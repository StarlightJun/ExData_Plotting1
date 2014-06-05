## This code assumes following two things
## 1) household_power_consumption.txt file in current working 
##    directory that this code runs
## 2) "sqldf" package is installed

## Load library sqldf 
library(sqldf)

## If there is same file named "plot4.png", it is deleted
if(file.exists("plot4.png")) file.remove("plot4.png")

## load data file as data frame 
file <- "household_power_consumption.txt"
df <- read.csv.sql( file, 
                    sep = ";", 
                    sql = ' select * from file 
                    where Date="1/2/2007" or Date="2/2/2007" 
                    ' )
## Change locale 
lct <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","C")

## Date and Time conversion for Date and Time column
x <- paste(df$Date, df$Time)
df$Time <- strptime(x, format="%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

### ;Please discard this comments
### ;add "Day" column in Engligh
### ;df$Day<-c("Sun","Mon","Tue","Wed","Thu","Fri","Sat")[ as.POSIXlt(
### ;                                                       df$Date )$wday 
### ;                                                     + 1 ]
### ;add "Day" column in Korean
### ;df$Day <- weekdays(df$Date) 

## Begin drawing plot4
png("plot4.png", height=480, width=480,res=55)
par(mfcol=c(2,2))

## Draw plot2.png on top left
par(mar=c(4,4,2,2))
plot(df$Time,df$Global_active_power,
     xlab="",ylab="Global Active Power", 
     type ="l") 

## Draw plot3.png on bottom left
par(mar=c(4,4,2,2))
plot(df$Time,df$Sub_metering_1,
     xlab="",ylab="Energy sub metering", 
     type ="l")
points(df$Time,df$Sub_metering_2,col="red",type="l")
points(df$Time,df$Sub_metering_3,col="blue",type="l")
legend("topright",
       c(names(df)[7],names(df)[8],names(df)[9]), 
       lty=c(1,1,1),bty="n",
       col=c("black","red","blue") )

## Draw Voltage on top right
par(mar=c(4,4,2,2))
plot(df$Time,df$Voltage,
     xlab="datetime", ylab="Voltage", 
     type ="l",
     ## suppress y axis for manual ticks
     yaxt = "n")
## Draw y axis with manual ticks and labels
ticks = c(234,236,238,240,242,244,246)
axis(side=2,at = ticks, 
     labels=c(234,NA,238,NA,242,NA,246) )

## Draw Global_reactive_power on bottom right
par(mar=c(4,4,2,2))
plot(df$Time,df$Global_reactive_power,
     xlab="datetime", ylab="Global_reactive_power", 
     type ="l")

###; Please Discard this comments
###; dev.copy(png, file="plot4.png", width=480, height=480, units="px") 

dev.off()

## Recover locale 
Sys.setlocale("LC_TIME",lct)
