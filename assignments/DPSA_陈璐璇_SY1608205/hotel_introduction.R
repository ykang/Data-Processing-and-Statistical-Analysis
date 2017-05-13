#Extract the top 5 pages of hotel information including the newest reviews 
#from TripAdvisor (https://www.tripadvisor.com/Hotels-g294212-Beijing-Hotels.html)

library(xml2)
library(rvest)
library(stringr)
library(rJava)
library(xlsxjars)
library(xlsx)

for(i in 1:5){
  num <- (i-1)*30
  url <- paste("https://www.tripadvisor.cn/Hotels-g294212-oa", num, "-Beijing-Hotels.html#ACCOM_OVERVIEW", sep="")
  if(i==1)url <- 'https://www.tripadvisor.cn/Hotels-g294212-Beijing-Hotels.html'
  
  web <- read_html(url, encoding = "utf-8")
  hotel_name <- web %>%
    html_nodes(xpath = '//div[@class="listing_title"]/a') %>%
    html_text()
  rank <- str_replace(web %>%
    html_nodes(xpath = '//div[@class="slim_ranking"]') %>%
    html_text(), ',', '')
  newest_review_time <- web %>%
    html_nodes(xpath = '//li[@class="cssTruncatedSnippet"][1]/span[1]') %>%
    html_text()
  newest_review <- str_replace_all(web %>%
    html_nodes(xpath = '//li[@class="cssTruncatedSnippet"][1]/span[2]') %>%
    html_text(),',','，')
  tags <- web %>%
    html_nodes(xpath = '//div[@class="clickable_tags"]') %>%
    html_text()
  
  if(i==1)
    hotel_introduction <- data.frame(hotel_name, rank, newest_review_time, newest_review, tags)else{
      hotel <- data.frame(hotel_name, rank, newest_review_time, newest_review, tags)
      hotel_introduction <- rbind(hotel_introduction, hotel)
    }
}

#save(hotel_introduction, file = "E:/R_workspace/hotel_introduction.Rdata")
#write.csv(hotel_introduction, file = "E:/R_workspace/hotel_introduction.csv", row.names = T, quote = F)
#write.table(hotel_introduction, file = "E:/R_workspace/hotel_introduction.txt", row.names = T, quote = F)
write.xlsx(x = hotel_introduction, file = "hotel_introduction.xlsx",
           sheetName = "hotel_introduction", row.names = TRUE)

#library(knitr)
#kable(head(hotel_introduction), format = "html")