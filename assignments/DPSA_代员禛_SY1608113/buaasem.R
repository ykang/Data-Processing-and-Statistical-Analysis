library(rvest)
urlbuaasem <- 'http://sem.buaa.edu.cn/szdw/jsbd.htm'
buaasem=read_html(urlbuaasem)

Name<-buaasem %>%
  html_nodes(xpath = '//li/table/tbody/tr/td[2]/span/p/strong/span/span') %>%
  html_text()
Name<-iconv(Name,"utf-8","gbk")
Name
nchar(Name)


Research<-buaasem %>%
  html_nodes(xpath = '//li/table/tbody/tr/td[2]/span/p/span/span[1]') %>%
  html_text()
Research <- iconv(Research,"utf-8","gbk")
Reserch <- 

Email<-buaasem %>%
  html_nodes(xpath = '//li/table/tbody/tr/td[2]/span/p/span/span[2]') %>%
  html_text()

Link<- html_attr(html_nodes(buaasem,xpath='//li/table/tbody/tr/td[1]/a'),'href')
Link<-c(link[1:2],"",link[3:40])

write.csv(cbind(Name,Research,Email,Link), file="BUAASEM.csv", quote =FALSE)

