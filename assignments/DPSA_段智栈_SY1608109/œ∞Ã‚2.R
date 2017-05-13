library(rvest)
 url<- 'https://movie.douban.com/top250?start=0&filter='
  
  web <- read_html(url)
  cname1 = web %>%
    html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
    html_text()
  ename1 = web %>%
    html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
    html_text()
  pingfen1 <- web %>%
    html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
    html_text()
  pingjia1 <- web %>%
    html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
    html_text()
  link1 <- web %>%
    html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
    html_attr('href')
data1 <- data.frame(cname1,ename1,pingfen1,pingjia1,link1)

url2<- 'https://movie.douban.com/top250?start=25&filter='

web <- read_html(url2)
cname2 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
  html_text()
ename2 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
  html_text()
pingfen2 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
  html_text()
pingjia2 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
  html_text()
link2 <- web %>%
  html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
  html_attr('href')
data2 <-data.frame(cname2,ename2,pingfen2,pingjia2,link2)

url3<- 'https://movie.douban.com/top250?start=50&filter='

web <- read_html(url3)
cname3 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
  html_text()
ename3 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
  html_text()
pingfen3 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
  html_text()
pingjia3 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
  html_text()
link3 <- web %>%
  html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
  html_attr('href')
data3 <-data.frame(cname3,ename3,pingfen3,pingjia3,link3)

url4<- 'https://movie.douban.com/top250?start=75&filter='

web <- read_html(url4)
cname4 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
  html_text()
ename4 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
  html_text()
pingfen4 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
  html_text()
pingjia4 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
  html_text()
link4 <- web %>%
  html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
  html_attr('href')
data4 <-data.frame(cname4,ename4,pingfen4,pingjia4,link4)

url5<- 'https://movie.douban.com/top250?start=100&filter='

web <- read_html(url5)
cname5 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
  html_text()
ename5 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
  html_text()
pingfen5 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
  html_text()
pingjia5 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
  html_text()
pingjia5 <- c(pingjia5[1:7],0,pingjia5[8:13],0,pingjia5[14:23])
link5 <- web %>%
  html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
  html_attr('href')
data5 <-data.frame(cname5,ename5,pingfen5,pingjia5,link5)
url6<- 'https://movie.douban.com/top250?start=125&filter='

web <- read_html(url6)
cname6 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
  html_text()
ename6 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
  html_text()
pingfen6 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
  html_text()
pingjia6 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
  html_text()
pingjia6 <- c(pingjia6[1:17],0,pingjia6[18:24])
link6 <- web %>%
  html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
  html_attr('href')
data6 <-data.frame(cname6,ename6,pingfen6,pingjia6,link6)

url7<- 'https://movie.douban.com/top250?start=150&filter='

web <- read_html(url7)
cname7 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
  html_text()
ename7 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
  html_text()
pingfen7 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
  html_text()
pingjia7 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
  html_text()
pingjia7 <- c(pingjia7[1:16],0,pingjia7[17],0,pingjia7[18:23])
link7 <- web %>%
  html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
  html_attr('href')
data7 <-data.frame(cname7,ename7,pingfen7,pingjia7,link7)

url8<- 'https://movie.douban.com/top250?start=175&filter='

web <- read_html(url8)
cname8 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
  html_text()
ename8 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
  html_text()
pingfen8 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
  html_text()
pingjia8 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
  html_text()
pingjia8 <- c(pingjia8[1],0,pingjia8[2:3],0,pingjia8[4:13],0,pingjia8[14:22])
link8 <- web %>%
  html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
  html_attr('href')
data8 <-data.frame(cname8,ename8,pingfen8,pingjia8,link8)

url9<- 'https://movie.douban.com/top250?start=200&filter='

web <- read_html(url9)
cname9 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
  html_text()
ename9 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
  html_text()
pingfen9 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
  html_text()
pingjia9 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
  html_text()
link9 <- web %>%
  html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
  html_attr('href')
data9 <- data.frame(cname9,ename9,pingfen9,pingjia9,link9)

url10<- 'https://movie.douban.com/top250?start=225&filter='

web <- read_html(url10)
cname10 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[1]') %>%
  html_text()
ename10 = web %>%
  html_nodes(xpath ='//div[@class="info"]/div/a/span[2]') %>%
  html_text()
pingfen10 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/div/span[2]') %>%
  html_text()
pingjia10 <- web %>%
  html_nodes(xpath = '//div[@class="info"]/div[2]/p/span') %>%
  html_text()
pingjia10 <- c(pingjia10[1:2],0,pingjia10[3:24])
link10 <- web %>%
  html_nodes(xpath = '//div[@class="item"]/div[1]/a') %>%
  html_attr('href')
data10 <- data.frame(cname10,ename10,pingfen10,pingjia10,link10)
a = data.frame(data1,data2,data3,data4,data5,data6,data7,data8,data9,data10)
