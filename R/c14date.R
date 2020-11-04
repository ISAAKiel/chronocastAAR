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
