library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity traffic_tb is
end traffic_tb;

architecture traffic_tb_arch of traffic_tb is
    component traffic is
        port(
            CLK : in std_logic;
            RESET : in std_logic
        );
    end component;

    signal clk_sig : std_logic := '0';
    signal reset_sig : std_logic;

begin
    traffic_top : traffic 
        port map(
            CLK => clk_sig,
            RESET => reset_sig
        );

    clk_sig <= not clk_sig after 50 ns;
    -- abstract is 50 and literal is ns they should have space
    reset_sig <= '0', '1' after 1 us;
end traffic_tb_arch;



