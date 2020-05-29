##load packages


library(plyr)
library(data.table)
library(reshape2)


##downloading file and setting it as working directory

download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")
unzip("data.zip")


##getting features
all_features <- fread("UCI HAR Dataset/features.txt",col.names = c("id","features"))
id_wanted <- grep(("mean()|std()"),all_features[,features])
features <- all_features[id_wanted,features]
features<-gsub("[()]","",features)                  

##getting activity label
aclabelS <- fread("UCI HAR Dataset/activity_labels.txt",col.names = c("id","activity"))

##reading train data set

train <- fread("UCI HAR Dataset/train/X_train.txt")
train <- train[,id_wanted,with=FALSE]
data.table::setnames(train, colnames(train), features)
activities<-fread("UCI HAR Dataset/train/Y_train.txt",col.names = "activity")
subjects<-fread("UCI HAR Dataset/train/subject_train.txt",col.names = "subject")
train<- cbind(subjects , activities,train)



##readining test data set

test <- fread("UCI HAR Dataset/test/X_test.txt")
test <- test[,id_wanted,with=FALSE]
data.table::setnames(test, colnames(test), features)
activities2<-fread("UCI HAR Dataset/test/Y_test.txt",col.names = "activity")
subjects2<-fread("UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
test<- cbind(subjects2 , activities2 ,test)


#merging using rowbind

data<-rbind(train,test)

##removing number and adding activity

data[["activity"]]<-factor(data[, activity], levels = aclabelS$id, labels = aclabelS$activity)

data[["subject"]] <- as.factor(data[, subject])

tidy_data<-melt(data = data, id = c("subject", "activity"))
tidy_data<-dcast(data = tidy_data, subject + activity ~ variable, fun.aggregate = mean)

##writing in file
fwrite(x = tidy_data, file = "tidyData.txt", quote = FALSE)


