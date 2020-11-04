new_c14date <- function(
  bp = double(),
  std = double(),
  calcurve = character(),
  dateswithprobabilities = double(),
  source = character()
){
  checkmate::assertNumber(bp)

  checkmate::assertNumber(std)

  checkmate::assertCharacter(calcurve)

  checkmate::assertMatrix(dateswithprobabilities, mode = "numeric", nrows = 2)

  checkmate::assertCharacter(source)


  list(bp = bp, std = std, calcurve = calcurve, dateswithprobabilities = dateswithprobabilities, source = source)
  structure(
    list(
      bp = bp,
      std = std,
      calcurve = calcurve,
      dateswithprobabilities = dateswithprobabilities,
      source = source
    ),
    class = "c14date"
  )
}

c14date <- function(
  bp = double(),
  std = double(),
  calcurve = character(),
  dates = double(),
  probabilities = double(),
  source = character()
){
  if(length(dates) != length(probabilities)){
    stop(
      "Error: dates must have the same length as probabilities",
      call. = FALSE
    )
  }

  new_c14date(
    as.double(bp),
    as.double(std),
    calcurve,
    t(
      apply(
        matrix(
          c(
            as.double(dates),
            as.double(probabilities)
          ),
          ncol = 2
        ),
        2,
        rev
      )
    ),
    source
  )
}
