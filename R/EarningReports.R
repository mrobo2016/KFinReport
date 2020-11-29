
#' Get a Single Companies' All Financial Statement
#'
#' Get Financial Statement for korea finance market
#'
#' @param crtfc_key is API certification key issued by openDART.
#' @param  corp_code is corporation code of the company you want to look for.
#' @param  bsns_year is business year to look for. Default is current year.
#' @param  reprt_code is report code to look for.
#' @param  fs_div is whether financial statements are consolidated or not. Default is OFS.
#' @return a [tibble][tibble::tibble-package]
#' @export
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble

# 사업, 반기, 분기 보고서
report <- function(crtfc_key, corp_code, bsns_year, reprt_code, fs_div){
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

# 영업실적
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
  return(tibble::tibble(report))
}

# 호출
'http://dart.fss.or.kr/dsaf001/main.do?rcpNo=' + rcept_no
ad <- add_headers("Accept" =  "text/html,application/xhtml+xml,application/xml;q=0.9,image/
                  avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9")


res <- httr::GET(url = 'http://dart.fss.or.kr/dsaf001/main.do?rcpNo=',
                 query = list(rcept_no = '20201110900125'), ad, verbose())
res
read_html(res)
read_html(res) %>% html_nodes(".id ifrm") %>% html_text()

content(res) %>% html_nodes('title') %>% html_text()


## 최종
# 사업보고서:y, 반기:h, 1분기:q1, 3분기: q3, 잠정:a 이렇게 바꾸기
report.earning <- function(){
  report(crtfc_key, corp_code, bsns_year, reprt_code, fs_div)
}
