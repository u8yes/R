# chap02_DataStructure

######################################
# chapter02. 데이터의 유형과 구조
######################################

# 1. Vector 자료 구조
##  - C() 함수 이용 벡터 객체 생성
x <- c(1, 2, 3, 4, 5)
x

x <- c(1:20) # 콜론 : 범위
x

y <- 10:20
y

##  - seq() 함수 이용 벡터 객체 생성
x <- seq(1, 10, 2)
x

##  - rep() 함수 이용 벡터 객체 생성
help(rep)
example(rep)
rep(1:3, 3)
# 1 2 3 1 2 3 1 2 3
rep(1:3, each=3)
# 1 1 1 2 2 2 3 3 3

# union(), setdiff(), intersect() 함수 이용
x <- c(1, 3, 5, 7)
y <- c(3, 5)
x; y

union(x, y)     # 합집합(x+y)
setdiff(x, y)   # 차집합(x-y)
intersect(x, y) # 교집합(x^y)

# 숫자형, 문자형, 논리형 벡터 생성
v1 <- c(33, -5, 20:23, 12, -2:3)
v1
v2 <- c(33, -5, 20:23, 12, "4") # 데이터를 모두 문자형으로 변환.
v2


# 한 줄에 명령문 중복 사용
v1; mode(v1)

# 벡터에 컬럼명 지정



# 벡터 자료 참조하기



# 잘못된 벡터 첨자 사용 예



# c() 함수에서 콤마 사용 예
v1 <- c(33, -5, 20:23, 12, -2:3)
v1



# 음수 값으로 첨자 지정 예



# 패키지 설치와 메모리 로딩
install.packages("RSADBE") # 패키지(데이터) 설치
library(RSADBE)            # 패키지를 메모리에 로드

data("Severity_Counts")    # RSADBE 패키지에서 제공되는 데이터 셋 가져오기.
str(Severity_Counts)

# 패키지에서 제공되는 벡터데이터 셋 보기
Severity_Counts


# 2. Matrix 자료 구조

# 벡터 이용 행렬 객체 생성
m <- matrix(c(1:5))
m  # 5행 1열

# 벡터의 열 우선으로 행렬 객체 생성
?matrix
m <- matrix(c(1:10), nrow = 2) # 2행 5열
m

# 행과 열의 수가 일치하지 않는 경우 예
m <- matrix(c(1:11), nrow = 2)
m

# 벡터의 행 우선으로 행렬 객체 생성


# 행 묶음으로 행렬 객체 생성


# 열 묶음으로 행렬 객체 생성


# 2행으로 행렬 객체 생성



# 자료와 객체 type 보기
mode(m3); class(m3) # numeric, matrix


# 행렬 객체에 첨자로 접근


# 3행 3열로 행렬 객체 생성



# 자료의 개수 보기
length(x) # 데이터 개수
ncol(x); nrow(x) # 열 / 행 수


# apply() 함수 적용


# 사용자 정의 적용


# 행 우선 순서로 사용자 정의 함수 적용


# 열 우선 순서로 사용자 정의 함수 적용


# 행렬 객체에 컬럼명 지정하기



## 3. Array 자료 구조

# 3차원 배열 객체 생성하기
vec <- c(1:12) # 12개 벡터 객체 생성
arr <- 
arr

# 3차원 배열 객체 자료 조회


# 배열 자료형과 자료 구조
mode(arr); class(arr)


# 데이터 셋 가져오기
library(RSADBE)
data(Bug_Metrics_Software)
str(Bug_Metrics_Software)

# 데이터 셋 자료보기
Bug_Metrics_Software



## 4. List 자료 구조

# key를 이용하여 value에 접근하기
member <- 
member

# key를 이용하여 value에 접근하기



# 1개 값을 갖는 리스트 객체 생성
list <- 
list



# 1개 이상의 값을 갖는 리스트 객체 생성
num <- 
num

# 리스트 자료구조 -> 벡터 구조로 변경하기
unlist <- 
unlist

# 리스트 객체에 함수 적용하기
# list data 처리 함수
a <- 
b <- 
a; b

c(a,b)

c <- 
c
mode(c); class(c)  # "list" "list"

# 리스트 형식을 벡터 형식으로 반환하기
c <- 
c
mode(c); class(c) # "numeric" "integer"

# 다차원 리스트 객체 생성
multi_list <- 
multi_list
multi_list <- 
multi_list

multi_list$c1
multi_list$c2
multi_list$c3

# 다차원 리스트를 열 단위로 바인딩
d <- 
d
class(d) # "matrix"



## 5. Data Frame 자료 구조

# 벡터 이용 객체 생성
no  <- c(1, 2, 3)
name <- c("홍길동","이순신","강감찬")
pay <- c(150,250,300)
vemp <- data.frame(No=no,Name=name,Pay=pay)
vemp
class(vemp) # "data.frame"

# matrix 이용 객체 생성
args()
m <- 
m
class(m)

memp <- 
memp
class(memp)

# txt 파일 이용 객체 생성
getwd()
setwd("C:/workspaces/Rwork/data")

txtemp <- 
txtemp
class(txtemp)


# csv 파일 이용 객체 생성(header=T)
csvtemp 
csvtemp; class(csvtemp)


# csv 파일 이용 객체 생성(header=F)
name <- c("사번", "이름", "급여")
csvtemp2 <- 
csvtemp2


# 데이터프레임 만들기
df <- 
df

# 데이터프레임 컬럼명 참조
df$x

# 자료구조, 열수, 행수, 컬럼명 보기
str(df)
ncol(df)
nrow(df)
df[c(2:3)]

# 요약 통계량 보기
summary(df)

# 데이터프레임 자료에 함수 적용
apply(df[,c(1,2)], 2, sum)

# 데이터프레임의 부분 객체 만들기
x1 <- subset(df, x >= 3) # x가 3이상인 레코드 대상
x1

y1 <- subset(df, y <= 8) # y가 8이하인 레코드 대상
y1

# 두 개의 조건으로 부분 객체 만들기
xyand <- subset(df, x>=2 & y<=6)
xyand

xyor <- subset(df, x>=2 | y<=6)
xyor

# student 데이터프레임 만들기
sid <- c('A','B','C','D')
score <- c(90, 80, 70, 60)
subject <- c('컴퓨터', '국어국문', '소프트웨어', '유아교육')

student <- data.frame(sid, score, subject)
student

# 자료형과 자료구조 보기
mode(student); class(student) # list, data.frame
str(sid); str(score); str(subject)
str(student)

# 두 개 이상의 데이터프레임 병합하기
height <- data.frame(id=c(1,2), h=c(180, 175))
weight <- data.frame(id=c(1,2), w=c(80,75))
height; weight

person <- merge()
person


# galton 데이터 셋 가져오기
install.packages("UsingR") # 패키지 설치
library(UsingR) # 패키지 메모리에 로드
data("galton") # galton 데이터 셋 가져오기

# galton 데이터 셋 구조 보기
str(galton)
dim(galton)
head(galton, 20)
head(galton) # default 갯수:6


## 6. 문자열 처리

# 문자열 추출하기
install.packages("stringr") # 패키지 설치
library(stringr) # 메모리 로딩

# 형식) str_extract('문자열', '정규표현식')
str_extract("홍길동35이순신45강감찬50","")
str_extract_all("홍길동35이순신45강감찬50","")


# 반복수를 지정하여 영문자 추출
string <- 'hongkildong105lee1002you25강감찬2005'
str_extract_all(string, '')
str_extract_all(string, '')
str_extract_all(string, '')

# 특정 단어 추출
str_extract_all(string, '유관순')
str_extract_all(string, '강감찬')


# 한글, 영문자, 숫자 추출하기
str_extract_all(string, 'hong')
str_extract_all(string, '25')
str_extract_all(string, '') # 한글 검색
str_extract_all(string, '') # 소문자 검색
str_extract_all(string, '') # 대문자 검색
str_extract_all(string, '') # 숫자 검색


# 한글, 영문자, 숫자를 제외한 나머지 추출하기
str_extract_all(string, '')
str_extract_all(string, '')
str_extract_all(string, '')
str_extract_all(string, '')


# 주민등록번호 검사하기
jumin <- '123456-3234567'
str_extract_all(jumin, '')
str_extract_all(jumin, '')

# 지정된 길이의 단어 추출하기
name <- '홍길동1234,이순신5678,강감찬1012'
str_extract_all(name, '') 
str_extract_all(name, '')

# 문자열 위치(index) 구하기
string <- 'hongkd105leess1002you25강감찬2005'
str_locate(string, '강감찬')

# 문자열 길이 구하기
string <- 'hongkild105lee1002you25강감찬2005'
len <- str_length(string) # 30
len

# 부분 문자열
string_sub <- str_sub(string, 1, len-7)
string_sub

string_sub <- str_sub(string, 1, 23)
string_sub

# 대문자, 소문자 변경하기
str_to_upper(string_sub)
str_to_lower(string_sub)

# 문자열 교체하기
string_rep <- str_replace(string_sub, 'hongkild105', '홍길동35,')
string_rep <- str_replace(string_rep, 'lee1002', '이순신45,')
string_rep <- str_replace(string_rep, 'you25', '유관순25,')
string_rep


# 문자열 결합하기
string_c <- str_c(string_rep, '강감찬55')
string_c


# 문자열 분리하기
string_sp <- str_split(string_c, ',')
string_sp

# 문자열 합치기
string_vec <- c('홍길동35', '이순신45', '유관순25', '강감찬55')
string_vec

string_join <- paste(string_vec, collapse = ',')
string_join

