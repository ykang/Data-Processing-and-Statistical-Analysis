library(rvest)
library(knitr)
library(stringr)
library(utils)

get_url <- function(start) {
  url <-
    paste('https://movie.douban.com/top250?start=', start * 25, sep = '')
  return(url)
}
get_content <- function(url) {
  web <- read_html(url, encoding = "utf-8")
  movie_title <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a/span[1]') %>%
    html_text()
  link <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a') %>%
    html_attr('href')
  number_of_rating <- web %>%
    html_nodes(xpath = '//div[@class="star"]/span[4]') %>%
    html_text()
  rating <- web %>%
    html_nodes(xpath = '//div[@class="star"]/span[@class="rating_num"]') %>%
    html_text()
  
  movies <- data.frame(movie_title, link, number_of_rating , rating)
  return(movies)
}
movies <- data.frame()
for (i in 0:0) {
  url <- get_url(i)
  movies = rbind(movies, get_content(url))
  
}
write.csv(movies, file = "Doban250.csv")