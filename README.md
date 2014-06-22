# Getting and Cleaning Data Course Project

This ReadMe walksthrough the basics of the run_analysis.R script works and the steps needed to follow in order to run it. 

## Overview

The run_analysis.R script computes the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Instructions

* First, download and unzip the found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Drag contents of this folder into your working directory.
* Source "run_analysis.R" in R to run the script.
* After the script runs, you'll have two new files in your working directory:
	* "mergedData.txt" - 8.3mB - a 10299 x 68 data frame called 'allCleanedData'
	* "mean_std_averages.txt" - 225KB - a 180 x 68 data frame called 'averages'
	
## Assumptions

* The only assumption is that all of the files in the folder from the zip file are all placed in the working directory.



 

