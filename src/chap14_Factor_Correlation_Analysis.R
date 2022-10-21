# chap14_Factor_Correlation_Analysis

###########################################
# Chapter14-1. 요인분석(Factor Analysis) # 요인 - domain, 값(빈도수를 가지고 있는 값)
###########################################

# 요인분석의 목적
# 1. 자료의 요약 : 변인(변수)을 몇 개의 공통된 변인으로 묶음
# 2. 변인 구조 파악 : 변인들의 상호관계 파악(독립성 등)
# 3. 불필요한 변인(변수) 제거 : 중요도가 떨어진 변수 제거
# 4. 측정도구 타당성 검증 : 변인(변수)들이 동일한 요인으로 묶이는지 여부를 확인

# 전제조건 : 등간척도 or 비율척도, 정규분포, 관찰치 상호독립적/분산 동일

# 요인분석 결과에 대한 활용 방안
# 1. 서로 밀접하게 관련된 변수들을 합치거나 중복된 변수를 제거하여 변수를 축소한다.
# 2. 변수들 간의 연관성 또는 공통점 탐색
# 3. 요인점수 계산으로 상관분석, 회귀분석의 설명변수로 이용


## 1.1 공통요인으로 변수 정제

# [실습] 변수와 데이터프레임 생성
s1 <- c(1, 2, 1, 2, 3, 4, 2, 3, 4, 5) # s1 : 자연과학
s2 <- c(1, 3, 1, 2, 3, 4, 2, 4, 3, 4) # s2 : 물리화학
s3 <- c(2, 3, 2, 3, 2, 3, 5, 3, 4, 2) # s3 : 인문사회
s4 <- c(2, 4, 2, 3, 2, 3, 5, 3, 4, 1) # s4 : 신문방송
s5 <- c(4, 5, 4, 5, 2, 1, 5, 2, 4, 3) # s5 : 응용수학
s6 <- c(4, 3, 4, 4, 2, 1, 5, 2, 4, 2) # s6 : 추론통계
name <-1:10 # 각 과목 문항 이름

subject <- data.frame(s1, s2, s3, s4, s5, s6)
View(subject)
str(subject)
summary(subject)

# [실습] 변수의 주요 성분분석
pc <- prcomp(subject)
summary(pc)
x11()
plot(pc)

# 고유값으로 요인 수 분석 # 2차적으로 검증을 할 수 있다고 볼 수 있다.
en <- eigen(cor(subject)) # $values : 고유값, $vectors : 고유벡터 # cor() 상관분석 알고리즘 # eigen() 고유값
names(en) # "values"  "vectors"

en$values # $values : 고유값(스칼라) 보기
en$vectors
plot(en$values, type="o") # 고유값을 이용한 시각화


# [실습] 변수 간의 상관관계 분석과 요인분석
cor(subject)

# 요인분석 : 요인회전법 적용(varimax is the default)

# (1) 주성분분석의 가정에 의해서 2개 요인으로 분석

result <- factanal(subject, factors = 2, rotation = "varimax") # 6개 데이터를 2개의 factor로 축약해서 결과를 요인분석
result # p-value is 0.0232  < 0.05 # 요인수가 부족. # 95% 안에 들어오지 못하기 때문에 2개로는 부족하다. 0.05보다 작기 때문에 기각 되는 것이다.

# (2) 고유값으로 가정한 3개 요인으로 분석
result <- factanal(subject, factors = 3, rotation = "varimax")
result
result <- factanal(subject, factors = 3, # 요인 개수 지정
                   rotation = "varimax", # 회전방법 지정("varimax", "promax", "none")
                   scores="regression") # 요인점수 계산 방법 # 4개는 최적이 아니다.
result
# Uniquenesses: 0.5이하면 유효.

# 요인적재량 보기
names(result)
result$loadings

# (3) 다양한 방법으로 요인적재량 보기
print(result, digits = 2, cutoff=0.5) # cutoff 차단
print(result$loadings, cutoff=0) # display every loadings # cutoff=0 감추어진 적재량까지 보여줘

# 요인점수
#  - 관측치의 동작을 살펴보는데 사용되며, 상관분석이나 회귀분석의 독립변수로 사용. # 몇 개로 축약할 건지 결정함
#  - 각 변수(표준화값)와 요인 간의 관계(요인부하량)를 통해서 구해진 점수.

result$scores


# [실습] 요인점수를 이용한 요인적재량 시각화

# (1) Factor1, Factor2 요인지표 시각화
plot(result$scores[, c(1:2)], main="Factor1과 Factor2 요인점수 행렬")
text(result$scores[, 1], result$scores[,2],
     labels = name, cex = 0.7, pos = 3, col = "blue")

# 요인적재량 plotting
points(result$loadings[, c(1:2)], pch=19, col = "red")
text(result$loadings[, 1], result$loadings[,2],
     labels = rownames(result$loadings),
     cex = 0.8, pos = 3, col = "red")

# (2) Factor1, Factor3 요인지표 시각화
plot(result$scores[,c(1,3)], main="Factor1과 Factor3 요인점수 행렬")
text(result$scores[,1], result$scores[,3],
     labels = name, cex = 0.7, pos = 3, col = "blue")

# 요인적재량 plotting
points(result$loadings[,c(1,3)], pch=19, col = "red")
text(result$loadings[,1], result$loadings[,3],
     labels = rownames(result$loadings),
     cex = 0.8, pos = 3, col = "red")


# [실습] 3차원 산점도로 요인적재량 시각화
install.packages("scatterplot3d")
library(scatterplot3d)

Factor1 <- result$scores[,1]
Factor2 <- result$scores[,2]
Factor3 <- result$scores[,3]
# scatterplot3d(밑변, 오른쪽변, 왼쪽변, type='p') # type='p' : 기본산점도 표시
d3 <- scatterplot3d(Factor1, Factor2, Factor3)

# 요인적재량 표시
loadings1 <- result$loadings[,1]
loadings2 <- result$loadings[,2]
loadings3 <- result$loadings[,3]
d3$points3d(loadings1, loadings2, loadings3, bg='red',pch=21, cex=2, type='h')


# [실습] 요인별 변수 묶기
# (1) 요인별 과목변수 이용 데이터프레임 생성
app <- data.frame(subject$s5, subject$s6) # 응용과학
soc <- data.frame(subject$s3, subject$s4) # 사회과학
net <- data.frame(subject$s1, subject$s2) # 자연과학

# (2) (산술)평균 계산 - 3개의 파생변수 생성:가독성과 설득력이 높다.
app_science <- round( (app$subject.s5 + app$subject.s6) / ncol(app), 2)
soc_science <- round( (soc$subject.s3 + soc$subject.s4) / ncol(soc), 2)
net_science <- round( (net$subject.s1 + net$subject.s2) / ncol(net), 2)

# (3) 상관관계 분석 - 요인분석을 통해서 만들어진 파생변수는 상관분석이나 회귀분석에서 독립변수로 사용할 수 있다.
subject_factor_df <- data.frame(app_science, soc_science, net_science)
cor(subject_factor_df)


## 1.2 잘못 분류된 요인 제거로 변수 정제

# [실습] 요인분석에 사용될 데이터 셋 가져오기

# (1) 데이터 가져오기
install.packages('memisc') # spss tool 포맷 파일 읽어오기
library(memisc)
#setwd("D:/heaven_dev/workspaces/R/data/")
data.spss <- as.data.set(spss.system.file('D:/heaven_dev/workspaces/R/data/drinking_water.sav', encoded = 'utf-8'))
data.spss
View(data.spss)

# (2) 데이터프레임으로 변경
drinking_water <- data.spss[1:11]
drinking_water
drinking_water_df <- as.data.frame(drinking_water)
str(drinking_water_df)
View(drinking_water_df)

# (3)  요인수를 3개로 지정하여 요인분석 수행
result2 <- factanal(drinking_water_df, factors = 3, rotation = "varimax",
                    scores = "regression")
result2
print(result2, cutoff=0.5)


# [실습] 요인별 변수 묶기

# 1)  q4 칼럼 제외하여 데이터프레임 생성
dw_df <- drinking_water_df[-4]
str(dw_df)
dim(dw_df) # [1] 380  10
cor(dw_df)
class(dw_df)
names(dw_df) <- c('q1','q2','q3','q5','q6','q7','q8','q9','q10','q11')

# 2) 요인에 속하는 입력변수별 데이터프레임 구성

# 제품만족도 저장 데이터프레임
s <- data.frame(dw_df$q8, dw_df$q9, dw_df$q10, dw_df$q11)
# 제품친밀도 저장 데이터프레임
c <- data.frame(dw_df$q1, dw_df$q2, dw_df$q3)
# 제품적절성 저장 데이터프레임
p <- data.frame(dw_df$q5, dw_df$q6, dw_df$q7)

# 3) 요인별 산술평균 계산
satisfaction <- round( (s$dw_df.q8 + s$dw_df.q9 + s$dw_df.q10 + s$dw_df.q11) / ncol(s), 2)
closeness <- round( (c$dw_df.q1 + c$dw_df.q2 + c$dw_df.q3) / ncol(c), 2)
pertinence <- round( (p$dw_df.q5 + p$dw_df.q6 + p$dw_df.q7) / ncol(p), 2)

# 4) 상관관계 분석
drinking_water_factor_df <- data.frame(satisfaction, closeness, pertinence)
colnames(drinking_water_factor_df) <- c("제품만족도","제품친밀도","제품적절성")
cor(drinking_water_factor_df)



######################################################
## Chapter14-2. 상관관계 분석(Correlation Analysis)
######################################################

# 2.2 상관관계 분석 수행

# [실습] 기술 통계량 구하기
result <- read.csv("D:/heaven_dev/workspaces/R/data/product.csv", header=TRUE)
View(result)
head(result) # 친밀도 적절성 만족도(등간척도 - 5점 척도)

# 기술통계량
summary(result) # 요약통계량

sd(result$제품_친밀도); sd(result$제품_적절성); sd(result$제품_만족도)


# [실습] 상관계수(coefficient of correlation) : 두 변량 X,Y 사이의 상관관계 정도를 나타내는 수치(계수)
cor(result$제품_친밀도, result$제품_적절성) # 0.4992086 -> 다소 높은 양의 상관관계
cor(result$제품_친밀도, result$제품_만족도) # 0.467145 -> 다소 높은 양의 상관관계

# [실습] 전체 변수 간 상관계수 보기
cor(result, method="pearson")

# [실습] 방향성 있는 색상으로 표현
install.packages("corrgram")
library(corrgram)
corrgram(result) # 색상 적용 - 동일 색상으로 그룹화 표시
corrgram(result, upper.panel=panel.conf) # 수치(상관계수) 추가(위쪽)
corrgram(result, lower.panel=panel.conf) # 수치(상관계수) 추가(아래쪽)

# [실습] 차트에 밀도 곡선, 상관성, 유의확률(별표) 추가
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

# 상관성,p값(*),정규분포 시각화 - 모수 검정 조건
chart.Correlation(result, histogram=, pch="+")

# [실습]  spearman : 서열척도 대상 상관계수
cor(result, method="spearman")

