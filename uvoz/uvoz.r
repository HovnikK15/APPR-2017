# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi preselitve iz Wikipedije

link <- "https://en.wikipedia.org/wiki/Immigration_to_Europe#Slovenia"
stran <- html_session(link) %>% read_html()
tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[6]] %>% html_table(dec = ".")
summary(tabela)

colnames(tabela) <- c("drzava", "stevilo priseljencev", "% priseljencev")
sl <- locale("sl", decimal_mark = ".")

View(tabela)

# Funkcija, ki uvozi podatke iz datoteke Meddrzavne_selitve.csv
library(readr)
uvozi(Meddrzavne_selitve) <- function(preselitve) {
  
stolpci <- c("vrsta_migrantov", "Starostna_skupina", "SPOL" , "LETO", "ST_MIGRANTOV")
  
data <- read.csv2(file="~/APPR-2017/podatki/Meddrzavne_selitve.csv", 
               locale=locale(encoding="Windows-1250"),
               col.names=stolpci, skip=4, n_max=42,
               na=c("", " ", "-"))

  
return(data)
}

# Zapišimo podatke v razpredelnico preselitve
preselitve <- uvozi.preselitve()

# Zapišimo podatke v razpredelnico Meddrzavne_selitve
Meddrzavne_selitve <- uvozi.Meddrzavne_selitve(levels(preselitve$preselitve))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
