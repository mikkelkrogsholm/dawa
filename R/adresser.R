#' Adressesøgning
#'
#' Søg efter adresser. Returnerer de adresser som opfylder kriteriet. Med mindre der er behov for felter som kun er med i den fulde adressestruktur anbefaler vi at, man tilføjer parameteren struktur=mini, da dette vil resultere i bedre performance.
#'
#' @param ... En af de nedenstående parametre.
#' @param q Søgetekst. Der søges i vejnavn, husnr, etage, dør, supplerende bynavn, postnr og postnummerets navn. Alle ord i søgeteksten skal matche adressebetegnelsen. Wildcard * er tilladt i slutningen af hvert ord. Der skelnes ikke mellem store og små bogstaver.
#' @param fuzzy Aktiver fuzzy søgning
#' @param id Adressens unikke id, f.eks. 0a3f5095-45ec-32b8-e044-0003ba298018. (Flerværdisøgning mulig).
#' @param adgangsadresseid Id på den til adressen tilknyttede adgangsadresse. UUID. (Flerværdisøgning mulig).
#' @param etage Etagebetegnelse. Hvis værdi angivet kan den antage følgende værdier: tal fra 1 til 99, st, kl, k2 op til k9. (Flerværdisøgning mulig). Søgning efter ingen værdi mulig.
#' @param dør Dørbetegnelse. Tal fra 1 til 9999, små og store bogstaver samt tegnene / og -. (Flerværdisøgning mulig). Søgning efter ingen værdi mulig.
#' @param kvhx KVHX-nøgle. 19 tegn bestående af 4 cifre der repræsenterer kommunekode, 4 cifre der repræsenterer vejkode, 4 tegn der repræsenter husnr, 3 tegn der repræsenterer etage og 4 tegn der repræsenter dør. Se databeskrivelse.
#' @param status Adressens status, som modtaget fra BBR. "1" angiver en endelig adresse og "3" angiver en foreløbig adresse". Adresser med status "2" eller "4" er ikke med i DAWA.
#' @param vejkode Vejkoden. 4 cifre. (Flerværdisøgning mulig).
#' @param vejnavn Vejnavn. Der skelnes mellem store og små bogstaver. (Flerværdisøgning mulig). Søgning efter ingen værdi mulig.
#' @param husnr Husnummer. Max 4 cifre eventuelt med et efterfølgende bogstav. (Flerværdisøgning mulig).
#' @param husnrfra Returner kun adresser hvor husnr er større eller lig det angivne.
#' @param husnrtil Returner kun adresser hvor husnr er mindre eller lig det angivne. Bemærk, at hvis der angives f.eks. husnrtil=20, så er 20A ikke med i resultatet.
#' @param supplerendebynavn Det supplerende bynavn. (Flerværdisøgning mulig). Søgning efter ingen værdi mulig.
#' @param postnr Postnummer. 4 cifre. (Flerværdisøgning mulig).
#' @param kommunekode Kommunekoden for den kommune som adressen skal ligge på. 4 cifre. (Flerværdisøgning mulig).
#' @param ejerlavkode Koden på det matrikulære ejerlav som adressen skal ligge på.
#' @param zonekode Heltalskoden for den zone som adressen skal ligge i. Mulige værdier er 1 for byzone, 2 for sommerhusområde og 3 for landzone. (Flerværdisøgning mulig).
#' @param zone Adressens zonestatus. Mulige værdier: "Byzone", "Sommerhusområde" eller "Landzone" (Flerværdisøgning mulig).
#' @param matrikelnr Matrikelnummer. Unikt indenfor et ejerlav.
#' @param esrejendomsnr ESR Ejendomsnummer. Indtil 7 cifre. Søger på esrejendomsnummeret for det tilknyttede jordstykke. (Flerværdisøgning mulig).
#' @param srid Angiver SRID for det koordinatsystem, som geospatiale parametre er angivet i. Default er 4326 (WGS84).
#' @param polygon Find de adresser, som ligger indenfor det angivne polygon. Polygonet specificeres som et array af koordinater på samme måde som koordinaterne specificeres i GeoJSON's polygon. Bemærk at polygoner skal være lukkede, dvs. at første og sidste koordinat skal være identisk. Som koordinatsystem kan anvendes (ETRS89/UTM32 eller) WGS84/geografisk. Dette angives vha. srid parameteren, se ovenover. Eksempel:  polygon=[[[10.3,55.3],[10.4,55.3],[10.4,55.31],[10.4,55.31],[10.3,55.3]]].
#' @param cirkel Find de adresser, som ligger indenfor den cirkel angivet af koordinatet (x,y) og radius r. Som koordinatsystem kan anvendes (ETRS89/UTM32 eller) WGS84/geografisk. Radius angives i meter. cirkel={x},{y},{r}.
#' @param nøjagtighed Find adresser hvor adgangspunktet har en den angivne nøjagtighed. Mulige værdier er "A", "B" og "U" (Flerværdisøgning mulig).
#' @param regionskode Find de adresser som ligger indenfor regionen angivet ved regionkoden. (Flerværdisøgning mulig). Søgning efter ingen værdi mulig.
#' @param sognekode Find de adresser som ligger indenfor sognet angivet ved sognkoden. (Flerværdisøgning mulig). Søgning efter ingen værdi mulig.
#' @param opstillingskredskode Find de adresser som ligger indenfor opstillingskredsen angivet ved opstillingskredskoden. (Flerværdisøgning mulig). Søgning efter ingen værdi mulig.
#' @param retskredskode Find de adresser som ligger indenfor retskredsen angivet ved retskredskoden. (Flerværdisøgning mulig). Søgning efter ingen værdi mulig.
#' @param politikredskode Find de adresser som ligger indenfor politikredsen angivet ved politikredskoden. (Flerværdisøgning mulig). Søgning efter ingen værdi mulig.
#' @param bebyggelsesid Find de adresser som ligger indenfor bebyggelsen med den angivne ID (Flerværdisøgning mulig).
#' @param bebyggelsestype Find de adresser som ligger en bebyggelse af den angivne type. Mulige værdier: "by", "bydel", "spredtBebyggelse", "sommerhusområde", "sommerhusområdedel", "industriområde", "kolonihave", "storby". (Flerværdisøgning mulig).
#' @param callback Output leveres i JSONP format. Se Dataformater.
#' @param format Output leveres i andet format end JSON. Se Dataformater.
#' @param noformat Parameteren angiver, at whitespaceformatering skal udelades
#' @param side Angiver hvilken siden som skal leveres. Se Paginering.
#' @param per_side Antal resultater per side. Se Paginering.
#' @param struktur Angiver om der ønskes en fuld svarstruktur (nestet), en flad svarstruktur (flad) eller en reduceret svarstruktur (mini).  Mulige værdier: "nestet", "flad" eller "mini".  For JSON er default "nestet", og for CSV og GeoJSON er default "flad". Det anbefales at benytte mini-formatet hvis der ikke er behov for den fulde struktur, da dette vil give bedre svartider.
#'
#' @return
#' En adresse er en struktureret betegnelse som angiver en særskilt adgang til et areal, en bygning eller en del af en bygning efter reglerne i adressebekendtgørelsen.
#' Du kan læse mere om de værdier funktionen returnerer her: \href{https://dawa.aws.dk/adressedok#adressedata}{DAWA adressedata}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Find de adresser som ligger på Rødkildevej og har husnummeret 46.
#' dawa::adresser(vejnavn = "Rødkildevej", husnr = 46, struktur = "mini")
#'
#' # Find de adresser som ligger på Rødkildevej og har husnummeret 46. Resultatet leveres i geojson format.
#' dawa::adresser(vejnavn = "Rødkildevej", husnr = 46, format = "geojson", struktur = "mini")
#'
#' # Find de adresser som ligger på Rødkildevej og har husnummeret 46. Resultatet leveres i csv format.
#' dawa::adresser(vejnavn = "Rødkildevej", husnr = 46, format = "csv")
#'
#' # Find de adresser som indeholder et ord der starter med hvid og har postnummeret 2400
#' dawa::adresser(q = "hvid*", postnr = 2400)
#'
#' # Find de adresser som er indenfor polygonet (10.3,55.3), (10.4,55.3), (10.4,55.31), (10.4,55.31), (10.3,55.3)
#' dawa::adresser(polygon = "[[[10.3,55.3],[10.4,55.3],[10.4,55.31],[10.4,55.31],[10.3,55.3]]]")
#'
#' # Find den adresse, som har KVHX-nøgle 04615319__93__1____
#' dawa::adresser(kvhx = "04615319__93__1____")
#'
#' # Hent alle adresse i postnummer 8471, i GeoJSON format, med koordinater angivet i ETRS89 / UTM zone 32N (SRID 25832)
#' dawa::adresser(postnr = 8471, format = "geojson", srid = 25832)
#' }

adresser <- function(...){

  # Udtrækker de parametre, der er angivet i funktionskaldet
  params <- list(...)

  # Henter data fra DAWA
  get_data <- httr::GET(
    url = "https://dawa.aws.dk/adresser",
    query = params
  )

  # Tjekker om alt gik OK. Hvis ikke returnerer den fejlkoden.
  if(get_data$status_code != 200){
    stop(paste("API call went wrong.\nGET status code is not 200. Instead it is ", get_data$status_code))
  }

  # Udtrækker data
  get_data_content <- httr::content(get_data)

  # Returnerer data
  return(get_data_content)
}
