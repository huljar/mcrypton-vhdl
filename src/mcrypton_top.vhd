library ieee;
use ieee.std_logic_1164.all;

entity mcrypton_top is
    port(plaintext:  in std_logic_vector(63 downto 0);
         key:        in std_logic_vector(95 downto 0);
         clk:        in std_logic;
         reset:      in std_logic;
         ciphertext: out std_logic_vector(63 downto 0)
    );
end mcrypton_top;

architecture behavioral of mcrypton_top is
    begin
    end architecture;
