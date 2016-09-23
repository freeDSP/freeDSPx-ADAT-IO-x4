library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity tb_adatiox4 is
end tb_adatiox4;

architecture tb_adatiox4 of tb_adatiox4 is
	
	-- Component Declaration for the Unit Under Test (UUT)
	component adatiox4
	port ( clk      : in  std_logic;                                   -- Systemtakt (24,576MHz)
	       tdmin1   : in  std_logic;                                   -- TDM-Eingangsignal 1
	       adatin1  : in  std_logic;                                   -- ADAT-Eingangssignal 1
	       bclk     : out std_logic;                                   -- Bitclock
	       wclk     : out std_logic;                                   -- Wordclock
	       adatout1 : out std_logic;                                   -- ADAT-Ausgangssignal 1
         rst      : in  std_logic);                                  -- Systemreset
  end component;
  
  signal clk    : std_logic := '0';
  signal tdmin1 : std_logic := '0';
  signal bclk   : std_logic;
  signal wclk   : std_logic;
  signal rst    : std_logic := '1';
  
  signal tdmpattern : std_logic_vector( 255 downto 0 );
  signal tdmsig : std_logic;
  signal adatout1 : std_logic;
  signal adatin1 : std_logic;
  
  signal lasttdmin : std_logic_vector( 255 downto 0 );
  
  constant clk_period  : time := 1 ns;
  
  signal tbCntr : unsigned(7 downto 0) := to_unsigned( 0, 8 );
  signal wclk_old : std_logic := '0';
  
begin
	
	-- Instantiate the Unit Under Test (UUT)
	uut_adatiox4 : adatiox4 port map (
		clk => clk,
		tdmin1 => tdmin1,
		adatin1 => adatin1,
		bclk => bclk,
		wclk => wclk,
		adatout1 => adatout1,
		rst => rst
	);
  
  -- Master-Takt erzeugen
  clk_process : process
  begin
    clk <= not clk;
    wait for clk_period/2;
  end process;
  
  -- Stimulusprozess
  stim_process : process
  begin   
    rst <= '1';
    wait for 10 ns;  
    rst <= '0';
    
    -- insert stimulus here 

    wait;
  end process;
  
  tdm_process : process(bclk)
    variable newword : unsigned(31 downto 0);

  begin
  	if rst = '1' then
  		tdmsig <= '0';
				
  	  tdmpattern( 255 downto 224 ) <= B"10000000000000000000000100000000";
  	  tdmpattern( 223 downto 192 ) <= B"10000000000000000000001100000000";
  	  tdmpattern( 191 downto 160 ) <= B"10000000000000000000010100000000";
  	  tdmpattern( 159 downto 128 ) <= B"10000000000000000000011100000000";
  	  tdmpattern( 127 downto  96 ) <= B"10000000000000000000100100000000";
  	  tdmpattern(  95 downto  64 ) <= B"10000000000000000000101100000000";
  	  tdmpattern(  63 downto  32 ) <= B"10000000000000000000110100000000";
  	  tdmpattern(  31 downto   0 ) <= B"10000000000000000000111100000000";

  		tbCntr <= to_unsigned( 0, 8 );
  			            	             
  	elsif rising_edge(bclk) then
  	  tdmsig <= tdmpattern(255);
  		tdmpattern(255 downto 1) <= tdmpattern(254 downto 0);
  		tdmpattern(0) <= tdmpattern(255); --'0';
  		
  		if wclk = '1' and wclk_old = '0' then
  		  tbCntr <= to_unsigned( 0, 8 );
  		else
  		  tbCntr <= tbCntr + 1;
  		end if;
  		wclk_old <= wclk;
  		
  		if to_integer(tbCntr) = 254 then
  		  newword := unsigned(tdmpattern( 254 downto 223 ));
  		  newword := newword + 4096;
  		  tdmpattern( 255 downto 224 ) <= std_logic_vector(newword);
  		  newword := unsigned(tdmpattern( 222 downto 191 ));
        newword := newword + 4096;
        tdmpattern( 223 downto 192 ) <= std_logic_vector(newword);
        newword := unsigned(tdmpattern( 190 downto 159 ));
        newword := newword + 4096;
        tdmpattern( 191 downto 160 ) <= std_logic_vector(newword);
        newword := unsigned(tdmpattern( 158 downto 127 ));
        newword := newword + 4096;
        tdmpattern( 159 downto 128 ) <= std_logic_vector(newword);
        newword := unsigned(tdmpattern( 126 downto  95 ));
        newword := newword + 4096;
        tdmpattern( 127 downto  96 ) <= std_logic_vector(newword);
        newword := unsigned(tdmpattern(  94 downto  63 ));
        newword := newword + 4096;
        tdmpattern(  95 downto  64 ) <= std_logic_vector(newword);
        newword := unsigned(tdmpattern(  62 downto  31 ));
        newword := newword + 4096;
        tdmpattern(  63 downto  32 ) <= std_logic_vector(newword);
        newword := unsigned(tdmpattern(  30 downto   0 ) & '0');
        newword := newword + 4096;
  		  tdmpattern(  31 downto   0 ) <= std_logic_vector(newword);
  		end if;
  		
  	end if;
  end process;
  
  tdmin1 <= tdmsig;
  
  -- ADAT-Ausgang auf ADAT-Eingang umleiten
  adatin1 <= adatout1;
  
  --tdm_backup_process : process(wclk)
  --begin
  --	if rst = '1' then
  --		lasttdmin <= (others => '0');
  --				             
  --	elsif rising_edge(wclk) then
  --	  lasttdmin <= tdmpattern;

--  	end if;
--  end process;
       
end tb_adatiox4;