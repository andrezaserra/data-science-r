library(tibble)
library(dplyr)
library(data.table)

############################################################################################
#Importando dataset
setwd("C:\Users\acbse\OneDrive\Documentos\ANÁLISE DE DADOS COM R\2- Manipulação e Transformação de Dados\dataset imdb")
imdb <- readr::read_rds("imdb.rds")


############################################################################################
# PACOTE dplyr
# filter() - filtra linhas
# select() - seleciona colunas
# arrange() - ordena a base
# mutate() - cria/modifica colunas
# group_by() - agrupa a base
# summarise() - sumariza a base

# O input é sempre uma tibble e o output é sempre um tibble.
# Colocamos o tibble no primeiro argumento e o que queremos fazer nos outros argumentos.
# A utilização é facilitada com o emprego do operador %>%.
# O pacote faz uso extensivo de NSE (non standard evaluation).

#############################################################################################
#Filtrando linhas do dataset / filter()
nota_acima_8 = imdb %>% filter(nota_imdb > 8)
nota_acima_8_ano_maior_2010 = imdb %>% filter(ano > 2010 & nota_imdb > 8)
imdb %>% filter(receita > orcamento | nota_imdb > 9)
imdb %>% filter(receita > orcamento)

# O operador %in% é muito útil na hora de criar filtros. O resultado das operações com %in% é um vetor 
# lógico do tamanho do vetor do elemento da esquerda, identificando quais elementos da esquerda batem 
# com algum elemento da direita.
imdb %>% filter(diretor %in% c("Steven Spielberg", "Quentin Tarantino"))

# Pode utilizar a função str_detect
library(stringr)
imdb %>% 
  filter(str_detect(generos, "Comedy"))


#################################################################################################
# Selecionando colunas do dataset / select()
imdb %>% 
  select(titulo, ano, orcamento)

imdb %>% 
  select(starts_with("ator"))

imdb %>% 
  select(titulo, ator_1:ator_3)

#Remover colunas
imdb %>% 
  select(-ano, - diretor, -cor)
imdb %>% 
  select(-starts_with("ator"))

################################################################################################
# Ordenando o dataset / arrange()
imdb %>% 
  arrange(orcamento) %>% 
  select(orcamento, everything())

imdb %>% 
  arrange(-orcamento) %>% 
  select(orcamento, everything())

imdb %>% 
  arrange(-ano, titulo) %>% 
  select(titulo, ano, everything())


################################################################################################
# mutate() - cria/modifica colunas
imdb %>% 
  mutate(duracao = duracao/60) %>% 
  select(duracao)
#Padronizar dados da coluna duracao
imdb %>% 
  mutate(duracao = scale(duracao, center = FALSE)) %>% 
  select(duracao)
#Normalizar dados da coluna duracao
imdb %>% 
  mutate(duracao = scale(duracao, center = TRUE)) %>% 
  select(duracao)
# Criando uma nova coluna
n_imdb = imdb %>% 
  mutate(duracao_horas = duracao/60) %>% 
  select(duracao, duracao_horas)

imdb %>% 
  mutate(
    lucro = receita - orcamento,
    resultado = ifelse(lucro < 0, "prejuizo", "lucro")
  ) %>% 
  select(lucro, resultado)
################################################################################################
# Agrupando e sumarizando o dataset
# group_by() - agrupa a base
# summarise() - sumariza a base

imdb %>% 
  summarise(media_orcamento = mean(orcamento, na.rm = TRUE),qtd = n())


imdb %>% 
  summarise(
    media_orcamento = mean(orcamento, na.rm = TRUE),
    mediana_orcamento = median(orcamento, na.rm = TRUE),
    qtd = n(),
    qtd_diretores = n_distinct(diretor)
  )

anos = imdb %>% 
  group_by(ano) %>% 
  summarise(qtd_filmes = n())

imdb %>% 
  group_by(diretor) %>% 
  summarise(orcamento_medio = mean(orcamento, na.rm = TRUE))


