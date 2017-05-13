library(rvest)
url1 <- 'https://www.tripadvisor.cn/Hotels-g294212-oa0-Beijing-Hotels.html#ACCOM_OVERVIEW'
web <- read_html(url1)
name1 <- web %>%
  html_nodes(xpath = '//div[@class="listing_title"]/a') %>%
  html_text()
rank1 <- web %>%
  html_nodes(xpath = '//div[@class="popRanking"]/div') %>%
  html_text()
ping1 <- web %>%
  html_nodes(xpath = '//ul[@class="listing_reviews stacked"]/li[1]/span[2]/a') %>%
  html_text()
data1 <- data.frame(name1,rank1,ping1)

url2 <- 'https://www.tripadvisor.cn/Hotels-g294212-oa30-Beijing-Hotels.html#ACCOM_OVERVIEW'
web <- read_html(url2)
name2 <- web %>%
  html_nodes(xpath = '//div[@class="listing_title"]/a') %>%
  html_text()
rank2 <- web %>%
  html_nodes(xpath = '//div[@class="popRanking"]/div') %>%
  html_text()
ping2 <- web %>%
  html_nodes(xpath = '//ul[@class="listing_reviews stacked"]/li[1]/span[2]/a') %>%
  html_text()
data2 <- data.frame(name2,rank2,ping2)

url3 <- 'https://www.tripadvisor.cn/Hotels-g294212-oa60-Beijing-Hotels.html#ACCOM_OVERVIEW'
web <- read_html(url3)
name3 <- web %>%
  html_nodes(xpath = '//div[@class="listing_title"]/a') %>%
  html_text()
rank3<- web %>%
  html_nodes(xpath = '//div[@class="popRanking"]/div') %>%
  html_text()
ping3<- web %>%
  html_nodes(xpath = '//ul[@class="listing_reviews stacked"]/li[1]/span[2]/a') %>%
  html_text()
data3<- data.frame(name3,rank3,ping3)

url4 <- 'https://www.tripadvisor.cn/Hotels-g294212-oa90-Beijing-Hotels.html#ACCOM_OVERVIEW'
web <- read_html(url4)
name4 <- web %>%
  html_nodes(xpath = '//div[@class="listing_title"]/a') %>%
  html_text()
rank4<- web %>%
  html_nodes(xpath = '//div[@class="popRanking"]/div') %>%
  html_text()
ping4<- web %>%
  html_nodes(xpath = '//ul[@class="listing_reviews stacked"]/li[1]/span[2]/a') %>%
  html_text()
data4<- data.frame(name4,rank4,ping4)

url5 <- 'https://www.tripadvisor.cn/Hotels-g294212-oa120-Beijing-Hotels.html#ACCOM_OVERVIEW'
web <- read_html(url5)
name5 <- web %>%
  html_nodes(xpath = '//div[@class="listing_title"]/a') %>%
  html_text()
rank5 <- web %>%
  html_nodes(xpath = '//div[@class="popRanking"]/div') %>%
  html_text()
ping5<- web %>%
  html_nodes(xpath = '//ul[@class="listing_reviews stacked"]/li[1]/span[2]/a') %>%
  html_text()
data5<- data.frame(name5,rank5,ping5)

datazong <- data.frame(data1,data2,data3,data4,data5)