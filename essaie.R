
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

herve2=lapply(unique(result_season_h[order(season,decreasing=TRUE),season]),herve)

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

essaie_url=getURL(team_hacked3[3,paste_url])
essaie_doc=htmlParse(essaie_url)
essaie_nodes=getNodeSet(essaie_doc,"//table[@id]//td[@align='left']//a")
essaie_nodes2=lapply(essaie_nodes,xmlGetAttr,"href")
essaie_node3=data.table(do.call(rbind,essaie_nodes2))

essaie_node3[grep("schools",V1)]

