
## simple-alu

This is my first real VHDL design; as its highly original name suggests, its a simple arithmetic logic unit (a core component in all CPU's). It has several functions and testbench to go with it.

### Technical Details

The ALU currently works on 8-bit integers. Except for the bitwise operations, the numbers are treated as signed integers. The ALU takes a 4-bit opcode and two 8-bit integers. Each operation is performed on a single clock cycle. The ALU can perform the following operations:

* Addition
* Subtraction
* Left and Right Shift
* And/Or/Xor of two numbers
* Not (or bit inversion)
* 2's complement
* Increment
* Decrement

I know that the IEEE library provides arithmetic operations on logic vectors, but I implemented the entire thing myself because I wanted to understand how everything worked internally down to the gate level. I also wanted to be able to look at the design and have a rough vision of how it would translate to an actual circuit.


