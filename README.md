# Nero's Toy Computer

A conceptual computer emulator inspired by FORTH, and COSMAC ELF.

## Summary

- programming with a switch panel/hex keyboard 
- Very small instruction set, no more than 20.
- Has a main memory as a array, a separated display memory, a data stack.
- Produce pixel graphic output via a direct memory access style instruction.
- Produce sound via setting a register controls frequency
- A hex number display

## Component Parts

### Interface
- in p5.js
- Provide a cheat interface for quick load program
### Main body
- in JavaScript
### Specification
- a text file descries the instuction set.
### An assembler script
- Produce json/hex output
- for loading program
### A hex number helper
- Used in presentation
- Convert from and to bin, oct, hex.
### A few demo programs
- calculate Fibonacci 6
- make some noise
- draw some text
- random mini game


## Challenges

As DEK says, u'll never expect what problems to have before actually working.
It's hard to debug an ad hoc language, espically a lowlevel one.
Also it's not easy to make a wise dicesion on instruction set.

## Timeline

- Week 1: Write proposal
- Week 2: CPU Spec
- Week 3: GUI
- Week 4: Present!

## Completed Work

Press number 1-8 as switchs.
Press `l` to load mode.
In load mode, press `i` to key in program.
Press `r` to run.
Press `s` to stop.
Press `c` to reset.

## References and links

- [COSMACS ELF](http://www.cosmacelf.com)
- [FORTH](http://www.forth.org)
- [MMIX](http://mmix.cs.hm.edu)
