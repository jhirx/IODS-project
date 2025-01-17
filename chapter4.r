
library(tidyr)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(plotly)
library(MASS)

#install.packages("plotly")



#Read data from data :




# load the data
data("Boston")
str(Boston)

#Data has  14 variables and 506 observations

#Glimpse at the boston data

glimpse(Boston) 


#Do some pairs 

pairs(Boston)


#And then drawing a bar plot of each variable

#message=FALSE, warning=FALSE, fig.width=12, fig.height=10}
gather(Boston) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()


#Scaling data first take Boston data and summaraised it


summary(Boston)


#Then  scaling so we can compare data

# center and standardize variables
boston_scaled <- scale(Boston)

# summaries of the scaled variables
summary(boston_scaled)


#We can see all values has change in same scale


# class of the boston_scaled object
class(boston_scaled)

# change the object to data frame
boston_scaled <- as.data.frame(boston_scaled)

summary(boston_scaled$crim)


#Then we create a categorical variable of the crime rate in the Boston dataset (from the scaled crime rate).


# create a quantile vector of crim and print it
bins <- quantile(boston_scaled$crim)


#We use the quantiles as the break points in the categorical variable. 


bins


#Next 

# create a categorical variable 'crime'
crime <- cut(boston_scaled$crim, breaks = bins, include.lowest = TRUE, labels = c("low", "med_low", "med_high", "high"))

# look at the table of the new factor crime
table(crime)



#As asked, drop the old crime rate variable from the dataset. 
#choose randomly 80% of the rows and then we create sets Train and test
#Last we divide the dataset to train and test sets, so that 80% of the data belongs to the train set.
#number of rows in the Boston dataset 


boston_scaled <- dplyr::select(boston_scaled, -crim)
boston_scaled <- data.frame(boston_scaled, crime)

n <- nrow(boston_scaled)

ind <- sample(n,  size = n * 0.8)

# create train set
train <- boston_scaled[ind,]

# create test set 
test <- boston_scaled[-ind,]

# save the correct classes from test data
correct_classes <- test$crime

# remove the crime variable from test data
test <- dplyr::select(test, -crime)



#Fit the linear discriminant analysis on the train set. Use the categorical crime rate as the target variable and all the other variables in the dataset as predictor variables. Draw the LDA (bi)plot. 


# linear discriminant analysis
lda.fit <- lda(crime ~ ., data = train)

# print the lda.fit object
lda.fit

# the function for lda biplot arrows
lda.arrows <- function(x, myscale = 1, arrow_heads = 0.1, color = "orange", tex = 0.75, choices = c(1,2)){
  heads <- coef(x)
  arrows(x0 = 0, y0 = 0, 
         x1 = myscale * heads[,choices[1]], 
         y1 = myscale * heads[,choices[2]], col=color, length = arrow_heads)
  text(myscale * heads[,choices], labels = row.names(heads), 
       cex = tex, col=color, pos=3)
}

# target classes as numeric
classes <- as.numeric(train$crime)

# plot the lda results
plot(lda.fit, dimen = 2, col = classes, pch = classes)
lda.arrows(lda.fit, myscale = 1)



# predict classes with test data
lda.pred <- predict(lda.fit, newdata = test)

# cross tabulate the results
table(correct = correct_classes, predicted = lda.pred$class)

#Similarity or dissimilarity of objects can be measured with distance measures. There are many different measures for different types of data.

library(MASS)
data('Boston')

# euclidean distance matrix
dist_eu <- dist(Boston)

# look at the summary of the distances
summary(dist_eu)

# manhattan distance matrix
dist_man <- dist(Boston, method = 'manhattan')

# look at the summary of the distances
summary(dist_man)

# k-means clustering
km <-kmeans(Boston, centers = 3)

# plot the Boston dataset with clusters
pairs(Boston, col = km$cluster)


set.seed(123)

# determine the number of clusters
k_max <- 10

# calculate the total within sum of squares
twcss <- sapply(1:k_max, function(k){kmeans(Boston, k)$tot.withinss})

# visualize the results
qplot(x = 1:k_max, y = twcss, geom = 'line')

# in plot we can see we need only 2 clusters 

# k-means clustering
km <-kmeans(Boston, centers = 2)

# plot the Boston dataset with clusters
pairs(Boston, col = km$cluster)


#Extra

model_predictors <- dplyr::select(train, -crime)

# check the dimensions
dim(model_predictors)
dim(lda.fit$scaling)

# matrix multiplication
matrix_product <- as.matrix(model_predictors) %*% lda.fit$scaling
matrix_product <- as.data.frame(matrix_product)

install.packages("plotly")

plot_ly(x = matrix_product$LD1, y = matrix_product$LD2, z = matrix_product$LD3, type= 'scatter3d', mode='markers')