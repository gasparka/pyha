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

-- DATE "06/24/2016 16:43:46"

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
	y : BUFFER std_logic_vector(17 DOWNTO 0)
	);
END top;

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
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \y[0]~output_o\ : std_logic;
SIGNAL \y[1]~output_o\ : std_logic;
SIGNAL \y[2]~output_o\ : std_logic;
SIGNAL \y[3]~output_o\ : std_logic;
SIGNAL \y[4]~output_o\ : std_logic;
SIGNAL \y[5]~output_o\ : std_logic;
SIGNAL \y[6]~output_o\ : std_logic;
SIGNAL \y[7]~output_o\ : std_logic;
SIGNAL \y[8]~output_o\ : std_logic;
SIGNAL \y[9]~output_o\ : std_logic;
SIGNAL \y[10]~output_o\ : std_logic;
SIGNAL \y[11]~output_o\ : std_logic;
SIGNAL \y[12]~output_o\ : std_logic;
SIGNAL \y[13]~output_o\ : std_logic;
SIGNAL \y[14]~output_o\ : std_logic;
SIGNAL \y[15]~output_o\ : std_logic;
SIGNAL \y[16]~output_o\ : std_logic;
SIGNAL \y[17]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~0_combout\ : std_logic;
SIGNAL \rst_n~input_o\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|dffe7~0_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|dffe7~q\ : std_logic;
SIGNAL \x[17]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][0]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|op_2~0_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|op_1~1_sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|op_1~2\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|op_1~5_sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|op_1~6\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|op_1~9_sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|op_1~10\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|op_1~13_sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ : std_logic;
SIGNAL \Add0~7\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \x[16]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-1]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\ : std_logic;
SIGNAL \x[15]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-2]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\ : std_logic;
SIGNAL \x[14]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-3]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\ : std_logic;
SIGNAL \x[13]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-4]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\ : std_logic;
SIGNAL \x[12]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-5]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\ : std_logic;
SIGNAL \x[11]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-6]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\ : std_logic;
SIGNAL \x[10]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-7]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\ : std_logic;
SIGNAL \x[9]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-8]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\ : std_logic;
SIGNAL \x[8]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-9]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\ : std_logic;
SIGNAL \x[7]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-10]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\ : std_logic;
SIGNAL \x[6]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-11]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\ : std_logic;
SIGNAL \x[5]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-12]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\ : std_logic;
SIGNAL \x[4]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-13]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\ : std_logic;
SIGNAL \x[3]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-14]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\ : std_logic;
SIGNAL \x[2]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-15]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\ : std_logic;
SIGNAL \x[1]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-16]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\ : std_logic;
SIGNAL \x[0]~input_o\ : std_logic;
SIGNAL \mv.in_sr[0][-17]~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\ : std_logic;
SIGNAL \Add0~98_cout\ : std_logic;
SIGNAL \Add0~99\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \Result~44_combout\ : std_logic;
SIGNAL \mv.sum[-17]~q\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~31\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Result~43_combout\ : std_logic;
SIGNAL \mv.sum[-16]~q\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~27\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \Result~42_combout\ : std_logic;
SIGNAL \mv.sum[-15]~q\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~23\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \Result~41_combout\ : std_logic;
SIGNAL \mv.sum[-14]~q\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~19\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \Result~40_combout\ : std_logic;
SIGNAL \mv.sum[-13]~q\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~15\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \Result~45_combout\ : std_logic;
SIGNAL \mv.sum[-12]~q\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~35\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \Result~46_combout\ : std_logic;
SIGNAL \mv.sum[-11]~q\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~39\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \Result~47_combout\ : std_logic;
SIGNAL \mv.sum[-10]~q\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~43\ : std_logic;
SIGNAL \Add0~45_sumout\ : std_logic;
SIGNAL \Result~48_combout\ : std_logic;
SIGNAL \mv.sum[-9]~q\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~47\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \Result~49_combout\ : std_logic;
SIGNAL \mv.sum[-8]~q\ : std_logic;
SIGNAL \Add0~50\ : std_logic;
SIGNAL \Add0~51\ : std_logic;
SIGNAL \Add0~53_sumout\ : std_logic;
SIGNAL \Result~50_combout\ : std_logic;
SIGNAL \mv.sum[-7]~q\ : std_logic;
SIGNAL \Add0~54\ : std_logic;
SIGNAL \Add0~55\ : std_logic;
SIGNAL \Add0~57_sumout\ : std_logic;
SIGNAL \Result~51_combout\ : std_logic;
SIGNAL \mv.sum[-6]~q\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~59\ : std_logic;
SIGNAL \Add0~61_sumout\ : std_logic;
SIGNAL \Result~52_combout\ : std_logic;
SIGNAL \mv.sum[-5]~q\ : std_logic;
SIGNAL \Add0~62\ : std_logic;
SIGNAL \Add0~63\ : std_logic;
SIGNAL \Add0~65_sumout\ : std_logic;
SIGNAL \Result~53_combout\ : std_logic;
SIGNAL \mv.sum[-4]~q\ : std_logic;
SIGNAL \Add0~66\ : std_logic;
SIGNAL \Add0~67\ : std_logic;
SIGNAL \Add0~69_sumout\ : std_logic;
SIGNAL \Result~54_combout\ : std_logic;
SIGNAL \mv.sum[-3]~q\ : std_logic;
SIGNAL \Add0~70\ : std_logic;
SIGNAL \Add0~71\ : std_logic;
SIGNAL \Add0~73_sumout\ : std_logic;
SIGNAL \Result~55_combout\ : std_logic;
SIGNAL \mv.sum[-2]~q\ : std_logic;
SIGNAL \Add0~74\ : std_logic;
SIGNAL \Add0~75\ : std_logic;
SIGNAL \Add0~77_sumout\ : std_logic;
SIGNAL \Result~56_combout\ : std_logic;
SIGNAL \mv.sum[-1]~q\ : std_logic;
SIGNAL \Add0~78\ : std_logic;
SIGNAL \Add0~79\ : std_logic;
SIGNAL \Add0~81_sumout\ : std_logic;
SIGNAL \Result~57_combout\ : std_logic;
SIGNAL \Add0~82\ : std_logic;
SIGNAL \Add0~83\ : std_logic;
SIGNAL \Add0~85_sumout\ : std_logic;
SIGNAL \Result~58_combout\ : std_logic;
SIGNAL \Add0~86\ : std_logic;
SIGNAL \Add0~87\ : std_logic;
SIGNAL \Add0~89_sumout\ : std_logic;
SIGNAL \Result~59_combout\ : std_logic;
SIGNAL \Add0~90\ : std_logic;
SIGNAL \Add0~91\ : std_logic;
SIGNAL \Add0~95\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Add0~93_sumout\ : std_logic;
SIGNAL \Result~60_combout\ : std_logic;
SIGNAL \Add0~94\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~11\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \Add2~26\ : std_logic;
SIGNAL \Add2~30\ : std_logic;
SIGNAL \Add2~34\ : std_logic;
SIGNAL \Add2~38\ : std_logic;
SIGNAL \Add2~42\ : std_logic;
SIGNAL \Add2~46\ : std_logic;
SIGNAL \Add2~70\ : std_logic;
SIGNAL \Add2~74\ : std_logic;
SIGNAL \Add2~54\ : std_logic;
SIGNAL \Add2~58\ : std_logic;
SIGNAL \Add2~62\ : std_logic;
SIGNAL \Add2~6\ : std_logic;
SIGNAL \Add2~10\ : std_logic;
SIGNAL \Add2~14\ : std_logic;
SIGNAL \Add2~18\ : std_logic;
SIGNAL \Add2~66\ : std_logic;
SIGNAL \Add2~22\ : std_logic;
SIGNAL \Add2~50\ : std_logic;
SIGNAL \Add2~1_sumout\ : std_logic;
SIGNAL \Add2~5_sumout\ : std_logic;
SIGNAL \Add2~9_sumout\ : std_logic;
SIGNAL \Add2~13_sumout\ : std_logic;
SIGNAL \Add2~17_sumout\ : std_logic;
SIGNAL \Add2~21_sumout\ : std_logic;
SIGNAL \Add2~25_sumout\ : std_logic;
SIGNAL \Add2~29_sumout\ : std_logic;
SIGNAL \Add2~33_sumout\ : std_logic;
SIGNAL \Add2~37_sumout\ : std_logic;
SIGNAL \Add2~41_sumout\ : std_logic;
SIGNAL \Add2~45_sumout\ : std_logic;
SIGNAL \Result~0_combout\ : std_logic;
SIGNAL \Result~1_combout\ : std_logic;
SIGNAL \Add2~49_sumout\ : std_logic;
SIGNAL \Add2~53_sumout\ : std_logic;
SIGNAL \Add2~57_sumout\ : std_logic;
SIGNAL \Add2~61_sumout\ : std_logic;
SIGNAL \Add2~65_sumout\ : std_logic;
SIGNAL \Add2~69_sumout\ : std_logic;
SIGNAL \Add2~73_sumout\ : std_logic;
SIGNAL \Result~2_combout\ : std_logic;
SIGNAL \Result~3_combout\ : std_logic;
SIGNAL \rounds~0_combout\ : std_logic;
SIGNAL \round_overflow~0_combout\ : std_logic;
SIGNAL \Result~4_combout\ : std_logic;
SIGNAL \Result~5_combout\ : std_logic;
SIGNAL \y[0]~reg0_q\ : std_logic;
SIGNAL \Result~6_combout\ : std_logic;
SIGNAL \Result~7_combout\ : std_logic;
SIGNAL \y[1]~reg0_q\ : std_logic;
SIGNAL \Result~8_combout\ : std_logic;
SIGNAL \Result~9_combout\ : std_logic;
SIGNAL \y[2]~reg0_q\ : std_logic;
SIGNAL \Result~10_combout\ : std_logic;
SIGNAL \Result~11_combout\ : std_logic;
SIGNAL \y[3]~reg0_q\ : std_logic;
SIGNAL \Result~12_combout\ : std_logic;
SIGNAL \Result~13_combout\ : std_logic;
SIGNAL \y[4]~reg0_q\ : std_logic;
SIGNAL \Result~14_combout\ : std_logic;
SIGNAL \Result~15_combout\ : std_logic;
SIGNAL \y[5]~reg0_q\ : std_logic;
SIGNAL \Result~16_combout\ : std_logic;
SIGNAL \Result~17_combout\ : std_logic;
SIGNAL \y[6]~reg0_q\ : std_logic;
SIGNAL \Result~18_combout\ : std_logic;
SIGNAL \Result~19_combout\ : std_logic;
SIGNAL \y[7]~reg0_q\ : std_logic;
SIGNAL \Result~20_combout\ : std_logic;
SIGNAL \Result~21_combout\ : std_logic;
SIGNAL \y[8]~reg0_q\ : std_logic;
SIGNAL \Result~22_combout\ : std_logic;
SIGNAL \Result~23_combout\ : std_logic;
SIGNAL \y[9]~reg0_q\ : std_logic;
SIGNAL \Result~24_combout\ : std_logic;
SIGNAL \Result~25_combout\ : std_logic;
SIGNAL \y[10]~reg0_q\ : std_logic;
SIGNAL \Result~26_combout\ : std_logic;
SIGNAL \Result~27_combout\ : std_logic;
SIGNAL \y[11]~reg0_q\ : std_logic;
SIGNAL \Result~28_combout\ : std_logic;
SIGNAL \Result~29_combout\ : std_logic;
SIGNAL \y[12]~reg0_q\ : std_logic;
SIGNAL \Result~30_combout\ : std_logic;
SIGNAL \Result~31_combout\ : std_logic;
SIGNAL \y[13]~reg0_q\ : std_logic;
SIGNAL \Result~32_combout\ : std_logic;
SIGNAL \Result~33_combout\ : std_logic;
SIGNAL \y[14]~reg0_q\ : std_logic;
SIGNAL \Result~34_combout\ : std_logic;
SIGNAL \Result~35_combout\ : std_logic;
SIGNAL \y[15]~reg0_q\ : std_logic;
SIGNAL \Result~36_combout\ : std_logic;
SIGNAL \Result~37_combout\ : std_logic;
SIGNAL \y[16]~reg0_q\ : std_logic;
SIGNAL \Result~38_combout\ : std_logic;
SIGNAL \Result~39_combout\ : std_logic;
SIGNAL \y[17]~reg0_q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|dffe3a\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a8~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a9~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a10~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a11~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a12~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a17~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a16~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a15~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a14~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a13~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\ : std_logic;
SIGNAL \ALT_INV_Add0~93_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~89_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~85_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~81_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~77_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~1_sumout\ : std_logic;
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
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit2~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit3~q\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\ : std_logic_vector(1 DOWNTO 1);
SIGNAL \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\ : std_logic;
SIGNAL \ALT_INV_Result~38_combout\ : std_logic;
SIGNAL \ALT_INV_Result~36_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_Result~34_combout\ : std_logic;
SIGNAL \ALT_INV_Result~32_combout\ : std_logic;
SIGNAL \ALT_INV_Result~30_combout\ : std_logic;
SIGNAL \ALT_INV_Result~28_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-1]~q\ : std_logic;
SIGNAL \ALT_INV_Result~26_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-2]~q\ : std_logic;
SIGNAL \ALT_INV_Result~24_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-3]~q\ : std_logic;
SIGNAL \ALT_INV_Result~22_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-4]~q\ : std_logic;
SIGNAL \ALT_INV_Result~20_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-5]~q\ : std_logic;
SIGNAL \ALT_INV_Result~18_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-6]~q\ : std_logic;
SIGNAL \ALT_INV_Result~16_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-7]~q\ : std_logic;
SIGNAL \ALT_INV_Result~14_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-8]~q\ : std_logic;
SIGNAL \ALT_INV_Result~12_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-9]~q\ : std_logic;
SIGNAL \ALT_INV_Result~10_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-10]~q\ : std_logic;
SIGNAL \ALT_INV_Result~8_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-11]~q\ : std_logic;
SIGNAL \ALT_INV_Result~6_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-12]~q\ : std_logic;
SIGNAL \ALT_INV_Result~4_combout\ : std_logic;
SIGNAL \ALT_INV_round_overflow~0_combout\ : std_logic;
SIGNAL \ALT_INV_rounds~0_combout\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-14]~q\ : std_logic;
SIGNAL \ALT_INV_mv.sum[-13]~q\ : std_logic;
SIGNAL \ALT_INV_Result~3_combout\ : std_logic;
SIGNAL \ALT_INV_Result~2_combout\ : std_logic;
SIGNAL \ALT_INV_Result~1_combout\ : std_logic;
SIGNAL \ALT_INV_Result~0_combout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a1~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a2~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a3~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a4~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a5~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a6~portbdataout\ : std_logic;
SIGNAL \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a7~portbdataout\ : std_logic;
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
SIGNAL \ALT_INV_x[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_x[17]~input_o\ : std_logic;

BEGIN

ww_clk <= clk;
ww_rst_n <= rst_n;
ww_x <= x;
y <= ww_y;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTADATAIN_bus\(0) <= \mv.in_sr[0][0]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-13]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-14]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-15]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-16]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-17]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-12]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-11]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-10]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-9]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-8]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-7]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-6]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-5]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-4]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-3]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-2]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBDATAOUT_bus\(0);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTADATAIN_bus\(0) <= \mv.in_sr[0][-1]~q\;

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTAADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)
& \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBADDR_bus\ <= (\mv.in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.in_sr_rtl_0|auto_generated|dffe3a\(2) & \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & 
\mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\ <= \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBDATAOUT_bus\(0);
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a8~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a9~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a10~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a11~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a12~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a17~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a16~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a15~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a14~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a13~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\;
\ALT_INV_Add0~93_sumout\ <= NOT \Add0~93_sumout\;
\ALT_INV_Add0~89_sumout\ <= NOT \Add0~89_sumout\;
\ALT_INV_Add0~85_sumout\ <= NOT \Add0~85_sumout\;
\ALT_INV_Add0~81_sumout\ <= NOT \Add0~81_sumout\;
\ALT_INV_Add0~77_sumout\ <= NOT \Add0~77_sumout\;
\ALT_INV_Add0~73_sumout\ <= NOT \Add0~73_sumout\;
\ALT_INV_Add0~69_sumout\ <= NOT \Add0~69_sumout\;
\ALT_INV_Add0~65_sumout\ <= NOT \Add0~65_sumout\;
\ALT_INV_Add0~61_sumout\ <= NOT \Add0~61_sumout\;
\ALT_INV_Add0~57_sumout\ <= NOT \Add0~57_sumout\;
\ALT_INV_Add0~53_sumout\ <= NOT \Add0~53_sumout\;
\ALT_INV_Add0~49_sumout\ <= NOT \Add0~49_sumout\;
\ALT_INV_Add0~45_sumout\ <= NOT \Add0~45_sumout\;
\ALT_INV_Add0~41_sumout\ <= NOT \Add0~41_sumout\;
\ALT_INV_Add0~37_sumout\ <= NOT \Add0~37_sumout\;
\ALT_INV_Add0~33_sumout\ <= NOT \Add0~33_sumout\;
\ALT_INV_Add0~29_sumout\ <= NOT \Add0~29_sumout\;
\ALT_INV_Add0~25_sumout\ <= NOT \Add0~25_sumout\;
\ALT_INV_Add0~21_sumout\ <= NOT \Add0~21_sumout\;
\ALT_INV_Add0~17_sumout\ <= NOT \Add0~17_sumout\;
\ALT_INV_Add0~13_sumout\ <= NOT \Add0~13_sumout\;
\ALT_INV_Add0~9_sumout\ <= NOT \Add0~9_sumout\;
\ALT_INV_Add0~5_sumout\ <= NOT \Add0~5_sumout\;
\ALT_INV_Add0~1_sumout\ <= NOT \Add0~1_sumout\;
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
\mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit0~q\ <= NOT \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\;
\mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit1~q\ <= NOT \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\;
\mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit2~q\ <= NOT \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\;
\mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit3~q\ <= NOT \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\;
\mv.in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\ <= NOT \mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\;
\mv.in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\ <= NOT \mv.in_sr_rtl_0|auto_generated|op_2~0_combout\;
\mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1) <= NOT \mv.in_sr_rtl_0|auto_generated|dffe3a\(1);
\mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\ <= NOT \mv.in_sr_rtl_0|auto_generated|dffe7~q\;
\ALT_INV_Result~38_combout\ <= NOT \Result~38_combout\;
\ALT_INV_Result~36_combout\ <= NOT \Result~36_combout\;
\ALT_INV_mv.sum\(3) <= NOT \mv.sum\(3);
\ALT_INV_Result~34_combout\ <= NOT \Result~34_combout\;
\ALT_INV_mv.sum\(2) <= NOT \mv.sum\(2);
\ALT_INV_Result~32_combout\ <= NOT \Result~32_combout\;
\ALT_INV_mv.sum\(1) <= NOT \mv.sum\(1);
\ALT_INV_Result~30_combout\ <= NOT \Result~30_combout\;
\ALT_INV_mv.sum\(0) <= NOT \mv.sum\(0);
\ALT_INV_Result~28_combout\ <= NOT \Result~28_combout\;
\ALT_INV_mv.sum[-1]~q\ <= NOT \mv.sum[-1]~q\;
\ALT_INV_Result~26_combout\ <= NOT \Result~26_combout\;
\ALT_INV_mv.sum[-2]~q\ <= NOT \mv.sum[-2]~q\;
\ALT_INV_Result~24_combout\ <= NOT \Result~24_combout\;
\ALT_INV_mv.sum[-3]~q\ <= NOT \mv.sum[-3]~q\;
\ALT_INV_Result~22_combout\ <= NOT \Result~22_combout\;
\ALT_INV_mv.sum[-4]~q\ <= NOT \mv.sum[-4]~q\;
\ALT_INV_Result~20_combout\ <= NOT \Result~20_combout\;
\ALT_INV_mv.sum[-5]~q\ <= NOT \mv.sum[-5]~q\;
\ALT_INV_Result~18_combout\ <= NOT \Result~18_combout\;
\ALT_INV_mv.sum[-6]~q\ <= NOT \mv.sum[-6]~q\;
\ALT_INV_Result~16_combout\ <= NOT \Result~16_combout\;
\ALT_INV_mv.sum[-7]~q\ <= NOT \mv.sum[-7]~q\;
\ALT_INV_Result~14_combout\ <= NOT \Result~14_combout\;
\ALT_INV_mv.sum[-8]~q\ <= NOT \mv.sum[-8]~q\;
\ALT_INV_Result~12_combout\ <= NOT \Result~12_combout\;
\ALT_INV_mv.sum[-9]~q\ <= NOT \mv.sum[-9]~q\;
\ALT_INV_Result~10_combout\ <= NOT \Result~10_combout\;
\ALT_INV_mv.sum[-10]~q\ <= NOT \mv.sum[-10]~q\;
\ALT_INV_Result~8_combout\ <= NOT \Result~8_combout\;
\ALT_INV_mv.sum[-11]~q\ <= NOT \mv.sum[-11]~q\;
\ALT_INV_Result~6_combout\ <= NOT \Result~6_combout\;
\ALT_INV_mv.sum[-12]~q\ <= NOT \mv.sum[-12]~q\;
\ALT_INV_Result~4_combout\ <= NOT \Result~4_combout\;
\ALT_INV_round_overflow~0_combout\ <= NOT \round_overflow~0_combout\;
\ALT_INV_rounds~0_combout\ <= NOT \rounds~0_combout\;
\ALT_INV_mv.sum[-17]~q\ <= NOT \mv.sum[-17]~q\;
\ALT_INV_mv.sum[-16]~q\ <= NOT \mv.sum[-16]~q\;
\ALT_INV_mv.sum[-15]~q\ <= NOT \mv.sum[-15]~q\;
\ALT_INV_mv.sum[-14]~q\ <= NOT \mv.sum[-14]~q\;
\ALT_INV_mv.sum[-13]~q\ <= NOT \mv.sum[-13]~q\;
\ALT_INV_Result~3_combout\ <= NOT \Result~3_combout\;
\ALT_INV_Result~2_combout\ <= NOT \Result~2_combout\;
\ALT_INV_Result~1_combout\ <= NOT \Result~1_combout\;
\ALT_INV_Result~0_combout\ <= NOT \Result~0_combout\;
\ALT_INV_mv.sum\(4) <= NOT \mv.sum\(4);
\mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita0~sumout\ <= NOT \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\;
\mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita2~sumout\ <= NOT \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\;
\mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~sumout\ <= NOT \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\;
\mv.in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ <= NOT \mv.in_sr_rtl_0|auto_generated|op_1~5_sumout\;
\mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_comb_bita3~1_sumout\ <= NOT \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\;
\mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~1_sumout\ <= NOT \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\;
\mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3) <= NOT \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3);
\mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2) <= NOT \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2);
\mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1) <= NOT \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1);
\mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0) <= NOT \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0);
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a1~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a2~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a3~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a4~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a5~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a6~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\;
\mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a7~portbdataout\ <= NOT \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\;
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
\ALT_INV_x[0]~input_o\ <= NOT \x[0]~input_o\;
\ALT_INV_x[1]~input_o\ <= NOT \x[1]~input_o\;
\ALT_INV_x[2]~input_o\ <= NOT \x[2]~input_o\;
\ALT_INV_x[3]~input_o\ <= NOT \x[3]~input_o\;
\ALT_INV_x[4]~input_o\ <= NOT \x[4]~input_o\;
\ALT_INV_x[17]~input_o\ <= NOT \x[17]~input_o\;

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
	o => \y[0]~output_o\);

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
	o => \y[1]~output_o\);

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
	o => \y[2]~output_o\);

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
	o => \y[3]~output_o\);

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
	o => \y[4]~output_o\);

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
	o => \y[5]~output_o\);

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
	o => \y[6]~output_o\);

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
	o => \y[7]~output_o\);

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
	o => \y[8]~output_o\);

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
	o => \y[9]~output_o\);

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
	o => \y[10]~output_o\);

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
	o => \y[11]~output_o\);

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
	o => \y[12]~output_o\);

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
	o => \y[13]~output_o\);

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
	o => \y[14]~output_o\);

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
	o => \y[15]~output_o\);

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
	o => \y[16]~output_o\);

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
	o => \y[17]~output_o\);

\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\ = SUM(( !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ = CARRY(( !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit0~q\,
	cin => GND,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~0_combout\ = !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita0~sumout\,
	combout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~0_combout\);

\rst_n~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst_n,
	o => \rst_n~input_o\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\ = SUM(( \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ ))
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ = CARRY(( \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit1~q\,
	cin => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\,
	clrn => \rst_n~input_o\,
	ena => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\ = SUM(( !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ ))
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ = CARRY(( !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit2~q\,
	cin => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\ = !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita2~sumout\,
	combout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\ = SUM(( !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ ))
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\ = CARRY(( !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit3~q\,
	cin => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\ = !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~sumout\,
	combout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\);

\mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\ = SUM(( GND ) + ( GND ) + ( \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\);

\mv.in_sr_rtl_0|auto_generated|dffe7~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|dffe7~0_combout\ = !\mv.in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~1_sumout\,
	combout => \mv.in_sr_rtl_0|auto_generated|dffe7~0_combout\);

\mv.in_sr_rtl_0|auto_generated|dffe7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|dffe7~0_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|dffe7~q\);

\x[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(17),
	o => \x[17]~input_o\);

\mv.in_sr[0][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[17]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][0]~q\);

\mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ = SUM(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ = CARRY(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\);

\mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ = SUM(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ = CARRY(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	cin => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\);

\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	sclr => \mv.in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1));

\mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ = SUM(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ = CARRY(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	cin => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\);

\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	sclr => \mv.in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2));

\mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ = SUM(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ ))
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\ = CARRY(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	cin => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\);

\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\,
	sclr => \mv.in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3));

\mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ = SUM(( GND ) + ( GND ) + ( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\,
	sumout => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\);

\mv.in_sr_rtl_0|auto_generated|cntr1|cout_actual\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\ = ( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ ) # ( !\mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ & ( 
-- (!\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) & (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010111111111111111100000000000000101111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	datab => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	datac => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	datae => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_comb_bita3~1_sumout\,
	combout => \mv.in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\);

\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	sclr => \mv.in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.in_sr_rtl_0|auto_generated|op_2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|op_2~0_combout\ = (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & ((\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1)) # 
-- (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000111000000000000011100000000000001110000000000000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	datab => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	datac => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	combout => \mv.in_sr_rtl_0|auto_generated|op_2~0_combout\);

\mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\ = (!\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) & (!\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & (\mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
-- \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001000000000000000100000000000000010000000000000001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	datab => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	datac => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	combout => \mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\);

\mv.in_sr_rtl_0|auto_generated|op_1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|op_1~1_sumout\ = SUM(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( (!\mv.in_sr_rtl_0|auto_generated|op_2~0_combout\ & !\mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) ) + ( !VCC ))
-- \mv.in_sr_rtl_0|auto_generated|op_1~2\ = CARRY(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( (!\mv.in_sr_rtl_0|auto_generated|op_2~0_combout\ & !\mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010101011111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\,
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	dataf => \mv.in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\,
	cin => GND,
	sumout => \mv.in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|op_1~2\);

\mv.in_sr_rtl_0|auto_generated|dffe3a[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.in_sr_rtl_0|auto_generated|op_1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|op_1~5_sumout\ = SUM(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( (!\mv.in_sr_rtl_0|auto_generated|op_2~0_combout\ & !\mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) ) + ( 
-- \mv.in_sr_rtl_0|auto_generated|op_1~2\ ))
-- \mv.in_sr_rtl_0|auto_generated|op_1~6\ = CARRY(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( (!\mv.in_sr_rtl_0|auto_generated|op_2~0_combout\ & !\mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) ) + ( 
-- \mv.in_sr_rtl_0|auto_generated|op_1~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010101011111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\,
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	dataf => \mv.in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\,
	cin => \mv.in_sr_rtl_0|auto_generated|op_1~2\,
	sumout => \mv.in_sr_rtl_0|auto_generated|op_1~5_sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|op_1~6\);

\mv.in_sr_rtl_0|auto_generated|dffe3a[1]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ = !\mv.in_sr_rtl_0|auto_generated|op_1~5_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\,
	combout => \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\);

\mv.in_sr_rtl_0|auto_generated|dffe3a[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|dffe3a\(1));

\mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ = !\mv.in_sr_rtl_0|auto_generated|dffe3a\(1)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1),
	combout => \mv.in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\);

\mv.in_sr_rtl_0|auto_generated|op_1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|op_1~9_sumout\ = SUM(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( (\mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) # (\mv.in_sr_rtl_0|auto_generated|op_2~0_combout\) ) + ( 
-- \mv.in_sr_rtl_0|auto_generated|op_1~6\ ))
-- \mv.in_sr_rtl_0|auto_generated|op_1~10\ = CARRY(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( (\mv.in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) # (\mv.in_sr_rtl_0|auto_generated|op_2~0_combout\) ) + ( 
-- \mv.in_sr_rtl_0|auto_generated|op_1~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010100000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\,
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	dataf => \mv.in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\,
	cin => \mv.in_sr_rtl_0|auto_generated|op_1~6\,
	sumout => \mv.in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	cout => \mv.in_sr_rtl_0|auto_generated|op_1~10\);

\mv.in_sr_rtl_0|auto_generated|dffe3a[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|dffe3a\(2));

\mv.in_sr_rtl_0|auto_generated|op_1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.in_sr_rtl_0|auto_generated|op_1~13_sumout\ = SUM(( \mv.in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.in_sr_rtl_0|auto_generated|op_1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	cin => \mv.in_sr_rtl_0|auto_generated|op_1~10\,
	sumout => \mv.in_sr_rtl_0|auto_generated|op_1~13_sumout\);

\mv.in_sr_rtl_0|auto_generated|dffe3a[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.in_sr_rtl_0|auto_generated|op_1~13_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr_rtl_0|auto_generated|dffe3a\(3));

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 0,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 0,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\);

\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( !\mv.sum\(4) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~95\ ) + ( \Add0~94\ ))
-- \Add0~6\ = CARRY(( !\mv.sum\(4) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~95\ ) + ( \Add0~94\ ))
-- \Add0~7\ = SHARE((!\mv.sum\(4) & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ & \x[17]~input_o\)) # (\mv.sum\(4) & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\) # (\x[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum\(4),
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	datad => \ALT_INV_x[17]~input_o\,
	cin => \Add0~94\,
	sharein => \Add0~95\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\,
	shareout => \Add0~7\);

\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( !\mv.sum\(4) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~7\ ) + ( \Add0~6\ ))
-- \Add0~10\ = CARRY(( !\mv.sum\(4) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~7\ ) + ( \Add0~6\ ))
-- \Add0~11\ = SHARE((!\mv.sum\(4) & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ & \x[17]~input_o\)) # (\mv.sum\(4) & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\) # (\x[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum\(4),
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	datad => \ALT_INV_x[17]~input_o\,
	cin => \Add0~6\,
	sharein => \Add0~7\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\,
	shareout => \Add0~11\);

\x[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(16),
	o => \x[16]~input_o\);

\mv.in_sr[0][-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[16]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-1]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 1,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 1,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBDATAOUT_bus\);

\x[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(15),
	o => \x[15]~input_o\);

\mv.in_sr[0][-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[15]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-2]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 2,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 2,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBDATAOUT_bus\);

\x[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(14),
	o => \x[14]~input_o\);

\mv.in_sr[0][-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[14]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-3]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 3,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 3,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBDATAOUT_bus\);

\x[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(13),
	o => \x[13]~input_o\);

\mv.in_sr[0][-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[13]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-4]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 4,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 4,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBDATAOUT_bus\);

\x[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(12),
	o => \x[12]~input_o\);

\mv.in_sr[0][-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[12]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-5]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 5,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 5,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBDATAOUT_bus\);

\x[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(11),
	o => \x[11]~input_o\);

\mv.in_sr[0][-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[11]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-6]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 6,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 6,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBDATAOUT_bus\);

\x[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(10),
	o => \x[10]~input_o\);

\mv.in_sr[0][-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[10]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-7]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 7,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 7,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBDATAOUT_bus\);

\x[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(9),
	o => \x[9]~input_o\);

\mv.in_sr[0][-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[9]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-8]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 8,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 8,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBDATAOUT_bus\);

\x[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(8),
	o => \x[8]~input_o\);

\mv.in_sr[0][-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[8]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-9]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 9,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 9,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBDATAOUT_bus\);

\x[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(7),
	o => \x[7]~input_o\);

\mv.in_sr[0][-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[7]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-10]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 10,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 10,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBDATAOUT_bus\);

\x[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(6),
	o => \x[6]~input_o\);

\mv.in_sr[0][-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[6]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-11]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 11,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 11,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBDATAOUT_bus\);

\x[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(5),
	o => \x[5]~input_o\);

\mv.in_sr[0][-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[5]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-12]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 12,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 12,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBDATAOUT_bus\);

\x[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(4),
	o => \x[4]~input_o\);

\mv.in_sr[0][-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[4]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-13]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 13,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 13,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBDATAOUT_bus\);

\x[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(3),
	o => \x[3]~input_o\);

\mv.in_sr[0][-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[3]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-14]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 14,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 14,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBDATAOUT_bus\);

\x[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(2),
	o => \x[2]~input_o\);

\mv.in_sr[0][-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[2]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-15]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 15,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 15,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBDATAOUT_bus\);

\x[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(1),
	o => \x[1]~input_o\);

\mv.in_sr[0][-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[1]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-16]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 16,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 16,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBDATAOUT_bus\);

\x[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(0),
	o => \x[0]~input_o\);

\mv.in_sr[0][-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x[0]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.in_sr[0][-17]~q\);

\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_vic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 17,
	port_a_last_address => 14,
	port_a_logical_ram_depth => 15,
	port_a_logical_ram_width => 18,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 17,
	port_b_last_address => 14,
	port_b_logical_ram_depth => 15,
	port_b_logical_ram_width => 18,
	port_b_read_during_write_mode => "new_data_no_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => VCC,
	portbre => VCC,
	clk0 => \clk~input_o\,
	clk1 => \clk~input_o\,
	ena0 => VCC,
	ena1 => VCC,
	clr0 => \mv.in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTADATAIN_bus\,
	portaaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTAADDR_bus\,
	portbaddr => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBDATAOUT_bus\);

\Add0~98\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~98_cout\ = CARRY(( GND ) + ( !VCC ) + ( !VCC ))
-- \Add0~99\ = SHARE(VCC)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	cin => GND,
	sharein => GND,
	cout => \Add0~98_cout\,
	shareout => \Add0~99\);

\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( !\mv.sum[-17]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\ $ (!\x[0]~input_o\)) ) + ( \Add0~99\ ) + ( \Add0~98_cout\ ))
-- \Add0~30\ = CARRY(( !\mv.sum[-17]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\ $ (!\x[0]~input_o\)) ) + ( \Add0~99\ ) + ( \Add0~98_cout\ ))
-- \Add0~31\ = SHARE((!\mv.sum[-17]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\ & \x[0]~input_o\)) # (\mv.sum[-17]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\) # (\x[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-17]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a17~portbdataout\,
	datad => \ALT_INV_x[0]~input_o\,
	cin => \Add0~98_cout\,
	sharein => \Add0~99\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\,
	shareout => \Add0~31\);

\Result~44\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~44_combout\ = (!\Add0~1_sumout\ & (((\Add0~29_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~29_sumout\,
	combout => \Result~44_combout\);

\mv.sum[-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~44_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-17]~q\);

\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( !\mv.sum[-16]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\ $ (!\x[1]~input_o\)) ) + ( \Add0~31\ ) + ( \Add0~30\ ))
-- \Add0~26\ = CARRY(( !\mv.sum[-16]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\ $ (!\x[1]~input_o\)) ) + ( \Add0~31\ ) + ( \Add0~30\ ))
-- \Add0~27\ = SHARE((!\mv.sum[-16]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\ & \x[1]~input_o\)) # (\mv.sum[-16]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\) # (\x[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-16]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a16~portbdataout\,
	datad => \ALT_INV_x[1]~input_o\,
	cin => \Add0~30\,
	sharein => \Add0~31\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\,
	shareout => \Add0~27\);

\Result~43\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~43_combout\ = (!\Add0~1_sumout\ & (((\Add0~25_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~25_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~25_sumout\,
	combout => \Result~43_combout\);

\mv.sum[-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~43_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-16]~q\);

\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( !\mv.sum[-15]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\ $ (!\x[2]~input_o\)) ) + ( \Add0~27\ ) + ( \Add0~26\ ))
-- \Add0~22\ = CARRY(( !\mv.sum[-15]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\ $ (!\x[2]~input_o\)) ) + ( \Add0~27\ ) + ( \Add0~26\ ))
-- \Add0~23\ = SHARE((!\mv.sum[-15]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\ & \x[2]~input_o\)) # (\mv.sum[-15]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\) # (\x[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-15]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a15~portbdataout\,
	datad => \ALT_INV_x[2]~input_o\,
	cin => \Add0~26\,
	sharein => \Add0~27\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\,
	shareout => \Add0~23\);

\Result~42\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~42_combout\ = (!\Add0~1_sumout\ & (((\Add0~21_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~21_sumout\,
	combout => \Result~42_combout\);

\mv.sum[-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~42_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-15]~q\);

\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( !\mv.sum[-14]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\ $ (!\x[3]~input_o\)) ) + ( \Add0~23\ ) + ( \Add0~22\ ))
-- \Add0~18\ = CARRY(( !\mv.sum[-14]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\ $ (!\x[3]~input_o\)) ) + ( \Add0~23\ ) + ( \Add0~22\ ))
-- \Add0~19\ = SHARE((!\mv.sum[-14]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\ & \x[3]~input_o\)) # (\mv.sum[-14]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\) # (\x[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-14]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a14~portbdataout\,
	datad => \ALT_INV_x[3]~input_o\,
	cin => \Add0~22\,
	sharein => \Add0~23\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\,
	shareout => \Add0~19\);

\Result~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~41_combout\ = (!\Add0~1_sumout\ & (((\Add0~17_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~17_sumout\,
	combout => \Result~41_combout\);

\mv.sum[-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~41_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-14]~q\);

\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( !\mv.sum[-13]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\ $ (!\x[4]~input_o\)) ) + ( \Add0~19\ ) + ( \Add0~18\ ))
-- \Add0~14\ = CARRY(( !\mv.sum[-13]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\ $ (!\x[4]~input_o\)) ) + ( \Add0~19\ ) + ( \Add0~18\ ))
-- \Add0~15\ = SHARE((!\mv.sum[-13]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\ & \x[4]~input_o\)) # (\mv.sum[-13]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\) # (\x[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-13]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a13~portbdataout\,
	datad => \ALT_INV_x[4]~input_o\,
	cin => \Add0~18\,
	sharein => \Add0~19\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\,
	shareout => \Add0~15\);

\Result~40\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~40_combout\ = (!\Add0~1_sumout\ & (((\Add0~13_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~13_sumout\,
	combout => \Result~40_combout\);

\mv.sum[-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~40_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-13]~q\);

\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( !\mv.sum[-12]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\ $ (!\x[5]~input_o\)) ) + ( \Add0~15\ ) + ( \Add0~14\ ))
-- \Add0~34\ = CARRY(( !\mv.sum[-12]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\ $ (!\x[5]~input_o\)) ) + ( \Add0~15\ ) + ( \Add0~14\ ))
-- \Add0~35\ = SHARE((!\mv.sum[-12]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\ & \x[5]~input_o\)) # (\mv.sum[-12]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\) # (\x[5]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-12]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a12~portbdataout\,
	datad => \ALT_INV_x[5]~input_o\,
	cin => \Add0~14\,
	sharein => \Add0~15\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\,
	shareout => \Add0~35\);

\Result~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~45_combout\ = (!\Add0~1_sumout\ & (((\Add0~33_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~33_sumout\,
	combout => \Result~45_combout\);

\mv.sum[-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~45_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-12]~q\);

\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( !\mv.sum[-11]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\ $ (!\x[6]~input_o\)) ) + ( \Add0~35\ ) + ( \Add0~34\ ))
-- \Add0~38\ = CARRY(( !\mv.sum[-11]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\ $ (!\x[6]~input_o\)) ) + ( \Add0~35\ ) + ( \Add0~34\ ))
-- \Add0~39\ = SHARE((!\mv.sum[-11]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\ & \x[6]~input_o\)) # (\mv.sum[-11]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\) # (\x[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-11]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a11~portbdataout\,
	datad => \ALT_INV_x[6]~input_o\,
	cin => \Add0~34\,
	sharein => \Add0~35\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\,
	shareout => \Add0~39\);

\Result~46\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~46_combout\ = (!\Add0~1_sumout\ & (((\Add0~37_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~37_sumout\,
	combout => \Result~46_combout\);

\mv.sum[-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~46_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-11]~q\);

\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( !\mv.sum[-10]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\ $ (!\x[7]~input_o\)) ) + ( \Add0~39\ ) + ( \Add0~38\ ))
-- \Add0~42\ = CARRY(( !\mv.sum[-10]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\ $ (!\x[7]~input_o\)) ) + ( \Add0~39\ ) + ( \Add0~38\ ))
-- \Add0~43\ = SHARE((!\mv.sum[-10]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\ & \x[7]~input_o\)) # (\mv.sum[-10]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\) # (\x[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-10]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a10~portbdataout\,
	datad => \ALT_INV_x[7]~input_o\,
	cin => \Add0~38\,
	sharein => \Add0~39\,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\,
	shareout => \Add0~43\);

\Result~47\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~47_combout\ = (!\Add0~1_sumout\ & (((\Add0~41_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~41_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~41_sumout\,
	combout => \Result~47_combout\);

\mv.sum[-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~47_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-10]~q\);

\Add0~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~45_sumout\ = SUM(( !\mv.sum[-9]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\ $ (!\x[8]~input_o\)) ) + ( \Add0~43\ ) + ( \Add0~42\ ))
-- \Add0~46\ = CARRY(( !\mv.sum[-9]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\ $ (!\x[8]~input_o\)) ) + ( \Add0~43\ ) + ( \Add0~42\ ))
-- \Add0~47\ = SHARE((!\mv.sum[-9]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\ & \x[8]~input_o\)) # (\mv.sum[-9]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\) # (\x[8]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-9]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a9~portbdataout\,
	datad => \ALT_INV_x[8]~input_o\,
	cin => \Add0~42\,
	sharein => \Add0~43\,
	sumout => \Add0~45_sumout\,
	cout => \Add0~46\,
	shareout => \Add0~47\);

\Result~48\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~48_combout\ = (!\Add0~1_sumout\ & (((\Add0~45_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~45_sumout\,
	combout => \Result~48_combout\);

\mv.sum[-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~48_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-9]~q\);

\Add0~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~49_sumout\ = SUM(( !\mv.sum[-8]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\ $ (!\x[9]~input_o\)) ) + ( \Add0~47\ ) + ( \Add0~46\ ))
-- \Add0~50\ = CARRY(( !\mv.sum[-8]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\ $ (!\x[9]~input_o\)) ) + ( \Add0~47\ ) + ( \Add0~46\ ))
-- \Add0~51\ = SHARE((!\mv.sum[-8]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\ & \x[9]~input_o\)) # (\mv.sum[-8]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\) # (\x[9]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-8]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a8~portbdataout\,
	datad => \ALT_INV_x[9]~input_o\,
	cin => \Add0~46\,
	sharein => \Add0~47\,
	sumout => \Add0~49_sumout\,
	cout => \Add0~50\,
	shareout => \Add0~51\);

\Result~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~49_combout\ = (!\Add0~1_sumout\ & (((\Add0~49_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~49_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~49_sumout\,
	combout => \Result~49_combout\);

\mv.sum[-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~49_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-8]~q\);

\Add0~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~53_sumout\ = SUM(( !\mv.sum[-7]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\ $ (!\x[10]~input_o\)) ) + ( \Add0~51\ ) + ( \Add0~50\ ))
-- \Add0~54\ = CARRY(( !\mv.sum[-7]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\ $ (!\x[10]~input_o\)) ) + ( \Add0~51\ ) + ( \Add0~50\ ))
-- \Add0~55\ = SHARE((!\mv.sum[-7]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\ & \x[10]~input_o\)) # (\mv.sum[-7]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\) # (\x[10]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-7]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a7~portbdataout\,
	datad => \ALT_INV_x[10]~input_o\,
	cin => \Add0~50\,
	sharein => \Add0~51\,
	sumout => \Add0~53_sumout\,
	cout => \Add0~54\,
	shareout => \Add0~55\);

\Result~50\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~50_combout\ = (!\Add0~1_sumout\ & (((\Add0~53_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~53_sumout\,
	combout => \Result~50_combout\);

\mv.sum[-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~50_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-7]~q\);

\Add0~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~57_sumout\ = SUM(( !\mv.sum[-6]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\ $ (!\x[11]~input_o\)) ) + ( \Add0~55\ ) + ( \Add0~54\ ))
-- \Add0~58\ = CARRY(( !\mv.sum[-6]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\ $ (!\x[11]~input_o\)) ) + ( \Add0~55\ ) + ( \Add0~54\ ))
-- \Add0~59\ = SHARE((!\mv.sum[-6]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\ & \x[11]~input_o\)) # (\mv.sum[-6]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\) # (\x[11]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-6]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a6~portbdataout\,
	datad => \ALT_INV_x[11]~input_o\,
	cin => \Add0~54\,
	sharein => \Add0~55\,
	sumout => \Add0~57_sumout\,
	cout => \Add0~58\,
	shareout => \Add0~59\);

\Result~51\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~51_combout\ = (!\Add0~1_sumout\ & (((\Add0~57_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~57_sumout\,
	combout => \Result~51_combout\);

\mv.sum[-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~51_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-6]~q\);

\Add0~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~61_sumout\ = SUM(( !\mv.sum[-5]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\ $ (!\x[12]~input_o\)) ) + ( \Add0~59\ ) + ( \Add0~58\ ))
-- \Add0~62\ = CARRY(( !\mv.sum[-5]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\ $ (!\x[12]~input_o\)) ) + ( \Add0~59\ ) + ( \Add0~58\ ))
-- \Add0~63\ = SHARE((!\mv.sum[-5]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\ & \x[12]~input_o\)) # (\mv.sum[-5]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\) # (\x[12]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-5]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a5~portbdataout\,
	datad => \ALT_INV_x[12]~input_o\,
	cin => \Add0~58\,
	sharein => \Add0~59\,
	sumout => \Add0~61_sumout\,
	cout => \Add0~62\,
	shareout => \Add0~63\);

\Result~52\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~52_combout\ = (!\Add0~1_sumout\ & (((\Add0~61_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~61_sumout\,
	combout => \Result~52_combout\);

\mv.sum[-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~52_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-5]~q\);

\Add0~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~65_sumout\ = SUM(( !\mv.sum[-4]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\ $ (!\x[13]~input_o\)) ) + ( \Add0~63\ ) + ( \Add0~62\ ))
-- \Add0~66\ = CARRY(( !\mv.sum[-4]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\ $ (!\x[13]~input_o\)) ) + ( \Add0~63\ ) + ( \Add0~62\ ))
-- \Add0~67\ = SHARE((!\mv.sum[-4]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\ & \x[13]~input_o\)) # (\mv.sum[-4]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\) # (\x[13]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-4]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a4~portbdataout\,
	datad => \ALT_INV_x[13]~input_o\,
	cin => \Add0~62\,
	sharein => \Add0~63\,
	sumout => \Add0~65_sumout\,
	cout => \Add0~66\,
	shareout => \Add0~67\);

\Result~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~53_combout\ = (!\Add0~1_sumout\ & (((\Add0~65_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~65_sumout\,
	combout => \Result~53_combout\);

\mv.sum[-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~53_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-4]~q\);

\Add0~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~69_sumout\ = SUM(( !\mv.sum[-3]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\ $ (!\x[14]~input_o\)) ) + ( \Add0~67\ ) + ( \Add0~66\ ))
-- \Add0~70\ = CARRY(( !\mv.sum[-3]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\ $ (!\x[14]~input_o\)) ) + ( \Add0~67\ ) + ( \Add0~66\ ))
-- \Add0~71\ = SHARE((!\mv.sum[-3]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\ & \x[14]~input_o\)) # (\mv.sum[-3]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\) # (\x[14]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-3]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a3~portbdataout\,
	datad => \ALT_INV_x[14]~input_o\,
	cin => \Add0~66\,
	sharein => \Add0~67\,
	sumout => \Add0~69_sumout\,
	cout => \Add0~70\,
	shareout => \Add0~71\);

\Result~54\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~54_combout\ = (!\Add0~1_sumout\ & (((\Add0~69_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~69_sumout\,
	combout => \Result~54_combout\);

\mv.sum[-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~54_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-3]~q\);

\Add0~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~73_sumout\ = SUM(( !\mv.sum[-2]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\ $ (!\x[15]~input_o\)) ) + ( \Add0~71\ ) + ( \Add0~70\ ))
-- \Add0~74\ = CARRY(( !\mv.sum[-2]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\ $ (!\x[15]~input_o\)) ) + ( \Add0~71\ ) + ( \Add0~70\ ))
-- \Add0~75\ = SHARE((!\mv.sum[-2]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\ & \x[15]~input_o\)) # (\mv.sum[-2]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\) # (\x[15]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-2]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a2~portbdataout\,
	datad => \ALT_INV_x[15]~input_o\,
	cin => \Add0~70\,
	sharein => \Add0~71\,
	sumout => \Add0~73_sumout\,
	cout => \Add0~74\,
	shareout => \Add0~75\);

\Result~55\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~55_combout\ = (!\Add0~1_sumout\ & (((\Add0~73_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~73_sumout\,
	combout => \Result~55_combout\);

\mv.sum[-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~55_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-2]~q\);

\Add0~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~77_sumout\ = SUM(( !\mv.sum[-1]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\ $ (!\x[16]~input_o\)) ) + ( \Add0~75\ ) + ( \Add0~74\ ))
-- \Add0~78\ = CARRY(( !\mv.sum[-1]~q\ $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\ $ (!\x[16]~input_o\)) ) + ( \Add0~75\ ) + ( \Add0~74\ ))
-- \Add0~79\ = SHARE((!\mv.sum[-1]~q\ & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\ & \x[16]~input_o\)) # (\mv.sum[-1]~q\ & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\) # (\x[16]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum[-1]~q\,
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a1~portbdataout\,
	datad => \ALT_INV_x[16]~input_o\,
	cin => \Add0~74\,
	sharein => \Add0~75\,
	sumout => \Add0~77_sumout\,
	cout => \Add0~78\,
	shareout => \Add0~79\);

\Result~56\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~56_combout\ = (!\Add0~1_sumout\ & (((\Add0~77_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~77_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~77_sumout\,
	combout => \Result~56_combout\);

\mv.sum[-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~56_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum[-1]~q\);

\Add0~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~81_sumout\ = SUM(( !\mv.sum\(0) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~79\ ) + ( \Add0~78\ ))
-- \Add0~82\ = CARRY(( !\mv.sum\(0) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~79\ ) + ( \Add0~78\ ))
-- \Add0~83\ = SHARE((!\mv.sum\(0) & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ & \x[17]~input_o\)) # (\mv.sum\(0) & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\) # (\x[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum\(0),
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	datad => \ALT_INV_x[17]~input_o\,
	cin => \Add0~78\,
	sharein => \Add0~79\,
	sumout => \Add0~81_sumout\,
	cout => \Add0~82\,
	shareout => \Add0~83\);

\Result~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~57_combout\ = (!\Add0~1_sumout\ & (((\Add0~81_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~81_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~81_sumout\,
	combout => \Result~57_combout\);

\mv.sum[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~57_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum\(0));

\Add0~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~85_sumout\ = SUM(( !\mv.sum\(1) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~83\ ) + ( \Add0~82\ ))
-- \Add0~86\ = CARRY(( !\mv.sum\(1) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~83\ ) + ( \Add0~82\ ))
-- \Add0~87\ = SHARE((!\mv.sum\(1) & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ & \x[17]~input_o\)) # (\mv.sum\(1) & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\) # (\x[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum\(1),
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	datad => \ALT_INV_x[17]~input_o\,
	cin => \Add0~82\,
	sharein => \Add0~83\,
	sumout => \Add0~85_sumout\,
	cout => \Add0~86\,
	shareout => \Add0~87\);

\Result~58\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~58_combout\ = (!\Add0~1_sumout\ & (((\Add0~85_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~85_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~85_sumout\,
	combout => \Result~58_combout\);

\mv.sum[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~58_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum\(1));

\Add0~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~89_sumout\ = SUM(( !\mv.sum\(2) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~87\ ) + ( \Add0~86\ ))
-- \Add0~90\ = CARRY(( !\mv.sum\(2) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~87\ ) + ( \Add0~86\ ))
-- \Add0~91\ = SHARE((!\mv.sum\(2) & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ & \x[17]~input_o\)) # (\mv.sum\(2) & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\) # (\x[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum\(2),
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	datad => \ALT_INV_x[17]~input_o\,
	cin => \Add0~86\,
	sharein => \Add0~87\,
	sumout => \Add0~89_sumout\,
	cout => \Add0~90\,
	shareout => \Add0~91\);

\Result~59\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~59_combout\ = (!\Add0~1_sumout\ & (((\Add0~89_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~89_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~89_sumout\,
	combout => \Result~59_combout\);

\mv.sum[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~59_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum\(2));

\Add0~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~93_sumout\ = SUM(( !\mv.sum\(3) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~91\ ) + ( \Add0~90\ ))
-- \Add0~94\ = CARRY(( !\mv.sum\(3) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~91\ ) + ( \Add0~90\ ))
-- \Add0~95\ = SHARE((!\mv.sum\(3) & (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ & \x[17]~input_o\)) # (\mv.sum\(3) & ((!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\) # (\x[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100001111001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum\(3),
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	datad => \ALT_INV_x[17]~input_o\,
	cin => \Add0~90\,
	sharein => \Add0~91\,
	sumout => \Add0~93_sumout\,
	cout => \Add0~94\,
	shareout => \Add0~95\);

\Result~60\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~60_combout\ = (!\Add0~1_sumout\ & (((\Add0~93_sumout\) # (\Add0~9_sumout\)) # (\Add0~5_sumout\))) # (\Add0~1_sumout\ & (\Add0~5_sumout\ & (\Add0~9_sumout\ & \Add0~93_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add0~1_sumout\,
	datab => \ALT_INV_Add0~5_sumout\,
	datac => \ALT_INV_Add0~9_sumout\,
	datad => \ALT_INV_Add0~93_sumout\,
	combout => \Result~60_combout\);

\mv.sum[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~60_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum\(3));

\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( !\mv.sum\(4) $ (!\mv.in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ $ (!\x[17]~input_o\)) ) + ( \Add0~11\ ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.sum\(4),
	datac => \mv.in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	datad => \ALT_INV_x[17]~input_o\,
	cin => \Add0~10\,
	sharein => \Add0~11\,
	sumout => \Add0~1_sumout\);

\mv.sum[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Add0~1_sumout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.sum\(4));

\Add2~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~25_sumout\ = SUM(( \mv.sum[-13]~q\ ) + ( VCC ) + ( !VCC ))
-- \Add2~26\ = CARRY(( \mv.sum[-13]~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-13]~q\,
	cin => GND,
	sumout => \Add2~25_sumout\,
	cout => \Add2~26\);

\Add2~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~29_sumout\ = SUM(( \mv.sum[-12]~q\ ) + ( GND ) + ( \Add2~26\ ))
-- \Add2~30\ = CARRY(( \mv.sum[-12]~q\ ) + ( GND ) + ( \Add2~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-12]~q\,
	cin => \Add2~26\,
	sumout => \Add2~29_sumout\,
	cout => \Add2~30\);

\Add2~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~33_sumout\ = SUM(( \mv.sum[-11]~q\ ) + ( GND ) + ( \Add2~30\ ))
-- \Add2~34\ = CARRY(( \mv.sum[-11]~q\ ) + ( GND ) + ( \Add2~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-11]~q\,
	cin => \Add2~30\,
	sumout => \Add2~33_sumout\,
	cout => \Add2~34\);

\Add2~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~37_sumout\ = SUM(( \mv.sum[-10]~q\ ) + ( GND ) + ( \Add2~34\ ))
-- \Add2~38\ = CARRY(( \mv.sum[-10]~q\ ) + ( GND ) + ( \Add2~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-10]~q\,
	cin => \Add2~34\,
	sumout => \Add2~37_sumout\,
	cout => \Add2~38\);

\Add2~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~41_sumout\ = SUM(( \mv.sum[-9]~q\ ) + ( GND ) + ( \Add2~38\ ))
-- \Add2~42\ = CARRY(( \mv.sum[-9]~q\ ) + ( GND ) + ( \Add2~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-9]~q\,
	cin => \Add2~38\,
	sumout => \Add2~41_sumout\,
	cout => \Add2~42\);

\Add2~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~45_sumout\ = SUM(( \mv.sum[-8]~q\ ) + ( GND ) + ( \Add2~42\ ))
-- \Add2~46\ = CARRY(( \mv.sum[-8]~q\ ) + ( GND ) + ( \Add2~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-8]~q\,
	cin => \Add2~42\,
	sumout => \Add2~45_sumout\,
	cout => \Add2~46\);

\Add2~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~69_sumout\ = SUM(( \mv.sum[-7]~q\ ) + ( GND ) + ( \Add2~46\ ))
-- \Add2~70\ = CARRY(( \mv.sum[-7]~q\ ) + ( GND ) + ( \Add2~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-7]~q\,
	cin => \Add2~46\,
	sumout => \Add2~69_sumout\,
	cout => \Add2~70\);

\Add2~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~73_sumout\ = SUM(( \mv.sum[-6]~q\ ) + ( GND ) + ( \Add2~70\ ))
-- \Add2~74\ = CARRY(( \mv.sum[-6]~q\ ) + ( GND ) + ( \Add2~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-6]~q\,
	cin => \Add2~70\,
	sumout => \Add2~73_sumout\,
	cout => \Add2~74\);

\Add2~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~53_sumout\ = SUM(( \mv.sum[-5]~q\ ) + ( GND ) + ( \Add2~74\ ))
-- \Add2~54\ = CARRY(( \mv.sum[-5]~q\ ) + ( GND ) + ( \Add2~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-5]~q\,
	cin => \Add2~74\,
	sumout => \Add2~53_sumout\,
	cout => \Add2~54\);

\Add2~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~57_sumout\ = SUM(( \mv.sum[-4]~q\ ) + ( GND ) + ( \Add2~54\ ))
-- \Add2~58\ = CARRY(( \mv.sum[-4]~q\ ) + ( GND ) + ( \Add2~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-4]~q\,
	cin => \Add2~54\,
	sumout => \Add2~57_sumout\,
	cout => \Add2~58\);

\Add2~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~61_sumout\ = SUM(( \mv.sum[-3]~q\ ) + ( GND ) + ( \Add2~58\ ))
-- \Add2~62\ = CARRY(( \mv.sum[-3]~q\ ) + ( GND ) + ( \Add2~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-3]~q\,
	cin => \Add2~58\,
	sumout => \Add2~61_sumout\,
	cout => \Add2~62\);

\Add2~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~5_sumout\ = SUM(( \mv.sum[-2]~q\ ) + ( GND ) + ( \Add2~62\ ))
-- \Add2~6\ = CARRY(( \mv.sum[-2]~q\ ) + ( GND ) + ( \Add2~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-2]~q\,
	cin => \Add2~62\,
	sumout => \Add2~5_sumout\,
	cout => \Add2~6\);

\Add2~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~9_sumout\ = SUM(( \mv.sum[-1]~q\ ) + ( GND ) + ( \Add2~6\ ))
-- \Add2~10\ = CARRY(( \mv.sum[-1]~q\ ) + ( GND ) + ( \Add2~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum[-1]~q\,
	cin => \Add2~6\,
	sumout => \Add2~9_sumout\,
	cout => \Add2~10\);

\Add2~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~13_sumout\ = SUM(( \mv.sum\(0) ) + ( GND ) + ( \Add2~10\ ))
-- \Add2~14\ = CARRY(( \mv.sum\(0) ) + ( GND ) + ( \Add2~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum\(0),
	cin => \Add2~10\,
	sumout => \Add2~13_sumout\,
	cout => \Add2~14\);

\Add2~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~17_sumout\ = SUM(( \mv.sum\(1) ) + ( GND ) + ( \Add2~14\ ))
-- \Add2~18\ = CARRY(( \mv.sum\(1) ) + ( GND ) + ( \Add2~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum\(1),
	cin => \Add2~14\,
	sumout => \Add2~17_sumout\,
	cout => \Add2~18\);

\Add2~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~65_sumout\ = SUM(( \mv.sum\(2) ) + ( GND ) + ( \Add2~18\ ))
-- \Add2~66\ = CARRY(( \mv.sum\(2) ) + ( GND ) + ( \Add2~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum\(2),
	cin => \Add2~18\,
	sumout => \Add2~65_sumout\,
	cout => \Add2~66\);

\Add2~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~21_sumout\ = SUM(( \mv.sum\(3) ) + ( GND ) + ( \Add2~66\ ))
-- \Add2~22\ = CARRY(( \mv.sum\(3) ) + ( GND ) + ( \Add2~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum\(3),
	cin => \Add2~66\,
	sumout => \Add2~21_sumout\,
	cout => \Add2~22\);

\Add2~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~49_sumout\ = SUM(( \mv.sum\(4) ) + ( GND ) + ( \Add2~22\ ))
-- \Add2~50\ = CARRY(( \mv.sum\(4) ) + ( GND ) + ( \Add2~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum\(4),
	cin => \Add2~22\,
	sumout => \Add2~49_sumout\,
	cout => \Add2~50\);

\Add2~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~1_sumout\ = SUM(( \mv.sum\(4) ) + ( GND ) + ( \Add2~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.sum\(4),
	cin => \Add2~50\,
	sumout => \Add2~1_sumout\);

\Result~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~0_combout\ = ( !\Add2~41_sumout\ & ( !\Add2~45_sumout\ & ( (!\Add2~25_sumout\ & (!\Add2~29_sumout\ & (!\Add2~33_sumout\ & !\Add2~37_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~25_sumout\,
	datab => \ALT_INV_Add2~29_sumout\,
	datac => \ALT_INV_Add2~33_sumout\,
	datad => \ALT_INV_Add2~37_sumout\,
	datae => \ALT_INV_Add2~41_sumout\,
	dataf => \ALT_INV_Add2~45_sumout\,
	combout => \Result~0_combout\);

\Result~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~1_combout\ = ( !\Add2~21_sumout\ & ( \Result~0_combout\ & ( (!\Add2~5_sumout\ & (!\Add2~9_sumout\ & (!\Add2~13_sumout\ & !\Add2~17_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~5_sumout\,
	datab => \ALT_INV_Add2~9_sumout\,
	datac => \ALT_INV_Add2~13_sumout\,
	datad => \ALT_INV_Add2~17_sumout\,
	datae => \ALT_INV_Add2~21_sumout\,
	dataf => \ALT_INV_Result~0_combout\,
	combout => \Result~1_combout\);

\Result~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~2_combout\ = (!\Add2~69_sumout\ & !\Add2~73_sumout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000100010001000100010001000100010001000100010001000100010001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~69_sumout\,
	datab => \ALT_INV_Add2~73_sumout\,
	combout => \Result~2_combout\);

\Result~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~3_combout\ = ( !\Add2~65_sumout\ & ( \Result~2_combout\ & ( (!\Add2~49_sumout\ & (!\Add2~53_sumout\ & (!\Add2~57_sumout\ & !\Add2~61_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~49_sumout\,
	datab => \ALT_INV_Add2~53_sumout\,
	datac => \ALT_INV_Add2~57_sumout\,
	datad => \ALT_INV_Add2~61_sumout\,
	datae => \ALT_INV_Add2~65_sumout\,
	dataf => \ALT_INV_Result~2_combout\,
	combout => \Result~3_combout\);

\rounds~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rounds~0_combout\ = ( \mv.sum[-17]~q\ & ( \mv.sum[-14]~q\ ) ) # ( !\mv.sum[-17]~q\ & ( (\mv.sum[-14]~q\ & (((\mv.sum[-16]~q\) # (\mv.sum[-15]~q\)) # (\mv.sum[-13]~q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001001100110011001100110011001100010011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-13]~q\,
	datab => \ALT_INV_mv.sum[-14]~q\,
	datac => \ALT_INV_mv.sum[-15]~q\,
	datad => \ALT_INV_mv.sum[-16]~q\,
	datae => \ALT_INV_mv.sum[-17]~q\,
	combout => \rounds~0_combout\);

\round_overflow~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \round_overflow~0_combout\ = (\rounds~0_combout\ & (!\mv.sum\(4) $ (!\Add2~49_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011000000110000001100000011000000110000001100000011000000110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \round_overflow~0_combout\);

\Result~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~4_combout\ = (!\mv.sum[-13]~q\ & (\Add2~25_sumout\ & ((\rounds~0_combout\)))) # (\mv.sum[-13]~q\ & ((!\mv.sum[-14]~q\) # ((\Add2~25_sumout\ & \rounds~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000001110011010100000111001101010000011100110101000001110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-13]~q\,
	datab => \ALT_INV_Add2~25_sumout\,
	datac => \ALT_INV_mv.sum[-14]~q\,
	datad => \ALT_INV_rounds~0_combout\,
	combout => \Result~4_combout\);

\Result~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~5_combout\ = ( \round_overflow~0_combout\ & ( \Result~4_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~4_combout\ ) ) # ( \round_overflow~0_combout\ 
-- & ( !\Result~4_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~4_combout\,
	combout => \Result~5_combout\);

\y[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~5_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[0]~reg0_q\);

\Result~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~6_combout\ = (!\rounds~0_combout\ & (\mv.sum[-12]~q\)) # (\rounds~0_combout\ & ((\Add2~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-12]~q\,
	datab => \ALT_INV_Add2~29_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~6_combout\);

\Result~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~7_combout\ = ( \round_overflow~0_combout\ & ( \Result~6_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~6_combout\ ) ) # ( \round_overflow~0_combout\ 
-- & ( !\Result~6_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~6_combout\,
	combout => \Result~7_combout\);

\y[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~7_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[1]~reg0_q\);

\Result~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~8_combout\ = (!\rounds~0_combout\ & (\mv.sum[-11]~q\)) # (\rounds~0_combout\ & ((\Add2~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-11]~q\,
	datab => \ALT_INV_Add2~33_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~8_combout\);

\Result~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~9_combout\ = ( \round_overflow~0_combout\ & ( \Result~8_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~8_combout\ ) ) # ( \round_overflow~0_combout\ 
-- & ( !\Result~8_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~8_combout\,
	combout => \Result~9_combout\);

\y[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~9_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[2]~reg0_q\);

\Result~10\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~10_combout\ = (!\rounds~0_combout\ & (\mv.sum[-10]~q\)) # (\rounds~0_combout\ & ((\Add2~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-10]~q\,
	datab => \ALT_INV_Add2~37_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~10_combout\);

\Result~11\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~11_combout\ = ( \round_overflow~0_combout\ & ( \Result~10_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~10_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~10_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~10_combout\,
	combout => \Result~11_combout\);

\y[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~11_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[3]~reg0_q\);

\Result~12\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~12_combout\ = (!\rounds~0_combout\ & (\mv.sum[-9]~q\)) # (\rounds~0_combout\ & ((\Add2~41_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-9]~q\,
	datab => \ALT_INV_Add2~41_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~12_combout\);

\Result~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~13_combout\ = ( \round_overflow~0_combout\ & ( \Result~12_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~12_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~12_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~12_combout\,
	combout => \Result~13_combout\);

\y[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~13_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[4]~reg0_q\);

\Result~14\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~14_combout\ = (!\rounds~0_combout\ & (\mv.sum[-8]~q\)) # (\rounds~0_combout\ & ((\Add2~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-8]~q\,
	datab => \ALT_INV_Add2~45_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~14_combout\);

\Result~15\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~15_combout\ = ( \round_overflow~0_combout\ & ( \Result~14_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~14_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~14_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~14_combout\,
	combout => \Result~15_combout\);

\y[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~15_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[5]~reg0_q\);

\Result~16\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~16_combout\ = (!\rounds~0_combout\ & (\mv.sum[-7]~q\)) # (\rounds~0_combout\ & ((\Add2~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-7]~q\,
	datab => \ALT_INV_Add2~69_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~16_combout\);

\Result~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~17_combout\ = ( \round_overflow~0_combout\ & ( \Result~16_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~16_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~16_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~16_combout\,
	combout => \Result~17_combout\);

\y[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~17_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[6]~reg0_q\);

\Result~18\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~18_combout\ = (!\rounds~0_combout\ & (\mv.sum[-6]~q\)) # (\rounds~0_combout\ & ((\Add2~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-6]~q\,
	datab => \ALT_INV_Add2~73_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~18_combout\);

\Result~19\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~19_combout\ = ( \round_overflow~0_combout\ & ( \Result~18_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~18_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~18_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~18_combout\,
	combout => \Result~19_combout\);

\y[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~19_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[7]~reg0_q\);

\Result~20\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~20_combout\ = (!\rounds~0_combout\ & (\mv.sum[-5]~q\)) # (\rounds~0_combout\ & ((\Add2~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-5]~q\,
	datab => \ALT_INV_Add2~53_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~20_combout\);

\Result~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~21_combout\ = ( \round_overflow~0_combout\ & ( \Result~20_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~20_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~20_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~20_combout\,
	combout => \Result~21_combout\);

\y[8]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~21_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[8]~reg0_q\);

\Result~22\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~22_combout\ = (!\rounds~0_combout\ & (\mv.sum[-4]~q\)) # (\rounds~0_combout\ & ((\Add2~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-4]~q\,
	datab => \ALT_INV_Add2~57_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~22_combout\);

\Result~23\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~23_combout\ = ( \round_overflow~0_combout\ & ( \Result~22_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~22_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~22_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~22_combout\,
	combout => \Result~23_combout\);

\y[9]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~23_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[9]~reg0_q\);

\Result~24\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~24_combout\ = (!\rounds~0_combout\ & (\mv.sum[-3]~q\)) # (\rounds~0_combout\ & ((\Add2~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-3]~q\,
	datab => \ALT_INV_Add2~61_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~24_combout\);

\Result~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~25_combout\ = ( \round_overflow~0_combout\ & ( \Result~24_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~24_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~24_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~24_combout\,
	combout => \Result~25_combout\);

\y[10]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~25_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[10]~reg0_q\);

\Result~26\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~26_combout\ = (!\rounds~0_combout\ & (\mv.sum[-2]~q\)) # (\rounds~0_combout\ & ((\Add2~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-2]~q\,
	datab => \ALT_INV_Add2~5_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~26_combout\);

\Result~27\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~27_combout\ = ( \round_overflow~0_combout\ & ( \Result~26_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~26_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~26_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~26_combout\,
	combout => \Result~27_combout\);

\y[11]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~27_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[11]~reg0_q\);

\Result~28\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~28_combout\ = (!\rounds~0_combout\ & (\mv.sum[-1]~q\)) # (\rounds~0_combout\ & ((\Add2~9_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum[-1]~q\,
	datab => \ALT_INV_Add2~9_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~28_combout\);

\Result~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~29_combout\ = ( \round_overflow~0_combout\ & ( \Result~28_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~28_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~28_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~28_combout\,
	combout => \Result~29_combout\);

\y[12]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~29_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[12]~reg0_q\);

\Result~30\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~30_combout\ = (!\rounds~0_combout\ & (\mv.sum\(0))) # (\rounds~0_combout\ & ((\Add2~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(0),
	datab => \ALT_INV_Add2~13_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~30_combout\);

\Result~31\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~31_combout\ = ( \round_overflow~0_combout\ & ( \Result~30_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~30_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~30_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~30_combout\,
	combout => \Result~31_combout\);

\y[13]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~31_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[13]~reg0_q\);

\Result~32\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~32_combout\ = (!\rounds~0_combout\ & (\mv.sum\(1))) # (\rounds~0_combout\ & ((\Add2~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(1),
	datab => \ALT_INV_Add2~17_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~32_combout\);

\Result~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~33_combout\ = ( \round_overflow~0_combout\ & ( \Result~32_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~32_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~32_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~32_combout\,
	combout => \Result~33_combout\);

\y[14]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~33_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[14]~reg0_q\);

\Result~34\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~34_combout\ = (!\rounds~0_combout\ & (\mv.sum\(2))) # (\rounds~0_combout\ & ((\Add2~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(2),
	datab => \ALT_INV_Add2~65_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~34_combout\);

\Result~35\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~35_combout\ = ( \round_overflow~0_combout\ & ( \Result~34_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~34_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~34_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~34_combout\,
	combout => \Result~35_combout\);

\y[15]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~35_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[15]~reg0_q\);

\Result~36\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~36_combout\ = (!\rounds~0_combout\ & (\mv.sum\(3))) # (\rounds~0_combout\ & ((\Add2~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(3),
	datab => \ALT_INV_Add2~21_sumout\,
	datac => \ALT_INV_rounds~0_combout\,
	combout => \Result~36_combout\);

\Result~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~37_combout\ = ( \round_overflow~0_combout\ & ( \Result~36_combout\ & ( (!\mv.sum\(4)) # ((!\Add2~1_sumout\ & (\Result~1_combout\ & \Result~3_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~36_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~36_combout\ & ( (!\mv.sum\(4) & (((!\Result~1_combout\) # (!\Result~3_combout\)) # (\Add2~1_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010001011111111111111111010101010101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_Result~1_combout\,
	datad => \ALT_INV_Result~3_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~36_combout\,
	combout => \Result~37_combout\);

\y[16]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~37_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[16]~reg0_q\);

\Result~38\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~38_combout\ = ( !\Add2~61_sumout\ & ( !\Add2~65_sumout\ & ( (!\Add2~69_sumout\ & (!\Add2~73_sumout\ & (!\Add2~53_sumout\ & !\Add2~57_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~69_sumout\,
	datab => \ALT_INV_Add2~73_sumout\,
	datac => \ALT_INV_Add2~53_sumout\,
	datad => \ALT_INV_Add2~57_sumout\,
	datae => \ALT_INV_Add2~61_sumout\,
	dataf => \ALT_INV_Add2~65_sumout\,
	combout => \Result~38_combout\);

\Result~39\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~39_combout\ = ( \Result~1_combout\ & ( \Result~38_combout\ & ( (\mv.sum\(4) & (((!\rounds~0_combout\) # (\Add2~1_sumout\)) # (\Add2~49_sumout\))) ) ) ) # ( !\Result~1_combout\ & ( \Result~38_combout\ & ( \mv.sum\(4) ) ) ) # ( \Result~1_combout\ & 
-- ( !\Result~38_combout\ & ( \mv.sum\(4) ) ) ) # ( !\Result~1_combout\ & ( !\Result~38_combout\ & ( \mv.sum\(4) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010101010101010101010101010100010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.sum\(4),
	datab => \ALT_INV_Add2~49_sumout\,
	datac => \ALT_INV_Add2~1_sumout\,
	datad => \ALT_INV_rounds~0_combout\,
	datae => \ALT_INV_Result~1_combout\,
	dataf => \ALT_INV_Result~38_combout\,
	combout => \Result~39_combout\);

\y[17]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~39_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y[17]~reg0_q\);

ww_y(0) <= \y[0]~output_o\;

ww_y(1) <= \y[1]~output_o\;

ww_y(2) <= \y[2]~output_o\;

ww_y(3) <= \y[3]~output_o\;

ww_y(4) <= \y[4]~output_o\;

ww_y(5) <= \y[5]~output_o\;

ww_y(6) <= \y[6]~output_o\;

ww_y(7) <= \y[7]~output_o\;

ww_y(8) <= \y[8]~output_o\;

ww_y(9) <= \y[9]~output_o\;

ww_y(10) <= \y[10]~output_o\;

ww_y(11) <= \y[11]~output_o\;

ww_y(12) <= \y[12]~output_o\;

ww_y(13) <= \y[13]~output_o\;

ww_y(14) <= \y[14]~output_o\;

ww_y(15) <= \y[15]~output_o\;

ww_y(16) <= \y[16]~output_o\;

ww_y(17) <= \y[17]~output_o\;
END structure;


