/*********************************************
 * OPL 12.6.0.0 Model
 * Author: AYAN
 * Creation Date: Apr 30, 2020 at 11:50:56 AM
 *********************************************/
/*********************************************
 * OPL 12.6.0.0 Model
 * Author: AYAN
 * Creation Date: Apr 29, 2020 at 4:09:15 PM
 *********************************************/

 
/*********************************************
 * OPL 12.6.0.0 Model
 * Author: AYAN
 * Creation Date: Apr 27, 2020 at 2:18:49 PM
 *********************************************/
int p=...;
int i=...;
int j=...;
int s=...;
int k=...;
int v=...;

range product=1..p;
range customer=1..i;
range hub=1..j;
range sorting=1..s;
range agent=1..k;
range vehicle=1..v;

// Decision variables
dvar boolean y[hub];
dvar boolean Y[sorting];
dvar boolean z[customer][hub][agent];
dvar boolean Z[hub][sorting][vehicle];
dvar boolean x[product][customer][hub];
dvar boolean X[product][hub][sorting][vehicle];

// Parameters
int fj[hub]=...;
int fs[sorting]=...;
float cijk[customer][hub][agent]=...;
float cjsv[hub][sorting][vehicle]=...;
float cpij[product][customer][hub]=...;
float cpjsv[product][hub][sorting][vehicle]=...;
float dij[customer][hub]=...;
float djs[hub][sorting]=...;
float Bs[sorting]=...;
float Bj[hub]=...;
float Lk[agent]=...;
float Lv[vehicle]=...;
int Pi[customer]=...;
int cxp[customer][product]=...;
//int jmax=...;
//int smax=...;

// Objective Function
minimize sum(j in hub)fj[j]*y[j]+sum(s in sorting)fs[s]*Y[s]+sum(i in customer)sum(j in hub)sum(k in agent)z[i][j][k]*cijk[i][j][k]+sum(j in hub)sum(s in sorting)sum(v in vehicle)cjsv[j][s][v]*Z[j][s][v]+sum(p in product)sum(i in customer)sum(j in hub)x[p][i][j]*cpij[p][i][j]+sum(p in product)sum(j in hub)sum(s in sorting)sum(v in vehicle)X[p][j][s][v]*cpjsv[p][j][s][v];


// constraints
subject to{
  forall(k in agent)
    ct:
      sum(i in customer)sum(j in hub)
        z[i][j][k]>=0;
    
    
  forall(i in customer)
    ca:
      sum(j in hub)sum(k in agent)
        z[i][j][k]>=1;
    
  forall(v in vehicle)
    cb:
      sum(j in hub)sum(s in sorting)
        Z[j][s][v]>=0;
   
  forall(v in vehicle)
    sum(j in hub)sum(s in sorting)
      
      Z[j][s][v]<=1;       
  forall(j in hub)
    cd:
      sum(s in sorting)sum(v in vehicle)
        Z[j][s][v]>=1;
  forall(k in agent)
    ce:
      sum(i in customer)sum(j in hub)
        dij[i][j]*z[i][j][k]<=Lk[k];
  forall(v in vehicle)
    cf:
      sum(j in hub)sum(s in sorting)
        djs[j][s]*Z[j][s][v]<=Lv[v];
  forall(j in hub)
    cg:
      sum(p in product)sum(i in customer)
        x[p][i][j]<=Bj[j];
  
  forall(j in hub)
    
    c1: 
      sum(p in product)sum(s in sorting)sum(v in vehicle)
        X[p][j][s][v]<=Bj[j];
        
        
   forall(s in sorting)
     sum(p in product)sum(j in hub)sum(v in vehicle)
       X[p][j][s][v]<=Bs[s];     
  
  forall(j in hub)
    c2:
      sum(p in product)sum(i in customer)x[p][i][j]==sum(p in product)sum(s in sorting)sum(v in vehicle)X[p][j][s][v];
        
  //forall(j in hub)
    //c3:
      //  sum(j in hub)y[j]<=3;

  sum(j in hub)y[j]>=sum(s in sorting) Y[s];
  
  sum(j in hub)y[j]==3;
  
  sum(s in sorting)Y[s]==2;
       
  //sum(s in sorting)Y[s]>=1;
              
 
 sum(p in product)sum(i in customer)sum(j in hub)
   x[p][i][j]==p;
   
 sum(p in product)sum(j in hub)sum(s in sorting)sum(v in vehicle)
   X[p][j][s][v]==p;
   
 forall(p in product)
    forall(i in customer)
      forall(j in hub)
        x[p][i][j]>=0;        
 forall(p in product)
    forall(j in hub)
      forall(s in sorting)
        forall( v in vehicle)
         X[p][j][s][v]>=0;        
  
  forall(i in customer)
    forall(j in hub)
      forall(k in agent)
        z[i][j][k]<=y[j];
        
  forall(j in hub)
    forall(s in sorting)
      forall(v in vehicle)
        Z[j][s][v]<=Y[s];
        
  forall(j in hub)
    forall(s in sorting)
      forall(v in vehicle)
        Z[j][s][v]<=y[j];
  forall(p in product)
    forall(i in customer)
      forall(j in hub)
        x[p][i][j]<=y[j];
        
 
  forall(p in product)
    forall(j in hub)
      forall(s in sorting)
        forall(v in vehicle)
          
          X[p][j][s][v]<=Y[s];
        
 forall(p in product)
    forall(j in hub)
      forall(s in sorting)
        forall(v in vehicle)
          X[p][j][s][v]<=y[j];
        
        
 forall(p in product)
   sum(i in customer)sum(j in hub)
     x[p][i][j]==1;
         
 forall(p in product)
   sum(j in hub)sum(s in sorting)sum(v in vehicle)
     X[p][j][s][v]==1;
  
 forall(i in customer)
   sum(p in product)sum(j in hub)
     x[p][i][j]>=1;
 
 forall(i in customer)
   sum(p in product)sum(j in hub)
      x[p][i][j]==Pi[i];
 
 forall(p in product)
   forall(i in customer)
     forall(j in hub)
       x[p][i][j]<=cxp[i][p] ;

 forall(p in product)
  forall(j in hub)
    forall(s in sorting)
      forall(v in vehicle)
        X[p][j][s][v]<=Z[j][s][v];                  
 
 
 
 forall(j in hub)
   forall(p in product)
     sum(i in customer)x[p][i][j]==sum(s in sorting)sum(v in vehicle)Z[j][s][v];
 forall(i in customer)
   forall(j in hub)
     sum(p in product)x[p][i][j]==sum(k in agent)z[i][j][k];
 forall(p in product)
   forall(j in hub)
     sum(i in customer)x[p][i][j]==sum(s in sorting)sum(v in vehicle)X[p][j][s][v];
}


  
