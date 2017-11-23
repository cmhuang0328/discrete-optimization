# Problem 3 Integer Programming
# Author Chien-Ming Huang
var x ;
var y ;
var p ;
var q ;

minimize target: x;
subject to a: -x+3*y+ p= 7.5;
subject to b: x-5*y +q = -12.5;
option solver cplex;
solve;
display x, y, p, q;