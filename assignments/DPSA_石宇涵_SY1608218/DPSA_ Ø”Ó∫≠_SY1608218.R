library(rvest)
for (i in 0:9) {
    url <- paste("http://movie.douban.com/top250?start=", (i * 25), sep = "")
    web <- read_html(url, encoding = "utf-8")
    Ranking <- web %>% 
      html_nodes(xpath = "//div[@class=\"pic\"]/em") %>% 
      html_text()
    Movies <- web %>% 
      html_nodes(xpath = "//div[@class=\"hd\"]/a/span[@class=\"title\"][1]") %>% 
      html_text()
    Popularity <- web %>% 
      html_nodes(xpath = "// div[@class=\"star\"]/span[last()]") %>% 
      html_text()
    Score <- web %>% 
      html_nodes(xpath = "//div[@class=\"star\"]/span[@class=\"rating_num\"]") %>% 
      html_text()
    Link <- web %>% 
      html_nodes(xpath = "//div[@class=\"hd\"]/a ") %>% 
      html_attr("href")
    douban.movie.attributes <- data.frame(Ranking, Movies, Popularity, Score, Link)
    write.table(douban.movie.attributes, row.names = FALSE)
}

