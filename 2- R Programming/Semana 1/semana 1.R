## semana 1

y=2
y
x

c=x+y
c

z=1:20
z

n=c(1:10)
n


x = c(4, TRUE)
x

b = c(4, TRUE)
b

b = c('a', TRUE)
b

m= matrix(1:6, nrow = 2, ncol = 3)
m

e=1:10
e

cbind(m,e) ## dará erro pq as colunas e linhas são de tamanho diferente
rbind(m,e)


f = factor(c("yes", "no", "no", "yes", "yes", "no"))
f

f = factor(c("yes", "no", "no", "yes", "yes", "no"), levels = c("yes", "no"))
f


g= c("a", "b", "c", "c", "d", "a")
g[1]
g[2]

g[1:4]

g[g>"a"]
h=g>"a"
h
g[h]


i=Matrix::1:6, 2, 3 ## assim da erro
i=matrix(1:6, 2, 3)
i

i[1,2]
i[2,3]

i[1,]
i[,2]


o=c(1, 2, ,4, ,5)
bad=is .na(o)

p=c(1, 2,NA ,4,NA ,5)
k=c("a","b",NA,"d",NA,"f")
good=complete.cases(p,k)
 good
 
 p[good]
 k[good]

 -------------------------------------------------------------
 ## PROVA
   
Pergunta 4
 If I execute the expression x <- 4L in R, what is the class of the object `x' as determined by the `class()' function?
   
   j=4L
   class(j)
  
  [1] "integer"
 
 ---------------------------
Pergunta 5
What is the class of the object defined by x <- c(4, TRUE)?

j=c(4, TRUE)
j
[1] 4 1
 
 ----------------------------------

Pergunta 6
If I have two vectors x <- c(1,3, 5) and y <- c(3, 2, 10), what is produced by the expression rbind(x, y)?
 
x=c(1,3, 5)
y=c(3, 2, 10)
rbind(x, y)

 [,1] [,2] [,3]
x    1    3    5
y    3    2   10


--------------------------
Pergunta 8
Suppose I have a list defined as x <- list(2, "a", "b", TRUE). What does x[[1]] give me? Select all that apply.

x=list(2, "a", "b", TRUE)
x[[1]]

[1] 2


---------------
Pergunta 9
Suppose I have a vector x <- 1:4 and a vector y <- 2. What is produced by the expression x + y? 
 
x=1:4
y=2
x+y

[1] 3 4 5 6
 
 ------------
Pergunta 10
Suppose I have a vector x <- c(17, 14, 4, 5, 13, 12, 10) and I want to set all elements of this vector that are greater than 10 to be equal to 4. What R code achieves this? Select all that apply.
 
x= c(17, 14, 4, 5, 13, 12, 10)
y= x[x > 10]<-4
y

z= x[x>=11]<-4 # se usar o = da ceto, mas se colocar == da falso falso ....
z


--------------
Pergunta 11
Use the Week 1 Quiz Data Set to answer questions 11-20.
In the dataset provided for this Quiz, what are the column names of the dataset?

data <- read.csv("hw1_data.csv")

or

> library(readr)
> hw1_data <- read_csv("E:/Bibliotecas/Documentos/Data Science/Data Science - John Holpkins/Modulo 2- R Programming/Semana 1/hw1_data.csv")
Parsed with column specification:
cols(
  Ozone = col_double(),
  Solar.R = col_double(),
  Wind = col_double(),
  Temp = col_double(),
  Month = col_double(),
  Day = col_double()
)
> View(hw1_data)


----------------------------
Pergunta 12
Extract the first 2 rows of the data frame and print them to the console. What does the output look like?   

 data <- read.csv("hw1_data.csv")
 data[1:2, ]
 
  Ozone Solar.R Wind Temp Month Day
1    41     190  7.4   67     5   1
2    36     118  8.0   72     5   2
 

----------------------
Pergunta 13
How many observations (i.e. rows) are in this data frame?

nrow(data)

[1] 153

--------------
Pergunta 14
Extract the last 2 rows of the data frame and print them to the console. What does the output look like?

data[152:153, ]
 
     Ozone Solar.R Wind Temp Month Day
152    18     131  8.0   76     9  29
153    20     223 11.5   68     9  30


--------------- 
Pergunta 15
What is the value of Ozone in the 47th row?

data$Ozone[47]
[1] 21

or

data [47,]
 Ozone Solar.R Wind Temp Month Day
47    21     191 14.9   77     6  16


--------------------
Pergunta 16
How many missing values are in the Ozone column of this data frame?

is.na(data$Ozone)        # aqui lista todos 
sum(is.na(data$Ozone))   # aqui somo todos os valores vazios

[1] 37

-----------
Pergunta 17
What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.

mean(data$Ozone, na.rm=TRUE)

------------------

Pergunta 18
Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?
 
 mean(data[wich(data$Ozone>31 & data$Temp>90),]$Solar.R) 
 
 

-----------------------

Pergunta 19
What is the mean of "Temp" when "Month" is equal to 6?

 usei os [[]] para extrair o valor
 
# ver somente os valores de TEMP no mês 6- Achei o codigo olhando a planilha 
 View(s)   
 
 s[["6"]][["Temp"]]
 
 t=median(s[["6"]][["Temp"]])# aqui acha a mediana 
 
 t=mean(s[["6"]][["Temp"]])# aqui acha a média 
 t


 
 -------------------
Pergunta 20
What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?

 s=split(airquality, airquality$Month)
 str(s)
 summary(s)
 
 list(s)
summary(s)



