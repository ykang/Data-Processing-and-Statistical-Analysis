#-------------------------------------------第一题-------------------------------------------------------
library(rvest)
url1 <- 'http://sem.buaa.edu.cn/szdw/jsbd.htm'
web1 <- read_html(url1, encoding = "UTF-8")
Professor_name <- web1 %>%
  html_nodes(xpath = '//div[@class="fak-list"]/li/table/tbody/tr/td[2]/span/p/strong') %>%
  html_text()
#Professor_name
Research_interests <- web1 %>%
  html_nodes(xpath = '//div[@class="fak-list"]/li/table/tbody/tr/td[2]/span/p/span/span[1]') %>%
  html_text()
Research_interests <- sub('主要研究方向：', '', Research_interests)
#Research_interests
emails <- web1 %>%
  html_nodes(xpath = '//div[@class="fak-list"]/li/table/tbody/tr/td[2]/span/p/span/span[2]') %>%
  html_text()
#emails
links <- web1 %>%
  html_nodes(xpath = '//div[@class="fak-list"]/li/table/tbody/tr/td/a') %>%
  html_attr('href')
links <- paste('sem.buaa.edu.cn/szdw/', links, sep = "")
#links
#因为第三个没有links,故设为NULL
t = links
for (i in 1:length(Professor_name)) {
  if (i < 3) {
    links[i]
  } else if (i == 3) {
    links[3] = 'NULL'
  } else{
    links[i] = t[i - 1]
  }
}
#links
Sem <- data.frame(Professor_name, Research_interests, emails, links)
library(knitr)
Result1 <- kable(Sem, format = 'html')
#-------------------------------------------第二题---------------------------------------------------------
Movie_names <- c()
Descriptions_2 <- c()
Remarks <- c()
Remarks1 <- c()
Remarks2 <- c()
Quotes <- c()
Movie_Links <- c()
Picture_Sources <- c()
for (i in 0:9) {
  p <- as.character(25 * i)
  url <-
    sprintf('https://movie.douban.com/top250?start=%s&filter=', p)
  web <- read_html(url, encoding = "UTF-8")
  Movie_name1 <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a/span[1]') %>%
    html_text()
  Movie_name2 <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a/span[2]') %>%
    html_text()
  #  Movie_name2 <- gsub(' / ', '/', Movie_name2)
  Movie_name3 <- web %>%
    html_nodes(xpath = '//div[@class="hd"]/a/span[3]') %>%
    html_text()
  #  Movie_name3 <- gsub(' / ', '/', Movie_name3)
  Movie_name <-
    paste(Movie_name1, Movie_name2, Movie_name3, sep = "")
  #  Movie_name <- web %>%
  #    html_nodes(xpath = '//div[@class="hd"]/a/span') %>%
  #    html_text()
  Movie_names <- c(Movie_names, Movie_name)
  Description_2 <- web %>%
    html_nodes(xpath = '//div[@class="bd"]/p[1]') %>%
    html_text()
  Descriptions_2 <- c(Descriptions_2, Description_2)
  Remark1 <- web %>%
    html_nodes(xpath = '//div[@class="star"]/span[2]') %>%
    html_text()
  Remark2 <- web %>%
    html_nodes(xpath = '//div[@class="star"]/span[4]') %>%
    html_text()
  Remarks1 <- c(Remarks1, Remark1)
  Remarks2 <- c(Remarks2, Remark2)
  Quote <- web %>%
    html_nodes(xpath = '//p[@class="quote"]/span') %>%
    html_text()
  Quotes <- c(Quotes, Quote)
  Movie_Link <- web %>%
    html_nodes(xpath = '//div[@class="pic"]/a') %>%
    html_attr('href')
  Movie_Links <- c(Movie_Links, Movie_Link)
  Picture_Source <- web %>%
    html_nodes(xpath = '//div[@class="pic"]/a/img') %>%
    html_attr('src')
  Picture_Sources <- c(Picture_Sources, Picture_Source)
}
library(stringr)
Descriptions_2 <-
  str_trim(Descriptions_2, side = c("both", "left", "right"))
Descriptions_2 <-
  sub('\n                            ', '   ', Descriptions_2)
Remarks <- paste(Remarks1, '(', Remarks2, ')')
#发现229，190.179,177，170,168，144，115,108没有quote
s = Quotes
for (i in 1:length(Movie_names)) {
  if (i < 108) {
    Quotes[i] = Quotes[i]
  } else if (i > 108 && i < 115) {
    Quotes[i] = s[i - 1]
  } else if (i > 115 && i < 144) {
    Quotes[i] = s[i - 2]
  } else if (i > 144 && i < 168) {
    Quotes[i] = s[i - 3]
  } else if (i > 168 && i < 170) {
    Quotes[i] = s[i - 4]
  } else if (i > 170 && i < 177) {
    Quotes[i] = s[i - 5]
  } else if (i > 177 && i < 179) {
    Quotes[i] = s[i - 6]
  } else if (i > 179 && i < 190) {
    Quotes[i] = s[i - 7]
  } else if (i > 190 && i < 229) {
    Quotes[i] = s[i - 8]
  } else if (i > 229) {
    Quotes[i] = s[i - 9]
  } else{
    Quotes[i] = 'NULL'
  }
}
#Movie_names
#Movie_names <- gsub(" / ", "/", Movie_names)
#Movie_name2 <- sub('<U+00A0>/<U+00A0>', '/', Movie_name2)
#Movie_name1
#Movie_name2
Movie_top250 <-
  cbind(Movie_names,
        Descriptions_2,
        Remarks,
        Movie_Links,
        Picture_Sources)
#Result2 <- Movie_top250
library(knitr)
Result2 <- kable(Movie_top250, format = "html")
#Movie_top250
#head(Movie_top250)
#Movie_names
#Movie_Links
#Picture_Sources
#Quotes
#Remarks
#Descriptions_2
#Descriptions_2 <- str_trim(Descriptions_2, side = c("both", "left",  "right"))
#Descriptions_2
#table(Descriptions_2)
#-------------------------------------------第三题----------------------------------------------------------
url3 <-
  'https://www.tripadvisor.cn/Hotels-g294212-Beijing-Hotels.html'
web3 <- read_html(url3, encoding = "UTF-8")
Hotel_names <- c()
Hotel_name <- web3 %>%
  html_nodes(xpath = '//div[@class="listing_title"]/a') %>%
  html_text()
Hotel_names <- c(Hotel_name)
Hotel_ranks_inBJ6450 <- c()
Hotel_rank <- web3 %>%
  html_nodes(xpath = '//div[@class="slim_ranking"]') %>%
  html_text()
Hotel_ranks_inBJ6450 <- c(Hotel_rank)
Newest_reviews <- c()
Newest_reviews1 <- c()
Newest_reviews2 <- c()
Newest_review_1 <- web3 %>%
  html_nodes(xpath = '//ul[@class="listing_reviews stacked"]/li[1]') %>%
  html_text()
Newest_review_2 <- web3 %>%
  html_nodes(xpath = '//ul[@class="listing_reviews stacked"]/li[2]') %>%
  html_text()
Newest_reviews1 <- c(Newest_review_1)
Newest_reviews2 <- c(Newest_review_2)
Descriptions <- c()
Description <- web3 %>%
  html_nodes(xpath = '//div[@class="clickable_tags"]') %>%
  html_text()
Descriptions <- c(Description)
#Newest_review
#Hotel_names
#for(i in 1:4){
# f <- as.character(30*i)
#print(f)
#}
#class(f)
#url <- sprintf('https://www.tripadvisor.cn/Hotels-g294212-oa%s-Beijing-Hotels.html#ACCOM_OVERVIEW','30')
#url
#class(url)
#url2 <- 'https://www.tripadvisor.cn/Hotels-g294212-oa30-Beijing-Hotels.html#ACCOM_OVERVIEW'
#web <- read_html(url2)
#Hotel_name <- web %>%
#  html_nodes(xpath = '//div[@class="listing_title"]/a') %>%
#  html_text()
#Hotel_name
for (i in 1:4) {
  f <- as.character(30 * i)
  url <-
    sprintf(
      'https://www.tripadvisor.cn/Hotels-g294212-oa%s-Beijing-Hotels.html#ACCOM_OVERVIEW',
      f
    )
  web <- read_html(url, encoding = "UTF-8")
  Hotel_name <- web %>%
    html_nodes(xpath = '//div[@class="listing_title"]/a') %>%
    html_text()
  Hotel_names <- c(Hotel_names, Hotel_name)
  Hotel_rank <- web %>%
    html_nodes(xpath = '//div[@class="slim_ranking"]') %>%
    html_text()
  Hotel_ranks_inBJ6450 <- c(Hotel_ranks_inBJ6450, Hotel_rank)
  Newest_review_1 <- web %>%
    html_nodes(xpath = '//ul[@class="listing_reviews stacked"]/li[1]') %>%
    html_text()
  Newest_review_2 <- web %>%
    html_nodes(xpath = '//ul[@class="listing_reviews stacked"]/li[2]') %>%
    html_text()
  Newest_reviews1 <- c(Newest_reviews1, Newest_review_1)
  Newest_reviews2 <- c(Newest_reviews2, Newest_review_2)
  Description <- web %>%
    html_nodes(xpath = '//div[@class="clickable_tags"]') %>%
    html_text()
  Descriptions <- c(Descriptions, Description)
}
#Hotel_names
Hotel_ranks_inBJ6450 <-
  sub("在北京市 6,450 家酒店中排名", "", Hotel_ranks_inBJ6450)
#Hotel_ranks_inBJ6450
Newest_reviews <- cbind(Newest_reviews1, Newest_reviews2)
#Newest_reviews
#Descriptions
Hotel_inBJ <- data.frame(Hotel_names,
                         Hotel_ranks_inBJ6450,
                         Newest_reviews,
                         Descriptions)
library(knitr)
Result3 <- kable(Hotel_inBJ, format = "html")
#-------------------------------------------第四题----------------------------------------------------------
#因为商品中有不是书本的，所以先按照上架时间进行排序，结果反映书的名称，上架时间，作者，价格，link
Book_names <- c()
Book_links <- c()
Books_timeOnshelf <- c()
Book_writters <- c()
Book_prices <- c()
for (i in 1:5) {
  m <- as.character(i)
  url <-
    paste(
      'https://www.amazon.cn/s/ref=sr_pg_',
      m,
      '?rh=i%3Aaps%2Ck%3A%E5%A4%A7%E6%95%B0%E6%8D%AE&page=',
      m,
      '&sort=date-desc-rank&keywords=%E5%A4%A7%E6%95%B0%E6%8D%AE&ie=UTF8&qid=1494154872',
      sep = ""
    )
  web <- read_html(url, encoding = "UTF-8")
  Book_name <- web %>%
    html_nodes(xpath = '//a[@class="a-link-normal s-access-detail-page  s-color-twister-title-link a-text-normal"]/h2') %>%
    html_text()
  Book_names <- c(Book_names, Book_name)
  Book_link <- web %>%
    html_nodes(xpath = '//a[@class="a-link-normal s-access-detail-page  s-color-twister-title-link a-text-normal"]') %>%
    html_attr('href')
  Book_links <- c(Book_links, Book_link)
  Book_timeOnshelf <- web %>%
    html_nodes(xpath = '//div[@class="a-row a-spacing-mini"]/div[1]/span[2]') %>%
    html_text()
  Books_timeOnshelf <- c(Books_timeOnshelf, Book_timeOnshelf)
  Book_first_writter <- web %>%
    html_nodes(xpath = '//div[@class="a-row a-spacing-mini"]/div[2]/span[2]') %>%
    html_text()
  Book_writters <- c(Book_writters, Book_first_writter)
  Book_price1 <- web %>%
    html_nodes(xpath = '//div[@class="s-item-container"]/div[3]/a/h3') %>%
    html_text()
  Book_price2 <- web %>%
    html_nodes(xpath = '//div[@class="s-item-container"]/div[4]/a/span[2]') %>%
    html_text()
  Book_price <- paste(Book_price1, Book_price2, sep = "：")
  Book_prices <- c(Book_prices, Book_price)
  
}
#Book_names
#Book_links
#Books_timeOnshelf
#Book_writters <- gsub('、 、', '、', Book_writters)
Book_writters <- gsub('、 ', '', Book_writters)
#Book_writters
#书籍106,108,109没有作者
t <- Book_writters
for (i in 1:length(Book_names)) {
  if (i < 106) {
    Book_writters[i] = Book_writters[i]
  } else if (i > 106 && i < 108) {
    Book_writters[i] = t[i - 1]
  } else if (i > 108 && i < 109) {
    Book_writters[i] = t[i - 2]
  } else if (i > 109) {
    Book_writters[i] = t[i - 3]
  } else{
    Book_writters[i] = "NULL"
  }
}
#Book_writters
#Book_prices
#str_trim(Book_names, side = c("both", "left", "right"))
Book_Amazon <- data.frame(Book_names,
                          Books_timeOnshelf,
                          Book_writters,
                          Book_prices,
                          Book_links)
library(knitr)
Result4 <- kable(Book_Amazon, format = "html")
Result <- c(Result1, Result2, Result3, Result4)
write.table(Result,
            file = "C:/Users/ZC/Desktop/DPSA_周畅_SY1608203.txt",
            quote = FALSE,
            fileEncoding = "UTF-8")

