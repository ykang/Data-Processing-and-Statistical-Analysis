# 设定工作路径
setwd("~/01wenjin")

# install.packages('xml2')
library(xml2)
# install.packages('rvest')
library(rvest)

newdata <- matrix(nrow = 250, ncol = 9)
for (i in 1:10) {
    ii <- (i - 1) * 25
    # 进行翻页循环
    url <- paste("https://movie.douban.com/top250?start=", ii, "&filter=", sep = "")
    web <- read_html(url, encoding = "utf-8")
    
    # 指标1：电影中文名称
    movie_title <- web %>% html_nodes(xpath = "//div[@class=\"hd\"]/a/span[1]") %>% html_text()
    # 解决中文编码问题
    new_movie_title <- iconv(movie_title, "UTF-8", "gbk")
    
    # 指标2：链接
    movie_link <- web %>% html_nodes(xpath = "//div[@class=\"hd\"]/a") %>% html_attr("href")
    
    # 指标3-4：导演&主演相关
    movie_people <- web %>% html_nodes(xpath = "//div[@class=\"bd\"]/p[1]/text()[1]") %>% html_text()
    # 解决中文编码问题
    new_movie_people <- iconv(movie_people, "UTF-8", "UTF-8")
    # 删除\n及空格
    new_movie_people2 <- gsub("([\n ])", "", new_movie_people)
    # 替换全角空格为半角空格
    new_movie_people3 <- gsub("([<U+00A0>])", " ", new_movie_people2)
    
    # 指标5-7：年份&影片类型
    movie_type <- web %>% html_nodes(xpath = "//div[@class=\"bd\"]/p[1]/text()[2]") %>% html_text()
    # 解决中文编码问题
    new_movie_type <- iconv(movie_type, "UTF-8", "UTF-8")
    # 删除/n及空格
    new_movie_type2 <- gsub("([\n ])", "", new_movie_type)
    # 替换全角空格为半角空格
    new_movie_type3 <- gsub("([<U+00A0>])", " ", new_movie_type2)
    
    # 指标8：电影评分
    movie_rate <- web %>% html_nodes(xpath = "//div[@class=\"star\"]/span[@class=\"rating_num\"]") %>% html_text()
    
    # 指标9：评价人数
    movie_ratenum <- web %>% html_nodes(xpath = "//div[@class=\"star\"]/span[4]") %>% html_text()
    # 解决中文编码问题
    new_movie_ratenum <- iconv(movie_ratenum, "UTF-8", "gbk")
    
    newdata[((i - 1) * 25 + 1):((i - 1) * 25 + 25), 1] <- new_movie_title
    newdata[((i - 1) * 25 + 1):((i - 1) * 25 + 25), 2] <- movie_link
    newdata[((i - 1) * 25 + 1):((i - 1) * 25 + 25), 3] <- new_movie_people3
    
    for (j in 1:25) {
        # 拆分主演及导演，分隔符为' '
        newdata[((i - 1) * 25 + j), 3] < strsplit(new_movie_people3[j], split = "   ")[[1]][1]
        newdata[((i - 1) * 25 + j), 4] <- strsplit(new_movie_people3[j], split = "   ")[[1]][2]
        # 拆分年份、国家及类型，分隔符为??<U+393C><U+3E63> / ??<U+393C><U+3E64>
        newdata[((i - 1) * 25 + j), 5] <- strsplit(new_movie_type3[j], split = " / ")[[1]][1]
        newdata[((i - 1) * 25 + j), 6] <- strsplit(new_movie_type3[j], split = " / ")[[1]][2]
        newdata[((i - 1) * 25 + j), 7] <- strsplit(new_movie_type3[j], split = " / ")[[1]][3]
    }
    
    newdata[((i - 1) * 25 + 1):((i - 1) * 25 + 25), 8] <- movie_rate
    newdata[((i - 1) * 25 + 1):((i - 1) * 25 + 25), 9] <- new_movie_ratenum
}

colnames(newdata) <- c("电影名","链接","导演",
                       "主演","发行年份","发行国家",
                       "影片类型","影片评分","评价人数")
write.csv(newdata, "newdata.csv") 
