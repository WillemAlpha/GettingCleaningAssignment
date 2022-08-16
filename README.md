---
title: "ReadMe.md"
author: "Willem Abrie"
date: "`r Sys.Date()`"
output: html_document
---


## Getting and Cleaning Data Course Assignment ReadME

This repo explains how all of the scripts work and how they are connected.

Only one scrip was written called "run_analysis". It was broken down into five steps as per the instructions.
The following is an explanation of each step:


### Step 1: Read in data and merge

First I created a dataframe for each of the test and training sets by adding all the bits together until I had the following:

* Col 1: text saying "test" or "train" depending on which data set was used
* Col 2: the subject numbers (1 to 30) showing which subject was considered for each row
* Col 3: the activity number reference
* Rest of the columns: the "X" data

Secondly I merged the two tables with rbind() to get a complete dataframe called "df_all"

### Step2: Extract only the mean and standard deviation values

I extacted all the columns that have "mean" or "std"as part of the variable name, but also kept the first three columns that have been added as above. The resultant dataframe is called "df_extract".

The following post was used to figure out the data extraction using the grep() function:

[Stackoverlow Post](https://stackoverflow.com/questions/69651600/r-subset-data-frame-by-column-names-using-partial-string-match-from-another-list)

### Step 3: Add descriptive activity names

This was interpreted as chaning the numbers between 1 and 6 in Col 3 (see Step 1 above) to match the labels in the "activity_labels.txt" file.

This was done by changing values using subsetting on the "Activities" column (col 3)

### Step 4: Appropriately label the data set with descriptive variable names

This is basically understood as renaming the column names from col 4 onwards to something more comprehensible.
With an acknowledged lack of understanding of what these data are, this was attempted by doing the following:

* removing the "t" prefixes
* replacing the "f" prefixes with "Frequency_"
* replacing "Acc" with "Acceleration"
* replacing "Mag" with "Magnitude"

this was achieved by using the sub() command


### Step 5: Create a new data set with the average of each variable for each activity and each subject

This was done as follows:

1. Melt the data according to ID and MEASURED variables
2. Recast all the variables according to the two ID variables
3. Prefix "AVERAGED_" to the var names to make it clear

## R scripts

***
```{r}

if(!file.exists("./data")){dir.create("./data")}

##1 - Read in and merge the training and the test sets to create one data set.
        ##a - First create the dataframe for the test data
        
        #Observations(rows) for all variables (columns)
        df_xtest = read.table('./Data/test/X_test.txt')
        ##Activities for each row
        df_ytest = read.table('./Data/test/y_test.txt')
        ##Subjects for each row
        df_subjects = read.table('./Data/test/subject_test.txt')
        ##add in extra column to indicate that these are all test data
        datasource <- rep("test", dim(df_xtest)[1])
        df_datasource <- as.data.frame(datasource)
        
        ##bind ref columns for subjects and activities to data
        df_test = cbind(df_datasource, df_subjects, df_ytest, df_xtest)
        
        ##read in variable(column) names
        df_features = read.table('./Data/features.txt')
        #add in column names including the first two columns that have been added
        colnames(df_test) <- c("DataSource","SubjectReference", "Activity", as.character(df_features[,2])) 

        ##b - Secondly, create the dataframe for the train data
        
        #Observations(rows) for all variables (columns)
        df_xtrain = read.table('./Data/train/X_train.txt')
        ##Activities for each row
        df_ytrain = read.table('./Data/train/y_train.txt')
        ##Subjects for each row
        df_subjects = read.table('./Data/train/subject_train.txt')
        ##add in extra column to indicate that these are all test data
        datasource <- rep("train", dim(df_xtrain)[1])
        df_datasource <- as.data.frame(datasource)
        
        ##bind ref columns for subjects and activities to data
        df_train = cbind(df_datasource, df_subjects, df_ytrain, df_xtrain)
        
        #add in column names including the first two columns that have been added
        colnames(df_train) <- c("DataSource","SubjectReference", "Activity", as.character(df_features[,2]))

        ##c - Merge the two sets
        df_all <- rbind(df_test, df_train)


##2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
        #a - extact all the columns that have "mean" or "std"as part of the variable name, but also keep the first
        #       three columns that have been added
        df_extract <- df_all[, c(1:3, grep("mean|std", x=names(df_all)) )]
        
##3 - Uses descriptive activity names to name the activities in the data set
        df_extract[,3][df_extract[,3] == 1] <- "walking"
        df_extract[,3][df_extract[,3] == 2] <- "walking_upstairs"
        df_extract[,3][df_extract[,3] == 3] <- "walking_downstairs"
        df_extract[,3][df_extract[,3] == 4] <- "sitting"
        df_extract[,3][df_extract[,3] == 5] <- "standing"
        df_extract[,3][df_extract[,3] == 6] <- "laying"
        
##4 - Appropriately labels the data set with descriptive variable names.
        # remove the "t" prefixes
        colnames(df_extract) <- sub("tB","B", names(df_extract))
        colnames(df_extract) <- sub("tG","G", names(df_extract))
        # replace the "f" prefixes with "Frequency_"
        colnames(df_extract) <- sub("fB","Frequency_B", names(df_extract))
        # replace "Acc" with "Acceleration"
        colnames(df_extract) <- sub("Acc","Acceleration", names(df_extract))
        # replace "Mag" with "Magnitude"
        colnames(df_extract) <- sub("Mag","Magnitude", names(df_extract))
        
##Step 5: Create a new data set with the average of each variable for each activity and each subject
        #melt the data according to ID and MEASURED variables
        df_melt <- melt(df_extract, id=c("SubjectReference","Activity"), measure.vars=names(df_extract)[-c(1:3)])
        #recast all the variables according to the two ID variables
        df_tidy2 <- dcast(df_melt, SubjectReference + Activity ~ variable, mean)
        #prefix "AVERAGED_" to the var names to make it clear
        colnames(df_tidy2)[-c(1:2)] <- paste("AVERAGED", colnames(df_tidy2)[-c(1:2)], sep = "_")
        
##Step 6: Write the tidy data
write.table(df_tidy2, file = "tidy2.txt", sep = " ",row.names = FALSE)

```
***
