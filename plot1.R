## Important R variables
## energydata ## Data frame of the household_power_consumption
## tidyenergydata ## Tidy data set with time and date columns 
## We will use the datetime column for time instead of the original time column
## febenergydata ## Tidy data frame containing rows filtered on date 2007-02-01 and 2007-02-02


## Read the Energy Data

samplerows<-read.table("./household_power_consumption.txt", header=TRUE, nrows=5, stringsAsFactors=FALSE)
classes<-sapply(samplerows, class)
energydata<-read.table("./household_power_consumption.txt", header=TRUE, colClasses=classes, sep=";", na.strings="?", stringsAsFactors=FALSE,  blank.lines.skip=TRUE)

## Tidy the data set

datanames<-names(energydata)
datanames<-tolower(datanames)
datanames<-gsub("_","",datanames)
names(energydata)<-datanames

## Add a new column called datatime to store the time
## We will convert this column to time using strptime()
## while the date will remain in the date column

library(dplyr)

tidyenergydata<-energydata%>%mutate(datetime=paste(date,time))


## Convert the data to date and time
tidyenergydata$date<-as.Date(tidyenergydata$date,"%d/%m/%Y")

tidyenergydata$datetime<-strptime(tidyenergydata$datetime, format = "%d/%m/%Y %H:%M:%S")

## Subset the energy data frame to select data from the dates 2007-02-01 and 2007-02-02
febenergydata<-subset(tidyenergydata, date=="2007-02-01" | date == "2007-02-02")

#### -------------- Plot 1 ----------------------###

## Plot the histogram on the screen device

hist(febenergydata$globalactivepower, xlab = "Global Active Power (kilowatts)", ylab ="Frequency", main = "Global Active Power", col = "red")

## Copy the histogram to png device in the current directory

dev.copy(png, file = "./plot1.png")

##### ------------- Plot 2 ----------------------###





