library(DAAG)
library(stats)

# import data
data <- head.injury

# logistic model
model <- glm(clinically.important.brain.injury~.,data,
              family=binomial(link="logit"))
summary(model)

# probability threshold 0.025 in terms of the linear model:
new_threshold <- log(0.025/(1-0.025))
new_threshold

#needed increment to exceed threshold
increment <- new_threshold-unname(model$coefficients[1])
increment
