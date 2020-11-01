library("data.table")
library(RColorBrewer)



path <- getwd()

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))


NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalNEI <- NEI[fips=='24510', lapply(.SD, sum, na.rm = TRUE)
                , .SDcols = c("Emissions")
                , by = year]

#ggplot2

barplot(totalNEI[, Emissions]
        , names = totalNEI[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")


#lineplot

baltimore <- subset(NEI, NEI$fips == "24510")

totalBaltimore <- aggregate(Emissions ~ year, baltimore, sum)

plot(totalBaltimore$year, totalBaltimore$Emissions, type = "o", 
     main = expression("Total Baltimore" ~ PM[2.5] ~ "Emissions by Year"), 
     xlab = "Year", ylab = expression("Total Baltimore "~ PM[2.5] ~ "Emissions"), 
     col = "steelblue3")
