library(MPV)
library(lattice)

#a
plot(y ~ x1, data=table.b3)

#b
xyplot(y ~ x1, group=x11, data=table.b3)

#c
b3.lm <- lm(y ~ x1*x11, data=table.b3)
par(mfrow=c(1,4), pty="s")
plot(b3.lm)

#d
xyplot(resid(b3.lm) ~ x7, group=x11, data=table.b3)
