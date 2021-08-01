#Informações sobre a seção
sessionInfo()


#Graficos
plot(1:30)
hist(rnorm(100))

#Instalar pacotes
install.packages("randomForest")
install.packages("ggplot2")

#Carregar pacotes
library(ggplot2)
library(randomForest)

#Como solicitar ajuda
help("mean")
help.search("randomForest")
x = c(0:10,50,60)
mean(x)
sum(x)
max(x)
min(x)

example("matplot")
