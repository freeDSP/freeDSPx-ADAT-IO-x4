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
	       tdmin2   : in  std_logic;                                   -- TDM-Eingangssignal 2
			 tdmin3   : in  std_logic;                                   -- TDM-Eingangssignal 3
			 tdmin4   : in  std_logic;                                   -- TDM-Eingangssignal 3
	       adatin1  : in  std_logic;                                   -- ADAT-Eingangssignal 1
	       adatin2  : in  std_logic;                                   -- ADAT-Eingangssignal 2
	       adatin3  : in  std_logic;                                   -- ADAT-Eingangssignal 3
			 adatin4  : in  std_logic;                                   -- ADAT-Eingangssignal 4
	       bclk     : out std_logic;                                   -- Bitclock
	       wclk     : out std_logic;                                   -- Wordclock
	       tdmout1  : out std_logic;                                   -- TDM-Ausgangssignal 1
	       tdmout2  : out std_logic;                                   -- TDM-Ausgangssignal 2
			 tdmout3  : out std_logic;                                   -- TDM-Ausgangssignal 3
			 tdmout4  : out std_logic;                                   -- TDM-Ausgangssignal 4
	       adatout1 : out std_logic;                                   -- ADAT-Ausgangssignal 1
	       adatout2 : out std_logic;                                   -- ADAT-Ausgangssignal 2
	       adatout3 : out std_logic;                                   -- ADAT-Ausgangssignal 3
			 adatout4 : out std_logic;                                   -- ADAT-Ausgangssignal 4
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
  
  -- Komponente TDM-Sender
  component tdmtx 
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
  signal in9  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 9
  signal in10 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 10
  signal in11 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 11
  signal in12 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 12
  signal in13 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 13
  signal in14 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 14
  signal in15 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 15
  signal in16 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 16
  signal in17 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 17
  signal in18 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 18
  signal in19 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 19
  signal in20 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 20
  signal in21 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 21
  signal in22 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 22
  signal in23 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 23
  signal in24 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 24
  signal in25 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 25
  signal in26 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 26
  signal in27 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 27
  signal in28 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 28
  signal in29 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 29
  signal in30 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 30
  signal in31 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 31
  signal in32 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 32  
  
  signal out1 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 1
  signal out2 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 2
  signal out3 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 3
  signal out4 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 4
  signal out5 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 5
  signal out6 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 6
  signal out7 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 7
  signal out8 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 8
  signal out9  : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 9
  signal out10 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 10
  signal out11 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 11
  signal out12 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 12
  signal out13 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 13
  signal out14 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 14
  signal out15 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 15
  signal out16 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 16
  signal out17 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 17
  signal out18 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 18
  signal out19 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 19
  signal out20 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 20
  signal out21 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 21
  signal out22 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 22
  signal out23 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 23
  signal out24 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 24
  signal out25 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 25
  signal out26 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 26
  signal out27 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 27
  signal out28 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 28
  signal out29 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 29
  signal out30 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 30
  signal out31 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 31
  signal out32 : std_logic_vector(23 downto 0);                       -- 24Bit-Wort Kanal 32
  
  signal sync1 : std_logic := '0';                                   -- ADAT Empfänger 1 ist synchronisiert
  signal sync2 : std_logic := '0';                                   -- ADAT Empfänger 2 ist synchronisiert
  signal sync3 : std_logic := '0';                                   -- ADAT Empfänger 3 ist synchronisiert
  signal sync4 : std_logic := '0';                                   -- ADAT Empfänger 4 ist synchronisiert
  
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
  
	-- Instanz tdmrx2
	tdmrx2 : tdmrx port map ( 
	  clk => clk,     
    rst => rst,
    ce12M => ce12M,
    ce48k => ce48k,
    tdmin => tdmin2,
    chn1 => in9,
    chn2 => in10,
    chn3 => in11,
    chn4 => in12,
    chn5 => in13,
    chn6 => in14,
    chn7 => in15,
    chn8 => in16
  );
  
 	-- Instanz tdmrx3
	tdmrx3 : tdmrx port map ( 
	  clk => clk,     
     rst => rst,
     ce12M => ce12M,
     ce48k => ce48k,
     tdmin => tdmin3,
     chn1 => in17,
     chn2 => in18,
     chn3 => in19,
     chn4 => in20,
     chn5 => in21,
     chn6 => in22,
     chn7 => in23,
     chn8 => in24
  );

 	-- Instanz tdmrx4
	tdmrx4 : tdmrx port map ( 
	  clk => clk,     
     rst => rst,
     ce12M => ce12M,
     ce48k => ce48k,
     tdmin => tdmin4,
     chn1 => in25,
     chn2 => in26,
     chn3 => in27,
     chn4 => in28,
     chn5 => in29,
     chn6 => in30,
     chn7 => in31,
     chn8 => in32
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

  -- Instanz adattx2
  adattx2 : adattx port map ( 
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    chn1 => in9,
    chn2 => in10,
    chn3 => in11,
    chn4 => in12,
    chn5 => in13,
    chn6 => in14,
    chn7 => in15,
    chn8 => in16,
    adatout => adatout2
  );
  
  -- Instanz adattx3
  adattx3 : adattx port map ( 
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    chn1 => in17,
    chn2 => in18,
    chn3 => in19,
    chn4 => in20,
    chn5 => in21,
    chn6 => in22,
    chn7 => in23,
    chn8 => in24,
    adatout => adatout3
  );
   
  -- Instanz adattx4
  adattx4 : adattx port map ( 
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    chn1 => in25,
    chn2 => in26,
    chn3 => in27,
    chn4 => in28,
    chn5 => in29,
    chn6 => in30,
    chn7 => in31,
    chn8 => in32,
    adatout => adatout4
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
  
  -- Instanz adatrx2
  adatrx2 : adatrx port map ( 
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    adatin => adatin2,
    chn1 => out9,
    chn2 => out10,
    chn3 => out11,
    chn4 => out12,
    chn5 => out13,
    chn6 => out14,
    chn7 => out15,
    chn8 => out16,
    sync => sync2
  );

  -- Instanz adatrx3
  adatrx3 : adatrx port map ( 
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    adatin => adatin3,
    chn1 => out17,
    chn2 => out18,
    chn3 => out19,
    chn4 => out20,
    chn5 => out21,
    chn6 => out22,
    chn7 => out23,
    chn8 => out24,
    sync => sync3
  );

  -- Instanz adatrx4
  adatrx4 : adatrx port map ( 
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    adatin => adatin4,
    chn1 => out25,
    chn2 => out26,
    chn3 => out27,
    chn4 => out28,
    chn5 => out29,
    chn6 => out30,
    chn7 => out31,
    chn8 => out32,
    sync => sync4
  );
  
  -- Instanz tdmtx1
  tdmtx1 : tdmtx port map (
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    chn1 => out1,
    chn2 => out2,
    chn3 => out3,
    chn4 => out4,
    chn5 => out5,
    chn6 => out6,
    chn7 => out7,
    chn8 => out8,
    tdmout => tdmout1
  );
  
  -- Instanz tdmtx2
  tdmtx2 : tdmtx port map (
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    chn1 => out9,
    chn2 => out10,
    chn3 => out11,
    chn4 => out12,
    chn5 => out13,
    chn6 => out14,
    chn7 => out15,
    chn8 => out16,
    tdmout => tdmout2
  );
  
  -- Instanz tdmtx3
  tdmtx3 : tdmtx port map (
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    chn1 => out17,
    chn2 => out18,
    chn3 => out19,
    chn4 => out20,
    chn5 => out21,
    chn6 => out22,
    chn7 => out23,
    chn8 => out24,
    tdmout => tdmout3
  );
  
  -- Instanz tdmtx4
  tdmtx4 : tdmtx port map (
    clk => clk,
    rst => rst,
    icntr => icntr,
    ce12M => ce12M,
    ce48k => ce48k,
    chn1 => out25,
    chn2 => out26,
    chn3 => out27,
    chn4 => out28,
    chn5 => out29,
    chn6 => out30,
    chn7 => out31,
    chn8 => out32,
    tdmout => tdmout4
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
