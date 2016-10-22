---
title: "Singapore Fixed Broadband Plans and Prices Data Visualizations"
author: "Author: yb"
date: "Sep 25, 2016"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

#### Source of Data
The Fixed Broadband Plans and Prices dataset is downloaded from <https://data.gov.sg>. It can be downloaded via this URL <https://data.gov.sg/dataset/fixed-broadband-plans-and-prices?view_id=831f2e2d-7acf-44c4-8537-988a8a52e3b8&resource_id=70e20cb2-f7a7-4e2d-bd95-47575b4dcbe6>.

#### Footnotes from the website
Prices listed here are lowest available monthly subscription fees gleaned from the respective service providers' websites. Only fixed residential broadband plans without usage limits are listed. Additional discounts or bundling may be available through your service provider.

```{r , echo=F,message=F}
library(data.table)
library(lubridate)
library(DT)
library(plotly)
library(ggplot2)
library(zoo)
library(dplyr)
```

```{r , echo=F,message=F}
setwd("C:/Users/user/Documents/R working folder/SG Fixed Broadband Plans and Prices")
bb = read.csv("fixed-broadband-plans-and-prices.csv",stringsAsFactors = F)
setDT(bb)

# Data Cleaning
bb$date_of_retrieval_ = dmy(bb$date_of_retrieval_)
bb$max_speed[bb$max_speed=="na"]=NA
bb$price_of_plan[bb$price_of_plan=="na"]=NA
bb$price_per_mbps[bb$price_per_mbps=="na"]=NA
bb$month2 = ymd(paste(bb$month,"-01",sep=""))

# Graph Functions
PriceGraph = function(op) {
p = ggplot(bb[operator==op,list(operator,Month=month2,price_of_plan,plan,connection_type)],aes(x=Month,y=price_of_plan,colour=plan,group=plan)) + 
  geom_line() +
  labs(title=paste(op,"Plans Price"),x = "") +
  theme(legend.position = "none") +
  facet_grid(connection_type ~ .,scales="free_y") + 
  scale_x_date(date_labels = "%b%y",date_breaks = "3 months")
ggplotly(p)
}

PricePerMbpsGraph = function(op) {
p = ggplot(bb[operator==op,list(operator,Month=month2,price_per_mbps,plan,connection_type)],aes(x=Month,y=price_per_mbps,colour=plan,group=plan)) + 
  geom_line() +
  labs(title=paste(op,"Plans Price Per Mbps"),x = "") +
  theme(legend.position = "none") +
  facet_grid(connection_type ~ .,scales="free_y") + 
  scale_x_date(date_labels = "%b%y",date_breaks = "3 months")
ggplotly(p)
}
```

<br><br>

Let's take a look at this dataset.
```{r , echo=F,message=F}
datatable(bb %>% select(-month2), options = list(pageLength = 5))
```

<br><br>

The pricing data is based on 6 Telco companies and 2 year contract basis.
```{r , echo=F,message=F}
unique(bb$operator)
unique(bb$contract_duration)
```

<br><br>

### Plans Price by Operator {.tabset}
#### Singnet
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PriceGraph("Singnet")
```

#### Starhub
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PriceGraph("Starhub")
```

#### M1
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PriceGraph("M1")
```

#### MyRepublic
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PriceGraph("MyRepublic")
```

#### Super Internet
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PriceGraph("Super Internet")
```

#### Viewqwest
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PriceGraph("Viewqwest")
```

### Plans Price Per Mbps by Operator {.tabset}
#### Singnet
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PricePerMbpsGraph("Singnet")
```

#### Starhub
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PricePerMbpsGraph("Starhub")
```

#### M1
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PricePerMbpsGraph("M1")
```

#### MyRepublic
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PricePerMbpsGraph("MyRepublic")
```

#### Super Internet
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PricePerMbpsGraph("Super Internet")
```

#### Viewqwest
```{r , echo=F,message=F,warning=F,fig.height=9,fig.width=8}
PricePerMbpsGraph("Viewqwest")
```



