## Title: Exploratory Data Analysis - Assignment 1: Plot 2
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

## Setting parameter to obtain a square plot
par(pty = "s")                              

## Creating the required plot
plot(finaldata$Time,finaldata$Global_active_power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)" )

## Copy the plot on to a png file
dev.copy(jpeg,"Plot2.png")

## Switching off the device
dev.off()
