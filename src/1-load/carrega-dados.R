Sys.setlocale("LC_ALL", 'pt_BR')
library("tidyverse")

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

# == Carrega dados grupo controle ==
filenames <- list.files(here::here("data/project_data_source/selections/2021-11-10/controle")
                        , full.names = TRUE)

# + cria lista de data-frames
ldf <- lapply(filenames, function(x) tryCatch(cria_df_eyetracking(x), warning = function(w) print(w) ))

# Filtragem dos nomes
names_wtxt <- sub("^.*?(RS)", "", filenames)
names(ldf) <- sub("..txt", "", names_wtxt)

# Encontra problemáticos
which(lengths(ldf) == 2)

# Salva dfs prontos para uso
dir.create(here::here("data/project_data_source/working/load/controle"),
           recursive = TRUE)

for (i in seq_along(ldf)) {
  print(names(ldf)[i])
  file_name <- paste("data/project_data_source/working/load/controle/", names(ldf)[i], ".tsv", sep = "")
  write_tsv(ldf[[i]], here::here(file_name))
}



