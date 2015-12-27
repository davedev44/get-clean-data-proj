# Course Project: Getting & Cleaning Data

## Summary

The materials herein are associated with the course project for the "Getting & Cleaning Data" course. Present here are a script, run_analysis.R, which takes as input raw data from the "Human Activity Recognition Using Smart Phones Data Set" (UCI Machine Learning Repository), and generates a tidy data set from a subset of it; a code book, which explains the composition of the tidy data set, and this README. The tidy data set is submitted under separate cover.

## run_analysis.R - tidy dataset generation script

The run_analysis.R script takes as input the major elements of the aforementioned dataset and provides a tidy dataset, summarizing for each test subject and activity (one of six physical activities for which data were collected) the mean for each of a set of variables from the raw data set; in particular, the raw mean and standard deviation measurements from the various gyro and accelerometer measurements. There are three components to the raw dataset: the "features", which are the measurements noted; the "activity" associated with the set of features measured, and the "subject", e.g. the study participant for the given set of measurements for the given activity.

The script accomplishes this task via the following steps (which were proscribed in the project statement):

* Merge Training & Test Data Sets

The dataset as a whole has two parts, a test set and a training set; as their shape and columns were the same this was a simple matter of reading in the training and test data for each of the three components, and combining the sets componentwise by appending the set of rows from the training set to the end of the test set. In the case of the sets for the features, the column names are separately listed in the file "features.txt"; this was parsed and attached as the series of column names for the feature data sets. Other column names were supplied as known (activity and subject_code, respectively).

* Extract only measurements on mean and standard deviation for each measurement

This was accomplished by a simple grep to find which measurements/features were a true mean (column name contained the string 'mean()') or standard deviation (contained the string 'std()'). 66 of the over 500 measurements satisfy this condition.

* Use descriptive activity names to name activities in the data set

The raw data includes the activity as a numeric (integer) code, as well as a separate file (activity_labels.txt) which provides the correspondence between the numeric code and the activity (1=WALKING, etc.). This was parsed and each numeric code in the activities data set replaced with the name of the activity using the mapvalues function, which provides exactly this functionality. It was at this point that the columns of all three datasets (features/measurements, activities, and subject codes were all combined into a single dataset).

* Appropriately label the dataset with descriptive variable names

This was accomplished by use of plyr's rename function; in looking at the existing column names (generated/derived as already discussed), and trying to make the variables more descriptive, for example, changing a name like "tBodyAcc-mean()-X" into "tBodyAccelSignalXMean", to indicate that the column represents, for the activity and subject, the mean of the body acceleration signal received in the X-direction. This was performed for all 68 variables (the 66 taken from step 2, plus activity and subject code).

* Create a second, independent tidy data set with the average of each variable for each activity and each subject

This was the final step - generating the tidy dataset, and plyr's ddply function splits the dataset by the two variables of interest (activity and subject) — and once grouped together, for each (activity, subject) pair that was found in the data set, the average for each measurement variable was computed based on the group of rows associated with that pair.





