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



#===================================
# Environment Set Up
setwd("C:/Documents and Settings/z78993/Bureau/R/KaggleMarchMadness")

regSeason <- read.table('regular_season_results.csv',sep=',',header=T,quote="")
seasons <- read.table('seasons.csv',sep=',',header=T,quote="")
teams <- read.table('teams.csv',sep=',',header=T,quote="")
tourneyResults <- read.table('tourney_results.csv',sep=',',header=T,quote="")
tourneySeeds <- read.table('tourney_seeds.csv',sep=',',header=T,quote="")
tourneySlots <- read.table('tourney_slots.csv',sep=',',header=T,quote="")

head(regSeason)
head(seasons)
head(teams)



# Discovery Notes : 
#
# Build intra-region ranking based on nb of points in intra-region games (ie teamA > teamB)
# build inter-region ranking based on nb of points in inter-region games (ie regA > regB)
# Build some kind of inter-intra-region ranking

  
  
  
