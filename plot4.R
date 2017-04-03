## Title: Exploratory Data Analysis - Assignment 1: Plot 4
## Author: Shubham Shishodia

## Reading Data: The script assumes that the zip file has been unzipped and the file name has not been changed. Also, the
## file should be in the working directory.

data<-read.table("household_power_consumption.txt", header=TRUE, stringsAsFactors = FALSE, sep=";")

## Replacing '?' with NA
data[data=="?"]<-NA

## Formatting the 'Date' column to date class
data$Date<-as.Date(data$Date,format = "%d/%m/%Y")

## Formatting the measurements to numeric class
for(i in 3:9){
  data[,i]<-as.numeric(data[,i])
}

## Subsetting the data to extract measurements between the required dates
finaldata<-subset(data, data$Date>=as.Date("01-02-2007", format = "%d-%m-%Y") & 
                    data$Date<=as.Date("02-02-2007", format = "%d-%m-%Y"))

## Formatting the 'Time' column to POSIXct class
t1<-(paste(finaldata$Date,finaldata$Time))
finaldata$Time<-as.POSIXct(t1)

## Open a png graphic device of required pixels. Since a graphic device has been initialized, no plot will be shown on
## the screen. Instead, a file will be created with the required plot.
png("Plot4.png",height = 720, width = 720)

## Setting the required parameters
par(mfrow =c(2,2), pty = "s")

## Creating the required plots
with(finaldata,{
                 plot(Time,Global_active_power, type = "l", col="black", xlab="", ylab = "Global Active Power")
                 plot(Time,Voltage, type = "l", col="black", xlab = "datetime", ylab = "Voltage")
                 plot(Time,Sub_metering_1, type = "l", col="black", xlab="", ylab = "Energy sub metering")
                 lines(Time,Sub_metering_2, col="red")
                 lines(Time,Sub_metering_3, col="blue")
                 legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
                        col= c("black","red","blue"),lty = 1, bty = "n", cex = 0.9)
                 plot(Time,Global_reactive_power, type = "l", col="black", xlab = "datetime")
})

## Switching off the graphic device
dev.off()
