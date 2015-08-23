Code Book for Course Project for Getting and Cleaning Data

This CodeBook file describes the variables, the data, transformations and work that I performed to clean up the data.

This link has the description of the original data. http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

I used the following files from the data set in the project:
1. y_test.txt - test labels (number 1 to 6, maps to activity labels, 2947 records)
2. X_test.txt - MAIN test data set (561 variables, 2947 records)
3. y_train.txt - training labels (number 1 to 6, maps to activity labels, 7352 records)
4. X_train.txt - MAIN training data set (561 variables, 7352 records)
5. activity_labels.txt - links the 6 class labels with their activity name (1-walking, 2-walking_upstairs, 3-walking_downstairs, 4-sitting, 5-standing, 6-laying)
6. features.txt - list of the different features (561 records) (e.g. tGravityAcc-std())
7. subject_train.txt - lists the individual subjects for the training data records
8. subject_test.txt - lists the individual subjects for the test data records

The run_analysis.R script file first imports the 8 raw data files.
The next steps in the script bring in the variable names from the features.txt file into the two MAIN data sets, as the preliminary raw data files just have the 561 variables named V1, V2, ..., V561.
The next steps in the script bring in the subject's ID into the two MAIN data sets.
The next steps in the script create a new variable in the two MAIN data sets called 'type'. This variable is "train" for the 7352 training records and "test" for the 2947 test records. This is so, when the data is merged, you will know if the subject was part of the training group or part of the testing group.
The next steps in the script removes all of the variables in the two MAIN data sets that were to be excluded as part of the project. The only variables of the 561 that we kept were the mean and standard deviation variables.
The next steps in the script create a variable in the two MAIN data sets called 'origID'. This variable is 1 to 7352 for the training records and 1 to 2947 for the test records. This is so, when the data is merged, you will know the ID from their separate original files.
The next step in the script merges the two altered MAIN data sets into one merged data set.
The final steps in the script reshape and output the merged data into a tidy data set containing the average of each variable for each activity and each subject

 
