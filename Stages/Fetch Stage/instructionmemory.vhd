--VHDL Code for the IM (Instruction Memory) of the MIPS Processor--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instructionmemory is
PORT (address: in STD_LOGIC_VECTOR(23 DOWNTO 0); 
 	   data: out STD_LOGIC_VECTOR(23 DOWNTO 0));--output that will carry the inst
-----------------------------------------------
end instructionmemory;

architecture Behavioral of instructionmemory is
--------//signals//------------------------
TYPE rom IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(23 DOWNTO 0); 
CONSTANT imem: 
rom:=rom'(

"000000001001110101010111", -- add $5,$2,$7
"000101010100110000000100",-- lw $3,4($5)
"000000010100110011001000", -- or $3,$5,$3
"001000001001100000000000", -- sw $6,0($2)
"000101001000100000000000", -- lw $2,0($2)
"001000010100110000000000", -- sw $3,0($5)
---------end of program & reset for more inst 'meaningless inst'-------
"001000100010010000000100",--sw 9,4(8)
"000000100000001001010111", -- add $9,$0,$8
"000000100101001010010111", -- add $10,$9,$4
"000000101010011001010111", -- add $9,$9,$10
"000000100000001001010111", -- add $9,$0,$8--dst=9
"000000000110011010010111",--add $t2,$9,$1--dst=10
"000101100010010000000011",--lw 9,3(8)
"000000100101001010010111", -- add $10,$9,$4
"000000000100001010010111",--add $t2,$0,$1--dst=10
"000000100000001011010111", --add $t3,$0,$t0--dst=11
"000000100000001100010111", --add $s0,$0,$t0--dst=12
"000000100000001101010111" ,--add $s1,$0,$t0--dst=13
"000000100000001011010111", --add $t3,$0,$t0--
"000000100000001100010111", --add $s0,$0,$t0--
"000000100000001100010111", --add $s0,$0,$t0--
"000000100000001100010111", --add $s0,$0,$t0--
"000000100000001101010111" ,--add $s1,$0,$t0--
"000000100000001011010111", --add $t3,$0,$t0--
"000000100000001100010111", --add $s0,$0,$t0--
"000000100000001100010111", --add $s0,$0,$t0--
"000000100000001100010111", --add $s0,$0,$t0--
"000000100000001101010111" ,--add $s1,$0,$t0--
"000000100000001011010111", --add $t3,$0,$t0--
"000000100000001100010111", --add $s0,$0,$t0--
"000000100000001100010111", --add $s0,$0,$t0--
"000000100000001101010111" --add $s1,$0,$t0--
);


begin
--the imem is a ROM containing the 24bit wide instructions
data<=imem(CONV_INTEGER(address));-- 'data' output will carry the 24b instuction from location specified by 'address'. 

end Behavioral;


