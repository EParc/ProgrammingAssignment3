This is the Readme file for R script "run_analysis.R" for the Peer Graded Assignment: Getting and Cleaning Data Course Project
The numbers (e.g. ##1) can also be found in the code "run_analysis.R"


##1) Loading libraries: First all the necessary libraries are loaded.

##2) Creating a working directory, if it doesnt exist yet then it is created

##3) De data is downloaded and stored in the working directory (see previous step)

##4) Reading all the data files (training, test, features, and activity labels)

##5) Merging the training and the test sets to create one data set (var name: merge_train_test).

##6) Setting the right column names 

##7) Select columns with mean or std in it

##8) The activity labels dataset is used to add the descriptive names of the activity numbers to the table

##9) The column names (for output) are altered so they are easier to understand

##10) The mean of all the variables is calculated for each Activity, Subject and Measurement

##11) The data is exported to "tidy.txt" which you will be able to find in the working directory (see step 2)