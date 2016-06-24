-- Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 16.0.1 Build 218 06/01/2016 SJ Lite Edition"

-- DATE "06/24/2016 22:26:54"

-- 
-- Device: Altera 5CEBA7F27C7 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	top IS
    PORT (
	clk : IN std_logic;
	rst_n : IN std_logic;
	x : IN std_logic_vector(17 DOWNTO 0);
	y : OUT std_logic_vector(17 DOWNTO 0)
	);
END top;

-- Design Ports Information
-- y[0]	=>  Location: PIN_W13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[1]	=>  Location: PIN_AF21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[2]	=>  Location: PIN_AE13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[3]	=>  Location: PIN_AF19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[4]	=>  Location: PIN_AB15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[5]	=>  Location: PIN_AF14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[6]	=>  Location: PIN_AB16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[7]	=>  Location: PIN_AD16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[8]	=>  Location: PIN_AC18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[9]	=>  Location: PIN_AE10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[10]	=>  Location: PIN_U14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[11]	=>  Location: PIN_AF11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[12]	=>  Location: PIN_AF12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[13]	=>  Location: PIN_AD18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[14]	=>  Location: PIN_V12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[15]	=>  Location: PIN_AC13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[16]	=>  Location: PIN_AD12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[17]	=>  Location: PIN_U12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_P11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rst_n	=>  Location: PIN_V15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[17]	=>  Location: PIN_AB17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[0]	=>  Location: PIN_AF22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[1]	=>  Location: PIN_T17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[2]	=>  Location: PIN_AC17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[3]	=>  Location: PIN_AA16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[4]	=>  Location: PIN_AD17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[5]	=>  Location: PIN_AC14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[6]	=>  Location: PIN_AE18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[7]	=>  Location: PIN_AF13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[8]	=>  Location: PIN_AE14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[9]	=>  Location: PIN_AC15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[10]	=>  Location: PIN_AF18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[11]	=>  Location: PIN_AE19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[12]	=>  Location: PIN_V14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[13]	=>  Location: PIN_Y15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[14]	=>  Location: PIN_Y16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[15]	=>  Location: PIN_V20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[16]	=>  Location: PIN_W15,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF top IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_rst_n : std_logic;
SIGNAL ww_x : std_logic_vector(17 DOWNTO 0);
SIGNAL ww_y : std_logic_vector(17 DOWNTO 0);
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTADATAIN_bus\ : std_logic_vector(39 DOWNTO 0);
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\ : std_logic_vector(39 DOWNTO 0);
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTADATAIN_bus\ : std_logic_vector(39 DOWNTO 0);
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\ : std_logic_vector(39 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~feeder_combout\ : std_logic;
SIGNAL \rst_n~input_o\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0_combout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0_combout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0_combout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|dffe6~0_combout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|dffe6~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|dffe7~0_combout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|dffe7~q\ : std_logic;
SIGNAL \x[17]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][0]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]~DUPLICATE_q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|op_1~1_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|op_1~2\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|op_1~6\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|op_1~9_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|op_1~10\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|op_1~13_sumout\ : std_logic;
SIGNAL \x[16]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-1]~q\ : std_logic;
SIGNAL \x[15]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-2]~q\ : std_logic;
SIGNAL \x[14]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-3]~q\ : std_logic;
SIGNAL \x[13]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-4]~q\ : std_logic;
SIGNAL \x[12]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-5]~q\ : std_logic;
SIGNAL \x[11]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-6]~q\ : std_logic;
SIGNAL \x[10]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-7]~q\ : std_logic;
SIGNAL \x[9]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-8]~q\ : std_logic;
SIGNAL \x[8]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-9]~q\ : std_logic;
SIGNAL \x[7]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-10]~q\ : std_logic;
SIGNAL \x[6]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-11]~q\ : std_logic;
SIGNAL \x[5]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-12]~q\ : std_logic;
SIGNAL \x[4]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-13]~q\ : std_logic;
SIGNAL \x[3]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-14]~q\ : std_logic;
SIGNAL \x[2]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-15]~q\ : std_logic;
SIGNAL \x[1]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-16]~q\ : std_logic;
SIGNAL \x[0]~input_o\ : std_logic;
SIGNAL \mv.av[0].in_sr[0][-17]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][0]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-1]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-2]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-3]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-4]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-5]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-6]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-7]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-8]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-9]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-10]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-11]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-12]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-13]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-14]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-15]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-16]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17\ : std_logic;
SIGNAL \mv.av[0].in_sr[15][-17]~q\ : std_logic;
SIGNAL \Add1~98_cout\ : std_logic;
SIGNAL \Add1~99\ : std_logic;
SIGNAL \Add1~21_sumout\ : std_logic;
SIGNAL \Result~101_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-17]~q\ : std_logic;
SIGNAL \Add1~22\ : std_logic;
SIGNAL \Add1~23\ : std_logic;
SIGNAL \Add1~25_sumout\ : std_logic;
SIGNAL \Result~102_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-16]~q\ : std_logic;
SIGNAL \Add1~26\ : std_logic;
SIGNAL \Add1~27\ : std_logic;
SIGNAL \Add1~29_sumout\ : std_logic;
SIGNAL \Result~103_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-15]~q\ : std_logic;
SIGNAL \Add1~30\ : std_logic;
SIGNAL \Add1~31\ : std_logic;
SIGNAL \Add1~17_sumout\ : std_logic;
SIGNAL \Result~100_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-14]~q\ : std_logic;
SIGNAL \Add1~18\ : std_logic;
SIGNAL \Add1~19\ : std_logic;
SIGNAL \Add1~13_sumout\ : std_logic;
SIGNAL \Result~99_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-13]~q\ : std_logic;
SIGNAL \Add1~14\ : std_logic;
SIGNAL \Add1~15\ : std_logic;
SIGNAL \Add1~37_sumout\ : std_logic;
SIGNAL \Result~105_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-12]~q\ : std_logic;
SIGNAL \Add1~38\ : std_logic;
SIGNAL \Add1~39\ : std_logic;
SIGNAL \Add1~45_sumout\ : std_logic;
SIGNAL \Result~107_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-11]~q\ : std_logic;
SIGNAL \Add1~46\ : std_logic;
SIGNAL \Add1~47\ : std_logic;
SIGNAL \Add1~33_sumout\ : std_logic;
SIGNAL \Result~104_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-10]~q\ : std_logic;
SIGNAL \Add1~34\ : std_logic;
SIGNAL \Add1~35\ : std_logic;
SIGNAL \Add1~41_sumout\ : std_logic;
SIGNAL \Result~106_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-9]~q\ : std_logic;
SIGNAL \Add1~42\ : std_logic;
SIGNAL \Add1~43\ : std_logic;
SIGNAL \Add1~49_sumout\ : std_logic;
SIGNAL \Result~108_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-8]~q\ : std_logic;
SIGNAL \Add1~50\ : std_logic;
SIGNAL \Add1~51\ : std_logic;
SIGNAL \Add1~53_sumout\ : std_logic;
SIGNAL \Result~109_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-7]~q\ : std_logic;
SIGNAL \Add1~54\ : std_logic;
SIGNAL \Add1~55\ : std_logic;
SIGNAL \Add1~57_sumout\ : std_logic;
SIGNAL \Result~110_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-6]~q\ : std_logic;
SIGNAL \Add1~58\ : std_logic;
SIGNAL \Add1~59\ : std_logic;
SIGNAL \Add1~61_sumout\ : std_logic;
SIGNAL \Result~111_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-5]~q\ : std_logic;
SIGNAL \Add1~62\ : std_logic;
SIGNAL \Add1~63\ : std_logic;
SIGNAL \Add1~65_sumout\ : std_logic;
SIGNAL \Result~112_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-4]~q\ : std_logic;
SIGNAL \Add1~66\ : std_logic;
SIGNAL \Add1~67\ : std_logic;
SIGNAL \Add1~69_sumout\ : std_logic;
SIGNAL \Result~113_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-3]~q\ : std_logic;
SIGNAL \Add1~70\ : std_logic;
SIGNAL \Add1~71\ : std_logic;
SIGNAL \Add1~74\ : std_logic;
SIGNAL \Add1~75\ : std_logic;
SIGNAL \Add1~77_sumout\ : std_logic;
SIGNAL \Result~115_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-1]~q\ : std_logic;
SIGNAL \Add1~78\ : std_logic;
SIGNAL \Add1~79\ : std_logic;
SIGNAL \Add1~81_sumout\ : std_logic;
SIGNAL \Result~116_combout\ : std_logic;
SIGNAL \Add1~82\ : std_logic;
SIGNAL \Add1~83\ : std_logic;
SIGNAL \Add1~85_sumout\ : std_logic;
SIGNAL \Result~117_combout\ : std_logic;
SIGNAL \Add1~86\ : std_logic;
SIGNAL \Add1~87\ : std_logic;
SIGNAL \Add1~89_sumout\ : std_logic;
SIGNAL \Result~118_combout\ : std_logic;
SIGNAL \Add1~90\ : std_logic;
SIGNAL \Add1~91\ : std_logic;
SIGNAL \Add1~95\ : std_logic;
SIGNAL \Add1~5_sumout\ : std_logic;
SIGNAL \Add1~93_sumout\ : std_logic;
SIGNAL \Result~119_combout\ : std_logic;
SIGNAL \Add1~94\ : std_logic;
SIGNAL \Add1~6\ : std_logic;
SIGNAL \Add1~7\ : std_logic;
SIGNAL \Add1~10\ : std_logic;
SIGNAL \Add1~11\ : std_logic;
SIGNAL \Add1~1_sumout\ : std_logic;
SIGNAL \Add1~9_sumout\ : std_logic;
SIGNAL \Add1~73_sumout\ : std_logic;
SIGNAL \Result~114_combout\ : std_logic;
SIGNAL \mv.av[0].sum[-2]~q\ : std_logic;
SIGNAL \Add2~42\ : std_logic;
SIGNAL \Add2~46\ : std_logic;
SIGNAL \Add2~38\ : std_logic;
SIGNAL \Add2~34\ : std_logic;
SIGNAL \Add2~30\ : std_logic;
SIGNAL \Add2~26\ : std_logic;
SIGNAL \Add2~70\ : std_logic;
SIGNAL \Add2~74\ : std_logic;
SIGNAL \Add2~66\ : std_logic;
SIGNAL \Add2~62\ : std_logic;
SIGNAL \Add2~58\ : std_logic;
SIGNAL \Add2~21_sumout\ : std_logic;
SIGNAL \Add2~22\ : std_logic;
SIGNAL \Add2~17_sumout\ : std_logic;
SIGNAL \Add2~45_sumout\ : std_logic;
SIGNAL \Add2~41_sumout\ : std_logic;
SIGNAL \Add2~37_sumout\ : std_logic;
SIGNAL \Add2~33_sumout\ : std_logic;
SIGNAL \Add2~29_sumout\ : std_logic;
SIGNAL \Add2~25_sumout\ : std_logic;
SIGNAL \Result~59_combout\ : std_logic;
SIGNAL \Add2~18\ : std_logic;
SIGNAL \Add2~14\ : std_logic;
SIGNAL \Add2~9_sumout\ : std_logic;
SIGNAL \Add2~13_sumout\ : std_logic;
SIGNAL \Add2~10\ : std_logic;
SIGNAL \Add2~54\ : std_logic;
SIGNAL \Add2~5_sumout\ : std_logic;
SIGNAL \Result~60_combout\ : std_logic;
SIGNAL \rounds~1_combout\ : std_logic;
SIGNAL \Add2~6\ : std_logic;
SIGNAL \Add2~1_sumout\ : std_logic;
SIGNAL \Add2~57_sumout\ : std_logic;
SIGNAL \Add2~65_sumout\ : std_logic;
SIGNAL \Add2~73_sumout\ : std_logic;
SIGNAL \Add2~69_sumout\ : std_logic;
SIGNAL \Add2~61_sumout\ : std_logic;
SIGNAL \Add2~53_sumout\ : std_logic;
SIGNAL \Result~61_combout\ : std_logic;
SIGNAL \Add2~2\ : std_logic;
SIGNAL \Add2~49_sumout\ : std_logic;
SIGNAL \Result~62_combout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|op_1~1_sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|op_1~2\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|op_1~6\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|op_1~9_sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|op_1~10\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|op_1~13_sumout\ : std_logic;
SIGNAL \Result~63_combout\ : std_logic;
SIGNAL \Result~64_combout\ : std_logic;
SIGNAL \round_overflow~0_combout\ : std_logic;
SIGNAL \Result~97_combout\ : std_logic;
SIGNAL \Result~98_combout\ : std_logic;
SIGNAL \Result~95_combout\ : std_logic;
SIGNAL \Result~96_combout\ : std_logic;
SIGNAL \Result~93_combout\ : std_logic;
SIGNAL \Result~94_combout\ : std_logic;
SIGNAL \Result~91_combout\ : std_logic;
SIGNAL \Result~92_combout\ : std_logic;
SIGNAL \Result~89_combout\ : std_logic;
SIGNAL \Result~90_combout\ : std_logic;
SIGNAL \Result~87_combout\ : std_logic;
SIGNAL \Result~88_combout\ : std_logic;
SIGNAL \Result~85_combout\ : std_logic;
SIGNAL \Result~86_combout\ : std_logic;
SIGNAL \Result~83_combout\ : std_logic;
SIGNAL \Result~84_combout\ : std_logic;
SIGNAL \Result~81_combout\ : std_logic;
SIGNAL \Result~82_combout\ : std_logic;
SIGNAL \Result~79_combout\ : std_logic;
SIGNAL \Result~80_combout\ : std_logic;
SIGNAL \Result~77_combout\ : std_logic;
SIGNAL \Result~78_combout\ : std_logic;
SIGNAL \Result~75_combout\ : std_logic;
SIGNAL \Result~76_combout\ : std_logic;
SIGNAL \Result~71_combout\ : std_logic;
SIGNAL \Result~72_combout\ : std_logic;
SIGNAL \Result~65_combout\ : std_logic;
SIGNAL \Result~66_combout\ : std_logic;
SIGNAL \Result~73_combout\ : std_logic;
SIGNAL \Result~74_combout\ : std_logic;
SIGNAL \Result~69_combout\ : std_logic;
SIGNAL \Result~70_combout\ : std_logic;
SIGNAL \Result~67_combout\ : std_logic;
SIGNAL \Result~68_combout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17\ : std_logic;
SIGNAL \Add4~98_cout\ : std_logic;
SIGNAL \Add4~99\ : std_logic;
SIGNAL \Add4~17_sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13\ : std_logic;
SIGNAL \Add4~19\ : std_logic;
SIGNAL \Add4~23\ : std_logic;
SIGNAL \Add4~31\ : std_logic;
SIGNAL \Add4~14\ : std_logic;
SIGNAL \Add4~15\ : std_logic;
SIGNAL \Add4~25_sumout\ : std_logic;
SIGNAL \Result~41_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-13]~q\ : std_logic;
SIGNAL \Add4~26\ : std_logic;
SIGNAL \Add4~27\ : std_logic;
SIGNAL \Add4~33_sumout\ : std_logic;
SIGNAL \Result~43_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-12]~q\ : std_logic;
SIGNAL \Add4~34\ : std_logic;
SIGNAL \Add4~35\ : std_logic;
SIGNAL \Add4~37_sumout\ : std_logic;
SIGNAL \Result~44_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-11]~q\ : std_logic;
SIGNAL \Add4~38\ : std_logic;
SIGNAL \Add4~39\ : std_logic;
SIGNAL \Add4~41_sumout\ : std_logic;
SIGNAL \Result~45_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-10]~q\ : std_logic;
SIGNAL \Add4~42\ : std_logic;
SIGNAL \Add4~43\ : std_logic;
SIGNAL \Add4~45_sumout\ : std_logic;
SIGNAL \Result~46_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-9]~q\ : std_logic;
SIGNAL \Add4~46\ : std_logic;
SIGNAL \Add4~47\ : std_logic;
SIGNAL \Add4~49_sumout\ : std_logic;
SIGNAL \Result~47_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-8]~q\ : std_logic;
SIGNAL \Add4~50\ : std_logic;
SIGNAL \Add4~51\ : std_logic;
SIGNAL \Add4~53_sumout\ : std_logic;
SIGNAL \Result~48_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-7]~q\ : std_logic;
SIGNAL \Add4~54\ : std_logic;
SIGNAL \Add4~55\ : std_logic;
SIGNAL \Add4~57_sumout\ : std_logic;
SIGNAL \Result~49_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-6]~q\ : std_logic;
SIGNAL \Add4~58\ : std_logic;
SIGNAL \Add4~59\ : std_logic;
SIGNAL \Add4~61_sumout\ : std_logic;
SIGNAL \Result~50_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-5]~q\ : std_logic;
SIGNAL \Add4~62\ : std_logic;
SIGNAL \Add4~63\ : std_logic;
SIGNAL \Add4~65_sumout\ : std_logic;
SIGNAL \Result~51_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-4]~q\ : std_logic;
SIGNAL \Add4~66\ : std_logic;
SIGNAL \Add4~67\ : std_logic;
SIGNAL \Add4~71\ : std_logic;
SIGNAL \Add4~75\ : std_logic;
SIGNAL \Add4~79\ : std_logic;
SIGNAL \Add4~83\ : std_logic;
SIGNAL \Add4~87\ : std_logic;
SIGNAL \Add4~91\ : std_logic;
SIGNAL \Add4~95\ : std_logic;
SIGNAL \Add4~7\ : std_logic;
SIGNAL \Add4~9_sumout\ : std_logic;
SIGNAL \Add4~69_sumout\ : std_logic;
SIGNAL \Result~52_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-3]~q\ : std_logic;
SIGNAL \Add4~70\ : std_logic;
SIGNAL \Add4~73_sumout\ : std_logic;
SIGNAL \Result~53_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-2]~q\ : std_logic;
SIGNAL \Add4~74\ : std_logic;
SIGNAL \Add4~77_sumout\ : std_logic;
SIGNAL \Result~54_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-1]~q\ : std_logic;
SIGNAL \Add4~78\ : std_logic;
SIGNAL \Add4~81_sumout\ : std_logic;
SIGNAL \Result~55_combout\ : std_logic;
SIGNAL \Add4~82\ : std_logic;
SIGNAL \Add4~85_sumout\ : std_logic;
SIGNAL \Result~56_combout\ : std_logic;
SIGNAL \Add4~86\ : std_logic;
SIGNAL \Add4~89_sumout\ : std_logic;
SIGNAL \Result~57_combout\ : std_logic;
SIGNAL \Add4~90\ : std_logic;
SIGNAL \Add4~93_sumout\ : std_logic;
SIGNAL \Result~58_combout\ : std_logic;
SIGNAL \Add4~94\ : std_logic;
SIGNAL \Add4~6\ : std_logic;
SIGNAL \Add4~10\ : std_logic;
SIGNAL \Add4~11\ : std_logic;
SIGNAL \Add4~1_sumout\ : std_logic;
SIGNAL \Add4~5_sumout\ : std_logic;
SIGNAL \Result~39_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-17]~q\ : std_logic;
SIGNAL \Add4~18\ : std_logic;
SIGNAL \Add4~21_sumout\ : std_logic;
SIGNAL \Result~40_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-16]~q\ : std_logic;
SIGNAL \Add4~22\ : std_logic;
SIGNAL \Add4~29_sumout\ : std_logic;
SIGNAL \Result~42_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-15]~q\ : std_logic;
SIGNAL \Add4~30\ : std_logic;
SIGNAL \Add4~13_sumout\ : std_logic;
SIGNAL \Result~38_combout\ : std_logic;
SIGNAL \mv.av[1].sum[-14]~q\ : std_logic;
SIGNAL \mv.av[1].sum[-15]~DUPLICATE_q\ : std_logic;
SIGNAL \mv.av[1].sum[-16]~DUPLICATE_q\ : std_logic;
SIGNAL \rounds~0_combout\ : std_logic;
SIGNAL \mv.av[1].sum[4]~DUPLICATE_q\ : std_logic;
SIGNAL \mv.av[1].sum[1]~DUPLICATE_q\ : std_logic;
SIGNAL \Add5~42\ : std_logic;
SIGNAL \Add5~46\ : std_logic;
SIGNAL \Add5~38\ : std_logic;
SIGNAL \Add5~34\ : std_logic;
SIGNAL \Add5~30\ : std_logic;
SIGNAL \Add5~26\ : std_logic;
SIGNAL \Add5~70\ : std_logic;
SIGNAL \Add5~74\ : std_logic;
SIGNAL \Add5~66\ : std_logic;
SIGNAL \Add5~62\ : std_logic;
SIGNAL \Add5~58\ : std_logic;
SIGNAL \Add5~22\ : std_logic;
SIGNAL \Add5~18\ : std_logic;
SIGNAL \Add5~14\ : std_logic;
SIGNAL \Add5~10\ : std_logic;
SIGNAL \Add5~54\ : std_logic;
SIGNAL \Add5~6\ : std_logic;
SIGNAL \Add5~1_sumout\ : std_logic;
SIGNAL \Add5~61_sumout\ : std_logic;
SIGNAL \Add5~69_sumout\ : std_logic;
SIGNAL \Add5~57_sumout\ : std_logic;
SIGNAL \Add5~65_sumout\ : std_logic;
SIGNAL \Add5~73_sumout\ : std_logic;
SIGNAL \Add5~53_sumout\ : std_logic;
SIGNAL \Result~19_combout\ : std_logic;
SIGNAL \Add5~2\ : std_logic;
SIGNAL \Add5~49_sumout\ : std_logic;
SIGNAL \Add5~5_sumout\ : std_logic;
SIGNAL \Add5~21_sumout\ : std_logic;
SIGNAL \Add5~33_sumout\ : std_logic;
SIGNAL \Add5~29_sumout\ : std_logic;
SIGNAL \Add5~41_sumout\ : std_logic;
SIGNAL \Add5~37_sumout\ : std_logic;
SIGNAL \Add5~45_sumout\ : std_logic;
SIGNAL \Result~17_combout\ : std_logic;
SIGNAL \Add5~25_sumout\ : std_logic;
SIGNAL \Add5~17_sumout\ : std_logic;
SIGNAL \Add5~9_sumout\ : std_logic;
SIGNAL \Add5~13_sumout\ : std_logic;
SIGNAL \Result~18_combout\ : std_logic;
SIGNAL \Result~20_combout\ : std_logic;
SIGNAL \overflowx~0_combout\ : std_logic;
SIGNAL \Result~37_combout\ : std_logic;
SIGNAL \Result~36_combout\ : std_logic;
SIGNAL \Result~35_combout\ : std_logic;
SIGNAL \Result~34_combout\ : std_logic;
SIGNAL \Result~33_combout\ : std_logic;
SIGNAL \Result~32_combout\ : std_logic;
SIGNAL \Result~31_combout\ : std_logic;
SIGNAL \Result~30_combout\ : std_logic;
SIGNAL \Result~29_combout\ : std_logic;
SIGNAL \Result~28_combout\ : std_logic;
SIGNAL \Result~27_combout\ : std_logic;
SIGNAL \Result~26_combout\ : std_logic;
SIGNAL \Result~25_combout\ : std_logic;
SIGNAL \Result~24_combout\ : std_logic;
SIGNAL \Result~23_combout\ : std_logic;
SIGNAL \Result~22_combout\ : std_logic;
SIGNAL \Result~21_combout\ : std_logic;
SIGNAL \Add6~78_cout\ : std_logic;
SIGNAL \Add6~10\ : std_logic;
SIGNAL \Add6~14\ : std_logic;
SIGNAL \Add6~18\ : std_logic;
SIGNAL \Add6~22\ : std_logic;
SIGNAL \Add6~26\ : std_logic;
SIGNAL \Add6~30\ : std_logic;
SIGNAL \Add6~34\ : std_logic;
SIGNAL \Add6~38\ : std_logic;
SIGNAL \Add6~42\ : std_logic;
SIGNAL \Add6~46\ : std_logic;
SIGNAL \Add6~50\ : std_logic;
SIGNAL \Add6~54\ : std_logic;
SIGNAL \Add6~58\ : std_logic;
SIGNAL \Add6~62\ : std_logic;
SIGNAL \Add6~66\ : std_logic;
SIGNAL \Add6~70\ : std_logic;
SIGNAL \Add6~74\ : std_logic;
SIGNAL \Add6~1_sumout\ : std_logic;
SIGNAL \Add6~9_sumout\ : std_logic;
SIGNAL \Add6~2\ : std_logic;
SIGNAL \Add6~5_sumout\ : std_logic;
SIGNAL \Result~0_combout\ : std_logic;
SIGNAL \y[0]~reg0_q\ : std_logic;
SIGNAL \Add6~13_sumout\ : std_logic;
SIGNAL \Result~1_combout\ : std_logic;
SIGNAL \y[1]~reg0_q\ : std_logic;
SIGNAL \Add6~17_sumout\ : std_logic;
SIGNAL \Result~2_combout\ : std_logic;
SIGNAL \y[2]~reg0_q\ : std_logic;
SIGNAL \Add6~21_sumout\ : std_logic;
SIGNAL \Result~3_combout\ : std_logic;
SIGNAL \y[3]~reg0_q\ : std_logic;
SIGNAL \Add6~25_sumout\ : std_logic;
SIGNAL \Result~4_combout\ : std_logic;
SIGNAL \y[4]~reg0_q\ : std_logic;
SIGNAL \Add6~29_sumout\ : std_logic;
SIGNAL \Result~5_combout\ : std_logic;
SIGNAL \y[5]~reg0_q\ : std_logic;
SIGNAL \Add6~33_sumout\ : std_logic;
SIGNAL \Result~6_combout\ : std_logic;
SIGNAL \y[6]~reg0_q\ : std_logic;
SIGNAL \Add6~37_sumout\ : std_logic;
SIGNAL \Result~7_combout\ : std_logic;
SIGNAL \y[7]~reg0_q\ : std_logic;
SIGNAL \Add6~41_sumout\ : std_logic;
SIGNAL \Result~8_combout\ : std_logic;
SIGNAL \y[8]~reg0_q\ : std_logic;
SIGNAL \Add6~45_sumout\ : std_logic;
SIGNAL \Result~9_combout\ : std_logic;
SIGNAL \y[9]~reg0_q\ : std_logic;
SIGNAL \Add6~49_sumout\ : std_logic;
SIGNAL \Result~10_combout\ : std_logic;
SIGNAL \y[10]~reg0_q\ : std_logic;
SIGNAL \Add6~53_sumout\ : std_logic;
SIGNAL \Result~11_combout\ : std_logic;
SIGNAL \y[11]~reg0_q\ : std_logic;
SIGNAL \Add6~57_sumout\ : std_logic;
SIGNAL \Result~12_combout\ : std_logic;
SIGNAL \y[12]~reg0_q\ : std_logic;
SIGNAL \Add6~61_sumout\ : std_logic;
SIGNAL \Result~13_combout\ : std_logic;
SIGNAL \y[13]~reg0_q\ : std_logic;
SIGNAL \Add6~65_sumout\ : std_logic;
SIGNAL \Result~14_combout\ : std_logic;
SIGNAL \y[14]~reg0_q\ : std_logic;
SIGNAL \Add6~69_sumout\ : std_logic;
SIGNAL \Result~15_combout\ : std_logic;
SIGNAL \y[15]~reg0_q\ : std_logic;
SIGNAL \Add6~73_sumout\ : std_logic;
SIGNAL \Result~16_combout\ : std_logic;
SIGNAL \y[16]~reg0_q\ : std_logic;
SIGNAL \y[17]~0_combout\ : std_logic;
SIGNAL \y[17]~reg0_q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.av[0].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.av[1].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_Add5~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~1_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add6~1_sumout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[1]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-15]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-16]~DUPLICATE_q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[3]~DUPLICATE_q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_x[16]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[15]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[14]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[13]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[12]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[11]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[10]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[9]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[8]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[17]~input_o\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit2~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit3~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit2~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-1]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-2]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-3]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-4]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-5]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-6]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-7]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-8]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit3~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-11]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-9]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-12]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-10]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-14]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][-13]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].in_sr[15][0]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\ : std_logic_vector(1 DOWNTO 1);
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\ : std_logic;
SIGNAL \ALT_INV_Result~98_combout\ : std_logic;
SIGNAL \ALT_INV_Result~97_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_Result~96_combout\ : std_logic;
SIGNAL \ALT_INV_Result~95_combout\ : std_logic;
SIGNAL \ALT_INV_Result~94_combout\ : std_logic;
SIGNAL \ALT_INV_Result~93_combout\ : std_logic;
SIGNAL \ALT_INV_Result~92_combout\ : std_logic;
SIGNAL \ALT_INV_Result~91_combout\ : std_logic;
SIGNAL \ALT_INV_Result~90_combout\ : std_logic;
SIGNAL \ALT_INV_Result~89_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-1]~q\ : std_logic;
SIGNAL \ALT_INV_Result~88_combout\ : std_logic;
SIGNAL \ALT_INV_Result~87_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-2]~q\ : std_logic;
SIGNAL \ALT_INV_Result~86_combout\ : std_logic;
SIGNAL \ALT_INV_Result~85_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-3]~q\ : std_logic;
SIGNAL \ALT_INV_Result~84_combout\ : std_logic;
SIGNAL \ALT_INV_Result~83_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-4]~q\ : std_logic;
SIGNAL \ALT_INV_Result~82_combout\ : std_logic;
SIGNAL \ALT_INV_Result~81_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-5]~q\ : std_logic;
SIGNAL \ALT_INV_Result~80_combout\ : std_logic;
SIGNAL \ALT_INV_Result~79_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-6]~q\ : std_logic;
SIGNAL \ALT_INV_Result~78_combout\ : std_logic;
SIGNAL \ALT_INV_Result~77_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-7]~q\ : std_logic;
SIGNAL \ALT_INV_Result~76_combout\ : std_logic;
SIGNAL \ALT_INV_Result~75_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-8]~q\ : std_logic;
SIGNAL \ALT_INV_Result~74_combout\ : std_logic;
SIGNAL \ALT_INV_Result~73_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-11]~q\ : std_logic;
SIGNAL \ALT_INV_Result~72_combout\ : std_logic;
SIGNAL \ALT_INV_Result~71_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-9]~q\ : std_logic;
SIGNAL \ALT_INV_Result~70_combout\ : std_logic;
SIGNAL \ALT_INV_Result~69_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-12]~q\ : std_logic;
SIGNAL \ALT_INV_Result~68_combout\ : std_logic;
SIGNAL \ALT_INV_Result~67_combout\ : std_logic;
SIGNAL \ALT_INV_Result~66_combout\ : std_logic;
SIGNAL \ALT_INV_Result~65_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-10]~q\ : std_logic;
SIGNAL \ALT_INV_round_overflow~0_combout\ : std_logic;
SIGNAL \ALT_INV_Result~64_combout\ : std_logic;
SIGNAL \ALT_INV_Result~63_combout\ : std_logic;
SIGNAL \ALT_INV_Result~62_combout\ : std_logic;
SIGNAL \ALT_INV_Result~61_combout\ : std_logic;
SIGNAL \ALT_INV_Result~60_combout\ : std_logic;
SIGNAL \ALT_INV_Result~59_combout\ : std_logic;
SIGNAL \ALT_INV_rounds~1_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-14]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[0].sum[-13]~q\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\ : std_logic_vector(1 DOWNTO 1);
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\ : std_logic;
SIGNAL \ALT_INV_Result~37_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_Result~36_combout\ : std_logic;
SIGNAL \ALT_INV_Result~35_combout\ : std_logic;
SIGNAL \ALT_INV_Result~34_combout\ : std_logic;
SIGNAL \ALT_INV_Result~33_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-1]~q\ : std_logic;
SIGNAL \ALT_INV_Result~32_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-2]~q\ : std_logic;
SIGNAL \ALT_INV_Result~31_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-3]~q\ : std_logic;
SIGNAL \ALT_INV_Result~30_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-4]~q\ : std_logic;
SIGNAL \ALT_INV_Result~29_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-5]~q\ : std_logic;
SIGNAL \ALT_INV_Result~28_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-6]~q\ : std_logic;
SIGNAL \ALT_INV_Result~27_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-7]~q\ : std_logic;
SIGNAL \ALT_INV_Result~26_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-8]~q\ : std_logic;
SIGNAL \ALT_INV_Result~25_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-9]~q\ : std_logic;
SIGNAL \ALT_INV_Result~24_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-10]~q\ : std_logic;
SIGNAL \ALT_INV_Result~23_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-11]~q\ : std_logic;
SIGNAL \ALT_INV_Result~22_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-12]~q\ : std_logic;
SIGNAL \ALT_INV_overflowx~0_combout\ : std_logic;
SIGNAL \ALT_INV_Result~21_combout\ : std_logic;
SIGNAL \ALT_INV_Result~20_combout\ : std_logic;
SIGNAL \ALT_INV_Result~19_combout\ : std_logic;
SIGNAL \ALT_INV_Result~18_combout\ : std_logic;
SIGNAL \ALT_INV_Result~17_combout\ : std_logic;
SIGNAL \ALT_INV_rounds~0_combout\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-13]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.av[1].sum[-14]~q\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~93_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~89_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~85_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~81_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~77_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~49_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~1_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a1\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a2\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a3\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a4\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a5\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a6\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a7\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a8\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a9\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a10\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a11\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a12\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a13\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a14\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a15\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a16\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a17\ : std_logic;
SIGNAL \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\ : std_logic;
SIGNAL \ALT_INV_Add2~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~1_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~93_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~89_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~85_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~81_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~77_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~33_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_Add4~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~1_sumout\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a1\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a2\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a3\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a4\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a5\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a6\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a7\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a8\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a9\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a10\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a11\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a12\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a13\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a14\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a15\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a16\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a17\ : std_logic;
SIGNAL \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\ : std_logic;
SIGNAL \ALT_INV_Add5~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~17_sumout\ : std_logic;

BEGIN

ww_clk <= clk;
ww_rst_n <= rst_n;
ww_x <= x;
y <= ww_y;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTADATAIN_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \mv.av[0].in_sr[0][-17]~q\ & 
\mv.av[0].in_sr[0][-16]~q\ & \mv.av[0].in_sr[0][-15]~q\ & \mv.av[0].in_sr[0][-14]~q\ & \mv.av[0].in_sr[0][-13]~q\ & \mv.av[0].in_sr[0][-12]~q\ & \mv.av[0].in_sr[0][-11]~q\ & \mv.av[0].in_sr[0][-10]~q\ & \mv.av[0].in_sr[0][-9]~q\ & 
\mv.av[0].in_sr[0][-8]~q\ & \mv.av[0].in_sr[0][-7]~q\ & \mv.av[0].in_sr[0][-6]~q\ & \mv.av[0].in_sr[0][-5]~q\ & \mv.av[0].in_sr[0][-4]~q\ & \mv.av[0].in_sr[0][-3]~q\ & \mv.av[0].in_sr[0][-2]~q\ & \mv.av[0].in_sr[0][-1]~q\ & \mv.av[0].in_sr[0][0]~q\);

\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTAADDR_bus\ <= (\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBADDR_bus\ <= (\mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(0);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(1);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(2);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(3);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(4);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(5);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(6);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(7);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(8);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(9);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(10);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(11);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(12);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(13);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(14);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(15);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(16);
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17\ <= \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(17);

\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTADATAIN_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \Result~68_combout\ & 
\Result~70_combout\ & \Result~74_combout\ & \Result~66_combout\ & \Result~72_combout\ & \Result~76_combout\ & \Result~78_combout\ & \Result~80_combout\ & \Result~82_combout\ & \Result~84_combout\ & \Result~86_combout\ & \Result~88_combout\ & 
\Result~90_combout\ & \Result~92_combout\ & \Result~94_combout\ & \Result~96_combout\ & \Result~98_combout\ & \Result~62_combout\);

\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTAADDR_bus\ <= (\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\);

\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBADDR_bus\ <= (\mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(0);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(1);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(2);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(3);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(4);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(5);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(6);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(7);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(8);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(9);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(10);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(11);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(12);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(13);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(14);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(15);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(16);
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17\ <= \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(17);
\ALT_INV_Add5~13_sumout\ <= NOT \Add5~13_sumout\;
\ALT_INV_Add5~9_sumout\ <= NOT \Add5~9_sumout\;
\ALT_INV_Add5~5_sumout\ <= NOT \Add5~5_sumout\;
\ALT_INV_Add5~1_sumout\ <= NOT \Add5~1_sumout\;
\ALT_INV_Add6~73_sumout\ <= NOT \Add6~73_sumout\;
\ALT_INV_Add6~69_sumout\ <= NOT \Add6~69_sumout\;
\ALT_INV_Add6~65_sumout\ <= NOT \Add6~65_sumout\;
\ALT_INV_Add6~61_sumout\ <= NOT \Add6~61_sumout\;
\ALT_INV_Add6~57_sumout\ <= NOT \Add6~57_sumout\;
\ALT_INV_Add6~53_sumout\ <= NOT \Add6~53_sumout\;
\ALT_INV_Add6~49_sumout\ <= NOT \Add6~49_sumout\;
\ALT_INV_Add6~45_sumout\ <= NOT \Add6~45_sumout\;
\ALT_INV_Add6~41_sumout\ <= NOT \Add6~41_sumout\;
\ALT_INV_Add6~37_sumout\ <= NOT \Add6~37_sumout\;
\ALT_INV_Add6~33_sumout\ <= NOT \Add6~33_sumout\;
\ALT_INV_Add6~29_sumout\ <= NOT \Add6~29_sumout\;
\ALT_INV_Add6~25_sumout\ <= NOT \Add6~25_sumout\;
\ALT_INV_Add6~21_sumout\ <= NOT \Add6~21_sumout\;
\ALT_INV_Add6~17_sumout\ <= NOT \Add6~17_sumout\;
\ALT_INV_Add6~13_sumout\ <= NOT \Add6~13_sumout\;
\ALT_INV_Add6~9_sumout\ <= NOT \Add6~9_sumout\;
\ALT_INV_Add6~5_sumout\ <= NOT \Add6~5_sumout\;
\ALT_INV_Add6~1_sumout\ <= NOT \Add6~1_sumout\;
\ALT_INV_mv.av[1].sum[1]~DUPLICATE_q\ <= NOT \mv.av[1].sum[1]~DUPLICATE_q\;
\ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\ <= NOT \mv.av[1].sum[4]~DUPLICATE_q\;
\ALT_INV_mv.av[1].sum[-15]~DUPLICATE_q\ <= NOT \mv.av[1].sum[-15]~DUPLICATE_q\;
\ALT_INV_mv.av[1].sum[-16]~DUPLICATE_q\ <= NOT \mv.av[1].sum[-16]~DUPLICATE_q\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[3]~DUPLICATE_q\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]~DUPLICATE_q\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\;
\ALT_INV_x[16]~input_o\ <= NOT \x[16]~input_o\;
\ALT_INV_x[15]~input_o\ <= NOT \x[15]~input_o\;
\ALT_INV_x[14]~input_o\ <= NOT \x[14]~input_o\;
\ALT_INV_x[13]~input_o\ <= NOT \x[13]~input_o\;
\ALT_INV_x[12]~input_o\ <= NOT \x[12]~input_o\;
\ALT_INV_x[11]~input_o\ <= NOT \x[11]~input_o\;
\ALT_INV_x[10]~input_o\ <= NOT \x[10]~input_o\;
\ALT_INV_x[9]~input_o\ <= NOT \x[9]~input_o\;
\ALT_INV_x[8]~input_o\ <= NOT \x[8]~input_o\;
\ALT_INV_x[7]~input_o\ <= NOT \x[7]~input_o\;
\ALT_INV_x[6]~input_o\ <= NOT \x[6]~input_o\;
\ALT_INV_x[5]~input_o\ <= NOT \x[5]~input_o\;
\ALT_INV_x[4]~input_o\ <= NOT \x[4]~input_o\;
\ALT_INV_x[3]~input_o\ <= NOT \x[3]~input_o\;
\ALT_INV_x[2]~input_o\ <= NOT \x[2]~input_o\;
\ALT_INV_x[1]~input_o\ <= NOT \x[1]~input_o\;
\ALT_INV_x[0]~input_o\ <= NOT \x[0]~input_o\;
\ALT_INV_x[17]~input_o\ <= NOT \x[17]~input_o\;
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit0~q\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\;
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit1~q\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit0~q\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\;
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit2~q\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit1~q\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\;
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit3~q\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit2~q\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\;
\ALT_INV_mv.av[0].in_sr[15][-1]~q\ <= NOT \mv.av[0].in_sr[15][-1]~q\;
\ALT_INV_mv.av[0].in_sr[15][-2]~q\ <= NOT \mv.av[0].in_sr[15][-2]~q\;
\ALT_INV_mv.av[0].in_sr[15][-3]~q\ <= NOT \mv.av[0].in_sr[15][-3]~q\;
\ALT_INV_mv.av[0].in_sr[15][-4]~q\ <= NOT \mv.av[0].in_sr[15][-4]~q\;
\ALT_INV_mv.av[0].in_sr[15][-5]~q\ <= NOT \mv.av[0].in_sr[15][-5]~q\;
\ALT_INV_mv.av[0].in_sr[15][-6]~q\ <= NOT \mv.av[0].in_sr[15][-6]~q\;
\ALT_INV_mv.av[0].in_sr[15][-7]~q\ <= NOT \mv.av[0].in_sr[15][-7]~q\;
\ALT_INV_mv.av[0].in_sr[15][-8]~q\ <= NOT \mv.av[0].in_sr[15][-8]~q\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit3~q\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\;
\ALT_INV_mv.av[0].in_sr[15][-11]~q\ <= NOT \mv.av[0].in_sr[15][-11]~q\;
\ALT_INV_mv.av[0].in_sr[15][-9]~q\ <= NOT \mv.av[0].in_sr[15][-9]~q\;
\ALT_INV_mv.av[0].in_sr[15][-12]~q\ <= NOT \mv.av[0].in_sr[15][-12]~q\;
\ALT_INV_mv.av[0].in_sr[15][-10]~q\ <= NOT \mv.av[0].in_sr[15][-10]~q\;
\ALT_INV_mv.av[0].in_sr[15][-15]~q\ <= NOT \mv.av[0].in_sr[15][-15]~q\;
\ALT_INV_mv.av[0].in_sr[15][-16]~q\ <= NOT \mv.av[0].in_sr[15][-16]~q\;
\ALT_INV_mv.av[0].in_sr[15][-17]~q\ <= NOT \mv.av[0].in_sr[15][-17]~q\;
\ALT_INV_mv.av[0].in_sr[15][-14]~q\ <= NOT \mv.av[0].in_sr[15][-14]~q\;
\ALT_INV_mv.av[0].in_sr[15][-13]~q\ <= NOT \mv.av[0].in_sr[15][-13]~q\;
\ALT_INV_mv.av[0].in_sr[15][0]~q\ <= NOT \mv.av[0].in_sr[15][0]~q\;
\mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\;
\mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\;
\mv.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1) <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\(1);
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3) <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3);
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2) <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2);
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1) <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1);
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0) <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0);
\mv.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|dffe6~q\;
\ALT_INV_Result~98_combout\ <= NOT \Result~98_combout\;
\ALT_INV_Result~97_combout\ <= NOT \Result~97_combout\;
\ALT_INV_mv.av[0].sum\(3) <= NOT \mv.av[0].sum\(3);
\ALT_INV_Result~96_combout\ <= NOT \Result~96_combout\;
\ALT_INV_Result~95_combout\ <= NOT \Result~95_combout\;
\ALT_INV_mv.av[0].sum\(2) <= NOT \mv.av[0].sum\(2);
\ALT_INV_Result~94_combout\ <= NOT \Result~94_combout\;
\ALT_INV_Result~93_combout\ <= NOT \Result~93_combout\;
\ALT_INV_mv.av[0].sum\(1) <= NOT \mv.av[0].sum\(1);
\ALT_INV_Result~92_combout\ <= NOT \Result~92_combout\;
\ALT_INV_Result~91_combout\ <= NOT \Result~91_combout\;
\ALT_INV_mv.av[0].sum\(0) <= NOT \mv.av[0].sum\(0);
\ALT_INV_Result~90_combout\ <= NOT \Result~90_combout\;
\ALT_INV_Result~89_combout\ <= NOT \Result~89_combout\;
\ALT_INV_mv.av[0].sum[-1]~q\ <= NOT \mv.av[0].sum[-1]~q\;
\ALT_INV_Result~88_combout\ <= NOT \Result~88_combout\;
\ALT_INV_Result~87_combout\ <= NOT \Result~87_combout\;
\ALT_INV_mv.av[0].sum[-2]~q\ <= NOT \mv.av[0].sum[-2]~q\;
\ALT_INV_Result~86_combout\ <= NOT \Result~86_combout\;
\ALT_INV_Result~85_combout\ <= NOT \Result~85_combout\;
\ALT_INV_mv.av[0].sum[-3]~q\ <= NOT \mv.av[0].sum[-3]~q\;
\ALT_INV_Result~84_combout\ <= NOT \Result~84_combout\;
\ALT_INV_Result~83_combout\ <= NOT \Result~83_combout\;
\ALT_INV_mv.av[0].sum[-4]~q\ <= NOT \mv.av[0].sum[-4]~q\;
\ALT_INV_Result~82_combout\ <= NOT \Result~82_combout\;
\ALT_INV_Result~81_combout\ <= NOT \Result~81_combout\;
\ALT_INV_mv.av[0].sum[-5]~q\ <= NOT \mv.av[0].sum[-5]~q\;
\ALT_INV_Result~80_combout\ <= NOT \Result~80_combout\;
\ALT_INV_Result~79_combout\ <= NOT \Result~79_combout\;
\ALT_INV_mv.av[0].sum[-6]~q\ <= NOT \mv.av[0].sum[-6]~q\;
\ALT_INV_Result~78_combout\ <= NOT \Result~78_combout\;
\ALT_INV_Result~77_combout\ <= NOT \Result~77_combout\;
\ALT_INV_mv.av[0].sum[-7]~q\ <= NOT \mv.av[0].sum[-7]~q\;
\ALT_INV_Result~76_combout\ <= NOT \Result~76_combout\;
\ALT_INV_Result~75_combout\ <= NOT \Result~75_combout\;
\ALT_INV_mv.av[0].sum[-8]~q\ <= NOT \mv.av[0].sum[-8]~q\;
\ALT_INV_Result~74_combout\ <= NOT \Result~74_combout\;
\ALT_INV_Result~73_combout\ <= NOT \Result~73_combout\;
\ALT_INV_mv.av[0].sum[-11]~q\ <= NOT \mv.av[0].sum[-11]~q\;
\ALT_INV_Result~72_combout\ <= NOT \Result~72_combout\;
\ALT_INV_Result~71_combout\ <= NOT \Result~71_combout\;
\ALT_INV_mv.av[0].sum[-9]~q\ <= NOT \mv.av[0].sum[-9]~q\;
\ALT_INV_Result~70_combout\ <= NOT \Result~70_combout\;
\ALT_INV_Result~69_combout\ <= NOT \Result~69_combout\;
\ALT_INV_mv.av[0].sum[-12]~q\ <= NOT \mv.av[0].sum[-12]~q\;
\ALT_INV_Result~68_combout\ <= NOT \Result~68_combout\;
\ALT_INV_Result~67_combout\ <= NOT \Result~67_combout\;
\ALT_INV_Result~66_combout\ <= NOT \Result~66_combout\;
\ALT_INV_Result~65_combout\ <= NOT \Result~65_combout\;
\ALT_INV_mv.av[0].sum[-10]~q\ <= NOT \mv.av[0].sum[-10]~q\;
\ALT_INV_round_overflow~0_combout\ <= NOT \round_overflow~0_combout\;
\ALT_INV_Result~64_combout\ <= NOT \Result~64_combout\;
\ALT_INV_Result~63_combout\ <= NOT \Result~63_combout\;
\ALT_INV_Result~62_combout\ <= NOT \Result~62_combout\;
\ALT_INV_Result~61_combout\ <= NOT \Result~61_combout\;
\ALT_INV_Result~60_combout\ <= NOT \Result~60_combout\;
\ALT_INV_Result~59_combout\ <= NOT \Result~59_combout\;
\ALT_INV_rounds~1_combout\ <= NOT \rounds~1_combout\;
\ALT_INV_mv.av[0].sum[-15]~q\ <= NOT \mv.av[0].sum[-15]~q\;
\ALT_INV_mv.av[0].sum[-16]~q\ <= NOT \mv.av[0].sum[-16]~q\;
\ALT_INV_mv.av[0].sum[-17]~q\ <= NOT \mv.av[0].sum[-17]~q\;
\ALT_INV_mv.av[0].sum[-14]~q\ <= NOT \mv.av[0].sum[-14]~q\;
\ALT_INV_mv.av[0].sum[-13]~q\ <= NOT \mv.av[0].sum[-13]~q\;
\ALT_INV_mv.av[0].sum\(4) <= NOT \mv.av[0].sum\(4);
\mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1) <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\(1);
\mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|dffe7~q\;
\ALT_INV_Result~37_combout\ <= NOT \Result~37_combout\;
\ALT_INV_mv.av[1].sum\(3) <= NOT \mv.av[1].sum\(3);
\ALT_INV_Result~36_combout\ <= NOT \Result~36_combout\;
\ALT_INV_mv.av[1].sum\(2) <= NOT \mv.av[1].sum\(2);
\ALT_INV_Result~35_combout\ <= NOT \Result~35_combout\;
\ALT_INV_mv.av[1].sum\(1) <= NOT \mv.av[1].sum\(1);
\ALT_INV_Result~34_combout\ <= NOT \Result~34_combout\;
\ALT_INV_mv.av[1].sum\(0) <= NOT \mv.av[1].sum\(0);
\ALT_INV_Result~33_combout\ <= NOT \Result~33_combout\;
\ALT_INV_mv.av[1].sum[-1]~q\ <= NOT \mv.av[1].sum[-1]~q\;
\ALT_INV_Result~32_combout\ <= NOT \Result~32_combout\;
\ALT_INV_mv.av[1].sum[-2]~q\ <= NOT \mv.av[1].sum[-2]~q\;
\ALT_INV_Result~31_combout\ <= NOT \Result~31_combout\;
\ALT_INV_mv.av[1].sum[-3]~q\ <= NOT \mv.av[1].sum[-3]~q\;
\ALT_INV_Result~30_combout\ <= NOT \Result~30_combout\;
\ALT_INV_mv.av[1].sum[-4]~q\ <= NOT \mv.av[1].sum[-4]~q\;
\ALT_INV_Result~29_combout\ <= NOT \Result~29_combout\;
\ALT_INV_mv.av[1].sum[-5]~q\ <= NOT \mv.av[1].sum[-5]~q\;
\ALT_INV_Result~28_combout\ <= NOT \Result~28_combout\;
\ALT_INV_mv.av[1].sum[-6]~q\ <= NOT \mv.av[1].sum[-6]~q\;
\ALT_INV_Result~27_combout\ <= NOT \Result~27_combout\;
\ALT_INV_mv.av[1].sum[-7]~q\ <= NOT \mv.av[1].sum[-7]~q\;
\ALT_INV_Result~26_combout\ <= NOT \Result~26_combout\;
\ALT_INV_mv.av[1].sum[-8]~q\ <= NOT \mv.av[1].sum[-8]~q\;
\ALT_INV_Result~25_combout\ <= NOT \Result~25_combout\;
\ALT_INV_mv.av[1].sum[-9]~q\ <= NOT \mv.av[1].sum[-9]~q\;
\ALT_INV_Result~24_combout\ <= NOT \Result~24_combout\;
\ALT_INV_mv.av[1].sum[-10]~q\ <= NOT \mv.av[1].sum[-10]~q\;
\ALT_INV_Result~23_combout\ <= NOT \Result~23_combout\;
\ALT_INV_mv.av[1].sum[-11]~q\ <= NOT \mv.av[1].sum[-11]~q\;
\ALT_INV_Result~22_combout\ <= NOT \Result~22_combout\;
\ALT_INV_mv.av[1].sum[-12]~q\ <= NOT \mv.av[1].sum[-12]~q\;
\ALT_INV_overflowx~0_combout\ <= NOT \overflowx~0_combout\;
\ALT_INV_Result~21_combout\ <= NOT \Result~21_combout\;
\ALT_INV_Result~20_combout\ <= NOT \Result~20_combout\;
\ALT_INV_Result~19_combout\ <= NOT \Result~19_combout\;
\ALT_INV_Result~18_combout\ <= NOT \Result~18_combout\;
\ALT_INV_Result~17_combout\ <= NOT \Result~17_combout\;
\ALT_INV_mv.av[1].sum\(4) <= NOT \mv.av[1].sum\(4);
\ALT_INV_rounds~0_combout\ <= NOT \rounds~0_combout\;
\ALT_INV_mv.av[1].sum[-15]~q\ <= NOT \mv.av[1].sum[-15]~q\;
\ALT_INV_mv.av[1].sum[-13]~q\ <= NOT \mv.av[1].sum[-13]~q\;
\ALT_INV_mv.av[1].sum[-16]~q\ <= NOT \mv.av[1].sum[-16]~q\;
\ALT_INV_mv.av[1].sum[-17]~q\ <= NOT \mv.av[1].sum[-17]~q\;
\ALT_INV_mv.av[1].sum[-14]~q\ <= NOT \mv.av[1].sum[-14]~q\;
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita0~sumout\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~sumout\;
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita1~sumout\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\;
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita2~sumout\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\;
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~sumout\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita2~sumout\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\;
\mv.av[1].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\;
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~1_sumout\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\;
\ALT_INV_Add1~93_sumout\ <= NOT \Add1~93_sumout\;
\ALT_INV_Add1~89_sumout\ <= NOT \Add1~89_sumout\;
\ALT_INV_Add1~85_sumout\ <= NOT \Add1~85_sumout\;
\ALT_INV_Add1~81_sumout\ <= NOT \Add1~81_sumout\;
\ALT_INV_Add1~77_sumout\ <= NOT \Add1~77_sumout\;
\ALT_INV_Add1~73_sumout\ <= NOT \Add1~73_sumout\;
\ALT_INV_Add1~69_sumout\ <= NOT \Add1~69_sumout\;
\ALT_INV_Add1~65_sumout\ <= NOT \Add1~65_sumout\;
\ALT_INV_Add1~61_sumout\ <= NOT \Add1~61_sumout\;
\ALT_INV_Add1~57_sumout\ <= NOT \Add1~57_sumout\;
\ALT_INV_Add1~53_sumout\ <= NOT \Add1~53_sumout\;
\ALT_INV_Add1~49_sumout\ <= NOT \Add1~49_sumout\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~sumout\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\;
\ALT_INV_Add1~45_sumout\ <= NOT \Add1~45_sumout\;
\ALT_INV_Add1~41_sumout\ <= NOT \Add1~41_sumout\;
\ALT_INV_Add1~37_sumout\ <= NOT \Add1~37_sumout\;
\ALT_INV_Add1~33_sumout\ <= NOT \Add1~33_sumout\;
\ALT_INV_Add1~29_sumout\ <= NOT \Add1~29_sumout\;
\ALT_INV_Add1~25_sumout\ <= NOT \Add1~25_sumout\;
\ALT_INV_Add1~21_sumout\ <= NOT \Add1~21_sumout\;
\ALT_INV_Add1~17_sumout\ <= NOT \Add1~17_sumout\;
\ALT_INV_Add1~13_sumout\ <= NOT \Add1~13_sumout\;
\ALT_INV_Add1~9_sumout\ <= NOT \Add1~9_sumout\;
\ALT_INV_Add1~5_sumout\ <= NOT \Add1~5_sumout\;
\ALT_INV_Add1~1_sumout\ <= NOT \Add1~1_sumout\;
\mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_comb_bita3~1_sumout\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~1_sumout\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a1\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a2\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a3\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a4\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a5\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a6\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a7\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a8\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a9\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a10\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a11\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a12\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a13\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a14\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a15\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a16\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a17\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17\;
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\ <= NOT \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\;
\ALT_INV_Add2~73_sumout\ <= NOT \Add2~73_sumout\;
\ALT_INV_Add2~69_sumout\ <= NOT \Add2~69_sumout\;
\ALT_INV_Add2~65_sumout\ <= NOT \Add2~65_sumout\;
\ALT_INV_Add2~61_sumout\ <= NOT \Add2~61_sumout\;
\ALT_INV_Add2~57_sumout\ <= NOT \Add2~57_sumout\;
\ALT_INV_Add2~53_sumout\ <= NOT \Add2~53_sumout\;
\ALT_INV_Add2~49_sumout\ <= NOT \Add2~49_sumout\;
\ALT_INV_Add2~45_sumout\ <= NOT \Add2~45_sumout\;
\ALT_INV_Add2~41_sumout\ <= NOT \Add2~41_sumout\;
\ALT_INV_Add2~37_sumout\ <= NOT \Add2~37_sumout\;
\ALT_INV_Add2~33_sumout\ <= NOT \Add2~33_sumout\;
\ALT_INV_Add2~29_sumout\ <= NOT \Add2~29_sumout\;
\ALT_INV_Add2~25_sumout\ <= NOT \Add2~25_sumout\;
\ALT_INV_Add2~21_sumout\ <= NOT \Add2~21_sumout\;
\ALT_INV_Add2~17_sumout\ <= NOT \Add2~17_sumout\;
\ALT_INV_Add2~13_sumout\ <= NOT \Add2~13_sumout\;
\ALT_INV_Add2~9_sumout\ <= NOT \Add2~9_sumout\;
\ALT_INV_Add2~5_sumout\ <= NOT \Add2~5_sumout\;
\ALT_INV_Add2~1_sumout\ <= NOT \Add2~1_sumout\;
\ALT_INV_Add4~93_sumout\ <= NOT \Add4~93_sumout\;
\ALT_INV_Add4~89_sumout\ <= NOT \Add4~89_sumout\;
\ALT_INV_Add4~85_sumout\ <= NOT \Add4~85_sumout\;
\ALT_INV_Add4~81_sumout\ <= NOT \Add4~81_sumout\;
\ALT_INV_Add4~77_sumout\ <= NOT \Add4~77_sumout\;
\ALT_INV_Add4~73_sumout\ <= NOT \Add4~73_sumout\;
\ALT_INV_Add4~69_sumout\ <= NOT \Add4~69_sumout\;
\ALT_INV_Add4~65_sumout\ <= NOT \Add4~65_sumout\;
\ALT_INV_Add4~61_sumout\ <= NOT \Add4~61_sumout\;
\ALT_INV_Add4~57_sumout\ <= NOT \Add4~57_sumout\;
\ALT_INV_Add4~53_sumout\ <= NOT \Add4~53_sumout\;
\ALT_INV_Add4~49_sumout\ <= NOT \Add4~49_sumout\;
\ALT_INV_Add4~45_sumout\ <= NOT \Add4~45_sumout\;
\ALT_INV_Add4~41_sumout\ <= NOT \Add4~41_sumout\;
\ALT_INV_Add4~37_sumout\ <= NOT \Add4~37_sumout\;
\ALT_INV_Add4~33_sumout\ <= NOT \Add4~33_sumout\;
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3) <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3);
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2) <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2);
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1) <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1);
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0) <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0);
\ALT_INV_Add4~29_sumout\ <= NOT \Add4~29_sumout\;
\ALT_INV_Add4~25_sumout\ <= NOT \Add4~25_sumout\;
\ALT_INV_Add4~21_sumout\ <= NOT \Add4~21_sumout\;
\ALT_INV_Add4~17_sumout\ <= NOT \Add4~17_sumout\;
\ALT_INV_Add4~13_sumout\ <= NOT \Add4~13_sumout\;
\ALT_INV_Add4~9_sumout\ <= NOT \Add4~9_sumout\;
\ALT_INV_Add4~5_sumout\ <= NOT \Add4~5_sumout\;
\ALT_INV_Add4~1_sumout\ <= NOT \Add4~1_sumout\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a1\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a2\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a3\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a4\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a5\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a6\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a7\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a8\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a9\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a10\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a11\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a12\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a13\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a14\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a15\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a16\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a17\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17\;
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\ <= NOT \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\;
\ALT_INV_Add5~73_sumout\ <= NOT \Add5~73_sumout\;
\ALT_INV_Add5~69_sumout\ <= NOT \Add5~69_sumout\;
\ALT_INV_Add5~65_sumout\ <= NOT \Add5~65_sumout\;
\ALT_INV_Add5~61_sumout\ <= NOT \Add5~61_sumout\;
\ALT_INV_Add5~57_sumout\ <= NOT \Add5~57_sumout\;
\ALT_INV_Add5~53_sumout\ <= NOT \Add5~53_sumout\;
\ALT_INV_Add5~49_sumout\ <= NOT \Add5~49_sumout\;
\ALT_INV_Add5~45_sumout\ <= NOT \Add5~45_sumout\;
\ALT_INV_Add5~41_sumout\ <= NOT \Add5~41_sumout\;
\ALT_INV_Add5~37_sumout\ <= NOT \Add5~37_sumout\;
\ALT_INV_Add5~33_sumout\ <= NOT \Add5~33_sumout\;
\ALT_INV_Add5~29_sumout\ <= NOT \Add5~29_sumout\;
\ALT_INV_Add5~25_sumout\ <= NOT \Add5~25_sumout\;
\ALT_INV_Add5~21_sumout\ <= NOT \Add5~21_sumout\;
\ALT_INV_Add5~17_sumout\ <= NOT \Add5~17_sumout\;

-- Location: IOOBUF_X52_Y0_N19
\y[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(0));

-- Location: IOOBUF_X70_Y0_N36
\y[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(1));

-- Location: IOOBUF_X60_Y0_N36
\y[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(2));

-- Location: IOOBUF_X68_Y0_N53
\y[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[3]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(3));

-- Location: IOOBUF_X58_Y0_N42
\y[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[4]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(4));

-- Location: IOOBUF_X62_Y0_N53
\y[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[5]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(5));

-- Location: IOOBUF_X62_Y0_N19
\y[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[6]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(6));

-- Location: IOOBUF_X66_Y0_N59
\y[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[7]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(7));

-- Location: IOOBUF_X66_Y0_N76
\y[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[8]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(8));

-- Location: IOOBUF_X54_Y0_N53
\y[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[9]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(9));

-- Location: IOOBUF_X60_Y0_N2
\y[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[10]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(10));

-- Location: IOOBUF_X56_Y0_N36
\y[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[11]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(11));

-- Location: IOOBUF_X56_Y0_N53
\y[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[12]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(12));

-- Location: IOOBUF_X66_Y0_N93
\y[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[13]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(13));

-- Location: IOOBUF_X56_Y0_N19
\y[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[14]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(14));

-- Location: IOOBUF_X58_Y0_N93
\y[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[15]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(15));

-- Location: IOOBUF_X52_Y0_N53
\y[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[16]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(16));

-- Location: IOOBUF_X56_Y0_N2
\y[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y[17]~reg0_q\,
	devoe => ww_devoe,
	o => ww_y(17));

-- Location: IOIBUF_X40_Y0_N1
\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G6
\clk~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clk~input_o\,
	outclk => \clk~inputCLKENA0_outclk\);

-- Location: LABCELL_X68_Y3_N30
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~sumout\ = SUM(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\ = CARRY(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit0~q\,
	cin => GND,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\);

-- Location: LABCELL_X68_Y3_N54
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~feeder_combout\ = ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita0~sumout\,
	combout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~feeder_combout\);

-- Location: IOIBUF_X68_Y0_N1
\rst_n~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst_n,
	o => \rst_n~input_o\);

-- Location: FF_X68_Y3_N56
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~feeder_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\);

-- Location: LABCELL_X68_Y3_N33
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\ = SUM(( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\ ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\ = CARRY(( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit1~q\,
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\);

-- Location: LABCELL_X68_Y3_N0
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0_combout\ = ( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita1~sumout\,
	combout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0_combout\);

-- Location: FF_X68_Y3_N2
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\);

-- Location: LABCELL_X68_Y3_N36
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\ = SUM(( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\ ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\ = CARRY(( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit2~q\,
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\);

-- Location: LABCELL_X68_Y3_N21
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0_combout\ = ( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111000000000000000011111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita2~sumout\,
	combout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0_combout\);

-- Location: FF_X68_Y3_N23
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\);

-- Location: LABCELL_X68_Y3_N39
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\ = SUM(( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\ ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\ = CARRY(( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit3~q\,
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\);

-- Location: LABCELL_X68_Y3_N15
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0_combout\ = ( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~sumout\,
	combout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0_combout\);

-- Location: FF_X68_Y3_N17
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\);

-- Location: LABCELL_X68_Y3_N42
\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\ = SUM(( GND ) + ( GND ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\);

-- Location: LABCELL_X68_Y3_N24
\mv.av[1].in_sr_rtl_0|auto_generated|dffe6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|dffe6~0_combout\ = ( !\mv.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~1_sumout\,
	combout => \mv.av[1].in_sr_rtl_0|auto_generated|dffe6~0_combout\);

-- Location: FF_X68_Y3_N25
\mv.av[1].in_sr_rtl_0|auto_generated|dffe6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|dffe6~0_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|dffe6~q\);

-- Location: LABCELL_X57_Y5_N0
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ = CARRY(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit0~q\,
	cin => GND,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\);

-- Location: FF_X57_Y5_N38
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	ena => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\);

-- Location: LABCELL_X57_Y5_N3
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ = CARRY(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit1~q\,
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\);

-- Location: FF_X57_Y5_N5
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\,
	clrn => \rst_n~input_o\,
	ena => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\);

-- Location: LABCELL_X57_Y5_N6
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\ = SUM(( !\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ = CARRY(( !\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit2~q\,
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\);

-- Location: LABCELL_X57_Y5_N54
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\ = ( !\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita2~sumout\,
	combout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\);

-- Location: FF_X57_Y5_N56
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\);

-- Location: LABCELL_X57_Y5_N9
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\ = SUM(( !\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\ = CARRY(( !\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit3~q\,
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\);

-- Location: LABCELL_X57_Y5_N21
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\ = ( !\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~sumout\,
	combout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\);

-- Location: FF_X57_Y5_N23
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\);

-- Location: LABCELL_X57_Y5_N12
\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\ = SUM(( GND ) + ( GND ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\);

-- Location: LABCELL_X57_Y5_N24
\mv.av[0].in_sr_rtl_0|auto_generated|dffe7~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|dffe7~0_combout\ = ( !\mv.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~1_sumout\,
	combout => \mv.av[0].in_sr_rtl_0|auto_generated|dffe7~0_combout\);

-- Location: FF_X57_Y5_N25
\mv.av[0].in_sr_rtl_0|auto_generated|dffe7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|dffe7~0_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|dffe7~q\);

-- Location: IOIBUF_X70_Y0_N1
\x[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(17),
	o => \x[17]~input_o\);

-- Location: FF_X64_Y4_N32
\mv.av[0].in_sr[0][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[17]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][0]~q\);

-- Location: MLABCELL_X59_Y5_N0
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ = CARRY(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\);

-- Location: MLABCELL_X59_Y5_N3
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ = CARRY(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\);

-- Location: FF_X59_Y5_N5
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	sclr => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1));

-- Location: MLABCELL_X59_Y5_N6
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ = CARRY(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\);

-- Location: FF_X59_Y5_N8
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	sclr => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2));

-- Location: FF_X59_Y5_N10
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\,
	sclr => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3));

-- Location: MLABCELL_X59_Y5_N9
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\ = CARRY(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\);

-- Location: FF_X59_Y5_N11
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\,
	sclr => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]~DUPLICATE_q\);

-- Location: FF_X59_Y5_N2
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	sclr => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\);

-- Location: MLABCELL_X59_Y5_N12
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ = SUM(( GND ) + ( GND ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\);

-- Location: MLABCELL_X59_Y5_N57
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\ = ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\ & ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ ) ) # ( 
-- !\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\ & ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ ) ) # ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\ & ( 
-- !\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ & ( (!\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & (\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
-- \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]~DUPLICATE_q\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000100000001011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	datab => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	datac => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[3]~DUPLICATE_q\,
	datae => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_comb_bita3~1_sumout\,
	combout => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\);

-- Location: FF_X59_Y5_N1
\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	sclr => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

-- Location: MLABCELL_X59_Y5_N30
\mv.av[0].in_sr_rtl_0|auto_generated|op_1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~1_sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\ ) + ( VCC ) + ( !VCC ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~2\ = CARRY(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\,
	cin => GND,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~2\);

-- Location: FF_X59_Y5_N31
\mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

-- Location: MLABCELL_X59_Y5_N48
\mv.av[0].in_sr_rtl_0|auto_generated|op_2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\ = ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]~DUPLICATE_q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[3]~DUPLICATE_q\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	combout => \mv.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\);

-- Location: MLABCELL_X59_Y5_N45
\mv.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\ = ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\ & ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]~DUPLICATE_q\ & ( 
-- (!\mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	datae => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[3]~DUPLICATE_q\,
	combout => \mv.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\);

-- Location: MLABCELL_X59_Y5_N33
\mv.av[0].in_sr_rtl_0|auto_generated|op_1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( (!\mv.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\ & !\mv.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~2\ ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~6\ = CARRY(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( (!\mv.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\ & !\mv.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010111110101111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\,
	datac => \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\,
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~2\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~6\);

-- Location: MLABCELL_X59_Y5_N51
\mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ = ( !\mv.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\,
	combout => \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\);

-- Location: FF_X59_Y5_N53
\mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\(1));

-- Location: MLABCELL_X59_Y5_N18
\mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ = ( !\mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\(1) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1),
	combout => \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\);

-- Location: MLABCELL_X59_Y5_N36
\mv.av[0].in_sr_rtl_0|auto_generated|op_1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~9_sumout\ = SUM(( (\mv.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) # (\mv.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\) ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~6\ ))
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~10\ = CARRY(( (\mv.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) # (\mv.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\) ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000000000000000000000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	datac => \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\,
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\,
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~6\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	cout => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~10\);

-- Location: FF_X59_Y5_N37
\mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2));

-- Location: MLABCELL_X59_Y5_N39
\mv.av[0].in_sr_rtl_0|auto_generated|op_1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[0].in_sr_rtl_0|auto_generated|op_1~13_sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]~DUPLICATE_q\ ) + ( GND ) + ( \mv.av[0].in_sr_rtl_0|auto_generated|op_1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \mv.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit[3]~DUPLICATE_q\,
	cin => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~10\,
	sumout => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~13_sumout\);

-- Location: FF_X59_Y5_N40
\mv.av[0].in_sr_rtl_0|auto_generated|dffe3a[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[0].in_sr_rtl_0|auto_generated|op_1~13_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3));

-- Location: IOIBUF_X68_Y0_N18
\x[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(16),
	o => \x[16]~input_o\);

-- Location: FF_X64_Y4_N47
\mv.av[0].in_sr[0][-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[16]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-1]~q\);

-- Location: IOIBUF_X89_Y4_N61
\x[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(15),
	o => \x[15]~input_o\);

-- Location: FF_X64_Y4_N29
\mv.av[0].in_sr[0][-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[15]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-2]~q\);

-- Location: IOIBUF_X64_Y0_N18
\x[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(14),
	o => \x[14]~input_o\);

-- Location: FF_X64_Y4_N41
\mv.av[0].in_sr[0][-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[14]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-3]~q\);

-- Location: IOIBUF_X64_Y0_N1
\x[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(13),
	o => \x[13]~input_o\);

-- Location: FF_X64_Y4_N35
\mv.av[0].in_sr[0][-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[13]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-4]~q\);

-- Location: IOIBUF_X60_Y0_N18
\x[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(12),
	o => \x[12]~input_o\);

-- Location: FF_X59_Y5_N22
\mv.av[0].in_sr[0][-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[12]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-5]~q\);

-- Location: IOIBUF_X68_Y0_N35
\x[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(11),
	o => \x[11]~input_o\);

-- Location: FF_X64_Y4_N14
\mv.av[0].in_sr[0][-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[11]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-6]~q\);

-- Location: IOIBUF_X64_Y0_N52
\x[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(10),
	o => \x[10]~input_o\);

-- Location: FF_X64_Y4_N50
\mv.av[0].in_sr[0][-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[10]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-7]~q\);

-- Location: IOIBUF_X58_Y0_N58
\x[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(9),
	o => \x[9]~input_o\);

-- Location: FF_X64_Y4_N38
\mv.av[0].in_sr[0][-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[9]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-8]~q\);

-- Location: IOIBUF_X62_Y0_N35
\x[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(8),
	o => \x[8]~input_o\);

-- Location: FF_X64_Y5_N28
\mv.av[0].in_sr[0][-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[8]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-9]~q\);

-- Location: IOIBUF_X60_Y0_N52
\x[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(7),
	o => \x[7]~input_o\);

-- Location: FF_X59_Y5_N43
\mv.av[0].in_sr[0][-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[7]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-10]~q\);

-- Location: IOIBUF_X64_Y0_N35
\x[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(6),
	o => \x[6]~input_o\);

-- Location: FF_X64_Y5_N32
\mv.av[0].in_sr[0][-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[6]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-11]~q\);

-- Location: IOIBUF_X58_Y0_N75
\x[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(5),
	o => \x[5]~input_o\);

-- Location: FF_X57_Y5_N53
\mv.av[0].in_sr[0][-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[5]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-12]~q\);

-- Location: IOIBUF_X66_Y0_N41
\x[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(4),
	o => \x[4]~input_o\);

-- Location: FF_X64_Y5_N23
\mv.av[0].in_sr[0][-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[4]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-13]~q\);

-- Location: IOIBUF_X62_Y0_N1
\x[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(3),
	o => \x[3]~input_o\);

-- Location: FF_X59_Y5_N16
\mv.av[0].in_sr[0][-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[3]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-14]~q\);

-- Location: IOIBUF_X70_Y0_N18
\x[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(2),
	o => \x[2]~input_o\);

-- Location: FF_X64_Y5_N10
\mv.av[0].in_sr[0][-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[2]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-15]~q\);

-- Location: IOIBUF_X72_Y0_N1
\x[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(1),
	o => \x[1]~input_o\);

-- Location: FF_X64_Y5_N20
\mv.av[0].in_sr[0][-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[1]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-16]~q\);

-- Location: IOIBUF_X70_Y0_N52
\x[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(0),
	o => \x[0]~input_o\);

-- Location: FF_X64_Y5_N2
\mv.av[0].in_sr[0][-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \x[0]~input_o\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[0][-17]~q\);

-- Location: M10K_X58_Y5_N0
\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.av[0].in_sr_rtl_0|shift_taps_jev:auto_generated|altsyncram_tic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 40,
	port_a_first_address => 0,
	port_a_first_bit_number => 0,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 40,
	port_b_first_address => 0,
	port_b_first_bit_number => 0,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~inputCLKENA0_outclk\,
	clk1 => \clk~inputCLKENA0_outclk\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTADATAIN_bus\,
	portaaddr => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTAADDR_bus\,
	portbaddr => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\);

-- Location: FF_X64_Y4_N26
\mv.av[0].in_sr[15][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][0]~q\);

-- Location: FF_X64_Y4_N19
\mv.av[0].in_sr[15][-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-1]~q\);

-- Location: FF_X59_Y5_N29
\mv.av[0].in_sr[15][-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-2]~q\);

-- Location: FF_X64_Y4_N17
\mv.av[0].in_sr[15][-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-3]~q\);

-- Location: FF_X64_Y4_N23
\mv.av[0].in_sr[15][-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-4]~q\);

-- Location: FF_X64_Y4_N11
\mv.av[0].in_sr[15][-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-5]~q\);

-- Location: FF_X64_Y4_N7
\mv.av[0].in_sr[15][-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-6]~q\);

-- Location: FF_X64_Y4_N4
\mv.av[0].in_sr[15][-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-7]~q\);

-- Location: FF_X64_Y4_N2
\mv.av[0].in_sr[15][-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-8]~q\);

-- Location: FF_X64_Y5_N59
\mv.av[0].in_sr[15][-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-9]~q\);

-- Location: FF_X64_Y5_N56
\mv.av[0].in_sr[15][-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-10]~q\);

-- Location: FF_X64_Y5_N53
\mv.av[0].in_sr[15][-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-11]~q\);

-- Location: FF_X64_Y5_N49
\mv.av[0].in_sr[15][-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-12]~q\);

-- Location: FF_X64_Y5_N47
\mv.av[0].in_sr[15][-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-13]~q\);

-- Location: FF_X64_Y5_N44
\mv.av[0].in_sr[15][-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-14]~q\);

-- Location: FF_X64_Y5_N40
\mv.av[0].in_sr[15][-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-15]~q\);

-- Location: FF_X64_Y5_N37
\mv.av[0].in_sr[15][-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-16]~q\);

-- Location: FF_X64_Y5_N34
\mv.av[0].in_sr[15][-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].in_sr[15][-17]~q\);

-- Location: LABCELL_X64_Y5_N30
\Add1~98\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~98_cout\ = CARRY(( GND ) + ( !VCC ) + ( !VCC ))
-- \Add1~99\ = SHARE(VCC)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	cin => GND,
	sharein => GND,
	cout => \Add1~98_cout\,
	shareout => \Add1~99\);

-- Location: LABCELL_X64_Y5_N33
\Add1~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~21_sumout\ = SUM(( !\x[0]~input_o\ $ (!\mv.av[0].sum[-17]~q\ $ (!\mv.av[0].in_sr[15][-17]~q\)) ) + ( \Add1~99\ ) + ( \Add1~98_cout\ ))
-- \Add1~22\ = CARRY(( !\x[0]~input_o\ $ (!\mv.av[0].sum[-17]~q\ $ (!\mv.av[0].in_sr[15][-17]~q\)) ) + ( \Add1~99\ ) + ( \Add1~98_cout\ ))
-- \Add1~23\ = SHARE((!\x[0]~input_o\ & (\mv.av[0].sum[-17]~q\ & !\mv.av[0].in_sr[15][-17]~q\)) # (\x[0]~input_o\ & ((!\mv.av[0].in_sr[15][-17]~q\) # (\mv.av[0].sum[-17]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000011100010111000100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_x[0]~input_o\,
	datab => \ALT_INV_mv.av[0].sum[-17]~q\,
	datac => \ALT_INV_mv.av[0].in_sr[15][-17]~q\,
	cin => \Add1~98_cout\,
	sharein => \Add1~99\,
	sumout => \Add1~21_sumout\,
	cout => \Add1~22\,
	shareout => \Add1~23\);

-- Location: LABCELL_X64_Y5_N15
\Result~101\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~101_combout\ = ( \Add1~21_sumout\ & ( (!\Add1~1_sumout\) # ((\Add1~9_sumout\ & \Add1~5_sumout\)) ) ) # ( !\Add1~21_sumout\ & ( (!\Add1~1_sumout\ & ((\Add1~5_sumout\) # (\Add1~9_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001010101010001000101010101010101010101110111010101010111011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~5_sumout\,
	dataf => \ALT_INV_Add1~21_sumout\,
	combout => \Result~101_combout\);

-- Location: FF_X64_Y5_N17
\mv.av[0].sum[-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~101_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-17]~q\);

-- Location: LABCELL_X64_Y5_N36
\Add1~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~25_sumout\ = SUM(( !\mv.av[0].sum[-16]~q\ $ (!\x[1]~input_o\ $ (!\mv.av[0].in_sr[15][-16]~q\)) ) + ( \Add1~23\ ) + ( \Add1~22\ ))
-- \Add1~26\ = CARRY(( !\mv.av[0].sum[-16]~q\ $ (!\x[1]~input_o\ $ (!\mv.av[0].in_sr[15][-16]~q\)) ) + ( \Add1~23\ ) + ( \Add1~22\ ))
-- \Add1~27\ = SHARE((!\mv.av[0].sum[-16]~q\ & (\x[1]~input_o\ & !\mv.av[0].in_sr[15][-16]~q\)) # (\mv.av[0].sum[-16]~q\ & ((!\mv.av[0].in_sr[15][-16]~q\) # (\x[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[0].sum[-16]~q\,
	datac => \ALT_INV_x[1]~input_o\,
	datad => \ALT_INV_mv.av[0].in_sr[15][-16]~q\,
	cin => \Add1~22\,
	sharein => \Add1~23\,
	sumout => \Add1~25_sumout\,
	cout => \Add1~26\,
	shareout => \Add1~27\);

-- Location: LABCELL_X64_Y5_N6
\Result~102\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~102_combout\ = ( \Add1~25_sumout\ & ( (!\Add1~1_sumout\) # ((\Add1~5_sumout\ & \Add1~9_sumout\)) ) ) # ( !\Add1~25_sumout\ & ( (!\Add1~1_sumout\ & ((\Add1~9_sumout\) # (\Add1~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111000001110000111100011111000101110000011100001111000111110001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~5_sumout\,
	datab => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~1_sumout\,
	datae => \ALT_INV_Add1~25_sumout\,
	combout => \Result~102_combout\);

-- Location: FF_X64_Y5_N8
\mv.av[0].sum[-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~102_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-16]~q\);

-- Location: LABCELL_X64_Y5_N39
\Add1~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~29_sumout\ = SUM(( !\mv.av[0].sum[-15]~q\ $ (!\mv.av[0].in_sr[15][-15]~q\ $ (!\x[2]~input_o\)) ) + ( \Add1~27\ ) + ( \Add1~26\ ))
-- \Add1~30\ = CARRY(( !\mv.av[0].sum[-15]~q\ $ (!\mv.av[0].in_sr[15][-15]~q\ $ (!\x[2]~input_o\)) ) + ( \Add1~27\ ) + ( \Add1~26\ ))
-- \Add1~31\ = SHARE((!\mv.av[0].sum[-15]~q\ & (!\mv.av[0].in_sr[15][-15]~q\ & \x[2]~input_o\)) # (\mv.av[0].sum[-15]~q\ & ((!\mv.av[0].in_sr[15][-15]~q\) # (\x[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010100001111010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum[-15]~q\,
	datac => \ALT_INV_mv.av[0].in_sr[15][-15]~q\,
	datad => \ALT_INV_x[2]~input_o\,
	cin => \Add1~26\,
	sharein => \Add1~27\,
	sumout => \Add1~29_sumout\,
	cout => \Add1~30\,
	shareout => \Add1~31\);

-- Location: LABCELL_X64_Y5_N24
\Result~103\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~103_combout\ = ( \Add1~9_sumout\ & ( (!\Add1~1_sumout\) # ((\Add1~29_sumout\ & \Add1~5_sumout\)) ) ) # ( !\Add1~9_sumout\ & ( (!\Add1~1_sumout\ & ((\Add1~5_sumout\) # (\Add1~29_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000011110000001100001111000011110000111100111111000011110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add1~29_sumout\,
	datac => \ALT_INV_Add1~1_sumout\,
	datad => \ALT_INV_Add1~5_sumout\,
	dataf => \ALT_INV_Add1~9_sumout\,
	combout => \Result~103_combout\);

-- Location: FF_X64_Y5_N26
\mv.av[0].sum[-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~103_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-15]~q\);

-- Location: LABCELL_X64_Y5_N42
\Add1~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~17_sumout\ = SUM(( !\x[3]~input_o\ $ (!\mv.av[0].sum[-14]~q\ $ (!\mv.av[0].in_sr[15][-14]~q\)) ) + ( \Add1~31\ ) + ( \Add1~30\ ))
-- \Add1~18\ = CARRY(( !\x[3]~input_o\ $ (!\mv.av[0].sum[-14]~q\ $ (!\mv.av[0].in_sr[15][-14]~q\)) ) + ( \Add1~31\ ) + ( \Add1~30\ ))
-- \Add1~19\ = SHARE((!\x[3]~input_o\ & (\mv.av[0].sum[-14]~q\ & !\mv.av[0].in_sr[15][-14]~q\)) # (\x[3]~input_o\ & ((!\mv.av[0].in_sr[15][-14]~q\) # (\mv.av[0].sum[-14]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010111110000010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_x[3]~input_o\,
	datac => \ALT_INV_mv.av[0].sum[-14]~q\,
	datad => \ALT_INV_mv.av[0].in_sr[15][-14]~q\,
	cin => \Add1~30\,
	sharein => \Add1~31\,
	sumout => \Add1~17_sumout\,
	cout => \Add1~18\,
	shareout => \Add1~19\);

-- Location: LABCELL_X64_Y5_N3
\Result~100\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~100_combout\ = (!\Add1~1_sumout\ & (((\Add1~5_sumout\) # (\Add1~17_sumout\)) # (\Add1~9_sumout\))) # (\Add1~1_sumout\ & (\Add1~9_sumout\ & (\Add1~17_sumout\ & \Add1~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~17_sumout\,
	datad => \ALT_INV_Add1~5_sumout\,
	combout => \Result~100_combout\);

-- Location: FF_X64_Y5_N5
\mv.av[0].sum[-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~100_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-14]~q\);

-- Location: LABCELL_X64_Y5_N45
\Add1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~13_sumout\ = SUM(( !\x[4]~input_o\ $ (!\mv.av[0].sum[-13]~q\ $ (!\mv.av[0].in_sr[15][-13]~q\)) ) + ( \Add1~19\ ) + ( \Add1~18\ ))
-- \Add1~14\ = CARRY(( !\x[4]~input_o\ $ (!\mv.av[0].sum[-13]~q\ $ (!\mv.av[0].in_sr[15][-13]~q\)) ) + ( \Add1~19\ ) + ( \Add1~18\ ))
-- \Add1~15\ = SHARE((!\x[4]~input_o\ & (\mv.av[0].sum[-13]~q\ & !\mv.av[0].in_sr[15][-13]~q\)) # (\x[4]~input_o\ & ((!\mv.av[0].in_sr[15][-13]~q\) # (\mv.av[0].sum[-13]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_x[4]~input_o\,
	datac => \ALT_INV_mv.av[0].sum[-13]~q\,
	datad => \ALT_INV_mv.av[0].in_sr[15][-13]~q\,
	cin => \Add1~18\,
	sharein => \Add1~19\,
	sumout => \Add1~13_sumout\,
	cout => \Add1~14\,
	shareout => \Add1~15\);

-- Location: LABCELL_X64_Y5_N12
\Result~99\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~99_combout\ = (!\Add1~1_sumout\ & (((\Add1~13_sumout\) # (\Add1~5_sumout\)) # (\Add1~9_sumout\))) # (\Add1~1_sumout\ & (\Add1~9_sumout\ & (\Add1~5_sumout\ & \Add1~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~5_sumout\,
	datad => \ALT_INV_Add1~13_sumout\,
	combout => \Result~99_combout\);

-- Location: FF_X64_Y5_N14
\mv.av[0].sum[-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~99_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-13]~q\);

-- Location: LABCELL_X64_Y5_N48
\Add1~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~37_sumout\ = SUM(( !\x[5]~input_o\ $ (!\mv.av[0].sum[-12]~q\ $ (!\mv.av[0].in_sr[15][-12]~q\)) ) + ( \Add1~15\ ) + ( \Add1~14\ ))
-- \Add1~38\ = CARRY(( !\x[5]~input_o\ $ (!\mv.av[0].sum[-12]~q\ $ (!\mv.av[0].in_sr[15][-12]~q\)) ) + ( \Add1~15\ ) + ( \Add1~14\ ))
-- \Add1~39\ = SHARE((!\x[5]~input_o\ & (\mv.av[0].sum[-12]~q\ & !\mv.av[0].in_sr[15][-12]~q\)) # (\x[5]~input_o\ & ((!\mv.av[0].in_sr[15][-12]~q\) # (\mv.av[0].sum[-12]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010111110000010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_x[5]~input_o\,
	datac => \ALT_INV_mv.av[0].sum[-12]~q\,
	datad => \ALT_INV_mv.av[0].in_sr[15][-12]~q\,
	cin => \Add1~14\,
	sharein => \Add1~15\,
	sumout => \Add1~37_sumout\,
	cout => \Add1~38\,
	shareout => \Add1~39\);

-- Location: LABCELL_X63_Y4_N51
\Result~105\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~105_combout\ = ( \Add1~1_sumout\ & ( \Add1~5_sumout\ & ( (\Add1~9_sumout\ & \Add1~37_sumout\) ) ) ) # ( !\Add1~1_sumout\ & ( \Add1~5_sumout\ ) ) # ( !\Add1~1_sumout\ & ( !\Add1~5_sumout\ & ( (\Add1~37_sumout\) # (\Add1~9_sumout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111000000000000000011111111111111110000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~37_sumout\,
	datae => \ALT_INV_Add1~1_sumout\,
	dataf => \ALT_INV_Add1~5_sumout\,
	combout => \Result~105_combout\);

-- Location: FF_X65_Y4_N17
\mv.av[0].sum[-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~105_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-12]~q\);

-- Location: LABCELL_X64_Y5_N51
\Add1~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~45_sumout\ = SUM(( !\mv.av[0].sum[-11]~q\ $ (!\x[6]~input_o\ $ (!\mv.av[0].in_sr[15][-11]~q\)) ) + ( \Add1~39\ ) + ( \Add1~38\ ))
-- \Add1~46\ = CARRY(( !\mv.av[0].sum[-11]~q\ $ (!\x[6]~input_o\ $ (!\mv.av[0].in_sr[15][-11]~q\)) ) + ( \Add1~39\ ) + ( \Add1~38\ ))
-- \Add1~47\ = SHARE((!\mv.av[0].sum[-11]~q\ & (\x[6]~input_o\ & !\mv.av[0].in_sr[15][-11]~q\)) # (\mv.av[0].sum[-11]~q\ & ((!\mv.av[0].in_sr[15][-11]~q\) # (\x[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[0].sum[-11]~q\,
	datac => \ALT_INV_x[6]~input_o\,
	datad => \ALT_INV_mv.av[0].in_sr[15][-11]~q\,
	cin => \Add1~38\,
	sharein => \Add1~39\,
	sumout => \Add1~45_sumout\,
	cout => \Add1~46\,
	shareout => \Add1~47\);

-- Location: LABCELL_X64_Y5_N0
\Result~107\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~107_combout\ = ( \Add1~45_sumout\ & ( (!\Add1~1_sumout\) # ((\Add1~9_sumout\ & \Add1~5_sumout\)) ) ) # ( !\Add1~45_sumout\ & ( (!\Add1~1_sumout\ & ((\Add1~5_sumout\) # (\Add1~9_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100000000001111110000000011111111000000111111111100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~5_sumout\,
	datad => \ALT_INV_Add1~1_sumout\,
	dataf => \ALT_INV_Add1~45_sumout\,
	combout => \Result~107_combout\);

-- Location: FF_X65_Y4_N2
\mv.av[0].sum[-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~107_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-11]~q\);

-- Location: LABCELL_X64_Y5_N54
\Add1~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~33_sumout\ = SUM(( !\x[7]~input_o\ $ (!\mv.av[0].sum[-10]~q\ $ (!\mv.av[0].in_sr[15][-10]~q\)) ) + ( \Add1~47\ ) + ( \Add1~46\ ))
-- \Add1~34\ = CARRY(( !\x[7]~input_o\ $ (!\mv.av[0].sum[-10]~q\ $ (!\mv.av[0].in_sr[15][-10]~q\)) ) + ( \Add1~47\ ) + ( \Add1~46\ ))
-- \Add1~35\ = SHARE((!\x[7]~input_o\ & (\mv.av[0].sum[-10]~q\ & !\mv.av[0].in_sr[15][-10]~q\)) # (\x[7]~input_o\ & ((!\mv.av[0].in_sr[15][-10]~q\) # (\mv.av[0].sum[-10]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010111110000010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_x[7]~input_o\,
	datac => \ALT_INV_mv.av[0].sum[-10]~q\,
	datad => \ALT_INV_mv.av[0].in_sr[15][-10]~q\,
	cin => \Add1~46\,
	sharein => \Add1~47\,
	sumout => \Add1~33_sumout\,
	cout => \Add1~34\,
	shareout => \Add1~35\);

-- Location: LABCELL_X66_Y4_N39
\Result~104\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~104_combout\ = ( \Add1~1_sumout\ & ( (\Add1~33_sumout\ & (\Add1~9_sumout\ & \Add1~5_sumout\)) ) ) # ( !\Add1~1_sumout\ & ( ((\Add1~5_sumout\) # (\Add1~9_sumout\)) # (\Add1~33_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111111111111010111111111111100000000000001010000000000000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~33_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~5_sumout\,
	dataf => \ALT_INV_Add1~1_sumout\,
	combout => \Result~104_combout\);

-- Location: FF_X65_Y4_N41
\mv.av[0].sum[-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~104_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-10]~q\);

-- Location: LABCELL_X64_Y5_N57
\Add1~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~41_sumout\ = SUM(( !\mv.av[0].sum[-9]~q\ $ (!\mv.av[0].in_sr[15][-9]~q\ $ (!\x[8]~input_o\)) ) + ( \Add1~35\ ) + ( \Add1~34\ ))
-- \Add1~42\ = CARRY(( !\mv.av[0].sum[-9]~q\ $ (!\mv.av[0].in_sr[15][-9]~q\ $ (!\x[8]~input_o\)) ) + ( \Add1~35\ ) + ( \Add1~34\ ))
-- \Add1~43\ = SHARE((!\mv.av[0].sum[-9]~q\ & (!\mv.av[0].in_sr[15][-9]~q\ & \x[8]~input_o\)) # (\mv.av[0].sum[-9]~q\ & ((!\mv.av[0].in_sr[15][-9]~q\) # (\x[8]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[0].sum[-9]~q\,
	datac => \ALT_INV_mv.av[0].in_sr[15][-9]~q\,
	datad => \ALT_INV_x[8]~input_o\,
	cin => \Add1~34\,
	sharein => \Add1~35\,
	sumout => \Add1~41_sumout\,
	cout => \Add1~42\,
	shareout => \Add1~43\);

-- Location: LABCELL_X66_Y4_N21
\Result~106\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~106_combout\ = ( \Add1~41_sumout\ & ( (!\Add1~1_sumout\) # ((\Add1~9_sumout\ & \Add1~5_sumout\)) ) ) # ( !\Add1~41_sumout\ & ( (!\Add1~1_sumout\ & ((\Add1~5_sumout\) # (\Add1~9_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000101010101010000010101010101010101010101011111010101010101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~5_sumout\,
	dataf => \ALT_INV_Add1~41_sumout\,
	combout => \Result~106_combout\);

-- Location: FF_X65_Y4_N20
\mv.av[0].sum[-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~106_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-9]~q\);

-- Location: LABCELL_X64_Y4_N0
\Add1~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~49_sumout\ = SUM(( !\x[9]~input_o\ $ (!\mv.av[0].sum[-8]~q\ $ (!\mv.av[0].in_sr[15][-8]~q\)) ) + ( \Add1~43\ ) + ( \Add1~42\ ))
-- \Add1~50\ = CARRY(( !\x[9]~input_o\ $ (!\mv.av[0].sum[-8]~q\ $ (!\mv.av[0].in_sr[15][-8]~q\)) ) + ( \Add1~43\ ) + ( \Add1~42\ ))
-- \Add1~51\ = SHARE((!\x[9]~input_o\ & (\mv.av[0].sum[-8]~q\ & !\mv.av[0].in_sr[15][-8]~q\)) # (\x[9]~input_o\ & ((!\mv.av[0].in_sr[15][-8]~q\) # (\mv.av[0].sum[-8]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_x[9]~input_o\,
	datac => \ALT_INV_mv.av[0].sum[-8]~q\,
	datad => \ALT_INV_mv.av[0].in_sr[15][-8]~q\,
	cin => \Add1~42\,
	sharein => \Add1~43\,
	sumout => \Add1~49_sumout\,
	cout => \Add1~50\,
	shareout => \Add1~51\);

-- Location: LABCELL_X63_Y4_N57
\Result~108\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~108_combout\ = ( \Add1~1_sumout\ & ( \Add1~5_sumout\ & ( (\Add1~49_sumout\ & \Add1~9_sumout\) ) ) ) # ( !\Add1~1_sumout\ & ( \Add1~5_sumout\ ) ) # ( !\Add1~1_sumout\ & ( !\Add1~5_sumout\ & ( (\Add1~9_sumout\) # (\Add1~49_sumout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010111111111000000000000000011111111111111110000000001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~49_sumout\,
	datad => \ALT_INV_Add1~9_sumout\,
	datae => \ALT_INV_Add1~1_sumout\,
	dataf => \ALT_INV_Add1~5_sumout\,
	combout => \Result~108_combout\);

-- Location: FF_X65_Y4_N50
\mv.av[0].sum[-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~108_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-8]~q\);

-- Location: LABCELL_X64_Y4_N3
\Add1~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~53_sumout\ = SUM(( !\x[10]~input_o\ $ (!\mv.av[0].in_sr[15][-7]~q\ $ (!\mv.av[0].sum[-7]~q\)) ) + ( \Add1~51\ ) + ( \Add1~50\ ))
-- \Add1~54\ = CARRY(( !\x[10]~input_o\ $ (!\mv.av[0].in_sr[15][-7]~q\ $ (!\mv.av[0].sum[-7]~q\)) ) + ( \Add1~51\ ) + ( \Add1~50\ ))
-- \Add1~55\ = SHARE((!\x[10]~input_o\ & (!\mv.av[0].in_sr[15][-7]~q\ & \mv.av[0].sum[-7]~q\)) # (\x[10]~input_o\ & ((!\mv.av[0].in_sr[15][-7]~q\) # (\mv.av[0].sum[-7]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010100001111010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_x[10]~input_o\,
	datac => \ALT_INV_mv.av[0].in_sr[15][-7]~q\,
	datad => \ALT_INV_mv.av[0].sum[-7]~q\,
	cin => \Add1~50\,
	sharein => \Add1~51\,
	sumout => \Add1~53_sumout\,
	cout => \Add1~54\,
	shareout => \Add1~55\);

-- Location: LABCELL_X64_Y4_N48
\Result~109\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~109_combout\ = ( \Add1~1_sumout\ & ( (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~53_sumout\)) ) ) # ( !\Add1~1_sumout\ & ( ((\Add1~53_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111111101111111011111110111111100000001000000010000000100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~5_sumout\,
	datab => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~53_sumout\,
	dataf => \ALT_INV_Add1~1_sumout\,
	combout => \Result~109_combout\);

-- Location: FF_X65_Y4_N38
\mv.av[0].sum[-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~109_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-7]~q\);

-- Location: LABCELL_X64_Y4_N6
\Add1~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~57_sumout\ = SUM(( !\x[11]~input_o\ $ (!\mv.av[0].in_sr[15][-6]~q\ $ (!\mv.av[0].sum[-6]~q\)) ) + ( \Add1~55\ ) + ( \Add1~54\ ))
-- \Add1~58\ = CARRY(( !\x[11]~input_o\ $ (!\mv.av[0].in_sr[15][-6]~q\ $ (!\mv.av[0].sum[-6]~q\)) ) + ( \Add1~55\ ) + ( \Add1~54\ ))
-- \Add1~59\ = SHARE((!\x[11]~input_o\ & (!\mv.av[0].in_sr[15][-6]~q\ & \mv.av[0].sum[-6]~q\)) # (\x[11]~input_o\ & ((!\mv.av[0].in_sr[15][-6]~q\) # (\mv.av[0].sum[-6]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_x[11]~input_o\,
	datac => \ALT_INV_mv.av[0].in_sr[15][-6]~q\,
	datad => \ALT_INV_mv.av[0].sum[-6]~q\,
	cin => \Add1~54\,
	sharein => \Add1~55\,
	sumout => \Add1~57_sumout\,
	cout => \Add1~58\,
	shareout => \Add1~59\);

-- Location: LABCELL_X63_Y4_N12
\Result~110\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~110_combout\ = ( \Add1~1_sumout\ & ( \Add1~5_sumout\ & ( (\Add1~9_sumout\ & \Add1~57_sumout\) ) ) ) # ( !\Add1~1_sumout\ & ( \Add1~5_sumout\ ) ) # ( !\Add1~1_sumout\ & ( !\Add1~5_sumout\ & ( (\Add1~57_sumout\) # (\Add1~9_sumout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111000000000000000011111111111111110000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~57_sumout\,
	datae => \ALT_INV_Add1~1_sumout\,
	dataf => \ALT_INV_Add1~5_sumout\,
	combout => \Result~110_combout\);

-- Location: FF_X65_Y4_N44
\mv.av[0].sum[-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~110_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-6]~q\);

-- Location: LABCELL_X64_Y4_N9
\Add1~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~61_sumout\ = SUM(( !\x[12]~input_o\ $ (!\mv.av[0].in_sr[15][-5]~q\ $ (!\mv.av[0].sum[-5]~q\)) ) + ( \Add1~59\ ) + ( \Add1~58\ ))
-- \Add1~62\ = CARRY(( !\x[12]~input_o\ $ (!\mv.av[0].in_sr[15][-5]~q\ $ (!\mv.av[0].sum[-5]~q\)) ) + ( \Add1~59\ ) + ( \Add1~58\ ))
-- \Add1~63\ = SHARE((!\x[12]~input_o\ & (!\mv.av[0].in_sr[15][-5]~q\ & \mv.av[0].sum[-5]~q\)) # (\x[12]~input_o\ & ((!\mv.av[0].in_sr[15][-5]~q\) # (\mv.av[0].sum[-5]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010100001111010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_x[12]~input_o\,
	datac => \ALT_INV_mv.av[0].in_sr[15][-5]~q\,
	datad => \ALT_INV_mv.av[0].sum[-5]~q\,
	cin => \Add1~58\,
	sharein => \Add1~59\,
	sumout => \Add1~61_sumout\,
	cout => \Add1~62\,
	shareout => \Add1~63\);

-- Location: LABCELL_X63_Y4_N42
\Result~111\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~111_combout\ = ( \Add1~1_sumout\ & ( \Add1~5_sumout\ & ( (\Add1~9_sumout\ & \Add1~61_sumout\) ) ) ) # ( !\Add1~1_sumout\ & ( \Add1~5_sumout\ ) ) # ( !\Add1~1_sumout\ & ( !\Add1~5_sumout\ & ( (\Add1~61_sumout\) # (\Add1~9_sumout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111000000000000000011111111111111110000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~61_sumout\,
	datae => \ALT_INV_Add1~1_sumout\,
	dataf => \ALT_INV_Add1~5_sumout\,
	combout => \Result~111_combout\);

-- Location: FF_X65_Y4_N5
\mv.av[0].sum[-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~111_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-5]~q\);

-- Location: LABCELL_X64_Y4_N12
\Add1~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~65_sumout\ = SUM(( !\mv.av[0].in_sr[15][-4]~q\ $ (!\x[13]~input_o\ $ (!\mv.av[0].sum[-4]~q\)) ) + ( \Add1~63\ ) + ( \Add1~62\ ))
-- \Add1~66\ = CARRY(( !\mv.av[0].in_sr[15][-4]~q\ $ (!\x[13]~input_o\ $ (!\mv.av[0].sum[-4]~q\)) ) + ( \Add1~63\ ) + ( \Add1~62\ ))
-- \Add1~67\ = SHARE((!\mv.av[0].in_sr[15][-4]~q\ & ((\mv.av[0].sum[-4]~q\) # (\x[13]~input_o\))) # (\mv.av[0].in_sr[15][-4]~q\ & (\x[13]~input_o\ & \mv.av[0].sum[-4]~q\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000010101010111100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].in_sr[15][-4]~q\,
	datac => \ALT_INV_x[13]~input_o\,
	datad => \ALT_INV_mv.av[0].sum[-4]~q\,
	cin => \Add1~62\,
	sharein => \Add1~63\,
	sumout => \Add1~65_sumout\,
	cout => \Add1~66\,
	shareout => \Add1~67\);

-- Location: LABCELL_X63_Y4_N24
\Result~112\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~112_combout\ = ( \Add1~1_sumout\ & ( \Add1~5_sumout\ & ( (\Add1~65_sumout\ & \Add1~9_sumout\) ) ) ) # ( !\Add1~1_sumout\ & ( \Add1~5_sumout\ ) ) # ( !\Add1~1_sumout\ & ( !\Add1~5_sumout\ & ( (\Add1~9_sumout\) # (\Add1~65_sumout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100111111000000000000000011111111111111110000001100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add1~65_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datae => \ALT_INV_Add1~1_sumout\,
	dataf => \ALT_INV_Add1~5_sumout\,
	combout => \Result~112_combout\);

-- Location: FF_X65_Y4_N11
\mv.av[0].sum[-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~112_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-4]~q\);

-- Location: LABCELL_X64_Y4_N15
\Add1~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~69_sumout\ = SUM(( !\mv.av[0].sum[-3]~q\ $ (!\mv.av[0].in_sr[15][-3]~q\ $ (!\x[14]~input_o\)) ) + ( \Add1~67\ ) + ( \Add1~66\ ))
-- \Add1~70\ = CARRY(( !\mv.av[0].sum[-3]~q\ $ (!\mv.av[0].in_sr[15][-3]~q\ $ (!\x[14]~input_o\)) ) + ( \Add1~67\ ) + ( \Add1~66\ ))
-- \Add1~71\ = SHARE((!\mv.av[0].sum[-3]~q\ & (!\mv.av[0].in_sr[15][-3]~q\ & \x[14]~input_o\)) # (\mv.av[0].sum[-3]~q\ & ((!\mv.av[0].in_sr[15][-3]~q\) # (\x[14]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[0].sum[-3]~q\,
	datac => \ALT_INV_mv.av[0].in_sr[15][-3]~q\,
	datad => \ALT_INV_x[14]~input_o\,
	cin => \Add1~66\,
	sharein => \Add1~67\,
	sumout => \Add1~69_sumout\,
	cout => \Add1~70\,
	shareout => \Add1~71\);

-- Location: LABCELL_X63_Y4_N30
\Result~113\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~113_combout\ = ( \Add1~1_sumout\ & ( \Add1~5_sumout\ & ( (\Add1~9_sumout\ & \Add1~69_sumout\) ) ) ) # ( !\Add1~1_sumout\ & ( \Add1~5_sumout\ ) ) # ( !\Add1~1_sumout\ & ( !\Add1~5_sumout\ & ( (\Add1~69_sumout\) # (\Add1~9_sumout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111000000000000000011111111111111110000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~69_sumout\,
	datae => \ALT_INV_Add1~1_sumout\,
	dataf => \ALT_INV_Add1~5_sumout\,
	combout => \Result~113_combout\);

-- Location: FF_X65_Y4_N26
\mv.av[0].sum[-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~113_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-3]~q\);

-- Location: LABCELL_X64_Y4_N18
\Add1~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~73_sumout\ = SUM(( !\mv.av[0].sum[-2]~q\ $ (!\x[15]~input_o\ $ (!\mv.av[0].in_sr[15][-2]~q\)) ) + ( \Add1~71\ ) + ( \Add1~70\ ))
-- \Add1~74\ = CARRY(( !\mv.av[0].sum[-2]~q\ $ (!\x[15]~input_o\ $ (!\mv.av[0].in_sr[15][-2]~q\)) ) + ( \Add1~71\ ) + ( \Add1~70\ ))
-- \Add1~75\ = SHARE((!\mv.av[0].sum[-2]~q\ & (\x[15]~input_o\ & !\mv.av[0].in_sr[15][-2]~q\)) # (\mv.av[0].sum[-2]~q\ & ((!\mv.av[0].in_sr[15][-2]~q\) # (\x[15]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010111110000010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum[-2]~q\,
	datac => \ALT_INV_x[15]~input_o\,
	datad => \ALT_INV_mv.av[0].in_sr[15][-2]~q\,
	cin => \Add1~70\,
	sharein => \Add1~71\,
	sumout => \Add1~73_sumout\,
	cout => \Add1~74\,
	shareout => \Add1~75\);

-- Location: LABCELL_X64_Y4_N21
\Add1~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~77_sumout\ = SUM(( !\mv.av[0].sum[-1]~q\ $ (!\mv.av[0].in_sr[15][-1]~q\ $ (!\x[16]~input_o\)) ) + ( \Add1~75\ ) + ( \Add1~74\ ))
-- \Add1~78\ = CARRY(( !\mv.av[0].sum[-1]~q\ $ (!\mv.av[0].in_sr[15][-1]~q\ $ (!\x[16]~input_o\)) ) + ( \Add1~75\ ) + ( \Add1~74\ ))
-- \Add1~79\ = SHARE((!\mv.av[0].sum[-1]~q\ & (!\mv.av[0].in_sr[15][-1]~q\ & \x[16]~input_o\)) # (\mv.av[0].sum[-1]~q\ & ((!\mv.av[0].in_sr[15][-1]~q\) # (\x[16]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[0].sum[-1]~q\,
	datac => \ALT_INV_mv.av[0].in_sr[15][-1]~q\,
	datad => \ALT_INV_x[16]~input_o\,
	cin => \Add1~74\,
	sharein => \Add1~75\,
	sumout => \Add1~77_sumout\,
	cout => \Add1~78\,
	shareout => \Add1~79\);

-- Location: LABCELL_X63_Y4_N21
\Result~115\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~115_combout\ = ( \Add1~1_sumout\ & ( \Add1~5_sumout\ & ( (\Add1~77_sumout\ & \Add1~9_sumout\) ) ) ) # ( !\Add1~1_sumout\ & ( \Add1~5_sumout\ ) ) # ( !\Add1~1_sumout\ & ( !\Add1~5_sumout\ & ( (\Add1~9_sumout\) # (\Add1~77_sumout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010111111111000000000000000011111111111111110000000001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~77_sumout\,
	datad => \ALT_INV_Add1~9_sumout\,
	datae => \ALT_INV_Add1~1_sumout\,
	dataf => \ALT_INV_Add1~5_sumout\,
	combout => \Result~115_combout\);

-- Location: FF_X65_Y4_N14
\mv.av[0].sum[-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~115_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-1]~q\);

-- Location: LABCELL_X64_Y4_N24
\Add1~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~81_sumout\ = SUM(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(0))) ) + ( \Add1~79\ ) + ( \Add1~78\ ))
-- \Add1~82\ = CARRY(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(0))) ) + ( \Add1~79\ ) + ( \Add1~78\ ))
-- \Add1~83\ = SHARE((!\mv.av[0].in_sr[15][0]~q\ & ((\mv.av[0].sum\(0)) # (\x[17]~input_o\))) # (\mv.av[0].in_sr[15][0]~q\ & (\x[17]~input_o\ & \mv.av[0].sum\(0))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001010110010101100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].in_sr[15][0]~q\,
	datab => \ALT_INV_x[17]~input_o\,
	datac => \ALT_INV_mv.av[0].sum\(0),
	cin => \Add1~78\,
	sharein => \Add1~79\,
	sumout => \Add1~81_sumout\,
	cout => \Add1~82\,
	shareout => \Add1~83\);

-- Location: LABCELL_X66_Y4_N42
\Result~116\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~116_combout\ = ( \Add1~9_sumout\ & ( \Add1~1_sumout\ & ( (\Add1~5_sumout\ & \Add1~81_sumout\) ) ) ) # ( \Add1~9_sumout\ & ( !\Add1~1_sumout\ ) ) # ( !\Add1~9_sumout\ & ( !\Add1~1_sumout\ & ( (\Add1~81_sumout\) # (\Add1~5_sumout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001111111111111111111111111100000000000000000000000000110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add1~5_sumout\,
	datad => \ALT_INV_Add1~81_sumout\,
	datae => \ALT_INV_Add1~9_sumout\,
	dataf => \ALT_INV_Add1~1_sumout\,
	combout => \Result~116_combout\);

-- Location: FF_X66_Y4_N44
\mv.av[0].sum[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~116_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum\(0));

-- Location: LABCELL_X64_Y4_N27
\Add1~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~85_sumout\ = SUM(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(1))) ) + ( \Add1~83\ ) + ( \Add1~82\ ))
-- \Add1~86\ = CARRY(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(1))) ) + ( \Add1~83\ ) + ( \Add1~82\ ))
-- \Add1~87\ = SHARE((!\mv.av[0].in_sr[15][0]~q\ & ((\mv.av[0].sum\(1)) # (\x[17]~input_o\))) # (\mv.av[0].in_sr[15][0]~q\ & (\x[17]~input_o\ & \mv.av[0].sum\(1))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001010110010101100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].in_sr[15][0]~q\,
	datab => \ALT_INV_x[17]~input_o\,
	datac => \ALT_INV_mv.av[0].sum\(1),
	cin => \Add1~82\,
	sharein => \Add1~83\,
	sumout => \Add1~85_sumout\,
	cout => \Add1~86\,
	shareout => \Add1~87\);

-- Location: LABCELL_X64_Y4_N51
\Result~117\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~117_combout\ = (!\Add1~5_sumout\ & (!\Add1~1_sumout\ & ((\Add1~85_sumout\) # (\Add1~9_sumout\)))) # (\Add1~5_sumout\ & ((!\Add1~1_sumout\) # ((\Add1~9_sumout\ & \Add1~85_sumout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111000011110001011100001111000101110000111100010111000011110001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~5_sumout\,
	datab => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~1_sumout\,
	datad => \ALT_INV_Add1~85_sumout\,
	combout => \Result~117_combout\);

-- Location: FF_X64_Y4_N53
\mv.av[0].sum[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~117_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum\(1));

-- Location: LABCELL_X64_Y4_N30
\Add1~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~89_sumout\ = SUM(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(2))) ) + ( \Add1~87\ ) + ( \Add1~86\ ))
-- \Add1~90\ = CARRY(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(2))) ) + ( \Add1~87\ ) + ( \Add1~86\ ))
-- \Add1~91\ = SHARE((!\mv.av[0].in_sr[15][0]~q\ & ((\mv.av[0].sum\(2)) # (\x[17]~input_o\))) # (\mv.av[0].in_sr[15][0]~q\ & (\x[17]~input_o\ & \mv.av[0].sum\(2))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001010110010101100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].in_sr[15][0]~q\,
	datab => \ALT_INV_x[17]~input_o\,
	datac => \ALT_INV_mv.av[0].sum\(2),
	cin => \Add1~86\,
	sharein => \Add1~87\,
	sumout => \Add1~89_sumout\,
	cout => \Add1~90\,
	shareout => \Add1~91\);

-- Location: LABCELL_X64_Y4_N54
\Result~118\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~118_combout\ = ( \Add1~89_sumout\ & ( (!\Add1~1_sumout\) # ((\Add1~5_sumout\ & \Add1~9_sumout\)) ) ) # ( !\Add1~89_sumout\ & ( (!\Add1~1_sumout\ & ((\Add1~9_sumout\) # (\Add1~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100110001001100010011000100110011001101110011011100110111001101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~5_sumout\,
	datab => \ALT_INV_Add1~1_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	dataf => \ALT_INV_Add1~89_sumout\,
	combout => \Result~118_combout\);

-- Location: FF_X64_Y4_N56
\mv.av[0].sum[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~118_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum\(2));

-- Location: LABCELL_X64_Y4_N33
\Add1~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~93_sumout\ = SUM(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(3))) ) + ( \Add1~91\ ) + ( \Add1~90\ ))
-- \Add1~94\ = CARRY(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(3))) ) + ( \Add1~91\ ) + ( \Add1~90\ ))
-- \Add1~95\ = SHARE((!\mv.av[0].in_sr[15][0]~q\ & ((\mv.av[0].sum\(3)) # (\x[17]~input_o\))) # (\mv.av[0].in_sr[15][0]~q\ & (\x[17]~input_o\ & \mv.av[0].sum\(3))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001010110010101100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].in_sr[15][0]~q\,
	datab => \ALT_INV_x[17]~input_o\,
	datac => \ALT_INV_mv.av[0].sum\(3),
	cin => \Add1~90\,
	sharein => \Add1~91\,
	sumout => \Add1~93_sumout\,
	cout => \Add1~94\,
	shareout => \Add1~95\);

-- Location: LABCELL_X64_Y4_N36
\Add1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~5_sumout\ = SUM(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(4))) ) + ( \Add1~95\ ) + ( \Add1~94\ ))
-- \Add1~6\ = CARRY(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(4))) ) + ( \Add1~95\ ) + ( \Add1~94\ ))
-- \Add1~7\ = SHARE((!\mv.av[0].in_sr[15][0]~q\ & ((\mv.av[0].sum\(4)) # (\x[17]~input_o\))) # (\mv.av[0].in_sr[15][0]~q\ & (\x[17]~input_o\ & \mv.av[0].sum\(4))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001010110010101100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].in_sr[15][0]~q\,
	datab => \ALT_INV_x[17]~input_o\,
	datac => \ALT_INV_mv.av[0].sum\(4),
	cin => \Add1~94\,
	sharein => \Add1~95\,
	sumout => \Add1~5_sumout\,
	cout => \Add1~6\,
	shareout => \Add1~7\);

-- Location: LABCELL_X64_Y4_N57
\Result~119\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~119_combout\ = ( \Add1~93_sumout\ & ( (!\Add1~1_sumout\) # ((\Add1~5_sumout\ & \Add1~9_sumout\)) ) ) # ( !\Add1~93_sumout\ & ( (!\Add1~1_sumout\ & ((\Add1~9_sumout\) # (\Add1~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100110001001100010011000100110011001101110011011100110111001101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~5_sumout\,
	datab => \ALT_INV_Add1~1_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	dataf => \ALT_INV_Add1~93_sumout\,
	combout => \Result~119_combout\);

-- Location: FF_X64_Y4_N59
\mv.av[0].sum[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~119_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum\(3));

-- Location: LABCELL_X64_Y4_N39
\Add1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~9_sumout\ = SUM(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(4))) ) + ( \Add1~7\ ) + ( \Add1~6\ ))
-- \Add1~10\ = CARRY(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(4))) ) + ( \Add1~7\ ) + ( \Add1~6\ ))
-- \Add1~11\ = SHARE((!\mv.av[0].in_sr[15][0]~q\ & ((\mv.av[0].sum\(4)) # (\x[17]~input_o\))) # (\mv.av[0].in_sr[15][0]~q\ & (\x[17]~input_o\ & \mv.av[0].sum\(4))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001010110010101100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].in_sr[15][0]~q\,
	datab => \ALT_INV_x[17]~input_o\,
	datac => \ALT_INV_mv.av[0].sum\(4),
	cin => \Add1~6\,
	sharein => \Add1~7\,
	sumout => \Add1~9_sumout\,
	cout => \Add1~10\,
	shareout => \Add1~11\);

-- Location: LABCELL_X64_Y4_N42
\Add1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~1_sumout\ = SUM(( !\mv.av[0].in_sr[15][0]~q\ $ (!\x[17]~input_o\ $ (!\mv.av[0].sum\(4))) ) + ( \Add1~11\ ) + ( \Add1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].in_sr[15][0]~q\,
	datab => \ALT_INV_x[17]~input_o\,
	datac => \ALT_INV_mv.av[0].sum\(4),
	cin => \Add1~10\,
	sharein => \Add1~11\,
	sumout => \Add1~1_sumout\);

-- Location: FF_X65_Y4_N35
\mv.av[0].sum[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Add1~1_sumout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum\(4));

-- Location: LABCELL_X63_Y4_N39
\Result~114\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~114_combout\ = ( \Add1~1_sumout\ & ( \Add1~5_sumout\ & ( (\Add1~9_sumout\ & \Add1~73_sumout\) ) ) ) # ( !\Add1~1_sumout\ & ( \Add1~5_sumout\ ) ) # ( !\Add1~1_sumout\ & ( !\Add1~5_sumout\ & ( (\Add1~73_sumout\) # (\Add1~9_sumout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111000000000000000011111111111111110000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~9_sumout\,
	datac => \ALT_INV_Add1~73_sumout\,
	datae => \ALT_INV_Add1~1_sumout\,
	dataf => \ALT_INV_Add1~5_sumout\,
	combout => \Result~114_combout\);

-- Location: FF_X65_Y4_N32
\mv.av[0].sum[-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Result~114_combout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[0].sum[-2]~q\);

-- Location: MLABCELL_X65_Y4_N0
\Add2~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~41_sumout\ = SUM(( \mv.av[0].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))
-- \Add2~42\ = CARRY(( \mv.av[0].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[0].sum[-13]~q\,
	cin => GND,
	sumout => \Add2~41_sumout\,
	cout => \Add2~42\);

-- Location: MLABCELL_X65_Y4_N3
\Add2~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~45_sumout\ = SUM(( \mv.av[0].sum[-12]~q\ ) + ( GND ) + ( \Add2~42\ ))
-- \Add2~46\ = CARRY(( \mv.av[0].sum[-12]~q\ ) + ( GND ) + ( \Add2~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-12]~q\,
	cin => \Add2~42\,
	sumout => \Add2~45_sumout\,
	cout => \Add2~46\);

-- Location: MLABCELL_X65_Y4_N6
\Add2~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~37_sumout\ = SUM(( \mv.av[0].sum[-11]~q\ ) + ( GND ) + ( \Add2~46\ ))
-- \Add2~38\ = CARRY(( \mv.av[0].sum[-11]~q\ ) + ( GND ) + ( \Add2~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[0].sum[-11]~q\,
	cin => \Add2~46\,
	sumout => \Add2~37_sumout\,
	cout => \Add2~38\);

-- Location: MLABCELL_X65_Y4_N9
\Add2~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~33_sumout\ = SUM(( \mv.av[0].sum[-10]~q\ ) + ( GND ) + ( \Add2~38\ ))
-- \Add2~34\ = CARRY(( \mv.av[0].sum[-10]~q\ ) + ( GND ) + ( \Add2~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-10]~q\,
	cin => \Add2~38\,
	sumout => \Add2~33_sumout\,
	cout => \Add2~34\);

-- Location: MLABCELL_X65_Y4_N12
\Add2~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~29_sumout\ = SUM(( \mv.av[0].sum[-9]~q\ ) + ( GND ) + ( \Add2~34\ ))
-- \Add2~30\ = CARRY(( \mv.av[0].sum[-9]~q\ ) + ( GND ) + ( \Add2~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-9]~q\,
	cin => \Add2~34\,
	sumout => \Add2~29_sumout\,
	cout => \Add2~30\);

-- Location: MLABCELL_X65_Y4_N15
\Add2~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~25_sumout\ = SUM(( \mv.av[0].sum[-8]~q\ ) + ( GND ) + ( \Add2~30\ ))
-- \Add2~26\ = CARRY(( \mv.av[0].sum[-8]~q\ ) + ( GND ) + ( \Add2~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum[-8]~q\,
	cin => \Add2~30\,
	sumout => \Add2~25_sumout\,
	cout => \Add2~26\);

-- Location: MLABCELL_X65_Y4_N18
\Add2~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~69_sumout\ = SUM(( \mv.av[0].sum[-7]~q\ ) + ( GND ) + ( \Add2~26\ ))
-- \Add2~70\ = CARRY(( \mv.av[0].sum[-7]~q\ ) + ( GND ) + ( \Add2~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-7]~q\,
	cin => \Add2~26\,
	sumout => \Add2~69_sumout\,
	cout => \Add2~70\);

-- Location: MLABCELL_X65_Y4_N21
\Add2~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~73_sumout\ = SUM(( \mv.av[0].sum[-6]~q\ ) + ( GND ) + ( \Add2~70\ ))
-- \Add2~74\ = CARRY(( \mv.av[0].sum[-6]~q\ ) + ( GND ) + ( \Add2~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-6]~q\,
	cin => \Add2~70\,
	sumout => \Add2~73_sumout\,
	cout => \Add2~74\);

-- Location: MLABCELL_X65_Y4_N24
\Add2~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~65_sumout\ = SUM(( \mv.av[0].sum[-5]~q\ ) + ( GND ) + ( \Add2~74\ ))
-- \Add2~66\ = CARRY(( \mv.av[0].sum[-5]~q\ ) + ( GND ) + ( \Add2~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[0].sum[-5]~q\,
	cin => \Add2~74\,
	sumout => \Add2~65_sumout\,
	cout => \Add2~66\);

-- Location: MLABCELL_X65_Y4_N27
\Add2~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~61_sumout\ = SUM(( \mv.av[0].sum[-4]~q\ ) + ( GND ) + ( \Add2~66\ ))
-- \Add2~62\ = CARRY(( \mv.av[0].sum[-4]~q\ ) + ( GND ) + ( \Add2~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-4]~q\,
	cin => \Add2~66\,
	sumout => \Add2~61_sumout\,
	cout => \Add2~62\);

-- Location: MLABCELL_X65_Y4_N30
\Add2~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~57_sumout\ = SUM(( \mv.av[0].sum[-3]~q\ ) + ( GND ) + ( \Add2~62\ ))
-- \Add2~58\ = CARRY(( \mv.av[0].sum[-3]~q\ ) + ( GND ) + ( \Add2~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-3]~q\,
	cin => \Add2~62\,
	sumout => \Add2~57_sumout\,
	cout => \Add2~58\);

-- Location: MLABCELL_X65_Y4_N33
\Add2~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~21_sumout\ = SUM(( \mv.av[0].sum[-2]~q\ ) + ( GND ) + ( \Add2~58\ ))
-- \Add2~22\ = CARRY(( \mv.av[0].sum[-2]~q\ ) + ( GND ) + ( \Add2~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-2]~q\,
	cin => \Add2~58\,
	sumout => \Add2~21_sumout\,
	cout => \Add2~22\);

-- Location: MLABCELL_X65_Y4_N36
\Add2~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~17_sumout\ = SUM(( \mv.av[0].sum[-1]~q\ ) + ( GND ) + ( \Add2~22\ ))
-- \Add2~18\ = CARRY(( \mv.av[0].sum[-1]~q\ ) + ( GND ) + ( \Add2~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[0].sum[-1]~q\,
	cin => \Add2~22\,
	sumout => \Add2~17_sumout\,
	cout => \Add2~18\);

-- Location: MLABCELL_X65_Y5_N54
\Result~59\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~59_combout\ = ( !\Add2~29_sumout\ & ( !\Add2~25_sumout\ & ( (!\Add2~45_sumout\ & (!\Add2~41_sumout\ & (!\Add2~37_sumout\ & !\Add2~33_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~45_sumout\,
	datab => \ALT_INV_Add2~41_sumout\,
	datac => \ALT_INV_Add2~37_sumout\,
	datad => \ALT_INV_Add2~33_sumout\,
	datae => \ALT_INV_Add2~29_sumout\,
	dataf => \ALT_INV_Add2~25_sumout\,
	combout => \Result~59_combout\);

-- Location: MLABCELL_X65_Y4_N39
\Add2~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~13_sumout\ = SUM(( \mv.av[0].sum\(0) ) + ( GND ) + ( \Add2~18\ ))
-- \Add2~14\ = CARRY(( \mv.av[0].sum\(0) ) + ( GND ) + ( \Add2~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[0].sum\(0),
	cin => \Add2~18\,
	sumout => \Add2~13_sumout\,
	cout => \Add2~14\);

-- Location: MLABCELL_X65_Y4_N42
\Add2~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~9_sumout\ = SUM(( \mv.av[0].sum\(1) ) + ( GND ) + ( \Add2~14\ ))
-- \Add2~10\ = CARRY(( \mv.av[0].sum\(1) ) + ( GND ) + ( \Add2~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum\(1),
	cin => \Add2~14\,
	sumout => \Add2~9_sumout\,
	cout => \Add2~10\);

-- Location: MLABCELL_X65_Y4_N45
\Add2~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~53_sumout\ = SUM(( \mv.av[0].sum\(2) ) + ( GND ) + ( \Add2~10\ ))
-- \Add2~54\ = CARRY(( \mv.av[0].sum\(2) ) + ( GND ) + ( \Add2~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[0].sum\(2),
	cin => \Add2~10\,
	sumout => \Add2~53_sumout\,
	cout => \Add2~54\);

-- Location: MLABCELL_X65_Y4_N48
\Add2~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~5_sumout\ = SUM(( \mv.av[0].sum\(3) ) + ( GND ) + ( \Add2~54\ ))
-- \Add2~6\ = CARRY(( \mv.av[0].sum\(3) ) + ( GND ) + ( \Add2~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[0].sum\(3),
	cin => \Add2~54\,
	sumout => \Add2~5_sumout\,
	cout => \Add2~6\);

-- Location: MLABCELL_X65_Y5_N12
\Result~60\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~60_combout\ = ( !\Add2~13_sumout\ & ( !\Add2~5_sumout\ & ( (!\Add2~21_sumout\ & (!\Add2~17_sumout\ & (\Result~59_combout\ & !\Add2~9_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000100000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~21_sumout\,
	datab => \ALT_INV_Add2~17_sumout\,
	datac => \ALT_INV_Result~59_combout\,
	datad => \ALT_INV_Add2~9_sumout\,
	datae => \ALT_INV_Add2~13_sumout\,
	dataf => \ALT_INV_Add2~5_sumout\,
	combout => \Result~60_combout\);

-- Location: LABCELL_X64_Y5_N18
\rounds~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \rounds~1_combout\ = ( \mv.av[0].sum[-14]~q\ & ( \mv.av[0].sum[-13]~q\ ) ) # ( \mv.av[0].sum[-14]~q\ & ( !\mv.av[0].sum[-13]~q\ & ( ((\mv.av[0].sum[-17]~q\) # (\mv.av[0].sum[-15]~q\)) # (\mv.av[0].sum[-16]~q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111111111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[0].sum[-16]~q\,
	datac => \ALT_INV_mv.av[0].sum[-15]~q\,
	datad => \ALT_INV_mv.av[0].sum[-17]~q\,
	datae => \ALT_INV_mv.av[0].sum[-14]~q\,
	dataf => \ALT_INV_mv.av[0].sum[-13]~q\,
	combout => \rounds~1_combout\);

-- Location: MLABCELL_X65_Y4_N51
\Add2~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~1_sumout\ = SUM(( \mv.av[0].sum\(4) ) + ( GND ) + ( \Add2~6\ ))
-- \Add2~2\ = CARRY(( \mv.av[0].sum\(4) ) + ( GND ) + ( \Add2~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	cin => \Add2~6\,
	sumout => \Add2~1_sumout\,
	cout => \Add2~2\);

-- Location: LABCELL_X66_Y4_N30
\Result~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~61_combout\ = ( !\Add2~61_sumout\ & ( !\Add2~53_sumout\ & ( (!\Add2~57_sumout\ & (!\Add2~65_sumout\ & (!\Add2~73_sumout\ & !\Add2~69_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~57_sumout\,
	datab => \ALT_INV_Add2~65_sumout\,
	datac => \ALT_INV_Add2~73_sumout\,
	datad => \ALT_INV_Add2~69_sumout\,
	datae => \ALT_INV_Add2~61_sumout\,
	dataf => \ALT_INV_Add2~53_sumout\,
	combout => \Result~61_combout\);

-- Location: MLABCELL_X65_Y4_N54
\Add2~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~49_sumout\ = SUM(( \mv.av[0].sum\(4) ) + ( GND ) + ( \Add2~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum\(4),
	cin => \Add2~2\,
	sumout => \Add2~49_sumout\);

-- Location: LABCELL_X66_Y5_N51
\Result~62\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~62_combout\ = ( \Result~61_combout\ & ( \Add2~49_sumout\ & ( \mv.av[0].sum\(4) ) ) ) # ( !\Result~61_combout\ & ( \Add2~49_sumout\ & ( \mv.av[0].sum\(4) ) ) ) # ( \Result~61_combout\ & ( !\Add2~49_sumout\ & ( (\mv.av[0].sum\(4) & 
-- ((!\Result~60_combout\) # ((!\rounds~1_combout\) # (\Add2~1_sumout\)))) ) ) ) # ( !\Result~61_combout\ & ( !\Add2~49_sumout\ & ( \mv.av[0].sum\(4) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011100000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Result~60_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.av[0].sum\(4),
	datad => \ALT_INV_Add2~1_sumout\,
	datae => \ALT_INV_Result~61_combout\,
	dataf => \ALT_INV_Add2~49_sumout\,
	combout => \Result~62_combout\);

-- Location: FF_X70_Y3_N2
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

-- Location: LABCELL_X70_Y3_N0
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ = SUM(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ = CARRY(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\);

-- Location: FF_X70_Y3_N1
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]~DUPLICATE_q\);

-- Location: LABCELL_X70_Y3_N3
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ = SUM(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ = CARRY(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\);

-- Location: FF_X70_Y3_N5
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1));

-- Location: LABCELL_X70_Y3_N6
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ = SUM(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ = CARRY(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\);

-- Location: FF_X70_Y3_N7
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2));

-- Location: LABCELL_X70_Y3_N9
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ = SUM(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\);

-- Location: FF_X70_Y3_N11
\mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3));

-- Location: LABCELL_X70_Y3_N30
\mv.av[1].in_sr_rtl_0|auto_generated|op_1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|op_1~1_sumout\ = SUM(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|op_1~2\ = CARRY(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~2\);

-- Location: FF_X70_Y3_N31
\mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

-- Location: LABCELL_X70_Y3_N33
\mv.av[1].in_sr_rtl_0|auto_generated|op_1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\ = SUM(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( VCC ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|op_1~2\ ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|op_1~6\ = CARRY(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( VCC ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|op_1~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~2\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~6\);

-- Location: LABCELL_X70_Y3_N24
\mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ = ( !\mv.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[1].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\,
	combout => \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\);

-- Location: FF_X70_Y3_N26
\mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\(1));

-- Location: LABCELL_X70_Y3_N27
\mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ = ( !\mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\(1) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \mv.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1),
	combout => \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\);

-- Location: LABCELL_X70_Y3_N36
\mv.av[1].in_sr_rtl_0|auto_generated|op_1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|op_1~9_sumout\ = SUM(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|op_1~6\ ))
-- \mv.av[1].in_sr_rtl_0|auto_generated|op_1~10\ = CARRY(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|op_1~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~6\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	cout => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~10\);

-- Location: FF_X70_Y3_N38
\mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2));

-- Location: LABCELL_X70_Y3_N39
\mv.av[1].in_sr_rtl_0|auto_generated|op_1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.av[1].in_sr_rtl_0|auto_generated|op_1~13_sumout\ = SUM(( \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.av[1].in_sr_rtl_0|auto_generated|op_1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \mv.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	cin => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~10\,
	sumout => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~13_sumout\);

-- Location: FF_X70_Y3_N40
\mv.av[1].in_sr_rtl_0|auto_generated|dffe3a[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \mv.av[1].in_sr_rtl_0|auto_generated|op_1~13_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3));

-- Location: MLABCELL_X65_Y5_N36
\Result~63\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~63_combout\ = ( !\Add2~69_sumout\ & ( !\Add2~73_sumout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000111100001111000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Add2~73_sumout\,
	dataf => \ALT_INV_Add2~69_sumout\,
	combout => \Result~63_combout\);

-- Location: MLABCELL_X65_Y5_N48
\Result~64\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~64_combout\ = ( !\Add2~53_sumout\ & ( !\Add2~1_sumout\ & ( (!\Add2~65_sumout\ & (!\Add2~57_sumout\ & (\Result~63_combout\ & !\Add2~61_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000100000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~65_sumout\,
	datab => \ALT_INV_Add2~57_sumout\,
	datac => \ALT_INV_Result~63_combout\,
	datad => \ALT_INV_Add2~61_sumout\,
	datae => \ALT_INV_Add2~53_sumout\,
	dataf => \ALT_INV_Add2~1_sumout\,
	combout => \Result~64_combout\);

-- Location: LABCELL_X66_Y4_N6
\round_overflow~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \round_overflow~0_combout\ = ( !\mv.av[0].sum\(4) & ( \Add2~1_sumout\ & ( \rounds~1_combout\ ) ) ) # ( \mv.av[0].sum\(4) & ( !\Add2~1_sumout\ & ( \rounds~1_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100110011001100110011001100110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~1_combout\,
	datae => \ALT_INV_mv.av[0].sum\(4),
	dataf => \ALT_INV_Add2~1_sumout\,
	combout => \round_overflow~0_combout\);

-- Location: MLABCELL_X65_Y5_N39
\Result~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~97_combout\ = ( \Add2~5_sumout\ & ( (\rounds~1_combout\) # (\mv.av[0].sum\(3)) ) ) # ( !\Add2~5_sumout\ & ( (\mv.av[0].sum\(3) & !\rounds~1_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010001000100010001000100010001110111011101110111011101110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(3),
	datab => \ALT_INV_rounds~1_combout\,
	dataf => \ALT_INV_Add2~5_sumout\,
	combout => \Result~97_combout\);

-- Location: MLABCELL_X65_Y5_N24
\Result~98\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~98_combout\ = ( \round_overflow~0_combout\ & ( \Result~97_combout\ & ( (!\mv.av[0].sum\(4)) # ((\Result~64_combout\ & (!\Add2~49_sumout\ & \Result~60_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~97_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~97_combout\ & ( (!\mv.av[0].sum\(4) & ((!\Result~64_combout\) # ((!\Result~60_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001000110011111111111111111100110011011100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Result~64_combout\,
	datab => \ALT_INV_mv.av[0].sum\(4),
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~60_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~97_combout\,
	combout => \Result~98_combout\);

-- Location: MLABCELL_X65_Y5_N45
\Result~95\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~95_combout\ = ( \Add2~53_sumout\ & ( (\mv.av[0].sum\(2)) # (\rounds~1_combout\) ) ) # ( !\Add2~53_sumout\ & ( (!\rounds~1_combout\ & \mv.av[0].sum\(2)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.av[0].sum\(2),
	dataf => \ALT_INV_Add2~53_sumout\,
	combout => \Result~95_combout\);

-- Location: MLABCELL_X65_Y5_N3
\Result~96\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~96_combout\ = ( \round_overflow~0_combout\ & ( \Result~64_combout\ & ( (!\Add2~49_sumout\ & ((!\Result~60_combout\ & ((!\mv.av[0].sum\(4)))) # (\Result~60_combout\ & (\Result~95_combout\)))) # (\Add2~49_sumout\ & (((!\mv.av[0].sum\(4))))) ) ) ) # 
-- ( !\round_overflow~0_combout\ & ( \Result~64_combout\ & ( \Result~95_combout\ ) ) ) # ( \round_overflow~0_combout\ & ( !\Result~64_combout\ & ( !\mv.av[0].sum\(4) ) ) ) # ( !\round_overflow~0_combout\ & ( !\Result~64_combout\ & ( \Result~95_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111111111110000000000001111000011111101111100000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~49_sumout\,
	datab => \ALT_INV_Result~60_combout\,
	datac => \ALT_INV_Result~95_combout\,
	datad => \ALT_INV_mv.av[0].sum\(4),
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~64_combout\,
	combout => \Result~96_combout\);

-- Location: LABCELL_X64_Y5_N27
\Result~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~93_combout\ = ( \Add2~9_sumout\ & ( (\mv.av[0].sum\(1)) # (\rounds~1_combout\) ) ) # ( !\Add2~9_sumout\ & ( (!\rounds~1_combout\ & \mv.av[0].sum\(1)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000101000001010000010100000101001011111010111110101111101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.av[0].sum\(1),
	dataf => \ALT_INV_Add2~9_sumout\,
	combout => \Result~93_combout\);

-- Location: MLABCELL_X65_Y5_N9
\Result~94\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~94_combout\ = ( \round_overflow~0_combout\ & ( \Result~93_combout\ & ( (!\mv.av[0].sum\(4)) # ((\Result~60_combout\ & (!\Add2~49_sumout\ & \Result~64_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~93_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~93_combout\ & ( (!\mv.av[0].sum\(4) & ((!\Result~60_combout\) # ((!\Result~64_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Result~60_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~64_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~93_combout\,
	combout => \Result~94_combout\);

-- Location: MLABCELL_X65_Y5_N42
\Result~91\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~91_combout\ = ( \Add2~13_sumout\ & ( (\mv.av[0].sum\(0)) # (\rounds~1_combout\) ) ) # ( !\Add2~13_sumout\ & ( (!\rounds~1_combout\ & \mv.av[0].sum\(0)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.av[0].sum\(0),
	dataf => \ALT_INV_Add2~13_sumout\,
	combout => \Result~91_combout\);

-- Location: MLABCELL_X65_Y5_N18
\Result~92\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~92_combout\ = ( \round_overflow~0_combout\ & ( \Result~91_combout\ & ( (!\mv.av[0].sum\(4)) # ((\Result~60_combout\ & (\Result~64_combout\ & !\Add2~49_sumout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~91_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~91_combout\ & ( (!\mv.av[0].sum\(4) & ((!\Result~60_combout\) # ((!\Result~64_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010001010101011111111111111111010101110101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Result~60_combout\,
	datac => \ALT_INV_Result~64_combout\,
	datad => \ALT_INV_Add2~49_sumout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~91_combout\,
	combout => \Result~92_combout\);

-- Location: LABCELL_X66_Y4_N57
\Result~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~89_combout\ = ( \Add2~17_sumout\ & ( (\mv.av[0].sum[-1]~q\) # (\rounds~1_combout\) ) ) # ( !\Add2~17_sumout\ & ( (!\rounds~1_combout\ & \mv.av[0].sum[-1]~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.av[0].sum[-1]~q\,
	dataf => \ALT_INV_Add2~17_sumout\,
	combout => \Result~89_combout\);

-- Location: MLABCELL_X65_Y5_N21
\Result~90\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~90_combout\ = ( \round_overflow~0_combout\ & ( \Result~89_combout\ & ( (!\mv.av[0].sum\(4)) # ((\Result~60_combout\ & (!\Add2~49_sumout\ & \Result~64_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~89_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~89_combout\ & ( (!\mv.av[0].sum\(4) & ((!\Result~60_combout\) # ((!\Result~64_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Result~60_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~64_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~89_combout\,
	combout => \Result~90_combout\);

-- Location: LABCELL_X66_Y4_N18
\Result~87\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~87_combout\ = ( \rounds~1_combout\ & ( \Add2~21_sumout\ ) ) # ( !\rounds~1_combout\ & ( \mv.av[0].sum[-2]~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100000000111111110000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-2]~q\,
	datad => \ALT_INV_Add2~21_sumout\,
	dataf => \ALT_INV_rounds~1_combout\,
	combout => \Result~87_combout\);

-- Location: MLABCELL_X65_Y5_N30
\Result~88\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~88_combout\ = ( \round_overflow~0_combout\ & ( \Result~87_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~64_combout\ & \Result~60_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~87_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~87_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~64_combout\) # (!\Result~60_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100010011111111111111111100110011001110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~49_sumout\,
	datab => \ALT_INV_mv.av[0].sum\(4),
	datac => \ALT_INV_Result~64_combout\,
	datad => \ALT_INV_Result~60_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~87_combout\,
	combout => \Result~88_combout\);

-- Location: LABCELL_X66_Y4_N3
\Result~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~85_combout\ = ( \Add2~57_sumout\ & ( (\mv.av[0].sum[-3]~q\) # (\rounds~1_combout\) ) ) # ( !\Add2~57_sumout\ & ( (!\rounds~1_combout\ & \mv.av[0].sum[-3]~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.av[0].sum[-3]~q\,
	dataf => \ALT_INV_Add2~57_sumout\,
	combout => \Result~85_combout\);

-- Location: MLABCELL_X65_Y5_N33
\Result~86\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~86_combout\ = ( \round_overflow~0_combout\ & ( \Result~85_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~60_combout\ & \Result~64_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~85_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~85_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~60_combout\) # (!\Result~64_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100010011111111111111111100110011001110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~49_sumout\,
	datab => \ALT_INV_mv.av[0].sum\(4),
	datac => \ALT_INV_Result~60_combout\,
	datad => \ALT_INV_Result~64_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~85_combout\,
	combout => \Result~86_combout\);

-- Location: LABCELL_X66_Y4_N51
\Result~83\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~83_combout\ = ( \Add2~61_sumout\ & ( \rounds~1_combout\ ) ) # ( \Add2~61_sumout\ & ( !\rounds~1_combout\ & ( \mv.av[0].sum[-4]~q\ ) ) ) # ( !\Add2~61_sumout\ & ( !\rounds~1_combout\ & ( \mv.av[0].sum[-4]~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-4]~q\,
	datae => \ALT_INV_Add2~61_sumout\,
	dataf => \ALT_INV_rounds~1_combout\,
	combout => \Result~83_combout\);

-- Location: MLABCELL_X65_Y5_N6
\Result~84\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~84_combout\ = ( \round_overflow~0_combout\ & ( \Result~83_combout\ & ( (!\mv.av[0].sum\(4)) # ((\Result~60_combout\ & (\Result~64_combout\ & !\Add2~49_sumout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~83_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~83_combout\ & ( (!\mv.av[0].sum\(4) & ((!\Result~60_combout\) # ((!\Result~64_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010001010101011111111111111111010101110101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Result~60_combout\,
	datac => \ALT_INV_Result~64_combout\,
	datad => \ALT_INV_Add2~49_sumout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~83_combout\,
	combout => \Result~84_combout\);

-- Location: LABCELL_X66_Y4_N15
\Result~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~81_combout\ = ( \Add2~65_sumout\ & ( (\mv.av[0].sum[-5]~q\) # (\rounds~1_combout\) ) ) # ( !\Add2~65_sumout\ & ( (!\rounds~1_combout\ & \mv.av[0].sum[-5]~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.av[0].sum[-5]~q\,
	dataf => \ALT_INV_Add2~65_sumout\,
	combout => \Result~81_combout\);

-- Location: LABCELL_X66_Y6_N6
\Result~82\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~82_combout\ = ( \round_overflow~0_combout\ & ( \Result~81_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~64_combout\ & \Result~60_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~81_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~81_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~64_combout\) # (!\Result~60_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_Result~64_combout\,
	datad => \ALT_INV_Result~60_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~81_combout\,
	combout => \Result~82_combout\);

-- Location: LABCELL_X66_Y4_N36
\Result~79\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~79_combout\ = ( \rounds~1_combout\ & ( \Add2~73_sumout\ ) ) # ( !\rounds~1_combout\ & ( \mv.av[0].sum[-6]~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100000000111111110000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-6]~q\,
	datad => \ALT_INV_Add2~73_sumout\,
	dataf => \ALT_INV_rounds~1_combout\,
	combout => \Result~79_combout\);

-- Location: LABCELL_X66_Y6_N18
\Result~80\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~80_combout\ = ( \round_overflow~0_combout\ & ( \Result~79_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~64_combout\ & \Result~60_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~79_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~79_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~64_combout\) # (!\Result~60_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_Result~64_combout\,
	datad => \ALT_INV_Result~60_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~79_combout\,
	combout => \Result~80_combout\);

-- Location: MLABCELL_X65_Y6_N54
\Result~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~77_combout\ = ( \Add2~69_sumout\ & ( (\mv.av[0].sum[-7]~q\) # (\rounds~1_combout\) ) ) # ( !\Add2~69_sumout\ & ( (!\rounds~1_combout\ & \mv.av[0].sum[-7]~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000101000001010000010100000101001011111010111110101111101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.av[0].sum[-7]~q\,
	dataf => \ALT_INV_Add2~69_sumout\,
	combout => \Result~77_combout\);

-- Location: MLABCELL_X65_Y6_N12
\Result~78\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~78_combout\ = ( \Result~60_combout\ & ( \Result~64_combout\ & ( (!\Add2~49_sumout\ & (\Result~77_combout\)) # (\Add2~49_sumout\ & ((!\round_overflow~0_combout\ & (\Result~77_combout\)) # (\round_overflow~0_combout\ & ((!\mv.av[0].sum\(4)))))) ) ) 
-- ) # ( !\Result~60_combout\ & ( \Result~64_combout\ & ( (!\round_overflow~0_combout\ & (\Result~77_combout\)) # (\round_overflow~0_combout\ & ((!\mv.av[0].sum\(4)))) ) ) ) # ( \Result~60_combout\ & ( !\Result~64_combout\ & ( (!\round_overflow~0_combout\ & 
-- (\Result~77_combout\)) # (\round_overflow~0_combout\ & ((!\mv.av[0].sum\(4)))) ) ) ) # ( !\Result~60_combout\ & ( !\Result~64_combout\ & ( (!\round_overflow~0_combout\ & (\Result~77_combout\)) # (\round_overflow~0_combout\ & ((!\mv.av[0].sum\(4)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010111001100010101011100110001010101110011000101010101011100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Result~77_combout\,
	datab => \ALT_INV_mv.av[0].sum\(4),
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_round_overflow~0_combout\,
	datae => \ALT_INV_Result~60_combout\,
	dataf => \ALT_INV_Result~64_combout\,
	combout => \Result~78_combout\);

-- Location: MLABCELL_X65_Y6_N51
\Result~75\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~75_combout\ = ( \Add2~25_sumout\ & ( \mv.av[0].sum[-8]~q\ ) ) # ( !\Add2~25_sumout\ & ( \mv.av[0].sum[-8]~q\ & ( !\rounds~1_combout\ ) ) ) # ( \Add2~25_sumout\ & ( !\mv.av[0].sum[-8]~q\ & ( \rounds~1_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010101010101010110101010101010101111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datae => \ALT_INV_Add2~25_sumout\,
	dataf => \ALT_INV_mv.av[0].sum[-8]~q\,
	combout => \Result~75_combout\);

-- Location: LABCELL_X66_Y6_N3
\Result~76\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~76_combout\ = ( \round_overflow~0_combout\ & ( \Result~75_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~60_combout\ & \Result~64_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~75_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~75_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~60_combout\) # (!\Result~64_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_Result~60_combout\,
	datad => \ALT_INV_Result~64_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~75_combout\,
	combout => \Result~76_combout\);

-- Location: MLABCELL_X65_Y6_N30
\Result~71\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~71_combout\ = ( \Add2~29_sumout\ & ( \mv.av[0].sum[-9]~q\ ) ) # ( !\Add2~29_sumout\ & ( \mv.av[0].sum[-9]~q\ & ( !\rounds~1_combout\ ) ) ) # ( \Add2~29_sumout\ & ( !\mv.av[0].sum[-9]~q\ & ( \rounds~1_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011110000111111110000111100001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_rounds~1_combout\,
	datae => \ALT_INV_Add2~29_sumout\,
	dataf => \ALT_INV_mv.av[0].sum[-9]~q\,
	combout => \Result~71_combout\);

-- Location: LABCELL_X66_Y6_N9
\Result~72\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~72_combout\ = ( \round_overflow~0_combout\ & ( \Result~71_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~60_combout\ & \Result~64_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~71_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~71_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~60_combout\) # (!\Result~64_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_Result~60_combout\,
	datad => \ALT_INV_Result~64_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~71_combout\,
	combout => \Result~72_combout\);

-- Location: MLABCELL_X65_Y6_N39
\Result~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~65_combout\ = ( \mv.av[0].sum[-10]~q\ & ( \Add2~33_sumout\ ) ) # ( !\mv.av[0].sum[-10]~q\ & ( \Add2~33_sumout\ & ( \rounds~1_combout\ ) ) ) # ( \mv.av[0].sum[-10]~q\ & ( !\Add2~33_sumout\ & ( !\rounds~1_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010101001010101010101011111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datae => \ALT_INV_mv.av[0].sum[-10]~q\,
	dataf => \ALT_INV_Add2~33_sumout\,
	combout => \Result~65_combout\);

-- Location: LABCELL_X66_Y6_N27
\Result~66\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~66_combout\ = ( \round_overflow~0_combout\ & ( \Result~65_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~60_combout\ & \Result~64_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~65_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~65_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~60_combout\) # (!\Result~64_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_Result~60_combout\,
	datad => \ALT_INV_Result~64_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~65_combout\,
	combout => \Result~66_combout\);

-- Location: LABCELL_X66_Y6_N15
\Result~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~73_combout\ = ( \Add2~37_sumout\ & ( (\rounds~1_combout\) # (\mv.av[0].sum[-11]~q\) ) ) # ( !\Add2~37_sumout\ & ( (\mv.av[0].sum[-11]~q\ & !\rounds~1_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000000011110000000000001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[0].sum[-11]~q\,
	datad => \ALT_INV_rounds~1_combout\,
	dataf => \ALT_INV_Add2~37_sumout\,
	combout => \Result~73_combout\);

-- Location: LABCELL_X66_Y6_N24
\Result~74\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~74_combout\ = ( \round_overflow~0_combout\ & ( \Result~73_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~64_combout\ & \Result~60_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~73_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~73_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~64_combout\) # (!\Result~60_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_Result~64_combout\,
	datad => \ALT_INV_Result~60_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~73_combout\,
	combout => \Result~74_combout\);

-- Location: MLABCELL_X65_Y6_N0
\Result~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~69_combout\ = ( \Add2~45_sumout\ & ( (\rounds~1_combout\) # (\mv.av[0].sum[-12]~q\) ) ) # ( !\Add2~45_sumout\ & ( (\mv.av[0].sum[-12]~q\ & !\rounds~1_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000000110000001100000011000000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[0].sum[-12]~q\,
	datac => \ALT_INV_rounds~1_combout\,
	dataf => \ALT_INV_Add2~45_sumout\,
	combout => \Result~69_combout\);

-- Location: LABCELL_X66_Y6_N0
\Result~70\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~70_combout\ = ( \round_overflow~0_combout\ & ( \Result~69_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~64_combout\ & \Result~60_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~69_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~69_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~64_combout\) # (!\Result~60_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_Result~64_combout\,
	datad => \ALT_INV_Result~60_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~69_combout\,
	combout => \Result~70_combout\);

-- Location: MLABCELL_X65_Y6_N45
\Result~67\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~67_combout\ = ( \mv.av[0].sum[-14]~q\ & ( \Add2~41_sumout\ & ( \rounds~1_combout\ ) ) ) # ( !\mv.av[0].sum[-14]~q\ & ( \Add2~41_sumout\ & ( (\mv.av[0].sum[-13]~q\) # (\rounds~1_combout\) ) ) ) # ( !\mv.av[0].sum[-14]~q\ & ( !\Add2~41_sumout\ & ( 
-- \mv.av[0].sum[-13]~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000000000000000001011111010111110101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.av[0].sum[-13]~q\,
	datae => \ALT_INV_mv.av[0].sum[-14]~q\,
	dataf => \ALT_INV_Add2~41_sumout\,
	combout => \Result~67_combout\);

-- Location: LABCELL_X66_Y6_N21
\Result~68\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~68_combout\ = ( \round_overflow~0_combout\ & ( \Result~67_combout\ & ( (!\mv.av[0].sum\(4)) # ((!\Add2~49_sumout\ & (\Result~60_combout\ & \Result~64_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~67_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~67_combout\ & ( (!\mv.av[0].sum\(4) & (((!\Result~60_combout\) # (!\Result~64_combout\)) # (\Add2~49_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[0].sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_Result~60_combout\,
	datad => \ALT_INV_Result~64_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~67_combout\,
	combout => \Result~68_combout\);

-- Location: M10K_X69_Y3_N0
\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.av[1].in_sr_rtl_0|shift_taps_lev:auto_generated|altsyncram_1jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 40,
	port_a_first_address => 0,
	port_a_first_bit_number => 0,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 40,
	port_b_first_address => 0,
	port_b_first_bit_number => 0,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~inputCLKENA0_outclk\,
	clk1 => \clk~inputCLKENA0_outclk\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTADATAIN_bus\,
	portaaddr => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTAADDR_bus\,
	portbaddr => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\);

-- Location: LABCELL_X66_Y6_N30
\Add4~98\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~98_cout\ = CARRY(( GND ) + ( !VCC ) + ( !VCC ))
-- \Add4~99\ = SHARE(VCC)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	cin => GND,
	sharein => GND,
	cout => \Add4~98_cout\,
	shareout => \Add4~99\);

-- Location: LABCELL_X66_Y6_N33
\Add4~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~17_sumout\ = SUM(( !\mv.av[1].sum[-17]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17\ $ (!\Result~68_combout\)) ) + ( \Add4~99\ ) + ( \Add4~98_cout\ ))
-- \Add4~18\ = CARRY(( !\mv.av[1].sum[-17]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17\ $ (!\Result~68_combout\)) ) + ( \Add4~99\ ) + ( \Add4~98_cout\ ))
-- \Add4~19\ = SHARE((!\mv.av[1].sum[-17]~q\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17\ & \Result~68_combout\)) # (\mv.av[1].sum[-17]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17\) # (\Result~68_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[1].sum[-17]~q\,
	datac => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a17\,
	datad => \ALT_INV_Result~68_combout\,
	cin => \Add4~98_cout\,
	sharein => \Add4~99\,
	sumout => \Add4~17_sumout\,
	cout => \Add4~18\,
	shareout => \Add4~19\);

-- Location: LABCELL_X66_Y6_N36
\Add4~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~21_sumout\ = SUM(( !\mv.av[1].sum[-16]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16\ $ (!\Result~70_combout\)) ) + ( \Add4~19\ ) + ( \Add4~18\ ))
-- \Add4~22\ = CARRY(( !\mv.av[1].sum[-16]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16\ $ (!\Result~70_combout\)) ) + ( \Add4~19\ ) + ( \Add4~18\ ))
-- \Add4~23\ = SHARE((!\mv.av[1].sum[-16]~q\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16\ & \Result~70_combout\)) # (\mv.av[1].sum[-16]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16\) # (\Result~70_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010100001111010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-16]~q\,
	datac => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a16\,
	datad => \ALT_INV_Result~70_combout\,
	cin => \Add4~18\,
	sharein => \Add4~19\,
	sumout => \Add4~21_sumout\,
	cout => \Add4~22\,
	shareout => \Add4~23\);

-- Location: LABCELL_X66_Y6_N39
\Add4~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~29_sumout\ = SUM(( !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15\ $ (!\Result~74_combout\ $ (!\mv.av[1].sum[-15]~q\)) ) + ( \Add4~23\ ) + ( \Add4~22\ ))
-- \Add4~30\ = CARRY(( !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15\ $ (!\Result~74_combout\ $ (!\mv.av[1].sum[-15]~q\)) ) + ( \Add4~23\ ) + ( \Add4~22\ ))
-- \Add4~31\ = SHARE((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15\ & ((\mv.av[1].sum[-15]~q\) # (\Result~74_combout\))) # (\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15\ & (\Result~74_combout\ & \mv.av[1].sum[-15]~q\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011001100111100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a15\,
	datac => \ALT_INV_Result~74_combout\,
	datad => \ALT_INV_mv.av[1].sum[-15]~q\,
	cin => \Add4~22\,
	sharein => \Add4~23\,
	sumout => \Add4~29_sumout\,
	cout => \Add4~30\,
	shareout => \Add4~31\);

-- Location: LABCELL_X66_Y6_N42
\Add4~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~13_sumout\ = SUM(( !\mv.av[1].sum[-14]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14\ $ (!\Result~66_combout\)) ) + ( \Add4~31\ ) + ( \Add4~30\ ))
-- \Add4~14\ = CARRY(( !\mv.av[1].sum[-14]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14\ $ (!\Result~66_combout\)) ) + ( \Add4~31\ ) + ( \Add4~30\ ))
-- \Add4~15\ = SHARE((!\mv.av[1].sum[-14]~q\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14\ & \Result~66_combout\)) # (\mv.av[1].sum[-14]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14\) # (\Result~66_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010100001111010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-14]~q\,
	datac => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a14\,
	datad => \ALT_INV_Result~66_combout\,
	cin => \Add4~30\,
	sharein => \Add4~31\,
	sumout => \Add4~13_sumout\,
	cout => \Add4~14\,
	shareout => \Add4~15\);

-- Location: LABCELL_X66_Y6_N45
\Add4~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~25_sumout\ = SUM(( !\mv.av[1].sum[-13]~q\ $ (!\Result~72_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13\)) ) + ( \Add4~15\ ) + ( \Add4~14\ ))
-- \Add4~26\ = CARRY(( !\mv.av[1].sum[-13]~q\ $ (!\Result~72_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13\)) ) + ( \Add4~15\ ) + ( \Add4~14\ ))
-- \Add4~27\ = SHARE((!\mv.av[1].sum[-13]~q\ & (\Result~72_combout\ & !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13\)) # (\mv.av[1].sum[-13]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13\) # (\Result~72_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[1].sum[-13]~q\,
	datac => \ALT_INV_Result~72_combout\,
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a13\,
	cin => \Add4~14\,
	sharein => \Add4~15\,
	sumout => \Add4~25_sumout\,
	cout => \Add4~26\,
	shareout => \Add4~27\);

-- Location: LABCELL_X67_Y5_N27
\Result~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~41_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~25_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~25_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~25_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~41_combout\);

-- Location: FF_X67_Y5_N29
\mv.av[1].sum[-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~41_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-13]~q\);

-- Location: LABCELL_X66_Y6_N48
\Add4~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~33_sumout\ = SUM(( !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12\ $ (!\mv.av[1].sum[-12]~q\ $ (!\Result~76_combout\)) ) + ( \Add4~27\ ) + ( \Add4~26\ ))
-- \Add4~34\ = CARRY(( !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12\ $ (!\mv.av[1].sum[-12]~q\ $ (!\Result~76_combout\)) ) + ( \Add4~27\ ) + ( \Add4~26\ ))
-- \Add4~35\ = SHARE((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12\ & ((\Result~76_combout\) # (\mv.av[1].sum[-12]~q\))) # (\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12\ & (\mv.av[1].sum[-12]~q\ & \Result~76_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011001100111100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a12\,
	datac => \ALT_INV_mv.av[1].sum[-12]~q\,
	datad => \ALT_INV_Result~76_combout\,
	cin => \Add4~26\,
	sharein => \Add4~27\,
	sumout => \Add4~33_sumout\,
	cout => \Add4~34\,
	shareout => \Add4~35\);

-- Location: LABCELL_X67_Y5_N21
\Result~43\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~43_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~33_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~33_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~33_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~43_combout\);

-- Location: FF_X67_Y5_N22
\mv.av[1].sum[-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~43_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-12]~q\);

-- Location: LABCELL_X66_Y6_N51
\Add4~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~37_sumout\ = SUM(( !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11\ $ (!\mv.av[1].sum[-11]~q\ $ (!\Result~78_combout\)) ) + ( \Add4~35\ ) + ( \Add4~34\ ))
-- \Add4~38\ = CARRY(( !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11\ $ (!\mv.av[1].sum[-11]~q\ $ (!\Result~78_combout\)) ) + ( \Add4~35\ ) + ( \Add4~34\ ))
-- \Add4~39\ = SHARE((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11\ & ((\Result~78_combout\) # (\mv.av[1].sum[-11]~q\))) # (\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11\ & (\mv.av[1].sum[-11]~q\ & \Result~78_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000010101010111100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a11\,
	datac => \ALT_INV_mv.av[1].sum[-11]~q\,
	datad => \ALT_INV_Result~78_combout\,
	cin => \Add4~34\,
	sharein => \Add4~35\,
	sumout => \Add4~37_sumout\,
	cout => \Add4~38\,
	shareout => \Add4~39\);

-- Location: LABCELL_X67_Y5_N12
\Result~44\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~44_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~37_sumout\ & \Add4~5_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~5_sumout\) # (\Add4~37_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100000000001111110000000011111111000000111111111100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~37_sumout\,
	datac => \ALT_INV_Add4~5_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~44_combout\);

-- Location: FF_X67_Y5_N13
\mv.av[1].sum[-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~44_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-11]~q\);

-- Location: LABCELL_X66_Y6_N54
\Add4~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~41_sumout\ = SUM(( !\mv.av[1].sum[-10]~q\ $ (!\Result~80_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10\)) ) + ( \Add4~39\ ) + ( \Add4~38\ ))
-- \Add4~42\ = CARRY(( !\mv.av[1].sum[-10]~q\ $ (!\Result~80_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10\)) ) + ( \Add4~39\ ) + ( \Add4~38\ ))
-- \Add4~43\ = SHARE((!\mv.av[1].sum[-10]~q\ & (\Result~80_combout\ & !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10\)) # (\mv.av[1].sum[-10]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10\) # (\Result~80_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010111110000010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-10]~q\,
	datac => \ALT_INV_Result~80_combout\,
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a10\,
	cin => \Add4~38\,
	sharein => \Add4~39\,
	sumout => \Add4~41_sumout\,
	cout => \Add4~42\,
	shareout => \Add4~43\);

-- Location: LABCELL_X67_Y5_N9
\Result~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~45_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~41_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~41_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~41_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~45_combout\);

-- Location: FF_X67_Y5_N10
\mv.av[1].sum[-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~45_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-10]~q\);

-- Location: LABCELL_X66_Y6_N57
\Add4~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~45_sumout\ = SUM(( !\mv.av[1].sum[-9]~q\ $ (!\Result~82_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9\)) ) + ( \Add4~43\ ) + ( \Add4~42\ ))
-- \Add4~46\ = CARRY(( !\mv.av[1].sum[-9]~q\ $ (!\Result~82_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9\)) ) + ( \Add4~43\ ) + ( \Add4~42\ ))
-- \Add4~47\ = SHARE((!\mv.av[1].sum[-9]~q\ & (\Result~82_combout\ & !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9\)) # (\mv.av[1].sum[-9]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9\) # (\Result~82_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[1].sum[-9]~q\,
	datac => \ALT_INV_Result~82_combout\,
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a9\,
	cin => \Add4~42\,
	sharein => \Add4~43\,
	sumout => \Add4~45_sumout\,
	cout => \Add4~46\,
	shareout => \Add4~47\);

-- Location: LABCELL_X67_Y5_N39
\Result~46\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~46_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~45_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~45_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~45_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~46_combout\);

-- Location: FF_X67_Y5_N40
\mv.av[1].sum[-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~46_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-9]~q\);

-- Location: LABCELL_X66_Y5_N0
\Add4~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~49_sumout\ = SUM(( !\mv.av[1].sum[-8]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8\ $ (!\Result~84_combout\)) ) + ( \Add4~47\ ) + ( \Add4~46\ ))
-- \Add4~50\ = CARRY(( !\mv.av[1].sum[-8]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8\ $ (!\Result~84_combout\)) ) + ( \Add4~47\ ) + ( \Add4~46\ ))
-- \Add4~51\ = SHARE((!\mv.av[1].sum[-8]~q\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8\ & \Result~84_combout\)) # (\mv.av[1].sum[-8]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8\) # (\Result~84_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010100001111010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-8]~q\,
	datac => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a8\,
	datad => \ALT_INV_Result~84_combout\,
	cin => \Add4~46\,
	sharein => \Add4~47\,
	sumout => \Add4~49_sumout\,
	cout => \Add4~50\,
	shareout => \Add4~51\);

-- Location: LABCELL_X67_Y5_N51
\Result~47\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~47_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~49_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~49_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~49_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~47_combout\);

-- Location: FF_X67_Y5_N52
\mv.av[1].sum[-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~47_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-8]~q\);

-- Location: LABCELL_X66_Y5_N3
\Add4~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~53_sumout\ = SUM(( !\mv.av[1].sum[-7]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7\ $ (!\Result~86_combout\)) ) + ( \Add4~51\ ) + ( \Add4~50\ ))
-- \Add4~54\ = CARRY(( !\mv.av[1].sum[-7]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7\ $ (!\Result~86_combout\)) ) + ( \Add4~51\ ) + ( \Add4~50\ ))
-- \Add4~55\ = SHARE((!\mv.av[1].sum[-7]~q\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7\ & \Result~86_combout\)) # (\mv.av[1].sum[-7]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7\) # (\Result~86_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[1].sum[-7]~q\,
	datac => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a7\,
	datad => \ALT_INV_Result~86_combout\,
	cin => \Add4~50\,
	sharein => \Add4~51\,
	sumout => \Add4~53_sumout\,
	cout => \Add4~54\,
	shareout => \Add4~55\);

-- Location: LABCELL_X67_Y5_N36
\Result~48\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~48_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~53_sumout\ & \Add4~5_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~5_sumout\) # (\Add4~53_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100000000001111110000000011111111000000111111111100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~53_sumout\,
	datac => \ALT_INV_Add4~5_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~48_combout\);

-- Location: FF_X67_Y5_N37
\mv.av[1].sum[-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~48_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-7]~q\);

-- Location: LABCELL_X66_Y5_N6
\Add4~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~57_sumout\ = SUM(( !\mv.av[1].sum[-6]~q\ $ (!\Result~88_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6\)) ) + ( \Add4~55\ ) + ( \Add4~54\ ))
-- \Add4~58\ = CARRY(( !\mv.av[1].sum[-6]~q\ $ (!\Result~88_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6\)) ) + ( \Add4~55\ ) + ( \Add4~54\ ))
-- \Add4~59\ = SHARE((!\mv.av[1].sum[-6]~q\ & (\Result~88_combout\ & !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6\)) # (\mv.av[1].sum[-6]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6\) # (\Result~88_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[1].sum[-6]~q\,
	datac => \ALT_INV_Result~88_combout\,
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a6\,
	cin => \Add4~54\,
	sharein => \Add4~55\,
	sumout => \Add4~57_sumout\,
	cout => \Add4~58\,
	shareout => \Add4~59\);

-- Location: LABCELL_X67_Y5_N18
\Result~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~49_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~57_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~57_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~57_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~49_combout\);

-- Location: FF_X67_Y5_N19
\mv.av[1].sum[-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~49_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-6]~q\);

-- Location: LABCELL_X66_Y5_N9
\Add4~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~61_sumout\ = SUM(( !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5\ $ (!\mv.av[1].sum[-5]~q\ $ (!\Result~90_combout\)) ) + ( \Add4~59\ ) + ( \Add4~58\ ))
-- \Add4~62\ = CARRY(( !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5\ $ (!\mv.av[1].sum[-5]~q\ $ (!\Result~90_combout\)) ) + ( \Add4~59\ ) + ( \Add4~58\ ))
-- \Add4~63\ = SHARE((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5\ & ((\Result~90_combout\) # (\mv.av[1].sum[-5]~q\))) # (\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5\ & (\mv.av[1].sum[-5]~q\ & \Result~90_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000010101010111100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a5\,
	datac => \ALT_INV_mv.av[1].sum[-5]~q\,
	datad => \ALT_INV_Result~90_combout\,
	cin => \Add4~58\,
	sharein => \Add4~59\,
	sumout => \Add4~61_sumout\,
	cout => \Add4~62\,
	shareout => \Add4~63\);

-- Location: LABCELL_X67_Y5_N33
\Result~50\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~50_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~61_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~61_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~61_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~50_combout\);

-- Location: FF_X67_Y5_N34
\mv.av[1].sum[-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~50_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-5]~q\);

-- Location: LABCELL_X66_Y5_N12
\Add4~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~65_sumout\ = SUM(( !\mv.av[1].sum[-4]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4\ $ (!\Result~92_combout\)) ) + ( \Add4~63\ ) + ( \Add4~62\ ))
-- \Add4~66\ = CARRY(( !\mv.av[1].sum[-4]~q\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4\ $ (!\Result~92_combout\)) ) + ( \Add4~63\ ) + ( \Add4~62\ ))
-- \Add4~67\ = SHARE((!\mv.av[1].sum[-4]~q\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4\ & \Result~92_combout\)) # (\mv.av[1].sum[-4]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4\) # (\Result~92_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.av[1].sum[-4]~q\,
	datac => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a4\,
	datad => \ALT_INV_Result~92_combout\,
	cin => \Add4~62\,
	sharein => \Add4~63\,
	sumout => \Add4~65_sumout\,
	cout => \Add4~66\,
	shareout => \Add4~67\);

-- Location: LABCELL_X66_Y5_N57
\Result~51\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~51_combout\ = ( \Add4~1_sumout\ & ( (\Add4~9_sumout\ & (\Add4~65_sumout\ & \Add4~5_sumout\)) ) ) # ( !\Add4~1_sumout\ & ( ((\Add4~5_sumout\) # (\Add4~65_sumout\)) # (\Add4~9_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111111111111001111111111111100000000000000110000000000000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~9_sumout\,
	datac => \ALT_INV_Add4~65_sumout\,
	datad => \ALT_INV_Add4~5_sumout\,
	dataf => \ALT_INV_Add4~1_sumout\,
	combout => \Result~51_combout\);

-- Location: FF_X66_Y5_N59
\mv.av[1].sum[-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~51_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-4]~q\);

-- Location: LABCELL_X66_Y5_N15
\Add4~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~69_sumout\ = SUM(( !\mv.av[1].sum[-3]~q\ $ (!\Result~94_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3\)) ) + ( \Add4~67\ ) + ( \Add4~66\ ))
-- \Add4~70\ = CARRY(( !\mv.av[1].sum[-3]~q\ $ (!\Result~94_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3\)) ) + ( \Add4~67\ ) + ( \Add4~66\ ))
-- \Add4~71\ = SHARE((!\mv.av[1].sum[-3]~q\ & (\Result~94_combout\ & !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3\)) # (\mv.av[1].sum[-3]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3\) # (\Result~94_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010111110000010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-3]~q\,
	datac => \ALT_INV_Result~94_combout\,
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a3\,
	cin => \Add4~66\,
	sharein => \Add4~67\,
	sumout => \Add4~69_sumout\,
	cout => \Add4~70\,
	shareout => \Add4~71\);

-- Location: LABCELL_X66_Y5_N18
\Add4~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~73_sumout\ = SUM(( !\Result~96_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2\ $ (!\mv.av[1].sum[-2]~q\)) ) + ( \Add4~71\ ) + ( \Add4~70\ ))
-- \Add4~74\ = CARRY(( !\Result~96_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2\ $ (!\mv.av[1].sum[-2]~q\)) ) + ( \Add4~71\ ) + ( \Add4~70\ ))
-- \Add4~75\ = SHARE((!\Result~96_combout\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2\ & \mv.av[1].sum[-2]~q\)) # (\Result~96_combout\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2\) # (\mv.av[1].sum[-2]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~96_combout\,
	datac => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a2\,
	datad => \ALT_INV_mv.av[1].sum[-2]~q\,
	cin => \Add4~70\,
	sharein => \Add4~71\,
	sumout => \Add4~73_sumout\,
	cout => \Add4~74\,
	shareout => \Add4~75\);

-- Location: LABCELL_X66_Y5_N21
\Add4~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~77_sumout\ = SUM(( !\mv.av[1].sum[-1]~q\ $ (!\Result~98_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1\)) ) + ( \Add4~75\ ) + ( \Add4~74\ ))
-- \Add4~78\ = CARRY(( !\mv.av[1].sum[-1]~q\ $ (!\Result~98_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1\)) ) + ( \Add4~75\ ) + ( \Add4~74\ ))
-- \Add4~79\ = SHARE((!\mv.av[1].sum[-1]~q\ & (\Result~98_combout\ & !\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1\)) # (\mv.av[1].sum[-1]~q\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1\) # (\Result~98_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010111110000010100000000000000001010010101011010",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-1]~q\,
	datac => \ALT_INV_Result~98_combout\,
	datad => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a1\,
	cin => \Add4~74\,
	sharein => \Add4~75\,
	sumout => \Add4~77_sumout\,
	cout => \Add4~78\,
	shareout => \Add4~79\);

-- Location: LABCELL_X66_Y5_N24
\Add4~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~81_sumout\ = SUM(( !\Result~62_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\mv.av[1].sum\(0))) ) + ( \Add4~79\ ) + ( \Add4~78\ ))
-- \Add4~82\ = CARRY(( !\Result~62_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\mv.av[1].sum\(0))) ) + ( \Add4~79\ ) + ( \Add4~78\ ))
-- \Add4~83\ = SHARE((!\Result~62_combout\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ & \mv.av[1].sum\(0))) # (\Result~62_combout\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # 
-- (\mv.av[1].sum\(0)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010001001101110100000000000000001001100101100110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Result~62_combout\,
	datab => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	datad => \ALT_INV_mv.av[1].sum\(0),
	cin => \Add4~78\,
	sharein => \Add4~79\,
	sumout => \Add4~81_sumout\,
	cout => \Add4~82\,
	shareout => \Add4~83\);

-- Location: LABCELL_X66_Y5_N27
\Add4~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~85_sumout\ = SUM(( !\Result~62_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\mv.av[1].sum\(1))) ) + ( \Add4~83\ ) + ( \Add4~82\ ))
-- \Add4~86\ = CARRY(( !\Result~62_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\mv.av[1].sum\(1))) ) + ( \Add4~83\ ) + ( \Add4~82\ ))
-- \Add4~87\ = SHARE((!\Result~62_combout\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ & \mv.av[1].sum\(1))) # (\Result~62_combout\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # 
-- (\mv.av[1].sum\(1)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010011010100110100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Result~62_combout\,
	datab => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	datac => \ALT_INV_mv.av[1].sum\(1),
	cin => \Add4~82\,
	sharein => \Add4~83\,
	sumout => \Add4~85_sumout\,
	cout => \Add4~86\,
	shareout => \Add4~87\);

-- Location: LABCELL_X66_Y5_N30
\Add4~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~89_sumout\ = SUM(( !\Result~62_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\mv.av[1].sum\(2))) ) + ( \Add4~87\ ) + ( \Add4~86\ ))
-- \Add4~90\ = CARRY(( !\Result~62_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\mv.av[1].sum\(2))) ) + ( \Add4~87\ ) + ( \Add4~86\ ))
-- \Add4~91\ = SHARE((!\Result~62_combout\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ & \mv.av[1].sum\(2))) # (\Result~62_combout\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # 
-- (\mv.av[1].sum\(2)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010011010100110100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Result~62_combout\,
	datab => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	datac => \ALT_INV_mv.av[1].sum\(2),
	cin => \Add4~86\,
	sharein => \Add4~87\,
	sumout => \Add4~89_sumout\,
	cout => \Add4~90\,
	shareout => \Add4~91\);

-- Location: LABCELL_X66_Y5_N33
\Add4~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~93_sumout\ = SUM(( !\Result~62_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\mv.av[1].sum\(3))) ) + ( \Add4~91\ ) + ( \Add4~90\ ))
-- \Add4~94\ = CARRY(( !\Result~62_combout\ $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\mv.av[1].sum\(3))) ) + ( \Add4~91\ ) + ( \Add4~90\ ))
-- \Add4~95\ = SHARE((!\Result~62_combout\ & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ & \mv.av[1].sum\(3))) # (\Result~62_combout\ & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # 
-- (\mv.av[1].sum\(3)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010011010100110100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Result~62_combout\,
	datab => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	datac => \ALT_INV_mv.av[1].sum\(3),
	cin => \Add4~90\,
	sharein => \Add4~91\,
	sumout => \Add4~93_sumout\,
	cout => \Add4~94\,
	shareout => \Add4~95\);

-- Location: LABCELL_X66_Y5_N36
\Add4~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~5_sumout\ = SUM(( !\mv.av[1].sum\(4) $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\Result~62_combout\)) ) + ( \Add4~95\ ) + ( \Add4~94\ ))
-- \Add4~6\ = CARRY(( !\mv.av[1].sum\(4) $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\Result~62_combout\)) ) + ( \Add4~95\ ) + ( \Add4~94\ ))
-- \Add4~7\ = SHARE((!\mv.av[1].sum\(4) & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ & \Result~62_combout\)) # (\mv.av[1].sum\(4) & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # 
-- (\Result~62_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010011010100110100000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum\(4),
	datab => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	datac => \ALT_INV_Result~62_combout\,
	cin => \Add4~94\,
	sharein => \Add4~95\,
	sumout => \Add4~5_sumout\,
	cout => \Add4~6\,
	shareout => \Add4~7\);

-- Location: LABCELL_X66_Y5_N39
\Add4~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~9_sumout\ = SUM(( !\mv.av[1].sum\(4) $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\Result~62_combout\)) ) + ( \Add4~7\ ) + ( \Add4~6\ ))
-- \Add4~10\ = CARRY(( !\mv.av[1].sum\(4) $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\Result~62_combout\)) ) + ( \Add4~7\ ) + ( \Add4~6\ ))
-- \Add4~11\ = SHARE((!\mv.av[1].sum\(4) & (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ & \Result~62_combout\)) # (\mv.av[1].sum\(4) & ((!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # 
-- (\Result~62_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010001001101110100000000000000001001100101100110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum\(4),
	datab => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	datad => \ALT_INV_Result~62_combout\,
	cin => \Add4~6\,
	sharein => \Add4~7\,
	sumout => \Add4~9_sumout\,
	cout => \Add4~10\,
	shareout => \Add4~11\);

-- Location: LABCELL_X66_Y5_N54
\Result~52\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~52_combout\ = ( \Add4~1_sumout\ & ( (\Add4~9_sumout\ & (\Add4~5_sumout\ & \Add4~69_sumout\)) ) ) # ( !\Add4~1_sumout\ & ( ((\Add4~69_sumout\) # (\Add4~5_sumout\)) # (\Add4~9_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111111111111001111111111111100000000000000110000000000000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~9_sumout\,
	datac => \ALT_INV_Add4~5_sumout\,
	datad => \ALT_INV_Add4~69_sumout\,
	dataf => \ALT_INV_Add4~1_sumout\,
	combout => \Result~52_combout\);

-- Location: FF_X66_Y5_N56
\mv.av[1].sum[-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~52_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-3]~q\);

-- Location: LABCELL_X67_Y5_N45
\Result~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~53_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~73_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~73_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~73_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~53_combout\);

-- Location: FF_X67_Y5_N46
\mv.av[1].sum[-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~53_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-2]~q\);

-- Location: LABCELL_X67_Y5_N57
\Result~54\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~54_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~77_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~77_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~77_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~54_combout\);

-- Location: FF_X67_Y5_N59
\mv.av[1].sum[-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~54_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-1]~q\);

-- Location: LABCELL_X67_Y5_N24
\Result~55\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~55_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~81_sumout\ & \Add4~5_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~5_sumout\) # (\Add4~81_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100000000001111110000000011111111000000111111111100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~81_sumout\,
	datac => \ALT_INV_Add4~5_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~55_combout\);

-- Location: FF_X67_Y5_N26
\mv.av[1].sum[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~55_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum\(0));

-- Location: LABCELL_X67_Y5_N6
\Result~56\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~56_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~85_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~85_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~85_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~56_combout\);

-- Location: FF_X67_Y5_N7
\mv.av[1].sum[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~56_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum\(1));

-- Location: LABCELL_X67_Y5_N15
\Result~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~57_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~5_sumout\ & \Add4~89_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~89_sumout\) # (\Add4~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000010111110000000011111111000001011111111100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~89_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~57_combout\);

-- Location: FF_X67_Y5_N17
\mv.av[1].sum[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~57_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum\(2));

-- Location: LABCELL_X67_Y5_N30
\Result~58\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~58_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~93_sumout\ & \Add4~5_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~5_sumout\) # (\Add4~93_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100000000001111110000000011111111000000111111111100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~93_sumout\,
	datac => \ALT_INV_Add4~5_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~58_combout\);

-- Location: FF_X67_Y5_N31
\mv.av[1].sum[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~58_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum\(3));

-- Location: LABCELL_X66_Y5_N42
\Add4~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~1_sumout\ = SUM(( !\mv.av[1].sum\(4) $ (!\mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ $ (!\Result~62_combout\)) ) + ( \Add4~11\ ) + ( \Add4~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001001011010010110",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum\(4),
	datab => \mv.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	datac => \ALT_INV_Result~62_combout\,
	cin => \Add4~10\,
	sharein => \Add4~11\,
	sumout => \Add4~1_sumout\);

-- Location: FF_X66_Y5_N50
\mv.av[1].sum[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Add4~1_sumout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum\(4));

-- Location: LABCELL_X67_Y5_N48
\Result~39\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~39_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~17_sumout\ & \Add4~5_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~5_sumout\) # (\Add4~17_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100000000001111110000000011111111000000111111111100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~17_sumout\,
	datac => \ALT_INV_Add4~5_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~39_combout\);

-- Location: FF_X67_Y5_N50
\mv.av[1].sum[-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~39_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-17]~q\);

-- Location: LABCELL_X67_Y5_N42
\Result~40\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~40_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~21_sumout\ & \Add4~5_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~5_sumout\) # (\Add4~21_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100000000001111110000000011111111000000111111111100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~21_sumout\,
	datac => \ALT_INV_Add4~5_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~40_combout\);

-- Location: FF_X67_Y5_N43
\mv.av[1].sum[-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~40_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-16]~q\);

-- Location: LABCELL_X67_Y5_N54
\Result~42\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~42_combout\ = ( \Add4~9_sumout\ & ( (!\Add4~1_sumout\) # ((\Add4~29_sumout\ & \Add4~5_sumout\)) ) ) # ( !\Add4~9_sumout\ & ( (!\Add4~1_sumout\ & ((\Add4~5_sumout\) # (\Add4~29_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100000000001111110000000011111111000000111111111100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~29_sumout\,
	datac => \ALT_INV_Add4~5_sumout\,
	datad => \ALT_INV_Add4~1_sumout\,
	dataf => \ALT_INV_Add4~9_sumout\,
	combout => \Result~42_combout\);

-- Location: FF_X67_Y5_N55
\mv.av[1].sum[-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~42_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-15]~q\);

-- Location: LABCELL_X66_Y6_N12
\Result~38\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~38_combout\ = ( \Add4~1_sumout\ & ( (\Add4~13_sumout\ & (\Add4~5_sumout\ & \Add4~9_sumout\)) ) ) # ( !\Add4~1_sumout\ & ( ((\Add4~9_sumout\) # (\Add4~5_sumout\)) # (\Add4~13_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111111111111001111111111111100000000000000110000000000000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add4~13_sumout\,
	datac => \ALT_INV_Add4~5_sumout\,
	datad => \ALT_INV_Add4~9_sumout\,
	dataf => \ALT_INV_Add4~1_sumout\,
	combout => \Result~38_combout\);

-- Location: FF_X66_Y6_N13
\mv.av[1].sum[-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~38_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-14]~q\);

-- Location: FF_X67_Y5_N56
\mv.av[1].sum[-15]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~42_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-15]~DUPLICATE_q\);

-- Location: FF_X67_Y5_N44
\mv.av[1].sum[-16]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~40_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[-16]~DUPLICATE_q\);

-- Location: LABCELL_X67_Y5_N0
\rounds~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rounds~0_combout\ = ( \mv.av[1].sum[-16]~DUPLICATE_q\ & ( \mv.av[1].sum[-14]~q\ ) ) # ( !\mv.av[1].sum[-16]~DUPLICATE_q\ & ( (\mv.av[1].sum[-14]~q\ & (((\mv.av[1].sum[-15]~DUPLICATE_q\) # (\mv.av[1].sum[-17]~q\)) # (\mv.av[1].sum[-13]~q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001010101010101000101010101010101010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-14]~q\,
	datab => \ALT_INV_mv.av[1].sum[-13]~q\,
	datac => \ALT_INV_mv.av[1].sum[-17]~q\,
	datad => \ALT_INV_mv.av[1].sum[-15]~DUPLICATE_q\,
	dataf => \ALT_INV_mv.av[1].sum[-16]~DUPLICATE_q\,
	combout => \rounds~0_combout\);

-- Location: FF_X66_Y5_N49
\mv.av[1].sum[4]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \Add4~1_sumout\,
	clrn => \rst_n~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[4]~DUPLICATE_q\);

-- Location: FF_X67_Y5_N8
\mv.av[1].sum[1]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~56_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.av[1].sum[1]~DUPLICATE_q\);

-- Location: LABCELL_X63_Y5_N0
\Add5~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~41_sumout\ = SUM(( \mv.av[1].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))
-- \Add5~42\ = CARRY(( \mv.av[1].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum[-13]~q\,
	cin => GND,
	sumout => \Add5~41_sumout\,
	cout => \Add5~42\);

-- Location: LABCELL_X63_Y5_N3
\Add5~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~45_sumout\ = SUM(( \mv.av[1].sum[-12]~q\ ) + ( GND ) + ( \Add5~42\ ))
-- \Add5~46\ = CARRY(( \mv.av[1].sum[-12]~q\ ) + ( GND ) + ( \Add5~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[-12]~q\,
	cin => \Add5~42\,
	sumout => \Add5~45_sumout\,
	cout => \Add5~46\);

-- Location: LABCELL_X63_Y5_N6
\Add5~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~37_sumout\ = SUM(( \mv.av[1].sum[-11]~q\ ) + ( GND ) + ( \Add5~46\ ))
-- \Add5~38\ = CARRY(( \mv.av[1].sum[-11]~q\ ) + ( GND ) + ( \Add5~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[-11]~q\,
	cin => \Add5~46\,
	sumout => \Add5~37_sumout\,
	cout => \Add5~38\);

-- Location: LABCELL_X63_Y5_N9
\Add5~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~33_sumout\ = SUM(( \mv.av[1].sum[-10]~q\ ) + ( GND ) + ( \Add5~38\ ))
-- \Add5~34\ = CARRY(( \mv.av[1].sum[-10]~q\ ) + ( GND ) + ( \Add5~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[-10]~q\,
	cin => \Add5~38\,
	sumout => \Add5~33_sumout\,
	cout => \Add5~34\);

-- Location: LABCELL_X63_Y5_N12
\Add5~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~29_sumout\ = SUM(( \mv.av[1].sum[-9]~q\ ) + ( GND ) + ( \Add5~34\ ))
-- \Add5~30\ = CARRY(( \mv.av[1].sum[-9]~q\ ) + ( GND ) + ( \Add5~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[-9]~q\,
	cin => \Add5~34\,
	sumout => \Add5~29_sumout\,
	cout => \Add5~30\);

-- Location: LABCELL_X63_Y5_N15
\Add5~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~25_sumout\ = SUM(( \mv.av[1].sum[-8]~q\ ) + ( GND ) + ( \Add5~30\ ))
-- \Add5~26\ = CARRY(( \mv.av[1].sum[-8]~q\ ) + ( GND ) + ( \Add5~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum[-8]~q\,
	cin => \Add5~30\,
	sumout => \Add5~25_sumout\,
	cout => \Add5~26\);

-- Location: LABCELL_X63_Y5_N18
\Add5~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~69_sumout\ = SUM(( \mv.av[1].sum[-7]~q\ ) + ( GND ) + ( \Add5~26\ ))
-- \Add5~70\ = CARRY(( \mv.av[1].sum[-7]~q\ ) + ( GND ) + ( \Add5~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum[-7]~q\,
	cin => \Add5~26\,
	sumout => \Add5~69_sumout\,
	cout => \Add5~70\);

-- Location: LABCELL_X63_Y5_N21
\Add5~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~73_sumout\ = SUM(( \mv.av[1].sum[-6]~q\ ) + ( GND ) + ( \Add5~70\ ))
-- \Add5~74\ = CARRY(( \mv.av[1].sum[-6]~q\ ) + ( GND ) + ( \Add5~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[-6]~q\,
	cin => \Add5~70\,
	sumout => \Add5~73_sumout\,
	cout => \Add5~74\);

-- Location: LABCELL_X63_Y5_N24
\Add5~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~65_sumout\ = SUM(( \mv.av[1].sum[-5]~q\ ) + ( GND ) + ( \Add5~74\ ))
-- \Add5~66\ = CARRY(( \mv.av[1].sum[-5]~q\ ) + ( GND ) + ( \Add5~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum[-5]~q\,
	cin => \Add5~74\,
	sumout => \Add5~65_sumout\,
	cout => \Add5~66\);

-- Location: LABCELL_X63_Y5_N27
\Add5~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~61_sumout\ = SUM(( \mv.av[1].sum[-4]~q\ ) + ( GND ) + ( \Add5~66\ ))
-- \Add5~62\ = CARRY(( \mv.av[1].sum[-4]~q\ ) + ( GND ) + ( \Add5~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[-4]~q\,
	cin => \Add5~66\,
	sumout => \Add5~61_sumout\,
	cout => \Add5~62\);

-- Location: LABCELL_X63_Y5_N30
\Add5~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~57_sumout\ = SUM(( \mv.av[1].sum[-3]~q\ ) + ( GND ) + ( \Add5~62\ ))
-- \Add5~58\ = CARRY(( \mv.av[1].sum[-3]~q\ ) + ( GND ) + ( \Add5~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[-3]~q\,
	cin => \Add5~62\,
	sumout => \Add5~57_sumout\,
	cout => \Add5~58\);

-- Location: LABCELL_X63_Y5_N33
\Add5~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~21_sumout\ = SUM(( \mv.av[1].sum[-2]~q\ ) + ( GND ) + ( \Add5~58\ ))
-- \Add5~22\ = CARRY(( \mv.av[1].sum[-2]~q\ ) + ( GND ) + ( \Add5~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[-2]~q\,
	cin => \Add5~58\,
	sumout => \Add5~21_sumout\,
	cout => \Add5~22\);

-- Location: LABCELL_X63_Y5_N36
\Add5~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~17_sumout\ = SUM(( \mv.av[1].sum[-1]~q\ ) + ( GND ) + ( \Add5~22\ ))
-- \Add5~18\ = CARRY(( \mv.av[1].sum[-1]~q\ ) + ( GND ) + ( \Add5~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[-1]~q\,
	cin => \Add5~22\,
	sumout => \Add5~17_sumout\,
	cout => \Add5~18\);

-- Location: LABCELL_X63_Y5_N39
\Add5~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~13_sumout\ = SUM(( \mv.av[1].sum\(0) ) + ( GND ) + ( \Add5~18\ ))
-- \Add5~14\ = CARRY(( \mv.av[1].sum\(0) ) + ( GND ) + ( \Add5~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum\(0),
	cin => \Add5~18\,
	sumout => \Add5~13_sumout\,
	cout => \Add5~14\);

-- Location: LABCELL_X63_Y5_N42
\Add5~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~9_sumout\ = SUM(( \mv.av[1].sum[1]~DUPLICATE_q\ ) + ( GND ) + ( \Add5~14\ ))
-- \Add5~10\ = CARRY(( \mv.av[1].sum[1]~DUPLICATE_q\ ) + ( GND ) + ( \Add5~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[1]~DUPLICATE_q\,
	cin => \Add5~14\,
	sumout => \Add5~9_sumout\,
	cout => \Add5~10\);

-- Location: LABCELL_X63_Y5_N45
\Add5~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~53_sumout\ = SUM(( \mv.av[1].sum\(2) ) + ( GND ) + ( \Add5~10\ ))
-- \Add5~54\ = CARRY(( \mv.av[1].sum\(2) ) + ( GND ) + ( \Add5~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum\(2),
	cin => \Add5~10\,
	sumout => \Add5~53_sumout\,
	cout => \Add5~54\);

-- Location: LABCELL_X63_Y5_N48
\Add5~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~5_sumout\ = SUM(( \mv.av[1].sum\(3) ) + ( GND ) + ( \Add5~54\ ))
-- \Add5~6\ = CARRY(( \mv.av[1].sum\(3) ) + ( GND ) + ( \Add5~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum\(3),
	cin => \Add5~54\,
	sumout => \Add5~5_sumout\,
	cout => \Add5~6\);

-- Location: LABCELL_X63_Y5_N51
\Add5~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~1_sumout\ = SUM(( \mv.av[1].sum[4]~DUPLICATE_q\ ) + ( GND ) + ( \Add5~6\ ))
-- \Add5~2\ = CARRY(( \mv.av[1].sum[4]~DUPLICATE_q\ ) + ( GND ) + ( \Add5~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	cin => \Add5~6\,
	sumout => \Add5~1_sumout\,
	cout => \Add5~2\);

-- Location: LABCELL_X62_Y5_N36
\Result~19\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~19_combout\ = ( !\Add5~73_sumout\ & ( !\Add5~53_sumout\ & ( (!\Add5~61_sumout\ & (!\Add5~69_sumout\ & (!\Add5~57_sumout\ & !\Add5~65_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add5~61_sumout\,
	datab => \ALT_INV_Add5~69_sumout\,
	datac => \ALT_INV_Add5~57_sumout\,
	datad => \ALT_INV_Add5~65_sumout\,
	datae => \ALT_INV_Add5~73_sumout\,
	dataf => \ALT_INV_Add5~53_sumout\,
	combout => \Result~19_combout\);

-- Location: LABCELL_X63_Y5_N54
\Add5~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~49_sumout\ = SUM(( \mv.av[1].sum[4]~DUPLICATE_q\ ) + ( GND ) + ( \Add5~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	cin => \Add5~2\,
	sumout => \Add5~49_sumout\);

-- Location: LABCELL_X62_Y5_N12
\Result~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~17_combout\ = ( !\Add5~45_sumout\ & ( (!\Add5~33_sumout\ & (!\Add5~29_sumout\ & (!\Add5~41_sumout\ & !\Add5~37_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000100000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add5~33_sumout\,
	datab => \ALT_INV_Add5~29_sumout\,
	datac => \ALT_INV_Add5~41_sumout\,
	datad => \ALT_INV_Add5~37_sumout\,
	dataf => \ALT_INV_Add5~45_sumout\,
	combout => \Result~17_combout\);

-- Location: LABCELL_X62_Y5_N42
\Result~18\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~18_combout\ = ( !\Add5~9_sumout\ & ( !\Add5~13_sumout\ & ( (!\Add5~21_sumout\ & (\Result~17_combout\ & (!\Add5~25_sumout\ & !\Add5~17_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add5~21_sumout\,
	datab => \ALT_INV_Result~17_combout\,
	datac => \ALT_INV_Add5~25_sumout\,
	datad => \ALT_INV_Add5~17_sumout\,
	datae => \ALT_INV_Add5~9_sumout\,
	dataf => \ALT_INV_Add5~13_sumout\,
	combout => \Result~18_combout\);

-- Location: LABCELL_X62_Y5_N30
\Result~20\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~20_combout\ = ( \Result~18_combout\ & ( (!\Result~19_combout\) # (((\Add5~5_sumout\) # (\Add5~1_sumout\)) # (\Add5~49_sumout\)) ) ) # ( !\Result~18_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111110111111111111111011111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Result~19_combout\,
	datab => \ALT_INV_Add5~49_sumout\,
	datac => \ALT_INV_Add5~1_sumout\,
	datad => \ALT_INV_Add5~5_sumout\,
	dataf => \ALT_INV_Result~18_combout\,
	combout => \Result~20_combout\);

-- Location: LABCELL_X62_Y5_N24
\overflowx~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \overflowx~0_combout\ = ( \Add5~5_sumout\ & ( \Result~18_combout\ & ( !\Add5~1_sumout\ $ (!\mv.av[1].sum[4]~DUPLICATE_q\) ) ) ) # ( !\Add5~5_sumout\ & ( \Result~18_combout\ & ( (!\Add5~1_sumout\ & (\mv.av[1].sum[4]~DUPLICATE_q\ & ((!\Result~19_combout\) # 
-- (\Add5~49_sumout\)))) # (\Add5~1_sumout\ & (!\mv.av[1].sum[4]~DUPLICATE_q\)) ) ) ) # ( \Add5~5_sumout\ & ( !\Result~18_combout\ & ( !\Add5~1_sumout\ $ (!\mv.av[1].sum[4]~DUPLICATE_q\) ) ) ) # ( !\Add5~5_sumout\ & ( !\Result~18_combout\ & ( 
-- !\Add5~1_sumout\ $ (!\mv.av[1].sum[4]~DUPLICATE_q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100100011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add5~1_sumout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_Result~19_combout\,
	datad => \ALT_INV_Add5~49_sumout\,
	datae => \ALT_INV_Add5~5_sumout\,
	dataf => \ALT_INV_Result~18_combout\,
	combout => \overflowx~0_combout\);

-- Location: LABCELL_X62_Y5_N18
\Result~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~37_combout\ = ( \mv.av[1].sum\(3) & ( (!\rounds~0_combout\) # (\Add5~5_sumout\) ) ) # ( !\mv.av[1].sum\(3) & ( (\rounds~0_combout\ & \Add5~5_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001111001100111111111100110011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~0_combout\,
	datad => \ALT_INV_Add5~5_sumout\,
	dataf => \ALT_INV_mv.av[1].sum\(3),
	combout => \Result~37_combout\);

-- Location: LABCELL_X62_Y5_N15
\Result~36\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~36_combout\ = ( \Add5~53_sumout\ & ( (\mv.av[1].sum\(2)) # (\rounds~0_combout\) ) ) # ( !\Add5~53_sumout\ & ( (!\rounds~0_combout\ & \mv.av[1].sum\(2)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011110000000000001111000000001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_rounds~0_combout\,
	datad => \ALT_INV_mv.av[1].sum\(2),
	dataf => \ALT_INV_Add5~53_sumout\,
	combout => \Result~36_combout\);

-- Location: LABCELL_X62_Y5_N6
\Result~35\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~35_combout\ = ( \Add5~9_sumout\ & ( \rounds~0_combout\ ) ) # ( \Add5~9_sumout\ & ( !\rounds~0_combout\ & ( \mv.av[1].sum[1]~DUPLICATE_q\ ) ) ) # ( !\Add5~9_sumout\ & ( !\rounds~0_combout\ & ( \mv.av[1].sum[1]~DUPLICATE_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum[1]~DUPLICATE_q\,
	datae => \ALT_INV_Add5~9_sumout\,
	dataf => \ALT_INV_rounds~0_combout\,
	combout => \Result~35_combout\);

-- Location: LABCELL_X62_Y5_N48
\Result~34\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~34_combout\ = ( \Add5~13_sumout\ & ( (\mv.av[1].sum\(0)) # (\rounds~0_combout\) ) ) # ( !\Add5~13_sumout\ & ( (!\rounds~0_combout\ & \mv.av[1].sum\(0)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.av[1].sum\(0),
	dataf => \ALT_INV_Add5~13_sumout\,
	combout => \Result~34_combout\);

-- Location: LABCELL_X62_Y5_N51
\Result~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~33_combout\ = ( \mv.av[1].sum[-1]~q\ & ( (!\rounds~0_combout\) # (\Add5~17_sumout\) ) ) # ( !\mv.av[1].sum[-1]~q\ & ( (\rounds~0_combout\ & \Add5~17_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001100000011000000110000001111001111110011111100111111001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_Add5~17_sumout\,
	dataf => \ALT_INV_mv.av[1].sum[-1]~q\,
	combout => \Result~33_combout\);

-- Location: LABCELL_X62_Y5_N0
\Result~32\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~32_combout\ = ( \Add5~21_sumout\ & ( (\mv.av[1].sum[-2]~q\) # (\rounds~0_combout\) ) ) # ( !\Add5~21_sumout\ & ( (!\rounds~0_combout\ & \mv.av[1].sum[-2]~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.av[1].sum[-2]~q\,
	dataf => \ALT_INV_Add5~21_sumout\,
	combout => \Result~32_combout\);

-- Location: LABCELL_X62_Y5_N21
\Result~31\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~31_combout\ = ( \Add5~57_sumout\ & ( (\mv.av[1].sum[-3]~q\) # (\rounds~0_combout\) ) ) # ( !\Add5~57_sumout\ & ( (!\rounds~0_combout\ & \mv.av[1].sum[-3]~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.av[1].sum[-3]~q\,
	dataf => \ALT_INV_Add5~57_sumout\,
	combout => \Result~31_combout\);

-- Location: LABCELL_X60_Y5_N6
\Result~30\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~30_combout\ = ( \Add5~61_sumout\ & ( (\mv.av[1].sum[-4]~q\) # (\rounds~0_combout\) ) ) # ( !\Add5~61_sumout\ & ( (!\rounds~0_combout\ & \mv.av[1].sum[-4]~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011001100000000001100110000110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~0_combout\,
	datad => \ALT_INV_mv.av[1].sum[-4]~q\,
	dataf => \ALT_INV_Add5~61_sumout\,
	combout => \Result~30_combout\);

-- Location: LABCELL_X62_Y5_N3
\Result~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~29_combout\ = ( \Add5~65_sumout\ & ( (\rounds~0_combout\) # (\mv.av[1].sum[-5]~q\) ) ) # ( !\Add5~65_sumout\ & ( (\mv.av[1].sum[-5]~q\ & !\rounds~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010001000100010001000100010001110111011101110111011101110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-5]~q\,
	datab => \ALT_INV_rounds~0_combout\,
	dataf => \ALT_INV_Add5~65_sumout\,
	combout => \Result~29_combout\);

-- Location: LABCELL_X62_Y5_N33
\Result~28\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~28_combout\ = ( \rounds~0_combout\ & ( \Add5~73_sumout\ ) ) # ( !\rounds~0_combout\ & ( \mv.av[1].sum[-6]~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100000000111111110000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum[-6]~q\,
	datad => \ALT_INV_Add5~73_sumout\,
	dataf => \ALT_INV_rounds~0_combout\,
	combout => \Result~28_combout\);

-- Location: LABCELL_X62_Y5_N54
\Result~27\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~27_combout\ = ( \Add5~69_sumout\ & ( (\mv.av[1].sum[-7]~q\) # (\rounds~0_combout\) ) ) # ( !\Add5~69_sumout\ & ( (!\rounds~0_combout\ & \mv.av[1].sum[-7]~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.av[1].sum[-7]~q\,
	dataf => \ALT_INV_Add5~69_sumout\,
	combout => \Result~27_combout\);

-- Location: LABCELL_X62_Y5_N57
\Result~26\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~26_combout\ = ( \rounds~0_combout\ & ( \Add5~25_sumout\ ) ) # ( !\rounds~0_combout\ & ( \mv.av[1].sum[-8]~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010100000000111111110000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-8]~q\,
	datad => \ALT_INV_Add5~25_sumout\,
	dataf => \ALT_INV_rounds~0_combout\,
	combout => \Result~26_combout\);

-- Location: LABCELL_X68_Y5_N3
\Result~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~25_combout\ = ( \Add5~29_sumout\ & ( (\rounds~0_combout\) # (\mv.av[1].sum[-9]~q\) ) ) # ( !\Add5~29_sumout\ & ( (\mv.av[1].sum[-9]~q\ & !\rounds~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000001010000010100000101000001011111010111110101111101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-9]~q\,
	datac => \ALT_INV_rounds~0_combout\,
	dataf => \ALT_INV_Add5~29_sumout\,
	combout => \Result~25_combout\);

-- Location: LABCELL_X61_Y4_N39
\Result~24\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~24_combout\ = ( \rounds~0_combout\ & ( \Add5~33_sumout\ ) ) # ( !\rounds~0_combout\ & ( \Add5~33_sumout\ & ( \mv.av[1].sum[-10]~q\ ) ) ) # ( !\rounds~0_combout\ & ( !\Add5~33_sumout\ & ( \mv.av[1].sum[-10]~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000000000000000000001111000011111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum[-10]~q\,
	datae => \ALT_INV_rounds~0_combout\,
	dataf => \ALT_INV_Add5~33_sumout\,
	combout => \Result~24_combout\);

-- Location: LABCELL_X61_Y4_N21
\Result~23\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~23_combout\ = ( \rounds~0_combout\ & ( \Add5~37_sumout\ ) ) # ( !\rounds~0_combout\ & ( \Add5~37_sumout\ & ( \mv.av[1].sum[-11]~q\ ) ) ) # ( !\rounds~0_combout\ & ( !\Add5~37_sumout\ & ( \mv.av[1].sum[-11]~q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000000000000000000001111000011111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_mv.av[1].sum[-11]~q\,
	datae => \ALT_INV_rounds~0_combout\,
	dataf => \ALT_INV_Add5~37_sumout\,
	combout => \Result~23_combout\);

-- Location: LABCELL_X61_Y4_N24
\Result~22\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~22_combout\ = ( \mv.av[1].sum[-12]~q\ & ( \Add5~45_sumout\ ) ) # ( !\mv.av[1].sum[-12]~q\ & ( \Add5~45_sumout\ & ( \rounds~0_combout\ ) ) ) # ( \mv.av[1].sum[-12]~q\ & ( !\Add5~45_sumout\ & ( !\rounds~0_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000000001111000011111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_rounds~0_combout\,
	datae => \ALT_INV_mv.av[1].sum[-12]~q\,
	dataf => \ALT_INV_Add5~45_sumout\,
	combout => \Result~22_combout\);

-- Location: LABCELL_X67_Y5_N3
\Result~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~21_combout\ = ( \Add5~41_sumout\ & ( ((!\mv.av[1].sum[-14]~q\ & \mv.av[1].sum[-13]~q\)) # (\rounds~0_combout\) ) ) # ( !\Add5~41_sumout\ & ( (!\mv.av[1].sum[-14]~q\ & \mv.av[1].sum[-13]~q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001000100010001000100010001000100010111111110010001011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.av[1].sum[-14]~q\,
	datab => \ALT_INV_mv.av[1].sum[-13]~q\,
	datad => \ALT_INV_rounds~0_combout\,
	dataf => \ALT_INV_Add5~41_sumout\,
	combout => \Result~21_combout\);

-- Location: LABCELL_X61_Y5_N0
\Add6~78\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~78_cout\ = CARRY(( VCC ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => GND,
	cout => \Add6~78_cout\);

-- Location: LABCELL_X61_Y5_N3
\Add6~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~9_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~21_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~21_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17\ ) + ( \Add6~78_cout\ ))
-- \Add6~10\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~21_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~21_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17\ ) + ( \Add6~78_cout\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111000010110001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_Result~21_combout\,
	datad => \ALT_INV_overflowx~0_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a17\,
	cin => \Add6~78_cout\,
	sumout => \Add6~9_sumout\,
	cout => \Add6~10\);

-- Location: LABCELL_X61_Y5_N6
\Add6~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~13_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~22_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~22_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16\ ) + ( \Add6~10\ ))
-- \Add6~14\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~22_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~22_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16\ ) + ( \Add6~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~22_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a16\,
	cin => \Add6~10\,
	sumout => \Add6~13_sumout\,
	cout => \Add6~14\);

-- Location: LABCELL_X61_Y5_N9
\Add6~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~17_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~23_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~23_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15\ ) + ( \Add6~14\ ))
-- \Add6~18\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~23_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~23_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15\ ) + ( \Add6~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~23_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a15\,
	cin => \Add6~14\,
	sumout => \Add6~17_sumout\,
	cout => \Add6~18\);

-- Location: LABCELL_X61_Y5_N12
\Add6~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~21_sumout\ = SUM(( \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14\ ) + ( (!\rounds~0_combout\ & (((!\Result~24_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~24_combout\))) # (\overflowx~0_combout\ & 
-- (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( \Add6~18\ ))
-- \Add6~22\ = CARRY(( \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14\ ) + ( (!\rounds~0_combout\ & (((!\Result~24_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~24_combout\))) # (\overflowx~0_combout\ & 
-- (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( \Add6~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000001001111111000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a14\,
	dataf => \ALT_INV_Result~24_combout\,
	cin => \Add6~18\,
	sumout => \Add6~21_sumout\,
	cout => \Add6~22\);

-- Location: LABCELL_X61_Y5_N15
\Add6~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~25_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~25_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~25_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13\ ) + ( \Add6~22\ ))
-- \Add6~26\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~25_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~25_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13\ ) + ( \Add6~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~25_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a13\,
	cin => \Add6~22\,
	sumout => \Add6~25_sumout\,
	cout => \Add6~26\);

-- Location: LABCELL_X61_Y5_N18
\Add6~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~29_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~26_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~26_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12\ ) + ( \Add6~26\ ))
-- \Add6~30\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~26_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~26_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12\ ) + ( \Add6~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~26_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a12\,
	cin => \Add6~26\,
	sumout => \Add6~29_sumout\,
	cout => \Add6~30\);

-- Location: LABCELL_X61_Y5_N21
\Add6~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~33_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~27_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~27_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11\ ) + ( \Add6~30\ ))
-- \Add6~34\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~27_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~27_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11\ ) + ( \Add6~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~27_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a11\,
	cin => \Add6~30\,
	sumout => \Add6~33_sumout\,
	cout => \Add6~34\);

-- Location: LABCELL_X61_Y5_N24
\Add6~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~37_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~28_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~28_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10\ ) + ( \Add6~34\ ))
-- \Add6~38\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~28_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~28_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10\ ) + ( \Add6~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~28_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a10\,
	cin => \Add6~34\,
	sumout => \Add6~37_sumout\,
	cout => \Add6~38\);

-- Location: LABCELL_X61_Y5_N27
\Add6~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~41_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~29_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~29_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9\ ) + ( \Add6~38\ ))
-- \Add6~42\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~29_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~29_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9\ ) + ( \Add6~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~29_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a9\,
	cin => \Add6~38\,
	sumout => \Add6~41_sumout\,
	cout => \Add6~42\);

-- Location: LABCELL_X61_Y5_N30
\Add6~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~45_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~30_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~30_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8\ ) + ( \Add6~42\ ))
-- \Add6~46\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~30_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~30_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8\ ) + ( \Add6~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~30_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a8\,
	cin => \Add6~42\,
	sumout => \Add6~45_sumout\,
	cout => \Add6~46\);

-- Location: LABCELL_X61_Y5_N33
\Add6~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~49_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~31_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~31_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7\ ) + ( \Add6~46\ ))
-- \Add6~50\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~31_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~31_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7\ ) + ( \Add6~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~31_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a7\,
	cin => \Add6~46\,
	sumout => \Add6~49_sumout\,
	cout => \Add6~50\);

-- Location: LABCELL_X61_Y5_N36
\Add6~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~53_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~32_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~32_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6\ ) + ( \Add6~50\ ))
-- \Add6~54\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~32_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~32_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6\ ) + ( \Add6~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~32_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a6\,
	cin => \Add6~50\,
	sumout => \Add6~53_sumout\,
	cout => \Add6~54\);

-- Location: LABCELL_X61_Y5_N39
\Add6~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~57_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~33_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~33_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5\ ) + ( \Add6~54\ ))
-- \Add6~58\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~33_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~33_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5\ ) + ( \Add6~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~33_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a5\,
	cin => \Add6~54\,
	sumout => \Add6~57_sumout\,
	cout => \Add6~58\);

-- Location: LABCELL_X61_Y5_N42
\Add6~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~61_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~34_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~34_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4\ ) + ( \Add6~58\ ))
-- \Add6~62\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~34_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~34_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4\ ) + ( \Add6~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~34_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a4\,
	cin => \Add6~58\,
	sumout => \Add6~61_sumout\,
	cout => \Add6~62\);

-- Location: LABCELL_X61_Y5_N45
\Add6~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~65_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~35_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~35_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3\ ) + ( \Add6~62\ ))
-- \Add6~66\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~35_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~35_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3\ ) + ( \Add6~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~35_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a3\,
	cin => \Add6~62\,
	sumout => \Add6~65_sumout\,
	cout => \Add6~66\);

-- Location: LABCELL_X61_Y5_N48
\Add6~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~69_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~36_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~36_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2\ ) + ( \Add6~66\ ))
-- \Add6~70\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~36_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~36_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2\ ) + ( \Add6~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~36_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a2\,
	cin => \Add6~66\,
	sumout => \Add6~69_sumout\,
	cout => \Add6~70\);

-- Location: LABCELL_X61_Y5_N51
\Add6~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~73_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\Result~37_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~37_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1\ ) + ( \Add6~70\ ))
-- \Add6~74\ = CARRY(( (!\rounds~0_combout\ & (((!\Result~37_combout\)))) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & ((!\Result~37_combout\))) # (\overflowx~0_combout\ & (\mv.av[1].sum[4]~DUPLICATE_q\)))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1\ ) + ( \Add6~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001111101100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datac => \ALT_INV_overflowx~0_combout\,
	datad => \ALT_INV_Result~37_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a1\,
	cin => \Add6~70\,
	sumout => \Add6~73_sumout\,
	cout => \Add6~74\);

-- Location: LABCELL_X61_Y5_N54
\Add6~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~1_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\mv.av[1].sum[4]~DUPLICATE_q\)))) # (\rounds~0_combout\ & ((!\Result~20_combout\ & (!\Add5~1_sumout\)) # (\Result~20_combout\ & ((!\mv.av[1].sum[4]~DUPLICATE_q\))))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ ) + ( \Add6~74\ ))
-- \Add6~2\ = CARRY(( (!\rounds~0_combout\ & (((!\mv.av[1].sum[4]~DUPLICATE_q\)))) # (\rounds~0_combout\ & ((!\Result~20_combout\ & (!\Add5~1_sumout\)) # (\Result~20_combout\ & ((!\mv.av[1].sum[4]~DUPLICATE_q\))))) ) + ( 
-- \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ ) + ( \Add6~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110010011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_Add5~1_sumout\,
	datac => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datad => \ALT_INV_Result~20_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	cin => \Add6~74\,
	sumout => \Add6~1_sumout\,
	cout => \Add6~2\);

-- Location: LABCELL_X61_Y5_N57
\Add6~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~5_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\mv.av[1].sum[4]~DUPLICATE_q\)))) # (\rounds~0_combout\ & ((!\Result~20_combout\ & (!\Add5~1_sumout\)) # (\Result~20_combout\ & ((!\mv.av[1].sum[4]~DUPLICATE_q\))))) ) + ( 
-- !\mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ ) + ( \Add6~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000001111111100000000000000001110010011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_Add5~1_sumout\,
	datac => \ALT_INV_mv.av[1].sum[4]~DUPLICATE_q\,
	datad => \ALT_INV_Result~20_combout\,
	dataf => \mv.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	cin => \Add6~2\,
	sumout => \Add6~5_sumout\);

-- Location: LABCELL_X60_Y5_N3
\Result~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~0_combout\ = ( \Add6~5_sumout\ & ( (\Add6~9_sumout\) # (\Add6~1_sumout\) ) ) # ( !\Add6~5_sumout\ & ( (\Add6~1_sumout\ & \Add6~9_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111100001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Add6~1_sumout\,
	datad => \ALT_INV_Add6~9_sumout\,
	dataf => \ALT_INV_Add6~5_sumout\,
	combout => \Result~0_combout\);

-- Location: FF_X60_Y5_N5
\y[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~0_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[0]~reg0_q\);

-- Location: LABCELL_X60_Y5_N54
\Result~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~1_combout\ = ( \Add6~1_sumout\ & ( (\Add6~13_sumout\) # (\Add6~5_sumout\) ) ) # ( !\Add6~1_sumout\ & ( (\Add6~5_sumout\ & \Add6~13_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001100110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add6~5_sumout\,
	datad => \ALT_INV_Add6~13_sumout\,
	dataf => \ALT_INV_Add6~1_sumout\,
	combout => \Result~1_combout\);

-- Location: FF_X60_Y5_N55
\y[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~1_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[1]~reg0_q\);

-- Location: LABCELL_X60_Y5_N24
\Result~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~2_combout\ = ( \Add6~1_sumout\ & ( (\Add6~17_sumout\) # (\Add6~5_sumout\) ) ) # ( !\Add6~1_sumout\ & ( (\Add6~5_sumout\ & \Add6~17_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001100110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add6~5_sumout\,
	datad => \ALT_INV_Add6~17_sumout\,
	dataf => \ALT_INV_Add6~1_sumout\,
	combout => \Result~2_combout\);

-- Location: FF_X60_Y5_N26
\y[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~2_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[2]~reg0_q\);

-- Location: LABCELL_X60_Y5_N27
\Result~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~3_combout\ = ( \Add6~21_sumout\ & ( (\Add6~1_sumout\) # (\Add6~5_sumout\) ) ) # ( !\Add6~21_sumout\ & ( (\Add6~5_sumout\ & \Add6~1_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111100001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Add6~5_sumout\,
	datad => \ALT_INV_Add6~1_sumout\,
	dataf => \ALT_INV_Add6~21_sumout\,
	combout => \Result~3_combout\);

-- Location: FF_X60_Y5_N28
\y[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~3_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[3]~reg0_q\);

-- Location: LABCELL_X60_Y5_N9
\Result~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~4_combout\ = (!\Add6~25_sumout\ & (\Add6~5_sumout\ & \Add6~1_sumout\)) # (\Add6~25_sumout\ & ((\Add6~1_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010101011111000001010101111100000101010111110000010101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~25_sumout\,
	datac => \ALT_INV_Add6~5_sumout\,
	datad => \ALT_INV_Add6~1_sumout\,
	combout => \Result~4_combout\);

-- Location: FF_X60_Y5_N10
\y[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~4_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[4]~reg0_q\);

-- Location: LABCELL_X60_Y5_N57
\Result~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~5_combout\ = ( \Add6~29_sumout\ & ( (\Add6~1_sumout\) # (\Add6~5_sumout\) ) ) # ( !\Add6~29_sumout\ & ( (\Add6~5_sumout\ & \Add6~1_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111100001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Add6~5_sumout\,
	datad => \ALT_INV_Add6~1_sumout\,
	dataf => \ALT_INV_Add6~29_sumout\,
	combout => \Result~5_combout\);

-- Location: FF_X60_Y5_N58
\y[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~5_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[5]~reg0_q\);

-- Location: LABCELL_X60_Y5_N48
\Result~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~6_combout\ = ( \Add6~1_sumout\ & ( \Add6~5_sumout\ ) ) # ( !\Add6~1_sumout\ & ( \Add6~5_sumout\ & ( \Add6~33_sumout\ ) ) ) # ( \Add6~1_sumout\ & ( !\Add6~5_sumout\ & ( \Add6~33_sumout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011110000111100001111000011111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Add6~33_sumout\,
	datae => \ALT_INV_Add6~1_sumout\,
	dataf => \ALT_INV_Add6~5_sumout\,
	combout => \Result~6_combout\);

-- Location: FF_X60_Y5_N49
\y[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~6_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[6]~reg0_q\);

-- Location: LABCELL_X60_Y5_N42
\Result~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~7_combout\ = ( \Add6~37_sumout\ & ( (\Add6~5_sumout\) # (\Add6~1_sumout\) ) ) # ( !\Add6~37_sumout\ & ( (\Add6~1_sumout\ & \Add6~5_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001100110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add6~1_sumout\,
	datad => \ALT_INV_Add6~5_sumout\,
	dataf => \ALT_INV_Add6~37_sumout\,
	combout => \Result~7_combout\);

-- Location: FF_X60_Y5_N43
\y[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~7_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[7]~reg0_q\);

-- Location: LABCELL_X60_Y5_N12
\Result~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~8_combout\ = ( \Add6~1_sumout\ & ( (\Add6~41_sumout\) # (\Add6~5_sumout\) ) ) # ( !\Add6~1_sumout\ & ( (\Add6~5_sumout\ & \Add6~41_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001100110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add6~5_sumout\,
	datad => \ALT_INV_Add6~41_sumout\,
	dataf => \ALT_INV_Add6~1_sumout\,
	combout => \Result~8_combout\);

-- Location: FF_X60_Y5_N13
\y[8]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~8_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[8]~reg0_q\);

-- Location: LABCELL_X60_Y5_N18
\Result~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~9_combout\ = ( \Add6~45_sumout\ & ( (\Add6~1_sumout\) # (\Add6~5_sumout\) ) ) # ( !\Add6~45_sumout\ & ( (\Add6~5_sumout\ & \Add6~1_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001100110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add6~5_sumout\,
	datad => \ALT_INV_Add6~1_sumout\,
	dataf => \ALT_INV_Add6~45_sumout\,
	combout => \Result~9_combout\);

-- Location: FF_X60_Y5_N19
\y[9]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~9_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[9]~reg0_q\);

-- Location: LABCELL_X60_Y5_N15
\Result~10\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~10_combout\ = ( \Add6~49_sumout\ & ( (\Add6~1_sumout\) # (\Add6~5_sumout\) ) ) # ( !\Add6~49_sumout\ & ( (\Add6~5_sumout\ & \Add6~1_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111100001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Add6~5_sumout\,
	datad => \ALT_INV_Add6~1_sumout\,
	dataf => \ALT_INV_Add6~49_sumout\,
	combout => \Result~10_combout\);

-- Location: FF_X60_Y5_N17
\y[10]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~10_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[10]~reg0_q\);

-- Location: LABCELL_X60_Y5_N45
\Result~11\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~11_combout\ = ( \Add6~5_sumout\ & ( (\Add6~53_sumout\) # (\Add6~1_sumout\) ) ) # ( !\Add6~5_sumout\ & ( (\Add6~1_sumout\ & \Add6~53_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111100001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Add6~1_sumout\,
	datad => \ALT_INV_Add6~53_sumout\,
	dataf => \ALT_INV_Add6~5_sumout\,
	combout => \Result~11_combout\);

-- Location: FF_X60_Y5_N46
\y[11]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~11_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[11]~reg0_q\);

-- Location: LABCELL_X60_Y5_N36
\Result~12\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~12_combout\ = ( \Add6~57_sumout\ & ( (\Add6~5_sumout\) # (\Add6~1_sumout\) ) ) # ( !\Add6~57_sumout\ & ( (\Add6~1_sumout\ & \Add6~5_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001100110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add6~1_sumout\,
	datad => \ALT_INV_Add6~5_sumout\,
	dataf => \ALT_INV_Add6~57_sumout\,
	combout => \Result~12_combout\);

-- Location: FF_X60_Y5_N38
\y[12]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~12_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[12]~reg0_q\);

-- Location: LABCELL_X60_Y5_N39
\Result~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~13_combout\ = ( \Add6~61_sumout\ & ( (\Add6~5_sumout\) # (\Add6~1_sumout\) ) ) # ( !\Add6~61_sumout\ & ( (\Add6~1_sumout\ & \Add6~5_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111100001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Add6~1_sumout\,
	datad => \ALT_INV_Add6~5_sumout\,
	dataf => \ALT_INV_Add6~61_sumout\,
	combout => \Result~13_combout\);

-- Location: FF_X60_Y5_N40
\y[13]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~13_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[13]~reg0_q\);

-- Location: LABCELL_X60_Y5_N30
\Result~14\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~14_combout\ = ( \Add6~65_sumout\ & ( (\Add6~5_sumout\) # (\Add6~1_sumout\) ) ) # ( !\Add6~65_sumout\ & ( (\Add6~1_sumout\ & \Add6~5_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001100110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add6~1_sumout\,
	datad => \ALT_INV_Add6~5_sumout\,
	dataf => \ALT_INV_Add6~65_sumout\,
	combout => \Result~14_combout\);

-- Location: FF_X60_Y5_N32
\y[14]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~14_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[14]~reg0_q\);

-- Location: LABCELL_X60_Y5_N0
\Result~15\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~15_combout\ = ( \Add6~69_sumout\ & ( (\Add6~5_sumout\) # (\Add6~1_sumout\) ) ) # ( !\Add6~69_sumout\ & ( (\Add6~1_sumout\ & \Add6~5_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001100110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Add6~1_sumout\,
	datad => \ALT_INV_Add6~5_sumout\,
	dataf => \ALT_INV_Add6~69_sumout\,
	combout => \Result~15_combout\);

-- Location: FF_X60_Y5_N1
\y[15]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~15_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[15]~reg0_q\);

-- Location: LABCELL_X60_Y5_N33
\Result~16\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~16_combout\ = ( \Add6~73_sumout\ & ( (\Add6~5_sumout\) # (\Add6~1_sumout\) ) ) # ( !\Add6~73_sumout\ & ( (\Add6~1_sumout\ & \Add6~5_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111100001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Add6~1_sumout\,
	datad => \ALT_INV_Add6~5_sumout\,
	dataf => \ALT_INV_Add6~73_sumout\,
	combout => \Result~16_combout\);

-- Location: FF_X60_Y5_N35
\y[16]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Result~16_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[16]~reg0_q\);

-- Location: LABCELL_X60_Y5_N21
\y[17]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \y[17]~0_combout\ = ( !\Add6~5_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add6~5_sumout\,
	combout => \y[17]~0_combout\);

-- Location: FF_X60_Y5_N22
\y[17]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \y[17]~0_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[17]~reg0_q\);

-- Location: LABCELL_X79_Y34_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


