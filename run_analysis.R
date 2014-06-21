# url of the data
url<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
# name of the loca file
dest_file<-'data.zip'
# download the data in the data.zip
download.file(url,dest_file, method = 'curl')
#read activities and 4 Appropriately labels the data set with descriptive variable names.
lb<-read.table("./UCI HAR Dataset/activity_labels.txt")
names(lb)<-c('id','activity')
#head(lb,n=3)
#read features and 4 Appropriately labels the data set with descriptive variable names.
ft<-read.table("./UCI HAR Dataset/features.txt")
names(ft)<-c('id','features')
#read subjects test and 4 Appropriately labels the data set with descriptive variable names.
ste <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(ste)<-c('subject')
#head(st,n=3)
# read X test and 4 Appropriately labels the data set with descriptive variable names.
x_te <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(x_te)<-ft$features
# read y test and 4 Appropriately labels the data set with descriptive variable names.
y_te <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(y_te)<-c('activity')
#######################################
#read subjects train and 4 Appropriately labels the data set with descriptive variable names. 
str <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(str)<-c('subject')
#read subjects train and 4 Appropriately labels the data set with descriptive variable names.
x_tr <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(x_tr)<-ft$features
#read subjects train and 4 Appropriately labels the data set with descriptive variable names.
y_tr <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(y_tr)<-c('activity')

# 1 Merges the training and the test sets to create one data set.
x_total=rbind(x_te,x_tr)
y_total=rbind(y_te,y_tr)
s_total=rbind(ste,str)
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
x_total <- x_total[, grep('mean|std', ft$features)]
##head(x_total,n=5)
# 4 Uses descriptive activity names to name the activities in the data set
y_total$activity<-lb[y_total$activity,]$activity
##head(y_total,n=100)

tidy <- cbind(s_total, y_total, x_total)
#write.csv(tidy, 'final_tidy_data.csv')

tidy_mean <- aggregate(tidy[, 3:dim(tidy)[2]],list(tidy$subject,tidy$activity),mean)
names(tidy_mean)[1:2] <- c('subject', 'activity')
head(tidy_mean)
write.table(tidy_mean, 'tidy_mean.txt')
##write.csv(tidy_mean, 'tidy_mean.csv')