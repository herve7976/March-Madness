library(XML)
library(data.table)
require(RCurl)
require(plyr)



# Fonctions de recherches pout les joueurs grace a la table des ur --------




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