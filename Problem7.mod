#Problem 7 Project Investment to get Max Net Profit 
#Author:Chien-Ming Huang

set P;
param Profit{P};
param Cost{P};
param Investment;
var Fund{P} binary;

maximize TotalProfit: sum{i in P} Fund[i] * Profit[i];
s.t. TotalCost: sum{i in P} Fund[i] * Cost[i] <= Investment;

data Problem7.dat;
option solver cplex;
solve;
display TotalProfit;
display Fund;
