## Getting and cleaning data, Course Project

## get the dataset
datasetUrl <- "dataset.zip"
if(!file.exists(datasetUrl))
{
    message("downloading data file")
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", datasetUrl, method="curl")
}

## unpack the dataset
resFolder <- "UCI HAR Dataset"
if(!file.exists(resFolder))
{
    message("unzipping data file")
    unzip <- unzip(datasetUrl, exdir = ".")
}

#####################################################################
## 1. Merge the training and test datasets into one data set

## cache the x data - since it takes so long to process
if(!exists("xData"))
{
    message("reading & binding X data")
    xData <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt"))
}

message("reading & binding Y data")
yData <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt"))

message("reading & binding subject data")
subjectData <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt"))

#######################################################################
## 2. extract the columns that represent mean and SD   

## start with the column names
featureTable <- read.table("UCI HAR Dataset/features.txt")

## find the columns of interest
required_features <- grep("-mean\\(\\)|-std\\(\\)", featureTable[, 2])

## extract just these columns
trimmedXData <- xData[, required_features]

## use the nice new tidy names
names(trimmedXData) <- featureTable[required_features, 2]

## remove the brackets from the column names
names(trimmedXData) <- gsub("\\(|\\)", "", names(trimmedXData))

##################################################################
## 3. Insert the descriptive activity names
activities_names <- read.table("UCI HAR Dataset/activity_labels.txt")
yData[,1] = activities_names[yData[,1], 2]
names(yData) <- "Activity"

######################################################################
## 4. label the dataset with the merged set of subject and activity names
names(subjectData) <- "Subject"
collatedData <- cbind(subjectData, yData, trimmedXData)

#########################################################################
## 5. output the new dataset that includes the average of each variable for each activity and subject

## create tall table of all permutations
moltenData <- melt(collatedData, id=c("Activity", "Subject"))

## transpose table into required format
outputData <- dcast(moltenData, Activity + Subject ~ variable, mean)

## finally, output the dataset
write.csv(outputData, "averages_per_activity_and_subject.csv", row.names = FALSE)