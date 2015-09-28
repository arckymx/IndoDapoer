# Cleaning INDO-DAPOER

# Use the following tutorial
# Intro to R Session 3.5 (Data Manipulation - World Bank Data)
# https://www.youtube.com/watch?v=6qmYxYtY6Rg

data <- read.csv("C:/Users/Roxanna/Downloads/INDODAPOER-Data.csv")
head(data)
str(data)
names(data)

# see table names
head(data$Country.Name)
head(data$Country.Code)
levels(data$Country.Code)
levels(data$Country.Name)
table(data$Country.Name)

# create a subset specifically for provincial data
# (1) Consider manual entry for initial coding; creating provincial selection via excel
# OR
# (2) Use subset function grepl 
# http://stackoverflow.com/questions/18587334/subset-data-to-contain-only-columns-whose-names-match-a-condition

# Using approach (1) via excel:
provsub <- subset(data, 
                    Country.Name=="Bali, Prop." |
                    Country.Name=="Banten, Prop." |
                    Country.Name=="Bengkulu, Prop." |
                    Country.Name=="D I Yogyakarta, Prop." |
                    Country.Name=="DKI Jakarta, Prop." |
                    Country.Name=="Gorontalo, Prop." |
                    Country.Name=="Jambi, Prop." |
                    Country.Name=="Jawa Barat, Prop." |
                    Country.Name=="Jawa Tengah, Prop." |
                    Country.Name=="Jawa Timur, Prop." |
                    Country.Name=="Kalimantan Barat, Prop." |
                    Country.Name=="Kalimantan Selatan, Prop." |
                    Country.Name=="Kalimantan Tengah, Prop." |
                    Country.Name=="Kalimantan Timur, Prop." |
                    Country.Name=="Kepulauan Bangka Belitung, Prop." |
                    Country.Name=="Kepulauan Riau, Prop." |
                    Country.Name=="Lampung, Prop." |
                    Country.Name=="Maluku Utara, Prop." |
                    Country.Name=="Maluku, Prop." |
                    Country.Name=="Nanggroe Aceh Darussalam, Prop." |
                    Country.Name=="Nusa Tenggara Barat, Prop." |
                    Country.Name=="Nusa Tenggara Timur, Prop." |
                    Country.Name=="Papua Barat, Prop." |
                    Country.Name=="Papua, Prop." |
                    Country.Name=="Riau, Prop." |
                    Country.Name=="Sulawesi Barat, Prop." |
                    Country.Name=="Sulawesi Selatan, Prop." |
                    Country.Name=="Sulawesi Tengah, Prop." |
                    Country.Name=="Sulawesi Tenggara, Prop." |
                    Country.Name=="Sulawesi Utara, Prop." |
                    Country.Name=="Sumatera Barat, Prop." |
                    Country.Name=="Sumatera Selatan, Prop." |
                    Country.Name=="Sumatera Utara, Prop.") 




# Further subsetting: selection with only years X2000-X2012 included
provsub2 <- subset(provsub, select=c(Country.Name,Country.Code,Indicator.Name,Indicator.Code,X2000:X2012)  )

# Further subsetting: Selecting with only "Total GDP including Oil and Gas" included
provsub3 <- subset(provsub2, Indicator.Name=="Total GDP including Oil and Gas (in IDR Million), Current Price", select=c(Country.Name,Country.Code,Indicator.Name,Indicator.Code,X2000:X2012))

# Further subsetting: Selecting with only "HDI" included
provsub4 <- subset(provsub2, Indicator.Code=="IDX.HDI") 




# Creating plot for GDP vs HDI
# For year 2010
gdp10 <- log(provsub3$X2010)
HDI10 <- provsub4$X2010
plot(gdp10,HDI10, xlab = "GDP", ylab="HDI", abline(lm(HDI10~gdp10)))
min(HDI10)

# For year 2012
gdp12 <- log(provsub3$X2012)
HDI12 <- provsub4$X2012
plot(gdp12,HDI12, xlab = "GDP", ylab="HDI", abline(lm(HDI12~gdp12)))


# Comparing GDP vs HDI based on selected province

# Estimating Bali
baligdp <- as.numeric(c(log(provsub3[provsub3$Country.Name=="Bali, Prop.",5:17])))
baliHDI <- as.numeric(c(provsub4[provsub4$Country.Name=="Bali, Prop.",5:17]))
plot(baligdp,baliHDI, main = "Bali LogGDPvsHDI")

# Estimating Papua
papuagdp <- c(log(provsub3[provsub3$Country.Name=="Papua, Prop.",5:17]))
papuaHDI <- c(provsub4[provsub4$Country.Name=="Papua, Prop.",5:17])
plot(papuagdp,papuaHDI, main = "Papua, Prop.PvsHDI")



# Cleaning data

# In order to clean the DAPOER data, (1) use reshape, (2) then melt-cast

# (1) Reshaping data
# See YouTube 24:30

# Create a vector
library(reshape)
years <- paste("X",2000:2012, sep="")
years

# Reshape the data
dapoerlong <- reshape(provsub2,varying=years,direction="long", sep="")
head(dapoerlong)
names(dapoerlong)
dapoerlong

# Selecting data after reshaping
longGDP <- log(dapoerlong[dapoerlong$Indicator.Code=="NA.GDP.INC.OG.CR",6])
longpoverty <- dapoerlong[dapoerlong$Indicator.Code=="SI.POV.NAPR.ZS",6]

detach(package:reshape) #need to perform this before using package reshape2




# (2) Melting and casting the data

# Melting
library(reshape2)
mymelt <- melt(provsub2)
mymelt$variable<-as.numeric(sub("X","",mymelt$variable)) ###remove X
names(mymelt)[5] <- "year" ### change the name 'variable' to 'year' on mymelt

# Subsetting with the required Country.Name indicators
mymeltsub <-  subset(mymelt,
                     Indicator.Code=="NA.GDP.AGR.KR"|
                       Indicator.Code=="NA.GDP.AGR.CR"|
                       Indicator.Code=="NA.GDP.CNST.KR"|
                       Indicator.Code=="NA.GDP.CNST.CR"|
                       Indicator.Code=="NA.GDP.FINS.KR"|
                       Indicator.Code=="NA.GDP.FINS.CR"|
                       Indicator.Code=="NA.GDP.MNF.KR"|
                       Indicator.Code=="NA.GDP.MNF.CR"|
                       Indicator.Code=="NA.GDP.MINQ.KR"|
                       Indicator.Code=="NA.GDP.MINQ.CR"|
                       Indicator.Code=="NA.GDP.SRV.OTHR.KR"|
                       Indicator.Code=="NA.GDP.SRV.OTHR.CR"|
                       Indicator.Code=="NA.GDP.TRD.HTL.KR"|
                       Indicator.Code=="NA.GDP.TRD.HTL.CR"|
                       Indicator.Code=="NA.GDP.TRAN.COMM.KR"|
                       Indicator.Code=="NA.GDP.TRAN.COMM.CR"|
                       Indicator.Code=="NA.GDP.UTL.KR"|
                       Indicator.Code=="NA.GDP.UTL.CR"|
                       Indicator.Code=="NE.GDI.TOTL.CR"|
                       Indicator.Code=="NA.GDP.EXC.OG.KR"|
                       Indicator.Code=="NA.GDP.EXC.OG.CR"|
                       Indicator.Code=="NA.GDP.INC.OG.KR"|
                       Indicator.Code=="NA.GDP.INC.OG.CR"|
                       Indicator.Code=="IDX.HDI"|
                       Indicator.Code=="SI.POV.NGAP"|
                       Indicator.Code=="SI.POV.NAPL"|
                       Indicator.Code=="SI.POV.NAPR.ZS"|
                       Indicator.Code=="SL.EMP.AGR.FRST.FSH"|
                       Indicator.Code=="SL.EMP.CNST"|
                       Indicator.Code=="SL.EMP.ELC"|
                       Indicator.Code=="SL.EMP.FINS"|
                       Indicator.Code=="SL.EMP.IND"|
                       Indicator.Code=="SL.EMP.MINQ"|
                       Indicator.Code=="SL.EMP.SOCL"|
                       Indicator.Code=="SL.EMP.TRAD"|
                       Indicator.Code=="SL.EMP.TRAN"|
                       Indicator.Code=="SH.STA.BRTC.ZS"|
                       Indicator.Code=="SH.DR.TOTL"|
                       Indicator.Code=="SH.MED.MWIV.TOTL"|
                       Indicator.Code=="SH.HOSP.TOTL"|
                       Indicator.Code=="SH.POLINDES.TOTL"|
                       Indicator.Code=="SH.PUSKESMAS.TOTL"|
                       Indicator.Code=="HOU.XPD.PC.CR"|
                       Indicator.Code=="HOU.XPD.EDU.PC.CR"|
                       Indicator.Code=="HOU.ELC.ACSN.ZS"|
                       Indicator.Code=="HOU.MLT.MAIN.ZS"|
                       Indicator.Code=="HOU.STA.ACSN.ZS"|
                       Indicator.Code=="HOU.H2O.ACSN.ZS"
                     )

# Casting the data
mycast <- dcast(mymeltsub,year+Country.Name~Indicator.Name)




## exporting file

# Basic export to R.Data
save.image("mycast.RData")

# Write csv
write.csv(mycast, "mycast.csv")

# write in SPSS package
library(foreign)
write.foreign(mycast, datafile="mycast.sav", codefile="mycast.sps", package="SPSS")

