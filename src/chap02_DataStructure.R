# Day19; 20220929

# chap02_DataStructure

######################################
# chapter02. 데이터의 유형과 구조
######################################

# 1. Vector 자료 구조
##  - C() 함수 이용 벡터 객체 생성
x <- c(1, 2.5, 3, 4, 5) # combine 함수
x

x <- c(1:20) # 콜론 : 범위
x

y <- 10:20
y

##  - seq() 함수 이용 벡터 객체 생성
x <- seq(1, 10, 2) # sequence(시작, 종료, 증감)
x

##  - rep() 함수 이용 벡터 객체 생성
help(rep) # ?rep
example(rep)
rep(1:3, 3) # replicate(대상, 반복수)
# 1 2 3 1 2 3 1 2 3
rep(1:3, each=3)
# 1 1 1 2 2 2 3 3 3

# union(), setdiff(), intersect() 함수 이용
x <- c(1, 3, 5, 7)
y <- c(3, 5)
x; y

union(x, y)     # 합집합(x+y) # 1 3 5 7
setdiff(x, y)   # 차집합(x-y) # 1 7
intersect(x, y) # 교집합(x^y) # 3 5


# 숫자형, 문자형, 논리형 벡터 생성
v1 <- c(33, -5, 20:23, 12, -2:3) # 33 -5 20 21 22 23 12 -2 -1  0  1  2  3
v1
v2 <- c(33, -5, 20:23, 12, "4") # 데이터를 모두 문자형으로 변환. # "33" "-5" "20" "21" "22" "23" "12" "4"
v2


# 한 줄에 명령문 중복 사용
v1; mode(v1) # mode()는 자료형을 반환해줌.
v2; mode(v2)

# 벡터에 컬럼명 지정
age <- c(30, 35, 40)
age
names(age) <- c("홍길동", "이순자", "강감촌치킨")
age
#    홍길동     이순자     강감촌치킨 
#    30         35         40 
age <- NULL # age 변수 데이터 삭제
age

# 벡터 자료 참조하기
a <- c(1:50)
a[10] # index : 1부터 시작
a[c(10:45)] # 10 ~ 45 사이의 벡터 원소 출력
a[c(10, 20, 30, 40)]
a[10:(length(a)-5)] # 모든 함수가 올 수 있다. 그것을 예상하고 있어야 한다.

# 잘못된 벡터 첨자 사용 예
a[5, 10] # Error in a[5, 10] : incorrect number of dimensions


# c() 함수에서 콤마 사용 예
v1 <- c(33, -5, 20:23, 12, -2:3)
v1
v1[3:6] # 20 21 22 23
v1[c(4, 5:8, 9)]


# 음수 값으로 첨자 지정 예
v1
v1[-1] # 첫번째 인덱스를 제외시키고 실행시켜라 = 해당 위치의 원소를 제외한 값 출력
# -5 20 21 22 23 12 -2 -1  0  1  2  3
v1
v1[-c(2,4)]


# 패키지 설치와 메모리 로딩
install.packages("RSADBE") # 패키지(데이터) 설치
library(RSADBE)            # 패키지를 메모리에 로드

data("Severity_Counts")    # RSADBE 패키지에서 제공되는 데이터 셋 가져오기.
str(Severity_Counts)# Structure(구조)

# 패키지에서 제공되는 벡터데이터 셋 보기
Severity_Counts


# 2. Matrix 자료 구조
args(matrix) # (data = NA, nrow = 1, ncol = 1, byrow = FALSE, dimnames = NULL)

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
m <- matrix(c(1:11), nrow = 2, byrow = T) # 행 우선
m

m <- matrix(c(1:10), byrow = T) # 주의 - 여전히 10행 1열
# (한글) nrow 또는 ncol 중 하나가 주어지지 않으면 데이터 길이와 다른 매개 변수에서 추론하려고 시도합니다. 둘 다 주어지지 않으면 한 열 행렬이 반환됩니다.
# (english) If one of nrow or ncol is not given, an attempt is made to infer it from the length of data and the other parameter. If neither is given, a one-column matrix is returned.
# 즉 byrow 속성은 적용되지 않음.
m

m <- matrix(c(1:10), ncol = 10) # 의도한 1행 10열 # 1    2    3    4    5    6    7    8    9    10
m

# 행 묶음으로 행렬 객체 생성
x1 <- c(5, 40, 50:52)
x2 <- c(30, 5, 6:8)
mr <- rbind(x1, x2)
mr

# 열 묶음으로 행렬 객체 생성
mc <- cbind(x1, x2)
mc

# 2행으로 행렬 객체 생성
m3 <- matrix(10:19, 2)
m3

# 자료와 객체 type 보기
mode(m3) # "numeric"
class(m3) # "matrix" "array"


# 행렬 객체에 첨자로 접근
m3[2,3] # 2행 3열의 데이터 1개 : 15
m3[1,] # 1행 전체 # 10 12 14 16 18
m3[,5] # 18 19
m3[1, c(2:5)] # 1행에서 2~5열까지의 데이터터 # 12 14 16 18
m3[1, c(2, 5)] # 1행에서 2열, 5열 데이터 2개 # 12 18
m3

# 3행 3열로 행렬 객체 생성
x <- matrix(c(1:9), nrow = 3, ncol = 3) # nrow, ncol, nro, nco, nr, nc 모두 가능하다. 하지만 n, n은 안 된다.
x

# 자료의 개수 보기
length(x) # 데이터 개수
ncol(x); nrow(x) # 열 / 행 수


# apply() 함수 적용
apply(x, 1, max) # 1번은 행, 2번은 열 # 행 단위 최대값
apply(x, 1, min) # 행 단위 최소값
apply(x, 2, mean) # 열 단위 평균값
x

# Day 20; 20220930
# 사용자 정의 적용
f <- function(x){ # x : 매개변수
  x * c(1,2,3)
}

# 행(1) 우선 순서로 사용자 정의 함수 적용
result <- apply(x, 1, f)
result

# 열(2) 우선 순서로 사용자 정의 함수 적용
result <- apply(x, 2, f)
result

# 행렬 객체에 컬럼명 지정하기
colnames(x) <- c('one', 'two', 'three')
x

## 3. Array 자료 구조

# 3차원 배열 객체 생성하기
vec <- c(1:12) # 12개 벡터 객체 생성
arr <- array(vec, c(3,2,2)) # 3차원일 때는 2개의 ,, 컴마가 있다. 
# 3행 2열 2면 만들라
arr

# 3차원 배열 객체 자료 조회
arr[2,1,2] # 2행1열2면
arr[,,1] # 1면
arr[,,2] # 2면
arr[2,,1] # 1면2행

# 배열 자료형과 자료 구조
mode(arr); class(arr)


# 데이터 셋 가져오기
library(RSADBE)
data(Bug_Metrics_Software)
str(Bug_Metrics_Software)

# 데이터 셋 자료보기
Bug_Metrics_Software # array 형태로 보여줌.


## 4. List 자료 구조 # 자바의 map개념과 같다

# key를 이용하여 value에 접근하기
member <- list(name=c("홍길동", "유관순"), 
               age=c(35, 25),
               address=c("제주도","천국"),
               gender=c("남자","여자"),
               htype=c("아파트","왕국")) # 변수에 접근할 때 자바는 '.'으로 접근하듯이 R은 key값으로 '$'로 접근한다.
member

# key를 이용하여 value에 접근하기
member$name
member$name[1]
member$name[2]
member$name[3] <- "이명박" # 데이터 추가 가능하다.

member$age <- 45 # 데이터 수정(※주의: 하나의 값으로 수정.)
member

member$id <- c("hong","yu") # 데이터 항목 추가
member

member$age <- NULL
member

# 1개 값을 갖는 리스트 객체 생성
list <- list("lee","이명박",70)
list
"""
[[1]]         ----------------------> key(생략) [[n]]
[1] "lee"     ----------------------> value[n]

[[2]]
[1] "이명박"

[[3]]
[1] 70
""" # """ 3개는 그 안의 모든 것을 문자열로 인식하게 만들어줌. error표시는 그냥 무시하면 된다.

# 1개 이상의 값을 갖는 리스트 객체 생성
num <- list(c(1:5), c(6:10))
num

# 리스트 자료구조 -> 벡터 구조로 변경하기
unlist <- unlist(num) # 1차원의 배열로 형변환해줌.
unlist

# 리스트 객체에 함수 적용하기
# list data 처리 함수
a <- list(c(1:5))
b <- list(c(6:10))
a; b

c(a,b)

c <- lapply(c(a,b), max) # list로 결과 반환
c

mode(c); class(c)  # "list" "list" # key 중심으로 자료형을 보기 때문에 key로 접근해서 봐야 알 수 있다.

# 리스트 형식을 벡터(1차원) 형식으로 반환하기
c <- sapply(c(a,b), max)
c
mode(c); class(c) # 자료형:"numeric", 자료구조:"integer"

# 다차원 리스트 객체 생성
multi_list <- list(list(1,2,3), list(10,20,30), list(100,200,300))
multi_list
multi_list <- list(c1=list(1,2,3), c2=list(10,20,30), c3=list(100,200,300))
multi_list

multi_list$c1
multi_list$c2
multi_list$c3
mode(multi_list); class(multi_list)

# 다차원 리스트를 열 단위로 바인딩
d <- do.call(cbind, multi_list)
d

d <- do.call(rbind, multi_list)
d

class(d) # "matrix"

## 5. Data Frame 자료 구조 # 서로 다른 자료형으로 컬럼별로 가질 수 있다.

# 벡터 이용 객체 생성
no  <- c(1, 2, 3)
name <- c("베드로","요한","야고보")
pay <- c(150,250,300)
vemp <- data.frame(No=no,Name=name,Pay=pay)
vemp
class(vemp) # "data.frame"

# matrix 이용 객체 생성 # Day21; 20221004
args(matrix) # 매개변수에 대한 inform을 보여준다. # function (data = NA, nrow = 1, ncol = 1, byrow = FALSE, dimnames = NULL) # byrow 행우선
m <- matrix(c(1,"베드로", 153, 
              2,"다니엘", 777,
              3,"성령", 888), 3, byrow = T) # 3행으로 셋팅, byrow 행 중심으로
m
class(m)

memp <- data.frame(m) # default이름으로 X1, X2, X3 임의로 붙어줌.
memp
class(memp)

# txt 파일 이용 객체 생성
getwd()
setwd("D:/heaven_dev/workspaces/R/data")

txtemp <- read.table('emp.txt', header = T, sep = "") # header = T 이름이 있다면 col.names에 이름을 보여준다. HTML <th> 때 header같은 느낌
txtemp
class(txtemp)


# csv 파일 이용 객체 생성(header=T)
csvtemp <- read.csv('emp.csv', header = T)
csvtemp; class(csvtemp)


# csv 파일 이용 객체 생성(header=F)
name <- c("사번", "이름", "급여")
csvtemp2 <- read.csv('emp2.csv', header = F, col.names = name) # col.names에 name변수를 넣어주면 됨
csvtemp2


# 데이터프레임 만들기
df <- data.frame(x=c(1:5),y=seq(2,10,2), z=c('a', 'b', 'c', 'd', 'e')) # seq(시작, 끝, 2개씩 더해줌)
df

# 데이터프레임 컬럼명 참조
df$x; df$y; df$z

# 자료구조, 열수, 행수, 컬럼명 보기
str(df) # 5 obs. of  3 variables: # 5개의 오브젝트와 3개의 변수
ncol(df)
nrow(df)
df[c(2:3)]

# 요약 통계량 보기
summary(df) # 수치형의 값에서 필요

# 데이터프레임 자료에 함수 적용
apply(df[,c(1,2)], 2, sum) # 데이터, 행(1)·열(2), 함수를 수행
# lapply는 리스트로, sapply는 vector형태로 쭉 펼쳐서 처리.

# 데이터프레임의 부분 객체 만들기 # 전처리에서 가장 많이 사용하는 함수
# 내가 원하는 데이터를 필터하는 용도
x1 <- subset(df, x >= 3) # x가 3이상인 레코드 대상
x1

y1 <- subset(df, y <= 8) # y가 8이하인 레코드 대상
y1

# 두 개의 조건으로 부분 객체 만들기
xyand <- subset(df, x>=2 & y<=6) # R에서는 '&&' 2개 사용 안 하고 '&' 1개만 사용
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
mode(student); class(student) # list라는 자료형, data.frame
str(sid); str(score); str(subject) # sid character, score number, subject character
str(student)

# 두 개 이상의 데이터프레임 병합하기
height <- data.frame(id=c(1,2), h=c(180, 175))
weight <- data.frame(id=c(1,2), w=c(80,75))
height; weight

person <- merge(height, weight, by.x = "id", by.y = "id") # id를 기준으로 병합
person


# galton 데이터 셋 가져오기
install.packages("UsingR") # 패키지 설치
library(UsingR) # 패키지 메모리에 로드
data("galton") # galton 데이터 셋 가져오기
View(galton)

# galton 데이터 셋 구조 보기
str(galton) # 928 obs. of  2 variables:
dim(galton) # 928   2
head(galton, 20) # 상위 1~20개까지
head(galton) # default 갯수는 6개
tail(galton, 20) # 하위 1~20개까지
tail(galton)

## 6. 문자열 처리

# 문자열 추출하기
install.packages("stringr") # 패키지 설치
library(stringr) # 메모리 로딩

# 형식) str_extract('문자열', '정규표현식')
str_extract("홍길동35이순신45강감찬50","[0-9]{2}") #[0-9]사이의 숫자값, {2}연속 2자리인 것만 추출하겠다.
str_extract_all("홍길동35이순신45강감찬50","[0-9]{2}") # 모든 숫자형 문자열 데이터를 추출


# 반복수를 지정하여 영문자 추출
string <- 'hongkildong105lee1002you25베드로2005'
str_extract_all(string, '[a-z]{3}') # 3자 연속된 알파벳 추출 # 소문자, 대문자 구분
str_extract_all(string, '[a-z]{3,}') # 3글자 이상 연속된 알파벳 추출 
str_extract_all(string, '[a-z]{3,5}') # 3~5글자 범위 안에 속하는 알파벳 추출

# 특정 단어 추출
str_extract_all(string, '유관순')
str_extract_all(string, '베드로')


# 한글, 영문자, 숫자 추출하기
str_extract_all(string, 'hong')
str_extract_all(string, '25')
str_extract_all(string, '[가-힣]{3}') # 한글 검색
str_extract_all(string, '[a-z]{3}') # 소문자 검색
str_extract_all(string, '[A-Z]{3}') # 대문자 검색
str_extract_all(string, '[0-9]{4}') # 숫자 검색


# 한글, 영문자, 숫자를 제외한 나머지 추출하기
str_extract_all(string, '[^a-z]') # ^표시가 제외외
str_extract_all(string, '[^a-z]{4}') # 알파벳을 제외한 4개의 연속
str_extract_all(string, '[^가-힣]{5}')
str_extract_all(string, '[^0-9]{3}')


# 주민등록번호 검사하기
jumin <- '123456-3234567'
str_extract_all(jumin, '[0-9]{6}-[1234][0-9]{6}')
str_extract_all(jumin, '\\d{6}-[1234]\\d{6}') # \\두번을 써야지 문자 '\'로 인식
# 숫자는 \d
# 지정된 길이의 단어 추출하기
name <- '홍길동1234,이순신5678,강감찬1012'
str_extract_all(name, '\\w{7,}') # '\\w' 특수문자 제외한 모든 문자
# '\\w': 한글, 영문자, 숫자는 포함.
# '\\W': only 특수문자만 선택.
str_extract_all(name, '\\W')

# 문자열 위치(index) 구하기
string <- 'hongkd105leess1002you25강감찬2005'
str_locate(string, '강감찬') # '강'위치:24,  '찬'위치:26

# 문자열 길이 구하기
string <- 'hongkild105lee1002you25강감찬2005'
len <- str_length(string) # 30
len

# 부분 문자열
string_sub <- str_sub(string, 1, len-7) # 30-7 = 23개까지의 데이터만을
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
string_rep # "홍길동35,이순신45,유관순25,"


# 문자열 결합하기
string_c <- str_c(string_rep, '강감찬55') # 추가하고 싶을 때 str_c
string_c


# 문자열 분리하기
string_sp <- str_split(string_c, ',') # 각각의 하나의 데이터셋으로 출력
string_sp

# 문자열 합치기
string_vec <- c('홍길동35', '이순신45', '유관순25', '강감찬55')
string_vec

string_join <- paste(string_vec, collapse = ',') # 하나의 벡터로 합침.
string_join

