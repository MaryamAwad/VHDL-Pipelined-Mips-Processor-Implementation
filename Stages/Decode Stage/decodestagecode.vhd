----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:27:31 12/04/2022 
-- Design Name: 
-- Module Name:    decodestagecode - Behavioral 
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

entity decodestagecode is
    Port ( inst : in  STD_LOGIC_VECTOR (23 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  regwrite : in STD_LOGIC;
           pc : in  STD_LOGIC_VECTOR (23 downto 0);
			  dst : in STD_LOGIC_VECTOR (3 downto 0);
			  wr_data : in  STD_LOGIC_VECTOR (23 downto 0);
			  exdst : in STD_LOGIC_VECTOR (3 downto 0);
			  dmemread : in STD_LOGIC;
			  --------output---------------
           reg1 : out  STD_LOGIC_VECTOR (23 downto 0);
           reg2 : out  STD_LOGIC_VECTOR (23 downto 0);
			  src1 : out  STD_LOGIC_VECTOR (3 downto 0);  -- regster 1 address
			  src2 : out  STD_LOGIC_VECTOR (3 downto 0);  -- regster 2 address
			  dstout : out  STD_LOGIC_VECTOR (3 downto 0);
           memtoreg : out  STD_LOGIC;
           memwrite : out  STD_LOGIC;
           memread : out  STD_LOGIC;
           branch : out  STD_LOGIC;
           alucontrol : out  STD_LOGIC_VECTOR (2 downto 0);
			  st_value : out  STD_LOGIC_VECTOR (23 downto 0);
			  signout : out STD_LOGIC_VECTOR (23 downto 0);
			  pcout : out STD_LOGIC_VECTOR (23 downto 0);
           regdst : out  STD_LOGIC;
           regwriteout : out  STD_LOGIC;
			  pcwrite : out STD_LOGIC;
			  if2dwrite : out STD_LOGIC;
			  opcode : out STD_LOGIC_VECTOR (5 downto 0));
end decodestagecode;

architecture Behavioral of decodestagecode is

component controlunitcode is 
	port (
			Op: in STD_LOGIC_VECTOR(5 DOWNTO 0);--The opcode from the current instruction
			Funct: in STD_LOGIC_VECTOR(5 DOWNTO 0);
			MemtoReg: out STD_LOGIC;
			MemWrite: out STD_LOGIC;
			MemRead: out STD_LOGIC;
			Branch: out STD_LOGIC;
			ALUControl: out STD_LOGIC_VECTOR(2 DOWNTO 0);
			ALUSrc: out STD_LOGIC;
			RegDst: out STD_LOGIC;
			RegWrite: out STD_LOGIC);
end component;


component regfilecode is
	Port ( src1 : in  STD_LOGIC_VECTOR (3 downto 0);
           src2 : in  STD_LOGIC_VECTOR (3 downto 0);
           dst : in  STD_LOGIC_VECTOR (3 downto 0);
           wr_data : in  STD_LOGIC_VECTOR (23 downto 0);
           regwrite : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (23 downto 0);
           out2 : out  STD_LOGIC_VECTOR (23 downto 0));
end component;

component signextcode is
    Port ( imt : in  STD_LOGIC_VECTOR (9 downto 0);
           imtext : out  STD_LOGIC_VECTOR (23 downto 0));
end component;

component hazarddetection is
    Port ( rs : in  STD_LOGIC_VECTOR (3 downto 0);
           rt : in  STD_LOGIC_VECTOR (3 downto 0);
           rd : in  STD_LOGIC_VECTOR (3 downto 0);
           dmemread : in  STD_LOGIC;
           pcwrite : out  STD_LOGIC:= '0';
           if2dwrite : out  STD_LOGIC:= '0';
           signalswrite : out  STD_LOGIC:= '0');
end component;

signal RegDstMuxOut : STD_LOGIC_VECTOR(3 downto 0); -- reg address
signal RegMuxOut : STD_LOGIC_VECTOR(3 downto 0); -- reg address
signal MemtoRegMuxOut : STD_LOGIC_VECTOR(23 downto 0);
signal RegWriteSignal : STD_LOGIC;
signal RD1Out : STD_LOGIC_VECTOR(23 downto 0); -- reg 1 value
signal RD2Out : STD_LOGIC_VECTOR(23 downto 0); -- reg 2 value
signal SignImmOut : STD_LOGIC_VECTOR(23 downto 0); --signext value
signal ALUControlSignal: STD_LOGIC_VECTOR(2 downto 0);
signal MemWriteSignal : STD_LOGIC;
signal MemReadSignal : STD_LOGIC;
signal MemtoRegSignal : STD_LOGIC;
signal BranchSignal : STD_LOGIC;
signal ALUSrcSignal : STD_LOGIC;
signal RegDstSignal : STD_LOGIC;
signal regout : STD_LOGIC_VECTOR(23 downto 0); -- data from second address reg "we will choose later between signext or reg2"
signal signalwrite : STD_LOGIC; --used to control the control unit signals


begin
rg: regfilecode port map (inst(17 downto 14),inst(13 downto 10),RegDstMuxOut,wr_data,regwrite,clk,reg1,regout);

cu: controlunitcode port map (inst(23 downto 18),inst(5 downto 0),MemtoRegSignal,MemWriteSignal,MemReadSignal,BranchSignal,ALUControlSignal,ALUSrcSignal,RegDstSignal,RegWriteSignal);
signextend: signextcode port map (inst(9 downto 0),SignImmOut);
detection : hazarddetection port map (inst(17 downto 14), inst(13 downto 10),exdst,dmemread,pcwrite,if2dwrite,signalwrite);

RegDstMuxOut <= dst;

with ALUSrcSignal select
reg2 <= regout when '0',
		  SignImmOut when others;		

signout <= SignImmOut;		  
pcout <=pc;
src1 <= inst(17 downto 14);
src2 <= inst(13 downto 10);

with RegDstSignal select 
dstout  <= inst(13 downto 10) when '1', -- I type (rt)--
			  inst(9 downto 6) when others; -- R type (rd)--

st_value <=regout; --value of reg 2 from regfile for store inst


process (signalwrite,clk)
begin
if (signalwrite = '0') then -- no hazard
	regwriteout <= RegWriteSignal;
	memtoreg <= MemtoRegSignal;
	memwrite <= MemWriteSignal;
	memread <= MemReadSignal;	
	branch <= BranchSignal;
	alucontrol <=ALUControlSignal;
	regdst <=RegDstSignal;
elsif (signalwrite = '1') then --hazard detected
	regwriteout <= '0';
	memtoreg <= '0';
	memwrite <= '0';
	memread <= '0';	
	branch <= '0';
	alucontrol <="000";
	regdst <='0';
end if;
end process;
opcode <= inst(23 downto 18); --opcode in case of R-type
end Behavioral;
