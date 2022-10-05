# chap03_DataIO

######################################
# chapter03. 데이터 입출력
######################################

# 1. 데이터 불러오기

## 1-1. 키보드 입력

# 키보드로 숫자 입력하기
num <- scan()
num

# 합계 구하기
sum(num)

# 키보드로 문자 입력하기
name <- scan(what = character())
name

# 편집기 이용 데이터프레임 만들기
df <- data.frame() # 빈 데이터프레임 생성성
df <- edit(df)
df

## 1-2. 로컬 파일 가져오기

# 1) read.table() 함수 이용
#   - 컬럼명이 없는 파일 불러오기
getwd()
setwd("D:/heaven_dev/workspaces/R/data")

student <- read.table(file = "student.txt")
student
mode(student); class(student)

names(student) <- c('번호', '이름', '키', '몸무게')
student

#   - 컬럼명이 있는 파일 불러오기
student1 <- read.table(file = "student1.txt", header = T )
student1

#   - 탐색기를 통해서 파일 선택하기
student1 <- read.table(file.choose(), header = T)
student1

#   - 구분자가 있는 경우(세미콜론, 탭)
student2 <- read.table(file = "student2.txt", sep = ";", header = T)
student2

#   - 결측치를 처리하여 파일 불러오기
student3 <- read.table(file = "student3.txt", header = T, na.strings = "-") # 문자열 -> NA 처리
student3

#   - csv 파일 형식 불러오기 # Day22; 20221005
student4 <- read.csv(file = "student4.txt", header = T, na.strings = "-", encoding = "UTF-8")
student4

# read.xlsx() 함수 이용 - 엑셀데이터 읽어오기
# 패키지 설치와 java 실행 환경 설정
install.packages("rJava") # rJava 패키지 설치
install.packages("xlsx")  # xlsx 패키지 설치
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk-11.0.16.1')

# 관련 패키지 메모리 로드
library(rJava)
library(xlsx) # 엑셀을 읽어올 수 있음

# 엑셀 파일 가져오기
studentex <- read.xlsx("studentexcel.xlsx", encoding = "UTF-8", sheetIndex = 1) # 엑셀 한장이니깐 1
studentex

install.packages("readxl")
library(readxl) # 엑셀을 읽어올 수 있음

st_excel <- read_excel(path = "studentexcel.xlsx", sheet = 1)
st_excel

## 1-3. 인터넷에서 파일 가져오기

# 단계1 : 세계 GDP 순위 데이터 가져오기
GDP_ranking <- read.csv("https://databank.worldbank.org/data/download/GDP.csv", encoding = "UTF-8")
GDP_ranking
head(GDP_ranking, 20)
dim(GDP_ranking)

# 데이터를 가공하기 위해 불필요한 행과 열을 제거한다.
GDP_ranking2 <- GDP_ranking[-c(1:4), c(1,2,4,5)] # 1~4행까지는 빼겠다. 1,2,4,5 열만 보이겠다
head(GDP_ranking2)

# 상위 16개 국가 선별한다.
GDP_ranking16 <- head(GDP_ranking2, 16) # 상위 16개 국가
GDP_ranking16

# 데이터프레임을 구성하는 4개의 열에 대한 이름을 지정한다.
names(GDP_ranking16) <- c('Code', 'Ranking', 'Nation', 'GDP')
GDP_ranking16
dim(GDP_ranking16)


# 단계2 : 세계 GDP 상위 16위 국가 막대 차트 시각화
gdp <- GDP_ranking16$GDP
nation <- GDP_ranking16$Nation
gdp

install.packages("stringr")
library(stringr)

num_gdp <- as.numeric(str_replace_all(gdp, ',', ''))
num_gdp

GDP_ranking16$GDP <- num_gdp


# 막대차트 시각화
barplot(GDP_ranking16$GDP, col = rainbow(16),
        xlab = '국가(nation)', ylab='단위(달러)', names.arg=nation)

# 1,000단위 축소
num_gdp2 <- num_gdp / 1000
GDP_ranking16$GDP2 <- num_gdp2
barplot(GDP_ranking16$GDP2, col = rainbow(16),
        main = "2021년도 GDP 세계 16위 국가",
        xlab = '국가(nation)', ylab='단위(천달러)', names.arg=nation)

GDP_ranking16


## 1-4. 웹문서 가져오기

# 2010년 ~ 2015년도 미국의 주별 1인당 소득 자료 가져오기.
# "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

# 단계1 : XML / httr 패키지 설치
install.packages("XML")
install.packages("httr")

library(XML)
library(httr)

# 단계2 : 미국의 주별 1인당 소득 자료 가져오기.
url <- "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

get_url <- GET(url)
get_url$content # 16진수로 읽어와서 담는다
rawToChar(get_url$content)

html_cont <- readHTMLTable(rawToChar(get_url$content), stringsAsFactors=F)
class(html_cont) # "list"는 key, value 형태

html_cont <- as.data.frame(html_cont) # data.frame으로 형변환
class(html_cont) # "data.frame"
head(html_cont) # 6개만 표시하겠다.

# 단계4 : 컬럼명을 수정한 후 뒷부분 6개 관측치 보기
names(html_cont) <- c("state","y2010","y2011","y2012","y2013","y2014","y2015")


# 2. 데이터 저장하기
# 2-1. 화면(콘솔) 출력
#  1) cat() 함수
x <- 10
y <- 20
z <- x * y
cat("x * y의 결과는 ", z, "입니다. \n") # \n은 줄바꿈 # x * y의 결과는  200 입니다.

#  2) print() 함수
print(z)
print(z * 10)
print("x*y=", z) # 문자 출력이 안 됨 # Error in print.default("x*y=", z) : invalid printing digits 200



# 2-2. 파일에 데이터 저장
#  1) sink() 함수를 이용한 파일 저장
getwd()
setwd("D:/heaven_dev/workspaces/R/output")

install.packages("RSADBE")
library(RSADBE)
data("Severity_Counts") # Severity_Counts 데이터 셋 가져오기 # 출시 전후의 문제점의 개수 등급별로 나눈 것
Severity_Counts

sink("severity.txt") # 저장할 파일 open
severity <- Severity_Counts # 데이터 셋을 변수에 저장.
severity  # 콘솔에 출력되지 않고, 파일에 저장
sink()    # 오픈된 파일 close

#  2) write.table() 함수 이용 파일 저장
# 탐색기를 이용하여 데이터 가져오기
studenttx <- read.xlsx(file.choose(), sheetIndex = 1, encoding = "UTF-8")
studenttx

# 기본 속성으로 저장 - 행이름과 따옴표가 붙는다.
write.table(studenttx, "stdt.txt")

# 'row.names=F' 속성을 이용하여 행이름 제거하여 저장한다.
write.table(studenttx, "stdt2.txt", row.names =  F)

# 'quote=F' 속성을 이용하여 따옴표를 제거하여 저장한다.
write.table(studenttx, "stdt3.txt", quote = F)

# 행이름 제거 + 따옴표 제거
write.table(studenttx, "stdt4.txt", quote = F, row.names =  F)

GDP_ranking16
write.table(GDP_ranking16, "GDP_ranking16.txt", row.names = F) # 파일에 테이블 내용을 저장하는 함수

GDP_ranking16_read <- read.table("GDP_ranking16.txt", sep="", header = T)
GDP_ranking16_read

#  3) write.xlsx() 함수 이용 파일 저장 - 엑셀 파일로 저장
library(rJava)
library(xlsx) # excel data 입출력 함수 제공

st.df <- read.xlsx(file.choose(), sheetIndex = 1, encoding = "UTF-8")
st.df

write.xlsx(st.df, "studentx.xlsx") # excel 형식으로 저장

#  4) write.csv() 함수 이용 파일 저장
#     - data.frame 형식의 데이터를 csv 형식으로 저장.

write.csv(st.df, "stdf.scv",row.names = F, quote = F)








