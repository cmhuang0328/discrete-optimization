# Problem 3 Integer Programming
# Author Chien-Ming Huang
var x integer;
var y integer;

minimize target: x;
subject to a: -x+3*y<= 7.5;
subject to b: x-5*y <= -12.5;
option solver cplex;
solve;
display x, y;




