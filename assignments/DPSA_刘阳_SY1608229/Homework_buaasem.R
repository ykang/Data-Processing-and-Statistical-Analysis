library(rvest)
url <- "http://sem.buaa.edu.cn/szdw/jsbd.htm"
web <- read_html(url)

professors_name <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//strong/span/span')
name <- html_text(professors_name)

professors_direction <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//p/span/span[1]')
direction <- html_text(professors_direction)

professors_email <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//p/span/span[2]')
email <- html_text(professors_email)

professors_link <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//a')
link <-  html_attr(professors_link, 'href')
link <- c(link[1:2], "", link[3:40])

buaasem_professors = data.frame(name, direction, email, link)

write.csv(buaasem_professors,file="buaasem_professors.csv", quote = FALSE)