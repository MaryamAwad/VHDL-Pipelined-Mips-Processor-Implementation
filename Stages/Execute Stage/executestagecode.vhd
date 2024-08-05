----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:32:29 12/05/2022 
-- Design Name: 
-- Module Name:    executestagecode - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity executestagecode is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  opcode : in STD_LOGIC_VECTOR (5 downto 0 );
           reg1 : in  STD_LOGIC_VECTOR (23 downto 0);
           reg2 : in  STD_LOGIC_VECTOR (23 downto 0);
           src1 : in  STD_LOGIC_VECTOR (3 downto 0);
           src2 : in  STD_LOGIC_VECTOR (3 downto 0);
           dst : in  STD_LOGIC_VECTOR (3 downto 0);
           memtoreg : in  STD_LOGIC;
           memwrite : in  STD_LOGIC;
           memread : in  STD_LOGIC;
           branch : in  STD_LOGIC;
			  st_value : in  STD_LOGIC_VECTOR (23 downto 0);
           alucontrol : in  STD_LOGIC_VECTOR (2 downto 0);
           pcexec : in  STD_LOGIC_VECTOR (23 downto 0);
			  regwritein : in  STD_LOGIC;
			  aluresultm : in  STD_LOGIC_VECTOR (23 downto 0);
			  wbdata : in  STD_LOGIC_VECTOR (23 downto 0);
			  exrd : in  STD_LOGIC_VECTOR (3 downto 0);
			  memrd : in  STD_LOGIC_VECTOR (3 downto 0);
			  exregwrite : in  STD_LOGIC;
			  memregwrite : in  STD_LOGIC;
			  ------------------------------------
			  ---out--
           regwrite : out  STD_LOGIC;
			  memtoregout : out  STD_LOGIC;
           aluresult : out  STD_LOGIC_VECTOR (23 downto 0);
			  st_valueout : out  STD_LOGIC_VECTOR (23 downto 0);
           pcexecout : out  STD_LOGIC_VECTOR (23 downto 0);
           dstout : out  STD_LOGIC_VECTOR (3 downto 0);
           memreadout : out  STD_LOGIC;
			  branchout : out  STD_LOGIC;
           memwriteout : out  STD_LOGIC);
end executestagecode;

architecture Behavioral of executestagecode is

component alucode
PORT (
inp1 : in  STD_LOGIC_VECTOR (23 downto 0);
inp2 : in  STD_LOGIC_VECTOR (23 downto 0);
ctr : in  STD_LOGIC_VECTOR (2 downto 0);
zero : out  STD_LOGIC;
result : out  STD_LOGIC_VECTOR (23 downto 0));
end component;


component forwardingunit is
    Port ( rs : in  STD_LOGIC_VECTOR (3 downto 0);
           rt : in  STD_LOGIC_VECTOR (3 downto 0);
			  opcode : in STD_LOGIC_VECTOR (5 downto 0 );
           exrd : in  STD_LOGIC_VECTOR (3 downto 0);
           memrd : in  STD_LOGIC_VECTOR (3 downto 0);
           exregwrite : in  STD_LOGIC;
           memregwrite : in  STD_LOGIC;
			  forwardst : out  STD_LOGIC_VECTOR (1 downto 0);
           forwardA : out  STD_LOGIC_VECTOR (1 downto 0);
           forwardB : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

signal RegWriteSignal : STD_LOGIC;
signal RD1Out : STD_LOGIC_VECTOR(23 downto 0);
signal RD2Out : STD_LOGIC_VECTOR(23 downto 0);
signal ZeroSignal: STD_LOGIC;
signal MemWriteSignal : STD_LOGIC;
signal MemReadSignal : STD_LOGIC;
signal MemtoRegSignal : STD_LOGIC;
signal BranchSignal : STD_LOGIC;
signal RegDstSignal : STD_LOGIC;
signal forwardstsignal : STD_LOGIC_VECTOR (1 downto 0);
signal forwardAsignal : STD_LOGIC_VECTOR (1 downto 0);
signal forwardBsignal : STD_LOGIC_VECTOR (1 downto 0);
signal aluresultout : STD_LOGIC_VECTOR(23 downto 0):=x"000000";

begin

alu:alucode port map(RD1Out,RD2Out,alucontrol,ZeroSignal,aluresultout);

hazard: forwardingunit port map (src1,src2,opcode,exrd,memrd,exregwrite,memregwrite,
											forwardstsignal,forwardAsignal,forwardBsignal);

with forwardAsignal select 
RD1Out <= reg1 when "00", --forward from regfile--
			 aluresultm when "10", -- forward from alu--
			 wbdata when "01",-- forward from memory--
			 reg1 when others;-- forward from regfile "to initialize"-- 

with forwardBsignal select
RD2Out <= reg2 when "00", --forward from regfile--
			 aluresultm when "10", -- forward from alu--
			 wbdata when "01", -- forward from memory--
			 reg2 when others;-- forward from regfile "to initialize"-- 

with forwardstsignal select
st_valueout <= st_value when "00", --forward from regfile--
					aluresultm when "10",-- forward from alu--
				wbdata when "01", -- forward from memory--
				st_value when others;-- forward from regfile "to initialize"-- 

aluresult<=aluresultout;
pcexecout <=pcexec;
dstout <=dst;
memreadout<=memread;
memwriteout<=memwrite;
regwrite<=regwritein;
memtoregout<=memtoreg;
branchout <= branch;
end Behavioral;

