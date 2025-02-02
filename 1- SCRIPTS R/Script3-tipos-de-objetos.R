#Objetos em R

#Vetor: possui 1 dimens�o e 1 tipo de dado
vetor1 <- c(1:10)
vetor1
length(vetor1)
mode(vetor1)
class(vetor1)
typeof(vetor1)

#Matriz: possui 2 dimens�es e 1 tipo de dado
matriz1 <- matrix(1:12,nrow = 4)
matriz1
length(matriz1)
mode(matriz1)
class(matriz1)
typeof(matriz1)


#Array: possui 2 ou mais dimens�es e 1 tipo de dado
array1 <- array(1:5,dim = c(4,4,1))
array1
length(array1)
mode(array1)
class(array1)
typeof(array1)

#Data Frames: dados de diferentes tipos
#Maneira mais f�cil de explicar data frames: � uma matriz com diferentes tipos de dados
View(iris)
length(iris)
mode(iris)
class(iris)
typeof(iris)

#Listas: cole��o de diferentes objetos
#Diferentes tipos de dados s�o poss�veis e comuns
lista1 <- list(a=matriz1,b=vetor1)
lista1
length(lista1)
mode(lista1)
class(lista1)
typeof(lista1)


#Fun��es tamb�m s�o vistas como objetos em R
fun1 <- function(x){
  var1 <- x*x
  return(var1)
}
fun1(5)
class(fun1)

#Removendo objetos
objects()
rm(array1, fun1)
objects()

