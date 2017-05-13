library(rvest)
library(stringr)

douban_movies <- data.frame()

for (page in 1:10) {
  # 每开始爬取一页之前随机停顿2~5秒
  Sys.sleep(runif(1, 2, 5))
  
  url <- paste('https://movie.douban.com/top250?start=',(page-1)*25,'&filter=',sep='')
  web <- read_html(url, encoding = "utf-8")
  
  # 电影名称
  movie_title <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a/span[@class="title"][1]') %>%
    html_text()
  
  # 链接
  link <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a') %>%
    html_attr('href')

  # 评分
  review_score <- web %>%
    html_nodes(xpath = '//div[@class="star"]/span[@class="rating_num"]') %>%
    html_text()
  
  # 评价人数
  review_num <- str_extract(web %>%
    html_nodes(xpath = '//div[@class="star"]/span[4]') %>%
    html_text(),'[0-9]+')
  
  # 电影类型
  bd <- str_split(str_trim(web %>%
    html_nodes(xpath = '//div[@class="bd"]/p[1]') %>%
    html_text()),'/')
  kind = c()
  for (i in bd) {
    kind = c(kind, str_trim(i[length(i)]))
  }
  
  douban_movies <- rbind(douban_movies, data.frame(link, movie_title, kind, review_score, review_num))
}

write.table(douban_movies, file='douban_movies.csv', sep=',', row.names = FALSE)
