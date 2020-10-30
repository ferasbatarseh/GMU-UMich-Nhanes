# import library

# install.packages('RSQLite')
# install.packages('DBI')
library(RSQLite)# for SQLite database
library(DBI)# for Database connect
library(dplyr)# for select
library(mice)# data imputation  
library(DescTools)# Measures of Association for Nominal Variables Cramer¡¦s V
# read the csv
# Data0 <- read.csv(
#   file="../NewData/newPredVar.csv",
#   header=T, as.is=TRUE, na.strings = "NULL")
# Var0 <- read.csv(
#   file="../NewData/newVarables.csv",
#   header=T, as.is=TRUE, na.strings = "NULL")

# Var1 = data.frame()
# Var1 = Var0[-1,]
# for (i in (1:ncol(Var0))){
#   names(Var1)[i] = Var0[1,i]
# }
# Var3 = select(Var1,c(1,2,3,4,5))

# names_freq <- as.data.frame(table(names(Var0)))
# names_freq[names_freq$Freq > 1, ]

# db
con <- dbConnect(RSQLite::SQLite(), dbname = "../Database/new.db")
# # drop table
# dbRemoveTable(con,"Data")
# dbRemoveTable(con,"Var")
# # # # write table
# dbWriteTable(con,"Data",Data0)
# # # # write table
# dbWriteTable(con,"Var",Var0)
# check table
dbListTables(con)
# check column name
# dbListFields(con, name = "Data")
# check data in table
# get data from table

# make loop for all 

# take column name
dataname = dbListFields(con, name = "Data")
# count columns
dataname = as.list(dataname)
class(dataname)
length(dataname)
CC_name = data.frame()
CC_value = data.frame()
result_total = data.frame()
pred_res_total = data.frame()
# length(dataname)
# factordata-592
# find cc for each var column by column
# then use the columns with whose cc is greater than 0.7 and no more than 90% NULL to predict the data
for (i in 2:length(dataname)) {
  # make statements
  statement = "SELECT Data."
  statement = paste0(statement, dataname[i],", Var.* FROM Data, Var WHERE Data.SEQN = Var.SEQN")
  statement
  # make pred statements LEFT JOIN
  statementforpred = "SELECT Data."
  statementforpred = paste0(statementforpred, dataname[i],", Var.* FROM Var LEFT JOIN Data ON Data.SEQN = Var.SEQN")
  statementforpred
  # tab0 for prediction 
  tab0 = dbGetQuery(con, statement = statementforpred) # for prediction data and varable data with all SEQN 73564 to 93547
  # remove extact same columns 332,693,890,895
  # remove string data 145 SMD100BR
  # only take pred
  predtable = select(tab0,-c(1,2)) # for varable data with all SEQN 73564 to 93547
  # assign as numeric
  predtable[,c(1:ncol(predtable))] <- sapply(predtable[,c(1:ncol(predtable))], as.numeric)
  predtable[,c(1:592)] <- sapply(predtable[,c(1:592)], as.factor)
  # tab1 for prediction data and variable data from SEQN 73564 to 83723 
  # get var and data
  tab1 = dbGetQuery(con, statement = statement)
  # take the predicting SEQN from SEQN 83757 to 93547
  r = nrow(tab1)+1
  Seqn = tab0[r:nrow(tab0),2]
  # only take var
  tab2 <- select(tab1,-c(1,2))
  # make var to numeric
  tab2[,c(1:ncol(tab2))] <- sapply(tab2[,c(1:ncol(tab2))], as.numeric)
  conti_table = data.frame() # for conti
  clean_tab2 = data.frame() # for factor
  ## Remove columns with more than 90% NA
  clean_tab2 = select(tab2,1:592)
  conti_table = select(tab2,593:ncol(tab2))
  clean_tab2 = clean_tab2[, -which(colMeans(is.na(clean_tab2)) > 0.9)]
  conti_table = conti_table[, -which(colMeans(is.na(conti_table)) > 0.9)]
  # make var to factor
  clean_tab2 <- lapply( clean_tab2, factor)
  # find cor
  # make var to factor
  PV = as.factor(tab1[,1])
  # find cor for FACTOR
  res_factor = sapply(clean_tab2, function(x, y) CramerV(x,y), y=PV)
  res_factor = as.data.frame(res_factor)
  colnames(res_factor)= dataname[i]
  test1 = subset(res_factor, (res_factor[,1]) >= 0.5)
  test1 = subset(test1, (test1[,1]) != Inf)
  # get the selected columns with cc >= 0.5
  if (nrow(test1) > 3){cor_res = subset(res_factor, (res_factor[,1]) >= 0.5)} else {cor_res = subset(res_factor, (res_factor[,1]) >= 0.3)}
  cor_res = subset(cor_res, (cor_res[,1]) != Inf)
  
  # find cor for conti
  
  res_Conti = sapply(conti_table, function(x, y) summary(lm(x~y))$r.squared, y=PV)
  res_Conti = sqrt(res_Conti)
  res_Conti = as.data.frame(res_Conti)
  colnames(res_Conti)= dataname[i]
  Conti_res = subset(res_Conti, (res_Conti[,1]) >= 0.5)
  
  # combine factor and numeric cor result
  combine_cor_res = rbind(cor_res,Conti_res)
  # make input table with above selected columns
  inputdata = data.frame()
  inputdata = select(predtable,rownames(combine_cor_res))
  #colSums(is.na(inputdata))
  if (ncol(inputdata) >= 10){inputdata = inputdata[, -which(colSums(is.na(inputdata)) > 130)]}
  # inputdata2 = data.frame()
  # inputdata2 = inputdata[, -which(colMeans(is.na(inputdata)) > 0.5)]
  # which(colMeans(is.na(inputdata)) > 0.5)
  # take input data and column we want to predict
  inputdata = cbind(tab0[,1], inputdata)
  # name the column we want to predict as pred
  colnames(inputdata)[1] <- 'pred'
  # assign pred as factor to make sure the prediction will match the data we already have (not over the boundary or new data point)
  inputdata[,1] = as.factor(inputdata[,1])
  colnames(inputdata)
  # Define arbitrary matrix with TRUE values when data is missing and FALSE otherwise
  A <- is.na(inputdata)
  # Replace all the other columns which are not imputed with FALSE
  A[,-1] <- FALSE # FALSE for all variables
  A[1:nrow(tab1),1] <- FALSE # FALSE for SEQN 73564 to 83723 prediction data we already had
  # Run the mice function
  imputed_data <- mice(inputdata, where = A, m = 2,seed=1234)
  # # fix columns with collinear
  # outlist = imputed_data$loggedEvents$out
  # outlist = as.character(outlist)
  # # remove the columns with collinear
  # newinputdata = select(inputdata,-outlist)
  # # re apply the mice
  # M <- is.na(newinputdata)
  # # Replace all the other columns which are not imputed with FALSE
  # M[,-1] <- FALSE
  # M[1:nrow(tab1),1] <- FALSE
  # # Run the mice function
  # new_imputed_data <- mice(newinputdata,where = M, m = 1,seed=1234)
  # get the completed data
  completedData <- complete(imputed_data,2)
  # get the rows with predicted data
  Final_Pred = completedData[r:nrow(tab0),1]
  Final_Pred = as.data.frame(Final_Pred)
  colnames(Final_Pred) = dataname[i]
  row.names(Final_Pred) = Seqn
  for_bind_table = t(Final_Pred)
  for_bind_table = as.data.frame(for_bind_table)
  # get the final pred table
  pred_res_total <- rbind(pred_res_total,for_bind_table)
  # # record the cc
  # result = as.data.frame(combine_cor_res)
  # result = as.data.frame(t(result))
  # result_total <- rbind(result_total,result)
  # record the cc
  Final_cor_res = select(as.data.frame(t(combine_cor_res)),colnames(inputdata[,-1]))
  t_Final_cor_res = as.data.frame(t(Final_cor_res))
  t_order_Final_cor_res = as.data.frame(t_Final_cor_res[order(-t_Final_cor_res[,1]),])
  row.names(t_order_Final_cor_res) = row.names(t_Final_cor_res)[order(-t_Final_cor_res[,1])]
  x = i-1
  CC_name[1:nrow(t_order_Final_cor_res),x] = row.names(t_order_Final_cor_res)
  CC_value[1:nrow(t_order_Final_cor_res),x] = (t_order_Final_cor_res)[1:nrow(t_order_Final_cor_res),1]
  names(CC_name)[x] = dataname[i]
  names(CC_value)[x]= dataname[i]
  print(i)
}
#cc result_total
# row.names(result_total)=dataname[2:length(dataname)]
# final_cc_result = t(result_total)
# final_cc_result = as.data.frame(final_cc_result)
#prediction result
final_pred_res_total = t(pred_res_total)
final_pred_res_total = as.data.frame(final_pred_res_total)
#combine CCname and CCvalue
CC_Name_N_Value = data.frame()
n = 2*ncol(CC_name)
for (i in 1:n){
  if (i%%2==0){
    x = i/2
    CC_Name_N_Value[1:nrow(CC_value),i] = CC_value[1:nrow(CC_value),x]
    names(CC_Name_N_Value)[i] = colnames(CC_value[x])
  } else {
    x = (i+1)/2
    CC_Name_N_Value[1:nrow(CC_name),i] = CC_name[1:nrow(CC_name),x]
    names(CC_Name_N_Value)[i] = x
  }
}
# write csv
write.csv(CC_Name_N_Value,file='../NewData/CC_Name_N_Value.csv')
#write.csv(final_cc_result,file='../NewData/correlation-coefficient.csv')
write.csv(final_pred_res_total,file='../NewData/completed-prediction.csv')

# disconnect
dbDisconnect(con)
