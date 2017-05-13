#Q1:抓取名字，研究方向，邮箱和链接
#Extract names, research interests, emails and links of all BUAA SEM Professors
library(rvest)
url <- 'http://sem.buaa.edu.cn/szdw/jsbd.htm'
web <- read_html(url)
professors_nodes <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//strong/span/span')
name <- html_text(professors_nodes)
#research interests研究方向
interests_nodes <-
  html_nodes(web, xpath = '//div[@class="fak-list"]//p/span/span[1]')
interests <- html_text(interests_nodes)
#emails电子邮件
emails_nodes <-
  html_nodes(web, xpath = '//div[@class="fak-list"]// p/span/span[2]')
emails <- html_text(emails_nodes)
#link
link <- web %>%
  html_nodes(xpath = '//div[@class="fak-list"]//tr/td[1]/a') %>%
  html_attr('href')
#发现第三个老师吴季松老师的link缺失，所以在link中加入一个NA
link <- c(link[1:2], NA, link[3:length(link)])
#汇总
sem_professors  <- data.frame(name, interests, emails, link)
library(knitr)
kable(head(sem_professors), format = "html")
#输出结果
write.csv(sem_professors, file = "DPSA_叶媛_SY1608108.csv")