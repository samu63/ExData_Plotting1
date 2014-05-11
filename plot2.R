
  #reading the file
  hspwcons <- read.csv("household_power_consumption.txt", skip=0, sep=";", header=T )
  
  ## transform data from m/d/y to date format'
  hspwcons$Date <-  as.Date(hspwcons$Date, format="%d/%m/%Y")
  ##subsetting data from the dates 2007-02-01 and 2007-02-02
  hspwcons_sub<-subset(hspwcons, Date==as.Date("01/02/2007", format="%d/%m/%Y")| Date==as.Date("02/02/2007", format="%d/%m/%Y"))
  hspwcons_sub$DateTime<-as.POSIXct(paste(hspwcons_sub$Date, hspwcons_sub$Time))
  #cleaning data
  hspwcons_sub$Global_active_power<-as.numeric(gsub("\\?",NA, hspwcons_sub$Global_active_power))
  hspwcons_sub$Global_reactive_power<-as.numeric(gsub("\\?",NA, hspwcons_sub$Global_reactive_power))
  hspwcons_sub$Voltage<-as.numeric(gsub("\\?",NA, hspwcons_sub$Voltage))
#plot data
png('plot2.png', width=480, height=480)

plot(hspwcons_sub$DateTime, hspwcons_sub$Global_active_power, ylab="Global Active Power (kilowatts)", type="l", lwd=1, xlab="")

dev.off()

