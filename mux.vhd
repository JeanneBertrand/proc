----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:07:55 05/12/2020 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux is
    Port ( OP : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA1 : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA2 : in  STD_LOGIC_VECTOR (7 downto 0);
           OT : out  STD_LOGIC_VECTOR (7 downto 0));
end mux;

architecture Behavioral of mux is

begin
OT <= DATA1 when OP=X"06" or OP=X"07" else
		DATA2 when OP=X"05" or OP=X"01" or OP=X"02" or OP=X"03" or OP=X"04" ; 


end Behavioral;

