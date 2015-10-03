## Cleaning and Reshaping IndoDapoer (World Bank)
Use the following tutorial: Intro to R Session 3.5 (Data Manipulation - World Bank Data) 
[https://www.youtube.com/watch?v=6qmYxYtY6Rg]

## Download the data
Indonesia Database for Policy and Economic Research [http://data.worldbank.org/data-catalog/indonesia-database-for-policy-and-economic-research]

## Prep
Before loading the data, remove the "Country_Code" variable using excel

~~~
# Load the data
data <- read.csv("INDODAPOER-Data.csv")
# Examine the data
head(data)
str(data)
names(data)
~~~

## Subsetting
subsetting the data based on the following criteria selection (1) provincial scale, (2) TS 2000-2012, (3) 52 variables of choice
~~~
# Subsetting for provincial data only
subset1 <- subset(data, 
                    Country.Name=="Bali, Prop." |
                    Country.Name=="Banten, Prop." |
                    Country.Name=="Bengkulu, Prop." |
                    Country.Name=="DI Yogyakarta, Prop." |
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
                    Country.Name=="Kepulauan Bangka-Belitung, Prop." |
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

# Further subsetting for select indicators (2000-2012)
subset2 <-  subset(subset1,
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
                     Indicator.Code=="HOU.H2O.ACSN.ZS"|
                     Indicator.Code=="SP.POP.TOTL" |
                     Indicator.Code=="SL.TLF"|
                     Indicator.Code=="SL.UEM.TOTL"|
                     Indicator.Code=="SL.EMP.TOTL")

# Further subsetting for select years (X2000-X2012)
subset3 <- subset(subset2, select=c(Country.Name,Indicator.Name,Indicator.Code,X2000:X2012))
~~~

## Renaming the variables
To keep things simple, selected indicator (variable) names have to be changed. Use the instructions from R Cookbook [http://www.cookbook-r.com/Manipulating_data/Renaming_levels_of_a_factor/] 
~~~
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Birth attended by Skilled Health worker (in % of total birth)"] <-"Birth"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Agriculture Sector (in IDR Million), Constant Price"] <-"AgGDPr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Agriculture Sector (in IDR Million), Current Price"] <-"AgGDPn"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Construction Sector (in IDR Million), Constant Price"] <-"CoGDPr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Construction Sector (in IDR Million), Current Price"] <-"CoGDPn"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Financial Service Sector (in IDR Million), Constant Price"] <-"FiGDPr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Financial Service Sector (in IDR Million), Current Price"] <-"FiGDPn"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Manufacturing Sector (in IDR Million), Constant Price"] <-"MgGDPr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Manufacturing Sector (in IDR Million), Current Price"] <-"MgGDPn"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Mining and Quarrying Sector (in IDR Million), Constant Price"] <-"MnGDPr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Mining and Quarrying Sector (in IDR Million), Current Price"] <-"MnGDPn"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Other Service Sector (in IDR Million), Constant Price"] <-"SvGDPr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Other Service Sector (in IDR Million), Current Price"] <-"SvcGDPc"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Trade, Hotel and Restaurant Sector (in IDR Million), Constant Price"] <-"TrGDPr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Trade, Hotel and Restaurant Sector (in IDR Million), Current Price"] <-"TrGDPc"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Transportation and Telecommunication Sector (in IDR Million), Constant Price"] <-"TeGDPr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Transportation and Telecommunication Sector (in IDR Million), Current Price"] <-"TeGDPc"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Utilities Sector (in IDR Million), Constant Price"] <-"UtGDPr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="GDP on Utilities Sector (in IDR Million), Current Price"] <-"UtGDPc"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Household Access to Electricity: Total (in % of total household)"] <-"Elect"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Household Access to Fixed Line Phone Connection (in % of total Household)"] <-"Phone"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Household Access to safe Sanitation (in % of total Household)"] <-"Sanit"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Household Access to Safe Water (in % of total household)"] <-"Water"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Household per capita expenditure (in IDR)"] <-"HseExp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Human Development Index"] <-"HDI"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Monthly Per Capita Household Education Expenditure (in IDR)"] <-"HseEd"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of Doctors"] <-"Doctor"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of hospitals"] <-"Hospit"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of Midwives"] <-"Mdwive"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed in agriculture, forestry and fishery"] <-"AgEmp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed in construction sector"] <-"CoEmp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed in electricity and utilities sector"] <-"FiEmp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed in financial services sector"] <-"MgEmp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed in industrial sector"] <-"IdEmp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed in mining and quarrying sector"] <-"MnEmp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed in social services sector"] <-"SvEmp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed in trade, hotel and restaurant sector"] <-"TrEmp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed in transportation and telecommunication sector"] <-"TtEmp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of Polindes (Poliklinik Desa/Village Polyclinic)"] <-"Vlg"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of Puskesmas and its line services"] <-"Clinic"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Poverty Gap (index)"] <-"PovGap"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Poverty Line (in IDR)"] <-"PovLin"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Poverty Rate (in % of population)"] <-"PovRte"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Total GDP based on expenditure (in IDR Million)"] <-"GDPexp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Total GDP excluding Oil and Gas (in IDR Million), Constant Price"] <-"GDPwOr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Total GDP excluding Oil and Gas (in IDR Million), Current Price"] <-"GDPwOn"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Total GDP including Oil and Gas (in IDR Million), Constant Price"] <-"GDPxOr"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Total GDP including Oil and Gas (in IDR Million), Current Price"] <-"GDPxOn"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Total Population (in number of people)"] <-"Popul"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people in labor force"] <-"Labor"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people unemployed"] <-"Unemp"
levels(subset3$Indicator.Name)[levels(subset3$Indicator.Name)=="Number of people employed"] <-"Empl"
~~~

## Current data structure
Currently, the data should have the following column names
~~~
[1] "Country.Name"  
 [2] "Indicator.Name"
 [3] "Indicator.Code"
 [4] "X2000"         
 [5] "X2001"         
 [6] "X2002"         
 [7] "X2003"         
 [8] "X2004"         
 [9] "X2005"         
[10] "X2006"         
[11] "X2007"         
[12] "X2008"         
[13] "X2009"         
[14] "X2010"         
[15] "X2011"         
[16] "X2012" 
~~~

## (1) Melting data
The next step is to melt the data, to reflect the following column: "Province"  "Indicator" "Code" "Year" "Value" 
~~~
# Use package "Reshape2"
library(reshape2)

# Melt the subset
mymelt <- melt(subset3)

# Renaming the variable 
names(mymelt)[1:5] <- c("Province", "Indicator", "Code", "Year", "Value")

# Removing X (from the year variable i.e. X2000, X2001, Xn,...)
mymelt$Year <- as.numeric(sub("X","",mymelt$Year))

# by now the data should show the following column names
[1] "Province"  "Indicator"
[3] "Code"      "Year"     
[5] "Value"    
~~~

## (2) casting the data
Using 'dcast', the data will be reshaped to show the following column structure: Year,Province~Indicator
~~~
mycast <- dcast(mymelt,Year+Province~Indicator, value.var = "Value")
##
~~~

## (3) casting the data 2
This s

