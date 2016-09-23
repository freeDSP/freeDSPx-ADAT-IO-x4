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
	port ( clk      : in  std_logic;                                   -- Systemtakt (24,576MHz)
	       tdmin1   : in  std_logic;                                   -- TDM-Eingangssignal 1
	       adatin1  : in  std_logic;                                   -- ADAT-Eingangssignal 1
	       bclk     : out std_logic;                                   -- Bitclock
	       wclk     : out std_logic;                                   -- Wordclock
	       adatout1 : out std_logic;                                   -- ADAT-Ausgangssignal 1
         rst      : in  std_logic);                                  -- Systemreset
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

  -- Komponente ADAT-Empfänger
  component adatrx
  port ( clk     : in  std_logic;                                    -- Systemtakt (24,576MHz)
         rst     : in  std_logic;                                    -- Systemreset
         icntr   : in  unsigned(8 downto 0);                         -- Ablaufzähler
         ce12M   : in  std_logic;                                    -- Clock-Enable Bittakt (12,288MHz)
         ce48k   : in  std_logic;                                    -- Clock-Enable Worttakt (48kHz)
         adatin  : in  std_logic;                                    -- ADAT-Signal
         userbits : out std_logic_vector( 3 downto 0);               -- User-Bits
         chn1    : out std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 1
         chn2    : out std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 2
         chn3    : out std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 3
         chn4    : out std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 4
         chn5    : out std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 5
         chn6    : out std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 6
         chn7    : out std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 7
         chn8    : out std_logic_vector(23 downto 0);                -- 24Bit-Wort Kanal 8
         sync    : out std_logic );                                  -- Empfänger hat sich synchronisiert zum ADAT-Stream
  end component;
  	
	constant bclk_div : integer := 2;                                  -- Teilerverhältnis für Bittakt
  signal   bclk_cnt : integer range 0 to bclk_div-1;                 -- Zähler für Bittakt
  constant wclk_div : integer := 512;                                -- Teilerverhältnis für Worttakt
  signal   wclk_cnt : integer range 0 to wclk_div-1;                 -- Zähler für Worttakt
         
	signal icntr : unsigned(8 downto 0) := B"000000000";               -- Zähler für Ablaufsteuerung
	signal ce12M : std_logic := '0';                                   -- Clock-Enable Bittakt (12,288MHz)
	signal ce48k : std_logic := '0';                                   -- Clock-Enable Worttakt (48kHz)
	
	signal in1  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 1
  signal in2  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 2
  signal in3  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 3
  signal in4  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 4
  signal in5  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 5
  signal in6  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 6
  signal in7  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 7
  signal in8  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 8
  
  signal out1 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 1
  signal out2 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 2
  signal out3 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 3
  signal out4 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 4
  signal out5 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 5
  signal out6 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 6
  signal out7 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 7
  signal out8 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 8
  
  signal sync1 : std_logic := '0';                                   -- ADAT Empfänger 1 ist synchronisiert
  
begin
	
	-- Instanz tdmrx1
	tdmrx1 : tdmrx port map ( 
	  clk => clk,     
    rst => rst,
    ce12M => ce12M,
    ce48k => ce48k,
    tdmin => tdmin1,
    chn1 => in1,
    chn2 => in2,
    chn3 => in3,
    chn4 => in4,
    chn5 => in5,
    chn6 => in6,
    chn7 => in7,
    chn8 => in8
  );
  
  -- Instanz adattx1
  adattx1 : adattx port map ( 
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    chn1 => in1,
    chn2 => in2,
    chn3 => in3,
    chn4 => in4,
    chn5 => in5,
    chn6 => in6,
    chn7 => in7,
    chn8 => in8,
    adatout => adatout1
  );
  
  -- Instanz adatrx1
  adatrx1 : adatrx port map ( 
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    adatin => adatin1,
    chn1 => out1,
    chn2 => out2,
    chn3 => out3,
    chn4 => out4,
    chn5 => out5,
    chn6 => out6,
    chn7 => out7,
    chn8 => out8,
    sync => sync1
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
