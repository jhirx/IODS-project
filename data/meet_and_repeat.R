# RStudio Exercise 6 data wrangling
# Jouni Hirvonen

# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Read the RATS data
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

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Change categorical values to factors in RATS data

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Change categorical values to factors in RATS data

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)



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


# Look at the subjects 1,2 from Group 1:
arrange(filter(RATSL,Group==1 & ID==c(1,2)), ID)

# Look at the subjects 1,2 from Group 1:
arrange(filter(BPRSL,treatment==1 & subject==c(1,2)), subject)


write.table(BPRSL, "data/BPRSL.txt", col.names = TRUE)
write.table(RATSL, "data/RATSL.txt", col.names = TRUE)

## Check the data. 

str(read.table("data/BPRSL.txt", header=TRUE))
str(read.table("data/RATSL.txt", header=TRUE))