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


# WEB SCRAPING - BUSCANDO A P�GINA
setwd("C:/Users/Ramon/Documents/Ciencia_dos_Dados")
webpage <- read_html("teste.html")
webpage

# BUSCANDO DADOS DE INTERESSE
results <- webpage %>% html_nodes(".fullpost")

# RECUPERANDO TEXTOS PARA PR�-PROCESSAMENTO
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


#PR�-PROCESSAMENTO (REMO��O DE CARACTERES ESPECIAIS N�O UTF-8)
data <- gsub("[^[:alnum:][:blank:]?&/\\-]", "", data)
data <- gsub("U00..", "", data)
#PR�-PROCESSAMENTO (Transforma��o para min�sculo)
data = tolower(data)
#PR�-PROCESSAMENTO (Remo��o de n�meros)
data = removeNumbers(data)
#PR�-PROCESSAMENTO (Remo��o de pontua��o)
data = removePunctuation(data)
#PR�-PROCESSAMENTO (Remo��o de stopwords)
data = removeWords(data, stopwords('portuguese'))
#PR�-PROCESSAMENTO (Remo��o de espa�os em branco)
data = stripWhitespace(data)


#PR�-PROCESSAMENTO (transforma��es)
data = gsub('�','a',data)
data = gsub('�','c',data)
data = gsub('�','a',data)
data = gsub('�','e',data)
data = gsub('�','o',data)
data = gsub('\"','o',data)
data = gsub('�','a',data)
data = gsub('�','e',data)
data = gsub('�','o',data)
data = gsub('�','i',data)

#PR�-PROCESSAMENTO (Stemming)
data = stemDocument(data)


# Criando um Corpus
dfCorpus <- Corpus(VectorSource(data))


strwrap(dfCorpus[[1]])
dfCorpus[[2]]$content


# PREPARA��O DO BOW, POR MEIO DA Document Term Matrix - DTM
dtm = DocumentTermMatrix(dfCorpus)
as.matrix(dtm)

# EXTRA��O DE FREQU�NCIAS
termFreq <- colSums(as.matrix(dtm))
head(termFreq)

# CRIA��O DE DATAFRAME COM OS TERMOS MAIS FREQUENTES
tf <- data.frame(term = names(termFreq), freq = termFreq)
tf <- tf[order(-tf[,2]),]
head(tf)
tf[c(1:20),]

# GR�FICO DE BARRAS COM TERMOS MAIS FREQUENTES
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


# FUN��O PARA IDENTIFICA��O DE TERMOS FREQUENTES
findFreqTerms(dtm, lowfreq = 4)
# FUN��O PARA BUSCAR TERMOS CORRELACIONADOS
findAssocs(dtm, terms = "dado", corlimit = 0.3)
head(tf, 10)




