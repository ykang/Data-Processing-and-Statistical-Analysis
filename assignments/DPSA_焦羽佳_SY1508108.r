library(rvest)
douban_movie = data.frame()
for (i in 1:10) {
  url <- paste("https://movie.douban.com/top250?start=",25*(i-1),"&filter=",sep="")
  web <- read_html(url,encoding="utf-8")
  movie_title <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a/span[1]') %>%
    html_text()
  link <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a') %>%
    html_attr('href')
  movie_detail <- web %>%
    html_nodes(xpath = '//div[@class="bd"]/p[1]') %>%
    html_text()
  movie_num <- web %>%
    html_nodes(xpath = '//div[@class="bd"]/div/span[2]') %>%
    html_text()
  movie_evaluate <- web %>%
    html_nodes(xpath = '//div[@class="bd"]/div/span[4]') %>%
    html_text()
  douban_movie <- rbind(douban_movie,data.frame(movie_title, movie_detail,movie_num,movie_evaluate,link))
}
library(knitr)
kable(head(douban_movie),format = "html")