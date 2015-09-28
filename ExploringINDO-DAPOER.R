# Exploring INDO-DAPOER

# Load the clean INDO-DAPOER set
# *Note: variable names have been changed into shortversion
dapoer <- read.csv("DataIndoDapoer_09282015.csv")
str(dapoer)
names(dapoer)

# Basic plotting
pairs(~log(dapoer$GDPwOilNom)+
        dapoer$"PovertyRate"+
        dapoer$"HDI"+
        dapoer$"Water"+
        dapoer$"Sanitation")


# Advanced plotting
# Using function from stackoverflow
# How to modify this Correlation Matrix plot?
# http://stackoverflow.com/questions/15271103/how-to-modify-this-correlation-matrix-plot
# By: Didzis Elferts

# Changed panel.cor() function to show to lines of text - p-values and correlation coefficients.
# Modified with use='complete.obs'
# https://stat.ethz.ch/pipermail/r-help/2005-March/067793.html
panel.cor <- function(x, y, digits=2, cex.cor)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y, use='complete.obs'))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  test <- cor.test(x,y)
  Signif <- ifelse(round(test$p.value,3)<0.001,"p<0.001",paste("p=",round(test$p.value,3)))  
  text(0.5, 0.25, paste("r=",txt))
  text(.5, .75, Signif)
}

# For panel.smooth() function defined cex=, col= and pch= arguments.
panel.smooth<-function (x, y, col = "blue", bg = NA, pch = 18, 
                        cex = 0.8, col.smooth = "red", span = 2/3, iter = 3, ...) 
{
  points(x, y, pch = pch, col = col, bg = bg, cex = cex)
  ok <- is.finite(x) & is.finite(y)
  if (any(ok)) 
    lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), 
          col = col.smooth, ...)
}

# To add histograms, panel.hist() functions should be defined (taken from help file of pairs())
panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col="cyan", ...)
}


# Economic set
c(47,49,51)

# Social set
c(28)

# development set
c(28)

# Electricity, Phone line vs economic indicator
pairs((dapoer[,c(23,24,47,49,51)]),
      lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist)

# Sanitation, water vs economic indicator
pairs(dapoer[,c(25,26,47,49,51)],
      lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist)

# HDI vs economic indicator
pairs(dapoer[,c(28,47,49,51)],
      lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist)

  # Ignore
  # Testing complete obs
  cor(dapoer[,28],dapoer[,47], use='complete.obs')
