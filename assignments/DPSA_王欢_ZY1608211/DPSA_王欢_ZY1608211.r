library(rvest)
link <- 'http://sem.buaa.edu.cn/szdw/jsbd.htm'
web <- read_html(link, encoding = "utf-8")
Professlink <- vector()
name_nodes <-
  html_nodes(xpath = '//div[@class="fak-list"]//strong/span/span',web)
prof_name <- html_text(name_nodes)
interest_nodes <-
  html_nodes(xpath = '//div[@class="fak-list"]//p/span/span[1]',web)
research_intr <- html_text(interest_nodes)
email_nodes <-
  html_nodes(xpath = '//div[@class="fak-list"]//p/span/span[2]',web)
email_box <- html_text(email_nodes)
link_nodes <- html_nodes(xpath = '//div[@class="fak-list"]//a',web)
link_prof <- html_attr(link_nodes,'href')
profess_link <- c(link_prof[1:2],"æ—?",link_prof[3:40])

pro_info <-
  data.frame(prof_name, research_intr, email_box,profess_link)
write.table(pro_info,file="C:/Users/Íõ»¶/Desktop/DPSA_Íõ»¶_ZY1608211.txt",sep=' ')
