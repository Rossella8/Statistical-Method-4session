---
title: "DAAG_ex6chapt6"
output: pdf_document
---

---
title: "HomeWork4"
output: pdf_document
---
##Chapter 6
##Exercise 6
The following investigates the consequences of not using a logarithmic transformation for the `nihills` data analysis. The second differs from the dirst in having a `distxclimb` interaction term, additional to linear terms in `dist` and `climb`.
1) Fit the two models
`nihills.lm <- lm(time ~ dist+climb, data=nihills)`
`nihills2.lm <- lm(time ~ dist+climb+dist:climb, data=nihills)`
2) Using the F-test result, make a tentative choice of model. and procede to examine the diagnostic plots. Are there any problematic observations? What happens if these points are removed? Refit both of the above models, and check the diagnostics again.

##Solution:
```{r setup, include=FALSE}
install.packages("DAAG")
library(DAAG)

nihills.lm.one <- lm(time ~ dist, data = nihills)
nihills.lm <- lm(time ~ dist+climb, data=nihills)
nihills2.lm <- lm(time ~ dist+climb+dist:climb, data=nihills)
summary(nihills.lm)
summary(nihills2.lm)
```
According to the F-test, we can't establish wich model is the best, having both the same p-value.
```{r setup, include=FALSE}
par(mfrow=c(2,2))
plot(nihills.lm, which=1:4)
summary(nihills.lm, corr=TRUE)
residuals(nihills.lm)

par(mfrow=c(2,2))
plot(nihills2.lm, which=1:4)
summary(nihills2.lm, corr=TRUE)
residuals(nihills2.lm)
```
Computing the residuals we get that the residuals of nihills2.lm results to be smaller that the ones of nihills.lm; through `anova` and `summary`, we observe the F-test results; in particular, $R^2$ and $R^2$ adjusted bring us to prefer `nihills2.lm` to `nihills.lm`.
Moreover, checking the diagnostics (in particular from the Cook's distance plot) we can suspect that Seven Seven is a potential outlier for both nihills.lm and nihills2.lm; let's try to remove it and refit the models:
```{r setup, include=FALSE}
myData <- nihills[-c(19), ]
nihills.lmr <- lm(time ~ dist+climb, data=myData)
nihills2.lmr <- lm(time ~ dist+climb+dist:climb, data=myData)
summary(nihills.lmr)
summary(nihills2.lmr)
par(mfrow=c(2,2))
plot(nihills.lmr, which=1:4)
par(mfrow=c(2,2))
plot(nihills2.lmr, which=1:4)
```
##(ulteriori commenti sull'ultima parte)

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
