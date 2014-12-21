# Coursera - Getting and Cleaning Data - Course project

## Inroduction
> The goal is to prepare tidy data that can be used for later analysis

The data originating from [http://archive.ics.uci.edu](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ) requires some pre-precessing before it can be considred tidy and ready for easy use.
The exercise as describe by the following 5 steps is to perfrom the following tidy the data set and produce a specific subset
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names. 
> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The Data
The data is disjoint and exist in multiple files, as described by the following file structure
* **UCI HAR Dataset**           (Root directory)
  * **activity_labels.txt**     (Map between numbered ids and their respective activity labels)
  * **features.txt**            (Map between numbered ids and their respective feature name)
  * **test**                    (Test obeservation results)
    * **Inertial Signals/**     (Directory with raw data files)
    * **subject_test.txt**      (The number of the subject for each of the observation)
    * **X_test.txt**            (561 derived variables(columns) monitored. each line is one observation)
    * **y_test.txt**            (the type of each of the observations) 
  * **train**                   (Train observation results)
    * **Inertial Signals/**     (Directory with raw data files)
    * **subject_test.txt**      (The number of the subject for each of the observation)
    * **X_test.txt**            (561 derived variables(columns) monitored. each line is one observation)
    * **y_test.txt**            (the type of each of the observations) 
    
Beside being disjoint, exiting in multiple files and split to test and training there is not much else that is fudenentaly wrong.

## Analysis 
The analysis follows these steps
* Read the feature and activity labels (only the label column)
````R
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = c("NULL", "character"))[,1]
feature  <- read.table("./UCI HAR Dataset/features.txt",        colClasses = c("NULL", "character"))[,1]
````
* Identify the columns containing `std()` or `mean()` string
````R
feature.cols <- grep("(mean|std)\\()", feature)
````
* Use the `construct` fucntion to build a data.frame for each of the data sets (_train_ and _test_) from its 3 disjoint parts (*files X_\<type>.txt*, *Y_\<type>.txt*, *subject_\<type>.txt*), and merge the two resulting data.table
````R
merged <- rbind(construct("train"), construct("test"))
````
* use `aggregate` to group all rows by **subject** and **activity** with a mean() as summary function. yielding the average for each variable per activity and subject.
````R
per.activity.subject <- aggregate(merged[c('type', col.names)], 
                                  list(activity=merged$activity, subject=merged$subject),
                                  function(x) { ifelse (class(x) == 'character', x, mean(x))  })
````
The function in **aggregate** is intended to avoid averaging the _type_ column(values: _train_ or _test_) which is of _character_ class.

### The `construct` function
The **construct** function capitalize on the fact that the two separated datasets for _train_ and _test_ share the same directory structure as well as file naming, and thusly both dataset can enjoy the same processing.
The function recives a _type_, either _train_ or _test_ and read the 3 different data sources (observations, activity ids, subjct ids).

````R
  obs <- read.table(file.path("./UCI HAR Dataset", type, paste0("X_", type, ".txt")), colClasses = col.class)
  act <- read.table(file.path("./UCI HAR Dataset", type, paste0("Y_", type, ".txt")))
  sbj <- read.table(file.path("./UCI HAR Dataset", type, paste0("subject_", type, ".txt")))
````
The observation file X_\<type>.txt has a colClasses sepcified to restrict reading feature.cols only. using the already generated col.class mask
````R
col.class    <- sapply(seq_along(feature), function(index) { ifelse(index %in% feature.cols, "numeric", "NULL")} )
````
The resulting data.frame columns are composed of all `mean()` and `std()` variables collection + the following 3 columns
````R
  obs["subject"]  <- sbj   # Subject ID previous read from subject_<type>.txt file
  obs["activity"] <- sapply(act$V1, function(act.no) { tolower(activity[act.no]) })  # Activity label, conjecture of activity_label.txt file and Y_<type>.txt file
  obs["type"]     <- type  # The type (train or test),  recieved argument
````

### Variable names transformation
I personally find the variable naming convention quite adquat being both concise and predictble, and no major changes takes place except for the removal of the parethensis which I find peculiar in a column name.
````R
col.names  <- sapply(feature[feature.cols], function(col) { gsub("\\()", "", col)})
````

## Running the script
### Dependencies
The script relies on external script **common.R** to download the external data and unzip it. 
````R
source('common.R') # Common external data retrival file
getFile("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        ".",
        "power_consumption.zip",
        unzip = TRUE)
````
If you already have **UCI HAR Dataset** directory and all related files, in the current **getwd()** directory than you don't need it and can remove this part of the code (lines 17-21).

### Output
The script will create in local directory a **tidy.txt** file as requested by the 5th point of the assingment 


## Comments
* The order of the instructions was deemed unimportant and was not strictly followed. efficiency and goal trump blind obidence, 
especailly when the grading rubricks do not require it.
* The assignement clearly asked for *standard deviation* and *mean* of each of the variables, meanFreqs was considered as not required


