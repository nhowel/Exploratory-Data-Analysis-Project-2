#This plot attempts to answer the question: 
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make 
#a plot answering this question.

library(dplyr)

#read files from working directory
setwd("C:/Users/natehow/Coursera/Course4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissionsDF <- tbl_df(NEI)

#filter by Baltimore City (fips ==24510)
baltimoreemissions <- filter(emissionsDF,fips == "24510")
byyear <- group_by(baltimoreemissions,year)
yeartotals <- summarize(byyear,"totalPM2.5"=sum(Emissions))

#contruct plot
png("plot2.png",width = 480,height = 480)
with(yeartotals,plot(x = year,y = totalPM2.5, main = "Total PM2.5 Emissions in Baltimore",
                     xlab = "Year",ylab = "Total Emissions (Tons)"))
with(yeartotals,abline(lm(totalPM2.5~year),col = "red",lwd = 2))
dev.off()