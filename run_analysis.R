## R script for Courseara "Getting and Cleaning Data" - Course Assignment

##Instructions: Create a script that does the following:
##1 - Merges the training and the test sets to create one data set.
##2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
##3 - Uses descriptive activity names to name the activities in the data set
##4 - Appropriately labels the data set with descriptive variable names. 
##5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Please upload your data set as a txt file created with write.table() using row.name=FALSE

##Link to GitHUB repo:
##https://github.com/WillemAlpha/GettingCleaningAssignment.git


#Set working directory
setwd("C:/Users/abriw/OneDrive - P D BULBECK PTY LTD/Documents/WillemFILES/DataScience/GettingCleaning/CourseProj")
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
        