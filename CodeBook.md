R script
In addition to retrieve the data, the file "run_analysis.R" performs the following 5 steps:

1 Merging the training and test sets to create one data set
1.1 After reading the files, three tables are created: 'xtraining', 'ytraining', and 'subtraining'. They contain the X, Y, and Subject
training data;
1.2 The testing data are stored in a similar fashion in the tables: 'xtest', 'ytest', and 'subtest'. They contain the X, Y, and Subject
testing data;
1.3 Two new tables are created, 'features' contains the correct names for the variables in the X, Y, and Subject
tables. The correct names are extracted from the activity lables table, 'actlabels';
1.4 Column names are attributed to all training and test tables and a vector with the correct variable names, 'activityId' and
'activityType' is created to attribute the appropriate variables to the merged data set;
1.5 Merged training and testing data sets are created using the function cbind() to concatenate both traning and testing data;
1.6 Finally, the new merged data set, 'newdataset', is created by applying the rbind() function to combine the training and testing
data sets.

2 Extracting only the measurements on the mean and standard deviation for each measurement
2.1 Column names are attributed to the merged data set using the grepl() function;
2.2 A new variable, 'mean_sd' is created by subsetting the merged data set, 'newdataset', to list the mean and standard deviation of all
variables.

3 Using descriptive activity names to name the activities in the data set
3.1 Merging the data set 'mean sd' with 'actlabels' by activity attributes activity names to the activities listed in the data set;
3.2 Applying the function aggregate(), the second data set, 'secdataset' is created.

4. Independent tidy data set with the average of each variable for each activity and each subject
4.1 This new data set is ordered by 'subjectId' and 'activityId' using the function order() and contains all means and standard deviations
of the analyzed variables.

5. The new merged data set is converted to .txt format.
