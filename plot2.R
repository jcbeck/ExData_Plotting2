require(plyr)

# Load data from RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Optimize variable names
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# Summarize all annual emissions in Baltimore
q2 <- ddply(NEI[NEI$fips == "24510", ], ~ year, summarize, 
            "Total Emissions" = sum(emissions))

# Create base plot
png(filename = "plot2.png")
plot(q2, type = "b", 
     main = "Sum of Annual Emissions in Baltimore")
dev.off()