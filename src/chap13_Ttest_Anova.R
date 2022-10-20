# chapter13_Ttest_Anova

##################################
##  Chapter13. 집단 간 차이 분석 
##################################

## 0. 추론 통계 분석 분류
# - 추정(estimation):표본을 통해서 모집단을 확률적으로 추측.
# - (가설) 검정(hypothesis testing):유의 수준과 표본의 검정통계량을 비교하여 통계적 가설의 진위를 입증.

# 용어 정의.
# - 검정통계량:표본에 의해서 계산된 통계량(표본평균, 표본표준편차)
# - 모수 : 모집단에 의해서 나온 통계량(모평균, 모표준편차)


## 1. 추정

# 1) 점 추정:제시된 한 개의 값과 검정통계량을 직접 비교하여 가설 기각 유무를 결정.
#      ex) 우리 나라 중학교 2학년 남학생 평균키는 165.2cm로 추정.

# 2) 구간 추정:신뢰구간과 검정통계량을 비교하여 가설 기각유무 결정
#   - 신뢰구간:오차범위에 의해서 결정된 하한값과 상한값의 범위.
#      ex) 우리 나라 중학교 2학년 남학생 평균키는 164.5 ~ 165.5cm로 추정.

# 예제) 우리나라 중학교 2학년 남학생 평균 신장 표본 조사
#  - 전체 표본 크기(N) : 10,000명
#  - 표본평균(X)       : 165.1 cm
#  - 표본 표준편차(S)  : 2 cm

# 모평균 신뢰수준 95%의 신뢰구간(하한값과 상한값) 구하기
N <- 10000  # 표본크기
X <- 165.1  # 표본평균
S <- 2      # 표본 표준편차

low <- X - 1.96 * S / sqrt(N) # 신뢰구간 하한값
high <- X + 1.96 * S / sqrt(N) # 신뢰구간 상한값

low; high  # 165.0608 ~ 165.1392

# 해석 : 신뢰수준 95%는 신뢰구간이 모수를 포함할 확률을 의미하고, 신뢰구간은 오차범위에 의해서 결정된 하한값~상한값을 의미.


# 신뢰구간으로 표본오차 구하기
low - X  # -0.0392 = 신뢰구간 하한값 - 표본 평균
high - X  # 0.0392 = 신뢰구간 상한값 - 표본 평균

(low - X) * 100 # -3.92
(high - X) * 100 # 3.92

# 최종 해석 : 우리나라 중학교 2학년 남학생 평균 신장이 95% 신뢰 수준에서 표본오차 -3.92~3.92 범위에서 165.1cm로 조사가 되었다면, 실제 평균키는 165.0608cm ~ 165.1392cm 사이에 나타날 수 있다는 의미.



## 2. 단일집단 검정 - 한 개의 집단과 기존 집단과의 비율/평균 차이 검정.

# 2.1 단일집단 비율검정
#  - 단일 집단의 비율이 어떤 특정한 값과 같은지를 검정하는 방법.
#  - 기술통계량으로 빈도 수에 대한 비율에 의미.
#  - 단일 집단의 비율이 어떤 특정한 값과 같은지를 검정하는 방법(검정 방법 중에서 가장 간단).

# 단일표본 빈도수와 비율 계산

# 가설 설정
# -연구가설(H1):기존 2020년도 고객불만율과 2021년도 CS교육 후 불만율에 차이가 있다.
# -귀무가설(H0):기존 2020년도 고객불만율과 2021년도 CS교육 후 불만율에 차이가 없다.

# 단계1. 실습데이터 가져오기
data <- read.csv("D:/heaven_dev/workspaces/R/data/one_sample.csv", header = T)
head(data)
View(data)


# 단계2. 빈도수와 비율 계산
x <- data$survey
x

summary(x) # 결측치 확인
length(x) # [1] 150
table(x) # 빈도수(0:불만족(14), 1:만족(136))


# 단계3. 패키지 이용 빈도수와 비율계산
install.packages("prettyR")
library(prettyR) # freq() 함수 사용
freq(x)
#Frequencies for x
#        1    0   NA
#      136   14    0
#%    90.7  9.3    0
#%!NA 90.7  9.3

# 이항분포 (불만족율 기준) 비율검정(양측검정) # discrete
binom.test(14, 150, p = 0.2) # p-value = 0.0006735 # binominal(이항분포) # 20%불만율이 맞는지 보고 싶은 것
binom.test(14, 150, p = 0.2, alternative = "two.sided", conf.level = 0.95)

# 방향성을 갖는 단측 가설 검정
binom.test(14, 150, p = 0.2, alternative = "greater", conf.level = 0.95) # p-value = 0.9999
binom.test(14, 150, p = 0.2, alternative = "less", conf.level = 0.95) # p-value = 0.0003179

    # 2.2 단일집단 평균검정(단일표본 T검정)
#  : 단일집단의 평균이 어떤 특정한 집단의 평균과 차이가 있는지를 검정하는 방법.
#  : 기술통계량으로 표본평균에 의미.

# 단일표본 평균 계산하기

# 가설설정
# -연구가설(H1):국내에서 생산된 노트북과 A회사에서 생산된 노트북의 평균 사용 시간에 차이가 있다.
# -귀무가설(H0):국내에서 생산된 노트북과 A회사에서 생산된 노트북의 평균 사용 시간에 차이가 없다.


# 단계1. 실습 파일 가져오기
data <- read.csv("C:/workspaces/Rwork/src/data/one_sample.csv", header = T)
head(data)
str(data)

x <- data$time
head(x)


# 단계2. 데이터 분포/결측치 제거
summary(x) # NA's -> 41
mean(x)    # [1] NA


# 단계3. 데이터 정제
mean(x, na.rm=T) # NA 제외 평균(방법1) - [1] 5.556881
x1 <- na.omit(x) # NA 제외(방법2)
x1

mean(x1)


# 단계4.정규분포 검정
# 귀무가설(H0) : x의 데이터 분포는 정규분포이다.

shapiro.test(x1)
# 정규분포 검정 함수(p-value = 0.7242), 표본이 정규 분포로부터 추출된 것인지 테스트하기 위한 함수. 이때 귀무가설은 주어진 데이터가 정규 분포로부터의 표본이라는 것이다.
# p-value > α(알파) : 정규분포로 본다.


# 단계5. 정규분포 시각화
x11()
hist(x1)

# stats 패키지에서 정규성 검정을 위해서 제공되는 시각화 함수.
qqnorm(x1)
qqline(x1, lty=1, col='blue')


# 단계6. 평균차이 검정
# T-test(T-검정) : 모집단에서 추출한 표본 데이터의 분포형태가 정규분포일 때 수행.
# 1. 양측검정: x1 객체와 기존 모집단의 평균 5.2시간 비교
t.test(x1, mu=5.2) # p-value = 0.0001417
t.test(x1, mu=5.2, alternative = "two.side", conf.level = 0.95)

# 2. 방향성을 갖는 단측가설 검정
t.test(x1, mu=5.2, alternative = "greater", conf.level = 0.95)
# p-value = 7.083e-05(7.083/100000)
t.test(x1, mu=5.2, alternative = "less", conf.level = 0.95)
# p-value = 0.9999


# 3. 두 집단 검정

# 3.1 두 집단 비율 검정

# (1) 집단별 subset 작성과 교차분석
# 두 집단 subset 작성과 교차분석 수행

# 가설 설정
# -연구가설(H1):두가지 교육방법에 따라 교육생의 만족율에 차이가 있다.
# -귀무가설(H0):두가지 교육방법에 따라 교육생의 만족율에 차이가 없다.

# 단계1. 실습데이터 가져오기
data <- read.csv("C:/workspaces/Rwork/src/data/two_sample.csv", header = T)
head(data)
str(data)
View(data)

# 단계2. 두 집단 subset 작성 및 데이터 전처리
x <- data$method # 교육방법(1:PT,2:Coding)
y <- data$survey # 만족도(1:만족, 0:불만족)


# 단계3. 집단별 빈도분석
table(x)
table(y)

# 단계4. 두 변수에 대한 교차분석
table(x, y, useNA = "ifany") # 결측치까지 출력
#   y
#x   0   1
#1  40 110
#2  15 135


# (2) 두 집단 비율 차이 검정

# 단계1. 양측 검정
prop.test(c(110,135), c(150,150)) # PT/Coding 교육 방법에 대한 비율 차이 검정.
prop.test(c(110,135), c(150,150), alternative = "two.sided", conf.level = 0.95) # p-value = 0.0003422 => 귀무가설 기각.


# 단계2. 방향성이 있는 단측가설 검정
prop.test(c(110,135), c(150,150), alternative = "greater", conf.level = 0.95)
# p-value = 0.9998 > 0.05(PT > Coding)
prop.test(c(110,135), c(150,150), alternative = "less", conf.level = 0.95) # p-value = 0.0001711(PT < Coding) : 채택


# 3.2 두 집단 평균 검정(독립표본 T검정)

# (1) 독립표본 평균 계산

# 연구가설(H1):교육방법에 따른 두 집단 간 실기시험의 평균에 차이가 있다.
# 귀무가설(H0):교육방법에 따른 두 집단 간 실기시험의 평균에 차이가 없다.

# 단계1. 실습파일 가져오기
data <- read.csv("C:/workspaces/Rwork/src/data/two_sample.csv", header = T)
View(data)
str(data)
head(data)
summary(data$score) # score - NA's :73개


# 단계2. 두 집단 subset 작성 및 데이터 전처리
result <- subset(data, !is.na(score), c(method, score))


# 단계3. 정제된 데이터를 대상으로 subset 생성
result
View(result)


# 단계4. 교육 방법별로 분리
a <- subset(result, method == 1)
b <- subset(result, method == 2)
a;b

a1 <- a$score # PT 교육 받은 학생 점수
b1 <- b$score # coding 교육 받은 학생 점수

# 단계5. 기술통계량
length(a1) # [1] 109
length(b1) # [1] 118

mean(a1); mean(b1)


# (2) 동질성 검정
var.test(a1, b1) # p-value = 0.3002 > α(유의수준) : t-검정


# (3) 두 집단 평균 차이 검정

# 단계1. 양측검정
t.test(a1, b1)
t.test(a1, b1, alternative = "two.sided", conf.level = 0.95)
# p-value = 0.0411 < 0.05 - 교육방법에 따른 두 집단간 실기시험의 평균에 차이가 있다.

# 단계2. 방향성을 갖는 단측가설 검정
t.test(a1, b1, alternative = "greater", conf.level = 0.95)
# p-value = 0.9794 : a1을 기준으로 비교 -> a1이 b1보다 크지 않다.

t.test(a1, b1, alternative = "less", conf.level = 0.95)
# p-value = 0.02055 : a1을 기준으로 비교 -> a1이 b1보다 작다.


# 3.3 대응 두 집단 평균검정(대응표본 T검정)
#   - 동일한 표본을 대상으로 측정된 두 변수의 평균 차이를 검정하는 분석방법.
#   - 일반적으로 사전검사와 사후검사의 평균 차이를 검증할 때 많이 사용.

# (1) 대응 표본 평균 계산

# 가설 설정
# -연구가설(H1):교수법 프로그램을 적용하기 전 학생들의 학습력과 교수법 프로그램을 적용한 후 학생들의 학습력에 차이가 있다.
# -귀무가설(H0):교수법 프로그램을 적용하기 전 학생들의 학습력과 교수법 프로그램을 적용한 후 학생들의 학습력에 차이가 없다.

# 단계1. 실습 파일 가져오기
data <- read.csv("C:/workspaces/Rwork/src/data/paired_sample.csv", header = T)
head(data) # no before after
View(data)

summary(data)

# 단계2. 대응 두 집단 subset 생성
result <- subset(data, !is.na(after), c(before, after)) # 96
result

x <- result$before
y <- result$after

# 단계3. 기술통계량
length(x) # [1] 96
length(y) # [1] 96

mean(x) # [1] 5.16875
mean(y, na.rm=T) # [1] 6.220833


# (2) 동질성 검정
# 동질성 검정의 귀무가설:대응 두 집단 간 분포의 모양이 동질적이다.
var.test(x, y, paired=T) # p-value = 0.7361


# (3) 대응 두 집단 평균 차이 검정

# 단계1: 양측검정
t.test(x, y, paired = T) # p-value < 2.2e-16 : 귀무가설 기각


# 단계2: 방향성을 갖는 단측가설 검정
t.test(x, y, paired = T, alternative = "less", conf.level = 0.95)
# p-value < 2.2e-16 -> x를 기준으로 비교 : x가 y보다 작다.

t.test(x, y, paired = T, alternative = "greater", conf.level = 0.95)
# p-value = 1 -> x를 기준으로 비교 : x가 y보다 크지 않다.


## 4. 세 집단 검정
# 4.1 세 집단 비율검정
# (1) 세 집단 subset 작성과 기술 통계량 계산

# 단계1. 파일 가져오기.

data <- read.csv("C:/workspaces/Rwork/src/data/three_sample.csv", header = T)
View(data)
head(data)
str(data)
summary(data)

# 단계2. 데이터 정제, 전처리
method <- data$method
survey <- data$survey

method; survey

# 단계3. 기술통계량(빈도분석)
table(method, useNA = "ifany")
#  method
# 1  2  3
#50 50 50 -> 3그룹 모두 관찰치 각 50개

table(method, survey, useNA = "ifany")
#       survey
#method  0  1
#     1 16 34
#     2 13 37
#     3 11 39


#(2) 세 집단 비율 차이 검정
prop.test(c(34,37,39), c(50,50,50))
prop.test(c(34,37,39), c(50,50,50), alternative = "two.sided", conf.level = 0.95) # p-value = 0.5232(유의확률) > 0.05(유의수준) -> 귀무가설 채택.


## 4.2 분산분석(F 검정, ANOVA Analysis)
# - 세 집단 이상의 평균 차이 검정.

# (1) 데이터 전처리
# 단계1. 파일 가져오기
data <- read.csv("C:/workspaces/Rwork/src/data/three_sample.csv", header = T)

# 단계2. 데이터 정제/전처리 - NA 제거
data <- subset(data, !is.na(score), c(method, score))
data

# 단계3. 차트 이용 - outlier 보기(데이터 분포 현황 분석)
x11()
plot(data$score) # 차트로 outlier 확인 : 50이상과 음수값
barplot(data$score) # 바 차트
mean(data$score) #[1] 14.44725

# 단계4. outlier 제거 - 평균(14.44725)
length(data$score) # [1] 91
data2 <- subset(data, score <= 14) # 14이상 제거
length(data2$score) # [1] 88


# 단계5. 정제된 데이터 보기
x <- data2$score
boxplot(x)
summary(x)

# (2) 세 집단 subset 작성과 기술통계량

# 단계1. 세 집단 subset 작성
data2$method2[data2$method == 1] <- "방법1"
data2$method2[data2$method == 2] <- "방법2"
data2$method2[data2$method == 3] <- "방법3"
View(data2)

# 단계2. 교육 방법별 빈도수
table(data2$method2)
#방법1 방법2 방법3
#  31    27    30


# 단계3. 교육 방법을 x 변수에 저장
x <- table(data2$method2)
x

# 단계4. 교육방법에 따른 시험성적 평균 구하기
y <- tapply(data2$score, data2$method2, mean)
y

# 단계5. 교육방법과 시험성적으로 데이터프레임 생성
df <- data.frame(교육방법 = x, 성적 = y)
df

# (3) 세 집단 간 동질성 검정
bartlett.test(score ~ method2, data = data2)
# p-value = 0.1905 > 0.05 : 귀무가설 채택.

# (4) 분산분석(세 집단 간 평균 차이 검정)
result <- aov(score ~ method2, data = data2)
result
names(result)
summary(result) # p-value=9.39e-14 : 귀무가설 기각

# (5) 사후검정
TukeyHSD(result) # 분산분석의 결과로 사후검정
plot(TukeyHSD(result))
