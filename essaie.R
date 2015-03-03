
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

team_2014=teams_seasons_url2[season==2014]


x=data.table(tourney_d_h[season==2014]$wteam)
y=data.table(tourney_d_h[season==2014]$lteam)

team_tourney_2014=rbind(x,y)
setnames(team_tourney_2014,"V1","team_id")
team_tourney_2014=unique(team_tourney_2014)
setkey(team,team_id)
setkey(team_tourney_2014,team_id)

team_tourney_2014_2=merge(team,team_tourney_2014)
team_tourney_2014_3=team_tourney_2014_2[order(team_name)]

liste_nom=unique(teams_seasons_url2$team_name)
name_tourney=data.table(team_name_bis=c(
"Albany (NY) Great Danes",
"American Eagles",
"Arizona Wildcats",
"Arizona State Sun Devils",
"Baylor Bears",
"Brigham Young Cougars",
"Cal Poly Mustangs" ,
"Cincinnati Bearcats",
"Coastal Carolina Chanticleers", 
"Colorado Buffaloes",
"Connecticut Huskies",
"Creighton Bluejays",
"Dayton Flyers",
"Delaware Fightin' Blue Hens",
"Duke Blue Devils",
"Eastern Kentucky Colonels",
"Florida Gators",
"George Washington Colonials",
"Gonzaga Bulldogs",
"Harvard Crimson",
"Iowa Hawkeyes" ,
"Iowa State Cyclones",
"Kansas Jayhawks",
"Kansas State Wildcats",
"Kentucky Wildcats",
"Louisville Cardinals",
"Manhattan Jaspers",
"Massachusetts Minutemen",
"Memphis Tigers",
"Mercer Bears",
"Michigan Wolverines",
"Michigan State Spartans",
"Mount St. Mary's Mountaineers", 
"North Dakota State Bison",  
"North Carolina Central Eagles",
"North Carolina State Wolfpack",
"Nebraska Cornhuskers",
"New Mexico Lobos",
"New Mexico State Aggies",
"North Carolina Tar Heels",
"Ohio State Buckeyes",
"Oklahoma Sooners",
"Oklahoma State Cowboys",
"Oregon Ducks",
"Pittsburgh Panthers",
"Providence Friars",
"San Diego Toreros",
"San Diego State Aztecs", 
"Saint Joseph's Hawks",
"Saint Louis Billikens",
"Stanford Cardinal",
"Syracuse Orange",
"Tennessee Volunteers",
"Texas Longhorns",
"Tulsa Golden Hurricane",
"Texas Southern Tigers",
"UCLA Bruins" ,
"Louisiana-Lafayette Ragin' Cajuns",
"Virginia Commonwealth Rams",
"Villanova Wildcats",
"Virginia Cavaliers",
"Western Michigan Broncos",  
"Weber State Wildcats", 
"Milwaukee Panthers",
"Wichita State Shockers",
"Wisconsin Badgers", 
"Wofford Terriers",
"Xavier Musketeers"))

team_name_tourney_2014_4=cbind(team_tourney_2014_3,name_tourney)

"http://www.sports-reference.com/cbb/schools/virginia-commonwealth/2014-schedule.html"

essaie=getURL("http://www.sports-reference.com/cbb/schools/virginia-commonwealth/2014-schedule.html")
essaie2=htmlParse(essaie)
essaie3=getNodeSet(essaie2,"//table[@id='schedule']//td[@csk]//a")
