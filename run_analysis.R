
###### To run this code you should first download and unzip the source file ######

### 1. Merging the training and test sets

## 1.1 Reads the data from the file:

features <- read.table('./UCI HAR Dataset/features.txt')
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')

x_train <- read.table('./UCI HAR Dataset/train/X_train.txt') 
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt') 
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## 1.2 Assign column names:

colnames(x_train) <- features[,2] 
colnames(y_train) <-"activity"
colnames(subject_train) <- "subject"
      
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activity"
colnames(subject_test) <- "subject"
      
colnames(activity_labels) <- c('activity','activity_type')

## 1.3 Merge the data: (it's part of the required item 4 about labeling the data set)

# 1.3.1 First merge the training data:
train_m <- cbind(y_train, subject_train, x_train)

# 1.3.2 Then merge the test data:
test_m <- cbind(y_test, subject_test, x_test)

# 1.3.3 Finally merge the training and test data:
all_data <- rbind(train_m, test_m)

# 1.3.4 Assign the column names of the merged data set:
col_names <- colnames(all_data) 


### 2 Extract mean and standard deviation (also part of the required item 4 about labeling the data set)

## 2.1 Define ID, mean and std 
mean_and_std <- (grepl("activity" , col_names) | grepl("subject" , col_names) | grepl("mean.." , col_ames) | grepl("std.." , col_names))
      
## 2.3 Subseting:
mean_std <- all_data[ , mean_and_std == TRUE]
      

### 3. Descriptive activity names for the activities:
activity_names <- merge(mean_std, activity_labels, by='activity', all.x=TRUE)

      
### 4. Creates the independent tidy data set with the average of each variable for each activity and each subject:
      
tidy_set <- aggregate(. ~subject + activity, activity_names, mean)
tidy_dat <- tidy_set[order(tidy_set$subject, tidy_set$activity),]
      
## 4.1 Writing the final tidy data in a txt file
write.table(tidy_dat, "tidy_data.txt", row.name=FALSE)


