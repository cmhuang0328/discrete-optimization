# Problem8 Transhipment Problem
# Author:Chien-Ming Huang

# Forcast Daily Demand Next Week
param d1= 1230;
param d2= 1190;
param d3= 845;
param d4= 935;
param d5= 915;
param d6= 1625;
param d7= 1510;

# Own Power Plant produce 50i, max 500MW
var i integer >= 0 <= 10;
var o1= 50* i;
var o2= 50* i;
var o3= 50* i;
var o4= 50* i;
var o5= 50* i;
var o6= 50* i;
var o7= 50* i;

# Rent Power Plant produce 100j, max 600MW
var j integer >= 0, <= 6;
var r1= 100* j;
var r2= 100* j;
var r3= 100* j;
var r4= 100* j;
var r5= 100* j;
var r6= 100* j;
var r7= 100* j;

# Neighbor Country max 500MW
var n1  >= 0 <= 500;
var n2  >= 0 <= 500;
var n3  >= 0 <= 500;
var n4  >= 0 <= 500;
var n5  >= 0 <= 500;
var n6  >= 0 <= 500;
var n7  >= 0 <= 500;

# Store Electricity
var s1 >= 0;
var s2 >= 0;
var s3 >= 0;
var s4 >= 0;
var s5 >= 0;
var s6 >= 0;
var s7 >= 0;

minimize Cost: 20* (o1+o2+o3+o4+o5+o6+o7)+ 25* (r1+r2+r3+r4+r5+r6+r7)+ 45* (n1+n2+n3+n4+n5+n6+n7) + 2* (s1+s2+s3+s4+s5+s6+s7);

# Everyday Store
subject to Store1: s1= o1+r1+ n1- d1;
subject to Store2: s2= o2+r2+ n2+ s1- d2;
subject to Store3: s3= o3+r3+ n3+ s2- d3;
subject to Store4: s4= o4+r4+ n4+ s3- d4;
subject to Store5: s5= o5+r5+ n5+ s4- d5;
subject to Store6: s6= o6+r6+ n6+ s5- d6;
subject to Store7: s7= o7+r7+ n7+ s6- d7;

# Everyday Demand
subject to Demand1: d1<= o1+r1+ n1;
subject to Demand2: d2<= o2+r2+ n2+ s1;
subject to Demand3: d3<= o3+r3+ n3+ s2;
subject to Demand4: d4<= o4+r4+ n4+ s3;
subject to Demand5: d5<= o5+r5+ n5+ s4;
subject to Demand6: d6<= o6+r6+ n6+ s5;
subject to Demand7: d7<= o7+r7+ n7+ s6;

option solver cplex;
solve;
display Cost;
display o1, o2, o3, o4, o5, o6, o7;
display r1, r2, r3, r4, r5, r6, r7;
display n1, n2, n3, n4, n5, n6, n7;
display s1, s2, s3, s4, s5, s6, s7;

