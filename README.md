# getting-and-cleaning-data
peer project


1)First list of all 561 variables are taken in the variable in the all_features
2)Then only the mean and the standards are taken and their id,s are selceted and the we get all the features that we want
3)then the train data set is obtained by reading the three files only the values of the features we require are taken and then column binded
4)same thing is applied on test data
5)then both of them are row binded
6)in the final data set all the numbers in activity are replaced with their labels
7)then the data set is melted and remodeled to get mean of every feature of every activity of each subject