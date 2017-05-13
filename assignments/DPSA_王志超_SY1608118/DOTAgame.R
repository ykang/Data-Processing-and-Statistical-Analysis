####==== 准备 ====####
setwd('D://R//DataProcessing')
rm(list = ls())
library('rvest')

####====  基辅特锦赛比赛信息 ====####

##== 英雄中英文名称对应 ==##
url.hero = 'http://www.dotamax.com/hero/'
web.hero = read_html(url.hero)
node.hero = html_nodes(web.hero, xpath = '//div[@class="hero-list-hero Unused-Hero"]')
hero.name.Chinese = html_attr(node.hero, 'id')
hero.name.English = html_attr(node.hero, 'onclick')
#- 提取英文名函数 -#
GetHeroEnglish = function(x) {
  x.strsplit = strsplit(x, split = '/')[[1]]
  x.name.English = x.strsplit[4]
  return(x.name.English)
}
hero.name.English = apply(as.matrix(hero.name.English), 1, GetHeroEnglish)
hero.name = data.frame(Chinese = hero.name.Chinese,
                       English = hero.name.English)
rm(hero.name.Chinese, hero.name.English)

##== 物品中英文名称对应 ==##
url.item = 'http://www.dotamax.com/item/'
web.item = read_html(url.item)
node.item.Chinese = html_nodes(web.item, xpath = '//table[@class="table table-hover table-striped sortable table-list"]')
item.name.Chinese = (html_table(node.item.Chinese)[[1]]) $ X1
node.item.English = html_nodes(web.item, xpath = '//table[@class="table table-hover table-striped sortable table-list"]/tbody//tr')
item.name.English = html_attr(node.item.English, 'onclick')
#- 提取英文名函数 -#
GetItemEnglish = function(x) {
  x.strsplit = strsplit(x, split = '/')[[1]]
  x.name.English = x.strsplit[4]
  x.name.English = gsub('\')', '', x.name.English)
  return(x.name.English)
}
item.name.English = apply(as.matrix(item.name.English), 1, GetItemEnglish)
item.name = data.frame(Chinese = item.name.Chinese,
                       English = item.name.English)
rm(item.name.Chinese, item.name.English)

##== 获取比赛地址 ==##
#- 获取比赛函数 -#
GetList = function(url) {
  list.reporter = NULL
  for (i in 1 : length(url)) {
    web.list = read_html(url[i])
    node.list = html_nodes(web.list, xpath = '//tr[@style="cursor: pointer;"]/td[1]')
    list.tmp = html_text(node.list)
    list.reporter = c(list.reporter, list.tmp)
  }
  list.reporter = paste('http://www.dotamax.com/match/detail/', list.reporter, sep = '')
  return(list.reporter)
}
page.list = 23
url.list = paste('http://www.dotamax.com/match/tour_matches/?league_id=5157&skill=&ladder=&p=', 1 : page.list, sep = '')
game.list = GetList(url.list)  #比赛地址

##== 获取比赛信息 ==##
#- 获取一血时间函数 -#
GetFirst = function(x) {
  x.strsplit = strsplit(x, split = ':')[[1]]
  x.numeric = as.numeric(x.strsplit)
  x.second = x.numeric[1] * 3600 + x.numeric[2] * 60 + x.numeric[3]
  return(x.second)
}
#- 获取分类信息函数 -#
GetClass = function(x) {
  x.id = x[2, 1]
  x.time = sub('分钟', '', x[2, 3])
  x.time = as.numeric(x.time) * 60
  x.area = x[2, 4]
  x.first = x[2, 5]
  x.first = GetFirst(x.first)
  x.skill = x[2, 6]
  x.form = x[2, 7]
  x.dataframe = data.frame(比赛ID = x.id,
                             持续时间  = x.time,
                             区域 = x.area,
                             一血时间 = x.first,
                             比赛级别 = x.skill,
                             比赛模式 = x.form)
  return(x.dataframe)
}
#- 禁选信息函数 -#
GetBP = function(x) {
  x.strsplit = strsplit(x, split = '/')[[1]]
  x.bp = x.strsplit[4]
  return(x.bp)
}
#- 详细信息 -#
GetDetail = function(x) {
  # 第三列 #
  x.MVP = grepl('MVP', x[, 3])
  x.grade = as.numeric(gsub('MVP', '', x[, 3]))
  # 第四列 #
  x.tmp = strsplit(x[, 4], split = '/')
  x.kill = NULL
  x.die = NULL
  x.assistance = NULL
  for (i in 1 : length(x.tmp)) {
    kill.tmp = strsplit(x.tmp[[i]], split = ' ')[[1]][2]
    x.kill = c(x.kill, kill.tmp)
    die.tmp = gsub(' ', '', x.tmp[[i]][2])
    x.die = c(x.die, die.tmp)
    assistance.tmp = gsub(' ', '', x.tmp[[i]][3])
    x.assistance = c(x.assistance, assistance.tmp)
  }
  x.kill = as.numeric(x.kill)
  x.die = as.numeric(x.die)
  x.assistance = as.numeric(x.assistance)
  # 第五列 #
  x.joint = as.numeric(gsub('%', '', x[, 5])) / 100
  # 第六列 #
  x.dps.percentage = as.numeric(gsub('%', '', x[, 6])) / 100
  # 第七列 #
  x.dps = as.numeric(x[, 7])
  # 第八列 #
  x.tmp = strsplit(x[, 8], split = '/')
  x.soldier = NULL
  x.antisoldier = NULL
  for (i in 1 : length(x.tmp)) {
    x.soldier = c(x.soldier, x.tmp[[i]][1])
    x.antisoldier = c(x.antisoldier, x.tmp[[i]][2])
  }
  x.soldier = as.numeric(x.soldier)
  x.antisoldier = as.numeric(x.antisoldier)
  # 第九列 #
  x.experiment = as.numeric(x[, 9])
  # 第十列 #
  x.money = as.numeric(x[, 10])
  # 数据框 #
  x.dataframe = data.frame(MVP = x.MVP,
                           等级 = x.grade,
                           击杀 = x.kill,
                           死亡 = x.die,
                           助攻 = x.assistance,
                           参战率 = x.joint,
                           伤害百分比 = x.dps.percentage,
                           伤害量 = x.dps,
                           正补 = x.soldier,
                           反补 = x.antisoldier,
                           每分钟经验 = x.experiment,
                           每分钟金钱 = x.money)
  # 返回 #
  return(x.dataframe)
}
#- 转换形态 -#
TransformHero = function(x, total = hero.name) {
  name.Chinese = as.character(total $ Chinese)
  name.English = as.character(total $ English)
  indicator.hero = matrix(0, nrow = 1, ncol = length(name.English))
  colnames(indicator.hero) = paste('出场', name.Chinese, sep = '.')
  for (i in 1 : length(x)) {
    indicator = (name.English == x[i])
    indicator.hero[indicator] = 1
  }
  indicator.hero = as.data.frame(indicator.hero)
  return(indicator.hero)
}
TransformMVP = function(x, total = hero.name) {
  name.Chinese = as.character(total $ Chinese)
  name.English = as.character(total $ English)
  indicator.MVP = matrix(0, nrow = 1, ncol = length(name.English))
  colnames(indicator.MVP) = paste('MVP', name.Chinese, sep = '.')
  MVP = x[x[, 2], 1]
  indicator = (name.English == MVP)
  indicator.MVP[indicator] = 1
  indicator.MVP = as.data.frame(indicator.MVP)
  return(indicator.MVP)
}
TransformNumeric = function(x, name, variable, total = hero.name) {
  name.Chinese = as.character(total $ Chinese)
  name.English = as.character(total $ English)
  indicator.hero = matrix(0, nrow = 1, ncol = length(name.English))
  colnames(indicator.hero) = paste(variable, name.Chinese, sep = '.')
  for (i in 1 : length(name)) {
    indicator = (name.English == name[i])
    indicator.hero[indicator] = x[i]
  }
  indicator.hero = as.data.frame(indicator.hero)
  return(indicator.hero)
}
#- 获取所有信息 -#
GetSample = function(url) {
  wrong = numeric()
  game.dataframe = NULL
  for (i in 1 : length(url)) {
    print(paste('[', i, '] ', url[i], sep = ''))
    web = read_html(url[i])
    #- 比赛双方 -#
    node.team.1 = html_node(web, xpath = '//p[@class="radiant"]/a')
    game.team.1 = html_text(node.team.1)
    game.team.1 = gsub('\r\n', '', game.team.1)
    game.team.1 = gsub(' ', '', game.team.1)
    node.team.2 = html_node(web, xpath = '//p[@class="dire"]/a')
    game.team.2 = html_text(node.team.2)
    game.team.2 = gsub('\r\n', '', game.team.2)
    game.team.2 = gsub(' ', '', game.team.2)
    game.team = data.frame(队伍.天辉 = game.team.1,
                           队伍.夜魇 = game.team.2)
    #- 比赛胜负 -#
    node.winner = html_nodes(web, xpath = '//span[@class="hero-title"]/font')
    game.winner = html_text(node.winner)
    game.winner = gsub('获胜', '', game.winner)
    game.winner = data.frame(胜者 = game.winner)
    #- 分类信息 -#
    node.class = html_nodes(web, xpath = '//table[@class="match-detail-info new-box"]')
    game.class = html_table(node.class)[[1]]
    game.class = GetClass(game.class)
    #- 禁选信息 -#
    node.bp = html_nodes(web, xpath = '//div[@style="float:left;position: relative;border: 0px solid #ffffff;text-align: left ;"]/a')
    game.bp = html_attr(node.bp, 'href')
    game.bp = apply(as.matrix(game.bp), 1, GetBP)
    ban = c(1, 11, 2, 12, 15, 5, 16, 6, 19, 9)  #禁止顺序
    pick = c(3, 13, 14, 4, 17, 7, 18, 8, 10, 20)  #选择顺序
    game.ban = matrix(game.bp[ban], nrow = 1)
    colnames(game.ban) = paste('禁止', 1 : 10, sep = '')
    game.pick = matrix(game.bp[pick], nrow = 1)
    colnames(game.pick) = paste('选择', 1 : 10, sep = '')
    #- 详细信息 -#
    # 天辉数据 #
    node.radiant = html_nodes(web, xpath = '//table[@class="reptable reptable-radiant"]')
    # 出错的场次跳过 #
    if (!length(node.radiant)) {
      wrong = c(wrong, i)
      next
    }
    else
      node.radiant = node.radiant[[1]]
    game.table.radiant = html_table(node.radiant)[-1, ]
    game.table.radiant = GetDetail(game.table.radiant)
    # 夜魇数据 #
    node.dire = html_nodes(web, xpath = '//table[@class="reptable reptable-dire"]')
    # 出错的场次跳过 #
    if (!length(node.dire)) {
      wrong = c(wrong, i)
      next
    }
    else
      node.dire = node.dire[[1]]
    game.table.dire = html_table(node.dire)[-1, ]
    game.table.dire = GetDetail(game.table.dire)
    # 拼接 #
    game.table = rbind(game.table.radiant, game.table.dire)
    node.corresponding = html_nodes(web, xpath = '//td[@style="position: relative;"]/a')
    game.corresponding = html_attr(node.corresponding, 'href')
    game.corresponding = apply(as.matrix(game.corresponding), 1, GetHeroEnglish)
    game.table $ 英雄 = game.corresponding
    game.table = game.table[, c(13, 1 : 12)]
    #- 转换形态 -#
    table.sample = cbind(game.class, game.team, game.winner, game.ban, game.pick)
    for (j in 1 : ncol(game.table)) {
      if (j == 1)
        game.tmp = TransformHero(x = game.table[, 1])
      else if (j == 2)
        game.tmp = TransformMVP(x = game.table[, 1 : 2])
      else
        game.tmp = TransformNumeric(game.table[, j], game.table[, 1], names(game.table)[j])
      table.sample = cbind(table.sample, game.tmp)
    }
    game.dataframe = rbind(game.dataframe, table.sample)
  }
  #- 输出结果 -#
  write.csv(game.dataframe, '比赛信息表.csv', row.names = FALSE)
  game.wrong <<- wrong  #报错场次编号
  return(game.dataframe)
}
game.all = GetSample(game.list)
# 报错的比赛场次（448场中共40场） #
# 22  33  36  53  70  77  88  90  91  93  94 115 122 136 146 149 166 178 187 194 204 207 209 211
# 261 262 264 266 268 281 282 292 297 311 318 362 378 401 421 422