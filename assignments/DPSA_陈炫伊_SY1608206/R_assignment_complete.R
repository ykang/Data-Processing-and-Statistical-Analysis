library(stringr)
get_movie_detail <- function(link){
  link = as.character(link)
  web = read_html(link)
  title <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a/span[@class="title"][1]') %>%
    html_text()
  link <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a') %>%
    html_attr('href')
  # link = paste('[Link](', link, sep='')
  # link <- paste(link, ')', sep='')
  director <- web %>%
    html_nodes(xpath = '//div[@class="bd"]/p') %>%
    html_text()
  star <- web %>%
    html_nodes(xpath = '//div[@class="star"]/span[@class="rating_num"]') %>%
    html_text()
  quote <- web %>%
    html_nodes(xpath = '//p[@class="quote"]/span[@class="inq"]') %>%
    html_text()
  douban_movies <- data.frame(title,link,director,star,quote)
  return(douban_movies)
}

movies <- data.frame()
for (i in 1:10){
  page = 25 * (i-1)
  webpage=paste('https://movie.douban.com/top250?start=',paste(page,'&filter=',sep=''),sep='')
  print(webpage)
  movies = rbind(movies, get_movie_detail(webpage))
}
kable(head(movies),format = "html")
write.table (movies, file ="E:/学习/研究生/dpsa/movies.csv")

