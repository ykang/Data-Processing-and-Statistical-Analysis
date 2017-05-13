library(rvest)
url <-'http://sem.buaa.edu.cn/szdw/jsbd.htm'
web <- read_html(url, encoding = "utf-8")
 professor_name <- web %>%
   html_nodes(xpath = '//div[@class="fak-list"]//strong/span/span') %>%
   html_text()
 research_interest <- web %>%
   html_nodes(xpath = '//div[@class="fak-list"]//p/span/span[1]') %>%
   html_text()
 email <- web %>%
   html_nodes(xpath = '//div[@class="fak-list"]//p/span/span[2]') %>%
   html_text()
 link <- web %>%
   html_nodes(xpath = '//div[@class="fak-list"]//a') %>%
   html_attr('href')
 professor_link <- c(link[1:2],"N/A",link[3:40])
 professor_details <- data.frame(professor_name, research_interest, email, professor_link)
 
 write.table(professor_details,file="C:/Users/Administrator/Desktop/DPSA_Íõæºâù_ZY1608212.txt",sep=' ')
 
 