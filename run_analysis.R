#
# run_analysis.R
#
# Read in and transform raw data to a tidy data set for mean and stdev
# variables
#
# NOTE: I drew upon several sources for help with this assignment - mostly
# stack overflow for getting past various roadblocks (for example, how to
# grep for something with parens in it) as well as drawing from the
# discussion forums for general help on how to proceed.
#

run_analysis <- function() {
    # Load plyr at beginning; it will be used several places throughout the fn
    library(plyr)
    
    # Tasks are
    
    # 1. Merge the training and test sets to create one data set
    
    # First, load the data from the provided data files.
    # X-data are the features/measurements of the data set
    # Y-data are the activity NUMBERS
    # subject-data are the subject code numbers
    
    # features.txt contains the list of measurements - each is given a number and
    # a name, one row per measurement name. We load this to get the column names
    # for the X-data
    features <-
        read.table("features.txt", col.names = c("Number", "Name"))
    
    xColNames <- as.vector(features$Name)
    
    # Now, load the x-data. There are the test and training sets; we'll
    # be careful what order we load them in and load the y-data in the
    # same order
    xtest <- read.table("test/X_test.txt", col.names = xColNames, check.names = FALSE)
    xtrain <- read.table("train/X_train.txt", col.names = xColNames, check.names = FALSE)
    
    # Now combine into a single table
    xcomb <- rbind(xtest, xtrain)
    
    # Repeat for Y; will provide more descriptive (activity names) info later
    ytest <- read.table("test/y_test.txt", col.names=c("activity"))
    ytrain <- read.table("train/y_train.txt", col.names=c("activity"))
    
    ycomb <- rbind(ytest, ytrain)
    
    # Repeat for subjects; 
    stest <- read.table("test/subject_test.txt", col.names=c("subject_code"))
    strain <- read.table("train/subject_train.txt", col.names=c("subject_code"))
    scomb <- rbind(stest, strain)
    
    # Based on the requested list of steps I am going to assume we want to
    # wait to join X and Y columnwise.
    
    # 2. Extract only measurements on mean & stdev for each measurement
    # We can use grep to find the word "mean()" or "std()" in a column name
    # Found that parentheses need to be double-backslashed for grep
    # grep will return the list of column names (rather than indices)
    # because we specify value=TRUE
    colNamesToKeep <- as.vector(grep("mean\\(\\)|std\\(\\)", xColNames, value=TRUE))
    
    # Now simply subset combined x data on that vector of columns
    xcombmeanstd <- xcomb[,colNamesToKeep]
    
    # 3. Use descriptive activity names to name activities in the data set
    
    # First we will merge the activity code ("label") according to the dataset
    # Then we can add just the name column to the combined x data set
    # also adding the subject data column along the way
    
    # First read in the activity name / label correspondence into a dataframe
    # We name the first column (the number or "code") activity
    # code to match with the column name in the combined y data
    # Read name as character so it can be used in the mapvalues call (next step)
    act_names <- read.table("activity_labels.txt", 
                            col.names=c("activity_code", "activity_name"),
                            colClasses=c("integer", "character"))
    
    # Now: use mapvalues function to replace the activity codes currently
    # in the activity column of the Y-data with the name.
    ycomb$activity <- as.factor(mapvalues(ycomb$activity, 
                                          act_names$activity_code, 
                                          act_names$activity_name))
    
    # Now we combine the columns we want - xcombmeanstd already contains
    # the measurements we want, and in addition, we want just the activity
    # names column from the y data, and the subject column
    
    # Combine columns with cbind
    xyscomb <- cbind(xcombmeanstd, ycomb, scomb)
    
    # 4. Appropriately label the dataset with descriptive variable names
    # This is just a matter of renaming the columns. I simply looked at
    # the output of names(xyscomb) and renamed each more descriptively
    xyscombdescrnames <- rename(xyscomb, 
                                replace=c("tBodyAcc-mean()-X"="tBodyAccelSignalXMean", 
                                          "tBodyAcc-mean()-Y"="tBodyAccelSignalYMean",
                                          "tBodyAcc-mean()-Z"="tBodyAccelSignalZMean",
                                          "tBodyAcc-std()-X"="tBodyAccelSignalXStdev",
                                          "tBodyAcc-std()-Y"="tBodyAccelSignalYStdev",
                                          "tBodyAcc-std()-Z"="tBodyAccelSignalZStdev",
                                          "tGravityAcc-mean()-X"="tGravityAccelSignalXMean",
                                          "tGravityAcc-mean()-Y"="tGravityAccelSignalYMean",
                                          "tGravityAcc-mean()-Z"="tGravityAccelSignalZMean",
                                          "tGravityAcc-std()-X"="tGravityAccelSignalXStdev",
                                          "tGravityAcc-std()-Y"="tGravityAccelSignalYStdev",
                                          "tGravityAcc-std()-Z"="tGravityAccelSignalZStdev",        
                                          "tBodyAccJerk-mean()-X"="tBodyAccelJerkSignalXMean",
                                          "tBodyAccJerk-mean()-Y"="tBodyAccelJerkSignalYMean",
                                          "tBodyAccJerk-mean()-Z"="tBodyAccelJerkSignalZMean",
                                          "tBodyAccJerk-std()-X"="tBodyAccelJerkSignalXStdev", 
                                          "tBodyAccJerk-std()-Y"="tBodyAccelJerkSignalYStdev",
                                          "tBodyAccJerk-std()-Z"="tBodyAccelJerkSignalZStdev",
                                          "tBodyGyro-mean()-X"="tBodyGyroSignalXMean",     
                                          "tBodyGyro-mean()-Y"="tBodyGyroSignalYMean",
                                          "tBodyGyro-mean()-Z"="tBodyGyroSignalZMean",
                                          "tBodyGyro-std()-X"="tBodyGyroSignalXStdev",
                                          "tBodyGyro-std()-Y"="tBodyGyroSignalYStdev",
                                          "tBodyGyro-std()-Z"="tBodyGyroSignalZStdev",
                                          "tBodyGyroJerk-mean()-X"="tBodyGyroJerkSignalXMean",
                                          "tBodyGyroJerk-mean()-Y"="tBodyGyroJerkSignalYMean",
                                          "tBodyGyroJerk-mean()-Z"="tBodyGyroJerkSignalZMean",
                                          "tBodyGyroJerk-std()-X"="tBodyGyroJerkSignalXStdev",
                                          "tBodyGyroJerk-std()-Y"="tBodyGyroJerkSignalYStdev",
                                          "tBodyGyroJerk-std()-Z"="tBodyGyroJerkSignalZStdev",
                                          "tBodyAccMag-mean()"="tBodyAccelSignalMagMean",
                                          "tBodyAccMag-std()"="tBodyAccelSignalMagStdev",
                                          "tGravityAccMag-mean()"="tGravityAccelSignalMagMean",
                                          "tGravityAccMag-std()"="tGravityAccelSignalMagStdev", 
                                          "tBodyAccJerkMag-mean()"="tBodyAccelJerkSignalMagMean",
                                          "tBodyAccJerkMag-std()"="tBodyAccelJerkSignalMagStdev",
                                          "tBodyGyroMag-mean()"="tBodyGyroSignalMagMean",
                                          "tBodyGyroMag-std()"="tBodyGyroSignalMagStdev",
                                          "tBodyGyroJerkMag-mean()"="tBodyGyroJerkSignalMagMean",
                                          "tBodyGyroJerkMag-std()"="tBodyGyroJerkSignalMagStdev",
                                          "fBodyAcc-mean()-X"="fBodyAccelSignalXMean",
                                          "fBodyAcc-mean()-Y"="fBodyAccelSignalYMean",
                                          "fBodyAcc-mean()-Z"="fBodyAccelSignalZMean",
                                          "fBodyAcc-std()-X"="fBodyAccelSignalXStdev",
                                          "fBodyAcc-std()-Y"="fBodyAccelSignalYStdev",
                                          "fBodyAcc-std()-Z"="fBodyAccelSignalZStdev",     
                                          "fBodyAccJerk-mean()-X"="fBodyAccJerkSignalXMean",
                                          "fBodyAccJerk-mean()-Y"="fBodyAccJerkSignalYMean",
                                          "fBodyAccJerk-mean()-Z"="fBodyAccJerkSignalZMean",  
                                          "fBodyAccJerk-std()-X"="fBodyAccJerkSignalXStdev",
                                          "fBodyAccJerk-std()-Y"="fBodyAccJerkSignalYStdev",      
                                          "fBodyAccJerk-std()-Z"="fBodyAccJerkSignalZStdev",
                                          "fBodyGyro-mean()-X"="fBodyGyroSignalXMean",
                                          "fBodyGyro-mean()-Y"="fBodyGyroSignalYMean",
                                          "fBodyGyro-mean()-Z"="fBodyGyroSignalZMean",
                                          "fBodyGyro-std()-X"="fBodyGyroSignalXStdev",
                                          "fBodyGyro-std()-Y"="fBodyGyroSignalYStdev",
                                          "fBodyGyro-std()-Z"="fBodyGyroSignalZStdev",
                                          "fBodyAccMag-mean()"="fBodyAccelSignalMagMean",
                                          "fBodyAccMag-std()"="fBodyAccelSignalMagStdev",
                                          "fBodyBodyAccJerkMag-mean()"="fBodyAccelJerkSignalMagMean",
                                          "fBodyBodyAccJerkMag-std()"="fBodyAccelJerkSignalMagStdev",
                                          "fBodyBodyGyroMag-mean()"="fBodyGyroSignalMagMean",
                                          "fBodyBodyGyroMag-std()"="fBodyGyroSignalMagStdev",
                                          "fBodyBodyGyroJerkMag-mean()"="fBodyGyroJerkSignalMagMean",
                                          "fBodyBodyGyroJerkMag-std()"="fBodyGyroJerkSignalMagStdev",
                                          "activity"="activityName",
                                          "subject_code"="subjectCode"))
    
    # 5. From the data set in step 4, create a second, independent tidy data
    # set with the average of each variable for each activity and each subject
    
    # Since we know we'll want to split the data frame by subject & activity,
    # we'll want to use ddply (plyr)
    
    # Since we want to apply the mean to every column once we split the 
    # data, we use ddply's colwise component - rather than trying to list
    # every variable one-by-one to have the mean provided.
    
    # I observe that this call does not result in ddply trying to compute
    # the mean of activity name (which is a factor, makes sense) or the
    # subject code - I assume this is because they are the variables
    # we are splitting by.
    meanBySubjAct <- ddply(xyscombdescrnames, 
                           .(activityName, subjectCode),
                           colwise(mean))
    
    write.table(meanBySubjAct, file="run_analysis.txt", row.names=FALSE)
}
