Assignment: Getting and Cleaning Data Course Project
====================================================

Files
-----
readme.md
codebook.md
Run_Analysis.r
TidyData.txt

Assignment
----------
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Needed packages for the R assigment
-----------------------------------
Some of the functions in de R application are needing functions, that are available in the following packages:
plyr
data.table

Download dataset (study design)
-------------------------------
Before you can start the cleanup of the files you wil need to download a zipfile with the nessasry files.
The URI: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

When running the R application the file will download automaticaly (you need a active internet connection) 
Downloading can take up some time.

Unpacking Zip file
------------------
After downloading the file, the application will extract the files in the appropiate folder

Cleaning data
-------------
After unzipping the files will be merged (training and test data) in x and y 
Extract only the mean and standard deviation (std)
Replace the activity names with a descriptive name
Add the appropiate labels


Export
------
Export the new dataset to a txt file (TidyData.txt)