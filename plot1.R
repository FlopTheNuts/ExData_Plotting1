# plot1.R
#
# creates a histogram of active power usage

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
png("plot1.png")

with(ds,hist(Global_active_power, 
             col="red", 
             main="Global Active Power", 
             xlab="Global Active Power (kilowatts)"))

# close the png
dev.off()