# Install the libraries the script will use. Assumes you already have the proper packages installed
library(plyr)
library(dplyr)
library(reshape2)

# Read in the relevant data files. Assumes data has already been downloaded to the working directory
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt")
testData <- read.table("UCI HAR Dataset/test/X_test.txt")
trainLabels <- read.table("UCI HAR Dataset/train/y_train.txt")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Names the 561 variables in the training data and test data
names(trainData) <- features[,2]
names(testData) <- features[,2]

# Imports the subject id into the training data and test data
trainSubjects <- as.integer(trainSubjects[,1])
trainData$subject <- trainSubjects

testSubjects <- as.integer(testSubjects[,1])
testData$subject <- testSubjects

# Sets the variable type to "train" for the training data and "test" for test data
trainData$type <- "train"
testData$type <- "test"

# Names the activities and imports the activity name into the training data and test data
trainJoinLabels <- join(trainLabels,activityLabels)
trainData$activity <- trainJoinLabels[,2]

testJoinLabels <- join(testLabels,activityLabels)
testData$activity <- testJoinLabels[,2]

# Removes the variables that are not the mean or standard deviation from training data and test data
valuekeepmean <- "mean()"
valueremovefreq <- "Freq"
valuekeepstd <- "std()"

variableIsMean1 <- grepl(valuekeepmean,features[,2])
variableIsMean2 <- !grepl(valueremovefreq,features[,2])
indexIsMean <- which(variableIsMean1 & variableIsMean2)
variableIsStd <- grepl(valuekeepstd,features[,2])
indexIsStd <- which(variableIsStd)
indexIsOther <- c(562:564)

trainDataKeep <- trainData[,c(indexIsMean, indexIsStd, indexIsOther)]
testDataKeep <- testData[,c(indexIsMean, indexIsStd, indexIsOther)]

# Set the original ID for the training data and test data
trainDataKeep$origID <- c(1:7352)
testDataKeep$origID <- c(1:2947)

# Merge the data
mergedData <- rbind(trainDataKeep,testDataKeep)

# Get the tidy data set for #5
tidyMelt <- melt(mergedData,id=c("subject","type","activity"),measure.vars=names(mergedData[,1:66]))
tidyData <- dcast(tidyMelt,subject + type + activity ~ variable,mean)
write.table(tidyData,file="JWTidyData.txt",row.names=FALSE)