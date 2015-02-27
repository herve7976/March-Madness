
result_season_h[,.N,by=season]

result_2014=result_season_h[season==x]
result_2014_equipe=result_2014[.N,by=wteam]
result_2014_equipe=result_2014_equipe[order(N,decreasing=TRUE)]
top5_team=team[team_id %in% head(result_2014_equipe[,wteam],5)]
 
herve=function(x)
{
  result_2014=result_season_h[season==x][,.N,by=wteam][order(N,decreasing=TRUE)]
  top5_team=team[team_id %in% head(result_2014[,wteam],5)]
}

bla2=readHTMLTable("http://www.sports-reference.com/cbb/schools/youngstown-state/2000.html")

bherve2=lapply(unique(result_season_h[order(season,decreasing=TRUE),season]),herve)

herve3=do.call(rbind,herve2)

herve4=herve3[,.N,by=team_name][order(N,decreasing=TRUE)]
herve4

d1 <- data.table(c=rep(1:2,each=3), b=1:6, key="c,b")
d2 <- data.table(a=0:1, bb=10:11, key="a")
d3 <- data.table(c=0:1, key="c")
d4 <- data.table(a=0:1, b=0:1, key="a,b")


merge(d1, d3)
merge(d2, d1)



names(all_team_ever2)
###Prendre 



script <- getURL("www.r-bloggers.com")
doc <- htmlParse(script)
li <- getNodeSet(doc, "//ul[@class='xoxo blogroll']//a")



all_team_script=getURL("http://www.sports-reference.com/cbb/schools/")
team_doc=htmlParse(all_team_script) 
team_nodes=getNodeSet(team_doc,"//table")

team_nodes=getNodeSet(team_doc,"//table[@id='schools']//td[@align='left']")


team_nodes=getNodeSet(team_doc,"//td[@align='left']")

team_hacked3[3,paste_url]
        
readHTMLTable(team_hacked3[3,paste_url])

base_url="http://www.sports-reference.com"

essaie_url=getURL(team_hacked3[3,paste_url])
essaie_doc=htmlParse(essaie_url)
essaie_nodes=getNodeSet(essaie_doc,"//table[@id]//td[@align='left']//a")
essaie_nodes2=lapply(essaie_nodes,xmlGetAttr,"href")
essaie_node3=data.table(do.call(rbind,essaie_nodes2))
essaie_nodes4=lapply(essaie_nodes,xmlValue)
essaie_node5=data.table(do.call(rbind,essaie_nodes4))


essaie81=essaie_node3[grep("schools",V1)]
essaie8=essaie81[1:min(grep("2001",V1))]

essaie6=essaie_node5[grep("[[:digit:]]",V1)]
essaie7=essaie6[1:min(grep("2000",V1))]

cbind(essaie7,paste(rep(base_url,nrow(essaie8)),essaie8[,V1],sep=""))


bla2=readHTMLTable("http://www.sports-reference.com/cbb/schools/youngstown-state/2000.html")

bla3=readHTMLTable("http://www.sports-reference.com/cbb/schools/youngstown-state/2010.html")

str(bla2)
str(bla3)

teams_seasons_url2

seasons_joueurs_nouveaux=teams_seasons_url2[season>=2010]
seasons_joueurs_anciens=teams_seasons_url2[season<2010]

get_everything_anciens=function(x){readHTMLTable(seasons_joueurs_anciens[x,seasons_url])}

get_roster_a=function(x){

  cbind(everything_player[[x]]$roster,team_name=rep(seasons_joueurs_anciens[x,team_name],nrow(everything_player[[x]]$roster)),season=rep(seasons_joueurs_anciens[x,season],nrow(everything_player[[x]]$roster)))
}
get_team_stats_a=function(x){
  
  cbind(everything_player[[x]]$team_stats,team_name=rep(seasons_joueurs_anciens[x,team_name],nrow(everything_player[[x]]$team_stats)),season=rep(seasons_joueurs_anciens[x,season],nrow(everything_player[[x]]$team_stats)))
  
}

get_totals_a=function(x){
  
  
  cbind(everything_player[[x]]$totals,team_name=rep(seasons_joueurs_anciens[x,team_name],nrow(everything_player[[x]]$totals)),season=rep(seasons_joueurs_anciens[x,season],nrow(everything_player[[x]]$totals)))
}

get_per_game_a=function(x){
  
  cbind(everything_player[[x]]$per_game,team_name=rep(seasons_joueurs_anciens[x,team_name],nrow(everything_player[[x]]$per_game)),season=rep(seasons_joueurs_anciens[x,season],nrow(everything_player[[x]]$per_game)))
}

get_per_min_a=function(x){
  
  cbind(everything_player[[x]]$per_min,team_name=rep(seasons_joueurs_anciens[x,team_name],nrow(everything_player[[x]]$per_min)),season=rep(seasons_joueurs_anciens[x,season],nrow(everything_player[[x]]$per_min)))
}

get_per_poss_a=function(x){
  
  cbind(everything_player[[x]]$per_poss,team_name=rep(seasons_joueurs_anciens[x,team_name],nrow(everything_player[[x]]$per_poss)),season=rep(seasons_joueurs_anciens[x,season],nrow(everything_player[[x]]$per_poss)))
}

get_advanced_a=function(x){
  
  cbind(everything_player[[x]]$advanced,team_name=rep(seasons_joueurs_anciens[x,team_name],nrow(everything_player[[x]]$advanced)),season=rep(seasons_joueurs_anciens[x,season],nrow(everything_player[[x]]$advanced)))
}

everything_player=lapply(1:20,get_everything_a)
roster_players_a=lapply(1:20,get_roster_a)
team_stats_players_a=lapply(1:20,get_team_stats_a)
totals_players_a=lapply(1:20,get_totals_a)
per_game_players_a=lapply(1:20,get_per_game_a)
per_min_players_a=lapply(1:20,get_per_min_a)
per_poss_players_a=lapply(1:20,get_per_poss_a)
advanced_players_a=lapply(1:20,get_advanced_a)

data_roster_a=data.table(do.call(rbind,roster_players_a))
data_team_stats_a=data.table(do.call(rbind,team_stats_players_a))
data_totals_a=data.table(do.call(rbind,totals_players_a))
data_per_game_a=data.table(do.call(rbind,per_game_players_a))
data_per_min_a=data.table(do.call(rbind,per_min_players_a))
data_per_poss_a=data.table(do.call(rbind,per_poss_players_a))
data_advanced_a=data.table(do.call(rbind,advanced_players_a))






# POUR LES NOUVEAUX -------------------------------------------------------





get_everything_nouveaux=function(x){readHTMLTable(seasons_joueurs_nouveaux[x,seasons_url])}

get_advanced_conf_n=function(x){
  
  cbind(everything_player[[x]]$advanced_conf,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$advanced_conf)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$advanced_conf)))
}
get_per_game_conf_n=function(x){
  
  cbind(everything_player[[x]]$per_game_conf,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$per_game_conf)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$per_game_conf)))
}

get_per_min_conf_n=function(x){
  
  cbind(everything_player[[x]]$per_min_conf,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$per_min_conf)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$per_min_conf)))
}

get_per_poss_conf_n=function(x){
  
  cbind(everything_player[[x]]$per_poss_conf,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$per_poss_conf)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$per_poss_conf)))
}

get_totals_conf_n=function(x){
  
  cbind(everything_player[[x]]$totals_conf,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$totals_conf)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$totals_conf)))
}

get_team_stats_conf_n=function(x){
  
  cbind(everything_player[[x]]$team_stats_conf,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$team_stats_conf)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$team_stats_conf)))
}

get_roster_n=function(x){
  
  cbind(everything_player[[x]]$roster,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$roster)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$roster)))
}

get_team_stats_n=function(x){
  
  cbind(everything_player[[x]]$team_stats,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$team_stats)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$team_stats)))
  
}

get_totals_n=function(x){
  
  
  cbind(everything_player[[x]]$totals,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$totals)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$totals)))
}

get_per_game_n=function(x){
  
  cbind(everything_player[[x]]$per_game,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$per_game)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$per_game)))
}

get_per_min_n=function(x){
  
  cbind(everything_player[[x]]$per_min,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$per_min)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$per_min)))
}

get_per_poss_n=function(x){
  
  cbind(everything_player[[x]]$per_poss,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$per_poss)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$per_poss)))
}

get_advanced_n=function(x){
  
  cbind(everything_player[[x]]$advanced,team_name=rep(seasons_joueurs_nouveaux[x,team_name],nrow(everything_player[[x]]$advanced)),season=rep(seasons_joueurs_nouveaux[x,season],nrow(everything_player[[x]]$advanced)))
}

everything_player=lapply(1:20,get_everything_nouveaux)
roster_players_n=lapply(1:20,get_roster_n)
team_stats_players_n=lapply(1:20,get_team_stats_n)
totals_players_n=lapply(1:20,get_totals_n)
per_game_players_n=lapply(1:20,get_per_game_n)
per_min_players_n=lapply(1:20,get_per_min_n)
per_poss_players_n=lapply(1:20,get_per_poss_n)
advanced_players_n=lapply(1:20,get_advanced_n)
team_stats_players_conf_n=lapply(1:20,get_team_stats_conf_n)
totals_players_conf_n=lapply(1:20,get_totals_conf_n)
per_game_players_conf_n=lapply(1:20,get_per_game_conf_n)
per_min_players_conf_n=lapply(1:20,get_per_min_conf_n)
per_poss_players_conf_n=lapply(1:20,get_per_poss_conf_n)
advanced_players_conf_n=lapply(1:20,get_advanced_conf_n)

data_roster_n=data.table(do.call(rbind,roster_players_n))
data_team_stats_n=data.table(do.call(rbind,team_stats_players_n))
data_totals_n=data.table(do.call(rbind,totals_players_n))
data_per_game_n=data.table(do.call(rbind,per_game_players_n))
data_per_min_n=data.table(do.call(rbind,per_min_players_n))
data_per_poss_n=data.table(do.call(rbind,per_poss_players_n))
data_advanced_n=data.table(do.call(rbind,advanced_players_n))
data_team_stats_conf_n=data.table(do.call(rbind,team_stats_players_conf_n))
data_totals_conf_n=data.table(do.call(rbind,totals_players_conf_n))
data_per_game_conf_n=data.table(do.call(rbind,per_game_players_conf_n))
data_per_min_conf_n=data.table(do.call(rbind,per_min_players_conf_n))
data_per_poss_conf_n=data.table(do.call(rbind,per_poss_players_conf_n))
data_advanced_conf_n=data.table(do.call(rbind,advanced_players_conf_n))
