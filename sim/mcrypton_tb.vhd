--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:58:04 03/01/2017
-- Design Name:   
-- Module Name:   /home/julian/Projekt/Xilinx Projects/mcrypton-vhdl/sim/mcrypton_tb.vhd
-- Project Name:  mcrypton-vhdl
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mcrypton_top
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
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE work.util.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY mcrypton_tb IS
END mcrypton_tb;
 
ARCHITECTURE behavior OF mcrypton_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mcrypton_top
    GENERIC(
         k : key_enum
    );
    PORT(
         plaintext : IN  std_logic_vector(63 downto 0);
         key : IN  std_logic_vector(95 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         ciphertext : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal plaintext : std_logic_vector(63 downto 0) := (others => '0');
   signal key : std_logic_vector(95 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal ciphertext : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mcrypton_top GENERIC MAP (
          k => K_96
        ) PORT MAP (
          plaintext => plaintext,
          key => key,
          clk => clk,
          reset => reset,
          ciphertext => ciphertext
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
      variable ct: line;
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
      
      reset <= '1';
      plaintext <= x"0000000000000000";
      key <= x"000000000000000000000000";
      wait for 10 ns;
      reset <= '0';
      wait for 130 ns;
      hwrite(ct, ciphertext);
      report "Ciphertext is " & ct.all & " (expected value: unknown)";
      deallocate(ct);

      wait;
   end process;

END;
