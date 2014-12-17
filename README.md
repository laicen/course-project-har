#Getting &amp; Cleaning Course Project
##Human Activity Recognition Data
##R Script & Code Book


###1. Below is the R script description:

####1.0 Download to R the Human Activity Recognition data from local files.

tsdata <- read.table("Insert directory file path/X_test.txt", sep="")

tssub <- read.table("Insert directory file path/subject_test.txt")

tsactiv <- read.table("Insert directory file path/y_test.txt")

test <- cbind(tsdata, tssub, tsactiv)

trdata <- read.table("Insert directory file path/X_train.txt", sep="")

trsub <- read.table("Insert directory file path/subject_train.txt")

tractiv <- read.table("Insert directory file path/y_train.txt")

train <- cbind(trdata, trsub, tractiv)

####1.1. Merge the test and training data sets.

completedata <- rbind(test,train)

####1.2. Extract the mean and standard deviation for each measurement from the merged data sets with the corresponding subject and human activity.

tidydata <- completedata[,c(1:6,121:126,562:563)]

####1.3. Rename the values of the human activity variable.

tidydata$V1.2[tidydata$V1.2==1] <- "Walking"

tidydata$V1.2[tidydata$V1.2==2] <- "Walking upstairs"

tidydata$V1.2[tidydata$V1.2==3] <- "Walking downstairs"

tidydata$V1.2[tidydata$V1.2==4] <- "Sitting"

tidydata$V1.2[tidydata$V1.2==5] <- "Standing"

tidydata$V1.2[tidydata$V1.2==6] <- "Laying"

####1.4. Label the variables with appropriate variable names: 
    Acc/Gyro corresponds to data taken from accelerometer/gyroscope,
    Mean/Std for the average/standard deviation of the target value, 
    X/Y/Z for the axis, 
    id for the corresponding subject and 
    Activity for the human activity.
    
colnames(tidydata) <- c("AccMeanX", "AccMeanY", "AccMeanZ","AccStdX", "AccStdY",
                        "AccStdZ", "GyroMeanX", "GyroMeanY", "GyroMeanZ", "GyroStdX", "GyroStdY",
                        "GyroStdZ", "id", "Activity")

####1.5. Make a new tidy data set with the average of each variable for each activity and each subject.

library(plyr)

tidydata2 <- ddply(tidydata, c("id","Activity"), summarise, MAccMeanX=mean(AccMeanX), 
                   MAccMeanY=mean(AccMeanY), MAccMeanZ=mean(AccMeanZ), MAccStdX=mean(AccStdX), 
                   MAccStdY=mean(AccStdY), MAccStdZ=mean(AccStdZ), MGyroMeanX=mean(GyroMeanX),
                   MGyroMeanY=mean(GyroMeanY), MGyroMeanZ=mean(GyroMeanZ), MGyroStdX=mean(GyroStdX),
                   MGyroStdY=mean(GyroStdY), MGyroStdZ=mean(GyroStdZ))

####Create a text file of the tidy data set: tidydata2.txt.

write.table(tidydata2, file="Insert directory file path/tidydata2.txt", row.names=F

###2. Here are the list of codes and their corresponding descriptions used in the script.

2.1. id = number identification for the subject who participated in the experiment.

2.2. Activity = the human activity (walking, walking upstairs, walking downstairs, sitting, standing, laying) where the subject is engaged in during the experiment.

2.3. AccMeanX/Y/Z = the mean linear acceleration (m/s^2) corresponding to the X/Y/Z axis vector of a subject doing a human activity measured by an accelerometer.

2.4. AccStdX/Y/Z = the standard deviation linear acceleration (m/s^2) corresponding to the X/Y/Z axis vector of a subject doing a human activity measured by an accelerometer.

2.5. GyroMeanX/Y/Z = the mean angular velocity (rad/s) corresponding to the X/Y/Z axis vector of a subject doing a human activity measured by a gyroscope.

2.6. GyroStdX/Y/Z = the standard deviation angular velocity (rad/s) corresponding to the X/Y/Z axis vector of a subject doing a human activity measured by a gyroscope.

2.7. MAccMeanX/Y/Z = the mean of AccMeanX/Y/Z (m/s^2) per subject and human activity.

2.8. MAccStdX/Y/Z = the mean of AccStdX/Y/Z (m/s^2) per subject and human activity.

2.9. MGyroMeanX/Y/Z = the mean of GyroMeanX/Y/Z per subject and human activity.

2.10. MGyroStdX/Y/Z = the mean of GyroStdX/Y/Z per subject and human activity.
