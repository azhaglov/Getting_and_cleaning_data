## Variable list and descriptions
### Variable name         Description
* subject 	ID the subject who performed the activity for each window sample. 
* activity 	Activity name
* domain 	Feature: Time domain signal or frequency domain signal (Time or Freq)
* instrument 	Feature: Measuring instrument (Accelerometer or Gyroscope)
* acceleration 	Feature: Acceleration signal (Body or Gravity)
* variable 	Feature: Variable (Mean or SD)
* jerk Feature: Jerk signal
* magnitude 	Feature: Magnitude of the signals calculated using the Euclidean norm
* axis Feature: 3-axial signals in the X, Y and Z directions (X, Y, or Z)
* count 	Feature: Count of data points used to compute average
* average 	Feature: Average of each variable for each activity and each subject

## Data sets available

* 'README.txt'
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.

## Data manipulations

* Downloading data from Url provided
=>>     fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
* Assigning names to files and directories 
=>>     ZIP <- "./UCI.zip"
=>>     root <- "./UCI HAR Dataset"
=>>     tidyData<- "./tidy.txt"
=>>     tidyDataAvg <- "./tidyAvg.txt" 
=>>     tidyDataAvgCsv <- "./tidy-UCI-HAR-dataset-AVG.csv"
* Checking whether the raw file is in the directory 
=>>     if (file.exists(ZIP) == FALSE) {
        =>> download.file(fileUrl, destfile = ZIP, method = "curl")
=>> }
* Reading data from files
=>>     x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
=>>     X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
=>>     y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
=>>     y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
=>>     subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
=>>     subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
* Merging data into temporary data frames
=>>     x <- rbind(x_train, X_test)
=>>     y <- rbind(y_train, y_test)
=>>     z <- rbind(subject_train, subject_test)
* making data tidy step by step 
=>>     features <- read.table("./UCI HAR Dataset/features.txt")
* reading features names
=>>     names(features) <- c('f_id', 'f_name')
* finding required fields related to mean and standard deviation observations 
=>>     index_features <- grep("-mean\\(\\)|-std\\(\\)", features$f_name) 
=>>     x <- x[, index_features] 
* Replacement executed
=>>     names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))
=>>     activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
* tidy names assigned 
=>>     names(activity) <- c('a_id', 'a_name')
=>>     y[, 1] = activity[y[, 1], 2]
=>>     names(y) <- "Activity"
=>>     names(z) <- "Subject"
* Final data set created
=>>     tidyDataSet <- cbind(z, y, x)
* Cloned final data set to calculate averages
=>>     p <- tidyDataSet[, 3:dim(tidyDataSet)[2]] 
=>>     tidyDataAvgSet <- aggregate(p,list(tidyDataSet$Subject, tidyDataSet$Activity), mean) 
* Tidy names assigned to tidyDataAvgSet
=>>     names(tidyDataAvgSet)[1] <- "Subject"
=>>     names(tidyDataAvgSet)[2] <- "Activity"
* writing final data into new .txt files
=>>     write.table(tidyDataSet, tidyData, row.name = FALSE)
=>>     write.table(tidyDataAvgSet, tidyDataAvg, row.name = FALSE)