# Problem 6 Lagrangean Dual
# Author Chien-Ming Huang
var x integer;
var y integer;
var a >=0;
var b >=0

maximize obj : minimum (x+ a*(-x+3*y-7.5)+ b*(x-5*y+12.5));

option solver cplex;
solve;
display x, y;
