Getting_and_cleaning_data
=========================

The purpose of this document is to explain how R script file is working.

The R script run_analysis.R should execute the following steps:

A. Check whether required file exists in the working directory, else - download it;
B. Read local file representing test and train data tables;
C. Read local file representing features and activity data;
D. Extract the mean and standard deviation related data;
E. Merge initially related data and create temporary data sets x, y and z to process;
F. Transform data to make it tidy;
G. Merge intermediate data sets into single tidy data set tidyDataSet;
H. Aggregate tidyDataSet data into new data set called tidyDataAvgSet representing Average calculation only;
I. Update column headers for newle created tidyDataAvgSet;
J. Write final data frames into appropriate .txt files. 

Based on the requirements only file tidyAvg.txt is used for submssion.
