% Use this editor as a MiniZinc scratch book

% Number of employees
int: n = 4;

% Length of the schedule
int: w = 7;

% The number of shifts
int: m = 3;

% The Set of Work shifts
var 1..m: A;

% Special activity
int: O = 0;

% A plus
var 0..m: Aplus;

%Temporal requirements matrix
set of int: HEIGHT = 0..m;
set of int: WIDTH = 0..w;

% i for the shift, j for the day (Ri,j)
array[HEIGHT,WIDTH] of var int: R; 

% Minimal and maximal length of blocks of consecutive work shifts.
int: lw;
int: uw;


% Minimal and maximal lengths of blocks of consecutive assignments of shift s given for each s ∈ A+.
int: ls;
int: us;

% Forbidden sequences of shifts

% Output S, n×w-matrix, where each Si,j ∈ A+ denotes the shift or day off that employee i is assigned during day j in the first period of the cycle.

output [ show(R[i,j]) | i in HEIGHT, j in WIDTH];
