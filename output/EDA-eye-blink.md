EDA Eye-Blink
================
Vinicius Teixeira
10/11/2021

*Última atualização: 26/01/2022*

# O fenômeno da piscada

A piscada pode ser considerada como um **erro de registro** em diversas
variáveis, como na movimentação ocular, fixação e diâmetro pupilar. Este
erro tem um formato característico, semelhante a um pico destoante da
mediana do sinal no qual há falta de dados. Somente a variável referente
ao aspecto pupilar não registraria a piscada como um erro, uma vez que o
fenômeno da piscada implica necessáriamente numa mudança gradativa da
razão do aspecto pupilar (aspect ratio).

Essa mudança corresponde a mudança da proporção (aspect ratio) da
identificação da pupila como circulo perfeito. Durante uma piscada, as
pálpebras ocludem a pupila e portanto a pupila deixa de estar
representada como um círculo, passando a um formato elíptico, chegando a
nenhuma identificação (oclusão total) e voltando gradativamente ao
formato circular novamente. Esse evento é descrito nas páginas 54 e 58
do manual do Eye-Tracker ViewPoint, onde diz respectivamente:

> *Blinks can be detected by monitoring the pupil aspect ratio. This is
> a dimensionless value, where 1.0 indicates a perfect circle.*

> ***10.2.4 Blinks***
>
> *As the eye lid comes down during a blink, the elliptical fit to the
> pupil becomes increasingly flat before it disappears. This
> characteristic change in the aspect ratio of elliptical fit to the
> pupil can be used to detect blinks. **A blink is classified as the
> pupil aspect ratio crossing below the threshold.***

Este fenômeno também é explorado por Youngjun Cho, no artigo *Rethinking
Eye-blink: Assessing Task Difficulty through Physiological
Representation of Spontaneous Blinking* no qual é proposto a
identificação de piscadas através da análise da série temporal do
aspecto pupilar.

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/src/5-EDA/assets/rethinking-eye-blink-figure-2.jpg)

Neste artigo, a abordagem utilizada não estipula um limiar (threshold)
para determinar quais pontos são piscadas e quais não são, buscando uma
análise de frequência de toda série temporal. A análise é realizada
filtrando o sinal (média móvel de 1 segundo e filtro passa-banda na
frequência de 0.033Hz a 0.4167Hz). Estes valores foram escolhidos
visando uma frequência de piscada de 2 a 25 por minuto. Posteriormente,
foi criado um espectrograma calculando a potência de Lomb-Scargle e
empregado um algortimo de aprendizado de máquina a fim de classificar os
períodos de maior e menor frequência de piscadas.

## Hipóteses

-   Aspecto pupilar - `PupilAspect` - deve estar igual ou próximo a 1
    durante momentos de “não piscada”. Portanto, **boa parte da
    distribuição dos dados deve ter mediana próximo de 1.**

-   Um evento de piscada consiste na mudança do Aspecto pupilar de 1
    para 0. Portanto, devem exister pontos destoantes, próximos a zero,
    com uma certa frequência.

-   Essa mudança é gradativa, sendo possível notar o *onset* e o
    *offset* da piscada, tal como um vale. Logo, nem todos os pontos
    destoantes são piscadas, mas sim “parte” da piscada.

-   Demais variáveis devem apresentar perturbações, desviando
    bruscamente o registro da mediana do sinal –> Registros fora de
    mediana poderiam ser considerados piscadas ou ruídos (outliers).

# Visualização dos dados

## PupilAspect x TotalTime

Plotagem da série temporal da variável `PupilAspect` de todos os
participantes do grupo controle ao longo do tempo percorrido. Foi
considerado um gráfico de linha, uma vez que o dado é contínuo, sendo
aplicado uma função de suavização de tendência. A qualidade do dado é
classificada em uma escala de 0 a 5, sendo quanto menor o valor melhor.

``` r
pupAspXtime_all = vector(mode="list")

i = 1
for (participante in participantes) {
  pupAspXtime_all[[i]] <- ggplot(data = participante) +
    geom_path(mapping = aes(x = TotalTime, y = PupilAspect, colour = Quality)) +
    geom_smooth(mapping = aes(x = TotalTime, y = PupilAspect)) +
    ggtitle(names(participantes[i]))
  
  i <- i+1
}

pupAspXtime_all
```

    ## [[1]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-1.png)<!-- -->

    ## 
    ## [[2]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-2.png)<!-- -->

    ## 
    ## [[3]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-3.png)<!-- -->

    ## 
    ## [[4]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-4.png)<!-- -->

    ## 
    ## [[5]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-5.png)<!-- -->

    ## 
    ## [[6]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-6.png)<!-- -->

    ## 
    ## [[7]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-7.png)<!-- -->

    ## 
    ## [[8]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-8.png)<!-- -->

    ## 
    ## [[9]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-9.png)<!-- -->

    ## 
    ## [[10]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-10.png)<!-- -->

    ## 
    ## [[11]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-11.png)<!-- -->

    ## 
    ## [[12]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-12.png)<!-- -->

    ## 
    ## [[13]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-13.png)<!-- -->

    ## 
    ## [[14]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-14.png)<!-- -->

    ## 
    ## [[15]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-15.png)<!-- -->

    ## 
    ## [[16]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-16.png)<!-- -->

    ## 
    ## [[17]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-17.png)<!-- -->

    ## 
    ## [[18]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-18.png)<!-- -->

    ## 
    ## [[19]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-19.png)<!-- -->

    ## 
    ## [[20]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-20.png)<!-- -->

    ## 
    ## [[21]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-21.png)<!-- -->

    ## 
    ## [[22]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-22.png)<!-- -->

    ## 
    ## [[23]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-23.png)<!-- -->

    ## 
    ## [[24]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-24.png)<!-- -->

    ## 
    ## [[25]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-25.png)<!-- -->

    ## 
    ## [[26]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plots%20PupilAspect%20x%20TotalTime%20todos%20participantes-26.png)<!-- -->

## Distribuição do PupilAspect

Plotagem do histograma da variável `PupilAspect` de todos os
participantes. Marcação da **mediana** em azul, **Q1** e **Q3** em
amarelo e **limite máximo** e **mínimo** do **intervalo interquartil**
em vermelho.

O limite máximo e mínimo equivalem a 1,5 vezes o intervalo interquartil
(IQR).

``` r
pupAspHist = vector(mode = "list")  
  
i = 1
for (participante in participantes) {
  pupAspHist[[i]] <- ggplot(data = participante) +
    geom_histogram(mapping = aes(PupilAspect), binwidth = 0.005) +
    geom_vline(xintercept = median(participante$PupilAspect), linetype="dotted", color = "blue", size = 1) +
    geom_vline(xintercept = quantile(participante$PupilAspect, 1/4), linetype="dotted", color = "yellow", size = 1) +
    geom_vline(xintercept = quantile(participante$PupilAspect, 3/4), linetype="dotted", color = "yellow", size = 1) +
    geom_vline(xintercept = quantile(participante$PupilAspect, 1/4) - 1.5*IQR(participante$PupilAspect), linetype="dotted", color = "red", size = 1) +
    geom_vline(xintercept = quantile(participante$PupilAspect, 3/4) + 1.5*IQR(participante$PupilAspect), linetype="dotted", color = "red", size = 1) +
    ggtitle(names(participantes[i]))
  i <- i+1
}
 
pupAspHist
```

    ## [[1]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-1.png)<!-- -->

    ## 
    ## [[2]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-2.png)<!-- -->

    ## 
    ## [[3]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-3.png)<!-- -->

    ## 
    ## [[4]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-4.png)<!-- -->

    ## 
    ## [[5]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-5.png)<!-- -->

    ## 
    ## [[6]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-6.png)<!-- -->

    ## 
    ## [[7]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-7.png)<!-- -->

    ## 
    ## [[8]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-8.png)<!-- -->

    ## 
    ## [[9]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-9.png)<!-- -->

    ## 
    ## [[10]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-10.png)<!-- -->

    ## 
    ## [[11]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-11.png)<!-- -->

    ## 
    ## [[12]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-12.png)<!-- -->

    ## 
    ## [[13]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-13.png)<!-- -->

    ## 
    ## [[14]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-14.png)<!-- -->

    ## 
    ## [[15]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-15.png)<!-- -->

    ## 
    ## [[16]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-16.png)<!-- -->

    ## 
    ## [[17]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-17.png)<!-- -->

    ## 
    ## [[18]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-18.png)<!-- -->

    ## 
    ## [[19]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-19.png)<!-- -->

    ## 
    ## [[20]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-20.png)<!-- -->

    ## 
    ## [[21]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-21.png)<!-- -->

    ## 
    ## [[22]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-22.png)<!-- -->

    ## 
    ## [[23]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-23.png)<!-- -->

    ## 
    ## [[24]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-24.png)<!-- -->

    ## 
    ## [[25]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-25.png)<!-- -->

    ## 
    ## [[26]]

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Plotagem%20histogramas-26.png)<!-- -->

# Detecção de piscada

## Tentativa de Detecção por Intervalo Interquartil

**Objetivo:** Classificar como “piscada” todos os pontos que estão além
dos limites do intervalo interquartil.

Para esta tentativa serão considerados somente os limites inferiores,
uma vez que a natureza do evento reflete somente a diminuição do
`PupilAspect` para valores inferiores a 1 e, por consequência,
inferiores a massa da distribuição. A massa da distribuição reflete qual
aspecto pupilar o participante apresenta na maior parte do tempo.

### Teste em participante “ideal”

Foi escolhido o participante **2179**, por ter um baixo intervalo
interquartil e distribuição relativamente simétrica.

``` r
limite_inferior = quantile(participantes$`2179`$PupilAspect, 1/4) - 1.5*IQR(participantes$`2179`$PupilAspect)

out_points = participantes$`2179`$PupilAspect < limite_inferior

paste("Total de valor abaixo do limite inferior: ", 
      sum(out_points == TRUE))
```

    ## [1] "Total de valor abaixo do limite inferior:  831"

``` r
pupAspectXTime_out_graph <- ggplot(data = participantes$`2179`) +
    geom_path(mapping = aes(x = TotalTime, y = PupilAspect, colour = out_points)) +
    scale_color_manual(values = c("black", "red")) +
    geom_hline(yintercept = limite_inferior, linetype="dotted")+
    ggtitle("2179")
    
pupAspectXTime_out_graph
```

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Separacao%20de%20pontos%20por%20limite%20inferior%20interquartil-1.png)<!-- -->

Como resultado, **831 pontos foram classificados além do limite
inferior** sendo ou não potenciais piscadas. Considerando uma amostra de
450 segundos (7:30 minutos) onde todos estes pontos são piscadas,
**teríamos uma frequência de aproximadamente 110 piscadas por minuto**.
A critério de comparação, de acordo com a literatura, um indivíduo sem
privação de sono apresenta de 9 a 13 piscadas por minuto, enquanto um
individuo com privação de sono apresenta de 20 a 30 piscadas por minuto.

**Existem algumas questões a serem avaliadas:**

-   Nem todos os pontos destoantes são piscadas. Vários são pontos
    intermediários entre a oclusão total e a reabertura. Cabe entender
    como agregar esses pontos e contabilizá-los como uma piscada.

-   Há a possibilidade de que a mediana varie localmente e, portanto,
    varie o limiar de classificação. Para isso, podemos comparar
    recortes locais com o cálculo global de mediana e o cálculo local.
    Dependendo dos resultados, talvez adotar uma abordagem de
    classificação por mediana móvel possa ser uma opção.

#### Recorte de 1 minuto, utilizando cálculo global.

Recorte temporal de 1 minuto, utilizando o cálculo global da mediana e
interquartil (para toda amostra)

``` r
pupAspectXTime_out_graph <- ggplot(data =
    participantes$`2179`[participantes$`2179`$TotalTime < 60, ]) +
    geom_path(
      mapping = aes(x = TotalTime, y = PupilAspect, colour = out_points[1:3556])) +
    scale_color_manual(values = c("black", "red")) +
    geom_hline(yintercept = limite_inferior, linetype="dotted")+
    ggtitle("2179")

paste("Total de valor abaixo do limite inferior: ", 
      sum(out_points[1:3556] == TRUE))
```

    ## [1] "Total de valor abaixo do limite inferior:  182"

``` r
pupAspectXTime_out_graph
```

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Recorte%20de%201%20minuto-1.png)<!-- -->

Como resultado, 182 pontos foram identificados abaixo do limite
inferior. Caso todos estes pontos sejam de fato “piscadas” teremos 182
piscadas por minuto, bem distante do observado na literatura.

#### Recorte de 1 minuto, utilizando cálculo local

Neste teste, a mediana e os intervalos interquartis foram calculados
considerando somente os dados do recorte local.

``` r
participante_recorte = participantes$`2179`[participantes$`2179`$TotalTime < 60, ]

limite_inferior = quantile(participante_recorte$PupilAspect, 1/4) - 1.5*IQR(participante_recorte$PupilAspect)

out_points = participante_recorte$PupilAspect < limite_inferior

paste("Total de valor abaixo do limite inferior: ", 
      sum(out_points == TRUE))
```

    ## [1] "Total de valor abaixo do limite inferior:  160"

``` r
pupAspectXTime_out_graph <- ggplot(data = participante_recorte) +
    geom_path(mapping = aes(x = TotalTime, y = PupilAspect, colour = out_points)) +
    scale_color_manual(values = c("black", "red")) +
    geom_hline(yintercept = limite_inferior, linetype="dotted")+
    ggtitle("2179")
    
pupAspectXTime_out_graph
```

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Recorte%20de%20um%20minuto,%20calculo%20local-1.png)<!-- -->

Como resultado, foram identificados 160 pontos. Mesmo sendo um valor
mais próximo da literatura, continua sendo bem distoante.

## Identificação de onduleta

``` r
pupAspectXTime_out_graph <- ggplot(data =
    participantes$`2179`[participantes$`2179`$TotalTime < 2, ]) +
    geom_path(
      mapping = aes(x = TotalTime, y = PupilAspect, colour = out_points[1:119])) +
    scale_color_manual(values = c("black", "red")) +
    geom_hline(yintercept = limite_inferior, linetype="dotted")+
    ggtitle("2179")

paste("Total de valor abaixo do limite inferior: ", 
      sum(out_points[1:119] == TRUE))
```

    ## [1] "Total de valor abaixo do limite inferior:  10"

``` r
pupAspectXTime_out_graph
```

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->
