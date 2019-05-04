#initializing the libraries
library(caret)
library(class)

#importing the training dataset
service_train<-read.csv("serviceTrainData.csv",row.names = NULL)

#importing the test dataset
service_test<-read.csv("serviceTestData.csv",row.names = NULL)

#examining the structure of the dataset
str(service_test)
str(service_train)

#obtatining the five point summary of the dataset
summary(service_test)
summary(service_train)

#initializing the parameters of the logistic regression function
lr<-glm(formula = service_train$Service~.,family = 'binomial',data = service_train)

#the model itself
lr

#the five point summary of the model
summary(lr)

#plotting the prediction using the model
lr_train<-predict(lr,type = 'response')
plot(lr_train)
lr_test<-predict(lr,newdata=service_test,type = 'response')
plot(lr_test)

#fine tuning of the parameters
service_test[lr_test<=0.4,"lr_test"]<-"No"
service_test[lr_test>0.4,"lr_test"]<-"Yes"

#the confusion matrix
confusionMatrix(table(service_test[,7],service_test[,6]),positive = 'Yes')

