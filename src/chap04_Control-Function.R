# chap04_Control-Function

####################################################
# chapter04-1. 연산자 / 제어문(조건문과 반복문)
####################################################

###################
##  1. 연산자
###################

# 산술연산자
num1 <- 100 # 피연산자1
num2 <- 20  # 피연산자2

result <- num1 + num2  # 덧셈
result
result <- num1 - num2  # 뺄셈
result
result <- num1 * num2  # 곱셈
result
result <- num1 / num2  # 나눗셈
result

result <- num1 %% num2  # 나머지 연산자
result

result <- num1^2   # 제곱연산자(num1 ** 2)
result

result <- num1^num2   # 100의 20승(10의 40승과 동일한 결과)
result   # [1] 1e+40 -> 1 * 10^40


# 비교(관계) 연산자
# (1) 동등비교
boolean <- num1 == num2 # 두 변수의 값이 같은지 비교
boolean
boolean <- num1 != num2 # 두 변수의 값이 다른지 비교
boolean

# (2) 크기비교
boolean <- num1 > num2
boolean
boolean <- num1 >= num2
boolean
boolean <- num1 < num2
boolean
boolean <- num1 <= num2
boolean

# 논리 연산자
logical <- num1 >= 50 & num2 <= 10
logical

logical <- num1 >= 50 | num2 <= 10
logical

x <- TRUE; y <- FALSE # 둘 중 하나만 달라도 TRUE
xor(x, y)
x <- TRUE; y <- TRUE # 둘이 같으면 무조건 FALSE
xor(x, y)

logical <- num1 >= 50
logical

logical <- !(num1 >= 50)
logical


###############################
## 2. 조건문
###############################

# 1) if()
x <- 10
y <- 5
z <- x * y
z

#if(조건식){ 산술/비교/논리 연산자
#    실행문1 <- 참
#}else{
#    실행문1 <- 거짓
#}

if(x*y > 40){ # 산술 > 비교 > 논리
  cat("x*y의 결과는 40이상입니다.\n")  # \n :줄바꿈
  cat("x*y = ", z, '\n')
  print(z)
}else{
  cat("x*y의 결과는 40미만입니다. x*y=", z, "\n")
}


# 학점 구하기
score <- scan()
score

if(score >= 90){ # 조건식1
  result = "A학점"
}else if(score >= 80){ # 조건식1
  result = "B학점"
}else if(score >= 70){ # 조건식2
  result = "C학점"
}else if(score >= 60){ # 조건식3
  result = "D학점"
}else{
  result = "F학점"
}

cat("당신의 학점은 ", result) # 당신의 학점은?
print(result)


# 2) ifelse(조건, 참, 거짓) - 3항 연산자 기능
# <JAVA에서는> (boolean)? true:false ;
score <- c(78, 95, 85, 65)
score
ifelse(score >= 80, "우수", "노력") # 우수 = TRUE, 노력 = FALSE
# "노력" "우수" "우수" "노력" # FALSE TRUE TRUE FALSE

# ifelse() 응용 # Day23; 20221006 #
getwd()
setwd("D:/heaven_dev/workspaces/R/data")

excel <- read.csv("excel.csv", header = T)
excel

q1 <- excel$q1 # q1 변수값 추출
q1
ifelse(q1 >= 3, sqrt(q1), q1) # 3보다 큰 경우 sqrt() 함수 적용.
ifelse(q1 >= 2 & q1 <= 4, q1^2, q1)

# 3) switch문
#   형식) switch(비교구문, 실행구문1, 실행구문2, 실행구문3, ...)
switch("name", id="hong", pwd="1234", age=25, name="홍길동") 

empname <- scan(what = "")
empname # "kang"

switch(empname, hong=250, lee=350, kim=200, kang=400) # 400

# 4) which문
#   - which()의 괄호내의 조건에 해당하는 위치(인덱스)를 출력한다.
#   - 벡터에서 사용 -> index값 리턴.

name <- c("kim", "lee", "choi", "park")
which(name == "choi") # 3(index)

# 데이터프레임에서 사용
no <- c(1:5)
name <- c("홍길동", "이순신", "강감찬", "유관순", "김유신")
score <- c(85, 78, 89, 90, 74)

exam <- data.frame(학번=no, 이름=name, 성적=score)
exam

sel <- which(exam$이름=="유관순") # 4
sel # 4 
exam[sel,]


#################
## 3. 반복문
#################

# 1) 반복문 - for(변수 in 값){ 표현식 }

i <- c(1:10)
i

d <- numeric() # 빈 vector(숫자)

for(n in i){ # 10회 반복
  print(n*10)
  print(n)
  d[n] <- n*2
}

d

for(n in i){
  if(n %% 2 != 0){
    print(n) # %% : 나머지 값 - 홀수만 출력.
  }
}

for(n in i){
  if(n %% 2 == 0){
    next # 다음 문장 skip -> 반복문 계속(자바의 continue 키워드와 동일.) # next 다시 반복문을 실행하러 돌아가라
  }else{
    print(n) # %% : 나머지 값 - 홀수만 출력.
  }
}

# 벡터 데이터 사용 예
score <- c(85, 95, 98)
name <- c("홍길동", "이순신", "강감찬")

i <- 1 # 첨자로 사용되는 변수
for(s in score){
  cat(name[i], " -> ", s, "\n")
  i <- i+1
}

# 2) 반복문 - while(조건){표현식}
i = 0

while(i < 10){ # ()는 boolean값만 올 수 있다. 그래야 무한반복을 피할 수 있다.
  i <- i + 1
  print(i)
}


####################################################
# chapter04-2. 사용자 정의 함수와 내장 함수
####################################################

## 1. 사용자 정의 함수

# 함수 정의 형식 # 변수에다 function으로 담아서 관리할 수 있다. (자바X)
# 변수 <- function([매개변수]){
#            함수의 실행문
#         }

# 함수 호출
#  - 변수([매개변수])


# 매개변수가 없는 함수 예
f1 <- function(){
          cat("매개변수가 없는 함수")
      }

f1() # 함수 호출 방법 # 호출은 항상 ()


# 매개변수가 있는 함수 예
f2 <- function(x){
         cat("x의 값 = ", x, "\n")
         print(x)
      }

f2(10) # 실인수 # 변수 이름에 10의 갯수만큼 데이터로 전달
f2(c(1:10)) # 벡터


# 리턴값이 있는 함수 예
f3 <- function(x, y){
          add <- x + y # 덧셈
          return (add)   # 결과 반환
      }

add <- f3(10, 30) # ()는 함수를 호출
add

# 기술 통계량을 계산하는 함수 정의
# 파일 불러오기
getwd()
setwd("D:/heaven_dev/workspaces/R/data")

test <- read.csv("test.csv", header = T) # data.frame으로 읽어옴
head(test)
test # 200행

# A 컬럼 요약통계량, 빈도수 구하기.
summary(test) # 요약통계량.
table(test$A) # A 변수 대상 빈도 수. # table()은 빈도수 # (빈)도수분포표
max(test$A)   # 최대값
min(test$A)   # 최소값
# table에서 도수분포표에 갯수로 나누어주면 확률분포표
length(test)  # 5


# 각 컬럼 단위 요약통계량과 빈도 수 구하기.
data_pro <- function(x){

  for(idx in 1:length(x)){
    cat(idx, '번째 컬럼의 빈도분석 결과')
    print(table(x[idx]))
    cat('\n')
  }

  for(idx in 1:length(x)){
    f <- table(x[idx])
    cat(idx, '번째 컬럼의 최대값/최소값 \n')
    cat("max=", max(f), "min=", min(f), '\n')
  }
}

data_pro(test) # 함수 호출


# 분산과 표준편차를 구하는 함수 정의
z <- c(7, 5, 12, 9, 15, 6) # x 변량 생성

var_sd <- function(x){
  var <- sum((x-mean(x))^2) / (length(x)-1) # 표본분산
  sd <- sqrt(var) # root를 씌운 것을 sqrt()
  cat('표본분산:', var, '\n')
  cat('표본 표준편차:', sd, '\n')
}

var_sd(z)

# 결측치(NA) 데이터 처리
data <- c(10, 20, 5, 4, 40, 7, NA, 6, 3, NA, 2, NA)
data

mean(data) # NA # mean은 평균을 구하는 함수
mean(data, na.rm = T) # 10.77778 # na.remove = TRUE하고 결과를 보여줌

# 구구단 출력 함수
gugudan <- function(i, j){
  for(x in i){
    cat("== ", x, "단 ==\n")

    for(y in j){
      cat(x, "*", y, "=", x*y, "\n")
    }

    cat("\n")
  }
}

i <- c(2:9) # 단수 지정
j <- c(1:9) # 단수와 곱해지는 수 지정


gugudan(i, j)

# 결측치 데이터 처리 함수
na <- function(x){
  # 1차 : NA 제거
  print(x)
  print(mean(x, na.rm = T))

  # 2차 : NA를 0으로 대체
  data <- ifelse(!is.na(x), x, 0) # NA이면 0으로 대체. , boolean값이 true이면 x, 아니면 0
  print(data)
  print(mean(data))

  # 3차 : NA를 평균으로 대체
  data2 <- ifelse(!is.na(x), x, round(mean(x, na.rm = T), 2)) # 평균으로 대체
  print(data2)
  print(mean(data2))
}

na(data) # 함수 호출
# 결측치를 무조건 제거하면 정확한 통계량을 얻을 수 없으며,
# 데이터가 손실될 수 있다.


## 2. 주요 내장 함수 # Day24; 20221007

# 행 단위, 컬럼 단위 합계와 평균 구하기.

# 단계1 : 데이터 셋 불러오기
library(RSADBE)
data(Bug_Metrics_Software)
class(Bug_Metrics_Software)

Bug_Metrics_Software[,,1]
Bug_Metrics_Software[,,2]

# 단계2 : 소프트웨어 발표 전 행 단위 합계와 평균 구하기.
rowSums(Bug_Metrics_Software[,,1])
rowMeans(Bug_Metrics_Software[,,1])

# 단계3 : 소프트웨어 발표 전의 열 단위 합계와 평균 구하기.
colSums(Bug_Metrics_Software[,,1])
colMeans(Bug_Metrics_Software[,,1])

# 기술 통계량 관련 내장 함수 사용 예
seq(-2, 2, by = .2) # 0.2씩 증가 # seq(시작값, 끝값, step 0.2 단위로 증가)
vec <- 1:10 # c()가 생략됐다.
vec

min(vec)
max(vec)
range(vec) # 최소값 ~ 최대값의 범위
mean(vec) # 평균
median(vec) # 중간값
sum(vec)
var(vec) # 분산
sd(vec) # 표준편차 구하기.
table(vec)    # 빈도수

# 난수와 확률 분포 관계
# 단계1 : 정규분포(연속형)의 난수 생성
n <- 1000
r <- rnorm(n, mean = 0, sd = 1) # 평균을 0, 표준편차를 1로 해서 난수를 뽑아내는 것
hist(r) # 대칭성

# 단계2 : 균등분포(연속형)의 난수 생성
n <- 1000
r2 <- runif(n, min = 0, max = 1) # 0 < r2 < 1 # R uniform 균일한 분포
hist(r2)


# 단계3 : 이항분포(이산형) 난수 생성
n <- 20
rbinom(n, 1, prob = 1/2) # R binary, prob 1/2의 확률이다. 0이 10개, 1이 10개
rbinom(n, 2, 0.5)
rbinom(n, 10, 0.5)
n <- 1000
rbinom(n, 5, prob = 1/6)

# 단계4 : 종자값(seed)으로 동일한 난수 생성. # 난수 - 1/1000초를 기준으로 난수, 그래서 서로 다른 값을 생성하는 것처럼 보이는 것이다.
rnorm(5, mean=0, sd=1) # 5개의 난수

set.seed(123)
rnorm(5, mean=0, sd=1) # 계속 같은 값으로 난수 발생

set.seed(345)
rnorm(5, mean=0, sd=1)

# 수학 관련 내장함수 사용 예
vec <- 1:10
prod(vec) # 벡터 원소들의 곱
factorial(5)
abs(-5) # 절대값 계산
sqrt(16) # 루트값

log(10) # 10의 자연로그(밑수가 e)
log10(10) # 10의 일반로그(밑수가 10)

# 집합연산 관련 내장 함수 사용 예
x <- c(1, 3, 5, 7, 9)
y <- c(3, 7, 8)

union(x, y) # 합집합
setequal(x, y) # 동일성 체크
intersect (x, y) # 집합x와y의교집합
setdiff(x, y)# x의모든원소중y에는없는x와y의차집합

