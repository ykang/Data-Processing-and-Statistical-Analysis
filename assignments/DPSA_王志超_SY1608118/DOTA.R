####==== 准备 ====####
setwd('D://R//DataProcessing')
rm(list = ls())
library('rvest')

#####==== 玩家信息表 ====####

##== 提取玩家信息 ==##
GetPlayer = function(link, rateTonumeric) {
  web = read_html(link)
  #- 原始表格 -#
  node.table = html_nodes(web, xpath = '//table[@class="sortable league_table"]')
  player.table = html_table(node.table)[[1]]
  #- 表格列名 -#
  node.title = html_nodes(web, xpath = '//table[@class="sortable league_table"]/thead//th')
  table.title = html_text(node.title)
  table.title = gsub(' ', '', table.title)
  names(player.table) = table.title
  #- 整理数据 -#
  p = ncol(player.table)
  player.table $ 战队 = apply(as.matrix(player.table $ 玩家), 1, GetTeam) #提取战队名称
  player.table $ 玩家 = apply(as.matrix(player.table $ 玩家), 1, GetName) #提取玩家ID
  # 转换胜率 #
  for (i in 1 : length(rateTonumeric))
    player.table[, rateTonumeric[i]] = apply(as.matrix(player.table[, rateTonumeric[i]]), 1, GetWinRate)
  #- 调换顺序 -#
  player.table = player.table[, c(p + 1, 1 : p)]
  #- 返回 -#
  return(player.table)
}

##== 提取战队名称 ==##
GetTeam = function(x) {
  x.split = strsplit(x, split = '.', fixed = TRUE)[[1]]
  if (length(x.split) > 2)
    team = paste(x.split[1 : 2], sep = '', collapse = '.') #战队名称 ig.V 被拆分
  else
    team = x.split[1]
  return(team)
}

##== 提取玩家ID ==##
GetName = function(x) {
  x.split = strsplit(x, split = '.', fixed = TRUE)[[1]]
  name = x.split[length(x.split)]
  return(name)
}

##== 获取数值型胜率 ==##
GetWinRate = function(x) {
  x = as.numeric(sub('%', '', x))
  x = x / 100
  return(x)
}
player.table = NULL
url.player = 'http://www.dotamax.com/match/tour_league_players/?league_id=5157&skill=&ladder=&p='  #有两页
for (i in 1 : 2) {
  url.tmp = paste(url.player, i, sep = '')
  message.tmp = GetPlayer(link = url.tmp, rateTonumeric = 5)
  player.table = rbind(player.table, message.tmp)
}

##== 输出结果 ==##
write.csv(player.table, '玩家信息表.csv', row.names = FALSE)
rm(i, url.tmp, message.tmp)

####==== 英雄信息表 ====####

##== 提取英雄信息 ==##
GetHero = function(link, rateTonumeric) {
  web = read_html(link)
  #- 原始表格 -#
  node.table = html_nodes(web, xpath = '//table[@class="sortable league_table"]')
  hero.table = html_table(node.table)[[1]]
  #- 表格列名 -#
  node.title = html_nodes(web, xpath = '//table[@class="sortable league_table"]/thead//th')
  table.title = html_text(node.title)
  table.title = gsub(' ', '', table.title)
  names(hero.table) = table.title
  #- 整理数据 -#
  for (i in 1 : length(rateTonumeric))
    hero.table[, rateTonumeric[i]] = apply(as.matrix(hero.table[, rateTonumeric[i]]), 1, GetWinRate)
  #- 返回 -#
  return(hero.table)
}

##== 上场英雄信息 ==##
url.hero = 'http://www.dotamax.com/match/tour_league_heroes/?league_id=5157'
hero.table = GetHero(link = url.hero, rateTonumeric = 3)

##== 禁选英雄信息 ==##
url.bp = 'http://www.dotamax.com/match/tour_league_bp/?league_id=5157'
bp.table = GetHero(link = url.bp, rateTonumeric = c(3, 4, 7, 8))

##== 英雄信息合并 ==##
hero.diff = setdiff(bp.table $ 英雄, hero.table $ 英雄) #两个数据框差4个样本
hero.table = rbind(hero.table[1 : 4, ], hero.table) #补齐数据框长度
hero.table[1 : 4, 1] = hero.diff #添加英雄名称
hero.table[1 : 4, -1] = 0 #补零
hero.table.both = merge(hero.table, bp.table, by.x = '英雄', by.y = '英雄') #数据框合并

##== 输出结果 ==##
write.csv(hero.table.both, '英雄信息表.csv', row.names = FALSE)