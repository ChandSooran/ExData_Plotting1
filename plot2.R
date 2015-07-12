## Plot 2 R code file
## Chand Sooran

## Set the working directory 
setwd("C://Chand Sooran/Johns Hopkins/Exploratory Data/Course Project 1/")

## Install package dplyr
install.packages("dplyr")
library(dplyr)

## Download the zip file
temp <- tempfile(tmpdir = "C://Chand Sooran/Johns Hopkins/Exploratory Data/Course Project 1/")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)

## Unzip the zip file
unzip("C://Chand Sooran/Johns Hopkins/Exploratory Data/Course Project 1/filed46e0e66ab")

## Read the unzipped file as a variable called "household"
household <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)

## Set the names for "household" variables
household_names <- c("Date","Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
colnames(household) <- household_names

## Remove the duplicative first row now that we have set the names
household <- household[-1,]

## Paste the date and time together in a new column that is of class POSIXct
household_datetime <- paste(household$Date, household$Time, sep = " ")
household_datetime <- strptime(household_datetime, "%d/%m/%Y %H:%M:%S")
household_datetime <- as.POSIXct(household_datetime)

new_household <- mutate(household, datetime = household_datetime) ## New variable new_household

## Shorten the data set to just the relevant time frame of Feb 1-2, 2007
new_household_filter <- filter(new_household, new_household$Date == "1/2/2007" | new_household$Date == "2/2/2007")

## Rename this variable as "short"
short <- new_household_filter

## Make the third columns through the ninth column as numeric
for(i in 3:9){short[,i] <- as.numeric(short[,i])}

## Make png plot
png(filename = "C://Chand Sooran/Johns Hopkins/Exploratory Data/Course Project 1/plot2.png")

## Make histogram in png file
plot(short$datetime, short$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Turn off png
dev.off()
