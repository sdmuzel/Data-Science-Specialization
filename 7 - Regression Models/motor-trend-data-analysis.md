---
title: "Regression Models Course Project"
output:
  pdf_document: default
  keep_md: yes
  html_document:
    df_print: paged
---
### EXECUTIVE SUMMARY
In this report, we will examine the mtcars data set and explore how miles per gallon (MPG) is affected by different variables. In particularly, we will answer the following two questions: 
 - 1 - Is an automatic or manual transmission better for MPG, and 
 - 2 - Quantify the MPG difference between automatic and manual transmissions.


Load the mtcars dataset and display the internal structure of the variables.
```{r}
knitr::opts_chunk$set(echo = TRUE, fig.path = 'figures/')
library(ggplot2)
data(mtcars)
head (mtcars, 1)
```
### EXPLORATORY DATA ANALYSIS
Perform some basic exploratory and inferential data analysis of the data to
study the relationship between transmission type (manual or automatic) and
automobile fuel consumption in miles per gallon (MPG).
```{r}
by(data = mtcars$mpg,
   INDICES = list(factor(mtcars$am, labels = c("Automatic", "Manual"))), summary)
```
#### Impact of Transmission Type on Fuel Consumption
FigureS A.1 in the Appendix section plot the relationship between transmission type
and fuel consumption in automobiles.

### REGRESSION ANALYSIS
Let’s now test this hypothesis with a Simple Linear Regression Test. 
```{r}
singleModelFit <- lm(mpg ~ am, data = mtcars)
summary(singleModelFit)
```
The p-value is less than 0.0003, so we will not reject the hypothesis. However, the R-squared value for this test is only ~= .35, suggesting that only a third or so of variance in MPG can be attributed to transmission type alone. 
Let’s perform an Analysis of Variance for the data

```{r}
T_variance_analysis <- aov(mpg ~ ., data = mtcars)
summary(T_variance_analysis)
```
```{r}
T_multivar <- lm(mpg ~ cyl + disp + wt + am, data = mtcars)
summary(T_multivar)
```
From the above Analysis of Variance, we can look for p-values of less than 0.5. 
This gives us cyl, disp, and wt to consider in addition to transmission type (am)
```{r}
T_multivar <- lm(mpg ~ cyl + disp + wt + am, data = mtcars)
summary(T_multivar)
```
This Multivariable Regression test now gives us an R-squared value of over .83, suggesting that 83% or more of variance can be explained by the multivariable model. P-values for cyl (number of cylinders) and weight are below 0.5, suggesting that these are confounding variables in the relation between car Transmission Type and Miles per Gallon.

### ANALYSIS OF RESIDUALS 
 Figures A.2
The “Residuals vs Fitted” plot here shows us that the residuals are homoscedastic. We can also see that they are normally distributed, with the exception of a few outliers.

### CONCLUSION
Automobiles with a manual transmission yield better gas mileage than vehicles with an automatic transmission.  
Using the final multivariable regression model it's conclude that ‘wt’ and ‘cyl’are confounding variables in the relationship between ’am and ’mpg’ and that manual transmission cars on average have 1.55 miles per gallon more than automatic cars.
   
### APPENDIX
 A.1 Plot Impact of Transmission Type on Fuel Consumption
```{r, echo = TRUE}
g <- ggplot(data = mtcars, aes(x = mpg, y = ..count..))
g <- g + geom_histogram(binwidth = 0.75,
                        aes(fill = factor(am, labels = c("Automatic", "Manual"))))
g <- g + facet_grid(. ~ factor(am, labels = c("Automatic", "Manual")))
g <- g + scale_colour_discrete(name = "Transmission Type")
g <- g + scale_fill_discrete(name = "Transmission Type")
g <- g + xlab("Fuel Consumption (MPG)") + ylab("Frequency") + theme(plot.title = element_text(size = 8, hjust = 0.5, vjust = 0.5,margin = margin(b = 12, unit = "pt")),
           axis.text.x = element_text(angle = 0,hjust = 0.5,vjust = 0.5,margin = margin(b = 10, unit = "pt")),
           axis.text.y = element_text(angle = 0, hjust = 0.5, vjust = 0.5, margin = margin(l = 10, unit = "pt"))) + ggtitle("Impact of Transmission Type on Fuel Consumption")
g
```
A.2 Residuals Plot
```{r analysis-of-residuals-plot, echo = TRUE, message = FALSE, results = 'hold'}
par(mfrow = c(2, 2))
plot(T_multivar)
```

