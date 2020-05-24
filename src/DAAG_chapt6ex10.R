---
title: "DAAG_chapt6ex10"
output: html_document
---
##Chapter 6
##Exercise 10

The data frame `table.b3` in the MPV package contains data on gas mileage and other 11 variables for a sample of 32 automobiles.
a) Construct a scatterplot between y (mpg) and x1 (displacement). Is the relationship non-linear?
b) Use the `xyplot()` function, and x11 (type of transmission) as a group variable. Is a linear model reasonable for these data?
c) Fit the model relating y to x1 and x11 which gives two lines having possibly different slopes and intercepts. Check the diagnostics. Are there any influential observation? Are there any influential outliers?
d) Plot the residuals against the variable `x7` (number of transmission speeds), again using x11 as a "group" variable. Is there anything striking about this plot?

##Solution:
a)
```{r setup, include=FALSE}
data(table.b3)
scatterplot(y ~ x1, data=table.b3,
            xlab="Displacement", ylab="mpg",
            main="Scatter Plot of y versus x1")

```
In the scatter plot we observe that with respect to the relationship between y and x1 there are two different behaviours in the dataset.
In particular, we observe a linear behaviour with two different slopes.

b)
```{r setup, include=FALSE}
xyplot(y~x1, data=table.b3,
       group=x11,
       main="displacement vs mpg", xlab="Displacement", ylab="mpg")
```
We observe that, grouping the two variables with respect to the x11-variable (type of transmission), we clearly distinguish the two slopes mentioned in point 1);
the first group (blue colour) is the one with manual type, the other (pink colour) is the manual type.
##Is a linear model reasonable for these data? (da capire)

c)
```{r setup, include=FALSE}
data <- table.b3
model <- lm(y ~ x1+x11+x1:x11, data=table.b3)
par(mfrow=c(2,2))
#plot(model, which=1:4)
#plot(model, 4, id.n=3) ##Cook's distance, i primi 3 valori più alti, probabili ouliers
summary(model) ##Rsquare e Rsquare adjusted

plot(data$x1, data$y, col=data$x11+1)
intercept0 <- unname(model$coefficients[1])
intercept1 <- unname(model$coefficients[1]+model$coefficients[3])
slope0 <- unname(model$coefficients[2])
slope1 <- unname(model$coefficients[2]+model$coefficients[4])
abline(intercept0, slope0)
abline(intercept1, slope1, col=2)
```
Fitting the model relating y to x1 and x11 we obtain two lines having different slopes and intercepts.
Now let's see if there are influential observations and outliers:
```{r setup, include=FALSE}
par(mfrow=c(2,2))
plot(model, which=1:4)

# Influential Observations
# Cook's plot
plot(model, which=4, id.n=3)
# Influence Plot
influencePlot(model, id.method="identify",
              main="Influence Plot")


##are there any influential outliers?
outlierTest(model) # Bonferroni p-value for most extreme obs
qqPlot(model, main="QQ Plot") #qq plot for studentized resid
residuals(model)
##########################
data1 <- table.b3[1:32, ] #original data
data2 <- table.b3[-c(5, 15), ] #data without suspected outliers

# Plot of data with and without suspected outliers.
model.lmr <- lm(y ~ x1+x11+x1:x11, data=data1)
model2.lmr <- lm(y ~ x1+x11+x1:x11, data=data2)
summary(model.lmr)
summary(model2.lmr)
par(mfrow=c(2,2))
plot(model.lmr)
par(mfrow=c(2,2))
plot(model2.lmr)
```
Looking at Cook's plot and influence plot, we observe that there in one clearly influential observation (row 5) and other two potential ones (row 12 and 15).
Plotting the data removing the suspected outliers (row 5 and 15) we conclude that they are effectively outliers.

d)
```{r setup, include=FALSE}
model <- lm(y ~ x1+x11+x1:x11, data=table.b3)
model$residuals

plot(data$x7, model$residuals, col=data$x11+1, pch=data$x11+1)
legend("topright", legend=c("Group 0", "Group 1"),col=c(1,2),
       pch=c(1,2),cex=0.8)
```
Dividing the residuals against variable x7, we discover that the three groups of transmission speeds are well distributed with respect to the variable x11, so that the data with x11=1 (automatic trasmission) are characterized by the lowest transmission speed, while the other type (manual transmission) covers the other two transmission speed.



This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
