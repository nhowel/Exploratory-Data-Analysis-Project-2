#This plot attempts to answer the question: 
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? (fips == 24510)

library(dplyr)
library(ggplot2)

#read files from working directory
setwd("C:/Users/natehow/Coursera/Course4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissionsDF <- tbl_df(NEI)

#filter by type == ONROAD and Baltimore (fips == 24510).
vehicleemissionsinbaltimore <- filter(emissionsDF,type == "ON-ROAD" & fips == "24510")
byyear <- group_by(vehicleemissionsinbaltimore,year)
yeartotals <- summarize(byyear,"totalPM2.5"=sum(Emissions))

#Contruct plot
png("plot5.png",width = 480,height = 480)
a <- ggplot(yeartotals,aes(x = year,y = totalPM2.5))
a <- a + geom_point(color="blue",size = 4)
a <- a + geom_smooth(method = "lm",color = "red", se = FALSE, size = 2)
a <- a + labs(title = "PM2.5 Emissions from Motor Vehicles in Baltimore",
              x = "Year",y = "TotalPM2.5 Emissions (tons)")
print(a)
dev.off()