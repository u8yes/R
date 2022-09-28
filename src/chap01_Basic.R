############################# Day17; 20220927 #############################
# chap01_Basic : 주석문 기호 # 

##############################
#  Chapter01. R 설치와 개요
##############################

# 주요 단축키
# - script 실행 : ctrl+Enter, ctrl+R, Ctrl + alt + s(전체파일저장)
# - script 저장 : ctrl+s

# Library 등록.
# - C:/Program Files/R/R-4.1.2/etc/Rprofile.site 파일에 .libPaths("C:/myRLib/Library") 추가 혹은
# - 사용자 변수 새로 만들기 : 변수 이름 -> R_LIBS, 변수 값 : C:\Users\user\Documents\R\win-library\4.1 으로 셋팅.

print("Hello, R!!!") # ctrl+Enter

## 패키지와 Session 보기

# R Package 보기
dim(available.packages()) # dimension 차원, 18688 패키지 수가 있고 17개의 정보를 가지고 있다.

available.packages()
 
# 패키지 사용법
install.packages("stringr") # 패키지 설치
library("stringr") # 메모리에 로딩 : "" 생략 가능
# install.packages("ichimoku")
search() # 패키지 메모리 로딩 확인

# 패키지 제거
remove.packages("stringr")
search()

# R session 보기
sessionInfo()

data()

# 기본 데이터 셋으로 히스토그램 그리기
# 단계1 : 빈도수(frequency)를 기준으로 히스토그램 그리기

hist(Nile) # hist - 히스토그램의 약자

############################# Day18; 20220928 #############################

# 단계2 : 밀도(density)를 기준으로 히스토그램 그리기
hist(Nile, freq = F) # Boolean형태로 F(alse), 곧 대문자로만 작성해야됨, 소문자로 쓰면 에러가 나게 됨. T는 당연히 True이다. 자바와 이런 차이가 있다. 심지어 순서를 바꿔도 상관없다.
# 단계3 : 단계2의 결과에 분포곡선(line)을 추가

?hist # 기능 설명

lines(density(Nile))

# 히스토그램을 파일에 저장하기
par(mfrow=c(4, 4)) # c - combine # plots창 영역에 1개 그래프만 표시하겠다
pdf("D:/heaven_dev/workspaces/R/output/batch.pdf")
hist(rnorm(20)) # random하게 정규분포를 뽑아줘.
dev.off()


## 4. 변수와 자료형
# 변수 사용 예
age <- 25 # '<-' 안 넣고 '=' 넣어도 상관없다. 단지 가독성때문에 '<-'사용
age
age <- 35
age

# 변수.멤버  형태로 변수 선언 예


var1 <- 50
var2 <- 100

goods.model <- "lg-320" # 상품 모델명명
goods.name <- "냉장고"
goods.price <- 850000
goods.desc <- "등급 최고 품질질"
rm(goods.model,goods.name,goods.price,goods.desc)

# 스칼라 변수 사용 예(스칼라 - 변수에 하나의 값만 담긴다.)
name <- "홍길동"
name

# 자료형
int <- 20    # 숫자형(정수) # 저장할 때 20.0으로 저장됨.
double <- 3.14 # 숫자형(실수)
string <- "홍길동"  # 문자형
boolean <- TRUE  # 진리값 : TRUE(T) / FALSE(F) [무조건 대문자]
boolean

boolean <- 3.14
boolean

# 자료형 확인
is.numeric(int) # TRUE #정수, 실수냐? 묻기
is.integer(int) # FALSE : 정수 값도 부동소숫점으로 관리.
is.double(int) # TRUE

as.integer(int) # 형변환을 시켜줌, 실수 -> 정수형
castInt <- as.integer(int)
is.integer(castInt) # TRUE

is.numeric(double) # TRUE 실수형 맞다
is.double(double) # TRUE 실수형 맞다 # 다른 언어 사용자를 위해 있음

is.character(double) # FALSE
is.character(string) # TRUE # 문자열이냐? 맞다! TRUE
is.character("double") # TRUE # ""이기 때문에

# 문자 원소를 숫자 원소로 형변환
x <- c(1, 2, 3) # combine 결합하다
x

# 숫자 원소를 문자 원소로 형변환
y <- c(1, 2, "3") # 서로 다른형을 저장할 수 없다. 숫자 + 문자의 경우에만 강제 형변환 해줌.
y

result <- x * 3
result


result <- y * 5 

result <- as.integer(y) * 5
result


# 복소수형 자료 생성과 형변환 # 실수와 허수 = 복소수
z <- 5.3 - 3i
Re(z) # 실수
Im(z) # 허수
is.complex(z) # TRUE
as.complex(5.3) # 5.3+0i # 강제로 복소수로 형변환을 해줌.


# 스칼라 변수의 자료형
mode(int) # "numeric"
mode(string) # "character"
mode(boolean) # "logical"

# 문자 벡터와 그래프 생성
gender <- c('man', 'woman', 'woman', 'man', 'man')
gender

mode(gender)
class(gender)

plot(gender)

# 요인형 변환
# as.factor() 함수 이용 범주(요인)형 변환
Ngender <- as.factor(gender)
Ngender
table(Ngender)

# Factor형 변수로 차트 그리기
plot(Ngender)
mode(Ngender)
class(Ngender)
is.factor(Ngender)

# Factor Nominal 변수
Ngender

# factor() 함수 이용 Factor형 변환



# 순서 없는 요인과 순서 있는 요인형 변수로 차트 그리기



# 도움말 보기
i <- sum(1, 2, 3)
i

help(sum)
?sum

# 함수 파라메터 보기
args(sum)

# 함수 사용 예제 보기
example(sum)

# 작업 공간 지정





