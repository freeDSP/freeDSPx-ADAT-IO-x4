----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20/09/2016 
-- Design Name: 
-- Module Name:    adat rx - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: ADAT Empfänger
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

entity adatrx is
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
end adatrx;

architecture Behavioral of adatrx is
  
  signal adatFrame : std_logic_vector(255 downto 0) := (others => '0');  -- Schieberegister für ADAT Frame
  signal dint      : std_logic := '1';                               -- Letzter Eingangszustand des NRZI-Dekodierers
  
  signal iuserbits : std_logic_vector( 3 downto 0);                  -- User-Bits (interne Zwischenspeicherung)
  signal ichn1     : std_logic_vector(23 downto 0);                  -- 24Bit-Wort Kanal 1 (interne Zwischenspeicherung)
  signal ichn2     : std_logic_vector(23 downto 0);                  -- 24Bit-Wort Kanal 2 (interne Zwischenspeicherung)
  signal ichn3     : std_logic_vector(23 downto 0);                  -- 24Bit-Wort Kanal 3 (interne Zwischenspeicherung)
  signal ichn4     : std_logic_vector(23 downto 0);                  -- 24Bit-Wort Kanal 4 (interne Zwischenspeicherung)
  signal ichn5     : std_logic_vector(23 downto 0);                  -- 24Bit-Wort Kanal 5 (interne Zwischenspeicherung)
  signal ichn6     : std_logic_vector(23 downto 0);                  -- 24Bit-Wort Kanal 6 (interne Zwischenspeicherung)
  signal ichn7     : std_logic_vector(23 downto 0);                  -- 24Bit-Wort Kanal 7 (interne Zwischenspeicherung)
  signal ichn8     : std_logic_vector(23 downto 0);                  -- 24Bit-Wort Kanal 8 (interne Zwischenspeicherung)
  
begin
  
  -- ADAT-Frame empfangen
  processAdatRx : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        adatFrame <= (others => '0');
        --issynced <= '0';
        dint <= '0';
        sync <= '0';
        
        iuserbits <= B"0000";
        ichn1 <= (others => '0');
        ichn2 <= (others => '0');
        ichn3 <= (others => '0');
        ichn4 <= (others => '0');
        ichn5 <= (others => '0');
        ichn6 <= (others => '0');
        ichn7 <= (others => '0');
        ichn8 <= (others => '0');
        
      elsif ce12M = '1' then
        -- Empfangene Daten in das Schieberegister einlesen
        adatFrame( 255 downto 1 ) <= adatFrame( 254 downto 0 );
        -- NRZI-Dekodierung
        if adatin = dint then
          adatFrame( 0 ) <= '0';
        else
          adatFrame( 0 ) <= '1';
        end if;
        dint <= adatin;
        
        if adatFrame( 10 downto 0 ) = B"10000000000" then            -- bei Blockstart alle Kanäle extrahieren und zwischenspeichern
          iuserbits <= adatFrame( 254 downto 251 );
          ichn1 <= adatFrame( 249 downto 246 ) & adatFrame( 244 downto 241 ) & adatFrame( 239 downto 236 )
                 & adatFrame( 234 downto 231 ) & adatFrame( 229 downto 226 ) & adatFrame( 224 downto 221 );
          ichn2 <= adatFrame( 219 downto 216 ) & adatFrame( 214 downto 211 ) & adatFrame( 209 downto 206 )
                 & adatFrame( 204 downto 201 ) & adatFrame( 199 downto 196 ) & adatFrame( 194 downto 191 );
          ichn3 <= adatFrame( 189 downto 186 ) & adatFrame( 184 downto 181 ) & adatFrame( 179 downto 176 )
                 & adatFrame( 174 downto 171 ) & adatFrame( 169 downto 166 ) & adatFrame( 164 downto 161 );
          ichn4 <= adatFrame( 159 downto 156 ) & adatFrame( 154 downto 151 ) & adatFrame( 149 downto 146 )
                 & adatFrame( 144 downto 141 ) & adatFrame( 139 downto 136 ) & adatFrame( 134 downto 131 );
          ichn5 <= adatFrame( 129 downto 126 ) & adatFrame( 124 downto 121 ) & adatFrame( 119 downto 116 )
                 & adatFrame( 114 downto 111 ) & adatFrame( 109 downto 106 ) & adatFrame( 104 downto 101 );
          ichn6 <= adatFrame(  99 downto  96 ) & adatFrame(  94 downto  91 ) & adatFrame(  89 downto  86 )
                 & adatFrame(  84 downto  81 ) & adatFrame(  79 downto  76 ) & adatFrame(  74 downto  71 );
          ichn7 <= adatFrame(  69 downto  66 ) & adatFrame(  64 downto  61 ) & adatFrame(  59 downto  56 )
                 & adatFrame(  54 downto  51 ) & adatFrame(  49 downto  46 ) & adatFrame(  44 downto  41 );
          ichn8 <= adatFrame(  39 downto  36 ) & adatFrame(  34 downto  31 ) & adatFrame(  29 downto  26 )
                 & adatFrame(  24 downto  21 ) & adatFrame(  19 downto  16 ) & adatFrame(  14 downto  11 );
          sync <= adatFrame(255) and adatFrame(250) and adatFrame(245) 
                  and adatFrame(240) and adatFrame(235) and adatFrame(230)
                  and adatFrame(225) and adatFrame(220) and adatFrame(215)
                  and adatFrame(210) and adatFrame(205) and adatFrame(200)
                  and adatFrame(195) and adatFrame(190) and adatFrame(185)
                  and adatFrame(180) and adatFrame(175) and adatFrame(170)
                  and adatFrame(165) and adatFrame(160) and adatFrame(155)
                  and adatFrame(150) and adatFrame(145) and adatFrame(140)
                  and adatFrame(135) and adatFrame(130) and adatFrame(125)
                  and adatFrame(120) and adatFrame(115) and adatFrame(110)
                  and adatFrame(105) and adatFrame(100) and adatFrame(95)
                  and adatFrame(90) and adatFrame(85) and adatFrame(80)
                  and adatFrame(75) and adatFrame(70) and adatFrame(65)
                  and adatFrame(60) and adatFrame(55) and adatFrame(50)
                  and adatFrame(45) and adatFrame(40) and adatFrame(35)
                  and adatFrame(30) and adatFrame(25) and adatFrame(20)
                  and adatFrame(15) and adatFrame(10) and adatFrame(5)
                  and adatFrame(0);
        end if;
        
        if ce48k = '1' then                                          -- Flankenwechsel an wclk erwartet?
          chn1 <= ichn1;                                             -- Kanalworte weiterreichen
          chn2 <= ichn2;
          chn3 <= ichn3;
          chn4 <= ichn4;
          chn5 <= ichn5;
          chn6 <= ichn6;
          chn7 <= ichn7;
          chn8 <= ichn8;
          userbits <= iuserbits;                                     -- Userbits weiterreichen
        end if;
      
      end if; 
    end if; 
  end process;  
  

  
end Behavioral;
