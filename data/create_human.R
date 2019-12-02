

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

colnames(hd_gii)

#Change collumn names
colnames(hd_gii)[colnames(hd_gii)=="Human.Development.Index..HDI."] <- "HDI.index"
colnames(hd_gii)[colnames(hd_gii)=="Life.Expectancy.at.Birth"] <- "Life.expect"
colnames(hd_gii)[colnames(hd_gii)=="Expected.Years.of.Education"] <- "Exp.yrs.Edu"
colnames(hd_gii)[colnames(hd_gii)=="Mean.Years.of.Education"] <- "Mean.yrs.Edu"
colnames(hd_gii)[colnames(hd_gii)=="Gross.National.Income..GNI..per.Capita"] <- "Grs.Nat.income.Cap"
colnames(hd_gii)[colnames(hd_gii)=="GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNi.minus.HDI"
colnames(hd_gii)[colnames(hd_gii)=="Gender.Inequality.Index..GII."] <- "GII"
colnames(hd_gii)[colnames(hd_gii)=="Maternal.Mortality.Ratio"] <- "Mat.Mor"
colnames(hd_gii)[colnames(hd_gii)=="Adolescent.Birth.Rate"] <- "Ado.Birth"
colnames(hd_gii)[colnames(hd_gii)=="Percent.Representation.in.Parliament" ] <- "Parli.F"
colnames(hd_gii)[colnames(hd_gii)=="Population.with.Secondary.Education..Female."] <- "Edu2.F"
colnames(hd_gii)[colnames(hd_gii)=="Population.with.Secondary.Education..Male."] <- "Edu2.M" 
colnames(hd_gii)[colnames(hd_gii)=="Labour.Force.Participation.Rate..Female."] <- "Labo.F"
colnames(hd_gii)[colnames(hd_gii)=="Labour.Force.Participation.Rate..Male."] <- "Labo.M"


#Mutate the “Gender inequality” data and create two new variables. 
#The first one should be the ratio of Female and Male populations with secondary education in each country. 
#(i.e. edu2F / edu2M). The second new variable should be the ratio of labour force participation of females and males in each country
#(i.e. labF / labM).
hd_gii <- mutate(hd_gii, Edu2.FM = Edu2.F/Edu2.M)
hd_gii <- mutate(hd_gii, Labo.FM = Labo.F/Labo.M)


dim(hd_gii)
#195 observations and 19 variables.

write.csv(hd_gii,file="~/IODS-project/data/human1.csv")

# I wrote different names of collums so i load data ready made data
human = read.table("data/human1.txt", header=TRUE, sep=",")


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
