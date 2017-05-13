install.packages("rvest")
library(rvest)
url <- 'http://sem.buaa.edu.cn/szdw/jsbd.htm'
web <- read_html(url, encoding = "utf-8")
pro_name <- web %>%
  html_nodes(xpath = '//td[@style="border: 0px rgb(0, 0, 0) !important;word-break: break-all;text-align:left"]/span/p/strong') %>%
  html_text()
pro_interest <- web %>%
  html_nodes(xpath = '//td[@style="border: 0px rgb(0, 0, 0) !important;word-break: break-all;text-align:left"]/span/p/span/span[1]') %>%
  html_text()
pro_email <- web %>%
  html_nodes(xpath = '//td[@style="border: 0px rgb(0, 0, 0) !important;word-break: break-all;text-align:left"]/span/p/span/span[2]') %>%
  html_text()
pro_link = web %>%
  html_nodes(xpath = '//div[@class = "fak-list"]/li/table/tbody/tr/td[1]/a') %>%
  html_attr('href')
pro_link = c(pro_link[1:2], 0, pro_link[3:length(pro_link)])
pro_interest <- sub("主要研究方向：", '', pro_interest)
pro_job <- data.frame(pro_name, pro_interest, pro_email, pro_link)
write.table(pro_job, file = "经管学院导师信息.csv")

