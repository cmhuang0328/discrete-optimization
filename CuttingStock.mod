#-----CUTTING STOCK MODEL USING PATTERNS-----
param roll_width >0;

set WIDTHS;
param orders {WIDTHS} >0;

param nPAT integer >=0;
set PATTERNS := 1..nPAT;

param A{WIDTHS, PATTERNS} integer >=0;
	check{j in PATTERNS}:
		sum {i in WIDTHS} i * A[i,j] <= roll_width;
		
var X{PATTERNS} integer >=0;

minimize NumberOfRolls:
	sum {j in PATTERNS} X[j];

subj to OrderFill {i in WIDTHS}:
	sum {j in PATTERNS} A[i,j] * X [j] >=orders[i];

#-----KNAPSACK SUBPROLEM FOR CUTTING STOCK-----
param dualprice {WIDTHS} default 0.0;

var C {WIDTHS} integer >=0;

minimize Reduced_Cost:
	1 - sum {i in WIDTHS} dualprice[i] * C[i];

subj to Width_Limit:
	sum {i in WIDTHS} i * C[i]  <=roll_width;

#-----Reading Data and Choosing Solver---------
data problem6.dat;

option solver cplex;
option solution_round 6;

#-----Defining the Two Stages------------------
problem Cutting_Opt: X, NumberOfRolls, OrderFill;
option relax_integrality 1;

problem Pattern_Gen: C, Reduced_Cost, Width_Limit;
option relax_integrality 0;

#-----Initializing Pattern Set-----------------
let nPAT := 0;

for {i in WIDTHS} {
   let nPAT := nPAT + 1;
   let A[i,nPAT] := floor (roll_width/i);
   let {i2 in WIDTHS: i2 <> i} A[i2,nPAT] := 0;
};

#-----Two Stage Optimization Loop--------------
repeat {
   solve Cutting_Opt;

   let {i in WIDTHS} dualprice[i] := OrderFill[i].dual;

   solve Pattern_Gen;

   if Reduced_Cost < -0.00001 then {
      let nPAT := nPAT + 1;
      let {i in WIDTHS} A[i,nPAT] := C[i];
      
      display C;
   }
   else break;
};

#-----Final Integer Program with Generated Patterns------
option Cutting_Opt.relax_integrality 0;
solve Cutting_Opt;

#-----Displaying Results---------------------------------
display A; 
display X;

