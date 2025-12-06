int: h = 8;
int: w = 8;
set of int: HEIGHT = 0..h;
set of int: CHEIGHT = 1..h-1;
set of int: WIDTH = 0..w;
set of int: CWIDTH = 1..w-1;  
array[HEIGHT,WIDTH] of var bool: a; % accelerator grid
array[HEIGHT,WIDTH] of var bool: b; % accelerated grid

% center
constraint forall (i in CHEIGHT, j in CWIDTH)
  (b[i,j] == '/\'(not(a[i,j]), '\/'('\/'(a[i-1,j], a[i+1,j]), '\/'(a[i,j-1], a[i,j+1]))));

% left side
constraint forall (i in CHEIGHT)
  (b[i,0] == '/\'(not(a[i,0]), '\/'('\/'(a[i-1,0], a[i+1,0]), a[i,1])));
% right side
constraint forall (i in CHEIGHT)
  (b[i,w] == '/\'(not(a[i,w]), '\/'('\/'(a[i-1,w], a[i+1,w]), a[i,w-1])));
% top side
constraint forall (j in CWIDTH)
  (b[0,j] == '/\'(not(a[0,j]), '\/'(a[1,j], '\/'(a[0,j-1], a[0,j+1]))));
% bottom side
constraint forall (j in CWIDTH)
  (b[h,j] == '/\'(not(a[h,j]), '\/'(a[h-1,j], '\/'(a[h,j-1], a[h,j+1]))));

% top left
constraint (b[0,0] == '/\'(not(a[0,0]), '\/'(a[0,1], a[1,0])));
% top right
constraint (b[0,w] == '/\'(not(a[0,w]), '\/'(a[0,w-1], a[1,w])));
% bottom left
constraint (b[h,0] == '/\'(not(a[h,0]), '\/'(a[h,1], a[h-1,0])));
% bottom right
constraint (b[h,w] == '/\'(not(a[h,w]), '\/'(a[h,w-1], a[h-1,w])));

var int: d = sum([bool2int(v) | v in b]);


solve maximize d;
output [
  "cells accelerated = \(d)\n",
  join("\n", [join(" ", [if fix(a[i,j]) then "O" else if fix(b[i,j]) then "." else "x" endif endif | j in WIDTH]) | i in HEIGHT])
];
