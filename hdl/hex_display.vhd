--
-- Company : TEIS AB
-- Engineer: Robin Riis
--
-- Create Date    : 2023-Mar-24 01:38
-- Design Name    : hex_display.vhd
-- Target Devices : DE10-Lite (ALTERA MAX 10: 10M50DAF484C7G)
-- Tool versions  : Quartus v18.1 and ModelSim
-- Testbench file : None
-- Do file        : None
--
-- History:
-----------
--  2023-03-24: something happend
--
-- Description:
---------------
--  this is a new file..
--
-- In_signals:
--------------
--  clock        : std_logic                    -- System clock XX MHz
--  reset_n      : std_logic                    -- reset switch, active low
--  data_in      : std_logic_vector(4..0)       -- data in
--  select_hex   : std_logic_vector(2..0)       -- select display
--  hex_displays : std_logic_vector(47..0)      -- data out
--
-- Out_signals:
---------------
--

library ieee;
use ieee.std_logic_1164.all;

entity hex_display is
  generic(
    reset_value : std_logic_vector(7 downto 0)
  );
  
  port(
    clock        : in  std_logic;
    reset_n      : in  std_logic;
    data_in      : in  std_logic_vector(4 downto 0);
    hex_display  : out std_logic_vector(7 downto 0)
  );
end entity hex_display;

architecture rtl of hex_display is
-- Graphical representation of segment display on DE10-Lite:
--
--     0
--    ___
-- 5 |   | 1
--   |___|
--   | 6 |
-- 4 |___| 2 (7)
--    
--     3
--
-- display segments are active low.
constant ZERO   : std_logic_vector(7 downto 0) := "11000000";
constant ONE    : std_logic_vector(7 downto 0) := "11111001";
constant TWO    : std_logic_vector(7 downto 0) := "10100100";
constant THREE  : std_logic_vector(7 downto 0) := "10110000";
constant FOUR   : std_logic_vector(7 downto 0) := "10011001";
constant FIVE   : std_logic_vector(7 downto 0) := "10010010";
constant SIX    : std_logic_vector(7 downto 0) := "10000011";
constant SEVEN  : std_logic_vector(7 downto 0) := "11111000";
constant EIGHT  : std_logic_vector(7 downto 0) := "10000000";
constant NINE   : std_logic_vector(7 downto 0) := "10011000";
constant E      : std_logic_vector(7 downto 0) := "10000110";
constant H      : std_logic_vector(7 downto 0) := "10001001";
constant r      : std_logic_vector(7 downto 0) := "10101111";
constant o      : std_logic_vector(7 downto 0) := "10100011";
constant L      : std_logic_vector(7 downto 0) := "11000111";
constant t      : std_logic_vector(7 downto 0) := "10000111";
constant UNDER  : std_logic_vector(7 downto 0) := "11110111";
constant OVER   : std_logic_vector(7 downto 0) := "11111110";
constant LSIDE  : std_logic_vector(7 downto 0) := "11001111";
constant MIDDLE : std_logic_vector(7 downto 0) := "10111111";
constant OFF    : std_logic_vector(7 downto 0) := "11111111";

signal hex_register : std_logic_vector(7 downto 0);

begin
  
  set_output : process(clock, reset_n)
  begin
    if reset_n = '0' then
      hex_register <= reset_value;
    elsif rising_edge(clock) then
      case data_in is
        when "00000" => hex_register <= ZERO;
        when "00001" => hex_register <= ONE;
        when "00010" => hex_register <= TWO;
        when "00011" => hex_register <= THREE;
        when "00100" => hex_register <= FOUR;
        when "00101" => hex_register <= FIVE;
        when "00110" => hex_register <= SIX;
        when "00111" => hex_register <= SEVEN;
        when "01000" => hex_register <= EIGHT;
        when "01001" => hex_register <= NINE;
        when "01010" => hex_register <= E;
        when "01011" => hex_register <= H;
        when "01100" => hex_register <= r;
        when "01101" => hex_register <= o;
        when "01110" => hex_register <= L;
        when "01111" => hex_register <= t;
        when "10000" => hex_register <= UNDER;
        when "10001" => hex_register <= OVER;
        when "10010" => hex_register <= LSIDE;
        when "10011" => hex_register <= MIDDLE;
        when others  => hex_register <= OFF;
      end case;
    end if;
  end process set_output;
  
  hex_display <= hex_register;
end architecture rtl;

