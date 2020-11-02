---
title: "Practical Machine Learning Project - Quantified Self Movement Data Analysis"
output:
  pdf_document: default
  html_document:
    fig_height: 9
    fig_width: 9
---

## Introduction  
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it.  

In this project, we will use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants to predict the manner in which they did the exercise.  

## Data Preprocessing  
```{r, cache = T}
library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)
library(corrplot)
library(RColorBrewer)
library(rattle)
```

Load the data  
```{r, cache = T}
trainRaw <- read.csv("pml-training.csv")
testRaw <- read.csv("pml-testing.csv")
dim(trainRaw)
dim(testRaw)

```
The training data set contains 19622 observations and 160 variables, while the testing data set contains 20 observations and 160 variables. The "classe" variable in the training set is the outcome to predict. 

### Clean the data
In this step, we will clean the data and get rid of observations with missing values as well as some meaningless variables.
```{r, cache = T}
sum(complete.cases(trainRaw))
```
First, we remove columns that contain NA missing values.
```{r, cache = T}
trainRaw <- trainRaw[, colSums(is.na(trainRaw)) == 0] 
testRaw <- testRaw[, colSums(is.na(testRaw)) == 0] 
```  


Next, we get rid of some columns that do not contribute much to the accelerometer measurements.
```{r, cache = T}
classe <- trainRaw$classe
trainRemove <- grepl("^X|timestamp|window", names(trainRaw))
trainRaw <- trainRaw[, !trainRemove]
trainCleaned <- trainRaw[, sapply(trainRaw, is.numeric)]
trainCleaned$classe <- classe
testRemove <- grepl("^X|timestamp|window", names(testRaw))
testRaw <- testRaw[, !testRemove]
testCleaned <- testRaw[, sapply(testRaw, is.numeric)]
```
Now, the cleaned training data set contains 19622 observations and 53 variables, while the testing data set contains 20 observations and 53 variables. The "classe" variable is still in the cleaned training set.



### Slice the data
Then, we can split the cleaned training set into a pure training data set (70%) and a validation data set (30%). We will use the validation data set to conduct cross validation in future steps.  
```{r, cache = T}
set.seed(22519) 
inTrain <- createDataPartition(trainCleaned$classe, p=0.70, list=F)
trainData <- trainCleaned[inTrain, ]
testData <- trainCleaned[-inTrain, ]
```


## Correlation Analysis
A correlation among variables is analysed before proceeding to the modeling procedures.

```{r, cache = T}
corrPlot <- cor(trainData[, -length(names(trainData))])
corrplot(corrPlot, method="color",  tl.cex = 0.5)

corrplot(corrPlot, order = "FPC", method = "color", type = "lower", 
         tl.cex = 0.5, tl.col = rgb(0, 0, 0))

```


## Prediction Model Building

Three popular methods will be applied to model the regressions (in the Train dataset) and the best one (with higher accuracy when applied to the Test dataset) will be used for the quiz predictions. The methods are: Random Forests, Decision Tree and Generalized Boosted Model, as described below.

A Confusion Matrix is plotted at the end of each analysis to better visualize the accuracy of the models.

### 1. Random Forests

```{r, cache = T}
controlRf <- trainControl(method="cv", 5)
modelRf <- train(classe ~ ., data=trainData, method="rf", trControl=controlRf, ntree=250)
modelRf
```


Then, we estimate the performance of the model on the validation data set.  
```{r, cache = T}
predictRf <- predict(modelRf, testData)
confusionMatrix(table(testData$classe, predictRf))
```
Accuracy : 0.9937 

### 2. Decision Tree Visualization
```{r, cache = T}
treeModel <- rpart(classe ~ ., data=trainData, method="class")
prp(treeModel) # fast plot

set.seed(1813)
modFitDecTree <- rpart(classe ~ ., data=trainData, method="class")
fancyRpartPlot(modFitDecTree)

```



```{r}
predict_decision_tree <- predict(modFitDecTree, newdata = testData, type="class")
conf_matrix_decision_tree <- confusionMatrix (table(predict_decision_tree, testData$classe))
conf_matrix_decision_tree
```
Accuracy : 0.7584


### 3. Generalized Boosted Model (GBM)

```{r}

# One can also build a generalized boosted model and compare its accuracy
# to random forest model
set.seed(301)
modelBM <- train( classe ~.,
                  data = trainData,
                  method = "gbm",
                  trControl = trainControl(method="repeatedcv",number = 5,repeats = 1),
                  verbose = FALSE)
```


```{r}
predictGBM <- predict(modelBM, newdata=trainData)
confMatGBM <- confusionMatrix (table(predictGBM, trainData$classe))
confMatGBM
```
Accuracy : 0.9746 

We can investigate our generalized boosted model a bit further to see which variables have the highest relative influence
```{r}

print(summary(modelBM))
```
The above list shows the ranking of variables in our GBM. We see that roll_belt, pitch_forearm,and yaw_belt are the most performant ones. We can checkout a few plots demonstrating their power:

```{r}
qplot(pitch_forearm, roll_belt, data =trainData, col = classe)
qplot(pitch_forearm, yaw_belt, data =trainData, col = classe)
qplot(yaw_belt, roll_belt, data =trainData, col = classe)

```


```{r}
```



# Applying the Best Predictive Model to the Test Data

Random Forest Model: 99,37%
Generalized Boosted Model:97,46%
Decision Tree Model: 75,84 %

The Random Forest model is selected and applied to make predictions on the 20 data points from the original testing dataset (data_quiz)

```{r}
predictTEST <- predict(modelRf, newdata=testRaw)
predictTEST
```
  
