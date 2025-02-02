
# Como saber se h� ou n�o uma rela��o linear?

#Dataset Women
women
View(women)

#Fun��o para c�lculo de correla��o
cor(women, method = "pearson")


# Com gr�ficos, como Scatter Plots
pairs(women, col = 2, pch = 19)

#install.packages('psych')
library(psych)
pairs.panels(women)

hist(women$height)





#####################################################################################################
# An�lises com o DataSet Iris
data(iris)
pairs(iris, col = 2, pch = 19)
pairs(iris[,(c(3,4))], col = 2, pch = 19)

#An�lise de correla��o de Pearson 
cor(iris[,c(1:4)], method = "pearson")

library(corrplot)
corrplot(cor(iris[,c(1:4)], method = "pearson"))


pairs.panels(iris[1:4],bg=c("red","yellow","blue")[iris$Species],
             pch=21+as.numeric(iris$Species),main="Dataset Iris por esp�cie",hist.col="red") 

df_setosa = iris[c(1:50),]
df_virgnica = iris[c(51:100),]
df_versicolor = iris[c(101:150),]

pairs.panels(df_setosa[1:4]) 
pairs.panels(df_virgnica[1:4]) 
pairs.panels(df_versicolor[1:4]) 

# O que ocorreu?
# Qual a for�a e dire��o da correla��o?





