#Criando Variáveis

var1 = 367
var1
mode(var1)
help("mode")
sqrt(var1)


var2 = as.integer(var1)
var2
is.integer(var2)
mode(var2)
typeof(var2)


var3 = c("seg","ter","qua","qui")
var3
mode(var3)
typeof(var3)


var4 = function(x){x+3}
var4
mode(var4)
typeof(var4)
var4(3)

#Mudando o modo do dado
var5 = as.character(var1)
var5
mode(var5)
typeof(var5)

#Atribuir valores a objetos
x <- c(4,5,6)
x
c(4,5,6) -> y
y
assign("x",c(1.3,4,-2))
x[1]
y[2]

#Verificando objetos
ls()
ls()
objects()
length(ls())
length(objects())


#Remover objetos
rm(x)
x
