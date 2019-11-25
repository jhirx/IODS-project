

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

#hd_gii2 <- hd_gii %>% mutate(HDI=Human.Development.Index..HDI.)

hd_gii <- mutate(hd_gii, Edu2.FM = Edu2.F/Edu2.M)
hd_gii <- mutate(hd_gii, Labo.FM = Labo.F/Labo.M)

write.csv(hd_gii,file="~/IODS-project/data/hd_gii_table.csv")