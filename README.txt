# DM_Assignment2

The source code of this program is written in R language.
The libraries caret,class needs to be initialised before running the code.

The logistic regression classifier code generates the following output

This output below tells us the type of the data present in a data frame.

'data.frame':	135 obs. of  6 variables:
 $ OilQual    : num  45.77 4.99 4.99 106.39 104.39 ...
 $ EnginePerf : num  49.94 7.89 4.89 104.45 103.74 ...
 $ NormMileage: num  49.78 6.59 7.31 103.05 103.05 ...
 $ TyreWear   : num  48.26 9.49 8.37 106.28 106.13 ...
 $ HVACwear   : num  50.95 3.24 2.78 105.54 105.78 ...
 $ Service    : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 2 2 1 ...

> str(service_train)
'data.frame':	315 obs. of  6 variables:
 $ OilQual    : num  103.4 26.8 62.4 45.5 104.4 ...
 $ EnginePerf : num  103.5 26.2 63.7 49.9 103.3 ...
 $ NormMileage: num  103.1 31.3 59.7 48.8 103.1 ...
 $ TyreWear   : num  106.2 29.2 64.7 48.1 105.8 ...
 $ HVACwear   : num  105.7 31.3 58.6 48 106.5 ...
 $ Service    : Factor w/ 2 levels "No","Yes": 1 2 2 1 1 1 1 1 1 1 ...

The five point summary of a data for each particular data 

> summary(service_test)
    OilQual          EnginePerf       NormMileage         TyreWear          HVACwear      Service 
 Min.   :  2.597   Min.   :  1.891   Min.   :  3.589   Min.   :  6.143   Min.   : -1.72   No :99  
 1st Qu.: 26.696   1st Qu.: 27.418   1st Qu.: 31.260   1st Qu.: 28.901   1st Qu.: 31.31   Yes:36  
 Median : 61.023   Median : 61.501   Median : 59.351   Median : 61.304   Median : 62.62           
 Mean   : 58.629   Mean   : 59.077   Mean   : 59.118   Mean   : 60.864   Mean   : 58.99           
 3rd Qu.:104.229   3rd Qu.:103.744   3rd Qu.:103.051   3rd Qu.:106.173   3rd Qu.:105.33           
 Max.   :106.389   Max.   :105.744   Max.   :105.051   Max.   :108.173   Max.   :105.83           

> summary(service_train)
    OilQual           EnginePerf       NormMileage         TyreWear          HVACwear       Service  
 Min.   :  0.9872   Min.   :  1.891   Min.   :  3.359   Min.   :  6.213   Min.   : -1.72    No :232  
 1st Qu.: 26.7655   1st Qu.: 27.418   1st Qu.: 31.260   1st Qu.: 29.036   1st Qu.: 31.34     Yes: 83  
 Median : 59.6633   Median : 59.741   Median : 57.221   Median : 60.304   Median : 60.62  
 Mean   : 59.6493   Mean   : 60.306   Mean   : 60.297   Mean   : 61.759   Mean   : 60.39  
 3rd Qu.:104.3888   3rd Qu.:103.744   3rd Qu.:103.051   3rd Qu.:106.173   3rd Qu.:105.54  
 Max.   :106.4288   Max.   :105.744   Max.   :105.051   Max.   :108.173   Max.   :107.54  

Initializing the parameters of the logistic regression function
> lr<-glm(formula = service_train$Service~.,family = 'binomial',data = service_train)
The function glm stands for generalised linear model and 
  formula takes the no of values in the attribute to be predicted
  family is which kind of linear model the current one belongs to and
  data is the service train data

Call:  glm(formula = service_train$Service ~ ., family = "binomial", 
    data = service_train)

Coefficients of the regression model for each attribute considered
(Intercept)      OilQual   EnginePerf  NormMileage     TyreWear     HVACwear  
     5.5569       0.3541      -0.3583      -1.2399      -0.4415       1.5678  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)   5.5569     0.8221   6.759 1.39e-11 ***
OilQual       0.3541     0.1494   2.370  0.01779 *  
EnginePerf   -0.3583     0.1433  -2.500  0.01241 *  
NormMileage  -1.2399     0.1854  -6.688 2.26e-11 ***
TyreWear     -0.4415     0.1517  -2.911  0.00361 ** 
HVACwear      1.5678     0.2050   7.648 2.04e-14 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

One interesting thing we can note about this is that the significant codes have been mentioned which means to say that the attribute which holds the least significance can be dropped and still the same accuracy can be maintained.

> #the confusion matrix
      No Yes
  No  93   5
  Yes  6  31
                                          
               Accuracy : 0.9185          
                 95% CI : (0.8589, 0.9586)
                  Kappa : 0.7935                                           
            Sensitivity : 0.8611          
            Specificity : 0.9394                 
 The logistic model is also associated with a graph plot which can be seen when the script is executed.
 
The result of the KNN Classifier is as follows.
  The usual five point summary and structure of data is printed.
  
> table(data$Service) #get the number of values in each class.
 No Yes 
232  83 

The data had to be normalized for the comparison to be performed and it is done in the below 3 steps

> normalize <- function(x) { return ((x - min(x)) / (max(x) - min(x))) }
> data_n <- as.data.frame(lapply(data[,-6], normalize))
> testdata_n <- as.data.frame(lapply(testdata[,-6], normalize))

> #using the class library to get the knn algorithm for implementation
> predictedknn <- knn(train=data_n[,-6],test=testdata_n[,-6],cl=data$Service,k=3)
  This is the inbuilt function knn used for classification.
    train takes as input the training data
    test takes as input the test data
    cl takes as input the no of classes in the output prediction
    k contains the no of neighbours into consideration. (For this particular model the accuracy decreases at higher values of k)

> summary(predictedknn)
 No Yes 
 99  36 

> #using caret library for generating the confusion matrix
#Confusion Matrix and Statistics

Prediction No Yes
       No  99   0
       Yes  0  36
                                    
               Accuracy : 1         
                 95% CI : (0.973, 1)
                  Kappa : 1                                                 
            Sensitivity : 1.0000    
            Specificity : 1.0000
       
