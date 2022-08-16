---
title: "CodeBook"
author: "Willem Abrie"
date: "`r Sys.Date()`"
output: html_document
---

# Getting and Cleaning Data Course Assignment Code Book

A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data ...

The code book modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information

# This code book explains the variables presented in the final dataset called "df_tidy2".

The original variables are described below. They were modified in this dataset by averaging the entries by subject and secondly by activity.

ID variables were added as follows:

1. SubjectReference - refers to the number assigned to the various participants (range 1:30), as below
2. Activity - refers to the activity that was relevant for that row of data as follows:
+ WALKING
+ WALKING_UPSTAIRS
+ WALKING_DOWNSTAIRS
+ SITTING
+ STANDING
+ LAYING

Variable names for the measured variables (i.e. the rest of the columns) were clarified by making the following clarifications:

* Prefixing *AVERAGED_*
* removing the "t" prefixes
* replacing the "f" prefixes with "Frequency_"
* replacing "Acc" with "Acceleration"
* replacing "Mag" with "Magnitude"

The various variable names sn classes may be inspected as follows:

str(df_tidy2)

### Extract from source code variable information:

***

Feature Selection 


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag



The set of variables that were estimated from these signals are: 

mean(): Mean value

std(): Standard deviation

mad(): Median absolute deviation 

max(): Largest value in array

min(): Smallest value in array

sma(): Signal magnitude area

energy(): Energy measure. Sum of the squares divided by the number of values.

iqr(): Interquartile range 

entropy(): Signal entropy

arCoeff(): Autorregresion coefficients with Burg order equal to 4

correlation(): correlation coefficient between two signals

maxInds(): index of the frequency component with largest magnitude

meanFreq(): Weighted average of the frequency components to obtain a mean frequency

skewness(): skewness of the frequency domain signal 

kurtosis(): kurtosis of the frequency domain signal 

bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.

angle(): Angle between to vectors.


Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean

tBodyAccMean

tBodyAccJerkMean

tBodyGyroMean

tBodyGyroJerkMean


The complete list of variables of each feature vector is available in 'features.txt'

***

### Examples from List of original variables:
(Only mean() and std() variables were extracted for the *df_tidy2* data set presented for this assignment.)

***

1 tBodyAcc-mean()-X

2 tBodyAcc-mean()-Y

3 tBodyAcc-mean()-Z

4 tBodyAcc-std()-X

5 tBodyAcc-std()-Y

6 tBodyAcc-std()-Z

41 tGravityAcc-mean()-X

42 tGravityAcc-mean()-Y

43 tGravityAcc-mean()-Z

44 tGravityAcc-std()-X

45 tGravityAcc-std()-Y

46 tGravityAcc-std()-Z

***
