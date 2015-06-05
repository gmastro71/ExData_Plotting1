# Read data for 2007-02-01 and 2007-02-02
consumptionInitial <- read.csv("household_power_consumption.txt",sep=";",na.strings="?",nrows=70000)  ## 70000 lines is enough to include the required range
consumptionInitial$Date <- as.Date(consumptionInitial$Date,"%d/%m/%Y")
consumption <- subset(consumptionInitial,consumptionInitial$Date=="2007-02-01" | consumptionInitial$Date=="2007-02-02")
rm(consumptionInitial)  ## no longer needed

# Convert Date/Time formats
consumption$datetime <- paste(consumption$Date,consumption$Time,sep=" ")  ## create combined "datetime" variable
consumption$datetime <- strptime(consumption$datetime, "%Y-%m-%d %H:%M:%S")

# Create multiple plots
png("plot4.png",width=480,height=480)  ## write directly to PNG to avoid legend truncation experienced with dev.copy
par(mfrow=c(2,2))
with(consumption, {
  # (1,1)
  plot(datetime,Global_active_power,type="l",xlab="", ylab="Global Active Power (kilowatts)")
  # (1,2)
  plot(datetime,Voltage,type="l",ylab="Voltage")
  # (2,1)
  plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
  lines(datetime,Sub_metering_2,col="red")
  lines(datetime,Sub_metering_3,col="blue")
  legend("topright",lty=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  # (2,2)
  plot(datetime,Global_reactive_power,type="l")
})  
dev.off()
