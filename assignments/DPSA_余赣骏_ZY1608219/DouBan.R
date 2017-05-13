library(xml2)
library(rvest)
#get all the websites
get_all_url <- function(total_page){
  urls <- vector(length = total_page)
  current_page = 1
  i = 0
  while(current_page <= total_page){
    urls[current_page] = paste('https://movie.douban.com/top250?start=', as.character(i), '&filter=', sep = '')
    i = i + 25
    current_page = current_page + 1
  }
  return(urls)
}
urls = get_all_url(10)
#urls[1:10]
title <- vector()
link <- vector()
info <- vector()
pic <- vector()
score_num <- vector()
one_comment <- vector()
score <- vector()
for(i in 1:10){
  #all titles
  web = read_html(urls[i])
  one_page_title = web %>%
    html_nodes(xpath = '//div[@class="hd"]/a/span[1]') %>%
    html_text()
  title <- c(title, one_page_title)
  #all links
  one_page_link = web %>%
    html_nodes(xpath = '//div[@class="hd"]/a') %>%
    html_attr('href')
  link <- c(link, one_page_link)
  #all info
  one_page_info = web %>%
    html_nodes(xpath = '//div[@class="bd"]/p[1]') %>%
    html_text()
  info <- c(info, one_page_info)
  #all scores
  one_page_score = web %>%
    html_nodes(xpath = '//span[@class="rating_num"]') %>%
    html_text()
  score <- c(score, one_page_score)
  #all score_nums
  one_page_score_num = web %>%
    html_nodes(xpath = '//div[@class="star"]/span[4]') %>%
    html_text()
  score_num <- c(score_num, one_page_score_num)
  #all one_comments
  one_page_one_comment = web %>%
    html_nodes(xpath = '//span[@class="inq"]') %>%
    html_text()
  one_comment <- c(one_comment, one_page_one_comment)
  #all pic
  one_page_pic = web %>%
    html_nodes(xpath = '//div[@class="pic"]//img') %>%
    html_attr('src')
  pic <- c(pic, one_page_pic)
}
movie_details = data.frame(title,score, score_num, pic, link)
#movie_details = get_all_movies_details(urls)
write.table(movie_details, file = 'C:/Users/YUG/movie_details.txt', row.names = F, quote = F, sep="\t")