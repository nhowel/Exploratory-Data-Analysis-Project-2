#This plot attempts to answer the question: 
#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(dplyr)
library(ggplot2)

#read files from working directory
setwd("C:/Users/natehow/Coursera/Course4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissionsDF <- tbl_df(NEI)
SCCDF <- tbl_df(SCC)
SCCDF$SCC <- as.character(SCCDF$SCC)

#filter by coal generation
SCCDF <- select(SCCDF,SCC,EI.Sector)
emissions <- merge(emissionsDF,SCCDF,by = "SCC")
emissions <- tbl_df(emissions)
coalemissions <- filter(emissions,grepl(pattern = "Coal",EI.Sector))
byyear <- group_by(coalemissions,year)
yeartotals <- summarize(byyear,"totalPM2.5"=sum(Emissions))

#Contruct plot
png("plot4.png",width = 480,height = 480)
a <- ggplot(yeartotals,aes(x = year,y = totalPM2.5))
a <- a + geom_point(color="blue",size = 2)
a <- a + geom_smooth(method = "lm",color = "red", se = FALSE)
a <- a + labs(title = "PM2.5 Emissions from Coal in the U.S.",
              x = "Year",y = "TotalPM2.5 Emissions (tons)")
print(a)
dev.off()