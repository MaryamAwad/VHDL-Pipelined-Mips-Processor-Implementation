----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:30:29 12/05/2022 
-- Design Name: 
-- Module Name:    fetchstagecode - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fetchstagecode is
PORT (inst : out  STD_LOGIC_VECTOR (23 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  pcwrite : in STD_LOGIC; -- '1' when a hazard is detected & '0' in normal case
           pcout : out  STD_LOGIC_VECTOR (23 downto 0);
			  NEW_PC_ADDR_IN	: in STD_LOGIC_VECTOR(23 downto 0); --pc signal for branch
			  PCSrc		: in STD_LOGIC); --to choose between incrementing by one or adding the signext "branch"
end fetchstagecode;

architecture Behavioral of fetchstagecode is

component instructionmemory is 
port (address: in STD_LOGIC_VECTOR(23 DOWNTO 0);
 	   data: out STD_LOGIC_VECTOR(23 DOWNTO 0));
end component;

component programcounter is 
PORT (
din: in STD_LOGIC_VECTOR(23 DOWNTO 0); --instruction number--
clk: in STD_LOGIC;
pcwrite : in STD_LOGIC;
clr: in STD_LOGIC;
dout: out STD_LOGIC_VECTOR(23 DOWNTO 0));
end component;
-- signals
signal PCmuxout : STD_LOGIC_VECTOR(23 downto 0):=x"000000";
signal instIN : STD_LOGIC_VECTOR(23 downto 0);
signal instOUT : STD_LOGIC_VECTOR(23 downto 0);
signal SignImmOut : STD_LOGIC_VECTOR(23 downto 0);

begin
PC: programcounter PORT MAP(PCmuxout,clk,pcwrite,rst,instIN);
IM: instructionmemory PORT MAP(instIN,instOUT);

--PCmuxout--
with PCSrc select
PCmuxout <= instIN + x"000001" when '0', -- normal case of increasing the pc counter
				NEW_PC_ADDR_IN +SignImmOut when others; -- in case of branch inst

inst <= instOUT;
pcout <=instIN; --pcout is the main signal that will be passed accross the stage 

end Behavioral;

