## Retrieving dataset
# directory creation and download
if(!file.exists("./course-project")) {dir.create("./course-project")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./course-project/Dataset.zip")

# unzip file
unzip(zipfile = "./course-project/Dataset.zip", exdir = "./course-project")

## Reading files
# training tables
xtraining <- read.table("./course-project/UCI HAR Dataset/train/X_train.txt")
ytraining <- read.table("./course-project/UCI HAR Dataset/train/Y_train.txt")
subtraining <- read.table("./course-project/UCI HAR Dataset/train/subject_train.txt")

# testing tables
xtest <- read.table("./course-project/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./course-project/UCI HAR Dataset/test/Y_test.txt")
subtest <- read.table("./course-project/UCI HAR Dataset/test/subject_test.txt")

# features
features <- read.table("./course-project/UCI HAR Dataset/features.txt")

# activity labels
actlabels <- read.table("./course-project/UCI HAR Dataset/activity_labels.txt")

## Column Names
colnames(xtraining) <- features[,2]
colnames(ytraining) <- "activityId"
colnames(subtraining) <- "subjectId"
colnames(xtest) <- features[,2]
colnames(ytest) <- "activityId"
colnames(subtest) <- "subjectId"
colnames(actlabels) <- c("activityId", "activityType")

## Merging data
mergedtraining <- cbind(ytraining, subtraining, xtraining)
mergedtest <- cbind(ytest, subtest, xtest)
newdataset <- rbind(mergedtraining, mergedtest)

## Extracting only the measurements on the mean and standard deviation for each measurement
# column names
colNames <- colnames(newdataset)

# stats 
stats <- grepl("activityId", colNames) |
    + grepl("subjectId", colNames) |
    + grepl("mean..", colNames) |
    + grepl("sd..", colNames)
mean_sd <- newdataset[, stats == TRUE]

## Using descriptive activity names to name the activities in the data set
actnames <- merge(mean_sd, actlabels, by = "activityId", all.x = TRUE)

## independent tidy data set with the average of each variable for each activity and each subject
secdataset <- aggregate(. ~subjectId + activityId, actnames, mean)
secdataset <- secdataset[order(secdataset$subjectId, secdataset$activityId),]

## Converting secdataset to .txt
write.table(secdataset, "secdataset.txt", row.names = FALSE)