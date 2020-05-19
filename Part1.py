#Ismail Arda Tuna
#240201031

import pandas as pd
import matplotlib.pyplot as plt

def unique_list(newlist):
    unique_list = []
    for i in newlist:
        if i not in unique_list:
            unique_list.append(i)
    return unique_list

# Exercise 1
    
dataset = pd.read_csv("AmazonSales.csv")
print(dataset)
print(dataset.info())
print(dataset.shape)
print(dataset.head(3))
print(dataset.tail(3))

# Exercise 2

prices = dataset.Price.tolist()
products = dataset.Product.tolist()
countries = dataset.Country.tolist()
payments = dataset.Payment_Type.tolist()
latitudes = dataset.Latitude.tolist()
longtitudes = dataset.Longitude.tolist()
prices = [price_edit.replace(",","") for price_edit in prices]
prices = [int(price) for price in prices]
products = [product_edit.replace(" ","") for product_edit in products]
unique_countries = unique_list(countries)
print("-----------------------------------------")
for l in range(len(unique_countries)):
    counter=0
    for m in range(len(countries)):
        if (unique_countries[l]== countries[m]):
            counter+=1
    print(unique_countries[l] + "   ----->   " + str(counter))       
print("-----------------------------------------")
print("There are " + str(len(unique_countries)) + " countries in data.")
print("")
print("-----------------------------------------")

# Exercise 3

unique_products = unique_list(products)
price_list = []
for i in range(len(unique_products)):
    summ=0
    for j in range(len(products)):
        if(products[j]==unique_products[i]):
            summ+=prices[j]
    price_list.append(summ)        
    print(unique_products[i] + "   ----->   " + str(price_list[i]))
print("")
print("-----------------------------------------")
print("Total sales amount is "+ str(sum(price_list)))

# Exercise 4
total=0    
for k in range(len(payments)):
    if(payments[k]=="Mastercard"):
        total+=prices[k]
print("")
print("-----------------------------------------")        
print("Total fee charged with Mastercard is " +str(total))        

# Exercise 5
print("")
print("-----------------------------------------")    
plt.scatter(products,prices)
plt.xlabel("Products")
plt.ylabel("Price")
plt.title("Price/Product Graph")
plt.show()
