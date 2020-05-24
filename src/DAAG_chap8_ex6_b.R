set.seed(0)
# simulate data from a poisson(exp{2-bx}) where b~N(4,5)
data2 <- poissonsim(x,a=2,b=-4,slope.sd=4)
mean(data2[,2])
var(data2[,2])

# poisson regression model
pois_model <- glm(y~x,data2,family=poisson(link="log"))
summary(pois_model) 

#quasipoisson regression model
quasi_pois_model <- glm(y~x,data2,family=quasipoisson)
summary(quasi_pois_model)
