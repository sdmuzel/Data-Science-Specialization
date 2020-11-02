library(shiny)

shinyUI(
    navbarPage("Motor Trend Data Analysis Application",
               tabPanel("Analysis",
                        fluidPage(
                            titlePanel("Analysis"),
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput("variable", "Variable:",
                                                c("Number of Cylinders" = "cyl",
                                                  "Displacement (cu.in.)" = "disp",
                                                  "Gross Horsepower" = "hp",
                                                  "Rear Axle Ratio" = "drat",
                                                  "Weight (lb/1000)" = "wt",
                                                  "1/4 Mile Time" = "qsec",
                                                  "Engine (V/S)" = "vs",
                                                  "Transmission (Auto/Manual)" = "am",
                                                  "Number of Forward Gears" = "gear",
                                                  "Number of Carburetors" = "carb"
                                                ))
                                ),

                                mainPanel(
                                    h4(textOutput("caption")),
                                    plotOutput("mpgPlot"),
                                    verbatimTextOutput("fit")
                                )
                            )
                        )
               ),
               tabPanel("Data Set",
                        h3("About the Data Set"),
                        div("The mtcars dataset is comprised of data that was
                            was extracted from the 1974 Motor Trend US
                            magazine, and comprises fuel consumption and 11
                            aspects of automobile design and performance
                            for 32 automobiles (1973-74 models).",
                            br(),br(),
                            "The mtcars dataset is a data frame with 32
                            observations on 11 (numeric) variables:",
                            br(),br(),
                            tags$ul(
                                tags$li(tags$strong("mpg"), "Miles/(US) gallon"),
                                tags$li(tags$strong("cyl"), "Number of cylinders"),
                                tags$li(tags$strong("disp"), "Displacement (cu.in.)"),
                                tags$li(tags$strong("hp"), "Gross horsepower"),
                                tags$li(tags$strong("drat"), "Rear axle ratio"),
                                tags$li(tags$strong("wt"), "Weight (1000 lbs)"),
                                tags$li(tags$strong("qsec"), "1/4 mile time"),
                                tags$li(tags$strong("vs"), "Engine (0 = V-shaped, 1 = straight)"),
                                tags$li(tags$strong("am"), "Transmission (0 = automatic, 1 = manual)"),
                                tags$li(tags$strong("gear"), "Number of forward gears"),
                                tags$li(tags$strong("carb"), "Number of carburetors")
                                ))
               ),
               tabPanel("About",
                        h3("About the Motor Trend Data Analysis Application"),
                        div("Motor Trend Data Analysis is an interactive
                            application that uses linear regression modeling
                            techniques to estimate fuel consumption (MPG) in 32
                            automobiles (1973-74 models) based on 11 aspects of
                            automobile design and performance. See ",
                            em("About the Data Set"),
                            br(),br(),
                            "The source code for this application can be found
                            on GitHub:",
                            br(),br(),
                            a(href = "https://github.com/sdmuzel/Data-Science-Specialization/tree/master/9%20-%20Developing%20Data%20Products/Week%204/shiny-app/",
                            "https://github.com/sdmuzel/Data-Science-Specialization/tree/master/9%20-%20Developing%20Data%20Products/Week%204/shiny-app//"))
               )
    )
)


