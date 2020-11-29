
#' Get a Single Companies' All Financial Statement
#'
#' Get Financial Statement for korea finance market
#'
#' @param crtfc_key is API certification key issued by openDART.
#' @param  corp_name is corporation name of the company you want to look for.
#' @param  bsns_year is business year to look for. Default is current year.
#' @param  reprt_name is report name to look for. Can be q1, h, q3, y.
#' @param  consolid is whether financial statements are consolidated or not. Can be c, nc. Default is c.
#' @return a [tibble][tibble::tibble-package]
#' @export
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble
# 사업, 반기, 분기 보고서
report_earning1 <- function(crtfc_key, corp_name, bsns_year, reprt_name, consolid ='c'){

  reprt_code <- change_labels(reprt_name)
  fs_div <- consolid_or_not(consolid)
  corp_code <- change_corpname(corp_name)
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


# 기업명 -> 기업코드
change_corpname <- function(corpname){
  corpcode <- corp_code %>%
    dplyr::filter(stringr::str_detect(corp_name, corpname)) %>%
    select('corp_code') %>% as.character() %>%
    stringr::str_pad(., 8, side = c('left') , pad = '0')
  return(corpcode)
}

# 사업보고서명
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

# 연결재무제표 여부
consolid_or_not <- function(consolid){
  x = ''
  if (consolid == 'c'){
    x = 'CFS'
  } else if (consolid == 'nc'){
    x = 'OFS'
  }
  return(x)
}

