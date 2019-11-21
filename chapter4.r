
library(tidyr)
library(dplyr)
library(ggplot2)
library(gridExtra)



Read data from data :
  
  
library(MASS)

# load the data
data("Boston")
str(Boston)

Data has  14 variables and 506 observations

Glimpse at the boston data

glimpse(Boston) 


Do some pairs 

pairs(Boston)


And then drawing a bar plot of each variable

 message=FALSE, warning=FALSE, fig.width=12, fig.height=10}
gather(Boston) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()


Scaling data first take Boston data and summaraised it


summary(Boston)


Then  scaling so we can compare data

# center and standardize variables
boston_scaled <- scale(Boston)

# summaries of the scaled variables
summary(boston_scaled)


We can see all values has change in same scale


# class of the boston_scaled object
class(boston_scaled)

# change the object to data frame
boston_scaled <- as.data.frame(boston_scaled)


Then we create a categorical variable of the crime rate in the Boston dataset (from the scaled crime rate).


# create a quantile vector of crim and print it
bins <- quantile(boston_scaled$crim)


We use the quantiles as the break points in the categorical variable. 


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

