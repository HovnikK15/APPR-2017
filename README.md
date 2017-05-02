# Analiza podatkov s programom R, 2016/17

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Tematika

Izbral sem si temo z naslovom Analiza gospodarstva Velike Britanije in primerjava z evropskimi državami. Najprej bom natančneje analiziral posamezne komponente, ki vplivajo na gospodarstvo, kot so: BDP, brezposelnost, izvoz/uvoz,.. Nato bom primerjal še gospodarstvo VB z evropskim gospodarstvom, katere komponente najbolj vplivajo na gospodarstvo v posameznih evropskih državah..
JOWW
Podatki so dostopni na SURS-u in na Eurostatu.
V tabeli bom navedel naslednje podatke za zadnje desetletje:
- BDP (urejenostna spremenljivka)
- leto (razvrščevalna spremenljivka)
- BDPpc (številska spremenljivka)
- rast BDP (številska spremenljivka)
- % brezposelnosti (številska spremenljivka)
- struktura BDP (številska spremenljivka)

Kasneje bom analiziral še gospodarstvo drugih evropskih držav. V tabeli bom navedel naslednje podatke, prav tako za zadnje desetletje:

- ime države (imenska spremenljivka)
- BDP (številska spremenljivka)
- struktura BDP (številska spremenljivka)

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
