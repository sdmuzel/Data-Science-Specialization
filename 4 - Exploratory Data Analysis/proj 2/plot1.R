library("data.table")
library(RColorBrewer)
path <- getwd()

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Prevents histogram from printing in scientific notation
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

totalNEI <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]


# barplot

barplot(totalNEI[, Emissions]
        , names = totalNEI[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")


#lineplot
plot(totalNEI$year, totalNEI$Emissions, type = "o", col = "steelblue3", 
     main = expression("Total US "~ PM[2.5]~ "Emissions by Year"), 
     ylab = expression("Total US "~   PM[2.5] ~ "Emissions"), xlab = "Year")
