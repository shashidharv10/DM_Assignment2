data <- read.csv("serviceTrainData.csv") #to load the train dataset into the workspace

testdata <- read.csv("serviceTestData.csv") #to load the test dataset into the workspace

str(data) #to check if the data is structured or not

summary(data)  #obtains a five point summary of the data in the data dataframe

summary(testdata) #obtains a five point summary of the data in the testdata dataframe

table(data$Service) #get the number of values in each class 

#using caret library for generating the confusion matrix 

#normalizing the numeric data VI
normalize <- function(x) { return ((x - min(x)) / (max(x) - min(x))) }
data_n <- as.data.frame(lapply(data[,-6], normalize))
testdata_n <- as.data.frame(lapply(testdata[,-6], normalize))

#using the class library to get the knn algorithm for implementation
predictedknn <- knn(train=data_n[,-6],test=testdata_n[,-6],cl=data$Service,k=3)
summary(predictedknn)

#generate the confusion matrix
conf_matrix <- table(predictedknn,testdata[,6])
conf_matrix

#a measure of accuracy of the classifier
accuracy <- sum(diag(conf_matrix))/nrow(testdata)
accuracy

#using the R package
Conf_matrix <-confusionMatrix(data=predictedknn,testdata$Service)
Conf_matrix