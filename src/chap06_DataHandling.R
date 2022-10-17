# chap06_DataHandling # Day29; 20221017

##############################
# chapter06. 데이터 조작
##############################

## 1. dplyr 패키지 활용
#  - 기존 plyr 패키지는 R 언어로 개발되었으나(인터프리터 방식 언어 - 바로 실행되는 구조, 인간 중심이라서 성능이 떨어짐), dplyr 패키지는 C++언어로 개발되어 처리 속도를 개선(compile 언어 - 실행할 때는 컴퓨터가 이해할 수 있는 명령어로 처리).
# c++ 언어는 Java와 80% 정도가 유사함, 둘 다 C 언어에서 나옴.

install.packages(c("dplyr", "hflights")) # 2개를 설치할 수 있음
library(dplyr) 
library(hflights)

hflights
str(hflights) # 'data.frame':	227496 obs. of  21 variables:

# 1.1 콘솔 창의 크기에 맞게 데이터 추출
#   : 콘솔 창 안에서 한 눈으로 파악하기
hflights_df <- tbl_df(hflights) # tbl_df 가독성있게 열로 분류해서 보여줌
hflights_df

# 1.2 조건에 맞는 데이터 필터링

# hflights_df를 대상으로 1월2일 데이터 추출하기.
filter(hflights_df, Month==1 & DayofMonth==2) # AND
# 678 x 21

# 1월 혹은 2월 데이터 추출
filter(hflights_df, Month==1 | Month==2) # OR
# 36,038 x 21

# 1.3 컬럼으로 데이터 정렬
# 년, 월, 출발시간, 도착시간 순으로 오름차순 정렬
arrange(hflights_df, Year, Month, DepTime, ArrTime)

# 년, 월, 출발시간, 도착시간 순으로 내림차순 정렬
arrange(hflights_df, Year, Month, desc(DepTime), ArrTime)


# 1.4 컬럼으로 데이터 검색
# hflights_df에서 년, 월, 출발시간, 도착시간 컬럼 검색하기.
select(hflights_df, Year, Month, DepTime, ArrTime) # 4개의 컬럼(열) 선택.

# 컬럼의 범위 지정하기.
select(hflights_df, Year:ArrTime) # 행은 다 보여줌

# 컬럼의 범위 제외 : Year부터 DayOfWeek 제외
select(hflights_df, -(Year:DayOfWeek)) # '-'는 제외하는 것을 의미


# 1.5 데이터 셋에 컬럼 추가

# 출발 지연 시간과 도착 지연 시간과의 차이를 계산하는 컬럼 추가하기.
mutate(hflights_df, gain = ArrDelay - DepDelay,
       gain_per_hour = gain/(AirTime/60))

# mutate() 함수에 의해서 추가된 컬럼 보기
select(mutate(hflights_df, gain = ArrDelay - DepDelay,
              gain_per_hour = gain/(AirTime/60)),
       Year, Month, ArrDelay, DepDelay, gain, gain_per_hour)

# 1.6 요약 통계치 계산

# 비행시간 평균 계산하기.
summarise(hflights_df, avgAirTime=mean(AirTime, na.rm = T))

# 데이터 셋의 관측치 길이, 출발 지연 시간 평균 구하기
summarise(hflights_df, cnt=n(), delay=mean(DepDelay, na.rm = T))

# 도착시간(ArrTime)의 표준편차와 분산 계산하기
summarise(hflights_df, arrTimeSd=sd(ArrTime, na.rm = T),
          arrTimeVar=var(ArrTime, na.rm = T))

# 1.7 집단변수 대상 그룹화

# 집단변수를 이용하여 그룹화하기
species <- group_by(iris, Species)
str(species)
species

planes <- group_by(hflights_df, TailNum) # TailNum(항공기 일련번호)
delay <- summarise(planes, count=n(), dist=mean(Distance, na.rm = T), delay=mean(ArrDelay, na.rm = T))
delay <- filter(delay, count > 20, dist < 2000)
delay

install.packages("ggplot2")
library(ggplot2)
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size=count), alpha=1/2) +
  geom_smooth() +
  scale_size_area()

# 파이프(pipe)연산자 이용하기
getwd()
setwd("D:/heaven_dev/workspaces/R/data")

exam <- read.csv("csv_exam.csv")
exam

# filter()
# %>% : 파이프(pipe) 연산자 -> 단축키(ctl+shift+m)
exam %>% filter(class==1) # filter(exam, class==1)
# %>% %>% %>% %>% %>% %>% %>% %>% %>% %>% %>% %>% %>% %>% %>% 
# select()
exam %>% select(class, math, english)

# class가 1인 행만 추출한 다음 english 추출
exam %>% filter(class==1) %>% select(english)
# 혹은 줄바꿈해서
exam %>%
  filter(class==1) %>%
  select(english)

# 주의
#exam
#    %>% filter(class==1)
#    %>% select(english)


# 과목별 총점과 총점 기준 정렬해서 상위 6개(head실행) 데이터만을  출력.
exam %>%
  mutate(total=math+english+science) %>%
  arrange(desc(total)) %>%
  head


# join 실습용 데이터프레임 생성
df1 <- data.frame(x = 1:5, y = rnorm(5)) # 정규분포 rnorm
df2 <- data.frame(x = 2:6, z = rnorm(5)) # 정규분포를 따르는 데이터셋에서 5개를 random으로 꺼내라

df1; df2

# inner_join 하기
inner_join(df1, df2, by = 'x') # x를 기준으로 해서 join해라
left_join(df1, df2, by = 'x')
right_join(df1, df2, by = 'x')
full_join(df1, df2, by = 'x')

# 두 개의 데이터프레임을 행 단위로 합치기
df1 <- data.frame(x = 1:5, y = rnorm(5))
df2 <- data.frame(x = 6:10, y = rnorm(5))

df1; df2

# 데이터프레임 행단위 합치기
bind_rows(df1, df2)

# 데이터프레임 열단위 합치기
bind_cols(df1, df2)



## 2. reshape2 패키지 활용
# 2.1 긴 형식을 넓은 형식으로 변경

# 패키지 설치
install.packages('reshape2')
library(reshape2)

# 데이터 가져오기
getwd()
data <- read.csv("data.csv")
data
View(data)

# 긴 형식 -> 넓은 형식으로 변경
help(dcast)
wide <- dcast(data, Customer_ID ~ Date, sum) # sum이 총합
wide
View(wide)

# 파일 저장 및 읽기
setwd("D:/heaven_dev/workspaces/R/output")
write.csv(wide, 'wide.csv', row.names = F)

wide_read <- read.csv('wide.csv')
colnames(wide_read) <- c('id','day1','day2','day3','day4','day5','day6','day7')
wide_read


# 2.2 넓은 형식을 긴 형식으로 변경

# melt() 함수 이용
long <- melt(wide_read, id='id') # id를 기준으로 긴 형식으로 변경해주라
long

# 컬럼명 수정
colnames(long) <- c("id", "Date", "Buy")
head(long)

# reshape2 패키지의 smiths 데이터 셋 구조 변경하기
data("smiths")
smiths

# wide -> long
long <- melt(smiths, id=1:2)
long

# long -> wide
dcast(long, subject + time ~ ...)


# 2.3 3차원 배열 형식으로 변경

# airquality 데이터 셋 구조 변경
data("airquality") # New York의 대기에 대한 질
View(airquality)
str(airquality) # 'data.frame':	153 obs. of  6 variables:

# 컬럼명 대문자 일괄 변경
names(airquality) <- toupper(names(airquality)) # 컬럼명 대문자 변경.
head(airquality)

# 월과 일 컬럼으로 나머지 4개 컬럼을 묶어서 긴 형식 변경
air_melt <- melt(airquality, id=c("MONTH", "DAY"), na.rm = T)
head(air_melt) # MONTH DAY variable value

# 일과 월 컬럼으로 variable 컬럼을 3차원 형식으로 분류
names(air_melt) <- tolower(names(air_melt)) # 컬럼명 소문자 변경
acast <- acast(air_melt, day~month~variable) # 3차원 구조 변경 # day행month열variable면
acast
class(acast) # "array"


# 월 단위 variable(대기관련 컬럼) 컬럼 합계
acast(air_melt, month~variable, sum) # array cast = acast?

