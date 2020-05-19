----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:02:55 04/15/2020 
-- Design Name: 
-- Module Name:    meminstruc - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity meminstruc is
    Port ( ADDR : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           OT : out  STD_LOGIC_VECTOR (31 downto 0));
end meminstruc;

architecture Behavioral of meminstruc is

	type instructions_array is
		 array (integer range 255 downto 0)
		 of std_logic_vector (31 downto 0);
	signal instructions: instructions_array := (0 => X"06010A00", 1 => X"050F0100", 2=> X"01030F01", 3=> X"03050301", 4=> X"020A0F05", 5=>X"0702FF00", 6=>X"08FE0A00", others => X"00000000") ;
begin
process
begin
	wait until CLK'event and CLK='1' ; 
		OT <= instructions(to_integer(UNSIGNED(ADDR))) ; 
	--A=op=b=c 8bits
	--a=1er argument, b 2e etc. 
	end process ; 
end Behavioral;

