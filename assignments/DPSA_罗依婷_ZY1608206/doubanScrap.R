library(rvest)
#统计共计10页豆瓣电影的信息
movieNameTotal <- vector(length = 0)#电影名称
movieNoTotal <- vector(length = 0)#电影排名
movieScoreTotal <- vector(length = 0)#电影评分
evaluNumberTotal <- vector(length = 0)#评分人数
movieLinkTotal <- vector(length = 0)#电影详细信息链接

for (n in c(0,25,50,75,100,125,150,175,200,225,250)) {
  link <- 'https://movie.douban.com/top250?start=X&filter='
  datalink <-
    sub(
      pattern = 'X', replacement = n, 'https://movie.douban.com/top250?start=X&filter='
    )  #实现翻页
  web <- read_html(datalink, encoding = "utf-8")
  movieNo_nodes <- html_nodes(xpath = '//div[@class="pic"]//em',web)
  movieNo <- html_text(movieNo_nodes)  #获取电影排名
  movieNoTotal <- c(movieNoTotal,movieNo)
  movieName_nodes <-
    html_nodes(xpath = '//div[@class="hd"]//a/span[1]',web)
  movieName <- html_text(movieName_nodes)  #获取电影名称
  movieNameTotal <- c(movieNameTotal,movieName)
  movieScore_nodes <-
    html_nodes(xpath = '//div[@class="star"]/span[2]',web)
  movieScore <- html_text(movieScore_nodes)  #获取电影评分
  movieScoreTotal <- c(movieScoreTotal,movieScore)
  movieEvalu_nodes <-
    html_nodes(xpath = '//div[@class="star"]/span[4]',web)
  evaluNumber <- html_text(movieEvalu_nodes)  #获取评分人数
  evaluNumberTotal <- c(evaluNumberTotal,evaluNumber)
  movieLink_nodes <- html_nodes(xpath = '//div[@class="hd"]//a',web)
  movieLink <- html_attr(movieLink_nodes,'href')  #获取电影详细信息链接
  movieLinkTotal <- c(movieLinkTotal,movieLink)
}
movieTop250_info <-
  data.frame(movieNoTotal,movieNameTotal,  movieScoreTotal,evaluNumberTotal,movieLinkTotal)
write.table(movieTop250_info,file = "e:/Data Process/movieTop250_info.txt",sep =
              '      ')  #写入txt文件