----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:07:21 04/30/2020 
-- Design Name: 
-- Module Name:    memdata - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memdata is
    Port ( ADDR : in  STD_LOGIC_VECTOR (7 downto 0);
           I : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OT : out  STD_LOGIC_VECTOR (7 downto 0));
end memdata;

architecture Behavioral of memdata is
	type data_array is
			 array (integer range 255 downto 0)
			 of std_logic_vector (7 downto 0);
		signal data: data_array := (255=> X"A2", others => X"00") ;
begin
process
begin
	wait until CLK'event and CLK = '0' ; 
	if (RST='0') then
		data <= (others => X"00") ;
	elsif (RW = '1') then --read
		OT <= data(to_integer(UNSIGNED(ADDR))) ; 
	elsif (RW='0') then --write
		data(to_integer(UNSIGNED(ADDR))) <= I ; 
	end if ; 		
end process ; 


end Behavioral;

