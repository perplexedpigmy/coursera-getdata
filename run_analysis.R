# Coursera Getting and Cleaning Data 
# Course Project 
# 
# Usage description:
#    source the script 
# 
# Objectives:
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.

source('common.R') # Common external data retrival file
getFile("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        ".",
        "power_consumption.zip",
        unzip = TRUE)

# ############################################################### 
#  Combine all 3 information parts into 1 table
#   - X file (Actual observation)
#   - Y file (Activity)
#   - Subject file (The subject id observed)
# 
#  Argument 
#     type - The type of information to process 
#            Possible values: test | train
# 
#  Return value
#    A data.frame with with 3 additional columns(type, subject, activity)
# 
#  Dependencies on parent closure (to avoid longer than necessary function signature)
#     activity      - A vector of activity labels (Order corresponds to activity value)
#     col.class     - A vector of classes (length must be equal to number of observational columns )
#                     Allows to filter out unwanted columns
#     col.names     - A vector of feature columns we are interested in
construct <- function(type) {
  obs <- read.table(file.path("./UCI HAR Dataset", type, paste0("X_", type, ".txt")), colClasses = col.class)
  act <- read.table(file.path("./UCI HAR Dataset", type, paste0("Y_", type, ".txt")))
  sbj <- read.table(file.path("./UCI HAR Dataset", type, paste0("subject_", type, ".txt")))
  names(obs) <- col.names

  obs["subject"]  <- sbj
  obs["activity"] <- sapply(act$V1, function(act.no) { tolower(activity[act.no]) })
  obs["type"]     <- type
  
  # Re-order the data.frame to have the introduced columns first
  obs <- subset(obs, select=c('subject', 'activity', 'type' , col.names))
}

# ###############################################################
#  Main
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = c("NULL", "character"))[,1]
feature  <- read.table("./UCI HAR Dataset/features.txt", colClasses = c("NULL", "character"))[,1]

# Deduce columns with mean and std and not meanFreq
feature.cols <- grep("(mean|std)\\()", feature)
col.class    <- rep("NULL", length(feature))
col.class[feature.cols] <- "numeric"

# Column names quite explanatory. I only remove the () from the name
col.names  <- sapply(feature[feature.cols], function(col) { gsub("\\()", "", col)})

# Step 1 throuh 4: Merged train & test with properly named columns 
merged <- rbind(construct("train"), construct("test"))

# Step 5: tidy dataset averaged per activity/subject 
per.activity.subject <- aggregate(merged[c('type', col.names)], 
                                  list(activity=merged$activity, subject=merged$subject),
                                  function(x) {  ifelse (class(x) == 'character', x, mean(x))  })

write.table(per.activity.subject, "tidy.txt", row.names = FALSE, quote = FALSE)
