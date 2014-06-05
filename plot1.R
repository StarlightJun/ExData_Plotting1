## This code assumes following two things
## 1) household_power_consumption.txt file in current working 
##    directory that this code runs
## 2) "sqldf" package is installed

        
## Load library sqldf 
library(sqldf)

## If there is same file named "plot1.png", it is deleted
if(file.exists("plot1.png")) file.remove("plot1.png")

## load data file as data frame 
file <- "household_power_consumption.txt"
df <- read.csv.sql( file, 
                    sep = ";", 
                    sql = ' select * from file 
                            where Date="1/2/2007" or Date="2/2/2007" 
                          ' )

## Date and Time conversion for Date and Time column 
x <- paste(df$Date, df$Time)
df$Time <- strptime(x, format="%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

## Draw plot1.png 
png(filename = "plot1.png", width = 480, height = 480, res=55)
par(mar=c(4,4,2,2))
hist( df$Global_active_power, 
      col="red", 
      xlab="Global Active Power(kilowatts)",
      ylab="Frequency", 
      main="Global Active Power" )
##dev.copy(png, file="plot1.png", width=480, height=480, units="px") 
dev.off()
   


