
#' Get a Single Companies' All Financial Statement
#'
#' Get Financial Statement for korea finance market
#'
#' @param crtfc_key is API certification key issued by openDART.
#' @param  corp_code is corporation code of the company you want to look for.
#' @param  bsns_year is business year to look for. Default is current year.
#' @param  reprt_code is report code to look for.
#' @param  fs_div is whether financial statements are consolidated or not. Default is CFS.
#' @return a [tibble][tibble::tibble-package]
#' @export
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble

# 사업, 반기, 분기 보고서
report_earning1 <- function(crtfc_key, corp_code, bsns_year, reprt_code, fs_div ='CFS'){
  res <- httr::GET(url = 'https://opendart.fss.or.kr/api/fnlttSinglAcntAll.json',
                   query = list(crtfc_key = I(x = '22e453fa898ad0aafafec060ebc22dd916f2b3ff'),
                                corp_code = corp_code,
                                bsns_year =bsns_year,
                                reprt_code = reprt_code,
                                fs_div = fs_div ))
  data <- jsonlite::fromJSON(res$url)
  report <- data$list
  return(tibble::tibble(report))
}

# 영업실적- report_earning2
## openDART로 report_nm 가져오기
get_report_nm <- function(crtfc_key, corp_code,bgn_de, end_de, corp_cls){
  res <- httr::GET(url = 'https://opendart.fss.or.kr/api/list.json',
                   query = list(crtfc_key = I(x = crtfc_key),
                                corp_code = corp_code,
                                bgn_de =bgn_de,
                                end_de = end_de,
                                pblntf_ty = 'I',
                                pblntf_detail_ty = 'I002',
                                corp_cls = 'Y',
                                page_no = '1',
                                page_count = '10'), verbose())
  data <- jsonlite::fromJSON(res$url)$list %>% filter(stringr::str_detect(report_nm, "잠정"))
  rcpNo <- data$rcept_no
  return(rcpNo)
}

bsns_perform <- function(rcpNo ){
  httr::GET("http://dart.fss.or.kr/dsaf001/main.do?rcpNo=20201110900125") %>%
    httr::content() %>%
    rvest::html_nodes("script") %>%
    .[str_detect(., "winTestNotice")] %>%
    stringr::str_split("\n") %>%
    tibble::tibble(data = .) %>%
    tidyr::unnest(cols = c(data)) %>%
    dplyr::filter(stringr::str_detect(data, "javascript: viewDoc")) %>%
    dplyr::pull(data) %>%
    stringr::str_split("'") %>%
    .[[1]] %>%
    .[4]-> dcmNo
  # request url
  httr::GET("http://dart.fss.or.kr/report/viewer.do",
            query = list(
              rcpNo = rcpNo,
              dcmNo = dcmNo,
              eleId=0,
              offset=0,
              length=0,
              dtd="HTML"
            )) %>% content(encoding = "cp949") %>% html_nodes("table") -> table


}
