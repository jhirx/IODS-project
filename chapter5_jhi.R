git config


install.packages("corrplot")
install.packages("corrplot")
install.packages("dplyr")

library(GGally)
library(corrplot)
library(dplyr)

human = read.table("data/human2.txt", header=TRUE, sep=",")


summary(human)
ggpairs(human)
