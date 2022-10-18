# chap07_EDA&DataPreprocessing 

####################################
# chapter07. EDA & 데이터 전처리
####################################

# - 자료분석에 필요한 데이터를 대상으로 불필요한 데이터를 처리하는 필터링과 전처리 방법에 대해서 알아본다.

# 1. EDA(Exploratory Data Analysis) - 탐색적 자료 분석
#   : 수집한 자료를 다양한 각도에서 관찰하고 이해하는 과정으로 그래프나 통계적 방법을 이용해서 자료를 직관적으로 파악하는 과정.

# 1.1 데이터 셋 보기

# 데이터 가져오기
setwd("D:/heaven_dev/workspaces/R/data")
dataset <- read.csv("dataset.csv", header = T) # 헤더가 있는 경우
View(dataset)

# 1) 데이터 조회
#    - 탐색적 데이터 분석을 위한 데이터 조회

# 전체 데이터 보기
print(dataset) # 콘솔창 출력
View(dataset)  # utils package, 뷰어창 출력


# 데이터의 앞부분과 뒷부분 보기
head(dataset, 10)
tail(dataset) # 마지막 6개 데이터

# 1.2 데이터 셋 구조 보기

# 데이터 셋 구조
names(dataset) # 변수명(컬럼) # feature이름 출력
attributes(dataset) # $names / $class / $row.names
str(dataset) # 데이터 구조보기(자료구조/관측치(행)/컬럼명(열) / 자료형)

# 1.3 데이터 셋 조회
dataset$age  # 데이터 셋 접근 방법.
dataset$resident

length(dataset) # 7 : 컬럼의 갯수
length(dataset$age) # 300 : 행(데이터)의 갯수

# 조회 결과 변수 저장
x <- dataset$gender
y <- dataset$price

# 산점도 형태로 변수 조회
plot(x, y) # 성별과 가격분포-극단치 발견

# 산점도 형태로 변수 조회
plot(dataset$price)

# ["컬럼명"] 형식으로 특정 변수 조회
dataset["gender"] # dataset$gender
dataset["price"]

# [색인(index)] 형식으로 변수 조회
dataset[2] # 두번째 컬럼(gender) - 출력형태:열 중심
dataset[6] # price
dataset[3,] # 3행 전체 # 3  NA  1  2  41  4  4.7  4
dataset[,3] # 3열 전체 # job 

# 두 개 이상의 [색인(index)] 형식으로 변수 조회
dataset[c("job", "price")]
dataset[c(2, 6)] # gender / price

dataset[c(1, 2, 3)] # resident/gender/job
dataset[c(1:3)]
dataset[1:3]

dataset[c(2,4:6,3,1)] # gender age position  price job resident # 순서를 바꿔서 가져올 수도 있다.
dataset[-c(2)] # dataset[c(1, 3:7)] # gender항목만 빠져있음

# dataset의 특정 행/열을 조회하는 경우
dataset[,c(2:4)]
dataset[c(2:4),]
dataset[-c(1:100),]

# 2. 결측치(NA) 처리
# 2.1 결측치 확인

# summary() 함수 이용
summary(dataset$price)
#    Min. 1st Qu. Median   Mean  3rd Qu.    Max.   NA's
#-457.200  4.425   5.400  8.752   6.300  675.000     30

sum(dataset$price) # NA

# 2.2 결측치 제거

# sum() 함수에서 제공되는 속성 이용
sum(dataset$price, na.rm = T) # 2362.9 # na r(e)m(ove)

# 결측데이터 제거 함수 이용
price2 <- na.omit(dataset$price)
sum(price2)
length(price2) # 270

# 2.3 결측치 대체 # 결측치 - 담겨져있지 않은 데이터

# 결측치를 0으로 대체하기
x <- dataset$price # price vector 생성
head(x)
dataset$price2 <- ifelse(!is.na(x), x, 0) # 0으로 대체
View(dataset)
sum(dataset$price2) # 2362.9


# 결측치를 평균으로 대체하기
x <- dataset$price # price vector 생성
head(x)
dataset$price3 <- ifelse(!is.na(x), x, round(mean(x,na.rm=T),2)) # 평균으로 대체 # 소수점 2째자리까지만 return해줌.
View(dataset)
sum(dataset$price2) # 2362.9

# 3. 이상치(극단치) 처리 # 이상치 - 범위를 벗어나는 데이터
# 3.1 범주형 변수 이상치 처리

# 범주형 변수의 이상치 확인
table(dataset$gender)
# 0   1   2   5 : (범주)
# 2 173 124   1 : (빈도수)

pie(table(dataset$gender)) # 파이차트

# subset() 함수를 이용한 데이터 정제하기
dataset <- subset(dataset, gender==1 | gender==2) # 바로 이상치 데이터를 제외할 수가 있다
dataset
length(dataset$gender) # 297
table(dataset$gender)
pie(table(dataset$gender))
#1   2 
#173 124

# 3.2 연속형 변수의 이상치 처리.
dataset <- read.csv('dataset.csv', header = T)
View(dataset)
dataset$price # 세부데이터 보기
plot(dataset$price)
summary(dataset$price)

# price 변수의 데이터 정제와 시각화
dataset2 <- subset(dataset, price >= 2 & price <= 8)
length(dataset2$price) # 251
stem(dataset2$price) # 줄기와 잎 도표 보기

# age 변수에서 NA 발견
summary(dataset2$age) # NA's -> 16
boxplot(dataset2$age)

# 4. 코딩 변경

# 4.1 가독성을 위한 코딩 변경
table(dataset2$resident)
View(dataset2)

dataset2$resident2[dataset2$resident == 1] <- '1. 서울특별시'
dataset2$resident2[dataset2$resident == 2] <- '2. 인천광역시'
dataset2$resident2[dataset2$resident == 3] <- '3. 대전광역시'
dataset2$resident2[dataset2$resident == 4] <- '4. 대구광역시'
dataset2$resident2[dataset2$resident == 5] <- '5. 시구군'
dataset2[c("resident","resident2")]
View(dataset2)

# job 컬럼을 대상으로 코딩 변경하기
dataset2$job2[dataset2$job == 1] <- '공무원'
dataset2$job2[dataset2$job == 2] <- '회사원'
dataset2$job2[dataset2$job == 3] <- '개인사업'
dataset2[c("job","job2")]
View(dataset2)

# 4.2 척도 변경을 위한 코딩 변경

# 나이(age) 변수를 청년층, 중년층, 장년층으로 코딩 변경하기.
dataset2$age2[dataset2$age <= 30] <- "청년층"
dataset2$age2[dataset2$age > 30 & dataset2$age <= 55] <- "중년층"
dataset2$age2[dataset2$age > 55] <- "장년층"

# 4.3 역코딩을 위한 코딩 변경

# 만족도(survey)를 긍정순서로 역코딩
survey <- dataset2$survey
csurvey <- 6-survey # 역코딩 # 만족과 불만족 점수를 뒤바꿔서 만족을 강조하고자 6을 빼줌
csurvey

dataset2$survey2 <- csurvey
mean(dataset2$survey2, na.rm = T) # 3.358566 # 5점대가 만점

# 5. 탐색적 분석을 위한 시각화 # Day30; 20221018

# 5.1 범주형 vs 범주형 # 범주형은 discrete를 말함
getwd()
setwd("D:/heaven_dev/workspaces/R/data")
new_data <- read.csv("new_data.csv", header = T)
View(new_data)

# 범주형(resident) vs 범주형(gender) 데이터 분포 시각화 #

## 성별에 따른 거주지역 분포 현황
resident_gender <- table(new_data$resident2, new_data$gender2) # table은 빈도수를 나타내주는 함수, 행:resident2, 열:gender2
resident_gender

barplot(resident_gender, beside = T, horiz = F,
        col=rainbow(2),
        legend=row.names(resident_gender),
        main="성별에 따른 거주지역 분포 현황")

## 거주지역에 따른 성별 분포 현황
gender_resident <- table(new_data$gender2, new_data$resident2) # table(행,열)
gender_resident

barplot(gender_resident, beside = T, horiz = F,
        col=rainbow(2),
        legend=row.names(gender_resident),
        main="거주지역에 따른 성별 분포 현황")

barplot(gender_resident, beside = T, horiz = T,
        col=rainbow(2),
        legend=row.names(gender_resident),
        main="거주지역에 따른 성별 분포 현황")

barplot(gender_resident, beside = F, horiz = T,
        col=rainbow(2),
        legend=row.names(gender_resident),
        main="거주지역에 따른 성별 분포 현황")


barplot(gender_resident, beside = F, horiz = F,
        col=rainbow(2),
        legend=row.names(gender_resident),
        main="거주지역에 따른 성별 분포 현황")

# 5.2 연속형 vs 범주형

# 나이(age/연속형) vs 직업(job2/범주형) 데이터 분포 시각화
install.packages("lattice") # chap08
library(lattice)

# 직업유형에 따른 나이 분포 현황
?densityplot
densityplot( ~ age, data=new_data, groups = job2,
             plot.points=T, auto.key = T)
# plot.points=F:밀도점 표시 여부(x), auto.key=T:범례

# 5.3 연속형 vs 범주형 vs 범주형

# price(연속형) vs gender(범주형) vs position(범주형) 데이터 분포 시각화

# (1) 성별에 따른 직급별 구매비용 분포 현황 분석
densityplot( ~ price|factor(gender2), data=new_data,
             groups = position2,
             plot.points=T, auto.key = T)

# (2) 직급에 따른 성별 구매비용 분포 현황 분석
densityplot( ~ price|factor(position2), data=new_data,
             groups = gender2,
             plot.points=T, auto.key = T)

# 5.4 연속형 vs 연속형 vs 범주형

# price(연속형) vs age(연속형) vs gender2(범주형)
xyplot(price ~ age|factor(gender2), data=new_data)

# 6. 파생변수 생성

# 6.1 더미(dummy) 형식으로 파생변수 생성

# 데이터 파일 가져오기
getwd()
setwd("D:/heaven_dev/workspaces/R/data")

user_data <- read.csv('user_data.csv', header = T)
View(user_data)
table(user_data$house_type)
#  1   2   3   4
# 32  47  21 300

# 더미변수 생성
# 주택유형(단독주택, 빌라) : 0, 아파트 유형(아파트, 오피스텔) : 1
house_type2 <- ifelse(user_data$house_type==1 | user_data$house_type==2, 0, 1)
house_type2[1:10]
head(house_type2, 10)


# 파생변수 추가
user_data$house_type2 <- house_type2


# 6.2 1:N -> 1:1 관계로 파생변수 생성

# 고객 식별번호(user_id) vs 상품유형(product_type)간의 1:1 파생변수 생성

# 데이터 파일 가져오기
pay_data <- read.csv('pay_data.csv', header = T)
View(pay_data)
table(pay_data$product_type)
#  1   2   3   4   5
# 55  82  89 104  70

# 고객별 상품유형에 따른 구매금액 합계 파생변수 생성
library(reshape2) # 구조 변경을 위한 패키지 로딩.
product_price <- dcast(pay_data,user_id ~ product_type, sum, na.rm=T)
View(product_price)

# 컬럼명 수정
names(product_price) <- c('user_id', '식료품(1)', '생필품(2)', '의류(3)', '잡화(4)', '기타(5)')
head(product_price) # 컬럼명 수정 확인.

# 고객별 지불유형에 따른 구매상품 개수 파생변수 생성
pay_price <- dcast(pay_data,user_id ~ pay_method, length)
View(pay_price)

# 6.3 파생변수 합치기

# 고객 정보 테이블에서 파생변수 추가
install.packages("plyr")
library(plyr)
user_pay_data <- join(user_data, product_price, by='user_id')
View(user_pay_data)

# 병합(위에 결과)된 데이터를 대상으로 고객별 지불 유형에 다른 구매상품 개수 병합하기
user_pay_data <- join(user_pay_data, pay_price, by='user_id')
View(user_pay_data)


# 7. 표본 샘플링

# 7.1 정제(cleaning) 데이터 저장하기
View(user_pay_data)

write.csv(user_pay_data, "cleanData.csv", quote = F, row.names = F)

data <- read.csv("cleanData.csv", header = T)
View(data)

# 7.2 표본 샘플링

# 표본 추출하기
nrow(data) # 400, data의 행수 구하기(Number of Rows)
choice1 <- sample(nrow(data), 30) # 30개 무작위 추출
choice1
data[choice1, 1]

# 50~data 길이 사이에서 30개 무작위 추출
choice2 <- sample(50:nrow(data), 30)
choice2

# 다양한 범위를 지정해서 무작위 샘플링
choice3 <- sample(c(10:50, 80:150, 160:190), 30)
choice3

# iris 데이터 셋을 대상으로 7:3 비율로 데이터 셋 생성.
data("iris")
dim(iris) # 150   5

idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
training <- iris[idx,] # 학습데이터 셋
testing <- iris[-idx,] # 검정데이터 셋

dim(training) # 105  5
dim(testing)  #  45  5


# 7.3 교차 검정 샘플링
#   - 평가의 신뢰도를 높이기 위해 동일한 데이터 셋을 N등분하여 N-1개의 학습데이터 모델을 생성하고, 나머지 1개를 검정데이터로 이용하여 모델을 평가하는 방식.

# 데이터 셋을 대상으로 K겹(fold) 교차 검정 데이터 셋 생성.
name <- c('a','b','c','d','e','f')
score <- c(90, 85, 70, 85, 60, 74)
df <- data.frame(Name=name, Score=score)
df

# 교차 검정을 위한 패키지 설치
install.packages("cvTools")
library(cvTools)

cross <- cvFolds(n=6, K=3, R=1, type = "random")
cross

str(cross)

# which를 이용하여 subsets 데이터 참조
cross$subsets[cross$which == 1, 1] # k=1인 경우
cross$subsets[cross$which == 2, 1] # k=2인 경우
cross$subsets[cross$which == 3, 1] # k=3인 경우

r <- 1 # 1회전
K <- 1:3 # 3겹(fold)
for(k in K){ # 3회전
    datas_idx <- cross$subsets[cross$which==k,r]
    cat('k=', k, '검정데이터\n')
    print(df[datas_idx,])

    cat('훈련데이터\n')
    print(df[-datas_idx,])
}




