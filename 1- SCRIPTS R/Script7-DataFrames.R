#DataFrames

#Criando um dataframe vazio
df <- data.frame()
class(df)
df

#Criando vetores vazios
nomes <- character()
idades <- numeric()
datas <- as.Date(character())
codigos <- integer()
#Atribuindo os vetores no data.frame, como descritores dos campos
df <- data.frame(c(nomes, idades,datas, codigos))

#Criando vetores
pais = c("EUA","Dinamarca","Holanda","Espanha","Brasil","Brasil")
nome = c("Maurício","Ramon","Pedro","Aline","Marta","Janne")
altura = c(1.78,1.72,1.63,1.59,1.63,1.59)
codigo = c(5501,2183,4702,7965,8890,3110)

#Criando um dataframe de diversos vetores
pesquisa = data.frame(pais, nome,altura, codigo)
pesquisa

#Adicionando um novo vetor a um dataframe existente
olhos = c("verde","azul","azul","castanho","verde","castanho")
#tarefa comum na analise de dados. Após a limpeza de dados você une os dados dimensão por dimensão no dataframe
pesq = cbind(pesquisa,olhos)
pesq

#Informações sobre o dataframe
#Resumo do df
str(pesq)
#Número de dimensões
dim(pesq)
#Tamanho em linhas 
length(pesq)

#Obtendo um vetor de um data frame
pesq$pais
pesq$nome

#Extraindo um único valor
pesq[1,1]
pesq[3,2]

#Número de Linhas e Colunas
nrow(pesq)
ncol(pesq)

#Primeiros elementos do dataframe
head(pesq)
head(mtcars)


#Últimos elementos do dataframe
tail(pesq)
tail(mtcars)

#Data frames built in R
?mtcars
mtcars

#Fitro para um subdataset de dados que atendem a um critério
pesq[altura < 1.6,]
pesq[altura < 1.6, c('codigo','olhos')]
pesq








#Dataframes nomeados
names(pesq) <- c("Pais","Nome","Altura","Código","Olhos")
pesq

colnames(pesq) <- c("Var 1","Var 2","Var 3","Var 4", "Var 5")
rownames(pesq) <- c("Obs 1", "Obs 2","Obs 3","Obs 4","Obs 5","Obs 6")
pesq

colnames(pesq)

#Importando arquivos
#read.xls() - Excel
#read.mtp() - Minitab
#read.spss() - SPSS
#read.table() - arquivos txt
#read.csv() - Arquivos CSV
#read.delim() - Leitura de arquivos delimitados

?read.csv
df2 <- data.frame(read.csv("e:/Programas_Doutorado/TextMining_R/articles_txt/pubmed18324520.txt",header=TRUE,sep="\n"))
head(df2)
summary(df2)

plot(df2)

summary(mtcars$mpg)
plot(mtcars$mpg,mtcars$disp)
plot(mtcars$mpg,mtcars$wt)

#Combinando dataframes
#Os dataframes tem que ter a mesma estrutura, caso contrário alguns valores poderão ficar duplicados
df3 <- merge(pesq,df2)
df3



