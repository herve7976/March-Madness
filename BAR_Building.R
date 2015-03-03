# ==============================================================
# Date : 2015-02-27
# Author : Maxime Maxime
#==============================================================
#
# This code builds the Basketball Analytics Record (BAR) out of 
#   the Kaggle datasets.  We will build a preliminary model on 
#   which we will evaluate whether bringing outside data improves
#   the model s accuracy
#
#==============================================================


#========================
# Environment Set Up
setwd("C:/Documents and Settings/z78993/Bureau/R/KaggleMarchMadness")
library("data.table")
library("sqldf")


#======================================================================
#======================================================================
#
# Building the BAR for the regular season
#
#======================================================================
#======================================================================

#========================
# Importing Data

regSeasonDetailed <- read.table('regular_season_detailed_results.csv',sep=',',header=T,quote="")
regSeasonCompact <- read.table('regular_season_compact_results.csv',sep=',',header=T,quote="")
seasons <- read.table('seasons.csv',sep=',',header=T,quote="")
teams <- read.table('teams.csv',sep=',',header=T,quote="")

head(regSeasonDetailed)
head(regSeasonCompact)
head(seasons)
head(teams)



#========================
# Building Cumulative Stats


regSeasonDetailed.dt <- data.table(regSeasonDetailed)
setkey(regSeasonDetailed.dt,season,daynum)

wStats <- paste("'season','daynum','numot','wloc','wteam','wscore','wfgm','wfga' ,'wfgm3' ,'wfga3' ,'wftm','wfta' ,
                'wor','wdr','wast','wto','wstl','wblk','wpf'")


tm <- 1104
for (tm in c(1104))
{
  # Only Stats from team 'tm'
  xw <- regSeasonDetailed.dt[regSeasonDetailed.dt$wteam == tm,]
  xl <- regSeasonDetailed.dt[regSeasonDetailed.dt$lteam == tm,]
  # Selecting the team's stats vs opponent's stats
  xw_tm <- sqldf('select season,daynum,numot,wloc,wteam,wscore,wfgm,wfga ,wfgm3 ,wfga3 ,wftm,wfta,wor,wdr,wast,wto,wstl,wblk,wpf from xw')
  xl_tm <- sqldf('select season,daynum,numot,wloc,lteam,lscore,lfgm,lfga ,lfgm3 ,lfga3 ,lftm,lfta,lor,ldr,last,lto,lstl,lblk,lpf from xl')
  
  xw_op <- sqldf('select season,daynum,numot,wloc,lteam,lscore,lfgm,lfga ,lfgm3 ,lfga3 ,lftm,lfta,lor,ldr,last,lto,lstl,lblk,lpf from xw')
  xl_op <- sqldf('select season,daynum,numot,wloc,wteam,wscore,wfgm,wfga ,wfgm3 ,wfga3 ,wftm,wfta,wor,wdr,wast,wto,wstl,wblk,wpf from xl')
  
  #Inverser les Home & Away 
  AreAs <- which(xl_tm$wloc=="A")
  xl_tm[AreAs,]$wloc <- "H"
  xl_tm[-AreAs,]$wloc <- "A"
  #Changing Names
  colnames(xl_tm) <- c("season","daynum","numot","loc","team","score","fgm","fga ","fgm3 ","fga3 ","ftm","fta","or","dr","ast","to","stl","blk","pf")
  colnames(xw_tm) <- c("season","daynum","numot","loc","team","score","fgm","fga ","fgm3 ","fga3 ","ftm","fta","or","dr","ast","to","stl","blk","pf")
  colnames(xl_op) <- c("season","daynum","opnumot","oploc","opteam","opscore","opfgm","opfga ","opfgm3 ","opfga3 ","opftm","opfta","opor","opdr","opast","opto","opstl","opblk","oppf")
  colnames(xw_op) <- c("season","daynum","opnumot","oploc","opteam","opscore","opfgm","opfga ","opfgm3 ","opfga3 ","opftm","opfta","opor","opdr","opast","opto","opstl","opblk","oppf") 
  #Merging per game
  setkey(xl_tm,season,daynum)
  setkey(xl_op,season,daynum)
  setkey(xw_tm,season,daynum)
  setkey(xw_op,season,daynum)
  xl <- merge(xl_tm, xl_op, by=c("season","daynum"),all.y=TRUE)
  xw <- merge(xw_tm, xw_op, by=c("season","daynum"),all.y=TRUE)
  
  #Unioning them back together
  x <- data.table(rbind(xl, xw))
  # In ascending order of season and daynum
  x <- x[order(x$season, x$daynum)]

  
  ssn <- 2003
  for (ssn in seq(min(x$season),max(x$season)))
  {
    #Subsetting per season
    xssn <- x[x$season == ssn,]
    
    #Building differential confrontational stats per game
    
    #TimeSerie-ing the shit out of it.

    xssn$matchnum <- 1
    xssn2 <- data.table(apply(xssn,FUN=cumsum,MARGIN=2))
    xxsn3 <- data.table(apply(xssn2[c(3,5:)],FUN=))    
  }
}


# Discovery Notes : 
#
# The only use of 'teams' dataset would be if we use the hashing trick... 
#
# Build two datasets, one with regular season data (including cumulative stats)
#   and one with tourneyResults containing cumulative stats from regular season 
#    
# ====================================================
# DataSet 1 : Regular Season
#
# Targets : 
#   1. Binary : W=1, L=0  
#   2. Points difference (wscore - lscore)
#   3. Points differential (wscore / lscore)
#   4. Standardized points differential : ((wscore - lscore) / lscore)#
#
# Stationary Stats : 
#       wteam and lteam region
#
#  Cumulative Stats  (always up until this game): 
#       Avg (Geo, Arith, Harm)
#       Median, 
#       Std, 
#       MA(3,6,12) 
#       Slope of regression (y = b0 + b1x + bx(sq)) (y = indicator above, x = games)
#
#   of the following stats : 
#         Winnings (1,0)
#         Points per game
#         Sandardized points differential per game
#         Everything found in regSeasonDetailed respective to the opponent's team.
#           Ex : I will never use 'average free throws' but always 'average free throws differential'
#             Thinking : The isolated stats are not important.  Its the confrontation that matters.
#
# Build intra-region ranking based on nb of points in intra-region games (ie teamA > teamB)
# build inter-region ranking based on nb of points in inter-region games (ie regA > regB)
# Build some kind of inter-intra-region ranking

  
  
tourneyResults <- read.table('tourney_results.csv',sep=',',header=T,quote="")
tourneySeeds <- read.table('tourney_seeds.csv',sep=',',header=T,quote="")
tourneySlots <- read.table('tourney_slots.csv',sep=',',header=T,quote="")

