Sys.setlocale("LC_ALL", 'pt_BR')
library("tidyverse")

# Seleciona arquivos
filenames <- list.files(
      here::here("data", "project_data_source", "working", "load", "controle"),
      full.names = TRUE)

# Ajeita nomes
names(filenames) <- sub(".tsv", "", sub("^.*/", "", filenames))

# Abre data frames
participantes_raw <- lapply(filenames, read_tsv)

# Remover TotalTime zerados
remove_zerados <- function(x) {
  df_zerado = filter(x, TotalTime != 0 | Count == 0)
  return(df_zerado)
}

participantes <- lapply(participantes_raw, remove_zerados)

# Salva dfs prontos para uso
dir.create(here::here("data/project_data_source/working/cleaned/controle"),
           recursive = TRUE)

for (i in seq_along(participantes)) {
  print(names(participantes)[i])
  file_name <- paste("data/project_data_source/working/cleaned/controle/", 
                     names(participantes)[i], ".tsv", sep = "")
  write_tsv(participantes[[i]], here::here(file_name))
}
