# MINERAÇÃO DE PADRÕES FREQUENTES 



#PACOTE ARULES
#install.packages('arules', dep=T)
library(arules)
library(datasets)

#Dataset com exemplos de transações de compras de produtos
data("Groceries")
image(Groceries)
#Inspecionando as primeiras 5 transações
inspect(Groceries[1:5])
#Visualizando os 10 produtos (itens) mais frequentes
itemFrequencyPlot(Groceries, topN=20, type='absolute')
#Sumário com informações estatísticas
summary(Groceries)
#O conjunto de dados Groceries possui 9835 transações, isso significa que durante o período de coleta 
#destes dados, este foi o total de compras feitas nesta loja. O número de colunas, 169, representa o total 
#de itens e o mais frequente deles, como já sabemos, é o leite. Note que a densidade dos itens 
#equivale a 0.026, esta é a dica para o nosso suporte.

#MINERAÇÃO DE REGRAS DE ASSOCIAÇÃO USANDO ALGORITMO APRIORI, SUPORTE 0.001 E MÍNIMO DE 2 ITENS
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.7, minlen=2))
#MINERAÇÃO DE ITENS FREQUENTES, SUPORTE 0.001 E MÍNIMO DE 2 ITENS
rules2 <- eclat(Groceries, parameter = list(supp = 0.001,  minlen=2))

#CSPADE É USADO PARA ITENS FREQUENTES SEQUENCIAIS
#rules3 <- cspade(Groceries, parameter = list(support = 0.001), control = list(verbose = TRUE))

#VERIFICAR SE HÁ REGRAS EM DUPLICIDADE
duplicated(rules2)
#BUSCANDO REGRAS REDUNDANTES
redundantes = is.redundant(rules)
which(is.redundant(rules))
#ELIMINANDO REGRAS REDUNDANTES
rules = rules[!redundantes]


#ESTATÍSTICAS DAS REGRAS GERADAS
summary(rules)
# 1 REGRA COM 2 ITEMSETS
# 137 REGRAS COM 3 ITEMSETS
# 761 REGRAS COM 4 ITEMSETS, etc.

#INSPEÇÃO DAS PRIEIRAS 5 REGRAS
options(digits=2)
inspect(sort(rules[1:5], by="confidence"))
#Quem compra vinho, tem 90% de chances de comprar cerveja
#E quem compra cerveja, compra o que? Analise os resultados
rules_beer <- apriori(data=Groceries, parameter=list(supp=0.001,conf = 0.1,minlen=2),appearance = list(default='rhs',lhs='bottled beer'), control = list(verbose=F))
inspect(sort(rules_beer, by='confidence', decreasing=T))

#VIZUALIZAÇÃO DE ASSOCIAÇÕES
#install.packages("arrulesViz", dependencies = TRUE)
library(aruleViz)



############################################################################################################
#SELECIONANDO UM ARQUIVO
file = file.choose()
load(file)
product_by_user
#TRANSFORMANDO A COLUNA $Product do DATAFRAME product_by_user EM TRANSACTIONS
trans = as(product_by_user $Product, "transactions")
trans


#Imagem das associações
image(trans)
#Visualizando os 20 produtos (itens) mais frequentes
itemFrequencyPlot(trans, topN=20, type='absolute')
#Sumário com informações estatísticas
summary(trans)

#MINERAÇÃO DE REGRAS DE ASSOCIAÇÃO USANDO ALGORITMO APRIORI, SUPORTE 0.001 E MÍNIMO DE 2 ITENS
rules <- apriori(trans, parameter = list(supp = 0.001, conf = 0.1, minlen=2))
#MINERAÇÃO DE ITENS FREQUENTES, SUPORTE 0.001 E MÍNIMO DE 2 ITENS
rules2 <- eclat(trans, parameter = list(supp = 0.001,  minlen=2))


#VERIFICAR SE HÁ REGRAS EM DUPLICIDADE
duplicated(rules)
#BUSCANDO REGRAS REDUNDANTES
redundantes = is.redundant(rules)
which(is.redundant(rules))
#ELIMINANDO REGRAS REDUNDANTES
rules = rules[!redundantes]

#ESTATÍSTICAS DAS REGRAS GERADAS
summary(rules)

#INSPEÇÃO DAS PRIEIRAS 5 REGRAS
options(digits=2)
inspect(sort(rules[1:5], by="confidence"))
inspect(rules2)
