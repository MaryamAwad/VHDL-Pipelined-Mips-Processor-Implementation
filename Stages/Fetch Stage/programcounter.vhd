--VHDL Code for the PC (Program Counter) of the MIPS Processor--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity programcounter is
---------//ports//---------
PORT (
din: in STD_LOGIC_VECTOR(23 DOWNTO 0); --instruction number input--
clk: in STD_LOGIC;
pcwrite : in STD_LOGIC; -- '1' when a hazard is detected & '0' in normal case
clr: in STD_LOGIC:='0';
dout: out STD_LOGIC_VECTOR(23 DOWNTO 0)); --instruction number output--
--------------------------
end programcounter;

architecture Behavioral of programcounter is
begin
PROCESS (clk,clr)  BEGIN
  IF (clr='1') THEN dout <= x"000000"; --start PC 
  elsIF rising_edge(clk) and clr = '0' and pcwrite = '0' THEN 
  dout<=din;
END IF;                   
END PROCESS; 

--------------------------

end Behavioral;

