----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2018 03:48:11 PM
-- Design Name: 
-- Module Name: adc_spi_cntrl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ltc2195_spi is
    port (
    clk           : in std_logic;                    
    reset         : in std_logic;                     
    adc_spi_we    : in std_logic;
    adc_spi_wdata : in std_logic_vector(31 downto 0);
    adc_spi_rdata : out std_logic_vector(31 downto 0);
    
    sclk        : out std_logic_vector(1 downto 0);
    sdi         : out std_logic_vector(1 downto 0);
    sdo         : in std_logic_vector(1 downto 0);
    csb         : out std_logic_vector(1 downto 0)
  
);
end ltc2195_spi;
 
architecture rtl of ltc2195_spi is

  type state_type is (IDLE, CLKP1, CLKP2, CLR_CLK);
  signal  state       : state_type;
  signal  sys_clk     : std_logic;
  signal  treg        : std_logic_vector(15 downto 0);                                                                                                                                    
  signal  bcnt        : integer range 0 to 16;                      
  signal  clk_cnt     : std_logic_vector(7 downto 0);  
  signal  adc_we_lat      : std_logic;
  signal  adc_we_lat_clr  : std_logic;
  signal  spi_wdata    : std_logic_vector(15 downto 0);
  signal  spi_rdata    : std_logic_vector(15 downto 0);
  signal  spiwr        : std_logic;
  --signal  sdi            : std_logic;
  --signal  sdo          : std_logic;
  signal  rwbit        : std_logic;
  --signal  csb          : std_logic;
  --signal  sclk         : std_logic;
  signal  adc_sel      : std_logic;
  
--  attribute mark_debug     : string;
--  attribute mark_debug of bcnt: signal is "true";
--  attribute mark_debug of state: signal is "true"; 
--  attribute mark_debug of adc_spi_wdata: signal is "true";
--  attribute mark_debug of adc_spi_rdata: signal is "true";   
--  attribute mark_debug of spi_wdata: signal is "true";
--  attribute mark_debug of spi_rdata: signal is "true";
--  attribute mark_debug of sclk: signal is "true";
--  attribute mark_debug of sdi: signal is "true";
--  attribute mark_debug of sdo: signal is "true";
--  attribute mark_debug of csb: signal is "true";   

    
  
begin  

adc_spi_rdata <= 24d"0" & spi_rdata(7 downto 0);



--initiate spi on we input
process (clk, reset)
   begin
     if (reset = '1') then
	     spi_wdata <= (others => '0');
	     adc_we_lat <= '0';
     elsif (adc_we_lat_clr = '1') then
          spi_wdata <= (others => '0');
          adc_we_lat <= '0';
     elsif (clk'event and clk = '1') then
		   if (adc_spi_we = '1') then
	           adc_we_lat <= '1';
			   spi_wdata <= adc_spi_wdata(15 downto 0);
			   adc_sel <= adc_spi_wdata(16);
	       end if;
     end if;
end process;



-- spi transfer
process (sys_clk, reset)
  begin  -- process spiStateProc
    if (reset = '1') then  
      csb   <= "11";
      sclk  <= "00";
	  sdi <= "00";
      treg  <= (others => '0');
      bcnt  <= 15;
	  adc_we_lat_clr <= '0';
      state <= IDLE;
      spi_rdata <= (others => '0');
      spiwr <= '1';
      rwbit <= '0';

    elsif (sys_clk'event and sys_clk = '1') then  
      case state is
        when IDLE =>    
           csb   <= "11";
           sclk  <= "00";
           sdi  <= "00";
           spiwr <= '1';
           adc_we_lat_clr <= '0';
           if (adc_we_lat = '1') then
             if (adc_sel = '1') then
               csb <= "00";
             else 
               csb <= "00";
             end if;
             treg  <= spi_wdata(15 downto 0);
             rwbit <= spi_wdata(15);
             bcnt <= 15;       
             state <= CLKP1;
           end if;

        when CLKP1 =>     -- CLKP1 clock phase LOW
			sclk  <= "00";
            state <= CLKP2;
            sdi <= treg(15) & treg(15);           
			treg <= treg(14 downto 0) & '0';


        when CLKP2 =>     -- CLKP2 clock phase HIGH
            sclk <= "11";
            if (adc_sel = '1') then
               spi_rdata(bcnt) <= sdo(0);
            else
               spi_rdata(bcnt) <= sdo(1);
            end if;
            if (bcnt = 0) and (adc_we_lat = '1') then
               adc_we_lat_clr <= '1';				
               state <= CLR_CLK;
            else
               bcnt <= bcnt - 1;
               state <= CLKP1;
		   end if;
 
 
       when CLR_CLK =>
           sclk   <= "00";
           state <= IDLE;
    
       when others =>
            state <= IDLE;
      end case;
    end if;
  end process;
  
--generate sys clk for spi from 100Mhz clock
--sys_clk <= clk_cnt(4);
sysclk_bufg_inst : BUFG  port map (O => sys_clk, I => clk_cnt(4));

clkdivide : process(clk, reset)
begin
   if (reset = '1') then  
     clk_cnt <= (others => '0');
  elsif (clk'event AND clk = '1') then  
            clk_cnt <= clk_cnt + 1; 
  end if;
end process; 



end rtl;
