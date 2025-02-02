
# Como saber se h� ou n�o uma rela��o linear, para definir qual tipo de correla��o fazer?
# Com gr�ficos, como Scatter Plots
pairs(women, col = 2, pch = 19)
library(psych)
pairs.panels(women)

#Fun��o para c�lculo de correla��o
cor(women, method = "pearson")



#################################################################################################
# Regress�o linear

# Criar um modelo para height (vari�vel dependente), utilizando weight
# Vari�vel dependente = height
modelo = lm(height ~ weight, data = women)

# Considerando um modelo de regress�o linear (y = a + bx) 
modelo$coefficients
summary(modelo)

# Qual o valor de a?
# Qual o valor de b?
# Como fica o modelo final?
# y = 25.72 + 0.28x


# Exemplo de predi��o
peso = 180
altura = modelo$coefficients[1] + modelo$coefficients[2] * peso
predict(modelo, data.frame(weight = c(160,180,200)))

# Gr�fico de dispers�o para verificar os pontos reais
plot(height ~ weight, data=women, col = 2, pch = 19)
# Linha de melhor ajuste do modelo definido
abline(modelo, col = 4)

# Utilizando a fun��o predict, fa�a a predi��o da altura para alguns pesos j�
# existentes no DataSet women. 
# Compare os resultados gerados pelo modelo, e o peso real do dataset? 
# Os valores s�o iguais?


# Res�duos do modelo (diferen�a entre os dados reais e a linha de melhor ajuste)
modelo$residuals
modelo$residuals

# Valores da reta de melhor ajuste do modelo (valores ajustados ou seja valores que ser�o previstos)
modelo$fitted.values

women$height

# A fun��o pairs.panels possibilita extrair a signific�ncia
pairs.panels(women, stars=TRUE)



# Quais vari�veis do dataset iris podem ser utilizados na cria��o de um modelo de regress�o linear?
pairs.panels(iris[1:4],bg=c("red","yellow","blue")[iris$Species],
             pch=21+as.numeric(iris$Species),main="Dataset Iris por esp�cie",hist.col="red",stars=TRUE) 
summary(lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data = iris))
