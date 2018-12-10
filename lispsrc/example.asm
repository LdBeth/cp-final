
most simple program:

     idle   00000000            ; do nothing

55*2:

  00 setp   00000011 3          ; Set memory pointer
  01 03     00000011 3          ; to hex number #x03 -> 06-07
  02 load   00000001 1          ; load memory pointer to stack
  03 dupl   00001001 9          ; duplicate top of stack
  04 adds   00001010 10         ; add top two numbers of stack
  05 show   00000101 5          ; pop and show
  06 num:55 00000000 0          ;  data section
  07        00110111 55


goto:

  00 setp   00000011 3
  01 03     00000011 3
  02 goto   00000100 4          ; goto 06
  03 idle   ----
  04 num:2  00000000
  05        00000011 2
  06 setp   00000011 3
  05 01     00000001 1
  06 load   00000001 1
  07 show   00000101 5
