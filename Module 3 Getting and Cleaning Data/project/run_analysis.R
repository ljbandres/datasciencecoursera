library(dplyr)
library(tidyr)
library(reshape2)
library(data.table)

## Question 4: Appropriately labels the data set with descriptive variable names.

### Importing data.
train_set <- fread(input = 'UCI HAR Dataset/train/X_train.txt')
### Changing columns names to those described in the file UCI HAR Dataset/features.txt.
colnames(train_set) <- fread(input = 'UCI HAR Dataset/features.txt',
                             col.names = c('number','feature'))$feature
### Reading the subjects data set and assign them to train set a column 'subject'.
train_set$subject <-fread(input = 'UCI HAR Dataset/train/subject_train.txt',
      col.names = 'subject')$subject
### Reading the labels data set and assign them to train set a column 'labels'.
train_set$label <- fread(input = 'UCI HAR Dataset/train/y_train.txt',
                         col.names = 'label')$label
### Removing duplicated columns. Here is important to set parameter 'with = FALSE' in order 
train_set <- train_set[, unique(colnames(train_set)), with = FALSE]

## Formating Train Set.

### Importing data.
test_set <- fread(input = 'UCI HAR Dataset/test/X_test.txt')
### Changing columns names to those described in the file UCI HAR Dataset/features.txt.
### This appropriately labels the data set with descriptive variable names.
colnames(test_set) <- fread(input = 'UCI HAR Dataset/features.txt',
                            col.names = c('number','feature'))$feature
### Reading the subjects data set and assign them to train set a column 'subject'.
test_set$subject <-fread(input = 'UCI HAR Dataset/test/subject_test.txt',
                          col.names = 'subject')$subject
### Reading the labels data set and assign them to train set a column 'labels'.
test_set$label <- fread(input = 'UCI HAR Dataset/test/y_test.txt',
                         col.names = 'label')$label
### Removing duplicated columns. Here is important to set parameter 'with = FALSE' in order 
### to not use colnames as data source, but as a dinamic selector of columns. 
test_set <- test_set[, unique(colnames(test_set)), with = FALSE]

## Question 1: Merging Train Set with Test Set into a new Data Set.
data_set <- merge(x = train_set,
          y = test_set,
          all = TRUE)

## Question 2: Extracting only the measurements on the mean and standard deviation for each measurement.
data_set <- data_set[,colnames(data_set)[grepl('[Mm]ean|std|subject|label',
                                               colnames(data_set))],
         with = FALSE]

## Question 3: Uses descriptive activity names to name the activities in the data set

### Importing data of the activities with them labels.
ctivity_labels <- fread(input = 'UCI HAR Dataset/activity_labels.txt',
                         col.names = c('label','activity'))

### Changing label numbers by activity names into data_set.
### It keeps the same column name 'label'
data_set <-merge(data_set,
      activity_labels,
      by.x = 'label',
      by.y = 'label',
      all = TRUE)

## Question 5: Creating a second, independent tidy data set with the average of each variable
## for each activity and each subject.
tidy_data_set <- data.table(data_set %>%
  group_by(activity, subject) %>%
  summarise_all(mean))

## Saving into a .txt file called 'luis_bandres_tidy_data_set.txt'
write.table(x = tidy_data_set,file = 'luis_bandres_tidy_data_set.txt',row.name=FALSE)
