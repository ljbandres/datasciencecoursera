# Getting and Cleaning Data Course Project
This is the Peer-Grade Assignment of the third module in Data Science Specialization. Here is described the all 
the variables, the data, and transformations made in the dataset used in this project.
### Libraries used in this project.
```
library(dplyr)
library(tidyr)
library(reshape2)
library(data.table)
```
## Question 4: Appropriately labels the data set with descriptive variable names.
#### Importing data.
```
train_set <- fread(input = 'UCI HAR Dataset/train/X_train.txt')
```
#### Changing columns names to those described in the file UCI HAR Dataset/features.txt.
```
colnames(train_set) <- fread(input = 'UCI HAR Dataset/features.txt',
                             col.names = c('number','feature'))$feature
```
#### Reading the subjects data set and assign them to train set a column 'subject'.
```
train_set$subject <-fread(input = 'UCI HAR Dataset/train/subject_train.txt',
      col.names = 'subject')$subject
```
#### Reading the labels data set and assign them to train set a column 'labels'.
```
train_set$label <- fread(input = 'UCI HAR Dataset/train/y_train.txt',
                         col.names = 'label')$label
```
#### Removing duplicated columns. Here is important to set parameter 'with = FALSE' in order 
```
train_set <- train_set[, unique(colnames(train_set)), with = FALSE]
```
## Formating Train Set.
#### Importing data.
```
test_set <- fread(input = 'UCI HAR Dataset/test/X_test.txt')
```
#### Changing columns names to those described in the file UCI HAR Dataset/features.txt. This appropriately labels the data set with descriptive variable names.
```
colnames(test_set) <- fread(input = 'UCI HAR Dataset/features.txt',
                            col.names = c('number','feature'))$feature
```
#### Reading the subjects data set and assign them to train set a column 'subject'.
```
test_set$subject <-fread(input = 'UCI HAR Dataset/test/subject_test.txt',
                          col.names = 'subject')$subject
```
#### Reading the labels data set and assign them to train set a column 'labels'.
```
test_set$label <- fread(input = 'UCI HAR Dataset/test/y_test.txt',
                         col.names = 'label')$label
```
#### Removing duplicated columns. Here is important to set parameter 'with = FALSE' in order to not use colnames as data source, but as a dinamic selector of columns. 
```
test_set <- test_set[, unique(colnames(test_set)), with = FALSE]
```
## Question 1: Merging Train Set with Test Set into a new Data Set.
```
data_set <- merge(x = train_set,
          y = test_set,
          all = TRUE)
```
## Question 2: Extracting only the measurements on the mean and standard deviation for each measurement.
```
data_set <- data_set[,colnames(data_set)[grepl('[Mm]ean|std|subject|label',
                                               colnames(data_set))],
         with = FALSE]
```
## Question 3: Uses descriptive activity names to name the activities in the data set
#### Importing data of the activities with them labels.
```
ctivity_labels <- fread(input = 'UCI HAR Dataset/activity_labels.txt',
                         col.names = c('label','activity'))
```
#### Changing label numbers by activity names into data_set. It keeps the same column name 'label'
```
data_set <-merge(data_set,
      activity_labels,
      by.x = 'label',
      by.y = 'label',
      all = TRUE)
```
## Question 5: Creating a second, independent tidy data set with the average of each variablefor each activity and each subject.
```
tidy_data_set <- data.table(data_set %>%
  group_by(activity, subject) %>%
  summarise_all(mean))
```
## Saving into a .txt file called 'luis_bandres_tidy_data_set.txt'
```
write.table(x = tidy_data_set,file = 'luis_bandres_tidy_data_set.txt',row.name=FALSE)
```
## Variables in the tidy data set.
```
[1] "label"                                "tBodyAcc-mean()-X"                   
 [3] "tBodyAcc-mean()-Y"                    "tBodyAcc-mean()-Z"                   
 [5] "tBodyAcc-std()-X"                     "tBodyAcc-std()-Y"                    
 [7] "tBodyAcc-std()-Z"                     "tGravityAcc-mean()-X"                
 [9] "tGravityAcc-mean()-Y"                 "tGravityAcc-mean()-Z"                
[11] "tGravityAcc-std()-X"                  "tGravityAcc-std()-Y"                 
[13] "tGravityAcc-std()-Z"                  "tBodyAccJerk-mean()-X"               
[15] "tBodyAccJerk-mean()-Y"                "tBodyAccJerk-mean()-Z"               
[17] "tBodyAccJerk-std()-X"                 "tBodyAccJerk-std()-Y"                
[19] "tBodyAccJerk-std()-Z"                 "tBodyGyro-mean()-X"                  
[21] "tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                  
[23] "tBodyGyro-std()-X"                    "tBodyGyro-std()-Y"                   
[25] "tBodyGyro-std()-Z"                    "tBodyGyroJerk-mean()-X"              
[27] "tBodyGyroJerk-mean()-Y"               "tBodyGyroJerk-mean()-Z"              
[29] "tBodyGyroJerk-std()-X"                "tBodyGyroJerk-std()-Y"               
[31] "tBodyGyroJerk-std()-Z"                "tBodyAccMag-mean()"                  
[33] "tBodyAccMag-std()"                    "tGravityAccMag-mean()"               
[35] "tGravityAccMag-std()"                 "tBodyAccJerkMag-mean()"              
[37] "tBodyAccJerkMag-std()"                "tBodyGyroMag-mean()"                 
[39] "tBodyGyroMag-std()"                   "tBodyGyroJerkMag-mean()"             
[41] "tBodyGyroJerkMag-std()"               "fBodyAcc-mean()-X"                   
[43] "fBodyAcc-mean()-Y"                    "fBodyAcc-mean()-Z"                   
[45] "fBodyAcc-std()-X"                     "fBodyAcc-std()-Y"                    
[47] "fBodyAcc-std()-Z"                     "fBodyAcc-meanFreq()-X"               
[49] "fBodyAcc-meanFreq()-Y"                "fBodyAcc-meanFreq()-Z"               
[51] "fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"               
[53] "fBodyAccJerk-mean()-Z"                "fBodyAccJerk-std()-X"                
[55] "fBodyAccJerk-std()-Y"                 "fBodyAccJerk-std()-Z"                
[57] "fBodyAccJerk-meanFreq()-X"            "fBodyAccJerk-meanFreq()-Y"           
[59] "fBodyAccJerk-meanFreq()-Z"            "fBodyGyro-mean()-X"                  
[61] "fBodyGyro-mean()-Y"                   "fBodyGyro-mean()-Z"                  
[63] "fBodyGyro-std()-X"                    "fBodyGyro-std()-Y"                   
[65] "fBodyGyro-std()-Z"                    "fBodyGyro-meanFreq()-X"              
[67] "fBodyGyro-meanFreq()-Y"               "fBodyGyro-meanFreq()-Z"              
[69] "fBodyAccMag-mean()"                   "fBodyAccMag-std()"                   
[71] "fBodyAccMag-meanFreq()"               "fBodyBodyAccJerkMag-mean()"          
[73] "fBodyBodyAccJerkMag-std()"            "fBodyBodyAccJerkMag-meanFreq()"      
[75] "fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-std()"              
[77] "fBodyBodyGyroMag-meanFreq()"          "fBodyBodyGyroJerkMag-mean()"         
[79] "fBodyBodyGyroJerkMag-std()"           "fBodyBodyGyroJerkMag-meanFreq()"     
[81] "angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)"
[83] "angle(tBodyGyroMean,gravityMean)"     "angle(tBodyGyroJerkMean,gravityMean)"
[85] "angle(X,gravityMean)"                 "angle(Y,gravityMean)"                
[87] "angle(Z,gravityMean)"                 "subject"                             
[89] "activity"
```
