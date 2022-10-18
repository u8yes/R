# chap08_VisualizationAnalysis

#######################################
# chapter08. 고급 시각화 분석 
#######################################

## 1. R 고급 시각화 도구
# 제공 패키지- graphics/lattice/ggplot2 등...

## 2. 격자형(lattice) 기법 시각화(lattice package)
# 패키지 설치와 실습 데이터 셋 가져오기
install.packages("lattice")
library(lattice)

install.packages(c("statmod", "lme4", "mlmRev"))
library(statmod)
library(lme4)
library(mlmRev)
data("Chem97")
View(Chem97)

str(Chem97) # 'data.frame':	31022 obs. of  8 variables:
table(Chem97$score)
#   0    2    4    6    8   10
#3688 3627 4619 5739 6668 6681
range(Chem97$gcsescore) # 0~8
range(Chem97$age) # -6(1월생)~5(12월생)

# 2.1 히스토그램
# -형식) histogram( ~ x축 컬럼|조건, data...)

histogram(~ gcsescore, data = Chem97) # gcsescore 변수를 대상으로 백분율 적용 히스토그램.

table(Chem97$score)

# score 변수를 조건으로 지정.
histogram(~ gcsescore|score, data = Chem97) # score 단위

histogram(~ gcsescore|factor(score), data = Chem97) # score 요인 단위

# 2.2 밀도 그래프
# - 형식) densityplot(~축컬럼|조건,data,groups=변수)
# - 성별 변수를 그룹으로 지정하여 GCSE 점수를 score 단위로 밀도그래프를 플로팅.
densityplot(~ gcsescore|factor(score), data = Chem97,
            groups = gender, plot.points=F, auto.key = T)

# 2.3 막대 그래프
#  - 형식) barchart(y축컬럼~x축컬럼|조건,data,layout)

# 1) 데이터셋 가져오기
data("VADeaths")
VADeaths
str(VADeaths)

# 2) 데이터셋 구조보기
mode(VADeaths) # "numeric"
class(VADeaths) # "matrix"

# 3) 데이터 형식 변경
#   (1) matrix -> dataframe 변환
df <- as.data.frame(VADeaths)
str(df) # 'data.frame':	5 obs. of  4 variables:
class(df) # "data.frame"
df

#   (2) 막대그래프 그리기 - 데이터 형식 변경(matrix 형식을 table 형식으로 변경)
dft <- as.data.frame.table(VADeaths)
str(dft) # 'data.frame':	20 obs. of  3 variables:
class(dft) # "data.frame"
dft # Var1 Var2 Freq -> 1열 기준으로 data.table 생성

# 막대그래프 그리기
barchart(Var1~Freq|Var2, data=dft)
barchart(Var1~Freq|Var2, data=dft, layout=c(4,1))
# Var2 변수 단위(그룹화:시골과 도시 출신의 남녀)로 x축-Freq(사망비율), y축-Var1(사망연령대)으로 막대차트 플로팅. layout=c(4,1) 속성은 4개의 패널을 1행에 나타내주는 역할을 제공.

barchart(Var1~Freq|Var2, data=dft, layout=c(4,1), origin=0) # origin 속성 : x축의 구간을 0부터 표시해 주는 역할.

# 2.4 점 그래프
# - 형식) dotplot(y축컬럼~x축컬럼|조건,data,layout)
dotplot(Var1~Freq|Var2, dft) # layout 속성 생략시 기본 : 2행 2열 구조의 패널.
dotplot(Var1~Freq|Var2, dft,layout=c(1,4))

# Var2 변수 단위로 그룹화하여 점을 연결하여 플로팅.
dotplot(Var1 ~ Freq,data=dft, groups=Var2, type="o",
        auto.key=list(space="right",points=T,lines=T))
# type="o":점(point) 타입으로 원형에 실선이 통과하는 유형으로 그래프의 타입 지정.
# auto.key=list(space="right",points=T,lines=T):범례를 나타내는 속성으로 범례의 위치를 그래프에 나타내고, 점과 선을 추가.


# 2.5 산점도 그래프
# -형식) xyplot(y축컬럼~x축컬럼|조건변수, data=data.frame or list, layout)
library(datasets)
str(airquality) # data.frame':	153 obs. of  6 variables:
head(airquality) # Ozone Solar.R Wind Temp Month Day
View(airquality)

# airquality의 Ozone(y), Wind(x) 산점도 플로팅
names(airquality) <- c('Ozone','Solar.R','Wind', 'Temp', 'Month','Day')
xyplot(Ozone ~ Wind, data = airquality)
range(airquality$Ozone, na.rm = T) # 1~168
xyplot(Ozone ~ Wind | Month, data = airquality) # 2행 3컬럼
xyplot(Ozone ~ Wind | Month, data = airquality, layout=c(5, 1)) # layout=c(5, 1):5개의 패널을 1행으로 출력.
xyplot(Ozone ~ Wind | factor(Month), data = airquality, layout=c(5, 1)) # factor(Month) : 범주값으로 출력.

# airquality 데이터셋의 Month 타입 변경(factor)
convert <- transform(airquality, Month=factor(Month))
str(convert)  # $ Month : Factor w/ 5 levels "5","6","7","8",..:
head(convert)

xyplot(Ozone ~ Wind | Month, data = convert, layout=c(5, 1))

# quakes 데이터 셋으로 산점도 그래프 그리기
head(quakes)
str(quakes)  # 'data.frame':	1000 obs. of  5 variables:
range(quakes$stations) # 10~132(관측소)
View(quakes)

# 지진 발생 위치(위도와 경도)
xyplot(lat~long, data=quakes, pch="o")

# 그래프를 변수에 저장
tplot <- xyplot(lat~long, data=quakes, pch=".")

# 그래프에 제목 추가
tplot2 <- update(tplot, main="1964년 이후 태평양에서 발생한 지진위치")
tplot2


# 산점도 그래프 그리기
# 1. depth 이산형 변수 범위 확인.
range(quakes$depth) # 40~680 : depth 범위

# 2. depth 변수 리코딩:6개의 범주(100단위)로 코딩 변경.
quakes$depth2[quakes$depth >= 40 & quakes$depth <= 150] <- 1
quakes$depth2[quakes$depth >= 151 & quakes$depth <= 250] <- 2
quakes$depth2[quakes$depth >= 251 & quakes$depth <= 350] <- 3
quakes$depth2[quakes$depth >= 351 & quakes$depth <= 450] <- 4
quakes$depth2[quakes$depth >= 451 & quakes$depth <= 550] <- 5
quakes$depth2[quakes$depth >= 551 & quakes$depth <= 680] <- 6
View(quakes)

# 3. 리코딩 변수(depth2)를 조건으로 산점도 그래프 그리기
convert <- transform(quakes, depth2 = factor(depth2))
xyplot(lat~long | depth2, data=convert)

# 동일한 패널에 2개의 y축에 값을 표현.
xyplot(Ozone+Solar.R ~ Wind | factor(Month),
       data = airquality,
       col=c("blue", "red"),
       layout=c(5,1))


# 2.6 데이터 범주화

# equal.count() 함수 이용 이산형 변수 범주화

# (1) 1~150을 대상으로 겹쳐치지 않게 4개 영역으로 범주화
numgroup <- equal.count(1:150, number=4, overlap=0)
numgroup

# (2) 지진의 깊이를 5개 영역으로 범주화
depthgroup <- equal.count(quakes$depth, number=5, overlap=0)
depthgroup


# 범주화된 변수(depthgroup)를 조건으로 산점도 그래프 그리기
xyplot(lat~long | depthgroup, data = quakes,
       main="Fiji Earthquakes(depthgroup)",
       ylab="위도", xlab="경도",pch="@", col="red")

# 수심과 리히터규모 변수를 동시에 적용하여 산점도 그래프 그리기
magnitudegroup <- equal.count(quakes$mag, number=2, overlap=0)
magnitudegroup

# magnitudegroup 변수 기준으로 플로팅
xyplot(lat~long | magnitudegroup, data = quakes,
       main="Fiji Earthquakes(magnitude)",
       ylab = "latitude", xlab = "longitude",
       pch="@", col="blue")


# 수심과 리히터 규모를 동시에 표현(2행 5열 패널 구조)
xyplot(lat~long | depthgroup*magnitudegroup, data=quakes,
       main="Fiji Earthquakes",
       ylab = "latitude", xlab = "longitude",
       pch="@", col=c("red", "blue"))

# 이산형 변수로 리코딩한 뒤에 factor형으로 변환하여 산점도 그래프 그리기

# depth 변수 리코딩분
quakes$depth3[quakes$depth >= 39.5 & quakes$depth <= 80.5] <- 'd1'
quakes$depth3[quakes$depth >= 79.5 & quakes$depth <= 186.5] <- 'd2'
quakes$depth3[quakes$depth >= 185.5 & quakes$depth <= 397.5] <- 'd3'
quakes$depth3[quakes$depth >= 396.5 & quakes$depth <= 562.5] <- 'd4'
quakes$depth3[quakes$depth >= 562.5 & quakes$depth <= 680.5] <- 'd5'

# mag 변수 리코딩
quakes$mag3[quakes$mag >= 3.95 & quakes$mag <= 4.65] <- 'm1'
quakes$mag3[quakes$mag >= 4.55 & quakes$mag <= 6.45] <- 'm2'
View(quakes)
str(quakes)

convert <- transform(quakes, depth3=factor(depth3), mag3=factor(mag3))
str(convert)

xyplot(lat ~ long | depth3*mag3, data=convert,
       main="Fiji Earthquakes",
       ylab = "latitude", xlab = "longitude",
       pch="@", col=c("red", "blue"))

# 2.7 조건 그래프(graphics 패키지에서 제공)
coplot(lat~long | depth, data = quakes) # default:6개영역, 0.5단위로 겹침.
coplot(lat~long | depth, data = quakes, overlap = 0.1) # 겹치는 구간:0.1
coplot(lat~long | depth, data = quakes, number = 5, row = 1) # 사이간격 5, 1행 5열

# 패널과 조건 막대에 색 적용 후 조건 그래프 그리기
coplot(lat~long | depth, data = quakes, number = 5, row=1,
       panel=panel.smooth)
coplot(lat~long | depth, data = quakes, number = 5, row=1,
       col="blue", bar.bg = c(num="green")) # 패널과 조건 막대 색
help(coplot)

# 2.8 3차원 산점도 그래프

# 위도, 경도, 깊이를 이용하여 3차원 산점도 그래프 그리기
cloud(depth ~ lat * long, data = quakes,
      zlim = rev(range(quakes$depth)),
      xlab = "경도", ylab = "위도", zlab = "깊이")


# 테두리와 회전 속성을 추가하여 3차원 산점도 그래프 그리기
cloud(depth ~ lat * long, data = quakes,
      zlim = rev(range(quakes$depth)),
      panel.aspect=0.9,
      screen=list(z=45, x=-25),
      xlab = "경도", ylab = "위도", zlab = "깊이") # panel.aspect:테두리사이즈, screen : 회전각


# 3. 기하학적 기법 시각화(ggplot2 package)

# 3.1 qplot() 함수

install.packages("ggplot2")
library(ggplot2)
data("mpg")
View(mpg)

str(mpg)
class(mpg)
summary(mpg)

# (1) 한 개 변수 대상 qplot() 함수 적용
help(qplot)

qplot(data=mpg, x=hwy) # 세로 막대 그래프

# fill 속성: hwy 변수를 대상으로 drv 변수에 색 채우기(누적 막대 그래프)
qplot(hwy, data=mpg, fill=drv) # fill 옵션 적용

# binwidth 속성: 막대 폭 지정 옵션
qplot(hwy, data=mpg, fill=drv, binwidth=2) # binwidth 옵션 적용(막대의 폭 크기 지정)

# facets 속성:drv 변수 값으로 컬럼 단위와 행 단위로 패널 생성
qplot(hwy, data=mpg, fill=drv, facets = .~ drv, binwidth=2) # 열 단위 패널 생성

qplot(hwy, data=mpg, fill=drv, facets = drv ~. , binwidth=2) # 행 단위 패널 생성

# (2) 두 개 변수 대상 qplot() 함수 적용.
qplot(displ, hwy, data=mpg) # mpg 데이터 셋의 displ과 hwy 변수 이용(산점도).

# displ, hwy 대상으로 drv 변수값으로 색상 적용 산점도 그래프
qplot(displ, hwy, data=mpg, color=drv)

# displ과 hwy 변수와 관계를 drv로 구분
qplot(displ, hwy, data=mpg, color=drv, facets=.~drv)

# (3) 미적 요소 맵핑(mapping)
#  - qplot() 함수에서 제공하는 색상, 크기, 모양 등의 미적 요소를 데이터에 연결하여 그래프에 적용.

View(mtcars)
str(mtcars) # 'data.frame':	32 obs. of  11 variables:
table(mtcars$carb)
# 1  2  3  4  6  8
# 7 10  3 10  1  1
table(mtcars$cyl)
#  4  6  8
# 11  7 14

qplot(wt,mpg,data=mtcars)
qplot(wt,mpg,data=mtcars,color=factor(carb)) # 색상 적용
qplot(wt,mpg,data=mtcars,color=factor(carb),size=qsec) # 크기 적용
qplot(wt,mpg,data=mtcars,color=factor(carb),size=qsec, shape=factor(cyl)) # 모양 적용

# (4) 기하학적 객체 적용
View(diamonds)

# geom="bar"(속성으로 막대그래프 그리기)
# -> clarity 변수 대상 cut 변수로 색 채우기
qplot(clarity,data=diamonds,fill=cut, geom="bar")# 레이아웃에 색 채우기
qplot(clarity,data=diamonds,color=cut, geom="bar") # 테두리 적용.

# geom="point"
qplot(wt,mpg,data=mtcars,size=qsec, geom="point")

# cyl 변수의 요인으로 point 크기 적용, carb 변수의 요인으로 포인트 색 적용.
qplot(wt,mpg,data=mtcars,size=factor(cyl),color=factor(carb), geom="point")

# qsec 변수로 포인트 크기 적용, cyl 변수의 요인으로 point 모양 적용.
qplot(wt,mpg,data=mtcars,size=qsec,color=factor(carb),shape=factor(cyl),geom = "point" )

# geom="smooth"
qplot(wt,mpg,data=mtcars,geom=c("point","smooth"))
qplot(wt,mpg,data=mtcars,color=factor(cyl),geom=c("point","smooth")) # cyl 변수 요인으로 색상 적용.

# geom="line"
qplot(mpg,wt,data=mtcars,color=factor(cyl),geom="line")
qplot(mpg,wt,data=mtcars,color=factor(cyl),geom=c("point","line"))

# 3.2 ggplot() 함수

# 단계1(layer1): 배경 설정하기.
# x축은 displ, y축은 hwy로 지정해 배경 생성
ggplot(data=mpg,aes(x=displ,y=hwy)) # aesthetics(미학)

# 단계2(layer2): 그래프 추가하기
# 배경에 산점도 추가
ggplot(data=mpg,aes(x=displ,y=hwy)) + geom_point()

# 단계3(layer3): 축범위를 조정하는 설정 추가하기.
# x축 범위값을 3~6으로 지정.
ggplot(data=mpg,aes(x=displ,y=hwy)) + geom_point() + xlim(3,6) + ylim(10,30)

# (1) 미적 요소 맵핑
p <- ggplot(diamonds, aes(carat,price,color=cut))
p + geom_point()

# (2) 기하학적 객체(geometric object:점/선/막대) 적용
p <- ggplot(mtcars, aes(mpg,wt,color=factor(cyl)))
p + geom_line()

p <- ggplot(mtcars, aes(mpg,wt,color=factor(cyl)))
p + geom_point()

# (3) 미적 요소 맵핑과 기하학적 객체 적용
p <- ggplot(diamonds, aes(price))
p + stat_bin(aes(fill=cut), geom="bar") # stat_bin():(aes():미적요소)+ ('geom=') : 기하학적 요소 + 기능 동시 적용.

p <- ggplot(diamonds, aes(price))
p + stat_bin(aes(fill=cut), geom="area")
p + stat_bin(aes(color=cut,size=..density..), geom="point")

# (4) 테마(Thema) 적용
p <- ggplot(diamonds, aes(carat,price,color=cut))
p <- p + geom_point() + ggtitle("다이아몬드 무게와 가격의 상관관계")
p

p + theme(
    title=element_text(color="blue",size=25), #축제목
    axis.title=element_text(size=14,face="bold"), # 축제목
    axis.title.x=element_text(color="green"), # x축 제목
    axis.title.y=element_text(color="red"), # y축 제목
    axis.text=element_text(size="14"), # 축이름크기
    axis.text.x=element_text(color="orange"), # x축이름(0~5)
    axis.text.y=element_text(color="yellow"), # y축이름(0~15000)
    legend.title = element_text(size=20,face="bold",color = "red"), # 범례
    legend.position = "bottom",
    legend.direction="horizontal")

# 3.3 ggsave() 함수

p <- ggplot(diamonds, aes(carat,price,color=cut))
p + geom_point()

# 가장 최근 그래프 저장
ggsave(file="C:/workspaces/Rwork/src/output/diamond_price.pdf")
ggsave(file="C:/workspaces/Rwork/src/output/diamond_price.jpg", dpi=72)

# 변수에 저장된 그래프 저장
p <- ggplot(diamonds, aes(clarity)) # 선명도
p <- p + geom_bar(aes(fill=cut), position="fill") # bar 추가
p

ggsave(file="C:/workspaces/Rwork/src/output/diamond_price.png",plot=p,width=10, height=5)


# 4. 지도 공간 기법 시각화(ggmap package)

# stamen Maps API 이용

# 지도 관련 패키지 설치
library(ggplot2)  # ggplot2 패키지 로딩
install.packages("ggmap") # ggmap 패키지 설치
library(ggmap)

# 위도와 경도 중심으로 지도 시각화
# 실습: 서울을 중심으로 지도 시각화하기
# 단계 1: 서울 지역의 중심 좌표 설정
seoul <- c(left = 126.77, bottom = 37.40,
           right = 127.17, top = 37.70)

# 단계 2: zoom, maptype으로 정적 지도 이미지 가져오기
map <- get_stamenmap(seoul, zoom = 12, maptype = 'terrain')
ggmap(map)


# 실습 : 2019년도 1월 대한민국 인구수를 기준으로 지역별 인구수 표시하기
# 단계 1: 데이터 셋 가져오기
pop <- read.csv(file.choose(), header = T)
View(pop)

library(stringr)

region <- pop$'지역명'
lon <- pop$LON
lat <- pop$LAT
tot_pop <- as.numeric(str_replace_all(pop$'총인구수', ',', ''))

df <- data.frame(region, lon, lat, tot_pop)
df
df <- df[1:17, ]
df

# 단계 2: 정적 지도 이미지 가져오기
daegu <- c(left = 123.4423013, bottom = 32.8528306,
           right = 131.601445, top = 38.8714354)
map <- get_stamenmap(daegu, zoom = 7, maptype = 'watercolor')

# 단계 3: 지도 시각화하기
layer1 <- ggmap(map)
layer1

# 단계 4: 포인트 추가
layer2 <- layer1 + geom_point(data = df,
                              aes(x = lon, y = lat,
                                  color = factor(tot_pop),
                                  size = factor(tot_pop)))
layer2

# 단계 5: 텍스트 추가
layer3 <- layer2 + geom_text(data = df,
                             aes(x = lon + 0.01, y = lat + 0.08,
                                 label = region), size = 3)
layer3

# 단계 6: 크기를 지정하여 파일로 저장하기
ggsave("C:/workspaces/Rwork/src/output/pop201901.png", scale = 1, width = 10.24, height = 7.68)

