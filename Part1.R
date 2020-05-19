
#Ismail Arda Tuna
#240201031

#Libraries that are used

library(stringr)
library(ggplot2)

#Exercise 1

readFile <- read.csv("AmazonSales.csv",TRUE,",")
class(readFile)
str(readFile)
dim(readFile)
head(readFile)

#Exercise 2 

columns <- data.frame(readFile)
getCountries <- as.data.frame(table(Country = columns$Country))
print(getCountries)
getUniqueCountries <- unique(columns$Country)
levels(getUniqueCountries) 
numOfCountries <- toString(nlevels(getUniqueCountries))
sprintf("There are %s countries in the data.",numOfCountries)

#Exercise 3

selectProductColumn <- columns$Product
getProducts <- (str_trim(selectProductColumn))
selectPriceColumn <- columns$Price
getTotalAmount <- as.numeric(gsub(",","",as.character(selectPriceColumn)))
aggregate(list(Amount = getTotalAmount), list(Products = getProducts), FUN=sum)
totalAmount <-sum(getTotalAmount)
sprintf("Total sales amount is %d.",totalAmount)

#Exercise 4 

selectPaymentTypeColumn <- columns$Payment_Type
selectMastercard <- columns[selectPaymentTypeColumn %in% "Mastercard",]$Payment_Type
selectMastercardPrice <- columns[selectPaymentTypeColumn %in% "Mastercard",]$Price
getMastercard <- as.character(selectMastercard)
getMastercardPrice <- as.numeric(gsub(",","",as.character(selectMastercardPrice)))
aggregate(list(Amount = getMastercardPrice), list(Payment_Type = getMastercard), FUN=sum)

#Exercise 5

x <- as.factor(getProducts)
y <- getTotalAmount
plot(x,y, pch=19, frame = TRUE, xlab = "Products", ylab = "Prices", main = "Price/Product Graph")
  
  
  


