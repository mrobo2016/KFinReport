
#' Get a Single Companies' All Financial Statement
#'
#' Get Financial Statement for korea finance market
#'
#' @param crtfc_key is API certification key issued by openDART.
#' @param  corp_code is corporation code of the company you want to look for.
#' @param  bsns_year is business year to look for. Default is current year.
#' @param  reprt_name is report name to look for. (q1, h, q3, y)
#' @param  fs_div is whether financial statements are consolidated or not. Default is CFS.
#' @return a [tibble][tibble::tibble-package]
#' @export
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble

change_labels <- function(reprt_name){
  x = ''
  if (reprt_name == 'y'){
    x = '11011'
  } else if (reprt_name == 'h'){
    x = '11012'
  } else if (reprt_name == 'q1'){
    x = '11013'
  } else if (reprt_name == 'q3'){
    x = '11014'
  }
  return(x)
}

consolid_or_not <- function(consolid){
  x = ''
  if (consolid == 'c'){
    x = 'CFS'
  } else if (consolid == 'nc'){
    x = 'OFS'
  }
  return(x)
}

# 사업, 반기, 분기 보고서
report_earning1 <- function(crtfc_key, corp_code, bsns_year, reprt_name, consolid ='c'){

  reprt_code <- change_labels(reprt_name)
  fs_div <- consolid_or_not(consolid)

  res <- httr::GET(url = 'https://opendart.fss.or.kr/api/fnlttSinglAcntAll.json',
                   query = list(crtfc_key = I(x = crtfc_key),
                                corp_code = corp_code,
                                bsns_year =bsns_year,
                                reprt_code = reprt_code,
                                fs_div = fs_div ))
  data <- jsonlite::fromJSON(res$url)
  report <- data$list
  return(tibble::tibble(report))
}

crtfc_key <- "22e453fa898ad0aafafec060ebc22dd916f2b3ff"
bsns_year <- '2019'
corp_code <- '00126380'
consolid <- "c"
reprt_name <- "y"

report_earning1(crtfc_key, corp_code, bsns_year, reprt_name, consolid ='c')
change_labels('y')
consolid_or_not('c')
