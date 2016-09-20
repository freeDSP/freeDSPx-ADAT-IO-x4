----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Raphael Knoop
-- 
-- Create Date:    18/09/2016 
-- Design Name: 
-- Module Name:    adatio-x4 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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

entity adatiox4 is
	port ( clk    : in  std_logic;                                     -- Systemtakt (24,576MHz)
	       tdmin1 : in  std_logic;                                     -- TDM-Eingangsignal 1
	       bclk   : out std_logic;                                     -- Bitclock
	       wclk   : out std_logic;                                     -- Wordclock
         rst    : in  std_logic);                                    -- Systemreset
end adatiox4;

architecture Behavioral of adatiox4 is
	
	-- Komponente TDM-Empfänger
	component tdmrx
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
	end component;
	
	-- Komponente ADAT-Sender
	component adattx
  port ( clk     : in  std_logic;                                     -- Systemtakt (24,576MHz)
         rst     : in  std_logic;                                     -- Systemreset
         icntr   : in  unsigned(8 downto 0);                          -- Ablaufzähler
         ce12M   : in  std_logic;                                     -- Clock-Enable Bittakt (12,288MHz)
         ce48k   : in  std_logic;                                     -- Clock-Enable Worttakt (48kHz)
         chn1    : in  std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 1
         chn2    : in  std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 2
         chn3    : in  std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 3
         chn4    : in  std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 4
         chn5    : in  std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 5
         chn6    : in  std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 6
         chn7    : in  std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 7
         chn8    : in  std_logic_vector(23 downto 0);                 -- 24Bit-Wort Kanal 8
         adatout : out std_logic );                                   -- ADAT-Signal
  end component;
	
	constant bclk_div : integer := 2;                                  -- Teilerverhältnis für Bittakt
  signal   bclk_cnt : integer range 0 to bclk_div-1;                 -- Zähler für Bittakt
  constant wclk_div : integer := 512;                                -- Teilerverhältnis für Worttakt
  signal   wclk_cnt : integer range 0 to wclk_div-1;                 -- Zähler für Worttakt
         
	signal icntr : unsigned(8 downto 0) := B"000000000";                 -- Zähler für Ablaufsteuerung
	signal ce12M : std_logic := '0';                                     -- Clock-Enable Bittakt (12,288MHz)
	signal ce48k : std_logic := '0';                                     -- Clock-Enable Worttakt (48kHz)
	signal chn1  : std_logic_vector(23 downto 0);                        -- 24Bit-Wort Kanal 1
  signal chn2  : std_logic_vector(23 downto 0);                        -- 24Bit-Wort Kanal 2
  signal chn3  : std_logic_vector(23 downto 0);                        -- 24Bit-Wort Kanal 3
  signal chn4  : std_logic_vector(23 downto 0);                        -- 24Bit-Wort Kanal 4
  signal chn5  : std_logic_vector(23 downto 0);                        -- 24Bit-Wort Kanal 5
  signal chn6  : std_logic_vector(23 downto 0);                        -- 24Bit-Wort Kanal 6
  signal chn7  : std_logic_vector(23 downto 0);                        -- 24Bit-Wort Kanal 7
  signal chn8  : std_logic_vector(23 downto 0);                        -- 24Bit-Wort Kanal 8
  signal adatout1 : std_logic;
  
begin
	
	-- Instanz tdmrx1
	tdmrx1 : tdmrx port map ( 
	  clk => clk,     
    rst => rst,
    ce12M => ce12M,
    ce48k => ce48k,
    tdmin => tdmin1,
    chn1 => chn1,
    chn2 => chn2,
    chn3 => chn3,
    chn4 => chn4,
    chn5 => chn5,
    chn6 => chn6,
    chn7 => chn7,
    chn8 => chn8
  );
  
  -- Instanz adattx1
  adattx1 : adattx port map ( 
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    chn1 => chn1,
    chn2 => chn2,
    chn3 => chn3,
    chn4 => chn4,
    chn5 => chn5,
    chn6 => chn6,
    chn7 => chn7,
    chn8 => chn8,
    adatout => adatout1
  );
  
  -- Zähler für Ablaufsteuerung
  icntr_proc : process(clk)
  	variable icntr_i : unsigned(8 downto 0);
  begin
    if rising_edge(clk) then
      if rst = '1' then 
      	icntr <= B"000000000";
      	bclk <= '0';
      	wclk <= '0';
      	
      else
        icntr_i := icntr;
		    icntr_i := icntr_i + 1;
		    icntr <= icntr_i;
		    	  
        bclk <= not icntr(0);                                        -- div = 2 => 256 bit clocks per tdm frame
        wclk <= not icntr(8);                                        -- div = 512 => 1 word clock per frame
        
      end if;
    end if;
  end process;
  
  -- Clock-Enable im Bittakt 
  ceBCLK_proc : process(clk)
  begin
    if rising_edge(clk) then
	    if rst = '1' then
	    	ce12M <= '0';
	      bclk_cnt <= 0;
		    
		  else
        if bclk_cnt = bclk_div-1 then
		      ce12M <= '1';
          bclk_cnt <= 0;
          
        else
          ce12M <= '0';
          bclk_cnt <= bclk_cnt +1 ;
          
        end if;
        
		  end if;
    end if;
  end process;
  
  -- Clock-Enable im Worttakt 
  ceWCLK_proc : process(clk)
  begin
    if rising_edge(clk) then
	    if rst = '1' then
	    	ce48k <= '0';
	      wclk_cnt <= 0;
		    
		  else
        if wclk_cnt = wclk_div-1 then
		      ce48k <= '1';
          wclk_cnt <= 0;
          
        else
          ce48k <= '0';
          wclk_cnt <= wclk_cnt +1 ;
          
        end if;
        
		  end if;
    end if;
  end process;
  
  
end Behavioral;
