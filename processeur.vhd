----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:39:49 05/12/2020 
-- Design Name: 
-- Module Name:    processeur - Behavioral 
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

entity processeur is
    Port ( ADDRIP : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end processeur;

architecture Behavioral of processeur is
component meminstruc  
	Port ( ADDR : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           OT : out  STD_LOGIC_VECTOR (31 downto 0));
end component; 

component pipeline 
   Port (CLK : in STD_LOGIC ; 
			A : in  STD_LOGIC_VECTOR (7 downto 0);
           OP : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           C : in  STD_LOGIC_VECTOR (7 downto 0);
           Ao : out  STD_LOGIC_VECTOR (7 downto 0);
           OPo : out  STD_LOGIC_VECTOR (7 downto 0);
           Bo : out  STD_LOGIC_VECTOR (7 downto 0);
           Co : out  STD_LOGIC_VECTOR (7 downto 0));
end component; 

component registerbench  
    Port ( ADDRA : in  STD_LOGIC_VECTOR (3 downto 0);
           ADDRB : in  STD_LOGIC_VECTOR (3 downto 0);
           ADDRW : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component alu 
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC;
           CTRL_ALU : in  STD_LOGIC_VECTOR (2 downto 0));
end component ; 

component memdata 
Port ( ADDR : in  STD_LOGIC_VECTOR (7 downto 0);
           I : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OT : out  STD_LOGIC_VECTOR (7 downto 0));
end component ; 

component lc 
 Port ( OP : in  STD_LOGIC_VECTOR (7 downto 0);
           W : out  STD_LOGIC_VECTOR (3 downto 0));
end component ; 
	
for all: meminstruc	use entity work.meminstruc(Behavioral) ;
for all: pipeline 	use entity work.pipeline(Behavioral) ; 
for all: registerbench	use entity work.registerbench(Behavioral) ; 
for all: alu 			use entity work.alu(Behavioral) ; 
for all: memdata 		use entity work.memdata(Behavioral) ;
for all: lc 			use entity work.lc(Behavioral) ;  
 
signal f, g, h, i: STD_LOGIC ; 
signal w, w2, ctrl: STD_LOGIC_VECTOR(3 downto 0) ; 
signal OT: STD_LOGIC_VECTOR(31 downto 0); 
signal a1, op1, b1, addr, c1, b6, a2, op2, b2, ot2, c2, a3, op3, b3, c3, qa1, qb1, addrw, op4, data, c4,s, b5, ot1: STD_LOGIC_VECTOR(7 downto 0);
begin
	Comp1: meminstruc port map(ADDRIP, CLK, OT); 
	--A, OP, B,  C
	LI_DI: pipeline port map(CLK, OT(23 downto 16), OT(31 downto 24), OT(15 downto 8), OT(7 downto 0), a1, op1, b1, c1); 
	Comp2: registerbench port map(b1(3 downto 0), c1(3 downto 0), addrw(3 downto 0), w(0), data, RST, CLK, qa1, qb1) ; 
	--mux1
	ot1 <= b1 when op1=X"06" or op1=X"07" else
			qa1 when op1=X"08" or op1=X"05" or op1=X"01" or op1=X"02" or op1=X"03" or op1=X"04" ; 
	DI_EX: pipeline port map(CLK, a1, op1, ot1, qb1, a2, op2, b2, c2);
	Lc3: lc port map(op2, ctrl); 
	Comp3: alu port map(b2, c2, s, f, g, h, i, ctrl(3 downto 1) );  
	--mux2
	ot2 <= b2 when op2=X"08" or op2=X"06" or op2=X"05" or  op2=X"07" else
			s when op2=X"01" or op2=X"02" or op2=X"03" or op2=X"04" ; 	
	EX_Mem: pipeline port map(CLK, a2, op2, ot2, c2, a3, op3, b3, c3);
	--mux 
	addr <= a3 when op3=X"08" else
			b3 ;
	Lc2: lc port map(op3, w2); 
	Comp4: memdata port map(addr, b3, w2(0), RST, CLK, b5) ; 
	--mux3
	b6 <= b5 when op3=X"07" else
			b3 when op3=X"05" or op3=X"01" or op3=X"02" or op3=X"03" or op3=X"06" or op3=X"04" ; 
	Mem_RE: pipeline port map(CLK, a3, op3, b6, c3, addrw, op4, data, c4) ; 
	Lc1: lc port map(op4, w);
	
end Behavioral;

