
#' Adgangsadressesøgning
#'
#' Søg efter adgangsadresser. Returnerer de adgangsadresser. som opfylder kriteriet.
#' Med mindre der er behov for felter som kun er med i den fulde adressestruktur
#' anbefaler vi at, man tilføjer parameteren struktur=mini, da dette vil resultere
#' i bedre performance.
#'
#' @param ... Find parametre her:
#'     \href{https://dawa.aws.dk/adgangsadressedok#adressesoegning}{Adgangsadresse parametre}
#'
#' @return En adgangsadresse er en struktureret betegnelse som angiver en særskilt
#' adgang til et areal eller en bygning efter reglerne i adressebekendtgørelsen.
#' Forskellen på en adresse og en adgangsadresse er at adressen rummer eventuel
#' etage- og/eller dørbetegnelse. Det gør adgangsadressen ikke. Du kan læse mere
#' om de værdier funktionen returnerer her:
#' \href{https://dawa.aws.dk/adgangsadressedok#adressedata}{DAWA adgangsadressedata}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Find de adgangsadresser som ligger på Rødkildevej og har husnummeret 46.
#' dawa::adgangsadresser(vejnavn = "Rødkildevej", husnr = 46, struktur = "mini")
#'
#' # Find de adgangsadresser som ligger på Rødkildevej og har husnummeret 46.
#' # Resultatet leveres i geojson format.
#' dawa::adgangsadresser(vejnavn = "Rødkildevej", husnr = 46, format = "geojson", struktur="mini")
#'
#' # Find de adgangsadresser som ligger på Rødkildevej og har husnummeret 46.
#' # Resultatet leveres i csv format.
#' dawa::adgangsadresser(vejnavn = "Rødkildevej", husnr = 46, format = "csv")
#'
#' # Find de adgangsadresser som indeholder et ord der starter med hvid og har postnummeret 2400
#' dawa::adgangsadresser(q="hvid*", postnr = 2400)
#'
#' # Find de adgangsadresser som er indenfor polygonet (10.3,55.3), (10.4,55.3),
#' # (10.4,55.31), (10.4,55.31), (10.3,55.3)
#' dawa::adgangsadresser(polygon = "[[[10.3,55.3],[10.4,55.3],[10.4,55.31],[10.4,55.31],[10.3,55.3]]]")
#'
#' # Hent alle adgangsadresser i Københavns kommune (kode 0101), i GeoJSON format,
#' # med koordinater angivet i ETRS89 / UTM zone 32N (SRID 25832)
#' dawa::adgangsadresser(kommunekode = "0101", format = "geojson", srid = 25832)
#'
#' # Find den adresse, som har KVH-nøgle 04615319__93
#' dawa::adgangsadresser(kvh = "04615319__93")
#' }
#'
adgangsadresser <- function(...){

  # Udtrækker de parametre, der er angivet i funktionskaldet
  params <- list(...)

  # Henter data fra DAWA
  get_data <- httr::GET(
    url = "https://dawa.aws.dk/adgangsadresser",
    query = params
  )

  # Tjekker om alt gik OK. Hvis ikke returnerer den fejlkoden.
  if(get_data$status_code != 200){
    stop(paste("API call went wrong.\nGET status code is not 200. Instead it is ",
               get_data$status_code))
  }

  # Udtrækker data
  get_data_content <- httr::content(get_data)

  # Returnerer data
  return(get_data_content)
}
