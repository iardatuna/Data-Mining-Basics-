#Ismail Arda Tuna
#240201031
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split
from sklearn import neighbors
from sklearn.metrics import accuracy_score, confusion_matrix

#The function below is retrieved from 
#https://towardsdatascience.com/ways-to-detect-and-remove-the-outliers-404d16608dba

def omitOutliers (col):
    q1 = col.quantile(0.25)
    q3 = col.quantile(0.75)
    iqr = q3 - q1
    upper_fence = q3 + 1.5*iqr
    lower_fence = q1 - 1.5*iqr
    col_without_outlier = col[((~(col < lower_fence)) & (~(col > upper_fence)))]
    return col_without_outlier
        
read_file = pd.read_csv("wdbc_edit.data")
dataset = read_file[read_file.columns[2:32]]
target = read_file[read_file.columns[1]]
x = read_file[read_file.columns[2]].to_frame()


#Which visualization techniques would be more appropriate for analyzing this data (breast cancer)?

#Box Plot
print("-----------------------------------------------------------")
print("          Visualization Techniques Examples")
print("")
print("                    BOX PLOT")
print("                    --------")
plt.xlabel("Concavity Mean")
plt.ylabel("Value")
plt.title("Concavity Mean With Outliers")
plt.boxplot(dataset[dataset.columns[6]])
plt.show()
#Histogram Plot

print("")
print("                 HISTOGRAM PLOT")
print("                 --------------")
plt.xlabel("Area Mean")
plt.ylabel("Value")
plt.title("Area Mean With Outliers")
plt.hist(dataset[dataset.columns[3]])
plt.show()

# Scatter Plot

print("")
print("                 SCATTER PLOT") 
print("                 ------------")
plt.ylabel("Radius Mean")
plt.xlabel("Value")
plt.title("Radius Mean With Outliers")
plt.scatter(dataset[dataset.columns[0]].index,dataset[dataset.columns[0]])
plt.show()

#Outlier Examples with 3 Visualization Techniques

# Box Plot  
print("-----------------------------------------------------------")
print("          Outlier Handling Examples")
print("")
print("                    BOX PLOT")
print("                    --------")
plt.xlabel("Compactness Standart Error")
plt.ylabel("Value")
plt.title("Compactness Standart Error With Outliers")
plt.boxplot(dataset[dataset.columns[15]])
plt.show()

plt.xlabel("Compactness Standart Error")
plt.ylabel("Value")
plt.title("Compactness Standart Error Without Outliers")
plt.boxplot(omitOutliers(dataset[dataset.columns[15]]))
plt.show()

# Hist Plot 

print("")
print("                 HISTOGRAM PLOT")
print("                 --------------")
plt.xlabel("Perimeter Standart Error")
plt.ylabel("Value")
plt.title("Perimeter Standart Error With Outliers")
plt.hist(dataset[dataset.columns[12]])
plt.show()

plt.xlabel("Perimeter Standart Error")
plt.ylabel("Value")
plt.title("Perimeter Standart Error Without Outliers")
plt.hist(omitOutliers(dataset[dataset.columns[12]]))
plt.show()
# Scatter Plot 

print("")
print("                 SCATTER PLOT") 
print("                 ------------")
plt.ylabel("Symmetry Standart Error")
plt.xlabel("Value")
plt.title("Symmetry Standart Error With Outliers")
plt.scatter(dataset[dataset.columns[18]].index,dataset[dataset.columns[18]])
plt.show()

plt.ylabel("Symmetry Standart Error")
plt.xlabel("Value")
plt.title("Symmetry Standart Error Without Outliers")
plt.scatter(omitOutliers(dataset[dataset.columns[18]]).index,omitOutliers(dataset[dataset.columns[18]]))
plt.show()



##PART 4 #Pre-processing

x = dataset
y = target
print("")
print(y.head(4))
print("")
print(y.tail(4))

#(Normalize Data)

min_max_scaler = MinMaxScaler()
x_norm = min_max_scaler.fit_transform(x)

# Check the normalization 

print("")
plt.title("Initial Data")
plt.boxplot(x)
plt.show()
print("")
plt.title("Normalized Data")
plt.boxplot(x_norm)
plt.show()

#PART 5 #Data Mining

# set the random state to make reproducible

x_train,x_test,y_train,y_test=train_test_split(x, y, test_size = .25 , random_state = 123 )

# Check data size

print("")
print ("Train size" + " ------------>  " + str(x_train.shape))
print("")
print ("Test size" + "  ------------>  " + str(x_test.shape))

#KNN Part

classifier=neighbors.KNeighborsClassifier( n_neighbors = 5 )
classifier.fit(x_train,y_train)
data_pred = classifier.predict(x_test)

#Accuracy

print("")
print ("Accuracy" + "  ------------>  "+str(accuracy_score(y_test, data_pred)))

#Confusion Matrix

print("")
print("Confusion Matrix:")
print("")
print (confusion_matrix(y_test, data_pred))


#PART 6 (Language Comparison)

#Box Plot

box_sample = dataset[dataset.columns[0]]
plt.xlabel("Radius Mean")
plt.ylabel("Value")
plt.title("Radius Mean With Outliers")
plt.boxplot(box_sample)
plt.show()
