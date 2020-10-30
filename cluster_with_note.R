# import library

library(dplyr)# for select
library(cluster)
# install.packages("factoextra")
library(factoextra)
#install.packages("klaR")
library(klaR)# k mode works for categorical data 
library(gridExtra)
#install.packages("tidyverse")
library(tidyverse)
# # install.packages("clustMixType") 
# library(clustMixType) # K proto works for mixed data type
# # install.packages("kpodclustr") for k-pod
# library(kpodclustr) # k-pod is one kind of k-means dealing with missing value; but still work only for numeric data 
# read the csv
Dental_data <- read.csv(
  file="../Cluster/Added_dental_data.csv",
  header=T, as.is=TRUE)



# SEQN number as row names 
var_data = Dental_data[,-1]
row.names(var_data) = Dental_data[,1]
F_Dental_data <- lapply(var_data, factor)
F_Dental_data = as.data.frame(F_Dental_data)
# cluster: A vector of integers indicating the cluster to which each object is allocated.
# size: The number of objects in each cluster.
# modes: A matrix of cluster modes.
# withindiff: The within-cluster simple-matching distance for each cluster
set.seed(123)
wss <- function(k) {
  sum(kmodes(F_Dental_data,modes = k,fast = TRUE)$withindiff)
}
# Compute and plot wss for k = 1 to k = 15
k.values <- 2:15
# extract wss for 2-15 clusters
wss_values <- map_dbl(k.values, wss)
plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total Within cluster simple-matching distance")
# k = 11 min total withindiff 
set.seed(123)
# assign cluster 

F_Dental_data$Cluster = kmodes(F_Dental_data,modes = 11,fast = TRUE)$cluster
row.names(F_Dental_data) = row.names(var_data)

# # cluster for all 
# all_data = Whole_data[,-1]
# row.names(all_data) = Whole_data[,1]
# # assign all column as factor
# F_all_data <- lapply(all_data, factor)
# F_all_data = as.data.frame(F_all_data)
# # assign numeric column as numeric
# F_all_data[,c(847:ncol(all_data))] <- sapply(F_all_data[,c(847:ncol(F_all_data))], as.numeric)
# # remove columns having 10% missing value
# clean_data = F_all_data[, -which(colMeans(is.na(F_all_data)) > 0.1)]
# # remove rows having missing value
# clean_data = na.omit(clean_data)
# # make the all data set from [2432,1039] down size to clean data set [1602,519] 
# row.names(clean_data)
# # class(clean_data[,710])
# ?kproto()
# ?kpod()
# # check class(clean_data[,847])
# set.seed(123)
# wss <- function(k) {
#   kproto(clean_data,k,lamdba = NULL, na.rm= TRUE, keep.data = TRUE)$tot.withinss
# }
# # Compute and plot wss for k = 1 to k = 15
# k.values <- 2:15
# # extract wss for 2-15 clusters
# wss_values <- map_dbl(k.values, wss)
# plot(k.values, wss_values,
#      type="b", pch = 19, frame = FALSE, 
#      xlab="Number of clusters K",
#      ylab="Total Within cluster distance")
# # k = 11 min total withindiff 
# set.seed(123)
# # assign cluster 
# 
# # kproto(clean_data,k = 11,lamdba = NULL, na.rm= TRUE, keep.data = TRUE)$cluster
# 
# clean_data$Cluster = kproto(clean_data,k = 11,lamdba = NULL, na.rm= TRUE, keep.data = TRUE)$cluster
# 
# name_index = as.numeric(row.names(clean_data))
# 
# row.names(clean_data) = row.names(all_data)[name_index]
# 
# # k9 = kpod(clean_data,9,kmpp_flag = TRUE)




# write csv
write.csv(F_Dental_data,file='../Cluster/Added_Cluster_Dental_data.csv')
# write.csv(clean_data,file='../Cluster/clean_data.csv')
