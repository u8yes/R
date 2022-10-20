# chap12_CrossTableChiSquare

#######################################
##  Chapter12. 교차분석과 카이제곱검정
#######################################

## 1. 교차분석(Cross Table Analyze)

# 1.1 데이터프레임 생성

# 변수 리코딩과 데이터프레임 생성

# 1) 실습 파일 가져오기
data <- read.csv("D:/heaven_dev/workspaces/R/data/cleanDescriptive.csv", header = T)
View(data)
head(data) # 변수 확인

# 2) 변수 리코딩
x <- data$level2 # 리코딩 변수 이용(학력수준)
y <- data$pass2  # 리코딩 변수 이용(합격/불합격)
x; y  # 부모학력수준(x) -> 자녀대학진학여부(y)

# 3) 데이터프레임 생성
result <- data.frame(Level=x, Pass=y) # 데이터 프레임 생성 - 데이터 묶음.
dim(result) # 차원보기(248,2)
head(result)
View(result)


# 1.2 교차분석

# 1) 교차 분할표 작성
table(result) # 빈도보기
#          Pass
#Level      실패 합격
#고졸       40   49
#대졸       27   55
#대학원졸   23   31

# 2) 교차분할표 생성을 위한 패키지 설치
install.packages("gmodels")
library(gmodels)


# 3) 패키지를 이용한 교차 분할표 생성
CrossTable(x, y)

# 교차테이블에 카이검정 적용
CrossTable(x, y, chisq = T) # 카이제곱분석 = TRUE
#Pearson's Chi-squared test
#----------------------------------------------------
#Chi^2 =  2.766951     d.f.(자유도) =  2(2행*1열)     p =  0.2507057(유의확률값, 기준:0.05)


## 2. 카이제곱 검정

# 1) 일원카이제곱 검정
#  (1) 적합성 검정
#-------------------------
# 귀무가설(영가설): 기대치와 관찰치는 차이가 없다. : p >= 알파
#     예) 주사위는 게임에 적합하다.

# 연구가설(대립가설): 기대치와 관찰치는 차이가 있다. : p < 알파
#     예) 주사위는 게임에 적합하지 않다.
#-------------------------

# 60회 주사위를 던져서 나온 관측도수/기대도수
# 기대도수 : 10, 10, 10, 10, 10, 10
# 관측도수 :  4,  6, 17, 16,  8,  9

chisq.test(c(4,6,17,16,8,9))
# X-squared = 14.2 > 11.07, df = 5, p-value = 0.01439


# (2) 선호도 검정(분석)
#----------------------------------------------------
# 귀무가설:기대치와 관찰치는 차이가 없다. : p >= 알파
#   예) 스포츠음료의 선호도에 차이가 없다.
# 연구가설:기대치와 관찰치는 차이가 있다. : p < 알파
#   예) 스포츠음료의 선호도에 차이가 있다.
#----------------------------------------------------

# 5개 제품의 스포츠 음료에 대한 선호도에 차이가 있는지 검정
data <- textConnection(
  "스포츠음료종류  관측도수
      1               41
      2               30
      3               51
      4               71
      5               61
  ")
class(data)
x <- read.table(data, header = T)
x # 스포츠음료종류   관측도수
str(x)

chisq.test(x$관측도수)
# X-squared = 20.488, df = 4, p-value = 0.0003999


# 2) 이원카이제곱 검정 - 교차분할표 이용

#  (1) 독립성 검정(관련성 검정)
#      : 동일 집단의 두 변인을 대상으로 관련성이 있는가? 없는가?를 검정하는 방법.

# 귀무가설(H0):부모의 학력 수준과 자녀의 대학 진학 여부는 관련성이 없다.
# 연구가설(H1):부모의 학력 수준과 자녀의 대학 진학 여부는 관련성이 있다.


data <- read.csv("D:/heaven_dev/workspaces/R/data/cleanDescriptive.csv", header = T)

# 독립변수(x) = 설명변수, 종속변수(y) = 반응 변수 생성
x <- data$level2 # 부모의 학력수준
y <- data$pass2  # 자녀의 대학 진학 여부

CrossTable(x, y, chisq = T)


#  (2) 동질성 검정
#      : - 두 집단의 분포가 동일한가? 분포가 동일하지 않는가?를 검정하는 방법.
#      : - 즉, 동일한 분포를 가지는 모집단에서 추출된 것인지를 검정하는 방법.

# 귀무가설:교육방법에 따라 만족도에 차이가 없다.
# 연구가설:교육방법에 따라 만족도에 차이가 있다.

# 1. 파일 가져오기
data <- read.csv("D:/heaven_dev/workspaces/R/data/homogenity.csv", header = T)
View(data)

table(data$method) # 교육방법
table(data$survey) # 만족도

# 전처리 - 결측치/ method와 survey 변수만 서브셋 생성
data <- subset(data, !is.na(survey), c(method, survey))
data
length(data$survey) # 150

# 2. 변수리코딩 - 코딩 변경

# method2 필드 추가
data$method2[data$method == 1] <- "방법1"
data$method2[data$method == 2] <- "방법2"
data$method2[data$method == 3] <- "방법3"


# survey2 필드 추가
data$survey2[data$survey == 1] <- "1. 매우만족"
data$survey2[data$survey == 2] <- "2. 만족"
data$survey2[data$survey == 3] <- "3. 보통"
data$survey2[data$survey == 4] <- "4. 불만족"
data$survey2[data$survey == 5] <- "5. 매우불만족"


# 3. 교차분할표 작성
table(data$method2, data$survey2) # 교차표 생성 -> table(행, 열)
#         1. 매우만족 2. 만족 3. 보통 4. 불만족 5. 매우불만족
#방법1           5       8      15        16             6
#방법2           8      14      11        11             6
#방법3           8       7      11        15             9

# 4. 교차분할표 생성
CrossTable(data$method2, data$survey2, chisq = T)


# 5. 동질성 검정 - 모수 특성치에 대한 추론 검정
chisq.test(data$method2, data$survey2)
# data:  data$method2 and data$survey2
# X-squared = 6.5447, df = 8, p-value = 0.5865


# 6. 동질성 검정 해석
# p-value = 0.5865 > α(알파: 0.05) : 귀무가설 채택
# 교육방법에 따라 만족도에 차이가 없다.









