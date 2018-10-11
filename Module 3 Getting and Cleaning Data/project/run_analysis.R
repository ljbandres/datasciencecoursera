library(dplyr)
library(tidyr)
library(reshape2)
library(data.table)

train_set <- fread(input = 'UCI HAR Dataset/train/X_train.txt')
colnames(train_set) <- fread(input = 'UCI HAR Dataset/features.txt',col.names = c('number','feature'))$feature
train_set$subject <-fread(input = 'UCI HAR Dataset/train/subject_train.txt',
      col.names = 'subject')$subject
train_set$label <- fread(input = 'UCI HAR Dataset/train/y_train.txt',
                         col.names = 'label')$label
train_set <- train_set[, unique(colnames(train_set)), with = FALSE]

test_set <- fread(input = 'UCI HAR Dataset/test/X_test.txt')
colnames(test_set) <- fread(input = 'UCI HAR Dataset/features.txt',
                            col.names = c('number','feature'))$feature
test_set$subject <-fread(input = 'UCI HAR Dataset/test/subject_test.txt',
                          col.names = 'subject')$subject
test_set$label <- fread(input = 'UCI HAR Dataset/test/y_test.txt',
                         col.names = 'label')$label
test_set <- test_set[, unique(colnames(test_set)), with = FALSE]

data_set <- merge(x = train_set,
          y = test_set,
          all = TRUE)

data_set <- data_set[,colnames(data_set)[grepl('[Mm]ean|std',colnames(data_set))],
         with = FALSE]

activity_labels <- fread(input = 'UCI HAR Dataset/activity_labels.txt',
                         col.names = c('label','activity'))

data_set <-merge(data_set,
      activity_labels,
      by.x = 'label',
      by.y = 'label',
      all = TRUE)
                         