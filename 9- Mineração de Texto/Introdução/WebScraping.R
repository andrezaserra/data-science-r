library(tibble)
library(httr)
library(rvest)
library(dplyr)
library(ggplot2)
library(stringr)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

#https://www.freecodecamp.org/news/an-introduction-to-web-scraping-using-r-40284110c848/
#https://towardsdatascience.com/web-scraping-tutorial-in-r-5e71fd107f32


# WEB SCRAPING - BUSCANDO A PÁGINA
setwd("C:/Users/Ramon/Documents/Ciencia_dos_Dados")
webpage <- read_html("teste.html")
webpage

# BUSCANDO DADOS DE INTERESSE
results <- webpage %>% html_nodes(".fullpost")

# RECUPERANDO TEXTOS PARA PRÉ-PROCESSAMENTO
lst_posts = list()
c = 0
for(i in 2:length(results)){
  c = c + 1
  result <- results[i]
  post = result %>% html_nodes("p") %>% html_text(trim = TRUE)
  post = paste(unlist(strsplit(post,'\r')), collapse = ' ')
  post = paste(unlist(strsplit(post,'\n')), collapse = ' ')
  post = stripWhitespace(post)
  lst_posts[c] = post
  cat('\nContador    = ',post)
}
lst_posts = unlist(lst_posts)


data = lst_posts

#data = paste(lst_posts, collapse = ' ')


#PRÉ-PROCESSAMENTO (REMOÇÃO DE CARACTERES ESPECIAIS NÃO UTF-8)
data <- gsub("[^[:alnum:][:blank:]?&/\\-]", "", data)
data <- gsub("U00..", "", data)
#PRÉ-PROCESSAMENTO (Transformação para minúsculo)
data = tolower(data)
#PRÉ-PROCESSAMENTO (Remoção de números)
data = removeNumbers(data)
#PRÉ-PROCESSAMENTO (Remoção de pontuação)
data = removePunctuation(data)
#PRÉ-PROCESSAMENTO (Remoção de stopwords)
data = removeWords(data, stopwords('portuguese'))
#PRÉ-PROCESSAMENTO (Remoção de espaços em branco)
data = stripWhitespace(data)


#PRÉ-PROCESSAMENTO (transformações)
data = gsub('à','a',data)
data = gsub('ç','c',data)
data = gsub('ã','a',data)
data = gsub('ê','e',data)
data = gsub('õ','o',data)
data = gsub('\"','o',data)
data = gsub('á','a',data)
data = gsub('é','e',data)
data = gsub('ó','o',data)
data = gsub('í','i',data)

#PRÉ-PROCESSAMENTO (Stemming)
data = stemDocument(data)


# Criando um Corpus
dfCorpus <- Corpus(VectorSource(data))


strwrap(dfCorpus[[1]])
dfCorpus[[2]]$content


# PREPARAÇÃO DO BOW, POR MEIO DA Document Term Matrix - DTM
dtm = DocumentTermMatrix(dfCorpus)
as.matrix(dtm)

# EXTRAÇÃO DE FREQUÊNCIAS
termFreq <- colSums(as.matrix(dtm))
head(termFreq)

# CRIAÇÃO DE DATAFRAME COM OS TERMOS MAIS FREQUENTES
tf <- data.frame(term = names(termFreq), freq = termFreq)
tf <- tf[order(-tf[,2]),]
head(tf)
tf[c(1:20),]

# GRÁFICO DE BARRAS COM TERMOS MAIS FREQUENTES
barplot(tf[1:10,]$freq, names.arg = tf[1:10,]$term,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")
# NUVEM DE PALAVRAS (modelo 1)
par(mar = rep(2, 4))
wordcloud(words = tf$term, freq = tf$freq)
# NUVEM DE PALAVRAS (modelo 2)
set.seed(1234)
wordcloud(words = tf$term, freq = tf$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.005, 
          colors=brewer.pal(8, "Dark2"))


# FUNÇÃO PARA IDENTIFICAÇÃO DE TERMOS FREQUENTES
findFreqTerms(dtm, lowfreq = 4)
# FUNÇÃO PARA BUSCAR TERMOS CORRELACIONADOS
findAssocs(dtm, terms = "dado", corlimit = 0.3)
head(tf, 10)




