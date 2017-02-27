library ieee;
use ieee.std_logic_1164.all;

entity gamma is
    port(data_in:  in std_logic_vector(63 downto 0);
         data_out: out std_logic_vector(63 downto 0)
    );
end gamma;

architecture structural of gamma is
    component sbox0
        port(s0_in:  in std_logic_vector(3 downto 0);
             s0_out: out std_logic_vector(3 downto 0)
        );
    end component;

    component sbox1
        port(s1_in:  in std_logic_vector(3 downto 0);
             s1_out: out std_logic_vector(3 downto 0)
        );
    end component;

    component sbox2
        port(s2_in:  in std_logic_vector(3 downto 0);
             s2_out: out std_logic_vector(3 downto 0)
        );
    end component;

    component sbox3
        port(s3_in:  in std_logic_vector(3 downto 0);
             s3_out: out std_logic_vector(3 downto 0)
        );
    end component;

    begin
        A0: sbox0 port map(
            s0_in => data_in(63 downto 60),
            s0_out => data_out(63 downto 60)
        );
        A1: sbox1 port map(
            s1_in => data_in(59 downto 56),
            s1_out => data_out(59 downto 56)
        );
        A2: sbox2 port map(
            s2_in => data_in(55 downto 52),
            s2_out => data_out(55 downto 52)
        );
        A3: sbox3 port map(
            s3_in => data_in(51 downto 48),
            s3_out => data_out(51 downto 48)
        );
        A4: sbox1 port map(
            s1_in => data_in(47 downto 44),
            s1_out => data_out(47 downto 44)
        );
        A5: sbox2 port map(
            s2_in => data_in(43 downto 40),
            s2_out => data_out(43 downto 40)
        );
        A6: sbox3 port map(
            s3_in => data_in(39 downto 36),
            s3_out => data_out(39 downto 36)
        );
        A7: sbox0 port map(
            s0_in => data_in(35 downto 32),
            s0_out => data_out(35 downto 32)
        );
        A8: sbox2 port map(
            s2_in => data_in(31 downto 28),
            s2_out => data_out(31 downto 28)
        );
        A9: sbox3 port map(
            s3_in => data_in(27 downto 24),
            s3_out => data_out(27 downto 24)
        );
        A10: sbox0 port map(
            s0_in => data_in(23 downto 20),
            s0_out => data_out(23 downto 20)
        );
        A11: sbox1 port map(
            s1_in => data_in(19 downto 16),
            s1_out => data_out(19 downto 16)
        );
        A12: sbox3 port map(
            s3_in => data_in(15 downto 12),
            s3_out => data_out(15 downto 12)
        );
        A13: sbox0 port map(
            s0_in => data_in(11 downto 8),
            s0_out => data_out(11 downto 8)
        );
        A14: sbox1 port map(
            s1_in => data_in(7 downto 4),
            s1_out => data_out(7 downto 4)
        );
        A15: sbox2 port map(
            s2_in => data_in(3 downto 0),
            s2_out => data_out(3 downto 0)
        );
    end architecture;
