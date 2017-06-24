#' Datavask
#'
#' Datavask af adresse. Servicen modtager en adressebetegnelse og svarer med 1 eller flere adresser, som bedst matcher svaret. Endvidere er der en angivelse af hvor godt de fundne adresser matcher adressebetegnelsen.
#'
#' @param betegnelse Adressebetegnelsen for den adresse som ønskes vasket, f.eks. "Augustenborggade 5, 5. 3, 8000 Aarhus C". Adressebetegnelsen kan leveres med eller uden supplerende bynavn.
#' @param type Vælg om det skal være "adgangsadresser" eller "adresser".
#'
#' @return
#' \tabular{ll}{
#' kategori      \tab Angiver, hvor godt de(n) returnerede adresse(r) matcher adressebetegnelsen. "A" angiver, at den returnerede adresse matcher præcist, bortset fra forskelle på store og små bogstaver samt punktuering. "B" angiver et sikkert match, hvor der dog er mindre variationer (stavefejl eller lignende). C angiver et usikkert match,  hvor der er en stor sansynlighed for at den fundne adresse ikke er korrekt. For kategori A og B gælder, at der kun returneres én adresse. For kategori C kan der returneres flere adresser.\cr
#' resultater    \tab En liste af de adresser, som bedst matcher adressebetegnelsen, samt information om hvordan hver enkelt adresse matcher. Listen er ordnet efter hvor godt de matcher adressebetegnelsen med den bedst matchende adresse først. \cr
#' adresse       \tab Den (muligvis historiske) adresse, som matchede adressebetegnelsen \cr
#' aktueladresse \tab Den aktuelle version af den adresse, som matchede adressebetegnelsen. Bemærk, at adressen kan være nedlagt (statuskode 2 eller 4). \cr
#' vaskeresultat \tab Information om hvordan adressebetegnelsen matchede den fundne adresse \cr
#' afstand       \tab Levenshtein afstanden mellem adressebetegnelsen og den fundne adresses adressebetegnelse \cr
#' parsetadresse \tab En angivelse af, hvordan adressebetegnelsen blev parset til en struktureret adresse \cr
#' forskelle     \tab Levenshtein afstand mellem hvert felt i den parsede adresse og den fundne adresse \cr
#' ukendtetokens \tab En liste over de tokens i adressebetegnelsen, som ikke kunne knyttes til en del af den fundne adresse \cr
#' item          \tab Den ukendte token
#' }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Vask adressen "Rante mester vej 8, 4, 2400 København NV"
#' dawa::datavask(betegnelse = "Rante mester vej 8, 4, 2400 København NV", type = "adresser")
#'
#' # Vask adressen "Borger gade 4, STTV, 6000 Kolding"
#' dawa::datavask(betegnelse = "Borger gade 4, STTV, 6000 Kolding", type = "adgangsadresser")
#' }

datavask <- function(betegnelse = NULL, type = NULL){

  # Tjekker at type er udfyldt
  if(is.null(type)) stop("Du skal vælge type: adresser eller adgangsadresser")

  # Sætter url til kald afhængig af type
  if(type == "adresser")  url <- "https://dawa.aws.dk/datavask/adresser"
  if(type == "adgangsadresser")  url <- "https://dawa.aws.dk/datavask/adgangsadresser"

  # Tjekker at betegnelse er udfyldt
  if(is.null(betegnelse)) stop("Betegnelse skal være udfyldt. Se evt eksempler.")

  params <- list(betegnelse = betegnelse)

  # Henter data fra DAWA
  get_data <- httr::GET(
    url = url,
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


