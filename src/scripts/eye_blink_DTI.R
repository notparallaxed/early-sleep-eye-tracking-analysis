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

#' Detecta piscadas ao avaliar a razao pupilar ao longo do tempo utilizando 
#' uma versão modificada do algoritmo de limiar de dispersão (I-DT) previsto em (Salvucci, 2009)
#' 
#' @param pa_points Conjunto de observações de pupil aspect.
#' @param iqr_threshold Limiar de dispersão em relação a mediana.
#' @param temporal_threshold Limiar temporal considerado para classificação da piscada.
#' @param sample_rate Taxa de amostragem em hertz.
#' @return Conjunto de pontos com a duração das piscadas

blink_dti <- function (pa_points, 
                  iqr_threshold, temporal_threshold, sample_rate){
  
  # Define o tamanho da amostra
  n <- nrow(pa_points)
  
  # Guarda as piscadas
  blinks <- tibble(timestamp=numeric(), duration=numeric())
  
  # Enquanto o próximo ponto for menor ou igual ao total de amostras
  while (nrow(pa_points) > 0){
    
    if (pa_points < iqr_threshold) {
      while(d_total < iqr_threshold && n_window < nrow(xy_points)){
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
