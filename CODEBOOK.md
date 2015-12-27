# Code Book: Getting & Cleaning Data Course Project

## Introduction

This is the code book for the tidy data set derived from the raw data associated with the "Human Activity Recognition Using Smart Phones Data Set" (UCI Machine Learning Repository). Please note that the descriptions herein derive heavily from the descriptions of the data provided along with the raw data set, and as such, I hereby cite all such descriptions as source material for this code book. The data set can be obtained from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and the source data set of interest [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

A script, run_analysis.R, was provided to transform the raw dataset mentioned above into the tidy dataset which this code book describes. That script is described in the README file.

## Summary

The raw data set is a large collection of signal measurements taken from a group of 30 subjects (identified by code numbers 1-30) each performing a series of six activities: laying, sitting, standing, walking, walking downstairs, and walking upstairs. Measurements were taken from a smart phone's gyroscope and accelerometer, and the latter signal divided into gravitational and body motion components. These signal measurements were captured in time domain, and some converted to frequency domain with a fast-fourier transform. All measurements are normalized within the range [-1,1].

The tidy data set was obtained by extracting each of the measurement variables corresponding to the mean or to the standard deviation of one of the signal measurements. There were 66 such variables in this dataset. Following that, for each activity and subject pairing (of which there are 180: 30 subjects, 6 activities per subject), each of the extracted variables was averaged over all of the tests (rows) reported in the dataset for the given activity/subject pairing. As such, the dataset is comprised of 180 rows (as already mentioned) with 68 observations for each - the 66 mean/stdev variables plus subject code and activity.

To reiterate: the items in the tidy data set are the *average* of the respective mean or stdev variables taken from the raw data set, for each activity/subject pairing.

## Format / Variables

The following variables are reported in each row of the dataset.

1. activityName - factor with six levels (LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)
2. subjectCode - integer code for the subject for which raw data are summarized for this activity (1-30)
3. 