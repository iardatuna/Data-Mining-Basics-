
#Ismail Arda Tuna
#240201031

#Libraries that are used

library(stringr)
library(ggplot2)
library(class)
library(Metrics)
library(caret)

#Normalize Data Function

normalizeData <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}

#Remove Outliers Function

omitOutliers <- function(allcols,a_col){
  quartiles <- quantile(a_col, probs=c(.25, .75), na.rm = FALSE)
  iqr <- IQR(a_col)
  upper_fence <-  quartiles[2]+1.5*iqr 
  lower_fence<- quartiles[1]-1.5*iqr 
  vector_without_outliers<- subset(allcols, a_col > (lower_fence) & a_col < (upper_fence))
  return (vector_without_outliers)  
}

#Read File

readFile <- read.csv("wdbc_edit.data",TRUE,",")
class(readFile)
str(readFile)
dim(readFile)
head(readFile)
column <- data.frame(readFile)
dataset <- column[3:32]

summary(column$radius_mean)
IQR(column$radius_mean)
#Which visualization techniques would be more appropriate for analyzing this data (breast cancer)?

#Box Plot

boxplot(dataset[,2], main = "Texture Mean With Outliers", xlab="Texture Mean", ylab="Values")

#Histogram Plot

hist(dataset[,5], main = "Smoothness Mean With Outliers", xlab="Smoothness Mean", ylab="Values")

# Scatter Plot 

plot(dataset[,25], main = "Smoothness Worst Mean With Outliers", ylab="Smoothness Worst Mean", xlab="Values")

#Outlier Examples with 3 Visualization Techniques

# Box Plot 1 

dataset_without_outliers <- omitOutliers(dataset,dataset[,1])
column_without_outliers <- dataset_without_outliers[,1]
boxplot(dataset[,1], main = "Radius Mean With Outliers", xlab="Radius Mean", ylab="Values")
boxplot(column_without_outliers,  main = "Radius Mean Without Outliers", xlab="Radius Mean", ylab="Values")

# Box Plot 2 

dataset_without_outliers <- omitOutliers(dataset,dataset[,4])
column_without_outliers <- dataset_without_outliers[,4]
boxplot(dataset[,4], main = "Area Mean With Outliers", xlab="Area Mean", ylab="Values")
boxplot(column_without_outliers,  main = "Area Mean Without Outliers", xlab="Area Mean", ylab="Values")

# Box Plot 3 

dataset_without_outliers <- omitOutliers(dataset,dataset[,7])
column_without_outliers <- dataset_without_outliers[,7]
boxplot(dataset[,7], main = "Concavity Mean With Outliers", xlab="Concavity Mean", ylab="Values")
boxplot(column_without_outliers,  main = "Concavity Mean Without Outliers", xlab="Concavity Mean", ylab="Values")

# Hist Plot 1

dataset_without_outliers <- omitOutliers(dataset,dataset[,10])
column_without_outliers <- dataset_without_outliers[,10]
hist(dataset[,10], main = "Fractal Dimension Mean With Outliers", xlab="Fractal Dimension", ylab="Values")
hist(column_without_outliers,  main = "Fractal Dimension Mean Without Outliers", xlab="Fractal Dimension", ylab="Values")

# Hist Plot 2

dataset_without_outliers <- omitOutliers(dataset,dataset[,13])
column_without_outliers <- dataset_without_outliers[,13]
hist(dataset[,13], main = "Perimeter Standart Error With Outliers", xlab="Perimeter Standart Error", ylab="Values")
hist(column_without_outliers,  main = "Perimeter Standart Error Without Outliers", xlab="Perimeter Standart Error", ylab="Values")

# Hist Plot 3

dataset_without_outliers <- omitOutliers(dataset,dataset[,16])
column_without_outliers <- dataset_without_outliers[,16]
hist(dataset[,16], main = "Compactness Standart Error With Outliers", xlab="Compactness Standart Error", ylab="Values")
hist(column_without_outliers,  main = "Compactness Standart Error Without Outliers", xlab="Compactness Standart Error", ylab="Values")

# Scatter Plot 1

dataset_without_outliers <- omitOutliers(dataset,dataset[,19])
column_without_outliers <- dataset_without_outliers[,19]
plot(dataset[,19], main = "Symmetry Standart Error With Outliers", ylab="Symmetry Standart Error", xlab="Values")
plot(column_without_outliers,  main = "Symmetry Standart Error Without Outliers", ylab="Symmetry Standart Error", xlab="Values")

# Scatter Plot 2

dataset_without_outliers <- omitOutliers(dataset,dataset[,22])
column_without_outliers <- dataset_without_outliers[,22]
plot(dataset[,22], main = "Texture Worst Mean With Outliers", ylab="Texture Worst Mean", xlab="Values")
plot(column_without_outliers,  main = "Texture Worst Mean Without Outliers", ylab="Texture Worst Mean", xlab="Values")

# Scatter Plot 3

dataset_without_outliers <- omitOutliers(dataset,dataset[,25])
column_without_outliers <- dataset_without_outliers[,25]
plot(dataset[,25], main = "Smoothness Worst Mean With Outliers", ylab="Smoothness Worst Mean", xlab="Values")
plot(column_without_outliers,  main = "Smoothness Worst Mean Without Outliers", ylab="Smoothness Worst Mean", xlab="Values")

#PART 4 #Pre-processing(Normalize Data)

x <- dataset
y <- column$diagnosis_malignant_benign
y_labels <- levels(y)
x_norm <- as.data.frame(lapply(x, normalizeData))

# Check the normalization

boxplot(x, main="Initial Data")
boxplot(x_norm, main="Normalized Data")


#PART 5 #Data Mining

# set the seed to make reproducible

set.seed(123)
train_ind <- sample(seq_len(nrow(x_norm)), size = floor(0.75 * nrow(x_norm)))
x_train = x_norm[train_ind,]
x_test = x_norm[-train_ind,]
y_train = y[train_ind]
y_test = y[-train_ind]

# Check data size

dim(x_train)
dim(x_test)

#KNN Part

data_pred <- knn(train = x_train, test = x_test, cl = y_train, k=5)
data_pred
accuracy(data_pred, y_test)

# Confusion matrix

table(data_pred, y_test)

# Confusion matrix with overall statistics

confusionMatrix(data_pred, y_test)

#PART 6(Language Comparison)
boxplot(dataset[,1], main = "Radius Mean With Outliers", xlab="Radius Mean", ylab="Values")














