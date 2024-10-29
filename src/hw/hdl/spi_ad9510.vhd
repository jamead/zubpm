library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;
 
entity spi_ad9510 is
  
  port (
    clk         : in  std_logic;                    
    reset 	    : in  std_logic;                     
	 we			 : in  std_logic;
	 data		 	 : in  std_logic_vector(31 downto 0);

    sclk        : out std_logic;                   
	 sdo			 : in std_logic;
    sdi 	       : out std_logic;
    csb         : out std_logic;                
    debug       : out std_logic_vector(8 downto 0)  
  );    

end spi_ad9510;

architecture rtl of spi_ad9510 is



  type     state_type is (IDLE, CLKP1, CLKP2);                     -- spi state machine type
  signal   state                 : state_type;
  signal   sys_clk               : std_logic;                      -- system clock to operate logic                                                          
  signal   treg                  : std_logic_vector(23 downto 0);  -- transfer register,
                                                                   -- 16-bit address and 8-bit data
                                                                   -- plus 24-bit device_update write
  signal   rreg                  : std_logic_vector(7 downto 0);   -- receiver register,
  signal   rddata                : std_logic_vector(7 downto 0);   -- 8-bit data
  signal   bcnt                  : integer range 0 to 63;          -- transfer counter
  signal   xfer_done             : std_logic;                      -- signal to clear rd_wr_x register
  
  signal   int_rwn					: std_logic;     
  signal   int_sclk              : std_logic;
  signal   int_csb               : std_logic;
  signal   int_sdi               : std_logic;

  
  signal clk_cnt            : std_logic_vector(7 downto 0);  
  signal strobe_cnt			 : std_logic_vector(15 downto 0);  
  
  signal we_lat				: std_logic;
  signal we_lat_clr			: std_logic;
  
  signal spi_data				: std_logic_vector(23 downto 0);
  
begin  


  
  debug(0) <= xfer_done; --'0'; --rd_wr_n;
  debug(1) <= '0'; 
  debug(2) <= '0'; 
  debug(5 downto 3) <= "000"; --state;
  debug(8 downto 6) <= "000"; --rreg(7 downto 0);

 
  sclk <= int_sclk;
  csb <= int_csb;
 
			
  sdi <= int_sdi; 
  --sdio <= int_sdio when (int_rwn = '0') else 'Z';



process (clk, reset)
   begin
      if (reset = '1') OR (we_lat_clr = '1') then
	     we_lat <= '0';
      elsif (clk'event and clk = '1') then
			if (we = '1') then
	          we_lat <= '1';
				 spi_data <= data(23 downto 0);
			end if;
      end if;
   end process;





 

  spiStateProc: process (sys_clk, reset)
  begin  -- process spiStateProc
    if (reset = '1') then                 -- asynchronous reset (active low)
      int_sclk  <= '0';
      int_csb  <= '1';
	   int_sdi <= '0';
      treg <= (others => '0');
      rreg <= (others => '0');
      bcnt <= 24;
      xfer_done <= '0';
		we_lat_clr <= '0';
      state <= IDLE;

    elsif (sys_clk'event and sys_clk = '1') then  -- rising clock edge
      case state is
        when IDLE =>     
            int_sclk  <= '0';
            int_csb  <= '1';
            xfer_done <= '0';
            we_lat_clr <= '0';
            if (we_lat = '1') then
					 we_lat_clr <= '1';
                treg <= spi_data;  
                bcnt <= 24;  -- 16-bit address and 8-bit data
                state <= CLKP1;
            end if;

        when CLKP1 =>                   -- CLKP1 clock phase 1
			 int_sclk  <= '0';
          int_csb  <= '0';
          state <= CLKP2;
			 treg <= treg(22 downto 0) & '0';
          int_sdi <= treg(23);

        when CLKP2 =>                   -- CLKP1 clock phase 2
          if (bcnt = 0) then
            int_csb <= '1';
            if (int_rwn = '1') then
				   rddata <= rreg;
				else
					rddata <= x"00";
				end if;
				xfer_done <= '1';
            we_lat_clr <= '1';				
            state <= IDLE;
          else
			   rreg <= rreg(6 downto 0) & sdo;
            int_sclk <= '1';
            bcnt <= bcnt - 1;
            state <= CLKP1;
			 end if;
 
    
        when others =>
            state <= IDLE;
      end case;
    end if;
  end process spiStateProc;





--sys_clk <= clk_cnt(4);
sysclk_bufg_inst : BUFG  port map (O => sys_clk, I => clk_cnt(5));


clkdivide : process(clk, reset)
   begin
      if (reset = '1') then  
          clk_cnt <= (others => '0');
      elsif (clk'event AND clk = '1') then  
			clk_cnt <= clk_cnt + 1; 
      end if;
   end process; 










  
end rtl;
