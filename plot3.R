# Load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting data and pull data on Baltimore City, Maryland (fips == "24510")
baltimoredata <- NEI[NEI$fips == "24510",]

# Create the data for the plot
library(plyr)
totalemissions <- ddply(baltimoredata,
                         .(as.factor(year), as.factor(type)),
                         summarize, 
                         total=sum(Emissions)) 

# Give column names
colnames <- c("year","type", "tons")
colnames(totalemissions) <- colnames

# Create the plot
library(ggplot2)

# Create my plots in a PNG file
png(filename = "plot3.png", width = 807, height = 342)

qplot(year, 
      data = totalemissions, 
      facets = . ~ type, 
      geom="bar", 
      weight=tons, 
      main=expression("Total Emissions From PM"[2.5]*" in Baltimore City, Maryland"),
      xlab="Years",
      ylab = expression("Amount of PM"[2.5]*" Emissions In Tons"),
      fill = type)

dev.off() 