# chap15_TimeseriesAnalysis

##################################################
##  Chapter15. 시계열 분석(Timeseries Analysis) 
##################################################

# 시계열(Time-Series) : 관측치 또는 통계량의 변화를 시간의 움직임에 따라서 기록하고, 이것을 계열화한 것을 의미한다.
# 시계열 데이터 : 통계 숫자를 시간의 흐름에 따라 일정한 간격마다 기록한 통계열을 의미한다.
# 현상 이해 -> 미래 예측

############################
## 시계열 자료 확인
############################

## 비정상성 시계열 -> 정상성 시계열

# 단계1: 데이터 셋 가져오기
data("AirPassengers") # 12년(1949~1961년)간 매월 항공기 탑승 승객 수를 기록한 시계열 자료.
str(AirPassengers) # Time-Series [1:144] from 1949 to 1961:

# 단계2:차분(Differencing) 적용-현재 시점에서 이전 시점의 자료를 빼는 연산으로 평균을 정상화하는데 이용 : 평균 정상화.
x11()
ts.plot(AirPassengers) # TimeSeries.plot = ts.plot

par(mfrow=c(1,2))
log <- diff(AirPassengers) # 차분 수행
plot(log) # 평균 정상화

log <- diff(log(AirPassengers)) # 로그+차분 수행
plot(log) # 분산 정상화


############################
## 시계열 자료 시각화
############################

# 단일 시계열 자료 시각화

# 단계1: WWWusage 데이터 셋 가져오기 - R에서 기본 제공 데이터 셋으로 인터넷 사용 시간을 분 단위로 측정한 100개 vector(1차원배열)로 구성된 시계열 자료.
data("WWWusage")
str(WWWusage) # Time-Series [1:100] from 1 to 100:
WWWusage

# 단계2: 시계열 자료 추세선 시각화
# - 추세:어떤 현상이 일정한 방향으로 나아가는 경향. 주식시장분석이나 판매예측등에서 어느 기간동안 같은 방향으로 움직이는 경향을 의미.
# - 추세선:추세를 직선이나 곡선 형태로 차트에서 나타내는 선(어느 정도 평균과 분산 확인 가능).

X11()
ts.plot(WWWusage, type="l", col="red")

# 다중 시계열 자료 시각화

# 단계1 : 데이터 셋 가져오기
data("EuStockMarkets") # 유럽(1991~1998년)의 주요 주식의 주가지수 일일 마감 가격.

head(EuStockMarkets) # DAX(독일) SMI(스위스) CAC(프랑스) FTSE(영국)
str(EuStockMarkets) # Time-Series [1:1860, 1:4]

# 단계2 : 데이터프레임으로 변환
EuStock <- data.frame(EuStockMarkets)
EuStock
head(EuStock)

# 단계3 : 단일 시계열 데이터 추세선
X11()
plot(EuStock$DAX[1:1000], type = "l", col="red") # 선 그래프 시각화

# 단계4 : 다중 시계열 데이터 추세선
plot.ts(cbind(EuStock$DAX[1:1800], EuStock$SMI[1:1800]), main="주가지수 추세선")



##########################
# 시계열요소분해 시각화
##########################

## 시계열 요소 분해 시각화

# 단계1 : 시계열 자료 준비

data <- c(45,56,45,43,69,75,58,59,66,64,62,65,
          55,49,67,55,71,78,71,65,69,43,70,75,
          56,56,65,55,82,85,75,77,77,69,79,89)
length(data) # 36

# 단계2 : 시계열자료 생성 : 시계열 자료 형식으로 객체 생성
tsdata <- ts(data, start = c(2016, 1), frequency = 12)
tsdata # 2016~2018

# 단계3 : 추세선 확인
par(mfrow=c(1,1))
ts.plot(tsdata) # plot(tsdata)와 동일함.

# 단계4 : 시계열 분해- stl():계절요소, 추세, 잔차 모두 제공.
plot(stl(tsdata, "periodic")) # periodic : 주기

# 단계5 : 시계열 분해와 변동 요인 제거
m <- decompose(tsdata) # decompose()함수 이용 시계열 분해
attributes(m) # 변수 보기
plot(m) # 추세요인, 계절요인, 불규칙 요인이 포함된 그래프.
plot(tsdata - m$seasonal) # 계절요인을 제거한 그래프.


# 단계6 : 추세요인과 불규칙요인 제거
x11()
plot(tsdata - m$trend) # 추세요인 제거 그래프
plot(tsdata - m$seasonal - m$trend) # 불규칙 요인만 출력.


##################################
# 자기상관함수/ 부분자기상관함수
##################################
# 자기상관함수(Auto Correlation Function) # ACF
# 부분자기상관함수(Partial Auto Correlation Function) # PACF

# 자기상관성: 자기 상관계수가 유의미한가를 나타내는 특성.
# 자기상관계수: 시계열 자료에서 시차(lag)를 일정하게 주는 경우 얻어지는 상관 계수.
# 시차(lag) - 일정 주기를 가짐

# 단계1 : 시계열자료 생성
input <- c(3180,3000,3200,3100,3300,3200,3400,3550,3200,3400,3300,3700) # 의미가 없다 # 데이터가 드러나게 할 수 있게 부각시키기 위해 임의로 만든 숫자
length(input) # 12

tsdata <- ts(input, start = c(2015, 2), frequency = 12) # Time Series # 2015년 2월 ~ 2016년 1월까지의 의미를 가지는 데이터셋, 주기는 12
tsdata

# 단계2 : 자기상관함수 시각화
x11()
acf(na.omit(tsdata), main="자기상관함수", col="red")

# 단계3 : 부분자기상관함수 시각화
pacf(na.omit(tsdata), main="부분자기상관함수", col="red")


##################################
# 추세 패턴 찾기 시각화
##################################
# 추세패턴:시계열 자료가 증가 또는 감소하는 경향이 있는지 알아보고, 증가나 감소의 경향이 선형인지 비선형인지를 찾는 과정.

## 시계열 자료의 추세 패턴 찾기 시각화

# 단계1 : 시계열 자료 생성
input <- c(3180,3000,3200,3100,3300,3200,3400,3550,3200,3400,3300,3700)

# Time Series
tsdata <- ts(input, start = c(2015, 2), frequency = 12)

# 단계2 : 추세선 시각
plot(tsdata, type="l", col="red")


# 단계3 : 자기상관 함수 시각화
acf(na.omit(tsdata), main="자기상관함수", col="red")

# 단계4 : 차분 시각화
plot(diff(tsdata, differences=1)) # 1 주기를 가지고 출력 # 평균 0을 기준으로 낮아지고 올라가고



##################################
# 평활법(Smoothing Method)
##################################

# - 수학/통계적 방법의 분석이 아닌 시각화를 통한 직관적 방법의 데이터 분석 방법.
# - 단기 예측. 1개(일변량)

# - 시계열 자료의 체계적인 자료의 흐름을 파악하기 위해서 과거 자료의 불규칙적인 변동을 제거하는 방법.

# - 이동 평균(Moving Average) : 시계열 자료를 대상으로 일정한 기간의 자료를 평균으로 계산하고, 이동 시킨 추세를 파악하여 추세를 예측하는 분석 기법.

# 단계1: 시계열  자료 생성
data <- c(45,56,45,43,69,75,58,59,66,64,62,65,
          55,49,67,55,71,78,71,65,69,43,70,75,
          56,56,65,55,82,85,75,77,77,69,79,89)
length(data) # 36

tsdata <- ts(data, start = c(2016, 1), frequency = 12)

tsdata

# 단계2 : 평활 관련 패키지 설치
install.packages("TTR")
library(TTR)

# 단계3 : 이동평균법으로 평활 및 시각화
par(mfrow=c(2,2))
plot(tsdata, main="원 시계열 자료") # 시계열 자료 시각화
plot(SMA(tsdata, n=1), main="1년 단위 이동평균법으로 평활") # Simple Moving Average
plot(SMA(tsdata, n=2), main="2년 단위 이동평균법으로 평활")
plot(SMA(tsdata, n=3), main="3년 단위 이동평균법으로 평활")

par(mfrow=c(1,1)) # 1행 1열로 변경했을 뿐.

##################################
## ARIMA 모형 시계열 예측
##################################

## 정상성시계열의 비계절형 # 비계절성은 일정한 주기를 가지고 있지는 않다.

# 단계1: 시계열자료 특성분석
# (1) 데이터 준비
input <- c(3180,3000,3200,3100,3300,3200,3400,3550,3200,3400,3300,3700)

# (2) 시계열 객체 생성(12개월:2015년 2월 ~ 2016년 1월)
tsdata <- ts(input, start = c(2015, 2), frequency = 12) # Time Series = ts
tsdata

# (3) 추세선 시각화(정상성시계열 vs 비정상성시계열)
x11()
plot(tsdata, type="l", col='red') # type='l'ine


# 단계2:정상성시계열 변환 
par(mfrow=c(1,2))
ts.plot(tsdata)
diff <- diff(tsdata) # 차분
plot(diff)

# 단계3: 모형 식별과 추정
install.packages('forecast')
library(forecast)

arima <- auto.arima(tsdata) # 시계열 데이터 이용. # ARIMA 모형을 통해 적합한 모델을 알려줌
arima
# ARIMA(1,1,0) - 1번 차분한 결과가 정상성시계열의 AR(1) 모형으로 식별.


# 단계4: 모형 생성(모델을 찾음)
model <- arima(tsdata, order=c(1,1,0)) # order에 ARIMA 결과를 그대로 써주면 됨.
model # model은 우리가 원하는 모델이다.


# 단계5: 모형 진단(모형 타당성 검정)
# (1) 자기상관함수(AutoCorrelationFunction)에 의한 모형 진단 # 일정 간격을 찾아가는 것.
tsdiag(model) # TimeSeriesDialog # p-value값이 0 이상으로 분포하면 정상값이다.

# (2) Box-Ljung에 의한 잔차항 모형 진단
Box.test(model$residuals, lag = 1, type = "Ljung") # 시차값을 지정해줌.
# p-value = 0.7252 > 0.05 : 결론) 모형이 통계적으로 적절하다.


# 단계6 : 미래 예측(업무 적용)
fore <- forecast(model) # 향후 2년 예측
fore
x11()
par(mfrow=c(1,2))
plot(fore) # 향후 24개월 예측치 시각화

model2 <- forecast(model, h = 6) # 향후 6개월 예측치 시각화
plot(model2)


## 정상성시계열의 계절형 # 계절형은 주기적이다. 데이터가 짧건 길건 상관없이 주기성을 가지고 있다.

# 단계1 : 시계열자료 특성분석

# (1) 데이터 준비 # 추위에 기반하는 특징을 가지는 주기를 가지고 있다. 반드시 똑같은 개념은 아니다.
data <- c(55,56,45,43,69,75,58,59,66,64,62,65,
          55,49,67,55,71,78,61,65,69,53,70,75,
          56,56,65,55,68,80,65,67,77,69,79,82,
          57,55,63,60,68,70,58,65,70,55,65,70)
length(data)# 48

# (2) 시계열자료 생성
tsdata <- ts(data, start=c(2016, 1),frequency=12)

#tsdata <- AirPassengers # 실제 data 적용.
tsdata
head(tsdata)
tail(tsdata)

# (3) 시계열요소분해 시각화
ts_feature <- stl(tsdata, s.window="periodic")
plot(ts_feature)

# 단계2 : 정상성시계열 변환
par(mfrow=c(1,2))
ts.plot(tsdata)
diff <- diff(tsdata)
plot(diff) # 차분 시각화

# 단계3 : 모형 식별과 추정
library(forecast)
ts_model2 <- auto.arima(tsdata)
ts_model2 # ARIMA(0,1,1)(1,1,0)[12] / ARIMA(2,1,1)(0,1,0)[12]

# 단계4 : 모형 생성
model <- arima(tsdata, c(0,1,1), seasonal = list(order = c(1,1,0)))
#model <- arima(tsdata, c(2,1,1), seasonal = list(order = c(0,1,0)))
model

# 단계5 : 모형 진단(모형 타당성 검정)
# (1) 자기상관함수에 의한 모형 진단
tsdiag(model)

# (2)Box-Ljung에 의한 잔차항 모형 진단
Box.test(model$residuals, lag=1, type = "Ljung") # p-value = 0.5618 / p-value = 0.9879

# 단계6 : 미래 예측
par(mfrow=c(1,2))
fore <- forecast(model, h=24) # 2년 예측
plot(fore)
fore2 <- forecast(model, h=6) # 6개월 예측
plot(fore2)

