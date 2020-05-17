x_n <- seq(-10, 10, length=1000)
y_n <- dnorm(x_n, mean=1, sd=2)
plot(x_n, y_n, type="l", lwd=2, col='blue')
