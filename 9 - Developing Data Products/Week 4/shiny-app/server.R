library(shiny)
library(datasets)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

shinyServer(function(input, output) {

    getVariableName <- function(x) {
        switch(as.character(x),
               "cyl" = return("Number of Cylinders"),
               "disp" = return("Displacement (cu.in.)"),
               "hp" = return("Gross Horsepower"),
               "drat" = return("Rear Axle Ratio"),
               "wt" = return("Weight (lb/1000)"),
               "qsec" = return("1/4 Mile Time"),
               "vs" = return("Engine (V/S)"),
               "am" = return("Transmission (Auto/Manual)"),
               "gear" = return("Number of Forward Gears"),
               "carb" = return("Number of Carburetors"),
               "Unknown"
        )
    }

    formulaText <- reactive({
        paste("Relationship Between MPG and", getVariableName(input$variable))
    })

    formulaTextPoint <- reactive({
        paste("mpg ~", "as.integer(", input$variable, ")")
    })

    fit <- reactive({
        lm(as.formula(formulaTextPoint()), data = mpgData)
    })

    output$caption <- renderText({
        formulaText()
    })

    output$fit <- renderPrint({
        summary(fit())
    })

    output$mpgPlot <- renderPlot({
        with(mpgData, {
            plot(as.formula(formulaTextPoint()),
                 ylab = "Miles/(US) Gallon",
                 xlab = getVariableName(input$variable))
            abline(fit(), col = 2)
        })
    })

})
