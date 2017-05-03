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

# Funkcija, ki uvozi podatke iz datoteke Meddrzavne_selitve.csv

library(readr)
library(tidyr)
library(gsubfn)
library(dplyr)

uvozi <- function() {
  tab <- read_csv2(file="podatki/05N1004Ss.csv",
                   col_names = c("Vrsta_migrantov", "Starostna_skupina", "Leto", "Spol", "Stevilo"),
                   locale=locale(encoding="Windows-1250"),skip = 4,  n_max = 1865) 
  tab <- tab %>% fill(1:4) %>% drop_na(Stevilo) %>% filter(Starostna_skupina != "SKUPAJ",
                                                           Starostna_skupina != "Starostne skupine - SKUPAJ")
  tab$leta_min <- tab$Starostna_skupina %>% strapplyc("(^[0-9]+)") %>% unlist() %>% parse_number()
  tab$Starostna_skupina <- NULL
  return(tab)
}
tabela <- uvozi()




# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
