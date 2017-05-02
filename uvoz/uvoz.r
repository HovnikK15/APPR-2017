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
stolpci <- c("vrsta_migrantov", "Starostna_skupina", "SPOL" , "LETO", "ST_MIGRANTOV")
library(readr)


uvozi <-function(){
  return(read.csv(file="podatki/05N1004Ss.csv",
                  col.names=stolpci,
                  fileEncoding = "UTF-8",
                  header=FALSE,
                  as.is = FALSE))
}



# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
