
# Como saber se há ou não uma relação linear, para definir qual tipo de correlação fazer?
# Com gráficos, como Scatter Plots
pairs(women, col = 2, pch = 19)
library(psych)
pairs.panels(women)

#Função para cálculo de correlação
cor(women, method = "pearson")



#################################################################################################
# Regressão linear

# Criar um modelo para height (variável dependente), utilizando weight
# Variável dependente = height
modelo = lm(height ~ weight, data = women)

# Considerando um modelo de regressão linear (y = a + bx) 
modelo$coefficients
summary(modelo)

# Qual o valor de a?
# Qual o valor de b?
# Como fica o modelo final?
# y = 25.72 + 0.28x


# Exemplo de predição
peso = 180
altura = modelo$coefficients[1] + modelo$coefficients[2] * peso
predict(modelo, data.frame(weight = c(160,180,200)))

# Gráfico de dispersão para verificar os pontos reais
plot(height ~ weight, data=women, col = 2, pch = 19)
# Linha de melhor ajuste do modelo definido
abline(modelo, col = 4)

# Utilizando a função predict, faça a predição da altura para alguns pesos já
# existentes no DataSet women. 
# Compare os resultados gerados pelo modelo, e o peso real do dataset? 
# Os valores são iguais?


# Resíduos do modelo (diferença entre os dados reais e a linha de melhor ajuste)
modelo$residuals
modelo$residuals

# Valores da reta de melhor ajuste do modelo (valores ajustados ou seja valores que serão previstos)
modelo$fitted.values

women$height

# A função pairs.panels possibilita extrair a significância
pairs.panels(women, stars=TRUE)



# Quais variáveis do dataset iris podem ser utilizados na criação de um modelo de regressão linear?
pairs.panels(iris[1:4],bg=c("red","yellow","blue")[iris$Species],
             pch=21+as.numeric(iris$Species),main="Dataset Iris por espécie",hist.col="red",stars=TRUE) 
summary(lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data = iris))
