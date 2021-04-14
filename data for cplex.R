#customers 500
#hubs 50
#sorting facility 20
#logistics agent 150
#vehicle 70
#products 800
#capacity of regional hubs
set.seed(100)
Bj<-floor(runif(50,min = 60,max=80))
#capacity of sorting facilities
set.seed(100)
Bs<-floor(runif(20,min = 300,max=400))
# cost of operating regional hub
# it is dependent on the capacity of the regional hub
fj=20*Bj
# cost of operating sorting facilities
# it is dependent on the capacity of the sorting facilities
fs=50*Bs
#distance between customers and regional hubs
set.seed(100)
dij<-matrix(abs(rnorm(500*50,mean=7,sd=6)),500,50,byrow = TRUE)
head(dij)
#rownames(dij)<-c(paste("customer",c(1:500),sep=" "))
min(dij)
max(dij)

#distance between regional hubs and sorting centres
set.seed(100)
djs<-matrix(abs(rnorm(50*20,mean=18,sd=9)),50,20,byrow = TRUE)
tail(djs)
min(djs)
max(djs)

# max distance that can be served by a logistics agent
set.seed(100)
lk<- (rnorm(150,mean = 10,sd=2)) 
min(lk)
max(lk)
# max distance that can be served by a logistics vehicle
set.seed(100)
lv<- (rnorm(70,mean = 50,sd=4)) 
min(lv)
max(lv)

#salary of the logistic agent per trip
#it is dependent on the max distance capacity of the logistics agent,let the realtion be rent=max_distnace(lv)*1.5

salaryk<-lk*5

#rent per trip of logistic vehicle
#it is dependent on the max distance capacity of the logistics vehicle,let the realtion be rent=max_distnace(lv)*3

rentv<-lv*20

#cost of assigning logistic agents from customer to hubs
# it is dependent on the distance between customer and hub and salary of the logistics agent
#cijk<- salaryk*0.2+ dij*2.5

cijk<-array(0,dim=c(500,50,150))
for (i in 1:500){
  for (j in 1:50){
    for (k in 1:150){
      cijk[i,j,k]=2.5*dij[i,j]+0.2*salaryk[k]
    }
  }
}

#cost of assigning vehicles from hubs to sorting facilities
# it is dependent on the distance between hub and sorting facility and rent of the vehicle
#cjsv<- rentv*0.5+ djs*6.5

cjsv<-array(0,dim=c(50,20,70))
for (j in 1:50){
  for (s in 1:20){
    for (v in 1:70){
      cjsv[j,s,v]=6.5*djs[j,s]+0.5*rentv[v]
    }
  }
}

#product wise cost of transporting products from the customers to the regional hubs
#it will depend on the cost of assigning logistics agent from the customers to the regional hubs and the product wise return cost(p) dependent on the type of the product
#cp(i)j<- p*2+cijk

set.seed(100)
p<-(rnorm(6,mean = 3.5,sd=1)) 
set.seed(100)
cust1<-  (sample(1:5,5,replace = F))
cust2<-  (sample(1:5,1,replace = T))
cust<-append(cust1,cust2)

library(dplyr)
df=bind_cols(as.data.frame(cust),as.data.frame(p))


cpijk<-array(0,dim=c(6,5,3,3))
for (p in 1:6){
  for (i in 1:5){
    for (j in 1:3){
      for (k in 1:3){
        cpijk[p,i,j,k]=2*df$p[p]+cijk[df$cust[p],j,k]
        
      }
    }
  }
  
  
}
##product wise cost of transporting products from the regional hubs to the sorting facilities
# it will depend on the cost of assigning  logistics vehicles from the regional hubs to the sorting facilities and the product wise return cost(p1) dependent on the type of the product
#cp(i)j<- p1*4+cjsv

set.seed(100)
p1<-(rnorm(6,mean = 4.5,sd=2)) 


cpjsv<-array(0,dim=c(6,3,2,2))
for (p in 1:6){
  for (j in 1:3){
    for (s in 1:2){
      for (v in 1:2){
        cpjsv[p,j,s,v]=4*p1[p]+cjsv[j,s,v]
        
      }
      
      
    }
  }
}

















