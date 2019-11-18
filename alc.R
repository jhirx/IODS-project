


alc <- read.table("~/IODS-project/data/alc.txt", sep=",", header=TRUE)
str(alc)

m <- glm(high_use ~ failures + absences + sex, data = alc, family = "binomial")

# print out a summary of the model
summary(m)

# print out the coefficients of the model
coef(m)

library(dplyr); library(ggplot2)

# compute odds ratios (OR)
OR <- coef(m) %>% exp

# compute confidence intervals (CI)
CI <- confint(m) %>% exp

# print out the odds ratios with their confidence intervals
cbind(OR, CI)

#my hypothese

oma <- glm(high_use ~ internet + romantic + sex, data = alc, family = "binomial")

# print out a summary of the model
summary(oma)

# print out the coefficients of the model
coef(oma)


# compute odds ratios (OR)
ORo <- coef(oma) %>% exp

# compute confidence intervals (CI)
CIo <- confint(oma) %>% exp

# print out the odds ratios with their confidence intervals
cbind(ORo, CIo)


# predict() the probability of high_use
probabilities <- predict(oma, type = "response")

# add the predicted probabilities to 'alc'
alc <- mutate(alc, probability = probabilities)

# use the probabilities to make a prediction of high_use
alc <- mutate(alc, prediction = probability > 0.5)

# see the last ten original classes, predicted probabilities, and class predictions
select(alc, failures, absences, sex, high_use, probability, prediction) %>% tail(10)

# tabulate the target variable versus the predictions
table(high_use = alc$high_use, prediction = alc$prediction)

# initialize a plot of 'high_use' versus 'probability' in 'alc'
g <- ggplot(alc, aes(x = probability, y = high_use, col = prediction))

# define the geom as points and draw the plot
g + geom_point()

# tabulate the target variable versus the predictions
table(high_use = alc$high_use, prediction = alc$prediction) %>% prop.table %>% addmargins


# define a loss function (mean prediction error)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}

# call loss_func to compute the average number of wrong predictions in the (training) data
loss_func(class = alc$high_use, prob = 0)

#Cross-validation is a method of testing a predictive model on unseen data. 
#In cross-validation, the value of a penalty (loss) function (mean prediction error)
#is computed on data not used for finding the model. Low value = good.

#Cross-validation gives a good estimate of the actual predictive power of the model. 
#It can also be used to compare different models or classification methods.



# define a loss function (average prediction error)
loss_funca <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}

# compute the average number of wrong predictions in the (training) data
loss_funca(class = alc$high_use, prob = alc$probability)

# K-fold cross-validation
library(boot)
cv <- cv.glm(data = alc, cost = loss_func, glmfit = m, K = 10)

# average number of wrong predictions in the cross validation
cv$delta[1]
