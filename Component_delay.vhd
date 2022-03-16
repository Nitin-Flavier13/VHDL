-- delay of 10u sec
-- freq of clock 10M Hz
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity delay is
    port(
        CLK : in std_logic;
        RST : in std_logic;
        DELAY : in std_logic;
        DONE : out std_logic
    );
end delay;

architecture delay_arch of delay is
    -- signal to increase the count upto 100;
    signal count : std_logic_vector(7 downto 0) ; -- "110"&X"4"
    -- 100 is given as "1100100".
    -- if std_logic_vector(7 to 0) then &X"64". hex
    begin
        --count <= (others => '0');
        process(CLK,RST) is
            begin
                if RST = '0' then
                    DONE <= '0';
                    count <= x"00"; -- count <= X"00";
                elsif rising_edge(CLK) then
                    if DELAY = '1' then
                        count <= count + '1';
                        if(count = X"63") then
                            DONE <= '1';
                        --    count <= X"00";
                        else
                            DONE <= '0'; 
                        end if;
                    else
                        count <= X"00"; 
                        DONE <= '0';    
                    end if;              
                end if;
        end process;
end delay_arch;

        