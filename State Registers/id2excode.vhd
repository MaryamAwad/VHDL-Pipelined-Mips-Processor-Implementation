----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:35 12/04/2022 
-- Design Name: 
-- Module Name:    id2excode - Behavioral 
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

entity id2excode is
port (
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  opcode : in STD_LOGIC_Vector (5 downto 0);
			  reg1 : in  STD_LOGIC_VECTOR (23 downto 0); --reg 1 value
           reg2 : in  STD_LOGIC_VECTOR (23 downto 0); -- reg 2 value
			  src1 : in  STD_LOGIC_VECTOR (3 downto 0);  -- reg 1 address
			  src2 : in  STD_LOGIC_VECTOR (3 downto 0); -- reg 2 address
			  dst : in  STD_LOGIC_VECTOR (3 downto 0); --dst address
			  st_valuein : in STD_LOGIC_VECTOR (23 downto 0); --store value for store inst
           memtoreg : in  STD_LOGIC;
           memwrite : in  STD_LOGIC;
           memread : in  STD_LOGIC;
           branch : in  STD_LOGIC;
           alucontrol : in  STD_LOGIC_VECTOR (2 downto 0);
			  signout : in STD_LOGIC_VECTOR (23 downto 0);
			  pcin : in STD_LOGIC_VECTOR (23 downto 0);
           regdst : in  STD_LOGIC;
           regwrite : in  STD_LOGIC;
			  --output
			  reg1out : out  STD_LOGIC_VECTOR (23 downto 0); -- first value of alu
           reg2out : out  STD_LOGIC_VECTOR (23 downto 0); -- second value of alu
			  src1out : out  STD_LOGIC_VECTOR (3 downto 0);  -- reg address
			  src2out : out  STD_LOGIC_VECTOR (3 downto 0);  -- reg address
			  dstout : out  STD_LOGIC_VECTOR (3 downto 0);   -- dst address
			  st_valueout : out  STD_LOGIC_VECTOR (23 downto 0); --store value for store inst
           memtoregout : out  STD_LOGIC;
           memwriteout : out  STD_LOGIC;
           memreadout : out  STD_LOGIC;
           branchout : out  STD_LOGIC;
			  alucontrolout : out  STD_LOGIC_VECTOR (2 downto 0);
			  pcout : out STD_LOGIC_VECTOR (23 downto 0);
           regdstout : out  STD_LOGIC;
           regwriteout : out  STD_LOGIC;
			  opcodeout : out STD_LOGIC_Vector (5 downto 0));
			  
end id2excode;

architecture Behavioral of id2excode is

begin
process (clk,rst)
begin
if rst='1' then 
	memtoregout <='0';
	memwriteout <='0';
	memreadout <='0';
	branchout <='0';
	pcout <=x"000000";
	regdstout <='0';
	regwriteout <='0';
	reg1out <=x"000000";
	reg2out <=x"000000";
	src1out <=x"0";
	src2out <=x"0";
	dstout <=x"0";
	alucontrolout <="000";
	st_valueout <= x"000000";
	opcodeout <= "000000";
elsif rising_edge(clk) and rst = '0' then
	memtoregout <= memtoreg;
	memwriteout <= memwrite;
	memreadout <=memread;
	branchout <=branch;
	pcout <=pcin;
	regdstout <=regdst;
	regwriteout <=regwrite;
	reg1out <=reg1; --alu 1 input
	reg2out <=reg2; -- alu 2 input
	src1out <=src1; --forward first input
	src2out <=src2; --forward second input
	dstout <=dst; --dst reg addr
	alucontrolout <=alucontrol;
	st_valueout <= st_valuein;
	opcodeout <= opcode;
end if;
end process;

end Behavioral;

