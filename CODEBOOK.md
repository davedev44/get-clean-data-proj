# Code Book: Getting & Cleaning Data Course Project

## Introduction

This is the code book for the tidy data set derived from the raw data associated with the "Human Activity Recognition Using Smart Phones Data Set" (UCI Machine Learning Repository). Please note that the descriptions herein derive heavily from the descriptions of the data provided along with the raw data set, and as such, I hereby cite all such descriptions as source material for this code book. The data set can be obtained from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and the source data set of interest [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). I also note that I drew upon the class discussion boards for ideas on what to put in this code book, where to find units for measurements, and the like, as well as other internet sources (for things like the units of jerk).

A script, run_analysis.R, was provided to transform the raw dataset mentioned above into the tidy dataset which this code book describes. That script is described in the README file.

## Summary

The raw data set is a large collection of signal measurements taken from a group of 30 subjects (identified by code numbers 1-30) each performing a series of six activities: laying, sitting, standing, walking, walking downstairs, and walking upstairs. Measurements were taken from a smart phone's gyroscope and accelerometer, and the latter signal divided into gravitational and body motion components. These signal measurements were captured in time domain, and some converted to frequency domain with a fast-fourier transform. All measurements are normalized within the range [-1,1].

The tidy data set was obtained by extracting each of the measurement variables corresponding to the mean or to the standard deviation of one of the signal measurements. There were 66 such variables in this dataset. Following that, for each activity and subject pairing (of which there are 180: 30 subjects, 6 activities per subject), each of the extracted variables was averaged over all of the tests (rows) reported in the dataset for the given activity/subject pairing. As such, the dataset is comprised of 180 rows (as already mentioned) with 68 observations for each - the 66 mean/stdev variables plus subject code and activity.

To reiterate: the items in the tidy data set are the *average* of the respective mean or stdev variables taken from the raw data set, for each activity/subject pairing.

## Format / Variables

The following variables are reported in each row of the dataset.

1. activityName - factor with six levels (LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)
2. subjectCode - integer code for the subject for which raw data are summarized for this activity (1-30)
3. tBodyAccelSignalXMean - mean of the body component of the accelerometer time-domain signal in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
4. tBodyAccelSignalYMean - mean of the body component of the accelerometer time-domain signal in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
5. tBodyAccelSignalZMean - mean of the body component of the accelerometer time-domain signal in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
6. tBodyAccelSignalXStdev - standard deviation of the body component of the accelerometer time-domain signal in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
7. tBodyAccelSignalYStdev - standard deviation of the body component of the accelerometer time-domain signal in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
8. tBodyAccelSignalZStdev - standard deviation of the body component of the accelerometer time-domain signal in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
9. tGravityAccelSignalXMean - mean of the gravity component of the accelerometer time-domain signal in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
10. tGravityAccelSignalYMean - mean of the gravity component of the accelerometer time-domain signal in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
11. tGravityAccelSignalZMean - mean of the gravity component of the accelerometer time-domain signal in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
12. tGravityAccelSignalXStdev - standard deviation of the gravity component of the accelerometer time-domain signal in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
13. tGravityAccelSignalYStdev - standard deviation of the gravity component of the accelerometer time-domain signal in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
14. tGravityAccelSignalYStdev - standard deviation of the gravity component of the accelerometer time-domain signal in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: g = m/s^2)
15. tBodyAccelJerkSignalXMean - mean of the jerk time-domain signal derived from the body linear acceleration in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: m/s^3)
16. tBodyAccelJerkSignalYMean - mean of the jerk time-domain signal derived from the body linear acceleration in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: m/s^3)
17. tBodyAccelJerkSignalZMean - mean of the jerk time-domain signal derived from the body linear acceleration in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: m/s^3)
18. tBodyAccelJerkSignalXStdev - standard deviation of the jerk time-domain signal derived from the body linear acceleration in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: m/s^3)
19. tBodyAccelJerkSignalYStdev - standard deviation of the jerk time-domain signal derived from the body linear acceleration in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: m/s^3)
20. tBodyAccelJerkSignalZStdev - standard deviation of the jerk time-domain signal derived from the body linear acceleration in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: m/s^3)
21. tBodyGyroSignalXMean - mean of the gyro time-domain signal in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec)
22. tBodyGyroSignalYMean - mean of the gyro time-domain signal in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec)
23. tBodyGyroSignalZMean - mean of the gyro time-domain signal in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec)
24. tBodyGyroSignalXStdev - standard deviation of the gyro time-domain signal in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec)
25. tBodyGyroSignalYStdev - standard deviation of the gyro time-domain signal in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec)
26. tBodyGyroSignalZStdev - standard deviation of the gyro time-domain signal in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec)
27. tBodyGyroJerkSignalXMean - mean of the jerk time-domain signal derived from the angular velocity in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec^2)
28. tBodyGyroJerkSignalYMean - mean of the jerk time-domain signal derived from the angular velocity in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec^2)
29. tBodyGyroJerkSignalZMean - mean of the jerk time-domain signal derived from the angular velocity in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec^2)
30. tBodyGyroJerkSignalXStdev - standard deviation of the jerk time-domain signal derived from the angular velocity in the X direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec^2)
31. tBodyGyroJerkSignalYStdev - standard deviation of the jerk time-domain signal derived from the angular velocity in the Y direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec^2)
32. tBodyGyroJerkSignalZStdev - standard deviation of the jerk time-domain signal derived from the angular velocity in the Z direction (mean over values of this variable in the raw dataset for this activity and subject) (units: rad/sec^2)
