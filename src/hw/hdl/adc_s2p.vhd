----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2021 08:51:50 AM
-- Design Name: 
-- Module Name: adc_s2p - behv
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
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity adc_s2p is
  port (
    sys_rst        : in std_logic;
    sys_clk        : in std_logic;
    adc_dclk       : in std_logic;
    adc_fclk       : in std_logic;
    adc_sdata      : in std_logic_vector(3 downto 0);
    adc_idly_wrval : in std_logic_vector(8 downto 0);
    adc_idly_wrstr : in std_logic_vector(3 downto 0);
    adc_idly_rdval : out std_logic_vector(8 downto 0);
    adc_out        : out std_logic_vector(15 downto 0)
);
end adc_s2p;

architecture behv of adc_s2p is

  signal adc_s0        : std_logic_vector(7 downto 0);
  signal adc_s1        : std_logic_vector(7 downto 0);
  signal adc_s2        : std_logic_vector(7 downto 0);
  signal adc_s3        : std_logic_vector(7 downto 0);
  signal serdes_out    : std_logic_vector(3 downto 0);
  signal adc_val       : std_logic_vector(15 downto 0);
  signal adc_reg       : std_logic_vector(15 downto 0);
  signal adc_data      : std_logic_vector(15 downto 0);
  
  signal adc_idly_rdval1 : std_logic_vector(8 downto 0);
  signal adc_idly_rdval2 : std_logic_vector(8 downto 0);  
  signal adc_idly_rdval3 : std_logic_vector(8 downto 0);  
  

  signal adc_sdata_dlyd          : std_logic_vector(3 downto 0);
  
  signal adc_q           : std_logic_vector(7 downto 0);



   attribute mark_debug     : string;
   --attribute mark_debug of adc_q: signal is "true"; 
   --attribute mark_debug of adc_val: signal is "true";
   --attribute mark_debug of adc_reg: signal is "true";
   --attribute mark_debug of adc_data: signal is "true";
   --attribute mark_debug of adc_out: signal is "true";
   --attribute mark_debug of adc_fclk: signal is "true";
   --attribute mark_debug of adc_idly_rdval: signal is "true";
   --attribute mark_debug of adc_idly_rdval1: signal is "true";
   --attribute mark_debug of adc_idly_rdval2: signal is "true";
   --attribute mark_debug of adc_idly_rdval3: signal is "true";      
      


begin


IDELAYE3_s0 : IDELAYE3
   generic map (
      CASCADE => "NONE",               -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "COUNT",          -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",          -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",           -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,                -- Input delay value setting
      IS_CLK_INVERTED => '0',          -- Optional inversion for CLK
      IS_RST_INVERTED => '0',          -- Optional inversion for RST
      REFCLK_FREQUENCY => 200.0,       -- IDELAYCTRL clock input frequency in MHz (200.0-800.0)
      SIM_DEVICE => "ULTRASCALE_PLUS", -- Set the device version for simulation functionality (ULTRASCALE,
                                       -- ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
      UPDATE_MODE => "ASYNC"           -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                       -- SYNC)
   )
   port map (
      CASC_OUT => open,               -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => adc_idly_rdval,  -- 9-bit output: Counter value output
      DATAOUT => adc_sdata_dlyd(0),   -- 1-bit output: Delayed data output
      CASC_IN => '0',                 -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0',             -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                      -- 1-bit input: Active-High enable increment/decrement input
      CLK => sys_clk,                 -- 1-bit input: Clock input
      CNTVALUEIN => adc_idly_wrval,   -- 9-bit input: Counter value input
      DATAIN => '0',                  -- 1-bit input: Data input from the logic
      EN_VTC => '0',                  -- 1-bit input: Keep delay constant over VT
      IDATAIN => adc_sdata(0),        -- 1-bit input: Data input from the IOBUF
      INC => '0',                     -- 1-bit input: Increment / Decrement tap delay input
      LOAD => adc_idly_wrstr(0),      -- 1-bit input: Load DELAY_VALUE input
      RST => sys_rst                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );


IDELAYE3_s1 : IDELAYE3
   generic map (
      CASCADE => "NONE",               -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "COUNT",          -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",          -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",           -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,                -- Input delay value setting
      IS_CLK_INVERTED => '0',          -- Optional inversion for CLK
      IS_RST_INVERTED => '0',          -- Optional inversion for RST
      REFCLK_FREQUENCY => 200.0,       -- IDELAYCTRL clock input frequency in MHz (200.0-800.0)
      SIM_DEVICE => "ULTRASCALE_PLUS", -- Set the device version for simulation functionality (ULTRASCALE,
                                       -- ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
      UPDATE_MODE => "ASYNC"           -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                       -- SYNC)
   )
   port map (
      CASC_OUT => open,               -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => adc_idly_rdval1,  -- 9-bit output: Counter value output
      DATAOUT => adc_sdata_dlyd(1),   -- 1-bit output: Delayed data output
      CASC_IN => '0',                 -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0',             -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                      -- 1-bit input: Active-High enable increment/decrement input
      CLK => sys_clk,                 -- 1-bit input: Clock input
      CNTVALUEIN => adc_idly_wrval,   -- 9-bit input: Counter value input
      DATAIN => '0',                  -- 1-bit input: Data input from the logic
      EN_VTC => '0',                  -- 1-bit input: Keep delay constant over VT
      IDATAIN => adc_sdata(1),        -- 1-bit input: Data input from the IOBUF
      INC => '0',                     -- 1-bit input: Increment / Decrement tap delay input
      LOAD => adc_idly_wrstr(1),      -- 1-bit input: Load DELAY_VALUE input
      RST => sys_rst                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_s2 : IDELAYE3
   generic map (
      CASCADE => "NONE",               -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "COUNT",          -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",          -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",           -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,                -- Input delay value setting
      IS_CLK_INVERTED => '0',          -- Optional inversion for CLK
      IS_RST_INVERTED => '0',          -- Optional inversion for RST
      REFCLK_FREQUENCY => 200.0,       -- IDELAYCTRL clock input frequency in MHz (200.0-800.0)
      SIM_DEVICE => "ULTRASCALE_PLUS", -- Set the device version for simulation functionality (ULTRASCALE,
                                       -- ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
      UPDATE_MODE => "ASYNC"           -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                       -- SYNC)
   )
   port map (
      CASC_OUT => open,               -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => adc_idly_rdval2,  -- 9-bit output: Counter value output
      DATAOUT => adc_sdata_dlyd(2),   -- 1-bit output: Delayed data output
      CASC_IN => '0',                 -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0',             -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                      -- 1-bit input: Active-High enable increment/decrement input
      CLK => sys_clk,                 -- 1-bit input: Clock input
      CNTVALUEIN => adc_idly_wrval,   -- 9-bit input: Counter value input
      DATAIN => '0',                  -- 1-bit input: Data input from the logic
      EN_VTC => '0',                  -- 1-bit input: Keep delay constant over VT
      IDATAIN => adc_sdata(2),        -- 1-bit input: Data input from the IOBUF
      INC => '0',                     -- 1-bit input: Increment / Decrement tap delay input
      LOAD => adc_idly_wrstr(2),      -- 1-bit input: Load DELAY_VALUE input
      RST => sys_rst                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );


IDELAYE3_s3 : IDELAYE3
   generic map (
      CASCADE => "NONE",               -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "COUNT",          -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",          -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",           -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,                -- Input delay value setting
      IS_CLK_INVERTED => '0',          -- Optional inversion for CLK
      IS_RST_INVERTED => '0',          -- Optional inversion for RST
      REFCLK_FREQUENCY => 200.0,       -- IDELAYCTRL clock input frequency in MHz (200.0-800.0)
      SIM_DEVICE => "ULTRASCALE_PLUS", -- Set the device version for simulation functionality (ULTRASCALE,
                                       -- ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
      UPDATE_MODE => "ASYNC"           -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                       -- SYNC)
   )
   port map (
      CASC_OUT => open,               -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => adc_idly_rdval3,  -- 9-bit output: Counter value output
      DATAOUT => adc_sdata_dlyd(3),   -- 1-bit output: Delayed data output
      CASC_IN => '0',                 -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0',             -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                      -- 1-bit input: Active-High enable increment/decrement input
      CLK => sys_clk,                 -- 1-bit input: Clock input
      CNTVALUEIN => adc_idly_wrval,   -- 9-bit input: Counter value input
      DATAIN => '0',                  -- 1-bit input: Data input from the logic
      EN_VTC => '0',                  -- 1-bit input: Keep delay constant over VT
      IDATAIN => adc_sdata(3),        -- 1-bit input: Data input from the IOBUF
      INC => '0',                     -- 1-bit input: Increment / Decrement tap delay input
      LOAD => adc_idly_wrstr(3),      -- 1-bit input: Load DELAY_VALUE input
      RST => sys_rst                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );



--ISERDESE3_0 : ISERDESE3
--  generic map (
--    DATA_WIDTH => 4,                 -- Parallel data width (4,8)
--    FIFO_ENABLE => "FALSE",          -- Enables the use of the FIFO
--    FIFO_SYNC_MODE => "FALSE",       -- Always set to FALSE. TRUE is reserved for later use.
--    IS_CLK_B_INVERTED => '1',        -- Optional inversion for CLK_B
--    IS_CLK_INVERTED => '0',          -- Optional inversion for CLK
--    IS_RST_INVERTED => '0',          -- Optional inversion for RST
--    SIM_DEVICE => "ULTRASCALE_PLUS"  -- Set the device version for simulation functionality (ULTRASCALE,
--                                       -- ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
--   )
--   port map (
--      FIFO_EMPTY => open,           -- 1-bit output: FIFO empty flag
--      INTERNAL_DIVCLK => open,      -- 1-bit output: Internally divided down clock used when FIFO is
--                                    -- disabled (do not connect)

--      Q => adc_s0,                  -- 8-bit registered output
--      CLK => adc_dclk,              -- 1-bit input: High-speed clock
--      CLKDIV => adc_fclk,           -- 1-bit input: Divided Clock
--      CLK_B => adc_dclk,            -- 1-bit input: Inversion of High-speed clock CLK
--      D => adc_sdata_dlyd(0),       -- 1-bit input: Serial Data Input
--      FIFO_RD_CLK => '0',           -- 1-bit input: FIFO read clock
--      FIFO_RD_EN =>'0',             -- 1-bit input: Enables reading the FIFO when asserted
--      RST => sys_rst                -- 1-bit input: Asynchronous Reset
--   );


--ISERDESE3_1 : ISERDESE3
--  generic map (
--    DATA_WIDTH => 4,                 -- Parallel data width (4,8)
--    FIFO_ENABLE => "FALSE",          -- Enables the use of the FIFO
--    FIFO_SYNC_MODE => "FALSE",       -- Always set to FALSE. TRUE is reserved for later use.
--    IS_CLK_B_INVERTED => '1',        -- Optional inversion for CLK_B
--    IS_CLK_INVERTED => '0',          -- Optional inversion for CLK
--    IS_RST_INVERTED => '0',          -- Optional inversion for RST
--    SIM_DEVICE => "ULTRASCALE_PLUS"  -- Set the device version for simulation functionality (ULTRASCALE,
--                                       -- ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
--   )
--   port map (
--      FIFO_EMPTY => open,           -- 1-bit output: FIFO empty flag
--      INTERNAL_DIVCLK => open,      -- 1-bit output: Internally divided down clock used when FIFO is
--                                    -- disabled (do not connect)

--      Q => adc_s1,                   -- 8-bit registered output
--      CLK => adc_dclk,              -- 1-bit input: High-speed clock
--      CLKDIV => adc_fclk,           -- 1-bit input: Divided Clock
--      CLK_B => adc_dclk,            -- 1-bit input: Inversion of High-speed clock CLK
--      D => adc_sdata(1),            -- 1-bit input: Serial Data Input
--      FIFO_RD_CLK => '0',           -- 1-bit input: FIFO read clock
--      FIFO_RD_EN =>'0',             -- 1-bit input: Enables reading the FIFO when asserted
--      RST => sys_rst                -- 1-bit input: Asynchronous Reset
--   );


--ISERDESE3_2 : ISERDESE3
--  generic map (
--    DATA_WIDTH => 4,                 -- Parallel data width (4,8)
--    FIFO_ENABLE => "FALSE",          -- Enables the use of the FIFO
--    FIFO_SYNC_MODE => "FALSE",       -- Always set to FALSE. TRUE is reserved for later use.
--    IS_CLK_B_INVERTED => '1',        -- Optional inversion for CLK_B
--    IS_CLK_INVERTED => '0',          -- Optional inversion for CLK
--    IS_RST_INVERTED => '0',          -- Optional inversion for RST
--    SIM_DEVICE => "ULTRASCALE_PLUS"  -- Set the device version for simulation functionality (ULTRASCALE,
--                                       -- ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
--   )
--   port map (
--      FIFO_EMPTY => open,           -- 1-bit output: FIFO empty flag
--      INTERNAL_DIVCLK => open,      -- 1-bit output: Internally divided down clock used when FIFO is
--                                    -- disabled (do not connect)

--      Q => adc_s2,                   -- 8-bit registered output
--      CLK => adc_dclk,              -- 1-bit input: High-speed clock
--      CLKDIV => adc_fclk,           -- 1-bit input: Divided Clock
--      CLK_B => adc_dclk,            -- 1-bit input: Inversion of High-speed clock CLK
--      D => adc_sdata(2),            -- 1-bit input: Serial Data Input
--      FIFO_RD_CLK => '0',           -- 1-bit input: FIFO read clock
--      FIFO_RD_EN =>'0',             -- 1-bit input: Enables reading the FIFO when asserted
--      RST => sys_rst                -- 1-bit input: Asynchronous Reset
--   );
   
   

--ISERDESE3_3 : ISERDESE3
--  generic map (
--    DATA_WIDTH => 4,                 -- Parallel data width (4,8)
--    FIFO_ENABLE => "FALSE",          -- Enables the use of the FIFO
--    FIFO_SYNC_MODE => "FALSE",       -- Always set to FALSE. TRUE is reserved for later use.
--    IS_CLK_B_INVERTED => '1',        -- Optional inversion for CLK_B
--    IS_CLK_INVERTED => '0',          -- Optional inversion for CLK
--    IS_RST_INVERTED => '0',          -- Optional inversion for RST
--    SIM_DEVICE => "ULTRASCALE_PLUS"  -- Set the device version for simulation functionality (ULTRASCALE,
--                                       -- ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
--   )
--   port map (
--      FIFO_EMPTY => open,           -- 1-bit output: FIFO empty flag
--      INTERNAL_DIVCLK => open,      -- 1-bit output: Internally divided down clock used when FIFO is
--                                    -- disabled (do not connect)

--      Q => adc_s3,                   -- 8-bit registered output
--      CLK => adc_dclk,              -- 1-bit input: High-speed clock
--      CLKDIV => adc_fclk,           -- 1-bit input: Divided Clock
--      CLK_B => adc_dclk,            -- 1-bit input: Inversion of High-speed clock CLK
--      D => adc_sdata(3),            -- 1-bit input: Serial Data Input
--      FIFO_RD_CLK => '0',           -- 1-bit input: FIFO read clock
--      FIFO_RD_EN =>'0',             -- 1-bit input: Enables reading the FIFO when asserted
--      RST => sys_rst                -- 1-bit input: Asynchronous Reset
--   );


 IDDR0_inst : IDDRE1
   generic map (
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
      IS_CB_INVERTED => '1',           -- Optional inversion for CB
      IS_C_INVERTED => '0'             -- Optional inversion for C
   )
   port map (
      Q1 => adc_q(1),      -- 1-bit output: Registered parallel output 1
      Q2 => adc_q(0),      -- 1-bit output: Registered parallel output 2
      C => adc_dclk,       -- 1-bit input: High-speed clock
      CB => adc_dclk,  -- 1-bit input: Inversion of High-speed clock C
      D => adc_sdata_dlyd(0),   -- 1-bit input: Serial Data Input
      R => '0'            -- 1-bit input: Active-High Async Reset
   );



IDDR1_inst : IDDRE1
   generic map (
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
      IS_CB_INVERTED => '1',           -- Optional inversion for CB
      IS_C_INVERTED => '0'             -- Optional inversion for C
   )
   port map (
      Q1 => adc_q(3),      -- 1-bit output: Registered parallel output 1
      Q2 => adc_q(2),      -- 1-bit output: Registered parallel output 2
      C => adc_dclk,       -- 1-bit input: High-speed clock
      CB => adc_dclk,  -- 1-bit input: Inversion of High-speed clock C
      D => adc_sdata_dlyd(1),   -- 1-bit input: Serial Data Input
      R => '0'            -- 1-bit input: Active-High Async Reset
   );



IDDR2_inst : IDDRE1
   generic map (
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
      IS_CB_INVERTED => '1',           -- Optional inversion for CB
      IS_C_INVERTED => '0'             -- Optional inversion for C
   )
   port map (
      Q1 => adc_q(5),      -- 1-bit output: Registered parallel output 1
      Q2 => adc_q(4),      -- 1-bit output: Registered parallel output 2
      C => adc_dclk,       -- 1-bit input: High-speed clock
      CB => adc_dclk,  -- 1-bit input: Inversion of High-speed clock C
      D => adc_sdata_dlyd(2),   -- 1-bit input: Serial Data Input
      R => '0'            -- 1-bit input: Active-High Async Reset
   );


IDDR3_inst : IDDRE1
   generic map (
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
      IS_CB_INVERTED => '1',           -- Optional inversion for CB
      IS_C_INVERTED => '0'             -- Optional inversion for C
   )
   port map (
      Q1 => adc_q(7),      -- 1-bit output: Registered parallel output 1
      Q2 => adc_q(6),      -- 1-bit output: Registered parallel output 2
      C => adc_dclk,       -- 1-bit input: High-speed clock
      CB => adc_dclk,  -- 1-bit input: Inversion of High-speed clock C
      D => adc_sdata_dlyd(3),   -- 1-bit input: Serial Data Input
      R => '0'            -- 1-bit input: Active-High Async Reset
   );




d0_s2p : process(adc_dclk)
  begin
    if (rising_edge(adc_dclk)) then
        adc_val(0)  <= adc_q(0);
        adc_val(1)  <= adc_q(1);
        adc_val(2)  <= adc_q(2);
        adc_val(3)  <= adc_q(3);
        adc_val(4)  <= adc_q(4);
        adc_val(5)  <= adc_q(5);
        adc_val(6)  <= adc_q(6);
        adc_val(7)  <= adc_q(7);
        adc_val(8)  <= adc_val(0);
        adc_val(9)  <= adc_val(1);
        adc_val(10) <= adc_val(2);
        adc_val(11) <= adc_val(3);  
        adc_val(12) <= adc_val(4);
        adc_val(13) <= adc_val(5);  
        adc_val(14) <= adc_val(6);
        adc_val(15) <= adc_val(7);       
    end if;
 end process d0_s2p;
      
      
--lat_d0: process(adc_dclk)
--  begin
--    if (rising_edge(adc_dclk)) then
--      if (adc_fclk = '1') then
--         adc_reg <= adc_val;       
--      end if;	
--    end if;
--end process;
           
           
reg_d0: process(adc_fclk)
  begin
    if (rising_edge(adc_fclk)) then
         adc_data(0)  <= adc_val(14);
         adc_data(1)  <= adc_val(12);        
         adc_data(2)  <= adc_val(15);
         adc_data(3)  <= adc_val(13);
         adc_data(4)  <= adc_val(6);
         adc_data(5)  <= adc_val(4);        
         adc_data(6)  <= adc_val(7);
         adc_data(7)  <= adc_val(5);
         adc_data(8)  <= adc_val(10);
         adc_data(9)  <= adc_val(8);        
         adc_data(10) <= adc_val(11);
         adc_data(11) <= adc_val(9);
         adc_data(12) <= adc_val(2);
         adc_data(13) <= adc_val(0);        
         adc_data(14) <= adc_val(3);
         adc_data(15) <= adc_val(1);                   	
    end if;
end process;

--reg_data: process(adc_fclk)
--  begin
--    if (rising_edge(adc_fclk)) then
--         adc_out(0)  <= adc_data(4);
--         adc_out(1)  <= adc_data(5);        
--         adc_out(2)  <= adc_data(6);
--         adc_out(3)  <= adc_data(7);
--         adc_out(4)  <= adc_data(0);
--         adc_out(5)  <= adc_data(1);        
--         adc_out(6)  <= adc_data(2);
--         adc_out(7)  <= adc_data(3);
--         adc_out(8)  <= adc_data(12);
--         adc_out(9)  <= adc_data(13);        
--         adc_out(10) <= adc_data(14);
--         adc_out(11) <= adc_data(15);
--         adc_out(12) <= adc_data(8);
--         adc_out(13) <= adc_data(9);        
--         adc_out(14) <= adc_data(10);
--         adc_out(15) <= adc_data(11);                   	
--    end if;
--end process;

reg_data: process(adc_fclk)
  begin
    if (rising_edge(adc_fclk)) then
         adc_out(0)  <= adc_data(4);
         adc_out(1)  <= adc_data(5);        
         adc_out(2)  <= adc_data(6);
         adc_out(3)  <= adc_data(7);
         adc_out(4)  <= adc_data(0);
         adc_out(5)  <= adc_data(1);        
         adc_out(6)  <= adc_data(2);
         adc_out(7)  <= adc_data(3);
         adc_out(8)  <= adc_data(12);
         adc_out(9)  <= adc_data(13);        
         adc_out(10) <= adc_data(14);
         adc_out(11) <= adc_data(15);
         adc_out(12) <= adc_data(8);
         adc_out(13) <= adc_data(9);        
         adc_out(14) <= adc_data(10);
         adc_out(15) <= adc_data(11);                   	
    end if;
end process;




end behv;
