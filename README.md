## Growth Accelerator Plot Optimizer
Finds the placement of Growth Accelerators (from Applied Energistics 2)
which optimizes the quantity of accelerated cells in a 9 by 9 block plot,
using z3.

```
Problem status: Sat
Accelerated 61 blocks
Legend: O: accelerator, .: accelerated cell, x: unaccelerated cell
O . O . . . O . . 
. . . . O . . . O 
. O . . . . O . . 
. . . O . . . . O 
O . . . . O . . . 
. . O . . . . O . 
. . . . O O . . . 
O O . . . . . . O 
. . . O . . O . . 
```

A slower minizinc implementation is also provided:
```
cells accelerated = 61
. O . O . . . O .
. . . . . O . . .
O . O . . . . . O
. . . . O . O . .
. O . . . . O . .
. . . O . . . . O
O . . . . O . . .
. . O . . . . O .
O . . . O . . O .
----------
==========
```

#### Licensing
This code belongs to the public domain.
