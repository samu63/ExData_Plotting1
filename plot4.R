

  #reading the file
  hspwcons <- read.csv("household_power_consumption.txt", skip=0, sep=";", header=T , dec=".")
  
  ## transform data from m/d/y to date format'
  hspwcons$Date <-  as.Date(hspwcons$Date, format="%d/%m/%Y")
  ##subsetting data from the dates 2007-02-01 and 2007-02-02
  #hspwcons_sub<-subset(hspwcons, hspwcons$Date %in% c("1/2/2007", "2/2/2007")
  hspwcons_sub<-subset(hspwcons, Date==as.Date("01/02/2007", format="%d/%m/%Y")| Date==as.Date("02/02/2007", format="%d/%m/%Y"))
  hspwcons_sub$DateTime<-as.POSIXct(paste(hspwcons_sub$Date, hspwcons_sub$Time))
  #cleaning data
  hspwcons_sub$Global_active_power<-as.numeric(gsub("\\?",NA, hspwcons_sub$Global_active_power))
  hspwcons_sub$Global_reactive_power<-as.numeric(gsub("\\?",NA, hspwcons_sub$Global_reactive_power))
  hspwcons_sub$Voltage<-as.numeric(gsub("\\?",NA, hspwcons_sub$Voltage))
  
  #plot data
  png('plot4.png', width=480, height=480)
  par(bg=NA, mfcol=c(2, 2))
  
  plot(hspwcons_sub$DateTime, hspwcons_sub$Global_active_power,
       type="l",
       xlab="", ylab="Global Active Power (kilowatts)")
  
  plot(hspwcons_sub$DateTime, hspwcons_sub$Sub_metering_1, type="l", col="black",
       xlab="", ylab="Energy sub metering")
  lines(hspwcons_sub$DateTime, as.numeric(as.character(hspwcons_sub$Sub_metering_2)), type = "l", col = "red")
  lines(hspwcons_sub$DateTime, hspwcons_sub$Sub_metering_3, type="l", col="blue")
  legend("topright", c(colnames(hspwcons_sub)[7:9]), col=c("black", "red", "blue"),
         lty=1, bty="n")
  
  
  plot(hspwcons_sub$DateTime, hspwcons_sub$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  plot(hspwcons_sub$DateTime, hspwcons_sub$Global_reactive_power, type="l",
       ylim=c(0,0.5),
       xlab="datetime", ylab="Global_reactive_power")
  
  dev.off()

