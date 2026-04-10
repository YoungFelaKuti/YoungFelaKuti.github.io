library(rworldmap)
k = 0.015
pdf("visits_1998_2020_president.pdf",width=k*800,height=k*450)
par(mai=c(0.04,0,0,0),xaxs="i",yaxs="i")
data = read.csv("1998-2020-president-visits.csv")
sPDF = joinCountryData2Map(data, joinCode = "ISO3",  nameJoinColumn = "ccode")
mapParams = mapCountryData(sPDF, nameColumnToPlot="president",catMethod="categorical",mapTitle="", addLegend=TRUE,colourPalette=c('green','mediumspringgreen', 'moccasin', 'lightgoldenrod','orange','darkorange3','red','brown'))
dev.off()
