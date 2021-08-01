#Matrizes

#Criando Matrizes

#Número de linhas
matrix(c(1,2,3,4,5,6), nr=2)
matrix(c(1,2,3,4,5,6), nr=3)
matrix(c(1,2,3,4,5,6), nr=6)

#Número de colunas
matrix(c(1,2,3,4,5,6), nc=2)

#help
?matrix

#Matrizes precisam ter um número para de valores
matrix(c(1,2,3,4,5), nc=2)

#Criando matrizes a partir de vetores e preenchendo a partir de linhas ou colunas
meus_dados = c(1:10)
#Preenchendo por linhas
matrix(data = meus_dados, nrow = 5, ncol = 2, byrow = T)
#Preenchendo por colunas
matrix(data = meus_dados, nrow = 5, ncol = 2, byrow = F)

#Fatiando a Matriz
mat <- matrix(c(2,3,4,5),nr = 2)
mat
mat[1,2]
mat[2,2]
mat[1,3]
#Imprimir coluna inteira
mat[,2]
#Imprimir linha inteira
mat[1,]

#Criando uma matriz diagonal
matriz = 1:3
diag(matriz)

#Extraindo vetor de uma matriz diagonal
vetor = diag(matriz)
diag(vetor)


#Transpose a matrix
w <- matrix(c(2,4,8,12), nr = 2, ncol = 2)
w
t(w)
u <- t(w)
u

#Obtendo uma matriz inversa
solve(w)

#Multiplicando matrizes
mat1 <- matrix(c(2,3,4,5), nr = 2)
mat1
mat2 <- matrix(c(6,7,8,9), nr = 2)
mat2
mat1 * mat2
mat1 / mat2
mat1 + mat2
mat1 - mat2

#Multiplicando matriz com vetor
x = c(1:4)
x
y <- matrix(c(2,3,4,5), nr = 2)
x * y

#Nomeando as dimensões de uma matriz
mat3 <- matrix(c('futebol','Natação','Campo','Piscina'), nr = 2)
mat3
dimnames(mat3) = (list(c("Linha1", "Linha2"), c("Coluna1", "Coluna2")))
mat3

#Identificando linhas e colunas no momento da criação da Matriz
matrix(c(4,6,8,9), nr = 2, nc = 2, dimnames = list(c("Linha 1", "Linha 2"), c("Coluna 1", "Coluna 2")))

#Combinando Matrizes
mat4 <- matrix(c(2,3,4,5), nr = 2)
mat4
mat5 <- matrix(c(6,7,8,9), nr = 2)
mat5
#Combinação por colunas
cbind(mat4,mat5)
#Combinação por linhas
rbind(mat4,mat5)

#Transformando a Matriz em vetor
c(mat4)
