library(rvest)
library(dplyr)
##HW02
url <-"https://www.wongnai.com/listings/sweet-easydesserts-bangkok"

shop_name <- url%>%
  read_html() %>%
  html_elements("h3.sc-3bgfff-2.fPFiZe.bd36.bd24-mWeb") %>%
  html_text2()

scores <- url%>%
  read_html() %>%
  html_elements("div.BaseGap-sc-1wadqs8.gpdArF") %>%
  html_text2() %>%
  as.numeric()

shop_types <- url%>%
  read_html() %>%
  html_elements("span.bbsi3i-0.kifiY") %>%
  html_text2()

df_phone_numbers <- url%>%
  read_html() %>%
  html_elements("span.rg14") %>%
  html_text2() %>%
  as.data.frame() %>%
  filter(grepl("^0", .))%>%
  rename("phone_number" = "." )
  
df1 <- data.frame(shop_name,shop_types,scores)
full_data <- bind_cols(df1, df_phone_numbers)

View(full_data)
  
##HW01
library(rvest)
library(dplyr)
library(stringr)

url <- "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc"

movie_name <- url %>%
  read_html() %>%
  html_elements("h3.lister-item-header") %>%
  html_text2()

ratings <- url %>%
  read_html() %>%
  html_elements("div.ratings-imdb-rating") %>%
  html_text2() %>%
  as.numeric()

votes <- url %>%
  read_html() %>%
  html_elements("p.sort-num_votes-visible") %>%
  html_text2()

df <- data.frame(
  movie_name,
  ratings,
  votes
)

df <- df %>%
  mutate(
    movie_name = movie_name,
    ratings = ratings,
    vote = str_match(votes,"Votes:\\s*(\\d+,?\\d+,?\\d+)")[, 2],
    gross = str_match(votes,"Gross:\\s*\\$(\\d+\\.\\d+)")[, 2],
    top = str_match(votes,"Top\\s*250:\\s*\\#(\\d+)")[, 2]
  ) %>%
  select(movie_name,ratings,vote,gross,top)
  
View(df)

write.csv(df, "imdbMovies.csv")






