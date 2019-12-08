# RStudio Exercise 6 data wrangling
# Jouni Hirvonen

# Read the BPRS data
## 40 male subjects were randomly assigned to one of two treatment groups and each subject was rated on the brief psychiatric rating scale (BPRS) measured before treatment began (week 0) and then at weekly intervals for eight weeks. 

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Read the RATS data
## Concerns the nutrition of rats by measuring weight weekly.
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

# Look at the variables of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# print out summaries of the variables
summary(BPRS)

# Look at the variables of RATS
names(RATS)

# Look at the structure of RATS
str(RATS)

# print out summaries of the variables
summary(RATS)

# Look at the data

head(RATS)
head(BPRS)

# Wide form data gives a good overview of the the data, where each value is assigned as their own variable.

# Change categorical values to factors in RATS data

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Change categorical values to factors in RATS data

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)



### CONVERT TO LONG FORM

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)


# Convert BPRS to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Convert RATS to long form
RATSL <-  RATS %>% gather(key = days, value = Weight, -ID, -Group)


# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Extract the week number
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(days,3,4)))

BPRSL <- select (BPRSL,-weeks)
RATSL <- select (RATSL,-days)
RATSL <- select (RATSL,ID, Group,Time,Weight)
BPRSL <- select (BPRSL,subject, treatment,Week,bprs)


# Take a glimpse at the BPRSL data

# Look at the subjects 1,2 from Group 1:
arrange(filter(RATSL,Group==1 & ID==c(1,2)), ID)

# Look at the subjects 1,2 from Group 1:
arrange(filter(BPRSL,treatment==1 & subject==c(1,2)), subject)

# Longitudinal data is usually arranged in long form to make the analysis easier, although data is easier to read in wide format.

write.table(BPRSL, "data/BPRSL.txt", col.names = TRUE)
write.table(RATSL, "data/RATSL.txt", col.names = TRUE)

## Check that the data is ok.

str(read.table("data/BPRSL.txt", header=TRUE))
str(read.table("data/RATSL.txt", header=TRUE))