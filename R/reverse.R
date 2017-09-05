#' Reverse geokodning
#' Find den adgangsadresse, som ligger nærmest det angivne koordinat. Som
#' koordinatsystem kan anvendes ETRS89/UTM32 med srid=25832 eller WGS84/geografisk
#' med srid=4326. Default er WGS84.
#'
#' @param ... Find parametre her:
#'     \href{https://dawa.aws.dk/adgangsadressedok#reversegeokodning}{Reverse geokodning parametre}
#'
#' @return
#' En adgangsadresse er en struktureret betegnelse som angiver en særskilt adgang
#' til et areal eller en bygning efter reglerne i adressebekendtgørelsen.
#' Forskellen på en adresse og en adgangsadresse er at adressen rummer eventuel
#' etage- og/eller dørbetegnelse. Det gør adgangsadressen ikke. Du kan læse mere
#' om de værdier funktionen returnerer her:
#' \href{https://dawa.aws.dk/adgangsadressedok#adressedata}{DAWA adgangsadressedata}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Returner adgangsadressen nærmest punktet angivet af WGS84/geografisk
#' # koordinatet (12.5851471984198, 55.6832383751223)
#' dawa::reverse(x = 12.5851471984198, y = 55.6832383751223, struktur = mini)
#'
#' # Returner adressen nærmest punktet angivet af ETRS89/UTM32
#' # koordinatet (725369.59, 6176652.55)
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
    stop(paste("API call went wrong.\nGET status code is not 200. Instead it is ",
               get_data$status_code))
  }

  # Udtrækker data
  get_data_content <- httr::content(get_data)

  # Returnerer data
  return(get_data_content)
}

