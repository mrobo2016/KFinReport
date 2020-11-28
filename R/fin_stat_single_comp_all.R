# 단일회사 전체 재무제표
library(jsonlite)

# 상장기업 고유번호 가져오기
corpcode = read.csv("C:/Users/swan3/Desktop/RTHON/RTHON/data/corp_code.csv", encoding  = 'CP949')

get_fin_stat_single_comp <- function(crtfc_key, corp_code,bsns_year, reprt_code, fs_div){
  url = paste0('https://opendart.fss.or.kr/api/fnlttSinglAcntAll.json?','crtfc_key=',crtfc_key,'&corp_code=',corp_code,'&bsns_year=', bsns_year,'&reprt_code=',reprt_code,  '&fs_div=', fs_div)
  data = fromJSON(url)
  report = data$list

  if (report$'reprt_code' == '11011'){
    colnames(report) = c("접수번호","보고서코드","사업연도","고유번호","재무제표구분", "재무제표명",
                         "계정ID","계정명","계정상세","당기명","당기금액","전기명","전기금액","전전기명","전전기금액",
                         "계정과목정렬순서", "당기누적금액")}
  else {
    colnames(report) = c("접수번호","보고서코드","사업연도","고유번호","재무제표구분", "재무제표명",
                         "계정ID","계정명","계정상세","당기명","당기금액","전기명","전기금액",
                         "계정과목정렬순서", "당기누적금액", "전기명(분/반기)",
                         "전기금액(분/반기)","전기누적금액") }
  return(report)
}


