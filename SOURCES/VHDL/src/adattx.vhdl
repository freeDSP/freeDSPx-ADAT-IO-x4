----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19/09/2016 
-- Design Name: 
-- Module Name:    adat tx - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: ADAT Sender
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

entity adattx is
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
         adatout : out std_logic );                                  -- ADAT-Signal
end adattx;

architecture Behavioral of adattx is
  constant bitstuffing : std_logic := '1';
  
  signal adatFrame : std_logic_vector(29 downto 0) := (others => '0');  -- Schieberegister für ADAT Frame
  signal nrziIn    : std_logic := 'U';                               -- Eingang des NRZI-Enkodierers (nur zum Debuggen)
  signal qint      : std_logic := '0';                               -- Letzter Ausgangszustand des NRZI-Enkodierers
  
begin
  
  -- ADAT Frame bauen und senden
  adatframe_proc : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        adatFrame <= (others => '0');
        nrziIn <= '0';
        qint <= '0';
        adatout <= '0';
        
      else
        if ce12M = '1' then
          case icntr is
          when B"000000000" =>                                       -- icntr=0: User-Bits
            adatFrame( 29 downto 25 ) <= B"11111";
            adatFrame( 24 downto  0 ) <= (others => '0');
            adatout <= '1';
            nrziIn <= '-'; --bitstuffing;
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint;
            adatout <= not qint; 
          when B"000001010" =>                                       -- icntr=10: Kanal 1
            adatFrame  <= bitstuffing & chn1( 23 downto 20 )
                        & bitstuffing & chn1( 19 downto 16 )
                        & bitstuffing & chn1( 15 downto 12 )
                        & bitstuffing & chn1( 11 downto  8 )
                        & bitstuffing & chn1(  7 downto  4 )
                        & bitstuffing & chn1(  3 downto  0 );
            nrziIn <= '-'; --bitstuffing;
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint;
            adatout <= not qint;            
          when B"001000110" =>                                       -- icntr=70: Kanal 2
            adatFrame  <= bitstuffing & chn2( 23 downto 20 )
                        & bitstuffing & chn2( 19 downto 16 )
                        & bitstuffing & chn2( 15 downto 12 )
                        & bitstuffing & chn2( 11 downto  8 )
                        & bitstuffing & chn2(  7 downto  4 )
                        & bitstuffing & chn2(  3 downto  0 );
            nrziIn <= '-'; --bitstuffing; 
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint;
            adatout <= not qint; 
          when B"010000010" =>                                       -- icntr=130: Kanal 3
            adatFrame  <= bitstuffing & chn3( 23 downto 20 )
                        & bitstuffing & chn3( 19 downto 16 )
                        & bitstuffing & chn3( 15 downto 12 )
                        & bitstuffing & chn3( 11 downto  8 )
                        & bitstuffing & chn3(  7 downto  4 )
                        & bitstuffing & chn3(  3 downto  0 );
            nrziIn <= '-'; --bitstuffing;
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint;
            adatout <= not qint; 
          when B"010111110" =>                                       -- icntr=190: Kanal 4
            adatFrame  <= bitstuffing & chn4( 23 downto 20 )
                        & bitstuffing & chn4( 19 downto 16 )
                        & bitstuffing & chn4( 15 downto 12 )
                        & bitstuffing & chn4( 11 downto  8 )
                        & bitstuffing & chn4(  7 downto  4 )
                        & bitstuffing & chn4(  3 downto  0 );
            nrziIn <= '-'; --bitstuffing;
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint;
            adatout <= not qint; 
          when B"011111010" =>                                       -- icntr=250: Kanal 5
            adatFrame  <= bitstuffing & chn5( 23 downto 20 )
                        & bitstuffing & chn5( 19 downto 16 )
                        & bitstuffing & chn5( 15 downto 12 )
                        & bitstuffing & chn5( 11 downto  8 )
                        & bitstuffing & chn5(  7 downto  4 )
                        & bitstuffing & chn5(  3 downto  0 );
            nrziIn <= '-'; --bitstuffing;
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint; 
            adatout <= not qint;
          when B"100110110" =>                                       -- icntr=310: Kanal 6
            adatFrame  <= bitstuffing & chn6( 23 downto 20 )
                        & bitstuffing & chn6( 19 downto 16 )
                        & bitstuffing & chn6( 15 downto 12 )
                        & bitstuffing & chn6( 11 downto  8 )
                        & bitstuffing & chn6(  7 downto  4 )
                        & bitstuffing & chn6(  3 downto  0 );
            nrziIn <= '-'; --bitstuffing;
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint;
            adatout <= not qint; 
          when B"101110010" =>                                       -- icntr=370: Kanal 7
            adatFrame  <= bitstuffing & chn7( 23 downto 20 )
                        & bitstuffing & chn7( 19 downto 16 )
                        & bitstuffing & chn7( 15 downto 12 )
                        & bitstuffing & chn7( 11 downto  8 )
                        & bitstuffing & chn7(  7 downto  4 )
                        & bitstuffing & chn7(  3 downto  0 );
            nrziIn <= '-'; --bitstuffing;
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint;
            adatout <= not qint; 
          when B"110101110" =>                                       -- icntr=430: Kanal 8
            adatFrame  <= bitstuffing & chn8( 23 downto 20 )
                        & bitstuffing & chn8( 19 downto 16 )
                        & bitstuffing & chn8( 15 downto 12 )
                        & bitstuffing & chn8( 11 downto  8 )
                        & bitstuffing & chn8(  7 downto  4 )
                        & bitstuffing & chn8(  3 downto  0 );
            nrziIn <= '-'; --bitstuffing;
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint; 
            adatout <= not qint;
          when B"111101010" =>                                       -- icntr=490: Sync
            adatFrame( 29 downto 19 )  <= bitstuffing & B"0000000000";
            adatFrame( 18 downto  0 ) <= (others => '0');
            nrziIn <= '-'; --bitstuffing;
            -- adatFrame(29) ist in jedem Fall '1' => Bitwechsel
            qint <= not qint; 
            adatout <= not qint;
          when others =>
            nrziIn <= adatFrame( 28 );
            adatFrame( 29 downto 1 ) <= adatFrame( 28 downto 0 );
            if adatFrame( 28 ) = '1' then                            -- '1' führt zu einem Bitwechsel
              qint <= not qint; 
              adatout <= not qint;
            end if;
          end case;
          
        end if;
       
      end if;
    end if;
  end process;
  
  
end Behavioral;
