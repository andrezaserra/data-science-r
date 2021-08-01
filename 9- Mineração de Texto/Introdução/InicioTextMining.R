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

# COMANDO PARA LIMPAR MEMÓRIA
gc()

# LENDO OS TEXTOS

# RESPOSTAS: O QUE É CIENCIA DE DADOS?
data = "Analise de dados que visam tomadas de decisão
Ciência onde se estuda e analisa dados, seja ele estruturado ou não
Entendo que seja uma área ampla e que está em constante evolução. É relacionada ao conceito de Big Data devido a grande quantidade de informações disponibilizadas. Com isso, surgiu a necessidade de desenvolver novos mecanismos, fazendo parte de um processo para extrair informações, analisar os dados, dar um feedback com intuito de disponibilizar dados de qualidade.
Analisar dados, a fim de explorar suas informações para tomadas de decisão em diferentes níveis
Extração, manipulação e analise de dados.
Estudos dos dados, para obtenção de informações
Ciência de dados é o estudo de uma ou mais bases de dados em busca de conhecimento oculto em tais dados, cujo objetivo é a descoberta de conhecimento a partir destes dados.
Ciência de dados estuda a captura e analise de dados, de modo que possa ser usado para algum proveito.
É a área que estuda técnicas de processamento de dados afim de apoiar na tomadas de decisão
Uma ciência que estuda a manipulação e armazenamento e dados para diversas aplicações.
Ciência que utiliza técnicas computacionais e estatística para obter conhecimento a respeito de dados de quaisquer tipos.
Acredito que seja o estudo de como melhor utilizar e organizar os dados da melhor forma
Estudo do armazenamento e manipulação dos dados
um estudo sobre dados, informações
Ciência de Dados entende-se pelo estudo da análise de dados, como eles se comportam e como deve ser a tomada de decisão na manipulação dos dados.
Realiza o estudo de forma a obter uma informação em um conjunto de dados
É uma ciência que trata das formas de manipular os dados e obter conhecimento a partir deles.
Área responsável por analisar e extrair informações de dados.
A ciência que estuda dados e os transformam em informação
o estudo de dados, informação e conhecimento e como elesm podem ser usados para os fins procurados
Ciência de Dados é a organização e valorização das informações presentes em um sistema de informação.
Estudo dos Dados"

# RESPOSTA: ÁREAS RELACIOANDAS A CIÊNCIA DE DADOS
data = "Probabilidade, matemática, computação 
Big data, data mining, ia, aprendizado de maquina
Big Data, Aprendizagem de máquina, Segurança da Informação, Mineração de dados, Matemática
Big Data, BI, Machine Learning, Deep Learning
Mineração, Redes, Sistemas Distribuídos, Sistemas da informação, IA, dentre muitas outras.
Estatística, funções, ciência e computação.
Banco de dados, desenvolvimento de software, programação, Inteligencia artificial.
Inteligencia artificial, Banco de dados, 
bancos de dados, mineração de dados e inteligencia artificial
Inteligência Artificial, Sistemas de informação
Inteligência Artificial, Estatística, Mineração de Dados, Machine Learning
mineração de dados, deep learning
Big Data, Machine Learning
Mineiração de dados, Aprendizado de máquinas
Matemática
Estatística
Inteligência Artificial
Mineração de Dados
Processamento de Dados
mineração de dados, sistemas de informação, banco de dados
Inteligência Artificial, Programação, Mineração de Dados
Banco de dados.
Mineração de dados e aprendizado de maquina
eng. software, big data, ia, banco de dados
Inteligência artificial, estatística, sistemas distribuídos, banco de dados.
Banco de Dados, Mineração de Dados."

dados = 'Analisar dados, e a partir dai tomar decisões para melhorar um projeto por exemplo
O principio de Ciência de dados, onde podemos aplicar e as técnicas utilizadas, e poder aplica-las na platica
Espero aproveitar o máximo da disciplina e aprender a transformar os dados em informações valiosas.
Espero me aprofundar bastante, e aprender o suficiente para aplicar tanto em aplicações quanto no mercado de trabalho, uma vez que verifica-se a grande demanda dessa área em questão.
Aprender data Science com Python.
Modelagem e aprendizagem prática
não sei dizer
Não sei
técnicas de tratamento de dados e de extração de conhecimento
Como manipular e compreender os dados e suas aplicações
Aprofundar e adquirir conhecimentos em dados, como big data e novos algoritmos de machine learning.
Como utilizar os algorítimos da maneira correta
Maneiras e técnicas de manipulação de dados de forma com que nos traga resultados mais apurados do que os originais
Um pouco mais sobre ciência de dados
Como a ciência de dados pode impactar e impulsionar o mercado, gerando novas soluções para os sistemas atuais.
Saber identificar uma informação nos dados
Espero aprender sobre histogramas para poder apresentar melhor os dados no meu trabalho de conclusão de curso.
Implementar e trabalhar com algoritmos que ajudem na extração de informações.
Aprender a utilizar técnicas para analisar os dados e transforma-los em informação
o maximo sobre mineração e agrupamento
Espero aprender o que é a Ciência de Dados e de que forma ela pode ser útil na minha vida profissional.
Tenho pouco conhecimento, sendo assim não posso dizer o que esperar
Você já pensou em trabalhar na área de Ciência de Dados?'


#DIVISÃO DA STRING A PARTIR DA QUEBRA DE LINHA, EM UMA LISTA DE STRINGS
data = unlist(strsplit(data,'\n'))

#PRÉ-PROCESSAMENTO (REMOÇÃO DE CARACTERES ESPECIAIS NÃO UTF-8)
data <- gsub("[^[:alnum:][:blank:]?&/\\-]", "", data)
data <- gsub("U00..", "", data)
#PRÉ-PROCESSAMENTO (Transformação para minúsculo)
data = tolower(data)
#data = stemDocument(data)
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

#PRÉ-PROCESSAMENTO (Transformações para minimizar ruídos)
data = gsub('mineiracao','mineracao',data)


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
findAssocs(dtm, terms = "dados", corlimit = 0.3)
head(tf, 10)

# Quais os termos mais correlacionados com o termo "ciencia"?
# Quais os termos mais correlacionados com o termo "analise"?
# Quais os termos mais correlacionados com o termo "decisao"?
# Quais os termos mais correlacionados com o termo "informacao"?





