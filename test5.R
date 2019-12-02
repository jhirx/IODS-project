
install.packages('FactoMineR', repos = "http://cloud.r-project.org")
library(FactoMineR)
data(tea)

summary(tea)
str(tea)


library(tidyr)
gather(tea) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar() + theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))



library(dplyr)
keep_columns <- c("Tea", "How", "how", "sugar", "where", "lunch")
# select the 'keep_columns' to create a new dataset
tea_vars <- select(tea, one_of(keep_columns))
head(tea_vars)




# multiple correspondence analysis
mca <- MCA(tea_vars, graph = FALSE)
# summary of the model
summary(mca)



# visualize MCA
plot(mca, invisible=c("ind"), habillage = "quali")

