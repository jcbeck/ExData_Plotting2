require(plyr)
require(ggplot2)

# Load data
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Set names of variables
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# Show SCC data with Ecological Inference sectors
levels(SCC$ei.sector)

# Look for anything starting with "Mobile - On-Road", 
# and ending in "Vehicles" (1,138)
q6.scc <- SCC[grep("^Mobile - On-Road .* Vehicles$", SCC$ei.sector), ]

# Remove unnecessary factor levels
q6.scc$scc <- factor(q6.scc$scc)

# Summarize all emissions for filtered SCCs in Baltimore and in LA County on an annual basis
q6 <- ddply(NEI[NEI$scc %in% q5.scc$scc & 
                  (NEI$fips == "24510" | NEI$fips == "06037"), ], 
            c("year", "fips"), 
            summarize, 
            total.emissions = sum(emissions))

# Create ggplot plot
png(filename = "plot6.png")
qplot(year, total.emissions, data = q6, geom = "line", facets = ~ fips, 
      main = "Sum of Emissions From Motor Vehicle Sources Per Year\nIn Los Angeles County (left) and Baltimore City (right)")

# Shut the graphic device
dev.off()