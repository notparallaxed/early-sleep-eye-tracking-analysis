EDA Eye-Blink
================
Vinicius Teixeira
10/11/2021

# O fenômeno da piscada

A piscada pode ser considerada como um **erro de registro** em diversas
variáveis, como movimentação ocular, fixação, diametro pupilar, etc.
Este erro tem um formato característico, semelhante a um pico destoante
da mediana do sinal no qual há falta de dados. Somente a variável
referente ao aspecto pupilar não registraria a piscada como um erro, uma
vez que o fenômeno da piscada implica necessáriamente numa mudança da
razão do aspecto pupilar (aspect ratio).

Essa mudança corresponde a mudança da proporção (aspect ratio) da
identificação da pupila como circulo perfeito. Durante uma piscada, as
pálpebras ocludem a pupila e portanto a pupila deixa de estar
representada como um círculo, passando a um formato elíptico, chegando a
nenhuma identificação (oclusão total), voltando ao formato circular.

## Hipóteses

-   Aspecto pupilar - `PupilAspect` - deve estar igual ou próximo a 1
    durante momentos de “não piscada”.

-   Um evento de piscada consiste na mudança do Aspecto pupilar de 1
    para 0.

-   Essa mudança é gradativa, sendo possível notar o *onset* e o
    *offset* da piscada, tal como um vale.

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
uma vez que a natureza do evento “piscada” reflete somente na diminuição
do `PupilAspect` para valores inferiores a 1 e, por consequência,
inferiores a massa da distribuição. A massa da distribuição reflete qual
aspecto pupilar o participante apresenta na maior parte do tempo.

### Teste em participante “ideal”

Será escolhido o participante **2179**, por ter menor intervalo
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

#### Recorte de 1 minuto, utilizando cálculo generalizado

Janela temporal de 1 minuto, utilizando calculo para toda amostra

``` r
pupAspectXTime_out_graph <- ggplot(data =
    participantes$`2179`[participantes$`2179`$TotalTime < 60, ]) +
    geom_path(
      mapping = aes(x = TotalTime, y = PupilAspect, colour = out_points[1:3556])) +
    scale_color_manual(values = c("black", "red")) +
    geom_hline(yintercept = limite_inferior, linetype="dotted")+
    ggtitle("2179")
    
pupAspectXTime_out_graph
```

![](/home/notparallaxed/UFABC/Projetos/IC-Sono-fMRI-eye-tracking/Analise/early-sleep-eye-tracking-analysis/output/EDA-eye-blink_files/figure-gfm/Recorte%20de%201%20minuto-1.png)<!-- -->

#### Recorte de 1 minuto, utilizando cálculo local

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
