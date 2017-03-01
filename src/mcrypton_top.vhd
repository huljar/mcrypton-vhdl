library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mcrypton_top is
    port(plaintext:  in std_logic_vector(63 downto 0);
         key:        in std_logic_vector(95 downto 0);
         clk:        in std_logic;
         reset:      in std_logic;
         ciphertext: out std_logic_vector(63 downto 0)
    );
end mcrypton_top;

architecture behavioral of mcrypton_top is
    signal data_state,
           data_sigma,
           data_gamma,
           data_pi,
           data_tau: std_logic_vector(63 downto 0);
    signal key_state,
           key_updated: std_logic_vector(95 downto 0);
    signal round_key: std_logic_vector(63 downto 0);
    signal round_counter: std_logic_vector(3 downto 0);
    signal final_tau1,
           final_pi,
           final_tau2: std_logic_vector(63 downto 0);

    component gamma
        port(data_in:  in std_logic_vector(63 downto 0);
             data_out: out std_logic_vector(63 downto 0)
        );
    end component;

    component pi
        port(data_in:  in std_logic_vector(63 downto 0);
             data_out: out std_logic_vector(63 downto 0)
        );
    end component;

    component tau
        port(data_in:  in std_logic_vector(63 downto 0);
             data_out: out std_logic_vector(63 downto 0)
        );
    end component;

    component key_schedule
        port(data_in:       in std_logic_vector(95 downto 0);
             round_counter: in std_logic_vector(3 downto 0);
             data_out:      out std_logic_vector(95 downto 0);
             round_key:     out std_logic_vector(63 downto 0)
        );
    end component;

    begin
        GL: gamma port map(
            data_in => data_sigma,
            data_out => data_gamma
        );

        PL: pi port map(
            data_in => data_gamma,
            data_out => data_pi
        );

        TL: tau port map(
            data_in => data_pi,
            data_out => data_tau
        );

        KS: key_schedule port map(
            data_in => key_state,
            round_counter => round_counter,
            data_out => key_updated,
            round_key => round_key
        );

        FINAL_T1: tau port map(
            data_in => final_tau1,
            data_out => final_pi
        );

        FINAL_PI: pi port map(
            data_in => final_pi,
            data_out => final_tau2
        );

        FINAL_T2: tau port map(
            data_in => final_tau2,
            data_out => ciphertext
        );

        data_sigma <= data_state xor round_key;

        process(clk, reset, plaintext, key)
        begin
            if reset = '1' then
                data_state <= plaintext;
                key_state <= key;
                round_counter <= "0000"; -- the initial key addition is round 0
                ciphertext <= x"0000000000000000";
            elsif rising_edge(clk) then
                data_state <= data_tau;
                key_state <= key_updated;
                round_counter
                    <= std_logic_vector((unsigned(round_counter) + 1) mod 13);

                final_tau1 <= data_sigma; -- TODO: use case statement?
            end if;
        end process;
    end architecture;
