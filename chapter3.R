# rs 17.11.2019 jouni hirvionen

#metadta

#ja tähän sitten koodi kommentoituna

#install.packages("dplyr")




#luetaan data sisään, read data in 
#readin data in
#d1=read.table("d:/yliopisto/IODS-project/data/student-mat.csv",sep=";",header=TRUE)
#d2=read.table("d:/yliopisto/IODS-project/data/student-por.csv",sep=";",header=TRUE)

#=merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))
#readtest <- read.csv("~/IODS-project/data/learning2014.csv")



#first test
# home readtest <- read.csv("d:/yliopisto/IODS-project/data/student-mat.csv",sep=";",header=TRUE)
readtest <- read.csv("~/IODS-project/data/student-mat.csv",sep=";",header=TRUE)

str(readtest)

readtest2 <- read.csv("~/IODS-project/data/student-por.csv",sep=";",header=TRUE)
str(readtest2)

#readin data in
math <- read.table("~/IODS-project/data/student-mat.csv",sep=";",header=TRUE)
por <- read.table("~/IODS-project/data/student-por.csv",sep=";",header=TRUE)

colnames(math)
colnames(por)


library(dplyr)

join_by <-c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

#making table
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# see the new column names
colnames(math_por)

# glimpse at the data
glimpse(math_por)



print(nrow(math_por)) # 382 students
#testing data
str(math_por)
dim(math_por)
colnames(math_po)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
 
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

glimpse(alc)

#avarage of alcohoil consumpition

# access the 'tidyverse' packages dplyr and ggplot2
library(ggplot2)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill = sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(alc, aes(high_use))

# draw a bar plot of high_use by sex
g2 + facet_wrap("sex") + geom_bar()

glimpse(alc)
#Observations: 382
#Variables: 35

write.csv(alc,file="~/IODS-project/data/alc_table.csv")

