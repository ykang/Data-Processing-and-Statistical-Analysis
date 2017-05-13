library(rvest)
url <- 'http://sem.buaa.edu.cn/szdw/jsbd.htm'
web <- read_html(url, encoding = "utf-8")
name <- web %>%
  html_nodes(xpath = '//div[@class = "fak-list"]/li/table/tbody/tr/td[2]/span/p/strong') %>%
  html_text()
research_interest <- web %>%
  html_nodes(xpath = '//div[@class = "fak-list"]/li/table/tbody/tr/td[2]/span/p/span/span[1]') %>%
  html_text()
email <- web %>%
  html_nodes(xpath = '//div[@class = "fak-list"]/li/table/tbody/tr/td[2]/span/p/span/span[2]') %>%
  html_text()
link = web %>%
  html_nodes(xpath = '//div[@class = "fak-list"]/li/table/tbody/tr/td[1]/a') %>%
  html_attr('href')
link = c(link[1:2],0,link[3:length(link)])
research_interest = sub('主要研究方向：','',research_interest)
professor_information <- data.frame(name, research_interest, email, link)
professor_information
library(knitr)
kable(head(professor_information), format = "html")