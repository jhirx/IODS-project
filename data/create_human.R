

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


colnames(hd_gii)[colnames(hd_gii)=="Human.Development.Index..HDI."] <- "HDI.index"
colnames(hd_gii)[colnames(hd_gii)=="Life.Expectancy.at.Birth"] <- "Life.expect"
colnames(hd_gii)[colnames(hd_gii)=="Expected.Years.of.Education"] <- "Exp.yrs.Edu"
colnames(hd_gii)[colnames(hd_gii)=="Mean.Years.of.Education"] <- "Mean.yrs.Edu"
colnames(hd_gii)[colnames(hd_gii)=="Gross.National.Income..GNI..per.Capita"] <- "Grs.Nat.income.Cap"
colnames(hd_gii)[colnames(hd_gii)=="GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNi.minus.HDI"
 

#hd_gii2 <- hd_gii %>% mutate(HDI=Human.Development.Index..HDI.)


human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)

# look at the (column) names of human
names(human)

# look at the structure of human
str(human)

# print out summaries of the variables
summary(human)