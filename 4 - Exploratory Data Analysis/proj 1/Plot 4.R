

data <- read.table("household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
summary(data)

subsetdata <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

globalActivePower <- as.numeric(subsetdata$Global_active_power)
globalReactivePower <- as.numeric(subsetdata$Global_reactive_power)
voltage <- as.numeric(subsetdata$Voltage)
subMetering1 <- as.numeric(subsetdata$Sub_metering_1)
subMetering2 <- as.numeric(subsetdata$Sub_metering_2)
subMetering3 <- as.numeric(subsetdata$Sub_metering_3)


par(mfrow = c(2, 2)) 

# First plot
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.1)


# Second plot
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")


# Third plot
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.4)

# Fourth plot
plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)
