library(dplyr)
library(data.table)

############################################################################################
#Importando dataset
setwd("C:\Users\acbse\OneDrive\Documentos\AN�LISE DE DADOS COM R\2- Manipula��o e Transforma��o de Dados\dataset IRIS")
df_iris = read.table(file = 'iris.data', sep = ',', col.names = c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width','Species'))

df_iris

###########################################################################################
# Comandos iniciais para manipua��o do dataframe
df_iris$Species #mostra s� esp�cies
df_iris[,5] 
df_iris[1,4]
df_iris[c(1:10),4]
df_iris[c(1,10),4]

colnames(df_iris)
rownames(df_iris)



############################################################################################
# Primeiras an�lises

#Estrutura do data.frame
str(df_iris)

#Podem ser necess�rias transforma��es. Verifique sempre a class do atributo. 
#Para transforma��es utilize as.xxxxxx
df_iris$Sepal.Length = as.character(df_iris$Sepal.Length)
df_iris$Sepal.Length = as.numeric(df_iris$Sepal.Length)
#Cria��o de novas colunas
df_iris$Sepal_mean = (df_iris$Sepal.Length + df_iris$Sepal.Width) / 2

#Para verificar a classe da vari�vel
class(df_iris$Sepal.Length)
class(df_iris$Species)

#N�veis
levels(df_iris$Species)



################################################################################





