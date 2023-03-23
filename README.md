### Introduction

This project is for Data Science - Getting and Cleaning Data course - Course Project.


### Resources
(1) Folder "getdata_projectfiles_UCI HAR Dataset" contains the processed data files from the Samsung study.
(2) File 'run_analysis.R' is the R script that perhaps Getting and Cleaning of the data
(3) File 'TidyData.txt" contains the cleaned up data.
(4) File 'Codebook.md' is the codebook for the cleaned up data.



### Process in "run_analysis.R"

1. Reads the data files from the experiment, and merges the test and training data to produce a set of combined data.

2. Extracts all the features for the mean and standard deviation values

3. Replaces the activity id with the activity label.

4. Renames the names for the extracted features to be more descriptive.

5. Creates a tidy set of data where the average for each feature is recorded, for each activity, and each subject.