----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:40:12 11/14/2022 
-- Design Name: 
-- Module Name:    controlunitcode - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controlunitcode is
PORT (
Op: in STD_LOGIC_VECTOR(5 DOWNTO 0);--The opcode from the current instruction
Funct: in STD_LOGIC_VECTOR(5 DOWNTO 0);
MemtoReg: out STD_LOGIC; --memory to reg signal to write value in regfile
MemWrite: out STD_LOGIC; --memory write signal to write in memory
MemRead: out STD_LOGIC; -- memory read signal to read from memory
Branch: out STD_LOGIC; -- branch signal that is used again in new pc value
ALUControl: out STD_LOGIC_VECTOR(2 DOWNTO 0); -- ALU signal to perform the required operations
ALUSrc: out STD_LOGIC; -- Alu control signal to choose between the reg 2 or the signext value
RegDst: out STD_LOGIC; -- reg destination to choose in which reg the data will be written
RegWrite: out STD_LOGIC); --reg write signal 
end controlunitcode;

architecture Behavioral of controlunitcode is

begin
process(Op,Funct)
begin
if(Op=0 AND Funct="010111") then ALUControl <= "000"; --add function =23
elsif(Op=0 AND Funct="001010") then ALUControl <= "001";-- sub function = 10
elsif(Op=0 AND Funct="001001") then ALUControl <= "010"; -- and function = 9
elsif(Op=0 AND Funct="001000") then ALUControl <= "011"; -- or function = 8
elsif(Op=0 AND Funct="001100") then ALUControl <= "100"; -- nor function = 12
elsif(Op=0 AND Funct="001011") then ALUControl <= "101"; -- xor function = 11
elsif(Op=0 AND Funct="000101") then ALUControl <= "110"; -- not used
elsif(Op="000111") then ALUControl <= "000"; -- addi = 7
elsif(Op="000101") then ALUControl <= "000";--load = 5 
elsif(Op="001000") then ALUControl <= "000";--sw = 8
elsif(Op="001010") then ALUControl <= "001";-- beq = 10
end if;
end process;

----------MemtoReg--Load-----------------------									
with Op select
MemtoReg <= 	'1' when "000101",--load --
					'0' when others;
----------MemWrite--Store---------------------
with Op select
MemWrite <= 	'1' when "001000", --store--
					'0' when others;
----------MemRead--Load---------------------
with Op select
MemRead <= 	'1' when "000101", -- to read required value to be loaded
				'0' when others;
-----------Branch----------------------------------
with Op select
Branch  <=  	'1' when "001010",
					'0' when others;

-----------RegDst---(!iType)-------------------------------------
with Op select
RegDst <=   '0' when "000000", --R type--
				'1' when others;	-- I type-- 			
------------ALUSrc----------------------------------------------
with Op select
ALUSrc <= 	'0' when "000000", -- read from register R2--
	         '0' when "001010", -- read from register R2 for beq --
				'1' when others;	-- read from signextent--
------------RegWrite---------------------------------------------
with Op select
RegWrite <= 	'1' when "000000", --R type--
					'1' when "000101", --load--
					'0' when others;
end Behavioral;

