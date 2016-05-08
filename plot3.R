# plot3.R
#
# creates a plot energy sub metering - whatever that is ;)

# first load the data
# (note that in a real analysis, I'd do this just once, not in each
# file as the assignment requests)

# set the working directory
setwd("~/R/Exploratory Data Analysis/ExData_Plotting1")

# read the raw data
raw_data <- read.csv("household_power_consumption.txt",
                     header=TRUE,
                     sep=";",
                     na.strings = "?")

library(dplyr) # Assignment is easily done without dplyr, I just prefer 'mutate'.
d <- tbl_df(raw_data)

# convert to time and date classes and also create a combo date and time
d <- mutate(d,
            DateAndTime = as.POSIXct(paste(Date,Time," "),
                                     format="%d/%m/%Y %H:%M:%S"),
            Date=as.Date(Date,format="%d/%m/%Y"), 
            Time=as.POSIXct(Time, format="%H:%M:%S")
)

# subset the data to just the dates we want to analyze
ds <- d[d$Date=="2007-02-01" | d$Date=="2007-02-02",]

# open the png device
png("plot3.png")

with(ds,plot(DateAndTime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
with(ds,lines(DateAndTime,Sub_metering_2,col="red"))
with(ds,lines(DateAndTime,Sub_metering_3,type="l",col="blue"))
legend(x="topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,
       col=c(1:3))

# close the png
dev.off()