# @importFrom askpass askpass  < error 남, 그럼 import 는 어디서?
# @importFrom fs path
#'
#'
#' @export
install <- function(){
  pw <- askpass::askpass("Please paste your API KEY here.")
  crtfc_key <- pw

  # csv 파일 경로 추가해야되나
}

