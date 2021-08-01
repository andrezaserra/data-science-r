##Strings

#String
texto <- "Isso é uma string"
texto

x = as.character(3.14)
x
class(x)

#Concatenando Strings
nome = "Barack"
sobrenome = "Obama"
paste(nome,sobrenome)
cat(nome,sobrenome)

#Formatando a saída
sprintf("%s governa os EUA há %d anos",paste(nome,sobrenome),8)

#Extraindo parte da string
texto <- "Isso é uma string"
substr(texto,start=2,stop=17)

#Contando o número de caracteres
nchar(texto)
length(texto)

#Alterando a caixa alta/baixa
tolower("Histogramas e Elementos de Daods")
toupper("Histogramas e Elementos de Dados")

#Usando stringr
library(stringr)

#Dividindo uma string em caracteres
strsplit("Histogramas e Elementos de Dados",NULL)

#Dividindo uma string em caracteres, após o caracter espaço
strsplit("Histogramas e Elementos de Dados"," ")

#Trabalhando com strings
string1 <- c("Esta é a primeira parte da minha string e será a","Aqui a minha string continua, mas será transformada ")
string2 <- c("Precisamos testar outras strings - @???!$$","Análise de Dados em R")
string1
string1[2]
string2

#Concatenando 2 strings
str_c(c(string1,string2),sep="")

#Podemos contar quantas vezes um caracter aparece no texto
n <- str_count(string2,"s")
n
n[1]
n[2]

#Localiza a primeira e última posição em que o caracter aparece na string
l <- str_locate_all(string2,"s")
l
l[1][1]
l[1][2]

#Substitui a primeira ocorrência de um caracter
r <- str_replace(string2,"\\s","")
r
r[2]

#Substitui todas as ocorrências de um caracter
r <- str_replace_all(string2,"\\s","")
r
r[2]

#Detectando padrões nas strings
string1 <- "23 mai 2000"
string2 <- "1 mai 2000"
padrao <- "mai 20"
grepl(pattern = padrao,x = string1)
padrao <- "mai20"
grepl(pattern = padrao,x = string1)
?grepl

#Importando arquivo txt
#http://www.gutenberg.org/cache/epub/100/pg100.txt

arquivo <- read.csv("e:/Programas_Doutorado/TextMining_R/articles_txt/pubmed18324520.txt",sep="\n")
strsplit(arquivo,"\n")

#Função que retorna um número n de elemento da string s
str_tail <- function(s,n=1){
  if(n<0)
    substring(s,1-n)
  else
    substring(s,nchar(s)-n+1)
}

str_tail("String de teste",10)

