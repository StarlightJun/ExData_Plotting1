## This code assumes following two things
## 1) household_power_consumption.txt file in current working 
##    directory that this code runs
## 2) "sqldf" package is installed


## Load library sqldf 
library(sqldf)

## If there is same file named "plot2.png", it is deleted
if(file.exists("plot2.png")) file.remove("plot2.png")

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

## Draw plot2.png 
png(filename = "plot2.png", width = 480, height = 480,res=55)
par(mar=c(4,4,2,2))
plot(df$Time,df$Global_active_power,
     xlab="",ylab="Global Active Power(kilowatts)", 
     type ="l")

### ; Please discard this comments
### ; dev.copy(png, file="plot2.png", width=480, height=480, units="px") 
dev.off()

## Recover locale 
Sys.setlocale("LC_TIME",lct)
   

