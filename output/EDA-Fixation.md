EDA Fixation
================
Vinicius Teixeira
08/02/2022

*Última atualização: 31/03/2022*

# A fixação como um evento

A fixação pode ser entendida como um **momento no qual o olhar se fixa,
por um certo perído de tempo, em um ponto (x, y)**. Por ter inicio e fim
é considerada um evento, porém como determinar o momento exato da
fixação em um ponto em relação ao livre movimento ocular e/ou movimento
sacádico?

Há uma série de questões que impedem uma fixação “plena”do olhar. A
primeira delas correspondem ao aparelho oculomotor, que naturalmente tem
um *drift* de 1 grau mesmo quando está performando uma fixação. Em
segundo lugar, sempre irá existir um ruído de medição de equipamento,
gerando variabilidade da medição ao longo do tempo. Este ruído pode ser
proveniente do algoritmo de processamento de imagem da câmera, de
movimentações da cabeça ou de etapas de pré-processamento em baixo
nível. Portanto, registrar um ponto que mantenha uma coordenada x,y
constante ao longo por um determinado período de tempo é bastante
improvável.

# Detecção de fixações

Em ambos os cenários descritos acima, quando performamos uma fixação,
podemos dizer que dentro de um intervalo de confiança estaremos
atingindo um certo ponto x,y. Afirmando isso, temos não um ponto x,y mas
sim um **conjunto de potenciais pontos que estando próximos podem ser
considerados como uma fixação em um ponto médio x,y**.

Esta ideia é empregada nos **algoritmos de detecção por limiar de
dispersão (I-DT).** Estes algoritmos estipulam que adotemos um limiar
aceitável para que um ponto se distancia do conjunto de pontos,
geralmente de 2 graus. Assim, **todos os pontos que manténham uma
distância de no máximo 2 graus entre si podem ser considerados
fixações.**

Porém, qual seria o menor conjunto de pontos possível para que
verifiquemos suas distâncias? Outra característica das fixações é que,
devido ao tempo de resposta do aparelho oculomotor e devido a natureza
da fixação, **há um valor mínimo de duração esperado para o evento de
fixação.** Este valor costuma ser maior que 50 ms e menor que 800 ms. No
geral, a maior distribuição de fixações é encontrada entre 200 ms e 400
ms.

<img src="assets/Manor_and_Gordon_fixation_histogram.png" alt="Figure 2 from Defining the temporal threshold for ocular fixation in free-viewing visuocognitive tasks - Barry R. Manor and Evian Gordon." width="437"/>

A partir da

# 
