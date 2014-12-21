# CodeBook 

## Input Data
The input data, Human Activity Recognition Using Smartphones Data Set, is obtained from [UCI Machine Learning repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#). 
There are 2 data layers Raw sensory data and post-processed data

### Raw sensor data
The data as captured by accelerometer and gyroscope sensors of a Samsung smartphone at a constant speed of 50Hz by 30 different individuals (subjects) aged from 19 to 48 as they perform activities of daily living (ADL). 

### Post processing data
The data is first cleaned and normalized to ranges -1 up to 1, using the [median filter](http://en.wikipedia.org/wiki/Median_filter) and and a 3<sup>rd</sup> order low pass [Butterworth filter](http://en.wikipedia.org/wiki/Butterworth_filter) with a corner frequency of 20 Hz.

Subsequently, the acceleration signal was then separated into body and gravity acceleration signals components. and the following additional variables were derived:
- The body linear acceleration and angular velocity were derived in time to obtain Jerk signals
- The magnitude of the above signals were calculated using the [Euclidean norm](http://en.wikipedia.org/wiki/Norm_(mathematics)#Euclidean_norm)
- Some frequency domain variables were synthesized via the [Fast Fourier Transform (FFT)](http://en.wikipedia.org/wiki/Fast_Fourier_transform)

### Stored Data structure
Description of the stored Input data can be found in the [README file](https://github.com/perplexedpigmy/coursera-getdata/blob/master/README.md#the-data)

## Output Data - Tidy

### Transformation 
The transformation analysis is detailed in the [README file](https://github.com/perplexedpigmy/coursera-getdata/blob/master/README.md#analysis)

### Tidy Data description

There are two column types categories and sensor derived (Derived from the observation of the sensors)

#### Category columns

There are 3 category columns 

  Name       |   Class    |   Values                                                                       | Comment
------------:|:----------:|:------------------------------------------------------------------------------:|:----------
**type**     | `character`| `train`, `test`                                                                | Origin of observation
**activity** | `character | `standing`,`sitting`,`laying`,`walking`,`walking_downstairs`,`walking_upstairs`|`  
**subject**  | `integer   | 1-30                                                                           | Subject id 

#### Sensor Derived data

There are 66 sensor derivded variables, that are ordered in the following table by their description 
and the type of the descrition ([Time domain](http://en.wikipedia.org/wiki/Time_domain), or [Frequency domain](http://en.wikipedia.org/wiki/Frequency_domain))

**Notes:**
* -XYZ is used to denote 3-axial signals in the X, Y and Z directions, i.e variable described as tBodyAcc-mean-XYZ, is actually a description of 3 variables tBodyAcc-mean-X, tBodyAcc-mean-Y and tBodyAcc-Z.
* The value of a variable whose name contain `mean` string is the average of all observationss for a specific subject and activity pair.
* The value of a variable whose name contain `std` string is the standard deviation of all observations for a specific subject and activity pair.
* There are 180 observation rows in the tidy dataset

   Description                       |  Time domain variable           | Frequency domain variable
:-----------------------------------:|:-------------------------------:|:-------------------------:
Body Acceleration	             |  tBodyAcc-mean-XYZ              |  fBodyAcc-mean-XYZ 
                                     |  tBodyAcc-std-XYZ               |  fBodyAcc-std-XYZ
Gravity Acceleration	             |  tGravityAcc-mean-XYZ           |  
                                     |  tGravityAcc-std-XYZ            |
Body Acceleration Jerk               |  tBodyAccJerk-mean-XYZ          |  fBodyAccJerk-mean-XYZ
                                     |  tBodyAccJerk-std-XYZ           |  fBodyAccJerk-std-XYZ
Body Angular Speed                   |  tBodyGyro-mean-XYZ             |  fBodyGyro-mean-XYZ
                                     |  tBodyGyro-std-XYZ              |  fBodyGyro-std-XYZ
Body Angular Acceleration	     |  tBodyGyroJerk-mean-XYZ         |  
                                     |  tBodyGyroJerk-std-XYZ          |  
Body Acceleration Magnitude          |  tBodyAcckMag-mean              |  fBodyAccMag-mean
                                     |  tBodyAcckMag-std               |  fBodyAccMag-std
Gravity Acceleration Magnitude       |  tGravityAccMag-mean            |  
                                     |  tGravityAccMag-std             |
Body Acceleration Jerk Magnitude     |	tBodyAccJerkMag-mean           |  fBodyAccJerkMag-mean
                                     |  tBodyAccJerkMag-std            |  fBodyAccJerkMag-std
Body Angular Speed Magnitude         |  tBodyGyroMag-mean              |  fBodyGyroMag-mean
                                     |  tBodyGyroMag-std               |  fBodyGyroMag-std
Body Angular Acceleration Magnitude  |  tBodyGyroJerkMag-mean          |  fBodyGyroJerkMag-mean
                                     |  tBodyGyroJerkMag-std           |  fBodyGyroJerkMag-std


### Stored data structure
The data is output to a file named tidy.txt in the current working directory.
An example code to read it in the R langauge is
````R
> View(read.table('tidy.txt', header = TRUE)
````
