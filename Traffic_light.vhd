library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity traffic is
    port(
        CLK : in std_logic;
        RESET : in std_logic
    );
end traffic;

architecture traffic_arch of traffic is
    -- component.
    -- components are listed here, and connected inside begin.
    component delay is
        port(
            CLK : in std_logic;
            RST : in std_logic;
            DELAY : in std_logic;
            DONE : out std_logic 
        );
    end component; 

    -- type
    -- type my_array array(1 to 3) of range (3 downto 0);

    type traffic_state_type is (initial,red,yellow,green);
    signal traffic_st : traffic_state_type;


    --signals
    signal delay_sig : std_logic;
    signal done_sig : std_logic;
    -- signal count : std_logic_vector(6 downto 0);
    signal direction_sig : std_logic;

    begin
        delay_comp : delay
        port map(
            CLK => CLK,
            RST => RESET,
            DELAY => delay_sig,
            DONE => done_sig
        );

        -- process
        process (CLK,RESET) is
            begin
            if (RESET = '0') then
                traffic_st <= initial;
                delay_sig <= '0';
                direction_sig <= '0';
            elsif rising_edge(CLK) then
                case traffic_st is
                    when initial =>
                        delay_sig <= '0';
                        direction_sig <= '0';
                        traffic_st <= red;

                    when red =>
                        direction_sig <= '0';
                        if done_sig = '1' then
                            delay_sig <= '0';
                            traffic_st <= yellow;
                        else
                            delay_sig <= '1';
                            traffic_st <= traffic_st;
                        end if;

                    when yellow =>
                        direction_sig <= direction_sig;
                        if done_sig = '1' then
                            delay_sig <= '0';
                            if direction_sig = '1' then
                                traffic_st <= red;
                            else
                                traffic_st <= green; 
                            end if;    
                        else
                            delay_sig <= '1';
                            traffic_st <= traffic_st;
                        end if;        

                    when green =>
                        direction_sig <= '1';
                        if done_sig = '1' then
                            delay_sig <= '0';
                            traffic_st <= yellow;
                        else
                            delay_sig <= '1';
                            traffic_st <= traffic_st;
                        end if; 
                     
                    when others =>
                        traffic_st <= initial;    
                end case;   
            end if;                            
        end process;
end traffic_arch;         

