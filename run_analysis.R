fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
ZIP <- "./UCI.zip"
root <- "./UCI HAR Dataset"
tidyData<- "./tidy.txt"
tidyDataAvg <- "./tidyAvg.txt" 
tidyDataAvgCsv <- "./tidy-UCI-HAR-dataset-AVG.csv"
if (file.exists(ZIP) == FALSE) {
        download.file(fileUrl, destfile = ZIP, method = "curl")
}
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x <- rbind(x_train, X_test)
y <- rbind(y_train, y_test)
z <- rbind(subject_train, subject_test)
features <- read.table("./UCI HAR Dataset/features.txt")
names(features) <- c('f_id', 'f_name')
index_features <- grep("-mean\\(\\)|-std\\(\\)", features$f_name) 
x <- x[, index_features] 
names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity) <- c('a_id', 'a_name')
y[, 1] = activity[y[, 1], 2]
names(y) <- "Activity"
names(z) <- "Subject"
tidyDataSet <- cbind(z, y, x)
p <- tidyDataSet[, 3:dim(tidyDataSet)[2]] 
tidyDataAvgSet <- aggregate(p,list(tidyDataSet$Subject, tidyDataSet$Activity), mean) 
names(tidyDataAvgSet)[1] <- "Subject"
names(tidyDataAvgSet)[2] <- "Activity"
write.table(tidyDataSet, tidyData, row.name = FALSE)
write.table(tidyDataAvgSet, tidyDataAvg, row.name = FALSE)