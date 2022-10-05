library(tidyverse)

cria_df_eyetracking <- function(nome_arquivo) {
  # Carregar aquivo bruto
  raw_data <- readLines(nome_arquivo)
  # Selecionar linhas que não correspondem ao tipo 10 e ao tipo 5
  a <- grep("(^3\t)|(^6\t)|(^7\t)|(^2\t)|(^16\t)|(^12\t)|(^14\t)", raw_data)
  # Apagar linhas do arquivo bruto
  cleaned_raw_data <- raw_data[-a]
  
  # Criar data frame
  raw_df <- read_tsv(I(cleaned_raw_data))
  df <- raw_df[,-1]  
  
  return(df) 
}

# Carrega participantes controle com VAMS processado
filenames <- list.files(
  here::here("data", "project_data_source", "Coleta","Eye_Tracking","sujeitos_VAMS", "Controle", "Selecionados"), 
  full.names = TRUE)

# + cria lista de data-frames
ldf <- lapply(filenames, 
              function(x) tryCatch(cria_df_eyetracking(x), 
                                   warning = function(w) print(w) ))

# Filtragem dos nomes
names_wtxt <- sub("^.*?(RS)", "", filenames)
names(ldf) <- sub("..txt", "", names_wtxt)

# Salva dfs prontos para uso

for (i in seq_along(ldf)) {
  print(names(ldf)[i])
  file_name <- paste0(names(ldf)[i], ".tsv")
  write_tsv(ldf[[i]], here::here("data", "project_data_source", "Processados", "Eye_Tracking", "Controle", file_name))
}
