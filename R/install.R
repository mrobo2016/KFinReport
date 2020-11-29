# @importFrom askpass askpass  < error 남, 그럼 import 는 어디서?
# @importFrom fs path
#'
#'
#' @export
install <- function(){
  pw <- askpass::askpass("Please paste your API KEY here.")
  crtfc_key <- pw

  # corp_code_path <- askpass::askpass("Please paste your Coportation Code csv here.")
  # corpcode = read.csv(corp_code_path, encoding  = 'CP949')
}
