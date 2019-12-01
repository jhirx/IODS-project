# Olli Palmen
# Exercise 5 (26.11.2019)
# Continue data wrangling on the human data from last week


hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the datasets: see the structure and dimensions of the data.
str(hd)

# 195 observations of 8 variables

str(gii)

# 195 observations of 10 variables


# Create summaries of the variables

summary(hd)

summary(gii)

hd_colnames = c("HDI.Rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI.Minus.Rank")

gii_colnames = c("GII.Rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "LFP.F", "LFP.M")

colnames(hd) <- hd_colnames
colnames(gii) <- gii_colnames

# new variable edu2ratio = edu2m/edu2f

gii$Edu2.Ratio = gii$Edu2.F/gii$Edu2.M


# new variable lfpratio = lfpf/lfpm

gii$LFP.Ratio = gii$LFP.F/gii$LFP.M

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("Country")

# join the two datasets by the selected identifiers
human <- inner_join(gii, hd, by = join_by)

# Summary of data
summary(human)

# Dimensions of data
str(human)
head(human)
#195 observations of 19 variables

#write.csv(human, "C:/Users/03158763/Work Folders/human.csv", row.names = FALSE)
#check <- read.table("C:/Users/03158763/Work Folders/human.csv", sep=",", header=TRUE)

##################################################################################################
### Here we continue from last week ####

## Load the 'human' data into R. Explore the structure and the dimensions of the data and describe the dataset briefly

# Dataset includes data included in the Human Development Index (HDI) and Gender Inequliaty Index (GII)

# look at the (column) names of human
names(human)

# GII.Rank - Gender inequality index country rank
# Country - country identifier
# GII - Gender inequality index
# Mat.Mor - Maternal mortality rate
# Ado.Birth - Adolescent fertility rate
# Parli.F - Share of seats in parliament held by women
# Edu2.F - Secondary education (female)
# Edu2.M - Secondary education (male)
# Edu2.Ratio - Ratio of secondary education (female to male)
# LFP.F - Labor force participation rate (Female)
# LFP.M - Labor force participation rate (male)
# LFP.Ratio - Ratio of labor force participation rate (female to male)
# HDI Rank - Human development index country rank
# HDI - Human development index 
# Life.Exp - Life expectancy
# Edu.Exp - Expected education
# Edu.Mean - Average education
# GNI - Gross national income
# GNI - Gross national income
# GNI.Minus.Rank - Gross National Income per capita rank minus Human Development Index rank


# look at the structure of human
str(human)

# 195 obs of 19 variables

# print out summaries of the variables
summary(human)

## Mutate the data: transform the Gross National Income (GNI) variable to numeric

# access the stringr package
library(stringr)

# look at the structure of the GNI column in 'human'
str(human$GNI)

# remove the commas from GNI and print out a numeric version of it
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

# columns to keep

keep <- c("Country", "Edu2.Ratio", "LFP.Ratio", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))

human_

# look at the last 10 observations
tail(human_, 10)

# last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last, ]

# add countries as rownames
rownames(human_) <- human_$Country

# remove the Country variable
human_ <- select(human_, -Country)
human_

write.table(human_, file="data/human.txt", row.names = TRUE)

checkdata = read.table("data/human.csv", header=TRUE, sep=" ")
