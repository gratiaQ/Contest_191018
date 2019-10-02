library(dplyr)

sales_pop <- read.csv('상권_유동인구.csv')
sales_live <- read.csv('상권_상주인구.csv')
sales_work <- read.csv('상권_직장인구.csv')
sales_sales <- read.csv('상권_추정매출.csv')
sales_xy <- read.csv('상권_상권영역.csv')
sales_change <- read.csv('상권_변화지표.csv')
sales_null <- read.csv('상권_공실률.csv')
sales_rent <- read.csv('상권-임대료.csv')


sales_sales <- sales_sales %>% group_by(Date, 상권_코드_명) %>% summarise(당월_매출_금액 = sum(당월_매출_금액), 점포수 = sum(점포수))

df = merge(sales_pop, sales_live, by= c('Date', '상권_코드_명'))
# df_count += 1
df = merge(df, sales_work, by= c('Date', '상권_코드_명'))
df = merge(df, sales_xy, by= c('상권_코드_명'))
df = merge(df, sales_change, by= c('Date', '상권_코드_명'))
df = merge(df, sales_sales, by= c('Date', '상권_코드_명'))
df = merge(df, sales_null, by= c('Date', '행정동_코드'))
df = merge(df, sales_rent, by= c('Date', '상권'))

write.csv(x = df, file = 'Seoul_Vacancy_Rate_v1.csv', row.names =FALSE)
