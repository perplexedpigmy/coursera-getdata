# CodeBook 

## Input Data
The input data, Human Activity Recognition Using Smartphones Data Set, is obtained from [UCI Machine Learning repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#). 
There are 2 data layers Raw sensory data and post-processed data

### Raw sensor data
The data as captured by accelerometer and gyroscope sensors of a Samsung smartphone at a constant speed of 50Hz by 30 different individuals (subjects) aged from 19 to 48 as they perform activities of daily living (ADL). 

### Post processing data
The data is first cleaned and normalized and bounded within [-1,1], using the [median filter](http://en.wikipedia.org/wiki/Median_filter) and and a 3<sup>rd</sup> order low pass [Butterworth filter](http://en.wikipedia.org/wiki/Butterworth_filter) with a corner frequency of 20 Hz.

Subsequently, the acceleration signal was then separated into body and gravity acceleration signals components(`tBodyAcc-XYZ` and `tGravityAcc-XYZ`). and the following additional variables were derived:
- The body linear acceleration and angular velocity were derived in time to obtain Jerk signal (`tBodyAccJerk-XYZ` and `tBodyGyroJerk-XYZ`)
- The magnitude of the above signals were calculated using the [Euclidean norm](http://en.wikipedia.org/wiki/Norm_(mathematics)#Euclidean_norm) (`tBodyAccMag`, `tGravityAccMag`, `tBodyAccJerkMag`, `tBodyGyroMag`, `tBodyGyroJerkMag`)
- Some frequency domain variables were synthesized via the [Fast Fourier Transform (FFT)](http://en.wikipedia.org/wiki/Fast_Fourier_transform)(`fBodyAcc-XYZ`, `fBodyAccJerk-XYZ`, `fBodyGyro-XYZ`, `fBodyAccJerkMag`, `fBodyGyroMag`, `fBodyGyroJerkMag`)

The set of variables that were estimated from these signals are:  
 
- `mean()` Mean value 
- `std()` Standard deviation 
- `mad()` Median absolute deviation  
- `max()` Largest value in array 
- `min()` Smallest value in array 
- `sma()` Signal magnitude area 
- `energy()` Energy measure. Sum of the squares divided by the number of values.  
- `iqr()` Interquartile range  
- `entropy()` Signal entropy 
- `arCoeff()` Autorregresion coefficients with Burg order equal to 4 
- `correlation()` correlation coefficient between two signals 
- `maxInds()` index of the frequency component with largest magnitude 
- `meanFreq()` Weighted average of the frequency components to obtain a mean frequency 
- `skewness()` skewness of the frequency domain signal  
- `kurtosis()` kurtosis of the frequency domain signal  
- `bandsEnergy()` Energy of a frequency interval within the 64 bins of the FFT of each window. 
- `angle()` Angle between to vectors. 
 
Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable: 
 
`gravityMean` 
`tBodyAccMean` 
`tBodyAccJerkMean` 
`tBodyGyroMean` 
`tBodyGyroJerkMean`

### Stored Data structure
Description of the stored Input data can be found in the [README file](https://github.com/perplexedpigmy/coursera-getdata/blob/master/README.md#the-data)

## Output Data - Tidy

### Transformation 
The transformation analysis is detailed in the [README file](https://github.com/perplexedpigmy/coursera-getdata/blob/master/README.md#analysis)

### Tidy Data description

There are 69 columns divided into 2 column types **tegories** and **sensor derived** (Derived from the observation of the sensors)

#### Category columns

There are 3 category columns 

  Name       |   Class    |   Values                                                                       | Comment
:-----------:|:----------:|:------------------------------------------------------------------------------:|:----------
**type**     | `character`| `train`, `test`                                                                | Origin of observation
**activity** | `character`| `standing`,`sitting`,`laying`,`walking`,`walking_downstairs`,`walking_upstairs`|  
**subject**  | `integer`  | 1-30                                                                           | Subject id 

#### Sensor Derived data

There are 66 sensor derivded variables, that are ordered in the following table by their description 
and the type of the descrition ([Time domain](http://en.wikipedia.org/wiki/Time_domain), or [Frequency domain](http://en.wikipedia.org/wiki/Frequency_domain)). They are of type `numeric` and their values are normalized and bounded within [-1,1]

   Description                       |  Time domain variable           | Frequency domain variable
:-----------------------------------:|:--------------------------------|:--------------------------
Body Acceleration	                   |  tBodyAcc-mean-XYZ              |  fBodyAcc-mean-XYZ 
                                     |  tBodyAcc-std-XYZ               |  fBodyAcc-std-XYZ
Gravity Acceleration	               |  tGravityAcc-mean-XYZ           |  
                                     |  tGravityAcc-std-XYZ            |
Body Acceleration Jerk               |  tBodyAccJerk-mean-XYZ          |  fBodyAccJerk-mean-XYZ
                                     |  tBodyAccJerk-std-XYZ           |  fBodyAccJerk-std-XYZ
Body Angular Speed                   |  tBodyGyro-mean-XYZ             |  fBodyGyro-mean-XYZ
                                     |  tBodyGyro-std-XYZ              |  fBodyGyro-std-XYZ
Body Angular Acceleration	           |  tBodyGyroJerk-mean-XYZ         |  
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

**Notes:**
* -XYZ is used to denote 3-axial signals in the X, Y and Z directions, i.e variable described as tBodyAcc-mean-XYZ, is actually a description of 3 variables tBodyAcc-mean-X, tBodyAcc-mean-Y and tBodyAcc-Z.
* The value of a variable whose name contain `mean` string is the average of all observations for a specific subject and activity pair.
* The value of a variable whose name contain `std` string is the standard deviation of all observations for a specific subject and activity pair.
* There are 180 observation rows in the tidy dataset.
* prefixes 'f' and 't' denote frequency domain and time domain repectively.

### Stored data structure
The data is output to a file named `tidy.txt` in the current working directory.
An example code to read it in the R langauge is
````R
> View(read.table('tidy.txt', header = TRUE)
````
