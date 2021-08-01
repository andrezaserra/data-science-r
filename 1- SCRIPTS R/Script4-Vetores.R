#Vetor de caracteres
vetor_caracter = c("Olá","DSA")
vetor_caracter

#Vetor de floats
vetor_numerico = c(1.9,45.2,300.5)
vetor_numerico

#vetor com números complexos
vetor_complexo = c(5.2+3i,3.8 + 4i)
vetor_complexo

#vetor de valores lógicos
vetor_logico = c(TRUE,FALSE,TRUE,TRUE)
vetor_logico

#Utilizando a função seq()
vetor1 = seq(1:10)
vetor1
is.vector(vetor1)

#Utilizando a função rep()
vetor2 = rep(1:5)
vetor2

#Indexação de vetores
a <- c(1,2,3,4,5)
a[1]
a[2]

b <- c("Data","Sciense")
b[1]


#Combinando Vetores
v1 = c(2,3,5)
v2 = c("aa","bb","cc","dd","ee")
#Concatena os vetores, porém o tipo predominante será character
c(v1,v2)

#Operações com vetores
x = c(1,3,5,7)
y = c(2,4,6,8)

x*5
x+y
x-y
x*y
x/y


#Somando vetores com número diferente de elementos
alfa = c(10,20,30)
beta = c(1,2,3,4,5,6,7,8,9)
alfa+beta

#Vetor Nomeado
v = c("Barack","Obama","45")
v
names(v) = c("Nome","Sobrenome","")
v
v["Nome"]


