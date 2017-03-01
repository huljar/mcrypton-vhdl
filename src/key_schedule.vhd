library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity key_schedule is
    port(data_in:       in std_logic_vector(95 downto 0);
         round_counter: in std_logic_vector(3 downto 0);
         data_out:      out std_logic_vector(95 downto 0);
         round_key:     out std_logic_vector(63 downto 0)
    );
end key_schedule;

architecture structural of key_schedule is
    type masking_words is array(0 to 3) of std_logic_vector(15 downto 0);
    constant masks: masking_words := (x"F000", x"0F00", x"00F0", x"000F");

    type round_constants is array(0 to 15) of std_logic_vector(3 downto 0);
    constant rcs: round_constants := ("0001", "0010", "0100", "1000",
                                      "0011", "0110", "1100", "1011",
                                      "0101", "1010", "0111", "1110",
                                      "1111", "0000", "0000", "0000");

    signal T_tmp: std_logic_vector(15 downto 0);
    signal T: std_logic_vector(15 downto 0);

    signal T0, T1, T2, T3: std_logic_vector(15 downto 0);

    component sbox0
        port(data_in:  in std_logic_vector(3 downto 0);
             data_out: out std_logic_vector(3 downto 0)
        );
    end component;

    begin
        GEN_T: for i in 0 to 3 generate
            -- S(U[0]) ...
            SX: sbox0 port map(
                data_in => data_in(95 - 4*i downto 95 - 4*i - 3),
                data_out => T_tmp(15 - 4*i downto 15 - 4*i - 3)
            );
            -- ... xor C[r]
            T(15 - 4*i downto 15 - 4*i - 3)
                <= T_tmp(15 - 4*i downto 15 - 4*i - 3)
                   xor rcs(to_integer(unsigned(round_counter)));
        end generate;

        T0 <= T and masks(0);
        T1 <= T and masks(1);
        T2 <= T and masks(2);
        T3 <= T and masks(3);

        round_key <= (data_in(79 downto 64) xor T0) & -- U[1] xor T0
                     (data_in(63 downto 48) xor T1) & -- U[2] xor T1
                     (data_in(47 downto 32) xor T2) & -- U[3] xor T2
                     (data_in(31 downto 16) xor T3);  -- U[4] xor T3

        data_out <= data_in(15 downto 0) &                          -- U[5]
                    data_in(92 downto 80) & data_in(95 downto 93) & -- U[0] << 3
                    data_in(79 downto 64) &                         -- U[1]
                    data_in(63 downto 48) &                         -- U[2]
                    data_in(39 downto 32) & data_in(47 downto 40) & -- U[3] << 8
                    data_in(31 downto 16);                          -- U[4]
    end architecture;
