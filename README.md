
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/dawa)](http://cran.r-project.org/package=dawa)

dawa
====

The goal of dawa is to make it easy to get danish address data. The package is in danish since the entire official documentation is in danish and the parameters used in the API calls are danish as well.

To do
-----

-   Write tests

-   Upload to CRAN

-   Update to use `crul` for asynchronous API calls

Installation
------------

You can install dawa from github with:

``` r
# install.packages("devtools")
devtools::install_github("mikkelkrogsholm/dawa")
```

Examples
========

Adgangsadressesøgning
---------------------

Søg efter adgangsadresser. Returnerer de adgangsadresser. som opfylder kriteriet. Med mindre der er behov for felter som kun er med i den fulde adressestruktur anbefaler vi at, man tilføjer parameteren `struktur=mini`, da dette vil resultere i bedre performance.

``` r
# Find de adgangsadresser som ligger på Rødkildevej og har husnummeret 46.
dawa::adgangsadresser(vejnavn = "Rødkildevej", husnr = 46, struktur = "mini")

# Find de adgangsadresser som ligger på Rødkildevej og har husnummeret 46.
# Resultatet leveres i geojson format.
dawa::adgangsadresser(vejnavn = "Rødkildevej", husnr = 46, format = "geojson", struktur="mini")

# Find de adgangsadresser som ligger på Rødkildevej og har husnummeret 46.
# Resultatet leveres i csv format.
dawa::adgangsadresser(vejnavn = "Rødkildevej", husnr = 46, format = "csv")

# Find de adgangsadresser som indeholder et ord der starter med hvid og har postnummeret 2400
dawa::adgangsadresser(q="hvid*", postnr = 2400)

# Find de adgangsadresser som er indenfor polygonet (10.3,55.3), (10.4,55.3),
# (10.4,55.31), (10.4,55.31), (10.3,55.3)
dawa::adgangsadresser(polygon = "[[[10.3,55.3],[10.4,55.3],[10.4,55.31],[10.4,55.31],[10.3,55.3]]]")

# Hent alle adgangsadresser i Københavns kommune (kode 0101), i GeoJSON format,
# med koordinater angivet i ETRS89 / UTM zone 32N (SRID 25832)
dawa::adgangsadresser(kommunekode = "0101", format = "geojson", srid = 25832)

# Find den adresse, som har KVH-nøgle 04615319__93
dawa::adgangsadresser(kvh = "04615319__93")
```

Adressesøgning
--------------

Søg efter adresser. Returnerer de adresser som opfylder kriteriet. Med mindre der er behov for felter som kun er med i den fulde adressestruktur anbefaler vi at, man tilføjer parameteren `struktur=mini`, da dette vil resultere i bedre performance.

``` r
# Find de adresser som ligger på Rødkildevej og har husnummeret 46.
dawa::adresser(vejnavn = "Rødkildevej", husnr = 46, struktur = "mini")

# Find de adresser som ligger på Rødkildevej og har husnummeret 46.
# Resultatet leveres i geojson format.
dawa::adresser(vejnavn = "Rødkildevej", husnr = 46, format = "geojson", struktur = "mini")

# Find de adresser som ligger på Rødkildevej og har husnummeret 46.
# Resultatet leveres i csv format.
dawa::adresser(vejnavn = "Rødkildevej", husnr = 46, format = "csv")

# Find de adresser som indeholder et ord der starter med hvid og har postnummeret 2400
dawa::adresser(q = "hvid*", postnr = 2400)

# Find de adresser som er indenfor polygonet (10.3,55.3), (10.4,55.3),
# (10.4,55.31), (10.4,55.31), (10.3,55.3)
dawa::adresser(polygon = "[[[10.3,55.3],[10.4,55.3],[10.4,55.31],[10.4,55.31],[10.3,55.3]]]")

# Find den adresse, som har KVHX-nøgle 04615319__93__1____
dawa::adresser(kvhx = "04615319__93__1____")

# Hent alle adresse i postnummer 8471, i GeoJSON format, med koordinater
# angivet i ETRS89 / UTM zone 32N (SRID 25832)
dawa::adresser(postnr = 8471, format = "geojson", srid = 25832)
```

Datavask
--------

Datavask af adresse. Servicen modtager en adressebetegnelse og svarer med 1 eller flere adresser, som bedst matcher svaret. Endvidere er der en angivelse af hvor godt de fundne adresser matcher adressebetegnelsen.

``` r
# Vask adressen "Rante mester vej 8, 4, 2400 København NV"
dawa::datavask(betegnelse = "Rante mester vej 8, 4, 2400 København NV",
    type = "adresser")

# Vask adressen "Borger gade 4, STTV, 6000 Kolding"
dawa::datavask(betegnelse = "Borger gade 4, STTV, 6000 Kolding",
    type = "adgangsadresser")
```

Reverse geokodning
------------------

Find den adgangsadresse, som ligger nærmest det angivne koordinat. Som koordinatsystem kan anvendes ETRS89/UTM32 med `srid=25832` eller WGS84/geografisk med `srid=4326`. Default er WGS84.

``` r
# Returner adgangsadressen nærmest punktet angivet af WGS84/geografisk
# koordinatet (12.5851471984198, 55.6832383751223)
dawa::reverse(x = 12.5851471984198, y = 55.6832383751223, struktur = mini)

# Returner adressen nærmest punktet angivet af ETRS89/UTM32
# koordinatet (725369.59, 6176652.55)
dawa::reverse(x = 725369.59, y = 6176652.55, srid = 25832)
```
