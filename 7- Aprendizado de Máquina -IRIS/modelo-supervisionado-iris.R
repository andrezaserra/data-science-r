# Criação de um modelo de aprendizado de máquina supervisionado a partir do dataset Iris

# INSTALAÇÃO E CARREGAMENTO DO PACOTE caret
#install.packages("caret", dependencies=c("Depends", "Suggests"))
library(caret)


# RECUPERAÇÃO DO DATASET IRIS
dataset <- iris


###################################################################################################


# SEPARAÇÃO DO DATASET IRIS EM CONJUNTO DE TREINAMENTO E TESTES

# Criação de uma lista aleatória com os objetos do conjunto de treinamento (80% do total dos dados)
validation_index <- createDataPartition(dataset$Species, p=0.80, list=FALSE)

# Criação de um dataframe com o conjunto de testes, para validação do modelo (20% dos dado)
validation <- dataset[-validation_index,]

# Criação de um dataframe com o conjunto de dados para treinamento (80% dos dados)
dataset <- dataset[validation_index,]


###################################################################################################

# SUMARIZAÇÃO E ANÁLISE EXPLORATÓRIA DE DADOS
percentage <- prop.table(table(dataset$Species)) * 100
cbind(freq=table(dataset$Species), percentage=percentage)
summary(dataset)
str(dataset)

# divisão entre atributos de entrada e atributo de saída
x <- dataset[,1:4]
y <- dataset[,5]

# Visuação em boxplot para cada atributo
par(mfrow=c(1,4))
for(i in 1:4) {
  boxplot(x[,i], main=names(iris)[i])
}

# Matriz de dispersão considerando atributos de entrada e saída
featurePlot(x=x, y=y, plot="ellipse")

# Boxplots considerando atributos de entrada e saída
featurePlot(x=x, y=y, plot="box")

# Plot de distribuição, considerando atributos de entrada e saída
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)


###################################################################################################
# AVALIAÇÃO DE DIFERENTES ALGORITMOS DE APRENDIZADO DE MÁQUINA PARA DEFINIÇÃO DE UM MODELO
# Uso de validação cruzada (cross validation), com k-fold = 10
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

# Treinamento e testes de algoritmos
# Algoritmos lineares
set.seed(7)
fit.lda <- train(Species~., data=dataset, method="lda", metric=metric, trControl=control)
# Algoritmos não lineares
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

# Resumos das acurácias dos modelos
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)

# Visualização das acurácias para comparação
dotplot(results)

# Sumarizando o melhor modelo
print(fit.lda)

###################################################################################################
# FAZENDO PREDIÇÕES COM O CONJUNTO DE TESTE

# Testes usando matriz de confusão
predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, validation$Species)





