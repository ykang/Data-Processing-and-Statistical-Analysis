library(rvest)
url <- 'http://sem.buaa.edu.cn/szdw/jsbd.htm'
web <- read_html(url)
extract_names_nodes <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//strong/span/span')
extract_names <- html_text(extract_names_nodes)
link <- web %>%
  html_nodes(xpath = '//div[@class="fak-list"]//tr/td[1]/a') %>%
  html_attr('href')
#发现第三个老师吴季松老师的link缺失，所以在link中加入一个NA
link <- c(link[1:2], NA, link[3:length(link)])
research_intrests_nodes <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//p/span/span[1]')
research_intrests <- html_text(research_intrests_nodes)
emails_nodes <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//p/span/span[2]')
emails <- html_text(emails_nodes)
buaa_professors  <-
  data.frame(extract_names, research_intrests, emails, link)
library(knitr)
kable(head(buaa_professors), format = "html")
#输出结果
write.csv(buaa_professors, file = "DPSA_王若岚_SY1608105.csv")