----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:16:52 04/15/2020 
-- Design Name: 
-- Module Name:    registerbench - Behavioral 
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
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registerbench is
    Port ( ADDRA : in  STD_LOGIC_VECTOR (3 downto 0);
           ADDRB : in  STD_LOGIC_VECTOR (3 downto 0);
           ADDRW : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end registerbench;

architecture Behavioral of registerbench is

type registers_array is
    array (integer range 15 downto 0)
    of std_logic_vector (7 downto 0);
signal registers: registers_array := (others => X"00") ;

begin
lecture: process (ADDRA, ADDRB)
begin
	if (W = '1') then
		if (ADDRW = ADDRA) then
			QA <= DATA ;
			QB <= registers(to_integer(UNSIGNED(ADDRB))) ; 
		elsif (ADDRW = ADDRB) then
			QB <= DATA ;
			QA <= registers(to_integer(UNSIGNED(ADDRA))) ; 			
		else 
			QA <= registers(to_integer(UNSIGNED(ADDRA))) ; 
			QB <= registers(to_integer(UNSIGNED(ADDRB))) ; 
		end if;		
	else 
		QA <= registers(to_integer(UNSIGNED(ADDRA))) ; 
		QB <= registers(to_integer(UNSIGNED(ADDRB))) ; 
	end if ; 
end process lecture; 

ecriture: process 
begin
	wait until CLK'event and CLK='1' ;
	if (RST='0') then
		registers <= (others => X"00") ; 
	elsif (W = '1') then
		registers(to_integer(UNSIGNED(ADDRW))) <= DATA ; 
	end if; 
end process ecriture;
 
end Behavioral;











