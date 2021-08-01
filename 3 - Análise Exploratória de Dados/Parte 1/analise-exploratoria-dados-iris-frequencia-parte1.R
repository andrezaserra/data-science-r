library(dplyr)
library(data.table)

############################################################################################
#Importando dataset
setwd("C:/Users/Ramon/Documents/Manipulacao-e-transformacao-de-dados")
df_iris = read.table(file = 'iris.data', sep = ',', col.names = c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width','Species'))


str(df_iris)


#########################################################################################################
# FREQUÊNCIA DE DADOS UNIVARIADOS
## definindo o número de observações
n<-length(df_iris$Species)    
## frequência absoluta observações de uma espécie específica
sum(df_iris$Species=="Iris-setosa") 

## tabela de frequências absolutas
table(df_iris$Species) 

## tabela de frequências relativas
prop.table(table(df_iris$Species)) 
prop.table(table(df_iris$Species))*100

## gráfico de frequências absolutas
barplot(table(df_iris$Species)) 
## gráfico de frequências relativas (barras)
barplot(prop.table(table(df_iris$Species))*100, col=c("pink","lightblue","gray"))
title("Frequência relativa - Espécies",xlab="Espécie",ylab="%") 

## gráfico de frequências absolutas (pizza)
pie(table(df_iris$Species),labels=c("Setosa","Versicolor","Virginica"),col=c(gray(0.2),gray(0.5),gray(0.8)))
title("Espécies das plantas") 



