----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:28:10 11/10/2022 
-- Design Name: 
-- Module Name:    regfilecode - Behavioral 
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

entity regfilecode is
    Port ( src1 : in  STD_LOGIC_VECTOR (3 downto 0); --address of reg used in operations (rs) 
           src2 : in  STD_LOGIC_VECTOR (3 downto 0); --address of reg used in operations (rt)
           dst : in  STD_LOGIC_VECTOR (3 downto 0); -- output address of reg (rd)
           wr_data : in  STD_LOGIC_VECTOR (23 downto 0); --data to be written 
           regwrite : in  STD_LOGIC; -- register write signal 
           clk : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (23 downto 0); -- data of sc1
           out2 : out  STD_LOGIC_VECTOR (23 downto 0)); -- data of scr2
end regfilecode;

architecture Behavioral of regfilecode is
TYPE ram IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL regfile:                                               
ram:=ram'(x"000000", x"000002", x"000003", x"000004",
x"000005", x"000006", x"000007", x"000008",
x"000005", x"000004", x"000008", x"000009",
x"00000A", x"000001", x"000003", x"000006"); --some random values of registers are stored in ram 

begin

process(clk)
begin
if (rising_edge(clk) and regwrite='1') then             --write enable
regfile(CONV_INTEGER(dst))<=wr_data; --write data into reg specified by addr A3
elsif (falling_edge(clk)) then
out1<=regfile(CONV_INTEGER(src1));--read data from reg specified by addr A1
out2<=regfile(CONV_INTEGER(src2));--read data from reg specified by addr A2
end if;
end process;

end Behavioral;

