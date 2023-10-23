library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use std.textio.all;

entity alu_tb is
end alu_tb;

architecture behavior of alu_tb is
    -- Constants
    constant bus_size : integer := 8;

    -- Declare our component
    component AL_UNIT
        port (
            A, B : in std_logic_vector(bus_size - 1 downto 0);
            OP : in std_logic_vector(3 downto 0);
            F : out std_logic_vector(bus_size - 1 downto 0)
        );
    end component;
    
    -- Bind to the component
    for ALU_0: AL_UNIT use entity work.AL_UNIT;
    signal A, B, F : std_logic_vector(7 downto 0);
    signal OP : std_logic_vector(3 downto 0);
begin
    -- Initialize component
    ALU_0: AL_UNIT port map(A => A, B => B, OP => OP, F => F);
    
    process
        type pattern_type is record
            A, B : integer;
            F : integer;
            OP : std_logic_vector(3 downto 0);
        end record;
        
        -- Put your patterns here
        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns: pattern_array := (
            -- Add tests
            ( 4, 5, 9, "0000" ),
            ( 8, 3, 11, "0000" ),
            -- Subtract tests
            ( 10, 5, 5, "0001" ),
            ( 7, 3, 4, "0001" ),
            ( 3, 11, -8, "0001" ),
            -- AND tests
            ( 1, 1, 1, "0100" ),
            ( 0, 1, 0, "0100" ),
            ( 7, 4, 4, "0100" ),
            ( 100, 43, 32, "0100" ),
            -- OR tests
            ( 0, 0, 0, "0101" ),
            ( 1, 0, 1, "0101" ),
            ( 1, 1, 1, "0101" ),
            ( 3, 4, 7, "0101" ),
            ( 8, 7, 15, "0101" ),
            -- XOR tests
            ( 1, 1, 0, "0110" ),
            ( 1, 4, 5, "0110" ),
            ( 127, 1, 126, "0110" ),
            -- NOT tests
            ( 1, 0, -2, "0111" ),
            ( 4, 0, -5, "0111" ),
            ( -3, 0, 2, "0111" ),
            -- 2's complement
            ( 1, 0, -1, "1000" ),
            -- Increment
            ( 1, 0, 2, "1001" ),
            ( -1, 0, 0, "1001" ),
            ( 10, 0, 11, "1001" ),
            -- Decrement
            ( 1, 0, 0, "1010" ),
            ( 0, 0, -1, "1010" ),
            ( 10, 0, 9, "1010" )
            );
            
        variable l : line;
    begin
        wait for 100 ns;
        
        -- Verify each pattern
        for i in patterns'range loop
            A <= conv_std_logic_vector(patterns(i).A, bus_size);
            B <= conv_std_logic_vector(patterns(i).B, bus_size);
            OP <= patterns(i).OP;
            wait for 100 ns;
            
            -- Debug code
            --write(l, String'("Result: "));
            --write(l, to_bitvector(F));
            --writeline(output, l);
        
            assert F = patterns(i).F report "Test failed." severity error;
        end loop;
        
        assert false report "" severity note;
        assert false report "Test completed." severity note;
        assert false report "" severity note;
        wait;
        
    end process;
end architecture;

