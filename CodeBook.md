## Codebook for Getting Data Course Project

This is the codebook for the Getting and Cleaning Data Course Project.

### Overview

The course project entails combining training and test datasets recording accelerometer readings from Samsung Galaxy S2 phones.

### Data Sources

The data was collated in support of **International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012**.


* Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
* Smartlab - Non Linear Complex Systems Laboratory 
* DITEN - UniversitÃ  degli Studi di Genova, Genoa I-16145, Italy. 
* activityrecognition '@' smartlab.ws 
* www.smartlab.ws 


### Transformations

The following transformations were applied to the data

* **Merge training and test datasets** (append one on to the end of the other)
* **Extract columns related to Mean and SD values** (via grep string matching)
* **Tidy variable names** (remove invalid characters)
* **Insert actual activity names** (replace index values with descriptive names)
* **Collate tidy data** (produce matrix of mean column value for each permutation of Activity & Subject)

### Data Dictionary 

