#' Reverse geokodning
#' Find den adgangsadresse, som ligger nærmest det angivne koordinat. Som koordinatsystem kan anvendes ETRS89/UTM32 med srid=25832 eller WGS84/geografisk med srid=4326. Default er WGS84.
#'
#' @param x X koordinat. (Hvis ETRS89/UTM32 anvendes angives øst-værdien.) Hvis WGS84/geografisk anvendex angives bredde-værdien.
#' @param y Y koordinat. (Hvis ETRS89/UTM32 anvendes angives nord-værdien.) Hvis WGS84/geografisk anvendex angives længde-værdien.
#' @param srid Angiver SRID for det koordinatsystem, som geospatiale parametre er angivet i. Default er 4326 (WGS84).
#' @param callback Output leveres i JSONP format. Se Dataformater.
#' @param format Output leveres i andet format end JSON. Se Dataformater.
#' @param noformat Parameteren angiver, at whitespaceformatering skal udelades
#' @param struktur Angiver om der ønskes en fuld svarstruktur (nestet), en flad svarstruktur (flad) eller en reduceret svarstruktur (mini).  Mulige værdier: "nestet", "flad" eller "mini".  For JSON er default "nestet", og for CSV og GeoJSON er default "flad". Det anbefales at benytte mini-formatet hvis der ikke er behov for den fulde struktur, da dette vil give bedre svartider.
#'
#' @return
#' En adgangsadresse er en struktureret betegnelse som angiver en særskilt adgang til et areal eller en bygning efter reglerne i adressebekendtgørelsen. Forskellen på en adresse og en adgangsadresse er at adressen rummer eventuel etage- og/eller dørbetegnelse. Det gør adgangsadressen ikke. Du kan læse mere om de værdier funktionen returnerer her: \href{https://dawa.aws.dk/adgangsadressedok#adressedata}{DAWA adgangsadressedata}
#' @export
#'
#' @examples
#' \dontrun{
#' # Returner adgangsadressen nærmest punktet angivet af WGS84/geografisk koordinatet (12.5851471984198, 55.6832383751223)
#' dawa::reverse(x = 12.5851471984198, y = 55.6832383751223, struktur = mini)
#'
#' # Returner adressen nærmest punktet angivet af ETRS89/UTM32 koordinatet (725369.59, 6176652.55)
#' dawa::reverse(x = 725369.59, y = 6176652.55, srid = 25832)
#' }

reverse <- function(...){

  # Udtrækker de parametre, der er angivet i funktionskaldet
  params <- list(...)

  # Henter data fra DAWA
  get_data <- httr::GET(
    url = "https://dawa.aws.dk/adgangsadresser/reverse",
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

