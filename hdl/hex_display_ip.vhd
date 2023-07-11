--
-- Company : TEIS AB
-- Engineer: Robin Riis
--
-- Create Date    : 2023-Mar-24 03:01
-- Design Name    : hex_display_ip.vhd
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
--  clock  : std_logic                    -- System clock XX MHz
--
-- Out_signals:
---------------
--

library ieee;
use ieee.std_logic_1164.all;

entity hex_display_ip is
  port(
    clk          : in  std_logic;
    reset_n      : in  std_logic;
    cs_n         : in  std_logic;
    addr         : in  std_logic_vector(2 downto 0);
    write_n      : in  std_logic;
    read_n       : in  std_logic;
    din          : in  std_logic_vector(31 downto 0);
    dout         : out std_logic_vector(31 downto 0);
    hex_displays : out std_logic_vector(47 downto 0)
  );
end entity hex_display_ip;

architecture rtl of hex_display_ip is
-- constants
-- signals
signal ctrl0,ctrl1,ctrl2,ctrl3,ctrl4,ctrl5 : std_logic_vector(4 downto 0);
signal data0,data1,data2,data3,data4,data5 : std_logic_vector(7 downto 0);

-- components
component hex_display is
  generic(
    reset_value : std_logic_vector(7 downto 0)
  );
  
  port(
    clock        : in  std_logic;
    reset_n      : in  std_logic;
    data_in      : in  std_logic_vector(4 downto 0);
    hex_display  : out std_logic_vector(7 downto 0)
  );
end component hex_display;

begin
  bus_register_read : process(cs_n, read_n, addr, data0, data1, data2, data3, data4, data5)
  -----------------
  -- output data register
  begin
    if cs_n = '0' and read_n = '0' then
      case addr is
        when "001"  => dout(7 downto 0) <= data0;
        when "010"  => dout(7 downto 0) <= data1;
        when "011"  => dout(7 downto 0) <= data2;
        when "100"  => dout(7 downto 0) <= data3;
        when "101"  => dout(7 downto 0) <= data4;
        when "110"  => dout(7 downto 0) <= data5;
        when others => dout(7 downto 0) <= (others => '0');
      end case;
    else
      dout <= (others => '0');
    end if;
  end process bus_register_read;
  
  bus_register_write : process(clk, reset_n)
  ------------------
  -- set control register
  begin
    if reset_n = '0' then
      ctrl0 <= (others => '1');
      ctrl1 <= (others => '1');
      ctrl2 <= (others => '1');
      ctrl3 <= (others => '1');
      ctrl4 <= (others => '1');
      ctrl5 <= (others => '1');
    elsif rising_edge(clk) then
      if cs_n='0' and write_n='0' then
        case addr is
          when "001"  => ctrl0 <= din(4 downto 0);
          when "010"  => ctrl1 <= din(4 downto 0);
          when "011"  => ctrl2 <= din(4 downto 0);
          when "100"  => ctrl3 <= din(4 downto 0);
          when "101"  => ctrl4 <= din(4 downto 0);
          when "110"  => ctrl5 <= din(4 downto 0);
          when others => null;
        end case;
      end if;
    end if;
  end process bus_register_write;
  
  seg_display0 : hex_display generic map(reset_value => "11111111") port map(
    clock        => clk,
    reset_n      => reset_n,
    data_in      => ctrl0,
    hex_display  => data0
  );
  
  seg_display1 : hex_display generic map(reset_value => "10000111") port map(
    clock        => clk,
    reset_n      => reset_n,
    data_in      => ctrl1,
    hex_display  => data1
  );
  
  seg_display2 : hex_display generic map(reset_value => "10000110") port map(
    clock        => clk,
    reset_n      => reset_n,
    data_in      => ctrl2,
    hex_display  => data2
  );
  
  seg_display3 : hex_display generic map(reset_value => "10010010") port map(
    clock        => clk,
    reset_n      => reset_n,
    data_in      => ctrl3,
    hex_display  => data3
  );
  
  seg_display4 : hex_display generic map(reset_value => "10000110") port map(
    clock        => clk,
    reset_n      => reset_n,
    data_in      => ctrl4,
    hex_display  => data4
  );
  
  seg_display5 : hex_display generic map(reset_value => "10101111") port map(
    clock        => clk,
    reset_n      => reset_n,
    data_in      => ctrl5,
    hex_display  => data5
  );
  
  hex_displays <= data5 & data4 & data3 & data2 & data1 & data0;
end architecture rtl;

