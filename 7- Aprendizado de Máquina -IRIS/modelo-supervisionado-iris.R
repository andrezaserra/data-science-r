# Cria��o de um modelo de aprendizado de m�quina supervisionado a partir do dataset Iris

# INSTALA��O E CARREGAMENTO DO PACOTE caret
#install.packages("caret", dependencies=c("Depends", "Suggests"))
library(caret)


# RECUPERA��O DO DATASET IRIS
dataset <- iris


###################################################################################################


# SEPARA��O DO DATASET IRIS EM CONJUNTO DE TREINAMENTO E TESTES

# Cria��o de uma lista aleat�ria com os objetos do conjunto de treinamento (80% do total dos dados)
validation_index <- createDataPartition(dataset$Species, p=0.80, list=FALSE)

# Cria��o de um dataframe com o conjunto de testes, para valida��o do modelo (20% dos dado)
validation <- dataset[-validation_index,]

# Cria��o de um dataframe com o conjunto de dados para treinamento (80% dos dados)
dataset <- dataset[validation_index,]


###################################################################################################

# SUMARIZA��O E AN�LISE EXPLORAT�RIA DE DADOS
percentage <- prop.table(table(dataset$Species)) * 100
cbind(freq=table(dataset$Species), percentage=percentage)
summary(dataset)
str(dataset)

# divis�o entre atributos de entrada e atributo de sa�da
x <- dataset[,1:4]
y <- dataset[,5]

# Visua��o em boxplot para cada atributo
par(mfrow=c(1,4))
for(i in 1:4) {
  boxplot(x[,i], main=names(iris)[i])
}

# Matriz de dispers�o considerando atributos de entrada e sa�da
featurePlot(x=x, y=y, plot="ellipse")

# Boxplots considerando atributos de entrada e sa�da
featurePlot(x=x, y=y, plot="box")

# Plot de distribui��o, considerando atributos de entrada e sa�da
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)


###################################################################################################
# AVALIA��O DE DIFERENTES ALGORITMOS DE APRENDIZADO DE M�QUINA PARA DEFINI��O DE UM MODELO
# Uso de valida��o cruzada (cross validation), com k-fold = 10
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

# Treinamento e testes de algoritmos
# Algoritmos lineares
set.seed(7)
fit.lda <- train(Species~., data=dataset, method="lda", metric=metric, trControl=control)
# Algoritmos n�o lineares
set.seed(7)
fit.cart <- train(Species~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(Species~., data=dataset, method="knn", metric=metric, trControl=control)
# SVM
set.seed(7)
fit.svm <- train(Species~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(Species~., data=dataset, method="rf", metric=metric, trControl=control)

# Resumos das acur�cias dos modelos
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)

# Visualiza��o das acur�cias para compara��o
dotplot(results)

# Sumarizando o melhor modelo
print(fit.lda)

###################################################################################################
# FAZENDO PREDI��ES COM O CONJUNTO DE TESTE

# Testes usando matriz de confus�o
predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, validation$Species)





