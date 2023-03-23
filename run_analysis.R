
# Read files

library(data.table)
library(dplyr)

featurenames <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
activitylabels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", header = FALSE)

subjecttrain <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activitytrain <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header = FALSE)
featurestrain <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header = FALSE)

subjecttest <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activitytest <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header = FALSE)
featurestest <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header = FALSE)

#-----------------------------------------------------------------------

# Merge Training and Test data

subject <- rbind(subjecttrain, subjecttest)
activity <- rbind(activitytrain, activitytest)
features <- rbind(featurestrain, featurestest)

colnames(features) <- c(featurenames$V2)
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
combineddata <- cbind(features, activity, subject)


#-----------------------------------------------------------------------

# Extract features for mean and std

colfilteredlist <- grepl("Mean()|Std()|Activity|Subject", names(combineddata), ignore.case=TRUE)

extracteddata <- combineddata[,colfilteredlist]


#-----------------------------------------------------------------------

# Replace activity value with names

extracteddata$Activity <- as.character(extracteddata$Activity)
for(i in 1:6){
	extracteddata$Activity[extracteddata$Activity==i] <- as.character(activitylabels[i,2])
}
extracteddata$Activity <- as.factor(extracteddata$Activity)


#-----------------------------------------------------------------------

# Rename the feature names

names(extracteddata)<-gsub("Acc", "Accelerometer", names(extracteddata))
names(extracteddata)<-gsub("Gyro", "Gyroscope", names(extracteddata))
#names(extracteddata)<-gsub("BodyBody", "Body", names(extracteddata))
#names(extracteddata)<-gsub("Mag", "Magnitude", names(extracteddata))
names(extracteddata)<-gsub("^t", "Time", names(extracteddata))
names(extracteddata)<-gsub("^f", "Frequency", names(extracteddata))
names(extracteddata)<-gsub("tBody", "TimeBody", names(extracteddata))
names(extracteddata)<-gsub("-mean()", "Mean", names(extracteddata), ignore.case = TRUE)
names(extracteddata)<-gsub("-std()", "Std", names(extracteddata), ignore.case = TRUE)
names(extracteddata)<-gsub("-freq()", "Freq", names(extracteddata), ignore.case = TRUE)
names(extracteddata)<-gsub("angle", "Angle", names(extracteddata))
names(extracteddata)<-gsub("gravity", "Gravity", names(extracteddata))


#-----------------------------------------------------------------------

# Create another data set with average of each feature for each activity and each subject

extracteddata$Subject <- as.factor(extracteddata$Subject)

extracteddata_t <- data.table(extracteddata)
tidydata <- aggregate(. ~Subject + Activity, extracteddata_t, mean)
tidydata <- tidydata[order(tidydata$Subject,tidydata$Activity),]
write.table(tidydata, file = "TidyData.txt", row.names = FALSE)


#-----------------------------------------------------------------------

