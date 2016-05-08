# plot2.R
#
# creates a plot global active power over time

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
png("plot2.png")

with(ds,plot(DateAndTime,
             Global_active_power,
             type="l",
             ylab="Global Active Power (kilowatts)",
             xlab=""))

# close the png
dev.off()