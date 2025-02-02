# ------ Cria��o de um modelo de aprendizado de m�quina supervisionado ---------

install.packages("ellipse")

library(dplyr)
library(data.table)
library(caret)
library(readr)

#Importando dataset
caminho <- file.choose()    
df <- read.table(caminho, col.names = c('A','P','C','LK',
                                        'WK','AssC','LK_G','Var'))
# A = area
# P = perimeter
# C = compactness C = 4*pi*A/P^2,
# LK = length of kernel
# WK = width of kernel
# AssC = asymmetry coefficient
# LK_G = length of kernel groove
# Var = varieties of wheat (Kama, Rosa and Canadian)


#--------------------PREPARA��O DO DATASET-------------------------

#Separando o dataset em conj de treinamento e conj de testes

#lista aleat�ria com os objetos do conjunto de treinamento (80% do total dos dados)
validation_index <- createDataPartition(df$Var, p=0.80, list=FALSE)

# Cria��o de um dataframe com o conjunto de testes, para valida��o do modelo (20% dos dado)
validation <- df[-validation_index,]

# Cria��o de um dataframe com o conjunto de dados para treinamento (80% dos dados)
training <- df[validation_index,]


#--------SUMARIZA��O E AN�LISE EXPLORAT�RIA DOS DADOS DE TREINAMENTO----------

percentage <- prop.table(table(training$Var)) * 100
cbind(freq=table(training$Var), percentage=percentage)

str(training)
summary(training)

# divis�o entre atributos de entrada e atributo de sa�da
x <- training[,1:7]
y <- factor(training[,8])

# Visua��o em boxplot para cada atributo
par(mfrow=c(1,7))
for(i in 1:7) {
  boxplot(x[,i], main=names(x)[i])
}

# Matriz de dispers�o considerando atributos de entrada e sa�da
featurePlot(x=x, y=y, plot="ellipse")

# Boxplots considerando atributos de entrada e sa�da
featurePlot(x=x, y=y, plot="box")

# Plot de distribui��o, considerando atributos de entrada e sa�da
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)

#colocando a col var como factor
training$Var = factor(training$Var)

#-----------------APLICA��O DE DIFERENTES ALGORITMOS DE ML-------------------- 

# Uso de cross validation, com k-fold = 10
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

# --Treinamento e testes de algoritmos--

# Algoritmos lineares
set.seed(7)
fit.lda <- train(Var~., data=training, method="lda", 
                 metric=metric, trControl=control)

# Algoritmos n�o lineares
set.seed(7)
fit.cart <- train(Var~., data=training, method="rpart",
                  metric=metric, trControl=control)

# kNN
set.seed(7)
fit.knn <- train(Var~., data=training, method="knn", 
                 metric=metric, trControl=control)

# SVM
set.seed(7)
fit.svm <- train(Var~., data=training, method="svmRadial", 
                 metric=metric, trControl=control)

# Random Forest
set.seed(7)
fit.rf <- train(Var~., data=training, method="rf", 
                metric=metric, trControl=control)


#-------COMPARA��O ENTRE OS ALGORITMOS E  DEFINI��O DE UM MODELO-------- 

# Resumos das acur�cias dos modelos
results <- resamples(list(lda=fit.lda, cart=fit.cart, 
                          knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)

# Visualiza��o das acur�cias para compara��o
dotplot(results)

# Sumarizando o melhor modelo
print(fit.lda)

#----------------------FAZENDO PREDI��ES COM O CONJ DE TESTE-------------------------

#tranformando a coluna var do validation em factor
validation$Var = factor(validation$Var)

# Testes usando matriz de confus�o
predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, validation$Var)