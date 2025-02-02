library(dplyr)
library(data.table)

############################################################################################
#Importando dataset
setwd("C:\Users\acbse\OneDrive\Documentos\AN�LISE DE DADOS COM R\2- Manipula��o e Transforma��o de Dados\dataset IRIS")
df_iris = read.table(file = 'iris.data', sep = ',', col.names = c('Sepal.Length','Sepal.Width','Petal.Length','Petal.Width','Species'))
 
df_iris

str(df_iris)


###########################################################################################
# summary - Sumariza��o do dataset (m�dia, mediana, quartis, valor m�nimo, valor m�ximo)
summary(df_iris)
# Pode se calcular quantis em diferentes porcentagens - Quantis s�o como cestas
quantile(df_iris$Sepal.Length,c(0,0.25,0.5,0.75,1))
quantile(df_iris$Sepal.Length,c(0.2,0.4,0.6))
# moda - A moda � aplicada a dados qualitativos e quantitativos
table(df_iris$Species)
table(df_iris$Sepal.Length)
moda<-function(x){
  names(which.max(table(x)))
}
moda(df_iris$Petal.Length)




###########################################################################################
# Visualiza��o das distribui��es Dados univariados - BOXPLOT
boxplot(df_iris$Sepal.Width)
boxplot(df_iris$Sepal.Width, pars = list(boxwex = 0.3, staplewex = 0.9, outwex = 0.1), horizontal = FALSE)

#H� outliers?

###########################################################################################
# Visualiza��o das distribui��es Dados Univariados - Histograma
hist(df_iris$Sepal.Width)
hist(df_iris$Sepal.Length)
hist(df_iris$Petal.Length)
hist(df_iris$Petal.Width)

######################################################################
# Stripcharts
par(mfrow=c(1,2))
stripchart(df_iris$Petal.Length,method="jitter",pch=16,xlab="Petal.length")
stripchart(df_iris$Petal.Width,method="jitter",pch=16,xlab="Petal.Width")

######################################################################
# Gr�fico de densidade
plot(density(df_iris$Petal.Length),xlab="Petal.Length",ylab="tam",main="Gr�fico de densidade - Petal.Length")
plot(density(df_iris$Petal.Width),xlab="Petal.Width",ylab="tam",main="Gr�fico de densidade - Petal.Width")


###########################################################################################
# Visualiza��o das distribui��es dados univariados - pie e table
table(df_iris$Sepal.Width)
table(df_iris$Species)

pie(table(df_iris$Sepal.Width))
pie(table(df_iris$Species))






###########################################################################################
# Visualiza��o das distribui��es dados multivariados - scatter plot

#Scatter plot total
plot(df_iris[,c(1:4)], col = df_iris[,5])
#pairs(df_iris[,c(1:4)], col = df_iris[,5])

#Scatter plot individual
plot(df_iris$Sepal.Length, df_iris$Sepal.Width, main="Scatterplot Example",
     xlab="Sepal.Length ", ylab="Sepal.Width", pch=19, col = df_iris$Species) 

plot(df_iris$Petal.Length, df_iris$Petal.Width, main="Scatterplot Example",
     xlab="Petal.Length ", ylab="Petal.Width", pch=19, col = df_iris$Species) 


#Scatter plot individual, com regress�o linear
plot(df_iris$Sepal.Length, df_iris$Sepal.Width, main="Scatterplot Example",
     xlab="Sepal.Length ", ylab="Sepal.Width", pch=19, col = df_iris$Species) 
abline(lm(df_iris$Sepal.Width~df_iris$Sepal.Length), col="blue") # regression line (y~x)


plot(df_iris$Petal.Length, df_iris$Petal.Width, main="Scatterplot Example",
     xlab="Petal.Length ", ylab="Petal.Width", pch=19, col = df_iris$Species) 
abline(lm(df_iris$Petal.Width~df_iris$Petal.Length), col="blue") # regression line (y~x)


plot(df_iris$Petal.Length, df_iris$Petal.Width, main="Scatterplot Example",
     xlab="Petal.Length ", ylab="Petal.Width", pch=19, col = df_iris$Species) 
abline(lm(df_iris$Petal.Width~df_iris$Petal.Length), col="blue") # regression line (y~x)



