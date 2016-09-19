library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_adatiox4 is
end tb_adatiox4;

architecture tb_adatiox4 of tb_adatiox4 is
	
	-- Component Declaration for the Unit Under Test (UUT)
	component adatiox4
	port ( clk    : in  std_logic;                                     -- Systemtakt (24,576MHz)
	       tdmin1 : in  std_logic;                                     -- TDM-Eingangsignal 1
	       bclk   : out std_logic;                                     -- Bitclock
	       wclk   : out std_logic;                                     -- Wordclock
         rst    : in  std_logic);                                    -- Systemreset
  end component;
  
  signal clk    : std_logic := '0';
  signal tdmin1 : std_logic := '0';
  signal bclk   : std_logic;
  signal wclk   : std_logic;
  signal rst    : std_logic := '1';
  
  signal tdmpattern : std_logic_vector( 255 downto 0 );
  signal tdmsig : std_logic;
  
  signal lasttdmin : std_logic_vector( 255 downto 0 );
  
  constant clk_period  : time := 1 ns;
  
begin
	
	-- Instantiate the Unit Under Test (UUT)
	uut_adatiox4 : adatiox4 port map (
		clk => clk,
		tdmin1 => tdmin1,
		bclk => bclk,
		wclk => wclk,
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

  		lasttdmin <= (255 => '1', 232 => '1',
  	  	            223 => '1', 200 => '1',
  	  	            191 => '1', 168 => '1',
  	  	            159 => '1', 136 => '1',
  	  	            127 => '1', 104 => '1',
  	  	             95 => '1',  72 => '1',
  	  	             63 => '1',  40 => '1',
  	  	             31 => '1',   8 => '1',
  			            others => '0');	
  			            	             
  	elsif rising_edge(bclk) then
  	  tdmsig <= tdmpattern(255);
  		tdmpattern(255 downto 1) <= tdmpattern(254 downto 0);
  		tdmpattern(0) <= '0';

  	end if;
  end process;
  
  tdmin1 <= tdmsig;
  
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