

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


summary(hd)
summary(gii)


colnames(hd)
colnames(gii)

join_by <-c("Country")

#making table
hd_gii <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))

# see the new column names
colnames(hd_gii)

# glimpse at the data
glimpse(hd_gii)

print(nrow(hd_gii))


str(hd_gii)
dim(hd_gii)
colnames(hd_gii)



human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)

# look at the (column) names of human
names(human)

# look at the structure of human
str(human)

# print out summaries of the variables
summary(human)