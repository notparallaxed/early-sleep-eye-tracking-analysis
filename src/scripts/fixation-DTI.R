library(tidyverse)

#' Calcula a dispersao de uma janela de n pontos. Isto é, verifica qual a maior
#' distancia entre todos os pontos presentes na janela. Este calculo é o mesmo
#' que a norma de um vetor dado pelos dois pontos mais distantes entre si.
#' 
#' @param window_pts Conjunto de pontos X e Y de uma janela.
#' @return D = (max[X] - min[X]) + (max[Y] - min[Y]) 

window_dispersion <- function(window_pts) {
  d_x <- max(window_pts[,1]) - min(window_pts[,1])
  d_y <- max(window_pts[,2]) - min(window_pts[,2])
  d_total <- d_x + d_y
}

#' Detecta fixações em um conjunto (x,y) de pontos de movimentação ocular utilizando 
#' um algoritmo de limiar de dispersão (I-DT) como previsto em (Salvucci, 2009)
#' 
#' @param xy_points Conjunto de observações de movimentação ocular (x,y).
#' @param dispersion_threshold Limiar de dispersão considerado para classificação da fixação.
#' @param temporal_threshold Limiar temporal considerado para classificação da fixação.
#' @param sample_rate Taxa de amostragem em hertz.
#' @return Conjunto de pontos com a duração das fixações, sendo 0 referente a um ponto 
#' no qual nenhuma fixação foi identificada

i_dt <- function (xy_points, 
                  dispersion_threshold, temporal_threshold, sample_rate){
  
  # Define o tamanho da amostra
  n <- nrow(xy_points)
  
  # Define a janela minima, encontrando a quantidade de pontos para aquele limiar temporal
  n_min_window <- temporal_threshold/1000 * sample_rate
  n_window = n_min_window # janela inicial corresponde a janela minima.
  
  # Guarda as fixacoes
  fixations <- tibble(pX=numeric(), pY=numeric(), duration=numeric())
  
  # Enquanto o próximo ponto for menor ou igual ao total de amostras
  while (nrow(xy_points) > n_window){
    window <- xy_points[1:n_window, ]
    
    # Calcula a dispersao da janela
    d_total <- window_dispersion(window)
    
    if (d_total < dispersion_threshold) {
      while(d_total < dispersion_threshold && n_window < nrow(xy_points)){
        n_window <- n_window + 1
        window = xy_points[1:n_window, ]
        
        d_total <- window_dispersion(window)
      }
      
      # Remove ultimo ponto que ultrapassou limiar de dispersão
      n_window <- n_window - 1
      window <- window[1:n_window, ]
      
      # Calcula ponto médio da fixação e duração
      duration <- round(n_window/sample_rate, 4)*(10**3) # em ms
      pX_mean <- round(mean(window[,1]))
      pY_mean <- round(mean(window[,2]))
      
      fixations <- add_row(fixations, pX=pX_mean, pY=pY_mean, duration=duration)
      
      xy_points <- xy_points[-(1:n_window), ]
      n_window <- n_min_window
    } else {
      xy_points <- xy_points[-1,]
    }
    
  }
  
  return(fixations)
}

# A janela se expande para um número mínimo de pontos, determinados pelo limiar
#temporal e pela taxa de amostragem.
#
# O algoritmo deve checar se a dispersão dos pontos na janela está acima ou abaixo do limiar
#
#se estiver acima do limiar, não deve considerar uma fixação e mover a janela 1 ponto para direita
#se estiver abaixo do limiar, é considerada uma fixação e neste caso a janela é expandida a direita até que a disperção esteja acima do limiar.
#Ao chegar ao fim da janela, a fixação é registrada no ponto central da janela (cálculo do centro de massa), contabilizando onset e duration

# O processo continua até o final de todos os pontos.


# O cáculo da dispersão pode ser considerando uma dispersão de 2 graus em relação a distância
# ou seja: 
