a <- 7
b <- 8
(a == 7) & (b != 9)



#Tipos numéricos (inteiro e real)
num <- 2.5
num2 <- 4
x <- -123
class(x)

#Conversão de tipos Numeric
#as.integer = transforma um valor em numerico
#is.integer = verifica se o valor é inteiro
is.integer(num2)
is.numeric(num2)
y = as.integer(num2)
class(y)

x2<-3.14
y2 = as.integer(3.14)
y2
as.integer('4.27')
as.integer("Joe")
as.integer('Joe')
as.integer(TRUE)


#Caracteres
char1 <- "A"
is.character(char1)

#Números complexos
compl = 2.5 + 4i
compl
class(compl)

sqrt(1)
sqrt(-1+0i)
sqrt(as.complex(-1))


#Logico
x = 1
y = 2
z = x > y
class(z)


