#' Adressesøgning
#'
#' Søg efter adresser. Returnerer de adresser som opfylder kriteriet. Med mindre
#' der er behov for felter som kun er med i den fulde adressestruktur anbefaler
#' vi at, man tilføjer parameteren struktur=mini, da dette vil resultere i bedre
#' performance.
#'
#' @param ... Find parametre her:
#'     \href{https://dawa.aws.dk/adressedok#adressesoegning}{Adresse parametre}
#'
#' @return En adresse er en struktureret betegnelse som angiver en særskilt adgang
#' til et areal, en bygning eller en del af en bygning efter reglerne i
#' adressebekendtgørelsen. Du kan læse mere om de værdier funktionen returnerer
#' her: \href{https://dawa.aws.dk/adressedok#adressedata}{DAWA adressedata}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Find de adresser som ligger på Rødkildevej og har husnummeret 46.
#' dawa::adresser(vejnavn = "Rødkildevej", husnr = 46, struktur = "mini")
#'
#' # Find de adresser som ligger på Rødkildevej og har husnummeret 46.
#' # Resultatet leveres i geojson format.
#' dawa::adresser(vejnavn = "Rødkildevej", husnr = 46, format = "geojson", struktur = "mini")
#'
#' # Find de adresser som ligger på Rødkildevej og har husnummeret 46.
#' # Resultatet leveres i csv format.
#' dawa::adresser(vejnavn = "Rødkildevej", husnr = 46, format = "csv")
#'
#' # Find de adresser som indeholder et ord der starter med hvid og har postnummeret 2400
#' dawa::adresser(q = "hvid*", postnr = 2400)
#'
#' # Find de adresser som er indenfor polygonet (10.3,55.3), (10.4,55.3),
#' # (10.4,55.31), (10.4,55.31), (10.3,55.3)
#' dawa::adresser(polygon = "[[[10.3,55.3],[10.4,55.3],[10.4,55.31],[10.4,55.31],[10.3,55.3]]]")
#'
#' # Find den adresse, som har KVHX-nøgle 04615319__93__1____
#' dawa::adresser(kvhx = "04615319__93__1____")
#'
#' # Hent alle adresse i postnummer 8471, i GeoJSON format, med koordinater
#' # angivet i ETRS89 / UTM zone 32N (SRID 25832)
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
    stop(paste("API call went wrong.\nGET status code is not 200. Instead it is ",
               get_data$status_code))
  }

  # Udtrækker data
  get_data_content <- httr::content(get_data)

  # Returnerer data
  return(get_data_content)
}
