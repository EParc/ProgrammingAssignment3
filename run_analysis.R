#The numbers (e.g. ##1) can be found in the "README.md" for more a detailed explanation 

##1
#Loading dependencies
library(dplyr)
library(reshape2)

##2
#Create a working directory if it does not already exist
  if (!file.exists("workingDir")){
  dir.create("workingDir")
}
setwd("workingDir")

##3
#Downloading the Samsung data
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip", mode = "wb")
unzip(zipfile="data.zip", exdir = "./data")

##4
#Reading the necessary files files
X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("data/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("data/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt")

##5
#Merging the 3 train datasets and the test files
merge_train<- cbind(Y_train,subject_train, X_train)
merge_test <- cbind(Y_test,subject_test,X_test)

#Merge the training and the test sets to create one data frame
merge_train_test <- rbind(merge_train, merge_test)

##6
#Column 1 name is "Activity"
#Column 2 name is "Subject
#Other columns use the value from column 2 of the feature data as the names of the columns
colnames(merge_train_test)[1:2] <- c("Activity","Subject")
colnames(merge_train_test)[3:563] <- as.character(features$V2)


##7
#Select columns with mean or std in it
mean_std <- grep("std|mean", names(merge_train_test))
meanstd1 <- merge_train_test[ ,c(1,2, mean_std)]


##8
#Adding the activity names
activity <- rename(activity_labels, Activitycode = V1, Activity = V2)
activity <- merge(activity, meanstd1, by.x = "Activitycode", by.y = "Activity")
all_data <- select(activity, -Activitycode)


##9
#Change column names so they are easier to understand
names(all_data) <-sub("Freq", "Frequency", names(all_data))
names(all_data) <-sub("^t", "TimeSignal", names(all_data))
names(all_data) <-sub("^f", "FrequencySignal", names(all_data))
names(all_data) <-sub("mean", "Mean", names(all_data))
names(all_data) <-sub("std", "StandardDeviation", names(all_data))
names(all_data) <-sub("max", "Maximum", names(all_data))
names(all_data) <-sub("min", "Minimum", names(all_data))
names(all_data) <-sub("Mag", "Magnitude", names(all_data))
names(all_data) <-sub("X", "Xaxis", names(all_data))
names(all_data) <-sub("Y", "Yaxis", names(all_data))
names(all_data) <-sub("Z", "Zaxis", names(all_data))
names(all_data) <-sub("\\()", "", names(all_data))
names(all_data) <-gsub("-", "", names(all_data))
names(all_data) <-sub("Acc", "Acceleration", names(all_data))
names(all_data) <-sub("Gyro", "Velocity", names(all_data))
names(all_data) <-sub("BodyBody", "Body", names(all_data))


##10
#Calculate the mean values of the measured variables
ActivitySubjectMelt <- melt(all_data, id=c("Activity", "Subject"))
means <- dcast(ActivitySubjectMelt , Subject + Activity ~ variable, mean)


##11
#Export the tidy dataset 
write.table(means, "tidy.txt", row.names = FALSE)

