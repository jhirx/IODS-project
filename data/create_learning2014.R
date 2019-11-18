# rs 6.11.2019 jouni hirvionen

#metadta
# - https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-meta.txt
# - https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS2-meta.txt

#install.packages("dplyr")


#reading data in
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

 
#download r tools
#https://cran.rstudio.com/bin/windows/Rtools/


# Structure of the data , description taken from Reijo Sund
# Mostly likert scale (1-5) variables
# Includes also Age (positive integers) and gender (as a two level factor: F and M)
# Attitude = Global attitude toward statistics ~Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj
# Points=Exam points (0-33)
dim(lrn14)  #dimension
summary(lrn14) #summary
str(lrn14) #structure

#install.packages("magrittr")install.packages("tidyverse")


#install.packages("qplot")


# here are questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# columns related to deep learning, surface learning and strategic learning
deep_columns <- lrn14 %>% select(one_of(deep_questions))
surface_columns <- lrn14 %>% select(one_of(surface_questions))
strategic_columns <- lrn14 %>% select(one_of(strategic_questions))


# Create column 'attitude' by scaling the column "Attitude"
# Create columns 'deep', 'surf', and 'stra' by averaging
# Exclude observations where the exam point variable is zero
# Select variables gender, age, attitude, deep, stra, surf and points
learning2014 <- lrn14 %>% mutate(
  attitude=Attitude/10,
  deep=rowMeans(deep_columns,na.rm=TRUE),
  surf=rowMeans(surface_columns,na.rm=TRUE),
  stra=rowMeans(strategic_columns,na.rm=TRUE)
) %>%
  filter(Points!=0) %>%
  select(gender, age=Age, attitude, deep, stra, surf, points=Points)

# Change working directory to IODS-folder
setwd("~/IODS-project")

# Save created data to folder 'data' as an csv worksheet
##library(openxlsx)
write.csv(learning2014,file="~/IODS-project/data/learning2014.csv")
#write.csv(learning2014,file="d:/yliopisto/IODS-project/data/learning2014.csv")


# Read the data back to R and check that structure and a few first observations look the same
# install.packages("readxl")
#library(readxl)

readtest <- read.csv("~/IODS-project/data/learning2014.csv")
#readtest <- read.csv("d:/yliopisto//IODS-project/data/learning2014.csv")



str(learning2014) #data in memory
str(readtest) # data on diskdrive


head(learning2014)  #data in memory
head(readtest) # data on diskdrive
