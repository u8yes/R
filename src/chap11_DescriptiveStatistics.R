# chap11_DescriptiveStatistics

########################################################
##  Chapter11. 기술 통계(Descriptive Statistics) 분석
########################################################

## 1. 기술 통계 개요.

# 대표값:평균(Mean), 합계(Sum), 중위수(Median), 최빈수(mode), 사분위수(quartile) 등.

# 산포도:분산(Variance), 표준편차(Standard Deviation), 최소값(Minimum), 최대값(Maximum), 범위(Range) 등

# 비대칭도:왜도(Skewness), 첨도(Kurtosis)


## 1.1 평균과 분산 그리고 표준편차
score1 <- c(85, 90, 93, 86, 82)
score2 <- c(100, 100, 50, 0, 0)#c(85, 90, 93, 46, 42)
score3 <- c(60, 60, 50, 40, 40)#c(100, 100, 54, 50, 52)

score10 <- c(100, 50, 30, 20, 20, 20, 10, NA)
mean(score10) # NA
mean(score10, na.rm = T) # 35.71429

# 평균
mean(score1)  # [1] 87.2 : 평균값
mean(score2)  # [1] 50 : 평균값
mean(score3)  # [1] 50 : 평균값


# 중앙값(median:중위수) - 모든 데이터를 크기 순서대로 정렬시킨 후 가운데 있는 값을 의미.
# ex) 100, 100, 54, 50, 52 : 중앙값 -> 54
median(score3) # 54

# ex) 6, 6, 7, 8, 9, 10
num <- c(6, 6, 7, 8, 9, 10)
median(num) # 7.5(=(7+8)/2)


# 편차(Deviation) : 평균값을 기준으로 각 값의 차이. 즉, 평균과 해당값의 차이.

# 분산(Variance) : 편차 값을 제곱해서 마이너스 값을 플러스 값으로 바꾼 후 평균을 구하는 방법.
# ex) ((100-71.2)^2+(100-71.2)^2+(54-71.2)^2+(50-71.2)^2+(52-71.2)^2) / 5 = 554.56
score <- c(100, 100, 54, 50, 52)
mean(score) # 71.2
var(score) # 693.2 # 5개가 아닌 5-1을 해서 나누어줌.
sd(score) # 표준편차
# 표준편차(Standard Deviation:SD) : 분산 값에 루트를 적용해서 제곱을 제거한 값. ex) 23.55(sqart(554.56))


# 자유도(degree of freedom) : 표본의 분산과 표준편차를 계산할 때 나누는 분모의 수를 (모집단-1)개로 계산하여 주어진 데이터에서 표본을 자유롭게 뽑을수 있는 경우의수를 의미. 표본을 추출해서 표본의 분산과 표준 편차를 계산할 때는 항상 자유도를 분모로 사용함.

median(score1) # [1] 86
# 분산(Variance) : score1 <- c(85, 90, 93, 86, 82)
# ((85-86)^2+(90-86)^2+(93-86)^2+(86-86)^2+(82-86)^2)/5 = 16.4
var(score1)    # [1] 18.7
sd(score1)     # [1] 4.32435


# 평균의 종류
# 1) 산술평균 : 모든 값을 더한 후 값의 개수만큼 나눈 후 나오는 값을 의미.

# 2) 상승평균/기하평균 : %로 평균 비율을 구할 때 방법.
#   ex) 회사의 연매출 10억 인 회사가 작년에 10% 성장 후 올해 2% 감소했다면 2년 평균 성장률은 어떻게 될까요?
#   ans) <루트>squart(1.1*0.98) = 1.04 : 4% 성장.

# 3) 제곱평균 : 각 값의 제곱의 평균을 구한 후 루트를 적용해서 구하는 평균.

# 4) 조화평균 : 주로 평균 속도를 구할 때 사용하는 방법.
#   ex) 서울에서 강원도로 휴가를 가는데 갈 때는 안 막혀서 시속 100km로 갔는데, 올 때는 너무 막혀서 시속 60km였다면 왕복 평균 속력은 얼마일까요?
#   ans) 조화 평균의 식 : 2xy / (x+y) = 2(100*60) / (100+60)



# 표준화와 표준값
# 1) 표준화 : 모든 값들의 표준값을 정해서 그 값을 기준으로 차이를 구해서 비교하는 방법.
# 2) 표준값 = (각데이터 - 평균) / 표준편차
# 3) 편차값 = 표준값 * 10 + 50


# 2. 척도별 기술 통계량 구하기

# 실습 데이터 셋 가져오기
data <- read.csv("D:/heaven_dev/workspaces/R/data/descriptive.csv", header = T)
View(data)

# 데이터 특성 보기
dim(data) # 300 8 - 차원보기 # 행렬의 갯수값을 반환해준다.
mode(data) # list
class(data) # data.frame
length(data) # 8
length(data$survey) # 300
str(data) # 'data.frame':	300 obs. of  8 variables:
str(data$survey) # 특정컬럼만 보고 싶을 때

# 데이터 특성(최소, 최대, 중위수, 평균, 분위수, 노이즈-NA) 제공
summary(data)

# 2.1 명목척도 기술 통계량 # 연산의 의미가 없다(예: 남녀), 식별만 하면 됨
length(data$gender) # 300
summary(data$gender)
table(data$gender) # 각 성별 빈도 수 - outlier(이상치)-> 0, 5
# 이상치 제거 # ifelse도 이상치 제거에 쓰임
data <- subset(data, data$gender==1 | data$gender==2) # 성별 outlier 제거.
x <- table(data$gender) # 성별에 대한 빈도 수 저장.
x

x11()
barplot(x) # 범주형(명목/서열 척도) 시각화 -> 막대차트

# 구성비율 계산
prop.table(x) # 비율계산: 0 < x < 1 사이의 값 # prop.table는 그냥 이름이다
#        1         2
#0.5824916 0.4175084

y <- prop.table(x)
round(y*100, 2) # 백분율 적용(소수점 2자리)
#    1     2
#58.25 41.75

# 2.2 서열척도 기술 통계량
length(data$level) # 297 : 학력수준 - 서열.
summary(data$level) # 명목척도와 함께 의미없음.
table(data$level) # 빈도분석 - 의미있음.
#   1   2   3
# 115  99  70

# 학력 수준(level) 변수의 빈도 수 시각화
x1 <- table(data$level) # 각 학력수준에 빈도수 저장.
x11()
barplot(x1)  # 명목/서열 척도 -> 막대차트

# 구성비율 계산
y <- prop.table(x1)
round(y*100,2) # 백분율 적용
#    1     2     3
#40.49 34.86 24.65

# 2.3 등간척도 기술 통계량
# 만족도(survey) 변수 대상 요약 통계량 구하기
survey <- data$survey
survey

summary(survey) # 만족도(5점척도)인 경우 의미 있음 -> 2.605(평균)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
#1.000   2.000   3.000   2.605   3.000   5.000     112
x1 <- table(survey) # 빈도 수
x1

hist(survey) # 등간척도 시각화
pie(x1) # 이산형, 연속형 아무때나 사용가능하다.

# 2.4 비율척도 기술 통계량 # 연산의 의미가 있다. # 연속형

# 생활비(cost) 변수 대상 요약 통계량 구하기
length(data$cost) # 297
summary(data$cost) # 요약통계량-의미있음(mean)-8.784, 중위수-3.000 # 이상치가 너무 큼

plot(data$cost)

# 데이터 정제(이상치 제거)
data <- subset(data, data$cost >= 2 & data$cost <= 10) # 총점기준 # 실무자들을 통해 확인하는 것이 좋다 # 분석가들이 실무자 수준으로 공부를 해야한다.
head(data)
data

summary(data$cost)

plot(data$cost) # 연속형 시각화
x <- data$cost
mean(x) # 5.354032

# 평균이 극단치에 영향을 받는 경우 - 중위수(median) 대체
median(x) # 5.4

#  (1) 대표값 구하기

# 생활비(cost) 변수 대상 대표값 구하기
mean(x) # 평균
median(x) # 중위수
sort(x) # 오름차순
sort(x, decreasing=T) # 내림차순

# 생활비(cost) 변수 대상 사분위수 구하기
quantile(x, 1/4) # 4.6
quantile(x, 2/4) # 5.4
quantile(x, 3/4) # 6.2
quantile(x, 4/4) # 7.9

# 생활비(cost) 변수의 최빈수(빈도 수가 가장 많은 변수) 구하기
length(x) # [1] 248
x.t <- table(x)
x.t

max(x.t) # [1] 18

x.m <- rbind(x.t)
x.m
class(x.m) # [1] "matrix"
str(x.m)
which(x.m[1, ] == 18) # 1행 전체를 대상으로 18값 찾기.
# 5번째 값이 18, 19번째 있는 값이 18
# 19 : index

x.df <- as.data.frame(x.m)
class(x.df)
which(x.df[1, ] == 18) # [1] 19(index)
x.df[1, 19] # [1] 18
attributes(x.df) # $names, $class, $row.names
names(x.df[19]) # [1] "5"


# (2) 산포도 구하기

# 생활비(cost) 변수 대상 산포도 구하기
var(x) # 분산, [1] 1.296826
sd(x)  # 표준편차, [1] 1.138783

# 분산 -> 표준편차
sqrt(var(x)) # root 씌우기

# 표준편차 -> 분산
sd(x) ** 2


# (3) 빈도 분석

# 생활비(cost) 변수의 빈도분석과 시각화
table(data$cost)

hist(data$cost) # 히스토그램 시각화
plot(data$cost) # 산점도 시각화

# 연속형 변수 범주화
data$cost2[data$cost >= 2 & data$cost < 4] <- 1
data$cost2[data$cost >= 4 & data$cost < 7] <- 2
data$cost2[data$cost >= 7] <- 3

x <- table(data$cost2)
barplot(x)
pie(x)


# 2.5 비대칭도 구하기
install.packages("moments")
library(moments)
cost <- data$cost
cost

# 왜도 - 평균을 중심으로 기울어진 정도. # 왜도가 음수이면 평균이 양수로
skewness(cost) # [1] -0.297234


# 첨도 - 표준 정규 분포와 비교하여 얼마나 뽀족한가 측정 지표
kurtosis(cost) # [1] 2.674163

# 기본 히스토그램
hist(cost)


# 히스토그램 확률밀도/표준 정규 분포 곡선
hist(cost, freq = F)

# 확률 밀도 분포 곡선
lines(density(cost), col='blue')

# 표준정규분포 곡선
x <- seq(0, 8, 0.1)
x
curve(dnorm(x, mean(cost), sd(cost)), col='red', add = T)


# attach() / detach() 함수로 기술 통계량 구하기
# - 기존 선언 변수와 컬럼의 이름이 중복시 기존 변수가 global 변수로 잡힘.
search()
attach(iris) # search에 포함시키게 됨 # iris.을 붙이지 않아도 됨. # iris가 글로벌 변수로 잡히게 됨
search()
length(Sepal.Width)
summary(Sepal.Width) # 요약 통계량 - 의미있음(mean)
mean(Sepal.Width)
min(Sepal.Width)
max(Sepal.Width)
range(Sepal.Width) # [1] 2.1(min) ~ 7.9(max)
var(Sepal.Width, na.rm = T)

sd <- sd(Sepal.Width, na.rm = T)
sqrt(var(Sepal.Width, na.rm=T))

sort(Sepal.Width) # 오름차순
sort(Sepal.Width, decreasing = T) # 내림차순
detach(iris)

attach(data) # data$cost 접근.
search()
length(cost) # [1] 248
summary(cost) # 요약 통계량 - 의미있음(mean)
mean(cost)
min(cost)
max(cost)
range(cost) # [1] 2.1(min) ~ 7.9(max)
var(cost, na.rm = T)

sd <- sd(cost, na.rm = T)
sqrt(var(cost, na.rm=T))

sort(cost) # 오름차순
sort(cost, decreasing = T) # 내림차순
detach(data)


## 3. 패키지 이용 기술 통계량 구하기

# 3.1 Hmisc 패키지 이용
install.packages("Hmisc")
library(Hmisc)

# 전체 변수 대상 기술통계량 제공 - 빈도와 비율 데이터 일괄 수행
describe(data)

# 개별 변수 기술 통계량
describe(data$gender) # 특정 변수(명목) 기술통계량-범주/빈도수/비율 제공.
describe(data$age) # 특정 변수(비율) 기술통계량 - lowest / highest

summary(data$age)


# 3.2 prettyR 패키지 이용
install.packages("prettyR")
library(prettyR)

# 전체 변수 대상
freq(data) # 각 변수별 : 빈도, 결측치, 백분율, 특징-소수점 제공

# 개별 변수 대상
freq(data$gender) # 빈도, 결측치, 백분율


# 4. 기술 통계량 보고서 작성

# 4.1 기술 통계량 구하기

# 변수 리코딩과 빈도분석

# 1) 거주지역 변수 리코딩과 비율 계산
data$resident2[data$resident==1] <- "특별시"
data$resident2[data$resident>=2 & data$resident<=4] <- "광역시"
data$resident2[data$resident==5] <- "시구군"

freq(data$resident2)
#     특별시 광역시 시구군   NA
#      131  101     44     21         : 빈도수
# %    44.1  34     14.8   7.1    
# %!NA 47.5  36.6   15.9              : 비율


# 2) 성별 변수 리코딩과 비율 계산
data$gender2[data$gender==1] <- "남자"
data$gender2[data$gender==2] <- "여자"

freq(data$gender2)
#      남자 여자   NA
#      173  124     0
# %    58.2 41.8    0 
# %!NA 58.2 41.8 


# 3) 나이 변수 리코딩과 비율 계산
summary(data$age)

data$age2[data$age <= 45] <- "중년층"
data$age2[data$age >= 46 & data$age <= 59] <- "장년층"
data$age2[data$age >= 60] <- "노년층"

freq(data$age2)
#    장년층 노년층 중년층  NA
#     169     61    18      0
#%    68.1   24.6   7.3     0
#%!NA 68.1   24.6   7.3


# 4) 학력 수준 변수 리코딩과 비율계산
data$level2[data$level == 1] <- "고졸"
data$level2[data$level == 2] <- "대졸"
data$level2[data$level == 3] <- "대학원졸"

freq(data$level2)
#     고졸 대졸 대학원졸  NA
#      93   86     57     12
#%     37.5 34.7   23     4.8
#%!NA  39.4 36.4   24.2


# 5) 합격 여부 변수 리코딩과 비율 계산
data$pass2[data$pass == 1] <- "합격"
data$pass2[data$pass == 2] <- "불합격"

freq(data$pass2)
#     합격 불합격 NA
#      139   96   13
#%      56  38.7  5.2
#%!NA  59.1 40.9


# 최종 결론과 관련된 내용은 pdf를 참조.








