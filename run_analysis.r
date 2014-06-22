

# 1 Merges the training and the test sets to create one data set "alldata".

xtrain <- read.table("train/X_train.txt")
xtest <- read.table("test/X_test.txt")
xdata <- rbind(xtrain, xtest)

ytrain <- read.table("train/Y_train.txt")
ytest <- read.table("test/Y_test.txt")
ydata <- rbind(ytrain, ytest)

subjectTrain <- read.table("train/subject_train.txt")
subjectTest <- read.table("test/subject_test.txt")
subjectdata <- rbind(subjectTrain, subjectTest)


# 2 Extracts only the measurements on the mean and standard deviation for each measurement.


#read in features.txt data
features_data <- read.table("features.txt")
#extract thost that only contain "mean" or "std" in their name
mean_std_rows <- grep("-mean\\(\\)|-std\\(\\)", features_data[, 2])
#subset data set to the rows that only contain "mean" or "std" in the column name
xdata <- xdata[, mean_std_rows]
#Fill in column names from features.txt file
names(xdata) <- features_data[mean_std_rows, 2]
#remove ugly characters in column names
names(xdata) <- gsub("\\(|\\)", "", names(xdata))


# 3 Uses descriptive activity names to name the activities in the data set


#read in activity_labels.txt file
activityLabels <- read.table("./activity_labels.txt")
#lowercase the activity labels with "tolower"
activityLabels[, 2] <- tolower(gsub("_", "", activityLabels[, 2]))
#uppercase "Upstairs" to make it easier to read
substr(activityLabels[2, 2], 8, 8) <- toupper(substr(activityLabels[2, 2], 8, 8))
#uppercase "Downstairs" to make it easier to read
substr(activityLabels[3, 2], 8, 8) <- toupper(substr(activityLabels[3, 2], 8, 8))
#match up names of activities with values in y data
ydata[,1] = activityLabels[ydata[,1], 2]
#change column name to "activity"
names(ydata) <- "activity"


# 4 Appropriately labels the data set with descriptive variable names. 


#change column name to "subject"
names(subjectdata) <- "subject"
#combine all three data sets into one clean data set with column bind
allCleanedData <- cbind(subjectdata, ydata, xdata)
#create and save file for new clean data set
write.table(allCleanedData, "mergedData.txt")
#head(allCleanedData, 10)


# 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

newdatatable <- data.table(allCleanedData)
averages <- newdatatable[,lapply(.SD,mean),by="activity,subject"]
#write new tidy data set with averages
write.table(averages, "mean_std_averages.txt")


