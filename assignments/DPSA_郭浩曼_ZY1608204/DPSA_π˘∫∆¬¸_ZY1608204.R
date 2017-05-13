library(rvest)
url <- 'http://sem.buaa.edu.cn/szdw/jsbd.htm'
web <- read_html(url)
extract_names_nodes <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//strong/span/span')
extract_names <- html_text(extract_names_nodes)
link <- web %>%
  html_nodes(xpath = '//div[@class="fak-list"]//tr/td[1]/a') %>%
  html_attr('href')
link <- c(link[1:2], NA, link[3:length(link)])
# link = paste('[Link](', link, sep='')
# link <- paste(link, ')', sep='')
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
#Êä³ö½á¹û
write.csv(buaa_professors, file = "DPSA_¹ùºÆÂü_ZY1608204.csv")