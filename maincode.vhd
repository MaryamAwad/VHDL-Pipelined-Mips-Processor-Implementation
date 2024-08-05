----------------------------------------------------------------------------------
-- Faculty :  BU
-- Engineers : Maryam
--					Amir
--					Omar
-- 
-- Create Date:    10:51:17 12/06/2022 
-- Design Name: 	MAO PROCESSOR
-- Module Name:    maincode - Behavioral 
-- Supervisor : DR/Radwa
-- Tool versions: ISE 14.7
-- Description: 24 bit pipelined processor 
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

entity maincode is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end maincode;

architecture Behavioral of maincode is

component fetchstagecode is
PORT (inst : out  STD_LOGIC_VECTOR (23 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  pcwrite : in STD_LOGIC;
           pcout : out  STD_LOGIC_VECTOR (23 downto 0);
			  NEW_PC_ADDR_IN	: in STD_LOGIC_VECTOR(23 downto 0);
			  PCSrc		: in STD_LOGIC);
end component;

component if2idcode is
port(
			clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  if2dwrite : in STD_LOGIC;
			  PC_IN	: in	STD_LOGIC_VECTOR(23 downto 0);
	        INST_IN	: in	STD_LOGIC_VECTOR(23 downto 0);
	        PC_OUT	: out	STD_LOGIC_VECTOR(23 downto 0);
	        INST_OUT	: out	STD_LOGIC_VECTOR(23 downto 0));
end component;

component decodestagecode is
    Port  ( inst : in  STD_LOGIC_VECTOR (23 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  regwrite : in STD_LOGIC;
           pc : in  STD_LOGIC_VECTOR (23 downto 0);
			  dst : in STD_LOGIC_VECTOR (3 downto 0);
			  wr_data : in  STD_LOGIC_VECTOR (23 downto 0);
			  exdst : in STD_LOGIC_VECTOR (3 downto 0);
			  dmemread : in STD_LOGIC;
				---------------
           reg1 : out  STD_LOGIC_VECTOR (23 downto 0);
           reg2 : out  STD_LOGIC_VECTOR (23 downto 0);
			  src1 : out  STD_LOGIC_VECTOR (3 downto 0);  -- regster address
			  src2 : out  STD_LOGIC_VECTOR (3 downto 0);
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
end component;

component id2excode is
port (
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  opcode : in STD_LOGIC_vector (5 downto 0);
			  reg1 : in  STD_LOGIC_VECTOR (23 downto 0);
           reg2 : in  STD_LOGIC_VECTOR (23 downto 0);
			  src1 : in  STD_LOGIC_VECTOR (3 downto 0);  -- regster address
			  src2 : in  STD_LOGIC_VECTOR (3 downto 0);
			  dst : in  STD_LOGIC_VECTOR (3 downto 0);
			  st_valuein : in STD_LOGIC_VECTOR (23 downto 0);
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
			  reg1out : out  STD_LOGIC_VECTOR (23 downto 0); --alu value
           reg2out : out  STD_LOGIC_VECTOR (23 downto 0);
			  src1out : out  STD_LOGIC_VECTOR (3 downto 0);  -- regster address
			  src2out : out  STD_LOGIC_VECTOR (3 downto 0);
			  dstout : out  STD_LOGIC_VECTOR (3 downto 0);
			  st_valueout : out  STD_LOGIC_VECTOR (23 downto 0);
           memtoregout : out  STD_LOGIC;
           memwriteout : out  STD_LOGIC;
           memreadout : out  STD_LOGIC;
           branchout : out  STD_LOGIC;
			  alucontrolout : out  STD_LOGIC_VECTOR (2 downto 0);
			  pcout : out STD_LOGIC_VECTOR (23 downto 0);
           regdstout : out  STD_LOGIC;
           regwriteout : out  STD_LOGIC;
			  opcodeout : out STD_LOGIC_Vector (5 downto 0));
			  
end component;

component executestagecode is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  opcode : in STD_LOGIC_VECTOR (5 downto 0);
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
           regwrite : out  STD_LOGIC;
			  memtoregout : out  STD_LOGIC;
           aluresult : out  STD_LOGIC_VECTOR (23 downto 0);
			  st_valueout : out  STD_LOGIC_VECTOR (23 downto 0);
           pcexecout : out  STD_LOGIC_VECTOR (23 downto 0);
           dstout : out  STD_LOGIC_VECTOR (3 downto 0);
           memreadout : out  STD_LOGIC;
			  branchout : out  STD_LOGIC;
           memwriteout : out  STD_LOGIC);
end component;


component exe2memcode is
port (	  aluresult : in  STD_LOGIC_VECTOR (23 downto 0);
           pcexe : in  STD_LOGIC_VECTOR (23 downto 0);
			  st_value : in STD_LOGIC_VECTOR (23 downto 0);
           dstin : in  STD_LOGIC_VECTOR (3 downto 0);
           memreadin : in  STD_LOGIC;
           memwritein : in  STD_LOGIC;
			  branchin : in  STD_LOGIC;
			  regwritein : in  STD_LOGIC;
			  memtoregin : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ---output---
			  aluresultout: out STD_LOGIC_VECTOR (23 downto 0);
			  st_valueout : out  STD_LOGIC_VECTOR (23 downto 0);
			  memtoregout : out  STD_LOGIC;
			  pcexeout : out  STD_LOGIC_VECTOR (23 downto 0);
			  dstout : out  STD_LOGIC_VECTOR (3 downto 0);
           memreadout : out  STD_LOGIC;
			  branchout : out  STD_LOGIC;
           memwriteout : out  STD_LOGIC;
			  regwriteout : out STD_LOGIC
			  );
end component;

component mem_stage_code is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           memtoreg : in  STD_LOGIC;
           memread : in  STD_LOGIC;
           memwrite : in  STD_LOGIC;
			  regwrite : in STD_LOGIC;
			  branchin : in STD_LOGIC;
			  dst : in STD_LOGIC_VECTOR (3 downto 0);
           aluresult : in  STD_LOGIC_VECTOR (23 downto 0);
           pc : in  STD_LOGIC_VECTOR (23 downto 0);
			  st_value : in  STD_LOGIC_VECTOR (23 downto 0);
			  --output--
           memdataout : out  STD_LOGIC_VECTOR (23 downto 0);
           pcmemout : out  STD_LOGIC_VECTOR (23 downto 0);
           memtoregout : out  STD_LOGIC;
			  regwriteout : out STD_LOGIC;
			  branchout : out STD_LOGIC;
			  dstout : out STD_LOGIC_VECTOR (3 downto 0);
           aluresultout : out  STD_LOGIC_VECTOR (23 downto 0);
			  			  wbdata: out std_logic_vector(23 downto 0));
			  
end component;

component mem2wb_code is

port (  	  clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  memdatain : in  STD_LOGIC_VECTOR (23 downto 0);
           pcmemin : in  STD_LOGIC_VECTOR (23 downto 0);
           memtoregin : in  STD_LOGIC;
			  regwritein : in STD_LOGIC;
			  branchin : in STD_LOGIC;
			  dstin : in STD_LOGIC_VECTOR (3 downto 0);
           aluresultin : in  STD_LOGIC_VECTOR (23 downto 0);
				---- output ----
			  memdataout : out  STD_LOGIC_VECTOR (23 downto 0);
           pcmemout : out  STD_LOGIC_VECTOR (23 downto 0);
           memtoregout : out  STD_LOGIC;
			  regwriteout : out STD_LOGIC;
			  branchout : out STD_LOGIC;
			  dstout : out STD_LOGIC_VECTOR (3 downto 0);
           aluresultout : out  STD_LOGIC_VECTOR (23 downto 0));

end component;

component wb_stagecode is
port (clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  memdatain : in  STD_LOGIC_VECTOR (23 downto 0);
           pcwbin : in  STD_LOGIC_VECTOR (23 downto 0);
           memtoregin : in  STD_LOGIC;
			  regwritein : in STD_LOGIC;
			  branchin : in STD_LOGIC;
			  dstin : in STD_LOGIC_VECTOR (3 downto 0);
           aluresultin : in  STD_LOGIC_VECTOR (23 downto 0);
			  -- output--
			  pcwbout : out STD_LOGIC_VECTOR (23 downto 0);
			  wbdata : out  STD_LOGIC_VECTOR (23 downto 0);
			  dstout : out STD_LOGIC_VECTOR (3 downto 0);
			  branchout : out STD_LOGIC;
			  regwriteout : out STD_LOGIC);
end component;

-- fetch --
signal pcsignal : STD_LOGIC_VECTOR (23 downto 0);
signal branchsignalwb : STD_LOGIC ;
signal pcsignalout : STD_LOGIC_VECTOR (23 downto 0) ;
signal instsignalin : STD_LOGIC_VECTOR (23 downto 0) ;
signal pcsignaloutfstate : STD_LOGIC_VECTOR (23 downto 0) ;
signal instsignalind : STD_LOGIC_VECTOR (23 downto 0) ;
--decode stage--
signal reg1d : STD_LOGIC_VECTOR (23 downto 0) ;
signal reg2d : STD_LOGIC_VECTOR (23 downto 0) ;
signal src1d : STD_LOGIC_VECTOR (3 downto 0) ;
signal src2d : STD_LOGIC_VECTOR (3 downto 0) ;
signal dstd : STD_LOGIC_VECTOR (3 downto 0) ;
signal memtoregd : STD_LOGIC ;
signal memwrited : STD_LOGIC ;
signal memreadd : STD_LOGIC ;
signal pcwrite : STD_LOGIC ;
signal if2dwrite : STD_LOGIC ;
signal alucontrold : STD_LOGIC_VECTOR (2 downto 0) ;
signal st_valued : STD_LOGIC_VECTOR (23 downto 0) ;
signal signoutd : STD_LOGIC_VECTOR (23 downto 0) ;
signal regdstd : STD_LOGIC ;
signal regwrited : STD_LOGIC ;
signal branchsignald : STD_LOGIC ;
signal pcsignaloutdstate : STD_LOGIC_VECTOR (23 downto 0) ;
signal opcodesignald : STD_LOGIC_VECTOR (5 downto 0) ;
--de2ex--
signal reg1e : STD_LOGIC_VECTOR (23 downto 0) ;
signal reg2e : STD_LOGIC_VECTOR (23 downto 0) ;
signal src1e : STD_LOGIC_VECTOR (3 downto 0) ;
signal src2e : STD_LOGIC_VECTOR (3 downto 0) ;
signal dste : STD_LOGIC_VECTOR (3 downto 0) ;
signal memtorege : STD_LOGIC ;
signal memwritee : STD_LOGIC ;
signal memreade : STD_LOGIC ;
signal alucontrole : STD_LOGIC_VECTOR (2 downto 0) ;
signal st_valuee : STD_LOGIC_VECTOR (23 downto 0) ;
signal signoute : STD_LOGIC_VECTOR (23 downto 0) ;
signal regdste : STD_LOGIC ;
signal branchsignale : STD_LOGIC ;
signal regwritee : STD_LOGIC ;
signal pcsignaloutestate : STD_LOGIC_VECTOR (23 downto 0) ;
signal opcodesignalde : STD_LOGIC_VECTOR (5 downto 0) ;
--- excute stage -----
signal aluresultes : STD_LOGIC_VECTOR (23 downto 0);
signal dstes : STD_LOGIC_VECTOR (3 downto 0);
signal memtoreges : STD_LOGIC ;
signal memwritees : STD_LOGIC ;
signal memreades : STD_LOGIC ;
signal st_valuees : STD_LOGIC_VECTOR (23 downto 0) ;
signal regdstes : STD_LOGIC ;
signal branchsignales : STD_LOGIC ;
signal regwritees : STD_LOGIC ;
signal pcsignaloutesstate : STD_LOGIC_VECTOR (23 downto 0) ;
signal opcodesignale : STD_LOGIC_VECTOR (5 downto 0) ;
--- exe2mem---
signal aluresultm : STD_LOGIC_VECTOR (23 downto 0);
signal dstm : STD_LOGIC_VECTOR (3 downto 0);
signal memtoregm : STD_LOGIC ;
signal memwritem : STD_LOGIC ;
signal memreadm : STD_LOGIC ;
signal st_valuem : STD_LOGIC_VECTOR (23 downto 0) ;
signal regdstem : STD_LOGIC ;
signal branchsignalm : STD_LOGIC ;
signal regwritem : STD_LOGIC ;
signal pcsignaloutmstate : STD_LOGIC_VECTOR (23 downto 0) ;
--- mems--
signal memdatams : STD_LOGIC_VECTOR (23 downto 0);
signal pcsignaloutmsstate : STD_LOGIC_VECTOR (23 downto 0) ;
signal memtoregms : STD_LOGIC;
signal regwritems : STD_LOGIC;
signal branchsignalms : STD_LOGIC;
signal dstms : STD_LOGIC_VECTOR (3 downto 0);
signal aluresultms : STD_LOGIC_VECTOR (23 downto 0);
-- memstate--
signal memdatawb : STD_LOGIC_VECTOR (23 downto 0);
signal pcsignaloutwbstate : STD_LOGIC_VECTOR (23 downto 0) ;
signal memtoregwb : STD_LOGIC;
signal regwritewb : STD_LOGIC;
signal branchsignalmss : STD_LOGIC;
signal dstwb : STD_LOGIC_VECTOR (3 downto 0);
signal aluresultwb : STD_LOGIC_VECTOR (23 downto 0);
signal wr_datawb : STD_LOGIC_VECTOR (23 downto 0);

---- wb------
signal branchsignalwbs : STD_LOGIC;
signal wr_datawb2 : STD_LOGIC_VECTOR (23 downto 0);
signal dstfinal : STD_LOGIC_VECTOR (3 downto 0);
signal regwritefinal : STD_LOGIC ;
begin
fetch : fetchstagecode port map (instsignalin,clk,rst,pcwrite,pcsignalout,pcsignaloutmsstate,branchsignalms);


if2d : if2idcode port map (clk,rst,if2dwrite,pcsignalout,instsignalin, pcsignaloutfstate,instsignalind);


decode : decodestagecode port map (instsignalind,clk,rst,regwritems,pcsignaloutfstate,dstms,wr_datawb,dste,memreade,
										     reg1d,reg2d,src1d,src2d,dstd,memtoregd,memwrited,memreadd,branchsignald,alucontrold, 
												st_valued,signoutd,pcsignaloutdstate,regdstd,regwrited,pcwrite,if2dwrite,opcodesignald);


id2ex : id2excode port map (clk,rst,opcodesignald,reg1d,reg2d,src1d,src2d,dstd,st_valued,memtoregd,memwrited,memreadd,branchsignald,alucontrold,signoutd,
									 pcsignaloutdstate,regdstd,regwrited,
									 reg1e,reg2e,src1e,src2e,dste,st_valuee,memtorege,memwritee,
									 memreade,branchsignale,alucontrole,pcsignaloutestate,regdste,regwritee,opcodesignalde);							 
									 


ex: executestagecode port map (clk,rst,opcodesignalde,reg1e,reg2e,src1e,src2e,dste,memtorege,memwritee,memreade,branchsignale,st_valuee,alucontrole,
				 						 pcsignaloutestate,regwritee,aluresultm,wr_datawb2,dstm,dstwb,regwritem,regwritewb,
								       regwritees,memtoreges,aluresultes,st_valuees,pcsignaloutesstate,
										 dstes,memreades,branchsignales,memwritees);


exs: exe2memcode port map ( aluresultes,pcsignaloutesstate,st_valuees,dstes,memreades,memwritees,branchsignales,regwritees,memtoreges,clk,rst,
									 aluresultm,st_valuem,memtoregm,pcsignaloutmstate,dstm,memreadm,branchsignalm,memwritem,regwritem);


mem: mem_stage_code port map (clk,rst,memtoregm,memreadm,memwritem,regwritem,branchsignalm,dstm,aluresultm,pcsignaloutmstate,st_valuem,
										 memdatams,pcsignaloutmsstate,memtoregms,regwritems,branchsignalms,dstms,aluresultms,wr_datawb);



mems : mem2wb_code port map  (clk,rst,memdatams,pcsignaloutmsstate,memtoregms,regwritems,branchsignalms,dstms,aluresultms,
										memdatawb,pcsignaloutwbstate,memtoregwb,regwritewb,branchsignalmss,dstwb,aluresultwb);


									
wb : wb_stagecode port map (clk,rst,memdatawb,pcsignaloutwbstate,memtoregwb,regwritewb,branchsignalmss,dstwb,aluresultwb,
								     pcsignal,wr_datawb2,dstfinal,branchsignalwbs,regwritefinal);
										
end Behavioral;
