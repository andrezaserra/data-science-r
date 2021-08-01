#Listas

#Objetos poderosos, mas causam confusão por serem genericos
#Uses list() para criar listas

lista_caracter = list("A","Bem vindo","DSA")
lista_caracter
lista_caracter[1]
lista_caracter[1][1]
lista_caracter[1][1][1]

#Lista com números inteiros
lista_inteiros = list(2,3,4)
lista_inteiros

#Lista de floats
lista_floats = list(1.9,45.3,300,5)
lista_floats

#Lista de complexos
lista_complexos = list(5.2+3i,2.4+8i)
lista_complexos

#Lista de valores lógicos
lista_logicos = list(TRUE,FALSE,FALSE)
lista_logicos

#Listas compostas
lista_composta = list("A",3,TRUE)
lista_composta
lista1 <- list(1:10,c("Maria","João","Alfredo"),rnorm(10))
lista1

?rnorm

#Slicing da lista
lista1[1]
lista1[c(1,2)]
lista1[2]
lista1[[2]][1]
lista1[[2]][3]

#Para nomear os elementos - Listas Nomeadas
names(lista1) <- c("inteiros","caracteres","numéricos")
lista1
lista1["inteiros"]
lista1["caracteres"]

vec_num <- 1:4
vec_char <- c("A","B","C","D")

lista2 <- list(Numeros = vec_num, Letras = vec_char)
lista2
lista2["Letras"]
lista2[["Letras"]][1]

#Nomear os elementos diretamente
lista2 <- list(elemento1=3:5,elemento2=c(7.2,3.5))
lista2
lista2["elemento1"]
lista2[["elemento1"]][2]

#Trabalhando com elementos específicos da lista
names(lista1) <- c("inteiros","caracteres","numéricos")
lista1
lista1$caracteres
length(lista1$inteiros)
lista1$inteiros
#Podemos extrair um elemento específico dentro de cada nível da minha lista
lista1$caracteres[1]


#Verificar o comprimento da lista
length(lista1)

#A lista permite trabalhar com dados heterogêneos. 
#mode dos elementos da lista1
mode(lista1$numéricos)
mode(lista1$caracteres)

#Combinando 2 listas
lista3 <- c(lista1,lista2)
lista3

#Transformando um vetor em lista
v = c(1:3)
v
l = as.list(v)
l

#Unindo 2 elementos diferentes em ua lista
mat = matrix(1:4, nrow = 2)
mat
vec = c(1:9)
vec
lst = list(mat,vec)
lst
lst[[1]]
lst[[2]]
lst[[1]][1,2]
lst[[2]][3]