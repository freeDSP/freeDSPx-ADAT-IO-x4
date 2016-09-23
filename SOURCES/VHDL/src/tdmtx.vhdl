----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Raphael Knoop
-- 
-- Create Date:    23/09/2016 
-- Design Name: 
-- Module Name:    tdm tx - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 8 channel TDM transmitter
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tdmtx is
  port ( clk     : in  std_logic;                                    -- Systemtakt (24,576MHz)
         rst     : in  std_logic;                                    -- Systemreset
         icntr   : in  unsigned(8 downto 0);                         -- Ablaufzähler
         ce12M   : in  std_logic;                                    -- Clock-Enable Bittakt (12,288MHz)
         ce48k   : in  std_logic;                                    -- Clock-Enable Worttakt (48kHz)
         chn1    : in  std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 1
         chn2    : in  std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 2
         chn3    : in  std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 3
         chn4    : in  std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 4
         chn5    : in  std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 5
         chn6    : in  std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 6
         chn7    : in  std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 7
         chn8    : in  std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 8
         tdmout : out std_logic );                                   -- TDM-Signal
end tdmtx;

architecture Behavioral of tdmtx is
  signal shiftreg : std_logic_vector(255 downto 0);
  
begin
  
  -- TDM-Frame senden
  processTDMtx : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        shiftreg <= (others => '0');
        
      elsif ce12M = '1' then
        
        if ce48k = '1' then
          shiftreg( 255 downto 232 ) <= chn1;
          shiftreg( 223 downto 200 ) <= chn2;
          shiftreg( 191 downto 168 ) <= chn3;
          shiftreg( 159 downto 136 ) <= chn4;
          shiftreg( 127 downto 104 ) <= chn5;
          shiftreg(  95 downto  72 ) <= chn6;
          shiftreg(  63 downto  40 ) <= chn7;
          shiftreg(  31 downto   8 ) <= chn8;
          tdmout <= chn1(23);
        else
          tdmout <= shiftreg(254);
          shiftreg(255 downto 1) <= shiftreg(254 downto 0);
        end if;
        
      end if;
    end if;
  end process;    
  
end Behavioral;
