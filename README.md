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
* Read the feature and activity labels (files activity_labels.txt and features.txt)
* Identify the columns containing std() or mean() string 
* Call the function **construct** to build a data.frame for each of the data sets (_train_ and _test_) from it's disjoint 3 parts (*files X_\<type>.txt*, *Y_\<type>.txt*, *subject_\<type>.txt*), only for the columns of interest (recieved in previous step)
* Combine the two data.frames created for _test_ and _train_. By now we have a tidy data.frame
* use **aggregate** to group all rows by subject and activity with a mean() function. yielding the average for each variable per activity and subject.

### The construct function
The **construct** function capitalize on the fact that the two separated datasets for _train_ and _test_ share the same directory structure as well as file naming.
The function recives a type, either _train_ or _test_ and it constructs a data.frame from the following 3 sources
* **X_\<type>.txt** - All observations containing mean() or std() are added to that data.frame
* **Y_\<type>.txt** - Add column with activity names deduced by the activity id in this file and the previously read _activity_labels.txt_, name column activity
* **subject_\<type>.txt** - Add column with subject id number named 'subject'
* Add column type with all obseravations set to functions argument type.

## Running the script
### Dependencies
The script relies on external script **common.R** to download the external data and unzip it. 
If you already have **UCI HAR Dataset** directory and all related files, in the current **getwd()** directory than you don't need it and can remove this part of the code (lines 17-21).

### Output
The script will create in local directory a **tidy.txt** file as requested by the 5th point of the assingment 


## Comments
* The order of the instructions was deemed unimportant and was not strictly followed. efficiency and goal trump blind obidence, 
especailly when the grading rubricks do not require it.
* The assignement clearly asked for *standard deviation* and *mean* of each of the variables, meanFreqs was considered as not required


