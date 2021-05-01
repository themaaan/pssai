include "alldifferent.mzn";
%%%%% Input %%%%%

% Minimum number of consecutive shifts
int: minOn;
% Maximum number of consecutive shifts
int: maxOn;
% Minimum number of consecutive free days
int: minOff;
% Maximum number of consecutive free days
int: maxOff;
% Number of employees
int: groups;
% Number of shift types
int: numShifts;
% Array containing the minimum number of consecutive shifts of the corresponding type
array[int] of int: minShift;
% Array containing the maximum number of consecutive shifts of the corresponding type
array[int] of int: maxShift;
% Array containing a set of shifts that are forbidden to follow the corresponding type
array[int] of set of int: forbidden;
% Array of shift sequences of length 3 that are forbidden
array[int,int] of int: forbidden3;
% Matrix of dimension numShifts x 7 indicating the demand of each shift type for each day
array[int,int] of int: demand;

%% Output 
%% test
int: w = 7;
set of int: HEIGHT = 1..numShifts;
set of int: WIDTH = 1..w;

output [ 
  if j=1 then "\n" else " " endif ++
    show(demand[i,j])
    | i in HEIGHT,j in WIDTH];
    
%% Cyclic Schedule
set of int: HEIGHT_S = 1..groups;
set of int: WIDTH_S = 1..w;
array[HEIGHT_S,WIDTH_S] of var 0..numShifts: S;


constraint forall(j in WIDTH)(
             sum(i in HEIGHT)(S[i,j] == demand[i,j]) == 1 );
             
% Amanii code:         
enum SHIFT= {D,A,N,O};       
enum day;
array[groups,day] of var SHIFT: roster;
int: Q = 6; int: q0 = 1;
    
constraint forall(i in day)(
    sum(i in groups)(roster[i,j]==D)==req_d /\
    sum(i in groups)(roster[i,j]==A)==req_a /\
    sum(i in groups)(roster[i,j]==N)==req_n  

   );
constraint forall(i in groups)(
             regular([roster[i,j] | j in day], Q, S, t, q0, S) /\
             sum(j in DAY)(roster[i,j] == n) >= min_night
           );
 

solve satisfy;

%when we want to minimize our objective function uncomment following code

%%solve maximize sum(i in b)(l(i)-5)^2;

%where we define b as the number of working blocks in a solution and l(i) to represent the length of working block

output ["\n"];

output [ 
  if j=1 then "\n" else " " endif ++
    show(S[i,j])
    | i in HEIGHT_S,j in WIDTH_S];
