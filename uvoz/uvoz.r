# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi preselitve iz Wikipedije

link <- "https://en.wikipedia.org/wiki/Immigration_to_Europe#Slovenia"
stran <- html_session(link) %>% read_html()
tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[6]] %>% html_table(dec = ".")
summary(tabela)

colnames(tabela) <- c("spol", "drzava", "leto", "stevilo priseljencev")
sl <- locale("sl", decimal_mark = ".")

View(tabela)


uvozihtml <- function() {

html <- file("podatki/html1.html") %>% readLines()
podatkiHTML <- grep("var dataValues", html, value = TRUE) %>%
  strapplyc('var dataValues="([^"]+)"') %>% .[[1]] %>%
  strsplit("|", fixed=TRUE) %>% unlist() %>%
  matrix(ncol=6, byrow=TRUE)
return(html)
}
html1 <- uvozihtml()




# Funkcija, ki uvozi podatke iz csv datotek v mapi "podatki"

library(readr)
library(tidyr)
library(gsubfn)
library(dplyr)
uvozi1 <- function() {
  tab <- read_csv2(file="podatki/tabela1.csv",
                   col_names = c("Vrsta_migrantov", "Starostna_skupina", "Leto", "Spol", "Stevilo"),
                   locale=locale(encoding="Windows-1250"),skip = 4,  n_max = 1865) 
  tab <- tab %>% fill(1:4) %>% drop_na(Stevilo) %>% filter(Starostna_skupina != "SKUPAJ",
                                                           Starostna_skupina != "Starostne skupine - SKUPAJ")
  tab$leta_min <- tab$Starostna_skupina %>% strapplyc("(^[0-9]+)") %>% unlist() %>% parse_number()
  tab$Starostna_skupina <- NULL
  return(tab)
}
tabela1 <- uvozi1()

uvozi2 <- function() {
  tab2 <- read_csv2(file="podatki/tabela2.csv",
                   col_names = c("Vrsta_migrantov", "Drzava_drzavljanstva", "Leto", "Spol", "Stevilo"),
                   locale=locale(encoding="Windows-1250"),skip = 5,  n_max = 3336) 
  tab2 <- tab2 %>% fill(1:4) %>% drop_na(Stevilo) %>% filter(Drzava_drzavljanstva != "Država državljanstva - SKUPAJ",
                                                             Drzava_drzavljanstva != "EVROPA")
  return(tab2) 
}
tabela2 <- uvozi2()

uvozi3 <- function() {
  tab3 <- read_csv2(file="podatki/tabela3.csv",
                   col_names = c("Vrsta_migrantov", "Starostna_skupina", "Leto", "Spol","Drzavljanstvo", "Stevilo"),
                   locale=locale(encoding="Windows-1250"),skip = 7,  n_max = 4525) 
  tab3 <- tab3 %>% fill(1:5) %>% drop_na(Stevilo) %>% filter(Starostna_skupina != "Starostne skupine - SKUPAJ")
  tab3$leta_min <- tab3$Starostna_skupina %>% strapplyc("(^[0-9]+)") %>% unlist() %>% parse_number()
  tab3$Starostna_skupina <- NULL

  return(tab3)
}
tabela3 <- uvozi3()

uvozi4 <- function() {
  tab4 <- read_csv2(file="podatki/tabela4.csv",
                    col_names = c("Vrsta_migrantov", "Drzavljanstvo", "Leto", "Regija","Stevilo"),
                    locale=locale(encoding="Windows-1250"),skip = 5,  n_max = 840) 
  tab4 <- tab4 %>% fill(1:3) %>% drop_na(Stevilo)
  return(tab4)
}
tabela4 <- uvozi4()




# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.

