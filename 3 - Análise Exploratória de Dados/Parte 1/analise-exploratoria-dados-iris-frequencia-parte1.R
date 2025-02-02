library(dplyr)
library(data.table)

############################################################################################
#Importando dataset
setwd("C:/Users/Ramon/Documents/Manipulacao-e-transformacao-de-dados")
df_iris = read.table(file = 'iris.data', sep = ',', col.names = c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width','Species'))


str(df_iris)


#########################################################################################################
# FREQU�NCIA DE DADOS UNIVARIADOS
## definindo o n�mero de observa��es
n<-length(df_iris$Species)    
## frequ�ncia absoluta observa��es de uma esp�cie espec�fica
sum(df_iris$Species=="Iris-setosa") 

## tabela de frequ�ncias absolutas
table(df_iris$Species) 

## tabela de frequ�ncias relativas
prop.table(table(df_iris$Species)) 
prop.table(table(df_iris$Species))*100

## gr�fico de frequ�ncias absolutas
barplot(table(df_iris$Species)) 
## gr�fico de frequ�ncias relativas (barras)
barplot(prop.table(table(df_iris$Species))*100, col=c("pink","lightblue","gray"))
title("Frequ�ncia relativa - Esp�cies",xlab="Esp�cie",ylab="%") 

## gr�fico de frequ�ncias absolutas (pizza)
pie(table(df_iris$Species),labels=c("Setosa","Versicolor","Virginica"),col=c(gray(0.2),gray(0.5),gray(0.8)))
title("Esp�cies das plantas") 



