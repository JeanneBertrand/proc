--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:11:24 04/30/2020
-- Design Name:   
-- Module Name:   /home/ise/ael/memdata_test.vhd
-- Project Name:  ael
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memdata
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY memdata_test IS
END memdata_test;
 
ARCHITECTURE behavior OF memdata_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memdata
    PORT(
         ADDR : IN  std_logic_vector(7 downto 0);
         I : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         OT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ADDR : std_logic_vector(7 downto 0) := (others => '0');
   signal I : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal RST : std_logic := '1';
   signal CLK : std_logic := '0';

 	--Outputs
   signal OT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memdata PORT MAP (
          ADDR => ADDR,
          I => I,
          RW => RW,
          RST => RST,
          CLK => CLK,
          OT => OT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		ADDR <= X"34" ; 
		I <= X"12" ; 
		RW <= '0' ; 
		wait for 100 ns ;
		RW <= '1' ; 
		wait for 100 ns ;
		RST <= '0' ; 
		wait for 100 ns ;
		RST <= '1' ; 
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
