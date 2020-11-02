---
title: ' Web page presentation using R Markdown'
date: "02/11/2020"
output:
  beamer_presentation: default
  ioslides_presentation: default
  slidy_presentation: default
---

## Synopsis

The goal of the project is to create a web page presentation using R Markdown
that features a plot created with Plotly, and to host the resulting web page on
either GitHub Pages, RPubs, or NeoCities.


## Boxplot
```{r, message = FALSE, echo = FALSE}

knitr::opts_chunk$set(echo = TRUE, fig.path = 'figures/')

library(plotly)
library(ggplot2)

# Loading iris dataset
data(iris)
attach(iris)

#plotting a Boxplot with Sepal.Length variable and storing it in box_plot
p<- plot_ly(y = Sepal.Length,
                    type = 'box',
                    color = ~Species, colors = "Set2")

#defining labels and title using layout()
layout(p,
       title = "Iris Dataset",
       yaxis = list(title = "Sepal.Length"))
```

## Scatter 3D
```{r, message = FALSE, echo = FALSE}

plot_ly(x= iris$Sepal.Width, y= iris$Sepal.Length, z = iris$Species, 
type = "scatter3d", mode = "markers", color = iris$Species)
```



## Bar
```{r, message = FALSE, echo = FALSE}

plot_ly(x= iris$Sepal.Width, y= iris$Sepal.Length, 
type = "bar", color = iris$Species)
```


## Histogram
```{r,message = FALSE, echo = FALSE}
plot_ly(x= iris$Sepal.Width, y= iris$Sepal.Length, 
type = "histogram", color = iris$Species)
```

