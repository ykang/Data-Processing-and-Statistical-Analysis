library(rvest)
url <- 'http://sem.buaa.edu.cn/szdw/jsbd.htm'
web <- read_html(url, encoding = "utf-8")
ProfessorsName <- web %>%
  html_nodes(xpath = '//div[@class"fak-list"]/table/tbody/tr/td[2]/span/p/strong/span/span') %>%
  html_text()
researchInterests <- web %>%
  html_nodes(xpath = '//div[@class"fak-list"]/table/tbody/tr/td[2]/span/p/span/span[1]/text()') %>%
  html_text()
email <- web %>%
  html_nodes(xpath = '//div[@class"fak-list"]/table/tbody/tr/td[2]/span/p/span/span[2]/text()') %>%
  html_text()
html_nodes(xpath = '//div[@class"fak-list"]/table/tbody/tr/td[1]/a') %>%
  html_attr('href')
link <- web %>%
  ProfessorsInfo <- data.frame(ProfessorsName, researchInterests , email, link)
library(knitr)
kable(head(ProfessorsInfo), format = "html")
write.table(head(ProfessorsInfo), format = "html")