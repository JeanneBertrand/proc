----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:27:44 04/20/2020 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC;
           CTRL_ALU : in  STD_LOGIC_VECTOR (2 downto 0));
end alu;

architecture Behavioral of alu is
	signal resultat_add : std_logic_vector(8 downto 0) ; 
	signal resultat_sub : std_logic_vector(8 downto 0) ; 
	signal resultat_mul : std_logic_vector(15 downto 0) ; 
begin
	
	resultat_add <= (b"0" & A) + (b"0" & B);
	resultat_sub <= (b"0" & A) - (b"0" & B);
	resultat_mul <= A * B; 
	
	S <= resultat_add(7 downto 0) when (CTRL_ALU = "001") else
			resultat_sub(7 downto 0) when (CTRL_ALU = "011") else
			resultat_mul(7 downto 0) ; --when (CTRL_ALU = "010") ;
		
	--flags 
	C <= resultat_add(8) ; 
--	N <= resultat_add(7) when (CTRL_ALU = "001") else
--			resultat_sub(7) when (CTRL_ALU = "011") else
--			resultat_mul(7) ;
	Z <= '0' when (resultat_add = X"00" or resultat_sub = X"00" or resultat_mul = X"00") ; 
	O <= resultat_mul(8) ;
--			il faut utiliser des guillemets pour des bus de signaux
--			le if est utilisable dans des process
--					process 
--					begin
--						
--						if 
--					end
--			dans un process, laffectation est effective a la fin de levaluation du process
end Behavioral;

