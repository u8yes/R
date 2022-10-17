# chap05_DataVisualization

##############################
# chapter05. 데이터 시각화
##############################

# 이산변수와 연속변수 시각화

# 1. 이산변수(discrete quantitative data) 시각화
#   - 정수 단위로 나누어 측정할 수 있는 변수.

#  1) 막대차트 시각화 - barplot() 함수
#    (1) 세로 막대차트

# 막대 차트 데이터 생성
chart_data <- c(305, 450, 320, 460, 330, 480, 380, 520) # 정수 데이터
names(chart_data) <- c("2019 1분기", "2020 1분기", "2019 2분기", "2020 2분기", "2019 3분기", "2020 3분기", "2019 4분기", "2020 4분기")

str(chart_data)
chart_data

# 세로 막대 차트
help("barplot")
help(barplot)
barplot(chart_data, ylim = c(0, 600), col = rainbow(8), main = "2019년도 vs 2020년도 분기별 매출현황 비교")

barplot(chart_data, ylim = c(0, 600), col = rainbow(8),
        ylab = "매출액(단위:억원)", xlab = "년도별 분기현황", 
        main = "2019년도 vs 2020년도 분기별 매출현황 비교")
# barplot(vector, ylimit(0부터 600까지만), col=rainbow(자동 8개의 색상으로), main = 타이틀을 붙어준다. )

#    (2) 가로 막대 차트
barplot(chart_data, xlim = c(0, 600),
        ylab = "년도별 분기현황", xlab = "매출액(단위:억원)",
        col = rainbow(8),
        main = "2019년도 vs 2020년도 분기별 매출현황 비교",
        horiz = T)

barplot(chart_data, xlim = c(0, 600),
        ylab = "년도별 분기현황", xlab = "매출액(단위:억원)",
        col = rainbow(8),
        main = "2019년도 vs 2020년도 분기별 매출현황 비교",
        horiz = T, space=1.5) # space = 크기의 간격

barplot(chart_data, xlim = c(0, 600),
        ylab = "년도별 분기현황", xlab = "매출액(단위:억원)",
        col = rainbow(8),
        main = "2019년도 vs 2020년도 분기별 매출현황 비교",
        horiz = T, space=1.5, cex.names=0.8) # character expand 문자 확장 = cex

# red와 blue 색상 4회 반복
barplot(chart_data, xlim = c(0, 600),
        ylab = "년도별 분기현황", xlab = "매출액(단위:억원)",
        main = "2019년도 vs 2020년도 분기별 매출현황 비교",
        horiz = T, space=1.5, cex.names=0.8,
        col=rep(c(2, 4), 4)) # repeat 함수 2:빨간색 4:파란색을 4번 반복하라.
# col=rep(c(2, 4), ) : 검은색(1), 빨간색(2), 초록색(3), 파란색(4), 하늘색(5), 자주색(6), 노란색(7)

barplot(chart_data, xlim = c(0, 600),
        ylab = "년도별 분기현황", xlab = "매출액(단위:억원)",
        main = "2019년도 vs 2020년도 분기별 매출현황 비교",
        horiz = T, space=1.5, cex.names=0.8,
        col=rep(c("green", "yellow"), 4)) # repeat 4번 반복

# 누적 막대 차트
data("VADeaths")
VADeaths

str(VADeaths)
mode(VADeaths)  # "numeric"
class(VADeaths) # "matrix" "array" 2차원 배열

# 개별 차트와 누적 차트 그리기

# 누적 차트
par(mfrow=c(1,2)) # 1행 2열 그래프 보기

barplot(VADeaths, col=rainbow(5),
        main = "미국 버지니아주 하위계층 사망 비율")

legend(3.8, 200,
       c("50-54세", "55-59세", "60-64세", "65-69세", "70-74세"),
       cex = 0.8, fill = rainbow(5)) # 3.8 위치

# 개별 차트
barplot(VADeaths, col=rainbow(5),
        main = "미국 버지니아주 하위계층 사망 비율",
        beside=T) # 개별적으로 나누어서 시각화

legend(19, 71,
       c("50-54세", "55-59세", "60-64세", "65-69세", "70-74세"),
       cex = 0.8, fill = rainbow(5))


#  2) 점 차트 시각화 - dotchart()
help("dotchart")

par(mfrow=c(1,1)) # 1행1열 그래프 보기

dotchart(chart_data, color = c("black", "red"),
         xlab = "매출액(단위:억원)",
         cex=1.2,
         main="분기별 판매현황 점 차트 시각화",
         labels=names(chart_data))

dotchart(chart_data, color = c("black", "red"),
         xlab = "매출액(단위:억원)",
         cex=1.2,
         main="분기별 판매현황 점 차트 시각화",
         labels=names(chart_data),
         lcolor="blue", pch=2:3)
# pch(plotting character): 원(1), 삼각형(2), +(3)
# cex(character expansion): 레이블과 점의 크기 확대 역할.

#  3) 원형 차트 시각화 - pie() 함수
help(pie)

pie(chart_data, labels = names(chart_data),
    border = 'blue', col=rainbow(8), cex=4)
title("2019~2020년도 분기별 매출현황")


# 2. 연속변수(Continuous quantitative data) 시각화 # Day25; 20221011
#   - 시간, 길이 등과 같은 연속성을 가진 변수.

#  1) 상자 그래프 시각화 : 요약정보를 시각화하는데 효과적. 특히 데이터의 분포 정도와 이상치 발견을 목적으로 하는 경우 유용.
help(boxplot)
par(mfrow=c(1,2))
boxplot(VADeaths) # 상자그래프 시각화.
boxplot(VADeaths, range=0) 
# range=0:최소값과 최대값 사이를 점선으로 연결하는 역할.

abline(h = 37, lty=3, col="red") # 기준선 추가(lty=3 : 점선)

summary(VADeaths) # median이 2사분위

#  2) 히스토그램 시각화
#    - 측정값의 범위(구간)를 그래프의 x축으로 놓고, 범위에 속하는 측정값의 빈도수를 y축으로 나타낸 그래프 형태.

data("iris") # iris 데이터 셋 가져오기
head(iris)
table(iris$Species)
#setosa versicolor  virginica
#    50         50         50

names(iris)
# "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" "Species"

summary(iris$Sepal.Width) # 기술 통계량

hist(iris$Sepal.Width, xlab = "꽃받침의 너비",
     col="green", xlim=c(2.0, 4.5),
     main="iris 꽃받침 너비 histogram") # xlimit(2 ~ 4.5까지 지정)

summary(iris$Sepal.Length)

hist(iris$Sepal.Length, xlab = "꽃받침의 길이",
     col="mistyrose", xlim=c(4.0, 8.0),
     main="iris 꽃받침 너비 histogram")

# 확률 밀도로 히스토그램 그리기 - 연속형변수의 확률.
hist(iris$Sepal.Width, xlab = "꽃받침 너비",
     col="mistyrose", xlim=c(2.0, 4.5),
     main="iris 꽃받침 너비 histgram", freq=F) # y축을 빈도수가 아닌 밀도로 계산을 해서 y축을 설정

# 밀도를 기준으로 line을 그려준다.
lines(density(iris$Sepal.Width), col="red")

# 정규분포곡선 추가
# - 분포곡선:빈도수의 값을 선으로 연결하여 얻어진 곡선.
x <- seq(2.0, 4.5, 0.1) # 0.1단위로 2~ 4.5까지 연속적인 데이터셋을 반환
x

curve(dnorm(x, mean=mean(iris$Sepal.Width), sd=sd(iris$Sepal.Width)),
      col="blue", add=T) # width값이 파란색(blue)


#  3) 산점도 시각화
#    - 두 개 이상의 변수들 사이의 분포를 점으로 표시한 차트를 의미.

# 기본 산점도 시각화
price <- runif(10, min = 1, max = 100) # 1~100 사이의 10개 난수 발생.
price # 난수를 확인 가능
plot(price)

# 대각선 추가
par(new=T) # 차트 추가
line_chart <- c(1:100)
line_chart
plot(line_chart, type = "l", col="red", axes = F, ann = F) 

# 텍스트 추가
text(70, 80, "대각선 추가", col="blue")

# type 속성으로 그리기
par(mfrow=c(2,2)) # 2행 2열 차트 그리기.
plot(price, type = "l") # 유형:실선
plot(price, type = "o") # 유형:원형과 실선(원형통과)
plot(price, type = "h") # 유형:직선
plot(price, type = "s") # 유형:꺽은선

# pch 속성으로 그리기
plot(price, type="o", pch=5) # 빈 사각형
plot(price, type="o", pch=15) # 채워진 사각형
plot(price, type="o", pch=20) # 채워진 원형
plot(price, type="o", pch=20, col="blue")
plot(price, type="o", pch=20, col="orange", cex=3.0) # 
plot(price, type="o", pch=20, col="orange", cex=3.0, lwd=3) # lwd:line width


#  4) 중첩 자료 시각화
# 중복된 자료의 수 만큼 점의 크기 확대하기
par(mfrow=c(1, 1)) # 1행 1열

# 두 개의 벡터 객체
x <- c(1, 2, 3, 4, 2, 4)
y <- rep(2, 6)
x; y

# 교차테이블 작성
table(x); table(y)
table(x, y)

# 산점도 시각화
plot(x, y)

# 데이터프레임 생성
xy.df <- as.data.frame(table(x, y))
xy.df

# 좌표에 중복된 수 만큼 점 확대
plot(x, y, pch=15, col="blue",
     xlab = "x 벡터 원소",
     ylab = "y 벡터 원소",
     cex = 0.8 * xy.df$Freq) # cex 문자 캐릭터 expansion


# galton 데이터 셋 대상 중복 자료 시각화
# galton 데이터 셋 가져오기
install.packages("UsingR")
library(UsingR)
data("galton") # 자식과 부모의 키 차이
head(galton) # 빈도수 값을 6번째까지 보여줌
str(galton) # 'data.frame':	928 obs. of  2 variables: # 928 가정을 대상으로 부모와 자식의 키 차이 데이터 제공
class(galton) # "data.frame"

# 데이터프레임으로 변환
galtonData <- as.data.frame(table(galton$child, galton$parent))
head(galtonData)
str(galtonData) # 'data.frame':	154 obs. of  3 variables:

# 컬럼 단위 추출
names(galtonData) <- c("child", "parent", "freq") # 컬럼에 이름 지정.
head(galtonData)

parent <- as.numeric(galtonData$parent)
child <- as.numeric(galtonData$child)


# 점의 크기 확대
plot(parent, child, pch=21, col="blue", bg="green",
     xlab = "parent", ylab = "child",
     cex = 0.2 * galtonData$freq) # 빈도수가 많을수록 0.2가 곱해짐
# plot ch캐릭터(pch)는 21일수록 더 원의 형태로 보여줌

#  5) 변수 간의 비교 시각화
# iris 4개 변수의 상호 비교
attributes(iris)
data(iris)
help(pairs)

# matrix 또는 데이터프레임의 numeric 컬럼을 대상으로 변수들 사이의 비교 결과를 행렬구조의 분산된 그래프로 제공.
pairs(iris[,1:4]) # "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"

# 꽃의 종류가 "virginica"와 "setosa", "versicolor"를 종별 대상으로 4개 변수 상호 비교.
pairs(iris[iris$Species=="virginica", 1:4])
pairs(iris[iris$Species=="setosa", 1:4])
pairs(iris[iris$Species=="versicolor", 1:4])

# 3차원 산점도 시각화
# 패키지 설치 및 로딩
install.packages("scatterplot3d")
library(scatterplot3d)

# Factor의 levels 보기
levels(iris$Species) # "setosa" "versicolor" "virginica"

# 붓꽃의 종류별 분류
iris_setosa <- iris[iris$Species == 'setosa', ]
iris_versicolor <- iris[iris$Species == 'versicolor', ]
iris_virginica <- iris[iris$Species == 'virginica', ]

# 3차원 틀 생성
# scatterplot3d(밑변, 오른쪽변 컬럼명, 왼쪽변 컬럼명, type)

d3 <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type = 'n') # type : h->수직선, p->점, l->선

# 3차원 산점도 시각화
d3$points3d(iris_setosa$Petal.Length,
            iris_setosa$Sepal.Length,
            iris_setosa$Sepal.Width,
            bg='orange', pch=21) # 타원 산점도

d3$points3d(iris_versicolor$Petal.Length,
            iris_versicolor$Sepal.Length,
            iris_versicolor$Sepal.Width,
            bg='blue', pch=23) # 마름모꼴 산점도

d3$points3d(iris_virginica$Petal.Length,
            iris_virginica$Sepal.Length,
            iris_virginica$Sepal.Width,
            bg='green', pch=25) # 역삼각형 산점도

