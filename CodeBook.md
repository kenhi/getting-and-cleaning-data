##Steps used to transform data and overview of important variables


The `run_analysis.R` script does the following to transform and clean original data:

1. Reads x_train.txt and x_test.txt, combines them using rbind and stores them in variable *xdata*.
2. Reads y_train.txt and y_test.txt, combines them using rbind and stores them in variable *ydata*.
3. Reads subject_train.txt and subject_test.txt, combines them using rbind and stores them in variable *subjectdata*
4. *features_data* reads in the features.txt file which is used to match up *xdata* with their respective column name. Unwanted and ugley characters are removed after subsetting for mean and stdDev rows only.
4. Variable *activityLabels* reads in activity_labels.txt. Some manipulation of these labels are done to clean them: Lowercasing all the labels and uppercasing a few second word first letter labels to make them easier to read.
5. *ydata* activitylabels are applied and matched up. Column name is changed to "Activity"
5. Variable *allCleanedData* applies a cbind to the variables we established previously using rbind (*subjectdata*, *ydata*, *xdata*)
6. *allCleanedData* is then exported to `mergedData.txt` producing one combined, clean data set.
7. *averages* is the variable that stores the above data set with only averages for each activity and each subject. `mean_std_averages.txt` is exported.


##Names of Columns

1. ActivityName: Specificies the activity the subject is performing.
2. SubjectID: ID identifies the subject from whom data was collected
3. tBodyAccMeanX
4. tBodyAccMeanY
5. tBodyAccMeanZ
6. tBodyAccStdX
7. tBodyAccStdY
8. tBodyAccStdZ
9. tGravityAccMeanX
10. tGravityAccMeanY
11. tGravityAccMeanZ
12. tGravityAccStdX
13. tGravityAccStdY
14. tGravityAccStdZ
15. tBodyAccJerkMeanX
16. tBodyAccJerkMeanY
17. tBodyAccJerkMeanZ
18. tBodyAccJerkStdX
19. tBodyAccJerkStdY
20. tBodyAccJerkStdZ
21. tBodyGyroMeanX
22. tBodyGyroMeanY
23. tBodyGyroMeanZ
24. tBodyGyroStdX
25. tBodyGyroStdY
26. tBodyGyroStdZ
27. tBodyGyroJerkMeanX
28. tBodyGyroJerkMeanY
29. tBodyGyroJerkMeanZ
30. tBodyGyroJerkStdX
31. tBodyGyroJerkStdY
32. tBodyGyroJerkStdZ
33. tBodyAccMagMean
34. tBodyAccMagStd
35. tGravityAccMagMean
36. tGravityAccMagStd
37. tBodyAccJerkMagMean
38. tBodyAccJerkMagStd
39. tBodyGyroMagMean
40. tBodyGyroMagStd
41. tBodyGyroJerkMagMean
42. tBodyGyroJerkMagStd
43. fBodyAccMeanX
44. fBodyAccMeanY
45. fBodyAccMeanZ
46. fBodyAccStdX
47. fBodyAccStdY
48. fBodyAccStdZ
49. fBodyAccJerkMeanX
50. fBodyAccJerkMeanY
51. fBodyAccJerkMeanZ
52. fBodyAccJerkStdX
53. fBodyAccJerkStdY
54. fBodyAccJerkStdZ
55. fBodyGyroMeanX
56. fBodyGyroMeanY
57. fBodyGyroMeanZ
58. fBodyGyroStdX
59. fBodyGyroStdY
60. fBodyGyroStdZ
61. fBodyAccMagMean
62. fBodyAccMagStd
63. fBodyBodyAccJerkMagMean
64. fBodyBodyAccJerkMagStd
65. fBodyBodyGyroMagMean
66. fBodyBodyGyroMagStd
67. fBodyBodyGyroJerkMagMean
68. fBodyBodyGyroJerkMagStd



##Overview of the steps of the script and data manipulation



#### 1 Merges the training and the test sets to create one data set "alldata".

	xtrain <- read.table("train/X_train.txt")
	xtest <- read.table("test/X_test.txt")
	xdata <- rbind(xtrain, xtest)

	ytrain <- read.table("train/Y_train.txt")
	ytest <- read.table("test/Y_test.txt")
	ydata <- rbind(ytrain, ytest)

	subjectTrain <- read.table("train/subject_train.txt")
	subjectTest <- read.table("test/subject_test.txt")
	subjectdata <- rbind(subjectTrain, subjectTest)


#### 2 Extracts only the measurements on the mean and standard deviation for each measurement.



	features_data <- read.table("features.txt")

	mean_std_rows <- grep("-mean\\(\\)|-std\\(\\)", 	features_data[, 2])

	xdata <- xdata[, mean_std_rows]

	names(xdata) <- features_data[mean_std_rows, 2]

	names(xdata) <- gsub("\\(|\\)", "", names(xdata))


#### 3 Uses descriptive activity names to name the activities in the data set


	activityLabels <- read.table("./activity_labels.txt")

	activityLabels[, 2] <- tolower(gsub("_", "", 	activityLabels[, 2]))

	substr(activityLabels[2, 2], 8, 8) <- 			toupper(substr(activityLabels[2, 2], 8, 8))

	substr(activityLabels[3, 2], 8, 8) <- 			toupper(substr(activityLabels[3, 2], 8, 8))

	ydata[,1] = activityLabels[ydata[,1], 2]

	names(ydata) <- "activity"


#### 4 Appropriately labels the data set with descriptive variable names. 



	names(subjectdata) <- "subject"

	allCleanedData <- cbind(subjectdata, ydata, xdata)

	write.table(allCleanedData, "mergedData.txt")



#### 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

	newdatatable <- data.table(allCleanedData)
	averages <- newdatatable[,lapply(.SD,mean),by="activity,subject"]

	write.table(averages, "mean_std_averages.txt")

