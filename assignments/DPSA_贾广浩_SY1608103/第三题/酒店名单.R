install.packages('stringr')
library(rvest)
library(stringr)
Hotel_names <- c()
Newest_reviews1 <- c()
Newest_reviews2 <- c()
Hotel_ranks_inBJ6450 <- c()
Descriptions <- c()
for (i in 0:4) {
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
  sub("åœ¨åŒ—äº¬å¸‚ 6,450 å®¶é…’åº—ä¸­æŽ’å", "", Hotel_ranks_inBJ6450)
#Hotel_ranks_inBJ6450
Newest_reviews <- cbind(Newest_reviews1, Newest_reviews2)
#Newest_reviews
#Descriptions
Hotel_inBJ <- data.frame(Hotel_names,
                         Hotel_ranks_inBJ6450,
                         Newest_reviews,
                         Descriptions)
library(knitr)
Result <-c( kable(Hotel_inBJ, format = 'html'))
write.table(Result, file = '¾ÆµêÃûµ¥.txt')

