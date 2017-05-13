library(rvest)
url <- "http://sem.buaa.edu.cn/szdw/jsbd.htm"
web <- read_html(url)
# 姓名
Name <- html_nodes(web, xpath = "//div[@class=\"fak-list\"]/li/table/tbody/tr/td[2]/span/p/strong/span/span")  #姓名
Name <- iconv(html_text(Name), "utf-8", "gbk")
# 研究方向
Research <- html_nodes(web, xpath = "//div[@class=\"fak-list\"]/li/table/tbody/tr/td[2]/span/p/span/span[1]")  #研究方向 
Research <- iconv(html_text(Research), "utf-8", "gbk")
# 邮箱
Email <- html_nodes(web, xpath = "//div[@class=\"fak-list\"]/li/table/tbody/tr/td[2]/span/p/span/span[2]")  #邮箱
Email <- iconv(html_text(Email), "utf-8", "gbk")
# 链接
Link <- list(NULL)
link <- html_nodes(web, xpath = "//div[@class=\"fak-list\"]/li/table/tbody/tr/td[1]/a/@href")  #链接
link <- as.character(link)
for (i in 1:41) {
    Link[i] = paste("http://sem.buaa.edu.cn/szdw/", substr(link[i],gregexpr("href", link[i])[[1]][1] + 6, nchar(link[i])), sep = "")
}
Link <- c(Link[1:2],"",Link[3:40])
Link <- as.character(Link)
# 输出
BUAA_SEM_Professors <- data.frame(Name, Research, Email, Link, stringsAsFactors = FALSE)
write.csv(BUAA_SEM_Professors, file = "输出结果_吕秋娜_SY1608115.csv")
 
