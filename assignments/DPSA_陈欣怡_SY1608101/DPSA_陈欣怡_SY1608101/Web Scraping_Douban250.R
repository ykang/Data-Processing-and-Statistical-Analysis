

# =============================================
# Title: Web Scraping
# Author: Xinyi Chen
# Date: May 06, 2017
# =============================================

library(stringr)
library(data.table)
library(rvest)

#构建结果矩阵结构，并设置列名称
douban250 <-
  matrix(nrow = 75,
         ncol = 5,
         dimnames = list(
           c(1:75),
           c(
             'Movie Name',
             'Movie Link',
             'Movie Director',
             'Movie Stars',
             'Movie Introduction'
           )
         ))

#设置抓取的目标网页并读入数据,并设置循环读取前三页的数据
for (i in 1:3) {
  url <-
    paste('https://movie.douban.com/top250?start=',
          i - 1,
          '&filter=',
          sep = "")
  web <- read_html(url, encoding = "utf-8")
  
  #抓取电影名称
  movie_name <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a/span[1]') %>%
    html_text()
  
  #抓取电影链接
  movie_link <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a') %>%
    html_attr('href')
  
  #抓取电影导演
  movie_dirc_temp1 <- web %>%
    html_nodes(xpath = '//p[@class=""]') %>%
    html_text()
  movie_dirc_temp2 <- str_trim(movie_dirc_temp1)
  movie_dirc <-
    str_split(movie_dirc_temp2, " ", simplify = TRUE)[, 2]
  
  #抓取电影评分
  movie_stars <- web %>%
    html_nodes(xpath = '//div[@class="star"]/span[2]') %>%
    html_text()
  
  #抓取电影评语
  movie_intro <- web %>%
    html_nodes(xpath = '//p[@class="quote"]/span') %>%
    html_text()
  
  #将抓取的数据放进矩阵douban250中
  douban250[((i - 1) * 25 + 1):(i * 25), 1] <- movie_name
  douban250[((i - 1) * 25 + 1):(i * 25), 2] <- movie_link
  douban250[((i - 1) * 25 + 1):(i * 25), 3] <- movie_dirc
  douban250[((i - 1) * 25 + 1):(i * 25), 4] <- movie_stars
  douban250[((i - 1) * 25 + 1):(i * 25), 5] <- movie_intro
}

#输出成CSV文件到桌面
douban250 = as.data.table(
  douban250,
  keep.rownames = c(
    'Movie Name',
    'Movie Link',
    'Movie Director',
    'Movie Stars',
    'Movie Introduction'
  )
)
write.csv(douban250[, 2:6], file = "C:/Users/za/Desktop/douban250.csv", row.names = FALSE)
