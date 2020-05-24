set.seed(2)

# simulate data from a poisson(exp{2-4x})
x <- seq(0,1,length=101)
data1 <- poissonsim(x,a=2,b=-4)

# fit a poisson regression model 
poisson_model <- glm(y~x,data1,family=poisson(link="log"))
summary(poisson_model)

# compare the true model and the fitted one on new data
new_data <- poissonsim(x,a=2,b=-4,seed=7)

set.seed(7) #change seed
predictions <- predict(poisson_model,newdata=new_data,type="response")
plot(x,new_data[,2],main="True vs Fitted model on new data",xlab="x",ylab="y")
lines(x,predictions,col=2,lwd=2)
legend("topright",legend=c("true values","fitted model"),
       col=c(1,2),lty=c(NA,1),pch=c(1,NA),lwd=c(NA,2))
