----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2021 10:07:16 AM
-- Design Name: 
-- Module Name: adc_interface - behv
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

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.all;
use std.textio.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.bpm_package.ALL;
 



entity adc_ltc2195 is
  generic (
    SIM_MODE            : integer := 0
  );
  port ( 
    sys_clk         : in std_logic;
    sys_rst         : in std_logic;
    adc_spi_we      : in std_logic;
    adc_spi_wdata   : in std_logic_vector(31 downto 0);
    adc_spi_rdata   : out std_logic_vector(31 downto 0);
    adc_csb         : out std_logic_vector(1 downto 0);
    adc_sdi         : out std_logic_vector(1 downto 0);
    adc_sdo         : in std_logic_vector(1 downto 0);
    adc_sclk        : out std_logic_vector(1 downto 0); 
    adc_fco_dlystr  : in std_logic_vector(1 downto 0);  
    adc_idly_wrval  : in std_logic_vector(8 downto 0);
    adc_idly_wrstr  : in std_logic_vector(15 downto 0);
    adc_idly_rdval  : out std_logic_vector(8 downto 0);     
    adc_fco_p       : in std_logic_vector(1 downto 0);
    adc_fco_n       : in std_logic_vector(1 downto 0);
    adc_dco_p       : in std_logic_vector(1 downto 0);
    adc_dco_n       : in std_logic_vector(1 downto 0);
    adc_sdata_p     : in std_logic_vector(15 downto 0);
    adc_sdata_n     : in std_logic_vector(15 downto 0);
    adc_fifo_wren   : in std_logic;
    adc_fifo_rst    : in std_logic;
    adc_clk_out     : out std_logic;
    adc_data        : out ADC_RAW_TYPE;
    adc_data_lat    : out ADC_RAW_TYPE;
    dbg             : out std_logic_vector(3 downto 0)    
  );
end adc_ltc2195;

architecture behv of adc_ltc2195 is

component ltc2195_spi is
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
end component;

component adc_fifo IS
  port (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
end component;


  signal ref_clk         : std_logic;

  signal adc0_dco        : std_logic;
  signal adc0_dco_dlyd   : std_logic;
  signal adc0_dco_bufg   : std_logic;
  signal adc0_dco_bufgdiv: std_logic;
  
  signal adc0_fco             : std_logic;
  signal adc0_fco_mmcm        : std_logic;
  signal adc0_fco_dlyd        : std_logic;
  signal adc0_fco_bufg        : std_logic;
  signal adc0_fco_mmcm_psdone : std_logic;
  signal adc0_fco_mmcm_locked : std_logic;
  
  signal adc1_dco             : std_logic;
  signal adc1_dco_dlyd        : std_logic;
  signal adc1_dco_bufg        : std_logic;
  signal adc1_dco_bufgdiv     : std_logic;
  signal adc1_fco_mmcm_psdone : std_logic;
  signal adc1_fco_mmcm_locked : std_logic;  
  
  signal adc1_fco        : std_logic;
  signal adc1_fco_mmcm   : std_logic;
  signal adc1_fco_dlyd   : std_logic;
  signal adc1_fco_bufg   : std_logic;      
  
  signal adca_sdata      : std_logic_vector(3 downto 0);
  signal adcb_sdata      : std_logic_vector(3 downto 0);
  signal adcc_sdata      : std_logic_vector(3 downto 0);
  signal adcd_sdata      : std_logic_vector(3 downto 0);
 
  signal adca_data       : std_logic_vector(15 downto 0);
  signal adcb_data       : std_logic_vector(15 downto 0);
  signal adcc_data       : std_logic_vector(15 downto 0);
  signal adcd_data       : std_logic_vector(15 downto 0);  
  
  signal adc_data_s      : adc_raw_type;    

  
  signal adc0_fifo_wren : std_logic;
  signal adc1_fifo_wren : std_logic;
  signal adc_fifo_full  : std_logic_vector(3 downto 0);
  signal adc_fifo_empty : std_logic_vector(3 downto 0);
  

   attribute mark_debug     : string;
   --attribute mark_debug of adca_data: signal is "true";
   --attribute mark_debug of adcb_data: signal is "true";
   --attribute mark_debug of adcc_data: signal is "true";
   --attribute mark_debug of adcd_data: signal is "true";
   --attribute mark_debug of adc_data: signal is "true";
   --attribute mark_debug of adc_idly_wrval: signal is "true";
   --attribute mark_debug of adc_idly_rdval: signal is "true";
   --attribute mark_debug of adc_idly_wrstr: signal is "true";
   --attribute mark_debug of adc_fco_dlystr: signal is "true";
   --attribute mark_debug of adc0_fco_mmcm_psdone: signal is "true";
   --attribute mark_debug of adc0_fco_mmcm_locked: signal is "true";   
   --attribute mark_debug of adc1_fco_mmcm_psdone: signal is "true";   
   --attribute mark_debug of adc1_fco_mmcm_locked: signal is "true";
   
   
      
--   attribute mark_debug of adc_idly_wrval: signal is "true";
--   attribute mark_debug of adc_idly_wrstr: signal is "true";
--   attribute mark_debug of adc_idly_rdval: signal is "true";
--   attribute mark_debug of cntval_dco0: signal is "true";
--   attribute mark_debug of cntval_fco0: signal is "true";
--   attribute mark_debug of cntval_dco1: signal is "true";
--   attribute mark_debug of cntval_fco1: signal is "true";
--   attribute mark_debug of adc_fifo_full: signal is "true";
--   attribute mark_debug of adc_fifo_empty: signal is "true";
--   attribute mark_debug of adc_fifo_wren: signal is "true";
--   attribute mark_debug of adc0_fifo_wren: signal is "true";
--   attribute mark_debug of adc1_fifo_wren: signal is "true";
--   attribute mark_debug of adc_fifo_rst: signal is "true";


begin

dbg(0) <= '0'; --adc_fco_dlystr(0);
dbg(1) <= '0'; --adc0_fco_mmcm_psdone;
dbg(2) <= adc1_fco_bufg;
dbg(3) <= adc1_fco_mmcm;





IDELAYCTRL_inst : IDELAYCTRL
  generic map (
      SIM_DEVICE => "ULTRASCALE"  -- Set the device version for simulation functionality (ULTRASCALE)
  )
  port map (
    RDY => open,       -- 1-bit output: Ready output
    REFCLK => ref_clk, -- 1-bit input: Reference clock input
    RST => sys_rst     -- 1-bit input: Active-High reset input. Asynchronous assert, synchronous deassert to REFCLK.
);




--fco and dco input buffer
adc0_fco_inst  : IBUFDS  port map (O => adc0_fco, I => adc_fco_p(0), IB => adc_fco_n(0)); 
adc0_dco_inst  : IBUFDS  port map (O => adc0_dco, I => adc_dco_p(0), IB => adc_dco_n(0)); 

--fco and dco input buffer
adc1_fco_inst  : IBUFDS  port map (O => adc1_fco, I => adc_fco_p(1), IB => adc_fco_n(1)); 
adc1_dco_inst  : IBUFDS  port map (O => adc1_dco, I => adc_dco_p(1), IB => adc_dco_n(1)); 

--fco and dco bufg
dco_bufg_inst : BUFG port map (O => adc0_dco_bufg, I => adc0_dco);
fco_bufg_inst : BUFG port map (O => adc0_fco_bufg, I => adc0_fco);
dc1_bufg_inst : BUFG port map (O => adc1_dco_bufg, I => adc1_dco);
fc1_bufg_inst : BUFG port map (O => adc1_fco_bufg, I => adc1_fco);




adc0_fco_pll : entity work.adc_fco_phaseshift
port map ( 
  reset => sys_rst,
  clk_in1 => adc0_fco_bufg, --adc_fco_p(0),
  --clk_in1_n => adc_fco_n(0),
  clk_out1 => adc0_fco_mmcm,               
  psclk => sys_clk,
  psen => adc_fco_dlystr(0), 
  psincdec => '1', 
  psdone => adc0_fco_mmcm_psdone,
  locked => adc0_fco_mmcm_locked 
 );


adc1_fco_pll : entity work.adc_fco_phaseshift
port map ( 
  reset => sys_rst,
  clk_in1 => adc1_fco_bufg, --adc_fco_p(1),
  --clk_in1_n => adc_fco_n(1),
  clk_out1 => adc1_fco_mmcm,               
  psclk => sys_clk, 
  psen => adc_fco_dlystr(1), 
  psincdec => '1', --psincdec,
  psdone => adc1_fco_mmcm_psdone,
  locked => adc1_fco_mmcm_locked
 );



-- adc cha is on bits 0-3
adc0_da0_inst  : IBUFDS  port map (O => adca_sdata(0), I => adc_sdata_p(0), IB => adc_sdata_n(0)); 
adc0_da1_inst  : IBUFDS  port map (O => adca_sdata(1), I => adc_sdata_p(1), IB => adc_sdata_n(1)); 
adc0_da2_inst  : IBUFDS  port map (O => adca_sdata(2), I => adc_sdata_p(2), IB => adc_sdata_n(2)); 
adc0_da3_inst  : IBUFDS  port map (O => adca_sdata(3), I => adc_sdata_p(3), IB => adc_sdata_n(3)); 

--adc chb is on bits 4-7
adc0_da4_inst  : IBUFDS  port map (O => adcb_sdata(0), I => adc_sdata_p(4), IB => adc_sdata_n(4)); 
adc0_da5_inst  : IBUFDS  port map (O => adcb_sdata(1), I => adc_sdata_p(5), IB => adc_sdata_n(5)); 
adc0_da6_inst  : IBUFDS  port map (O => adcb_sdata(2), I => adc_sdata_p(6), IB => adc_sdata_n(6)); 
adc0_da7_inst  : IBUFDS  port map (O => adcb_sdata(3), I => adc_sdata_p(7), IB => adc_sdata_n(7)); 

-- adc chc is on bits 8-11
adc1_da0_inst  : IBUFDS  port map (O => adcc_sdata(0), I => adc_sdata_p(8), IB => adc_sdata_n(8)); 
adc1_da1_inst  : IBUFDS  port map (O => adcc_sdata(1), I => adc_sdata_p(9), IB => adc_sdata_n(9)); 
adc1_da2_inst  : IBUFDS  port map (O => adcc_sdata(2), I => adc_sdata_p(10), IB => adc_sdata_n(10)); 
adc1_da3_inst  : IBUFDS  port map (O => adcc_sdata(3), I => adc_sdata_p(11), IB => adc_sdata_n(11)); 

--adc chd is on bits 12-15
adc1_da4_inst  : IBUFDS  port map (O => adcd_sdata(0), I => adc_sdata_p(12), IB => adc_sdata_n(12)); 
adc1_da5_inst  : IBUFDS  port map (O => adcd_sdata(1), I => adc_sdata_p(13), IB => adc_sdata_n(13)); 
adc1_da6_inst  : IBUFDS  port map (O => adcd_sdata(2), I => adc_sdata_p(14), IB => adc_sdata_n(14)); 
adc1_da7_inst  : IBUFDS  port map (O => adcd_sdata(3), I => adc_sdata_p(15), IB => adc_sdata_n(15)); 






adc_cha: entity work.adc_s2p
  port map (
    sys_rst => sys_rst,
    sys_clk => sys_clk,
    adc_dclk => adc0_dco_bufg,
    adc_fclk => adc0_fco_mmcm, 
    adc_idly_wrval => adc_idly_wrval,
    adc_idly_wrstr => adc_idly_wrstr(3 downto 0),
    adc_idly_rdval => open, --adc_idly_rdval,
    adc_sdata => adca_sdata, 
    adc_out => adca_data
);

adc_chb: entity work.adc_s2p
  port map (
    sys_rst => sys_rst,  
    sys_clk => sys_clk,
    adc_dclk => adc0_dco_bufg,
    adc_fclk => adc0_fco_mmcm, 
    adc_idly_wrval => adc_idly_wrval,
    adc_idly_wrstr => adc_idly_wrstr(7 downto 4),
    adc_idly_rdval => open, --adc_idly_rdval,    
    adc_sdata => adcb_sdata, 
    adc_out => adcb_data
);

adc_chc: entity work.adc_s2p
  port map (
    sys_rst => sys_rst,
    sys_clk => sys_clk,  
    adc_dclk => adc1_dco_bufg,
    adc_fclk => adc1_fco_mmcm, 
    adc_idly_wrval => adc_idly_wrval,
    adc_idly_wrstr => adc_idly_wrstr(11 downto 8),
    adc_idly_rdval => open, --adc_idly_rdval,      
    adc_sdata => adcc_sdata, 
    adc_out => adcc_data
);

adc_chd: entity work.adc_s2p
  port map (
    sys_rst => sys_rst,  
    sys_clk => sys_clk,
    adc_dclk => adc1_dco_bufg,
    adc_fclk => adc1_fco_mmcm, 
    adc_idly_wrval => adc_idly_wrval,
    adc_idly_wrstr => adc_idly_wrstr(15 downto 12),
    adc_idly_rdval => open, --adc_idly_rdval,    
    adc_sdata => adcd_sdata, 
    adc_out => adcd_data
);

--sync both adc's to adc0_fco_mmcm for now. 
adc_clk_out <= adc1_fco_mmcm;
 
 
--process(adc_clk_out)
--begin
--  if (rising_edge(adc_clk_out)) then
--     adc_data_s(0) <= adca_data;
--     adc_data_s(1) <= adcb_data;
--     adc_data_s(2) <= adcc_data;
--     adc_data_s(3) <= adcd_data;
--  end if;
--end process; 
 
 
----set to corret a,b,c,d channels
--process(adc_clk_out)
--begin
--  if (rising_edge(adc_clk_out)) then
--     adc_data(0) <= adc_data_s(2);
--     adc_data(1) <= adc_data_s(0);
--     adc_data(2) <= adc_data_s(3);
--     adc_data(3) <= adc_data_s(1);
--  end if;
--end process;





----sync adc fifo_wren
--process (adc0_fco_bufg,sys_rst)
--  begin  
--     if sys_rst = '1' then
--        adc0_fifo_wren <= '0';  
--     elsif (rising_edge(adc0_fco_bufg)) then
--			if (adc_fifo_wren = '1') then
--				adc0_fifo_wren <= '1';
--			else
--				adc0_fifo_wren <= '0';
--			end if;
--     end if;
--  end process;


----sync adc fifo_wren
--process (adc1_fco_bufg,sys_rst)
--  begin  
--     if sys_rst = '1' then
--        adc1_fifo_wren <= '0';  
--     elsif (rising_edge(adc1_fco_bufg)) then
--			if (adc_fifo_wren = '1') then
--				adc1_fifo_wren <= '1';
--			else
--				adc1_fifo_wren <= '0';
--			end if;
--     end if;
-- end process;


--adca_fifo:  adc_fifo
--  port map (
--    rst => adc_fifo_rst, --sys_rst, 
--    wr_clk => adc0_fco_bufg, 
--    rd_clk => adc_clk, 
--    din => adca_data, 
--    wr_en => adc0_fifo_wren,  
--    rd_en => '1', 
--    dout => adc_data(0), 
--    full => adc_fifo_full(0),  
--    empty => adc_fifo_empty(0)
--  );

--adcb_fifo:  adc_fifo
--  port map (
--    rst => sys_rst, 
--    wr_clk => adc0_fco_bufg, 
--    rd_clk => adc_clk, 
--    din => adcb_data, 
--    wr_en => adc0_fifo_wren,  
--    rd_en => '1', 
--    dout => adc_data(1), 
--    full => adc_fifo_full(1),  
--    empty => adc_fifo_empty(1)
--  );

--adcc_fifo:  adc_fifo
--  port map (
--    rst => sys_rst, 
--    wr_clk => adc1_fco_bufg, 
--    rd_clk => adc_clk, 
--    din => adcc_data, 
--    wr_en => adc1_fifo_wren, 
--    rd_en => '1', 
--    dout => adc_data(2), 
--    full => adc_fifo_full(2),  
--    empty => adc_fifo_empty(2)
--  );
  
--adcd_fifo:  adc_fifo
--  port map (
--    rst => sys_rst, 
--    wr_clk => adc1_fco_bufg, 
--    rd_clk => adc_clk, 
--    din => adcd_data, 
--    wr_en => adc1_fifo_wren,  
--    rd_en => '1', 
--    dout => adc_data(3), 
--    full => adc_fifo_full(3),  
--    empty => adc_fifo_empty(3)
--  );  
  




adc_spi: ltc2195_spi
  port map (
    clk => sys_clk,                     
    reset => sys_rst,                     
    adc_spi_we => adc_spi_we, 
    adc_spi_wdata => adc_spi_wdata,
    adc_spi_rdata => adc_spi_rdata, 
    csb => adc_csb,
    sdi => adc_sdi,
    sdo => adc_sdo,
    sclk => adc_sclk 
);       



adcdata_syn: if (SIM_MODE = 0) generate

process(adc_clk_out)
begin
  if (rising_edge(adc_clk_out)) then
     adc_data(0) <= adc_data_s(2);
     adc_data(1) <= adc_data_s(0);
     adc_data(2) <= adc_data_s(3);
     adc_data(3) <= adc_data_s(1);
  end if;
end process;

process(adc_clk_out)
begin
  if (rising_edge(adc_clk_out)) then
     adc_data_s(0) <= adca_data;
     adc_data_s(1) <= adcb_data;
     adc_data_s(2) <= adcc_data;
     adc_data_s(3) <= adcd_data;
  end if;
end process;


end generate;


adcdata_sim: if (SIM_MODE = 1) generate read_adc_data: 
  process(adc_clk_out,sys_rst)
    file adc_vector   : text open read_mode is "/home/mead/rfbpm/dualadadc_afe/firmware/zudfe_dualadadc_v6/python/sim_adcdata.txt";
    --file adc_vector   : text open read_mode is "/home/mead/zcu208/python/sim_adcdata.txt";

    variable row       : line;
    variable adca_raw  : integer;
    variable adcb_raw  : integer;
    variable adcc_raw  : integer;
    variable adcd_raw  : integer;
  
    begin
      if (falling_edge(adc_clk_out))  then
        readline(adc_vector,row);
        read(row,adca_raw);
        read(row,adcb_raw);
        read(row,adcc_raw);
        read(row,adcd_raw);
        adc_data(0) <= std_logic_vector(to_signed(adca_raw,16)); 
        adc_data(1) <= std_logic_vector(to_signed(adcb_raw,16));
        adc_data(2) <= std_logic_vector(to_signed(adcc_raw,16)); 
        adc_data(3) <= std_logic_vector(to_signed(adcd_raw,16));
      end if;
end process;
 
end generate;







end behv;
