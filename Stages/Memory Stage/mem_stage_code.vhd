----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:37 12/05/2022 
-- Design Name: 
-- Module Name:    mem_stage_code - Behavioral 
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

entity mem_stage_code is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           memtoreg : in  STD_LOGIC;
           memread : in  STD_LOGIC;
           memwrite : in  STD_LOGIC;
			  regwrite : in STD_LOGIC;
			  branchin : in STD_LOGIC;
			  dst : in STD_LOGIC_VECTOR (3 downto 0); --reg file dst--
           aluresult : in  STD_LOGIC_VECTOR (23 downto 0);
           pc : in  STD_LOGIC_VECTOR (23 downto 0); -- inst no--
			  st_value : in  STD_LOGIC_VECTOR (23 downto 0); -- value to be stored in data memory--
			  --output--
           memdataout : out  STD_LOGIC_VECTOR (23 downto 0);
           pcmemout : out  STD_LOGIC_VECTOR (23 downto 0);
           memtoregout : out  STD_LOGIC;
			  regwriteout : out STD_LOGIC;
			  branchout : out STD_LOGIC;
			  dstout : out STD_LOGIC_VECTOR (3 downto 0); -- reg file dst--
           aluresultout : out  STD_LOGIC_VECTOR (23 downto 0);
			  wbdata: out std_logic_vector(23 downto 0)); -- data to be written to reg file--
			  
end mem_stage_code;

architecture Behavioral of mem_stage_code is

component datamemorycode is
    Port ( address : in  STD_LOGIC_VECTOR (23 downto 0);
           memwrite : in  STD_LOGIC;
           memread : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           wrdata : in  STD_LOGIC_VECTOR (23 downto 0);
           rddata : out  STD_LOGIC_VECTOR (23 downto 0));
end component;
signal memdataoutsignal: std_logic_vector (23 downto 0);
begin

mem: datamemorycode port map (aluresult,memwrite,memread,clk,st_value,memdataoutsignal);

with memtoreg select 
wbdata <= aluresult when '0', --write the alu result for R-type inst--
			 memdataoutsignal when others; -- write from data memory in the load inst--

pcmemout <= pc;
memtoregout <= memtoreg;
dstout <= dst; -- reg where the data to be written--
aluresultout <= aluresult;
regwriteout <= regwrite;
branchout <= branchin;
memdataout<=memdataoutsignal; --data read from memory--
end Behavioral;

