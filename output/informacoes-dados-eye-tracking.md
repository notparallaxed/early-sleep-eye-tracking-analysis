Informações sobre os dados de Eye-Tracking
================
Vinicius Teixeira
11/07/2021

*Última atualização: 07/11/2021*

## Obtenção

Os dados foram obtidos utilizando o(s) eye-tracker(s) xxxxx em conjunto
com a coleta de dados de fMRI. Foi indicado aos participantes para que
observassem o centro de uma cruz e deixassem o pensamento fluir
livremente. O registro foi realizado utilizando o software *Arrington
Research ViewPoint Eye-Tracking*.

|   Tipo    | Tempo total de captura | Taxa de amostragem |      Suavização      |
|:---------:|:----------------------:|:------------------:|:--------------------:|
| Monocular |     6 - 7 minutos      |       60 Hz        | Dados não suavizados |

## Formato

O registro foi realizado em **arquivos de texto simples (`.txt`)**, de
forma **retangular** (linha coluna), utilizando `tab` como espaçador.

-   Cada arquivo corresponde a um participante.
-   Cada linha corresponde a uma observação.
-   Cada coluna a uma variável de interesse.

**Entretanto o arquivo bruto não é retangular**, cada início de linha é
identificado com um código que se refere ao tipo de dado registrado.
Estes códigos são detalhados no [manual do
ViewPoint](https://drive.google.com/uc?id=1xldexfhVFQcIbdabKfb37GRuG9qezUWh)
&gt; Data Collection &gt; 9.3 Data File Format.

### Nomenclatura

Os arquivos estão identificados como:
`[ano-mês-dia]_[hora-minuto-segundo]RS[XXXX][T]`

Onde:

-   **XXXX:** 4 números referente a identificação do participante
-   **T:** Número de tentativas

### Exemplo de arquivo bruto

``` r
#Nome ou link do arquivo bruto
arquivo = here("data", "project_data_source", "selections", "2021-05-01", "Prelim", "2018-2-28_16-7-24RS21501.txt")

#Carrega o arquivo
raw_data <- readLines(arquivo)

# Imprime as primeiras 35 linhas 
cat(raw_data[1:35], sep = "\n")
```

    ## 3    Product Version: PC60
    ## 3    Executable File Version: 2.8.3,437 
    ## 3    Program Build Date: Oct 15 2007,  16:38:44
    ## 3    Customer Serial Number: 200-733-3-1
    ## 3    Customer Name:  Philips Medical Systems Ltda 
    ## 3    Customer Organization:  Brazil 
    ## 3    --------------------------------------------------------
    ## 3    TimeValues  2018    2   28  19  7   24  UTC
    ## 3    TimeStamp   quarta-feira, 28 de fevereiro de 2018, 16:07:24 
    ## 3    DataFormat  2.7.0.95
    ## 3    Storing UN-SMOOTHED data.
    ## 3    ScreenSize  800 600
    ## 3    ViewingDistance 500
    ## 3    ImageShape  Fit
    ## 3    --------------------------------------------------------
    ## 3     idName 
    ## 3     idTest 
    ## 3     idSession  
    ## 3     idNotes    
    ## 3    --------------------------------------------------------
    ## 6    ATT ADT ALX ALY ARI APW APA AQU AFX APX APY AGX AGY CNT
    ## 5    TotalTime   DeltaTime   X_Gaze  Y_Gaze  Region  PupilWidth  PupilAspect Quality Fixation     pXraw   pYraw   gXraw   gYraw  Count
    ## 7     0.000000   FrameRate   59.94
    ## 2     0.000000   +
    ## 16    0.000000   STARTUP.BMP
    ## 10     0.0000       0.0000   0.5616  0.4957  -1  0.0869  0.9858  1   0.0108  0.5145  0.4438  -1.0000 -1.0000 0
    ## 10     0.0239      23.8767   0.5438  0.5715  -1  0.0902  0.9207  1   0.0232  0.5148  0.4477  -1.0000 -1.0000 1
    ## 10     0.0334       9.4809   0.5667  0.4961  0   0.0883  0.9671  1   0.0094  0.5142  0.4438  -1.0000 -1.0000 2
    ## 10     0.0568      23.4068   0.5438  0.5715  0   0.0902  0.9207  1   0.0234  0.5148  0.4477  -1.0000 -1.0000 3
    ## 10     0.0667       9.9521   0.5600  0.5265  0   0.0896  0.9443  1   0.0100  0.5144  0.4453  -1.0000 -1.0000 4
    ## 10     0.0899      23.1975   0.5330  0.5725  0   0.0908  0.9181  1   0.0231  0.5153  0.4479  -1.0000 -1.0000 5
    ## 10     0.1001      10.1596   0.5490  0.5279  0   0.0894  0.9584  1   0.0101  0.5149  0.4454  -1.0000 -1.0000 6
    ## 10     0.1237      23.6310   0.5323  0.5483  0   0.0906  0.9398  1   0.0237  0.5156  0.4465  -1.0000 -1.0000 7
    ## 10     0.1334       9.7388   0.5560  0.4978  0   0.0879  0.9855  1   0.0098  0.5148  0.4439  -1.0000 -1.0000 8
    ## 10     0.1568      23.4050   0.5438  0.5715  0   0.0902  0.9207  1   0.0234  0.5148  0.4477  -1.0000 -1.0000 9

### Tipos de registros

O tipo de registro é indicado por um número inteiro ao início de cada
linha. Existem 7 tipos de registro:

| Nº Inteiro |                             Significado                             |
|:----------:|:-------------------------------------------------------------------:|
|     10     |                 Dado coletado, separado por colunas                 |
|     2      | Caractere marcador ASCII indicando o acontecimento de algum evento  |
|     12     |                 Texto ASCII indicando algum evento.                 |
|     3      |  Informações sobre o arquivo, como data, dia, modo de coleta, etc.  |
|     5      |  Informações de cabeçalho, indicando os nomes inteiros das colunas  |
|     6      | Informações de cabeçalho, indicando os nomes abreviados das colunas |
|     14     |                   Informações sobre head tracker.                   |

Outros tipos de registros podem ser inseridos, como é o caso do tipo nº
7, indicativo da taxa de quadros ao início de cada captura no exemplo
acima.

## Criação de um data frame

Para a criação do data frame somente com os dados retangulares coletados
é necessário remover as demais linhas que não correspondem ao *tipo 10*
(dado) e *tipo 5* (cabeçalhos).

> Será necessário utilizar a biblioteca do tidyverse

``` r
library(tidyverse)

# Função para carregar o arquivo de dados em data frame
cria_df_eyetracking <- function(nome_arquivo) {
  # Carregar aquivo bruto
  raw_data <- readLines(nome_arquivo)
  # Selecionar linhas que não correspondem ao tipo 10 e ao tipo 5
  a <- grep("(^3\t)|(^6\t)|(^7\t)|(^2\t)|(^16\t)|(^12\t)|(^14\t)", raw_data)
  # Apagar linhas do arquivo bruto
  cleaned_raw_data <- raw_data[-a]
  
  # Criar data frame
  raw_df <- read_tsv(cleaned_raw_data)
  df <- raw_df[,-1]  
  
  return(df) 
}

df_1 <- cria_df_eyetracking(arquivo)
print(df_1)
```

    ## # A tibble: 27,084 x 14
    ##    TotalTime DeltaTime X_Gaze Y_Gaze Region PupilWidth PupilAspect Quality
    ##        <dbl>     <dbl>  <dbl>  <dbl>  <dbl>      <dbl>       <dbl>   <dbl>
    ##  1    0           0     0.562  0.496     -1     0.0869       0.986       1
    ##  2    0.0239     23.9   0.544  0.572     -1     0.0902       0.921       1
    ##  3    0.0334      9.48  0.567  0.496      0     0.0883       0.967       1
    ##  4    0.0568     23.4   0.544  0.572      0     0.0902       0.921       1
    ##  5    0.0667      9.95  0.56   0.526      0     0.0896       0.944       1
    ##  6    0.0899     23.2   0.533  0.572      0     0.0908       0.918       1
    ##  7    0.100      10.2   0.549  0.528      0     0.0894       0.958       1
    ##  8    0.124      23.6   0.532  0.548      0     0.0906       0.940       1
    ##  9    0.133       9.74  0.556  0.498      0     0.0879       0.986       1
    ## 10    0.157      23.4   0.544  0.572      0     0.0902       0.921       1
    ## # … with 27,074 more rows, and 6 more variables: Fixation <dbl>, pXraw <dbl>,
    ## #   pYraw <dbl>, gXraw <dbl>, gYraw <dbl>, Count <dbl>

## Variáveis de eye-tracking

### `TotalTime`

-   Tipo: `float`

Corresponde ao valor total de tempo decorrido **em segundos**. A
contagem começa a partir do momento em que a captura é iniciada, dai em
diante o tempo é somado cumulativamente a cada nova entrada.

### `DeltaTime`

-   Tipo: `float`

Diferença de tempo em relação a última entrada **em milessegundos**
-&gt; dt = *t*<sub>*n*</sub> − *t*<sub>*n* − 1</sub>

### `X_Gaze`

-   Tipo: `float`

Direção do olhar normalizada em relação ao eixo x.

### `Y_Gaze`

-   Tipo: `float`

Direção do olhar normalizada em relação ao eixo y.

> Os valores X e Y de gaze correspondem a coordenadas referentes a
> direção. Por exemplo, (0.0, 0.0) representa a posição do olhar **no
> canto superior esquerdo**

### `Region`

-   Tipo: `list`

Qual região (ou regiões) de interesse o olhar do participante está
apontando.

### `PupilWidth`

-   Tipo: `float`

Largura da pupila normalizada em relação a largura da janela de captura.

### `PupilAspect`

-   Tipo: `float`

Valor adimensional referente ao aspect ratio pupilar. É portanto um
valor adimensional, no qual 1 representa que a pupila corresponde a um
círculo perfeito.

> Através do PupilAspect é possível determinar a ocorrência de piscadas.
> Conforme as pálpebras se fecham e ocludem a pupila, a altura e a
> largura da pupila identificadas pelo eye-tracker modificam-se
> alterando suas respectivas proporções.

### `Quality`

-   Tipo: `integer`

Representa a qualidade da entrada em valores de 0 a 5:

| Código |                                                                       Descrição                                                                       |
|:------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------:|
|   0    |                                O usuário selecionou o modo glint-pupil vector e ambos foram reconhecidos com sucesso.                                 |
|   1    |                                   O usuário selecionou somente o modo pupil e a pupila foi reconhecida com sucesso                                    |
|   2    | O usuário selecionou o modo glint-pupil vector e o glint não foi reconhecido com sucesso, utilizando somente o método pupilar para captura da entrada |
|   3    |                                      Independente do modo escolhido, a pupila excedeu os critérios estabelecidos                                      |
|   4    |                                  Independente do modo escolhido, a pupila não pode ser ajustada ao formato elíptico                                   |
|   5    |                                       Independente do modo escolhido, o limiar para escaneamento pupilar falhou                                       |

### `Fixation`

-   Tipo: `float`

Duração da fixação do olhar **em segundos.**

### `Count`

-   Tipo: `integer`

Contador do número de entradas, a cada nova entrada soma-se 1 ao valor
anterior.

## Mitigação de entradas inválidas

Há entradas que, por motivos desconhecidos, apresentam inconsistências
não ignoráveis.

### `TotalTime = 0` após primeira observação

`TotalTime` corresponde ao total de tempo passado desde a primeira
observação. Portanto, entradas que apresentam `TotalTime` zerado, com
exceção da primeira observação `(Count = 0`), devem ser consideradas
entradas inválidas e devem ser removidas do data frame.

``` r
# Remover TotalTime e DeltaTime zerados
remove_zerados <- function(x) {
  df_zerado = filter(x, TotalTime != 0 | Count == 0)
  return(df_zerado)
}

df_1_cleaned <- remove_zerados(df_1)
print(df_1)
```

    ## # A tibble: 27,084 x 14
    ##    TotalTime DeltaTime X_Gaze Y_Gaze Region PupilWidth PupilAspect Quality
    ##        <dbl>     <dbl>  <dbl>  <dbl>  <dbl>      <dbl>       <dbl>   <dbl>
    ##  1    0           0     0.562  0.496     -1     0.0869       0.986       1
    ##  2    0.0239     23.9   0.544  0.572     -1     0.0902       0.921       1
    ##  3    0.0334      9.48  0.567  0.496      0     0.0883       0.967       1
    ##  4    0.0568     23.4   0.544  0.572      0     0.0902       0.921       1
    ##  5    0.0667      9.95  0.56   0.526      0     0.0896       0.944       1
    ##  6    0.0899     23.2   0.533  0.572      0     0.0908       0.918       1
    ##  7    0.100      10.2   0.549  0.528      0     0.0894       0.958       1
    ##  8    0.124      23.6   0.532  0.548      0     0.0906       0.940       1
    ##  9    0.133       9.74  0.556  0.498      0     0.0879       0.986       1
    ## 10    0.157      23.4   0.544  0.572      0     0.0902       0.921       1
    ## # … with 27,074 more rows, and 6 more variables: Fixation <dbl>, pXraw <dbl>,
    ## #   pYraw <dbl>, gXraw <dbl>, gYraw <dbl>, Count <dbl>
