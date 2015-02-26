library(XML)
library(data.table)

# setwd("C:/Users/Herve/Dropbox/Projet/Projets R/March-Madness")

result_season_h=fread("regular_season_compact_results.csv",header=TRUE)
# str(result_season_h)


result_season_d_h=fread("regular_season_detailed_results.csv",header=TRUE)
# str(result_season_d_h)

season_h=fread("seasons.csv",header=TRUE)
# str(season_h)

team=fread("teams.csv",header=TRUE)
# str(team)

tourney_h=fread("tourney_compact_results.csv",header=TRUE)
# str(tourney_h)

tourney_d_h=fread("tourney_detailed_results.csv",header=TRUE)
# str(tourney_d_h)

tourney_seeds_h=fread("tourney_seeds.csv",header=TRUE)
# str(tourney_seeds_h)

tourney_slots_h=fread("tourney_slots.csv",header=TRUE)
# str(tourney_slots_h)

View(result_season_h)


# Voir plus en detail juste pour 2014 ----------------------------------------------------

# Les 5 equipes qui ont remporte le plus de match 
result_2014=result_season_h[season==2014][,.N,by=wteam][order(N,decreasing=TRUE)]
top32_team_2014=team[team_id %in% head(result_2014[,wteam],32)]

# Les tops 5 sur tous les ans ----------------------------------------------------------


herve=function(x)
{
  result_all=result_season_h[season==x][,.N,by=wteam][order(N,decreasing=TRUE)]
  top5_team=team[team_id %in% head(result_2014[,wteam],5)]
}

herve2=lapply(unique(result_season_h[order(season,decreasing=TRUE),season]),herve)

herve3=do.call(rbind,herve2)

herve4=herve3[,.N,by=team_name][order(N,decreasing=TRUE)]




# pour toutes les annees --------------------------------------------------

id_winners=tourney_h[tourney_h$daynum==max(daynum),wteam,by=season]
team_winners=team[team_id %in% id_winners$wteam,team_name]

setnames(id_winners,"wteam","team_id")
setkey(team,team_id)
setkey(id_winners,team_id)

annee_winners=merge(id_winners,team)[base::order(season,decreasing=TRUE)]

annee_winners2=annee_winners[,list(.N,vieux=min(season),recent=max(season)),by=team_name]

annee_winners3=annee_winners2[base::order(N,decreasing=TRUE)]
# Pour les 3 derniers gagnants --------------------------------------------

annee_winners_top3=head(annee_winners3[,team_name],3)


# recherche de donnees ----------------------------------------------------


# aller chercher tous les url de chaque equipe!

####premier web scrapping

require(RCurl)
require(plyr)


all_team_ever= readHTMLTable("http://www.sports-reference.com/cbb/schools/")
all_team_ever2=data.table(ldply(all_team_ever, data.frame))
# View(all_team_ever2)
# str(all_team_ever2)
setkey(all_team_ever2,From)
all_team_ever3=all_team_ever2[!"From"]
# str(all_team_ever3)
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


# Aller chercher pour chaque equipe les joueurs ---------------------------
base_url="http://www.sports-reference.com"
paste_url=paste(rep("http://www.sports-reference.com",nrow(team_hacked2)),team_hacked2[,team_url],sep="")
 team_hacked3=cbind(team_hacked2,paste_url)
 team_hacked4=team_hacked3[,team_url:=NULL]
 team_hacked4$From=as.numeric(as.character(team_hacked4$From))
 team_hacked4$To=as.numeric(as.character(team_hacked4$To)) #Extraction deja faite
#  write.table(team_hacked4,"all_team_ever.txt") #Extraction deja faite
# team_hacked4=fread("all_team_ever.txt",sep=" ",header=FALSE)
# bla=read.table("all_team_ever.txt",sep=" ")
team_hacked5=team_hacked4[From<=2000]
team_hacked6=team_hacked4[From>2000]
team_hacked7=team_hacked5[To>2000]
team_hacked8=team_hacked6[To>2000]


# find_seasons_url_2000=function(x){
#   
#     
#   essaie_url=getURL(team_hacked4[1,paste_url])
#   essaie_doc=htmlParse(essaie_url)
#   essaie_nodes=getNodeSet(essaie_doc,"//table[@id]//td[@align='left']//a")
#   essaie_nodes2=lapply(essaie_nodes,xmlGetAttr,"href")
#   essaie_node3=data.table(do.call(rbind,essaie_nodes2))
#   essaie_nodes4=lapply(essaie_nodes,xmlValue)
#   essaie_node5=data.table(do.call(rbind,essaie_nodes4))
#   
#   
#   essaie1=essaie_node3[grep("schools",V1)]
# #   essaie2=essaie1[1:min(grep("2001",V1))]
#   essaie3=essaie_node5[grep("[[:digit:]]",V1)]
#   essaie3$V1=as.character(essaie3$V1)
#   c=grepl("[a-zA-Z]",essaie3$V1)
# 
#   if(length(c[c==TRUE])>0){
#     
#     essaie4=essaie3[-grep("[a-zA-Z]",V1)]
#   }else{
#     essaie4=essaie3
#   }  
#   essaie5=cbind(rep(team_hacked4[x,team_name],nrow(essaie1)),seasons=essaie4,seasons_url=paste(rep(base_url,nrow(essaie1)),essaie1[,V1],sep=""))
#   essaie5$season=as.numeric(substr(as.character(essaie5$seasons.V1),1,4))
#   essaie6=essaie5[season>=2000]
# 
# }
# 
# # teams_seasons_url=lapply(1:nrow(team_hacked4),find_seasons_url_2000)
 teams_seasons_url2=do.call(rbind,teams_seasons_url)

setnames(teams_seasons_url2,names(teams_seasons_url2),c("team_name","season_name","seasons_url","season"))
write.table(names(teams_seasons_url2),"names_teams_seasons_url.txt")
write.table(teams_seasons_url2,"teams_seasons_url.txt")
# Aller cherches tous les joueurs de chaque equipe et de chaque sa --------


# un gros changement a partir de 2011 pour ce qui est des données
# Everythings seems good