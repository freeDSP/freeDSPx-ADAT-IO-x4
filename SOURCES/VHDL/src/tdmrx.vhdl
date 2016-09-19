----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18/09/2016 
-- Design Name: 
-- Module Name:    tdm rx - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 8-channel TDM Receiver
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

entity tdmrx is
  port ( clk     : in  std_logic;                                     -- Systemtakt (24,576MHz)
         rst     : in  std_logic;                                     -- Systemreset
         ce12M   : in  std_logic;                                     -- Clock-Enable Bittakt (12,288MHz)
         ce48k   : in  std_logic;                                     -- Clock-Enable Worttakt (48kHz)
         tdmin   : in  std_logic;                                     -- TDM-Eingangssignal
         chn1    : out std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 1
         chn2    : out std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 2
         chn3    : out std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 3
         chn4    : out std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 4
         chn5    : out std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 5
         chn6    : out std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 6
         chn7    : out std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 7
         chn8    : out std_logic_vector(23 downto 0) );               -- 24Bit-Wort Kanal 8
end tdmrx;

architecture Behavioral of tdmrx is
	signal shiftreg : std_logic_vector(255 downto 0);                  -- Schieberegister zum Epmpfangen der Daten
	
begin
	
	shiftreg_proc : process(clk)
	begin
		if rising_edge(clk) then
			if rst ='1' then
				shiftreg <= (others => '0');
				
			else
				if ce12M = '1' then
					shiftreg(255 downto 1) <= shiftreg(254 downto 0);
					shiftreg(0) <= tdmin;
					
				end if;
			end if;			
		end if;
	end process;
	
	unpack_proc : process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				chn1 <= (others => '0');
				chn2 <= (others => '0');
				chn3 <= (others => '0');
				chn4 <= (others => '0');
				chn5 <= (others => '0');
				chn6 <= (others => '0');
				chn7 <= (others => '0');
				chn8 <= (others => '0');
		  
			elsif ce48k = '1' then
				-- 24Bit, Left-Justified
				chn1 <= shiftreg( 255 downto 232 );
				chn2 <= shiftreg( 223 downto 200 );
				chn3 <= shiftreg( 191 downto 168 );
				chn4 <= shiftreg( 159 downto 136 );
				chn5 <= shiftreg( 127 downto 104 );
				chn6 <= shiftreg(  95 downto  72 );
				chn7 <= shiftreg(  63 downto  40 );
				chn8 <= shiftreg(  31 downto   8 );
			
			end if;
		end if;
	end process;
		
end Behavioral;
