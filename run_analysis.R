#Read and download to R the Human Activity Recognition Using Smartphones Data from local files.

tsdata <- read.table("Insert directory file path/X_test.txt", sep="")
tssub <- read.table("Insert directory file path/subject_test.txt")
tsactiv <- read.table("Insert directory file path/y_test.txt")
test <- cbind(tsdata, tssub, tsactiv)

trdata <- read.table("Insert directory file path/X_train.txt", sep="")
trsub <- read.table("Insert directory file path/subject_train.txt")
tractiv <- read.table("Insert directory file path/y_train.txt")
train <- cbind(trdata, trsub, tractiv)

#Merge the test and training data sets.
completedata <- rbind(test,train)

#Extract the measurements on the mean and standard deviation for each measurement taken from the accelerometer and gyroscope 3-axial raw signals (X,Y,Z) with the corresponding subject and activity.
tidydata <- completedata[,c(1:6,121:126,562:563)]

#Rename the values of the human activity variable: 1 for Walking...6 for Laying.
tidydata$V1.2[tidydata$V1.2==1] <- "Walking"
tidydata$V1.2[tidydata$V1.2==2] <- "Walking upstairs"
tidydata$V1.2[tidydata$V1.2==3] <- "Walking downstairs"
tidydata$V1.2[tidydata$V1.2==4] <- "Sitting"
tidydata$V1.2[tidydata$V1.2==5] <- "Standing"
tidydata$V1.2[tidydata$V1.2==6] <- "Laying"

#Label the variables with appropriate variable names: 
#Acc/Gyro corresponds to data taken from accelerometer/gyroscope,
#Mean/Std for the average/standard deviation of the target value, 
#X/Y/Z for the axis, 
#id for the corresponding subject and 
#Activity for the human activity.
colnames(tidydata) <- c("AccMeanX", "AccMeanY", "AccMeanZ","AccStdX", "AccStdY",
                        "AccStdZ", "GyroMeanX", "GyroMeanY", "GyroMeanZ", "GyroStdX", "GyroStdY",
                        "GyroStdZ", "id", "Activity")

#Make a new tidy data set with the average of each variable for each activity and each subject.
library(plyr)
tidydata2 <- ddply(tidydata, c("id","Activity"), summarise, MAccMeanX=mean(AccMeanX), 
                   MAccMeanY=mean(AccMeanY), MAccMeanZ=mean(AccMeanZ), MAccStdX=mean(AccStdX), 
                   MAccStdY=mean(AccStdY), MAccStdZ=mean(AccStdZ), MGyroMeanX=mean(GyroMeanX),
                   MGyroMeanY=mean(GyroMeanY), MGyroMeanZ=mean(GyroMeanZ), MGyroStdX=mean(GyroStdX),
                   MGyroStdY=mean(GyroStdY), MGyroStdZ=mean(GyroStdZ))

#Create a text file regarding the tidy data set: tidydata2.txt.
write.table(tidydata2, file="Insert directory file path/tidydata2.txt", row.names=FALSE)
