# Read data for 2007-02-01 and 2007-02-02
consumptionInitial <- read.csv("household_power_consumption.txt",sep=";",na.strings="?",nrows=70000)  ## 70000 lines is enough to include the required range
consumptionInitial$Date <- as.Date(consumptionInitial$Date,"%d/%m/%Y")
consumption <- subset(consumptionInitial,consumptionInitial$Date=="2007-02-01" | consumptionInitial$Date=="2007-02-02")
rm(consumptionInitial)  ## no longer needed

# Convert Date/Time formats
consumption$datetime <- paste(consumption$Date,consumption$Time,sep=" ")  ## create combined "datetime" variable
consumption$datetime <- strptime(consumption$datetime, "%Y-%m-%d %H:%M:%S")

# Create Global Active Power line graph
with(consumption, plot(datetime,Global_active_power,type="l",xlab="", ylab="Global Active Power (kilowatts)"))
dev.copy(png, file="plot2.png", width=480, height=480)  ## generate PNG file output
dev.off()
