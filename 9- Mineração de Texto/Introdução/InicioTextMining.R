# Text Mining
# https://www.youtube.com/watch?v=fga5gLtFQs0
# https://www.youtube.com/watch?v=lRTerj8fdY0

# https://rstudio-pubs-static.s3.amazonaws.com/265713_cbef910aee7642dc8b62996e38d2825d.html

# Exemplo 1
install.packages(c("tm", "SnowballC", "wordcloud", "RColorBrewer"))

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(plyr) 

# COMANDO PARA LIMPAR MEM�RIA
gc()

# LENDO OS TEXTOS

# RESPOSTAS: O QUE � CIENCIA DE DADOS?
data = "Analise de dados que visam tomadas de decis�o
Ci�ncia onde se estuda e analisa dados, seja ele estruturado ou n�o
Entendo que seja uma �rea ampla e que est� em constante evolu��o. � relacionada ao conceito de Big Data devido a grande quantidade de informa��es disponibilizadas. Com isso, surgiu a necessidade de desenvolver novos mecanismos, fazendo parte de um processo para extrair informa��es, analisar os dados, dar um feedback com intuito de disponibilizar dados de qualidade.
Analisar dados, a fim de explorar suas informa��es para tomadas de decis�o em diferentes n�veis
Extra��o, manipula��o e analise de dados.
Estudos dos dados, para obten��o de informa��es
Ci�ncia de dados � o estudo de uma ou mais bases de dados em busca de conhecimento oculto em tais dados, cujo objetivo � a descoberta de conhecimento a partir destes dados.
Ci�ncia de dados estuda a captura e analise de dados, de modo que possa ser usado para algum proveito.
� a �rea que estuda t�cnicas de processamento de dados afim de apoiar na tomadas de decis�o
Uma ci�ncia que estuda a manipula��o e armazenamento e dados para diversas aplica��es.
Ci�ncia que utiliza t�cnicas computacionais e estat�stica para obter conhecimento a respeito de dados de quaisquer tipos.
Acredito que seja o estudo de como melhor utilizar e organizar os dados da melhor forma
Estudo do armazenamento e manipula��o dos dados
um estudo sobre dados, informa��es
Ci�ncia de Dados entende-se pelo estudo da an�lise de dados, como eles se comportam e como deve ser a tomada de decis�o na manipula��o dos dados.
Realiza o estudo de forma a obter uma informa��o em um conjunto de dados
� uma ci�ncia que trata das formas de manipular os dados e obter conhecimento a partir deles.
�rea respons�vel por analisar e extrair informa��es de dados.
A ci�ncia que estuda dados e os transformam em informa��o
o estudo de dados, informa��o e conhecimento e como elesm podem ser usados para os fins procurados
Ci�ncia de Dados � a organiza��o e valoriza��o das informa��es presentes em um sistema de informa��o.
Estudo dos Dados"

# RESPOSTA: �REAS RELACIOANDAS A CI�NCIA DE DADOS
data = "Probabilidade, matem�tica, computa��o 
Big data, data mining, ia, aprendizado de maquina
Big Data, Aprendizagem de m�quina, Seguran�a da Informa��o, Minera��o de dados, Matem�tica
Big Data, BI, Machine Learning, Deep Learning
Minera��o, Redes, Sistemas Distribu�dos, Sistemas da informa��o, IA, dentre muitas outras.
Estat�stica, fun��es, ci�ncia e computa��o.
Banco de dados, desenvolvimento de software, programa��o, Inteligencia artificial.
Inteligencia artificial, Banco de dados, 
bancos de dados, minera��o de dados e inteligencia artificial
Intelig�ncia Artificial, Sistemas de informa��o
Intelig�ncia Artificial, Estat�stica, Minera��o de Dados, Machine Learning
minera��o de dados, deep learning
Big Data, Machine Learning
Mineira��o de dados, Aprendizado de m�quinas
Matem�tica
Estat�stica
Intelig�ncia Artificial
Minera��o de Dados
Processamento de Dados
minera��o de dados, sistemas de informa��o, banco de dados
Intelig�ncia Artificial, Programa��o, Minera��o de Dados
Banco de dados.
Minera��o de dados e aprendizado de maquina
eng. software, big data, ia, banco de dados
Intelig�ncia artificial, estat�stica, sistemas distribu�dos, banco de dados.
Banco de Dados, Minera��o de Dados."

dados = 'Analisar dados, e a partir dai tomar decis�es para melhorar um projeto por exemplo
O principio de Ci�ncia de dados, onde podemos aplicar e as t�cnicas utilizadas, e poder aplica-las na platica
Espero aproveitar o m�ximo da disciplina e aprender a transformar os dados em informa��es valiosas.
Espero me aprofundar bastante, e aprender o suficiente para aplicar tanto em aplica��es quanto no mercado de trabalho, uma vez que verifica-se a grande demanda dessa �rea em quest�o.
Aprender data Science com Python.
Modelagem e aprendizagem pr�tica
n�o sei dizer
N�o sei
t�cnicas de tratamento de dados e de extra��o de conhecimento
Como manipular e compreender os dados e suas aplica��es
Aprofundar e adquirir conhecimentos em dados, como big data e novos algoritmos de machine learning.
Como utilizar os algor�timos da maneira correta
Maneiras e t�cnicas de manipula��o de dados de forma com que nos traga resultados mais apurados do que os originais
Um pouco mais sobre ci�ncia de dados
Como a ci�ncia de dados pode impactar e impulsionar o mercado, gerando novas solu��es para os sistemas atuais.
Saber identificar uma informa��o nos dados
Espero aprender sobre histogramas para poder apresentar melhor os dados no meu trabalho de conclus�o de curso.
Implementar e trabalhar com algoritmos que ajudem na extra��o de informa��es.
Aprender a utilizar t�cnicas para analisar os dados e transforma-los em informa��o
o maximo sobre minera��o e agrupamento
Espero aprender o que � a Ci�ncia de Dados e de que forma ela pode ser �til na minha vida profissional.
Tenho pouco conhecimento, sendo assim n�o posso dizer o que esperar
Voc� j� pensou em trabalhar na �rea de Ci�ncia de Dados?'


#DIVIS�O DA STRING A PARTIR DA QUEBRA DE LINHA, EM UMA LISTA DE STRINGS
data = unlist(strsplit(data,'\n'))

#PR�-PROCESSAMENTO (REMO��O DE CARACTERES ESPECIAIS N�O UTF-8)
data <- gsub("[^[:alnum:][:blank:]?&/\\-]", "", data)
data <- gsub("U00..", "", data)
#PR�-PROCESSAMENTO (Transforma��o para min�sculo)
data = tolower(data)
#data = stemDocument(data)
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

#PR�-PROCESSAMENTO (Transforma��es para minimizar ru�dos)
data = gsub('mineiracao','mineracao',data)


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
findAssocs(dtm, terms = "dados", corlimit = 0.3)
head(tf, 10)

# Quais os termos mais correlacionados com o termo "ciencia"?
# Quais os termos mais correlacionados com o termo "analise"?
# Quais os termos mais correlacionados com o termo "decisao"?
# Quais os termos mais correlacionados com o termo "informacao"?





