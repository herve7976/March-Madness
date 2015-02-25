library(XML)
library(data.table)


result_season_h=fread("C:\\Users\\Herve\\Dropbox\\Projet\\Projets R\\March Madness\\regular_season_compact_results.csv",header=TRUE)
str(result_season_h)


result_season_d_h=fread("C:\\Users\\Herve\\Dropbox\\Projet\\Projets R\\March Madness\\regular_season_detailed_results.csv",header=TRUE)
str(result_season_d_h)

season_h=fread("C:\\Users\\Herve\\Dropbox\\Projet\\Projets R\\March Madness\\seasons.csv",header=TRUE)
str(season_h)

team=fread("C:\\Users\\Herve\\Dropbox\\Projet\\Projets R\\March Madness\\teams.csv",header=TRUE)
str(team)

tourney_h=fread("C:\\Users\\Herve\\Dropbox\\Projet\\Projets R\\March Madness\\tourney_compact_results.csv",header=TRUE)
str(tourney_h)

tourney_d_h=fread("C:\\Users\\Herve\\Dropbox\\Projet\\Projets R\\March Madness\\tourney_detailed_results.csv",header=TRUE)
str(tourney_d_h)

tourney_seeds_h=fread("C:\\Users\\Herve\\Dropbox\\Projet\\Projets R\\March Madness\\tourney_seeds.csv",header=TRUE)
str(tourney_seeds_h)

tourney_slots_h=fread("C:\\Users\\Herve\\Dropbox\\Projet\\Projets R\\March Madness\\tourney_slots.csv",header=TRUE)
str(tourney_slots_h)

View(result_season_h)

annee=tourney_h_2014=tourney_h[season==2014]

# Les tops 5 sur tous les ans ----------------------------------------------------------


herve=function(x)
{
  result_all=result_season_h[season==x][,.N,by=wteam][order(N,decreasing=TRUE)]
  top5_team=team[team_id %in% head(result_2014[,wteam],5)]
}
 
herve2=lapply(unique(result_season_h[order(season,decreasing=TRUE),season]),herve)

herve3=do.call(rbind,herve2)

herve4=herve3[,.N,by=team_name][order(N,decreasing=TRUE)]
tail(herve4,1)


# Voir plus en detail juste pour 2014 ----------------------------------------------------

# Les 5 equipes qui ont remporte le plus de match 
result_2014=result_season_h[season==2014][,.N,by=wteam][order(N,decreasing=TRUE)]
top32_team_2014=team[team_id %in% head(result_2014[,wteam],32)]



# pour toutes les annees --------------------------------------------------

id_winners=tourney_h[daynum==max(daynum),wteam,by=season]
team_winners=team[team_id %in% id_winners,team_name]

setnames(id_winners,"wteam","team_id")
setkey(team,team_id)
setkey(id_winners,team_id)

annee_winners=merge(id_winners,team)[base::order(season,decreasing=TRUE)]

annee_winners[,list(.N,vieux=min(season),recent=max(season)),by=team_name]

annee_winners_top3=head(annee_winners[,team_name],3)

# Pour les 3 derniers gagnants --------------------------------------------

# recherche de donnees ----------------------------------------------------


# aller chercher tous les url de chaque equipe!

####premier web scrapping

require(RCurl)
require(plyr)


all_team_ever= readHTMLTable("http://www.sports-reference.com/cbb/schools/")
all_team_ever2=data.table(ldply(all_team_ever, data.frame))
View(all_team_ever2)
str(all_team_ever2)
setkey(all_team_ever2,From)
all_team_ever3=all_team_ever2[!"From"]
str(all_team_ever3)
all_team_ever4=all_team_ever3[,.id:=NULL]
### Prendre les urls et faire de la magie


all_team_script=getURL("http://www.sports-reference.com/cbb/schools/")
team_doc=htmlParse(all_team_script) 
team_nodes=getNodeSet(team_doc,"//table[@id='schools']//td[@align='left']//a")
team_nodes_todate=getNodeSet(team_doc,"//table[@id='schools']//td[@align='center']")

list_team_name_url=lapply(team_nodes,xmlValue)
name_team=do.call(rbind,list_team_name_url)

list_url_team=lapply(team_nodes,xmlGetAttr,"href")
url_team=do.call(rbind,list_url_team)

team_hack1=data.table(cbind(name_team,url_team))
setnames(team_hack1,c("V1","V2"),c("team_name","team_url"))
setnames(all_team_ever4,"School","team_name")

setkey(team_hack1,team_name)
setkey(all_team_ever4,team_name)

team_hacked2=merge(all_team_ever4,team_hack1)
View(team_hacked2)

# Aller chercher pour chaque equipe les joueurs ---------------------------

paste_url=paste(rep("http://www.sports-reference.com",nrow(team_hacked2)),team_hacked2[,team_url],sep="")
team_hacked3=cbind(team_hacked2,paste_url)
str(team_hacked3)
