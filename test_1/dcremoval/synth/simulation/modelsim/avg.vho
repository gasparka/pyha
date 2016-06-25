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

-- DATE "06/25/2016 17:39:27"

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
	x1 : IN std_logic_vector(17 DOWNTO 0);
	x2 : IN std_logic_vector(17 DOWNTO 0);
	y1 : OUT std_logic_vector(17 DOWNTO 0);
	y2 : OUT std_logic_vector(17 DOWNTO 0)
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
SIGNAL ww_x1 : std_logic_vector(17 DOWNTO 0);
SIGNAL ww_x2 : std_logic_vector(17 DOWNTO 0);
SIGNAL ww_y1 : std_logic_vector(17 DOWNTO 0);
SIGNAL ww_y2 : std_logic_vector(17 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTADATAIN_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTBDATAOUT_bus\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \y1[0]~output_o\ : std_logic;
SIGNAL \y1[1]~output_o\ : std_logic;
SIGNAL \y1[2]~output_o\ : std_logic;
SIGNAL \y1[3]~output_o\ : std_logic;
SIGNAL \y1[4]~output_o\ : std_logic;
SIGNAL \y1[5]~output_o\ : std_logic;
SIGNAL \y1[6]~output_o\ : std_logic;
SIGNAL \y1[7]~output_o\ : std_logic;
SIGNAL \y1[8]~output_o\ : std_logic;
SIGNAL \y1[9]~output_o\ : std_logic;
SIGNAL \y1[10]~output_o\ : std_logic;
SIGNAL \y1[11]~output_o\ : std_logic;
SIGNAL \y1[12]~output_o\ : std_logic;
SIGNAL \y1[13]~output_o\ : std_logic;
SIGNAL \y1[14]~output_o\ : std_logic;
SIGNAL \y1[15]~output_o\ : std_logic;
SIGNAL \y1[16]~output_o\ : std_logic;
SIGNAL \y1[17]~output_o\ : std_logic;
SIGNAL \y2[0]~output_o\ : std_logic;
SIGNAL \y2[1]~output_o\ : std_logic;
SIGNAL \y2[2]~output_o\ : std_logic;
SIGNAL \y2[3]~output_o\ : std_logic;
SIGNAL \y2[4]~output_o\ : std_logic;
SIGNAL \y2[5]~output_o\ : std_logic;
SIGNAL \y2[6]~output_o\ : std_logic;
SIGNAL \y2[7]~output_o\ : std_logic;
SIGNAL \y2[8]~output_o\ : std_logic;
SIGNAL \y2[9]~output_o\ : std_logic;
SIGNAL \y2[10]~output_o\ : std_logic;
SIGNAL \y2[11]~output_o\ : std_logic;
SIGNAL \y2[12]~output_o\ : std_logic;
SIGNAL \y2[13]~output_o\ : std_logic;
SIGNAL \y2[14]~output_o\ : std_logic;
SIGNAL \y2[15]~output_o\ : std_logic;
SIGNAL \y2[16]~output_o\ : std_logic;
SIGNAL \y2[17]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \x1[17]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \rst_n~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe7~0_combout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe7~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][0]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~2\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~6\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~9_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~10\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~13_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][0]~q\ : std_logic;
SIGNAL \Add1~7\ : std_logic;
SIGNAL \Add1~9_sumout\ : std_logic;
SIGNAL \x1[16]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-1]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-1]~q\ : std_logic;
SIGNAL \x1[15]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-2]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-2]~q\ : std_logic;
SIGNAL \x1[14]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-3]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-3]~q\ : std_logic;
SIGNAL \x1[13]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-4]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-4]~q\ : std_logic;
SIGNAL \x1[12]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-5]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-5]~q\ : std_logic;
SIGNAL \x1[11]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-6]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-6]~q\ : std_logic;
SIGNAL \x1[10]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-7]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-7]~q\ : std_logic;
SIGNAL \x1[9]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-8]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-8]~q\ : std_logic;
SIGNAL \x1[8]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-9]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-9]~q\ : std_logic;
SIGNAL \x1[7]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-10]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-10]~q\ : std_logic;
SIGNAL \x1[6]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-11]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-11]~q\ : std_logic;
SIGNAL \x1[5]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-12]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-12]~q\ : std_logic;
SIGNAL \x1[4]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-13]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-13]~q\ : std_logic;
SIGNAL \x1[3]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-14]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-14]~q\ : std_logic;
SIGNAL \x1[2]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-15]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-15]~q\ : std_logic;
SIGNAL \x1[1]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-16]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-16]~q\ : std_logic;
SIGNAL \x1[0]~input_o\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[0][-17]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr[15][-17]~q\ : std_logic;
SIGNAL \Add1~98_cout\ : std_logic;
SIGNAL \Add1~99\ : std_logic;
SIGNAL \Add1~21_sumout\ : std_logic;
SIGNAL \Result~202_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-17]~q\ : std_logic;
SIGNAL \Add1~22\ : std_logic;
SIGNAL \Add1~23\ : std_logic;
SIGNAL \Add1~25_sumout\ : std_logic;
SIGNAL \Result~203_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-16]~q\ : std_logic;
SIGNAL \Add1~26\ : std_logic;
SIGNAL \Add1~27\ : std_logic;
SIGNAL \Add1~29_sumout\ : std_logic;
SIGNAL \Result~204_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-15]~q\ : std_logic;
SIGNAL \Add1~30\ : std_logic;
SIGNAL \Add1~31\ : std_logic;
SIGNAL \Add1~17_sumout\ : std_logic;
SIGNAL \Result~201_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-14]~q\ : std_logic;
SIGNAL \Add1~18\ : std_logic;
SIGNAL \Add1~19\ : std_logic;
SIGNAL \Add1~13_sumout\ : std_logic;
SIGNAL \Result~200_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-13]~q\ : std_logic;
SIGNAL \Add1~14\ : std_logic;
SIGNAL \Add1~15\ : std_logic;
SIGNAL \Add1~37_sumout\ : std_logic;
SIGNAL \Result~206_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-12]~q\ : std_logic;
SIGNAL \Add1~38\ : std_logic;
SIGNAL \Add1~39\ : std_logic;
SIGNAL \Add1~45_sumout\ : std_logic;
SIGNAL \Result~208_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-11]~q\ : std_logic;
SIGNAL \Add1~46\ : std_logic;
SIGNAL \Add1~47\ : std_logic;
SIGNAL \Add1~33_sumout\ : std_logic;
SIGNAL \Result~205_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-10]~q\ : std_logic;
SIGNAL \Add1~34\ : std_logic;
SIGNAL \Add1~35\ : std_logic;
SIGNAL \Add1~41_sumout\ : std_logic;
SIGNAL \Result~207_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-9]~q\ : std_logic;
SIGNAL \Add1~42\ : std_logic;
SIGNAL \Add1~43\ : std_logic;
SIGNAL \Add1~49_sumout\ : std_logic;
SIGNAL \Result~209_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-8]~q\ : std_logic;
SIGNAL \Add1~50\ : std_logic;
SIGNAL \Add1~51\ : std_logic;
SIGNAL \Add1~53_sumout\ : std_logic;
SIGNAL \Result~210_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-7]~q\ : std_logic;
SIGNAL \Add1~54\ : std_logic;
SIGNAL \Add1~55\ : std_logic;
SIGNAL \Add1~57_sumout\ : std_logic;
SIGNAL \Result~211_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-6]~q\ : std_logic;
SIGNAL \Add1~58\ : std_logic;
SIGNAL \Add1~59\ : std_logic;
SIGNAL \Add1~61_sumout\ : std_logic;
SIGNAL \Result~212_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-5]~q\ : std_logic;
SIGNAL \Add1~62\ : std_logic;
SIGNAL \Add1~63\ : std_logic;
SIGNAL \Add1~65_sumout\ : std_logic;
SIGNAL \Result~213_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-4]~q\ : std_logic;
SIGNAL \Add1~66\ : std_logic;
SIGNAL \Add1~67\ : std_logic;
SIGNAL \Add1~69_sumout\ : std_logic;
SIGNAL \Result~214_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-3]~q\ : std_logic;
SIGNAL \Add1~70\ : std_logic;
SIGNAL \Add1~71\ : std_logic;
SIGNAL \Add1~73_sumout\ : std_logic;
SIGNAL \Result~215_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-2]~q\ : std_logic;
SIGNAL \Add1~74\ : std_logic;
SIGNAL \Add1~75\ : std_logic;
SIGNAL \Add1~77_sumout\ : std_logic;
SIGNAL \Result~216_combout\ : std_logic;
SIGNAL \mv.iav.av[0].sum[-1]~q\ : std_logic;
SIGNAL \Add1~78\ : std_logic;
SIGNAL \Add1~79\ : std_logic;
SIGNAL \Add1~81_sumout\ : std_logic;
SIGNAL \Result~217_combout\ : std_logic;
SIGNAL \Add1~82\ : std_logic;
SIGNAL \Add1~83\ : std_logic;
SIGNAL \Add1~85_sumout\ : std_logic;
SIGNAL \Result~218_combout\ : std_logic;
SIGNAL \Add1~86\ : std_logic;
SIGNAL \Add1~87\ : std_logic;
SIGNAL \Add1~89_sumout\ : std_logic;
SIGNAL \Result~219_combout\ : std_logic;
SIGNAL \Add1~90\ : std_logic;
SIGNAL \Add1~91\ : std_logic;
SIGNAL \Add1~95\ : std_logic;
SIGNAL \Add1~5_sumout\ : std_logic;
SIGNAL \Add1~93_sumout\ : std_logic;
SIGNAL \Result~220_combout\ : std_logic;
SIGNAL \Add1~94\ : std_logic;
SIGNAL \Add1~6\ : std_logic;
SIGNAL \Add1~10\ : std_logic;
SIGNAL \Add1~11\ : std_logic;
SIGNAL \Add1~1_sumout\ : std_logic;
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
SIGNAL \Add2~22\ : std_logic;
SIGNAL \Add2~18\ : std_logic;
SIGNAL \Add2~14\ : std_logic;
SIGNAL \Add2~10\ : std_logic;
SIGNAL \Add2~54\ : std_logic;
SIGNAL \Add2~6\ : std_logic;
SIGNAL \Add2~1_sumout\ : std_logic;
SIGNAL \rounds~2_combout\ : std_logic;
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
SIGNAL \Result~120_combout\ : std_logic;
SIGNAL \Result~121_combout\ : std_logic;
SIGNAL \Add2~2\ : std_logic;
SIGNAL \Add2~49_sumout\ : std_logic;
SIGNAL \Add2~53_sumout\ : std_logic;
SIGNAL \Add2~57_sumout\ : std_logic;
SIGNAL \Add2~61_sumout\ : std_logic;
SIGNAL \Add2~65_sumout\ : std_logic;
SIGNAL \Add2~69_sumout\ : std_logic;
SIGNAL \Add2~73_sumout\ : std_logic;
SIGNAL \Result~122_combout\ : std_logic;
SIGNAL \Result~123_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe6~0_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe6~q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~2\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~6\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~9_sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~10\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~13_sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ : std_logic;
SIGNAL \Add4~7\ : std_logic;
SIGNAL \Add4~9_sumout\ : std_logic;
SIGNAL \Result~124_combout\ : std_logic;
SIGNAL \Result~125_combout\ : std_logic;
SIGNAL \round_overflow~0_combout\ : std_logic;
SIGNAL \Result~158_combout\ : std_logic;
SIGNAL \Result~159_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1~portbdataout\ : std_logic;
SIGNAL \Result~156_combout\ : std_logic;
SIGNAL \Result~157_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2~portbdataout\ : std_logic;
SIGNAL \Result~154_combout\ : std_logic;
SIGNAL \Result~155_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3~portbdataout\ : std_logic;
SIGNAL \Result~152_combout\ : std_logic;
SIGNAL \Result~153_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4~portbdataout\ : std_logic;
SIGNAL \Result~150_combout\ : std_logic;
SIGNAL \Result~151_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5~portbdataout\ : std_logic;
SIGNAL \Result~148_combout\ : std_logic;
SIGNAL \Result~149_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6~portbdataout\ : std_logic;
SIGNAL \Result~146_combout\ : std_logic;
SIGNAL \Result~147_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7~portbdataout\ : std_logic;
SIGNAL \Result~144_combout\ : std_logic;
SIGNAL \Result~145_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8~portbdataout\ : std_logic;
SIGNAL \Result~142_combout\ : std_logic;
SIGNAL \Result~143_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9~portbdataout\ : std_logic;
SIGNAL \Result~140_combout\ : std_logic;
SIGNAL \Result~141_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10~portbdataout\ : std_logic;
SIGNAL \Result~138_combout\ : std_logic;
SIGNAL \Result~139_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11~portbdataout\ : std_logic;
SIGNAL \Result~136_combout\ : std_logic;
SIGNAL \Result~137_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12~portbdataout\ : std_logic;
SIGNAL \Result~132_combout\ : std_logic;
SIGNAL \Result~133_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13~portbdataout\ : std_logic;
SIGNAL \Result~126_combout\ : std_logic;
SIGNAL \Result~127_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14~portbdataout\ : std_logic;
SIGNAL \Result~134_combout\ : std_logic;
SIGNAL \Result~135_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15~portbdataout\ : std_logic;
SIGNAL \Result~130_combout\ : std_logic;
SIGNAL \Result~131_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16~portbdataout\ : std_logic;
SIGNAL \Result~128_combout\ : std_logic;
SIGNAL \Result~129_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17~portbdataout\ : std_logic;
SIGNAL \Add4~98_cout\ : std_logic;
SIGNAL \Add4~99\ : std_logic;
SIGNAL \Add4~17_sumout\ : std_logic;
SIGNAL \Result~79_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-17]~q\ : std_logic;
SIGNAL \Add4~18\ : std_logic;
SIGNAL \Add4~19\ : std_logic;
SIGNAL \Add4~21_sumout\ : std_logic;
SIGNAL \Result~80_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-16]~q\ : std_logic;
SIGNAL \Add4~22\ : std_logic;
SIGNAL \Add4~23\ : std_logic;
SIGNAL \Add4~29_sumout\ : std_logic;
SIGNAL \Result~82_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-15]~q\ : std_logic;
SIGNAL \Add4~30\ : std_logic;
SIGNAL \Add4~31\ : std_logic;
SIGNAL \Add4~14\ : std_logic;
SIGNAL \Add4~15\ : std_logic;
SIGNAL \Add4~25_sumout\ : std_logic;
SIGNAL \Result~81_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-13]~q\ : std_logic;
SIGNAL \Add4~26\ : std_logic;
SIGNAL \Add4~27\ : std_logic;
SIGNAL \Add4~33_sumout\ : std_logic;
SIGNAL \Result~83_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-12]~q\ : std_logic;
SIGNAL \Add4~34\ : std_logic;
SIGNAL \Add4~35\ : std_logic;
SIGNAL \Add4~37_sumout\ : std_logic;
SIGNAL \Result~84_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-11]~q\ : std_logic;
SIGNAL \Add4~38\ : std_logic;
SIGNAL \Add4~39\ : std_logic;
SIGNAL \Add4~41_sumout\ : std_logic;
SIGNAL \Result~85_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-10]~q\ : std_logic;
SIGNAL \Add4~42\ : std_logic;
SIGNAL \Add4~43\ : std_logic;
SIGNAL \Add4~45_sumout\ : std_logic;
SIGNAL \Result~86_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-9]~q\ : std_logic;
SIGNAL \Add4~46\ : std_logic;
SIGNAL \Add4~47\ : std_logic;
SIGNAL \Add4~49_sumout\ : std_logic;
SIGNAL \Result~87_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-8]~q\ : std_logic;
SIGNAL \Add4~50\ : std_logic;
SIGNAL \Add4~51\ : std_logic;
SIGNAL \Add4~53_sumout\ : std_logic;
SIGNAL \Result~88_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-7]~q\ : std_logic;
SIGNAL \Add4~54\ : std_logic;
SIGNAL \Add4~55\ : std_logic;
SIGNAL \Add4~57_sumout\ : std_logic;
SIGNAL \Result~89_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-6]~q\ : std_logic;
SIGNAL \Add4~58\ : std_logic;
SIGNAL \Add4~59\ : std_logic;
SIGNAL \Add4~61_sumout\ : std_logic;
SIGNAL \Result~90_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-5]~q\ : std_logic;
SIGNAL \Add4~62\ : std_logic;
SIGNAL \Add4~63\ : std_logic;
SIGNAL \Add4~65_sumout\ : std_logic;
SIGNAL \Result~91_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-4]~q\ : std_logic;
SIGNAL \Add4~66\ : std_logic;
SIGNAL \Add4~67\ : std_logic;
SIGNAL \Add4~69_sumout\ : std_logic;
SIGNAL \Result~92_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-3]~q\ : std_logic;
SIGNAL \Add4~70\ : std_logic;
SIGNAL \Add4~71\ : std_logic;
SIGNAL \Add4~73_sumout\ : std_logic;
SIGNAL \Result~93_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-2]~q\ : std_logic;
SIGNAL \Add4~74\ : std_logic;
SIGNAL \Add4~75\ : std_logic;
SIGNAL \Add4~77_sumout\ : std_logic;
SIGNAL \Result~94_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-1]~q\ : std_logic;
SIGNAL \Add4~78\ : std_logic;
SIGNAL \Add4~79\ : std_logic;
SIGNAL \Add4~81_sumout\ : std_logic;
SIGNAL \Result~95_combout\ : std_logic;
SIGNAL \Add4~82\ : std_logic;
SIGNAL \Add4~83\ : std_logic;
SIGNAL \Add4~85_sumout\ : std_logic;
SIGNAL \Result~96_combout\ : std_logic;
SIGNAL \Add4~86\ : std_logic;
SIGNAL \Add4~87\ : std_logic;
SIGNAL \Add4~89_sumout\ : std_logic;
SIGNAL \Result~97_combout\ : std_logic;
SIGNAL \Add4~90\ : std_logic;
SIGNAL \Add4~91\ : std_logic;
SIGNAL \Add4~95\ : std_logic;
SIGNAL \Add4~5_sumout\ : std_logic;
SIGNAL \Add4~93_sumout\ : std_logic;
SIGNAL \Result~98_combout\ : std_logic;
SIGNAL \Add4~94\ : std_logic;
SIGNAL \Add4~6\ : std_logic;
SIGNAL \Add4~10\ : std_logic;
SIGNAL \Add4~11\ : std_logic;
SIGNAL \Add4~1_sumout\ : std_logic;
SIGNAL \Add4~13_sumout\ : std_logic;
SIGNAL \Result~78_combout\ : std_logic;
SIGNAL \mv.iav.av[1].sum[-14]~q\ : std_logic;
SIGNAL \rounds~0_combout\ : std_logic;
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
SIGNAL \Add5~5_sumout\ : std_logic;
SIGNAL \Add5~9_sumout\ : std_logic;
SIGNAL \Add5~13_sumout\ : std_logic;
SIGNAL \Add5~17_sumout\ : std_logic;
SIGNAL \Add5~21_sumout\ : std_logic;
SIGNAL \Add5~25_sumout\ : std_logic;
SIGNAL \Add5~29_sumout\ : std_logic;
SIGNAL \Add5~33_sumout\ : std_logic;
SIGNAL \Add5~37_sumout\ : std_logic;
SIGNAL \Add5~41_sumout\ : std_logic;
SIGNAL \Add5~45_sumout\ : std_logic;
SIGNAL \Result~34_combout\ : std_logic;
SIGNAL \Result~35_combout\ : std_logic;
SIGNAL \Add5~2\ : std_logic;
SIGNAL \Add5~49_sumout\ : std_logic;
SIGNAL \Add5~53_sumout\ : std_logic;
SIGNAL \Add5~57_sumout\ : std_logic;
SIGNAL \Add5~61_sumout\ : std_logic;
SIGNAL \Add5~65_sumout\ : std_logic;
SIGNAL \Add5~69_sumout\ : std_logic;
SIGNAL \Add5~73_sumout\ : std_logic;
SIGNAL \Result~36_combout\ : std_logic;
SIGNAL \Result~37_combout\ : std_logic;
SIGNAL \Result~38_combout\ : std_logic;
SIGNAL \overflowx~0_combout\ : std_logic;
SIGNAL \Result~55_combout\ : std_logic;
SIGNAL \Result~54_combout\ : std_logic;
SIGNAL \Result~53_combout\ : std_logic;
SIGNAL \Result~52_combout\ : std_logic;
SIGNAL \Result~51_combout\ : std_logic;
SIGNAL \Result~50_combout\ : std_logic;
SIGNAL \Result~49_combout\ : std_logic;
SIGNAL \Result~48_combout\ : std_logic;
SIGNAL \Result~47_combout\ : std_logic;
SIGNAL \Result~46_combout\ : std_logic;
SIGNAL \Result~45_combout\ : std_logic;
SIGNAL \Result~44_combout\ : std_logic;
SIGNAL \Result~43_combout\ : std_logic;
SIGNAL \Result~42_combout\ : std_logic;
SIGNAL \Result~41_combout\ : std_logic;
SIGNAL \Result~40_combout\ : std_logic;
SIGNAL \Result~39_combout\ : std_logic;
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
SIGNAL \Add6~2\ : std_logic;
SIGNAL \Add6~5_sumout\ : std_logic;
SIGNAL \Add6~9_sumout\ : std_logic;
SIGNAL \Result~0_combout\ : std_logic;
SIGNAL \y1[0]~reg0_q\ : std_logic;
SIGNAL \Add6~13_sumout\ : std_logic;
SIGNAL \Result~1_combout\ : std_logic;
SIGNAL \y1[1]~reg0_q\ : std_logic;
SIGNAL \Add6~17_sumout\ : std_logic;
SIGNAL \Result~2_combout\ : std_logic;
SIGNAL \y1[2]~reg0_q\ : std_logic;
SIGNAL \Add6~21_sumout\ : std_logic;
SIGNAL \Result~3_combout\ : std_logic;
SIGNAL \y1[3]~reg0_q\ : std_logic;
SIGNAL \Add6~25_sumout\ : std_logic;
SIGNAL \Result~4_combout\ : std_logic;
SIGNAL \y1[4]~reg0_q\ : std_logic;
SIGNAL \Add6~29_sumout\ : std_logic;
SIGNAL \Result~5_combout\ : std_logic;
SIGNAL \y1[5]~reg0_q\ : std_logic;
SIGNAL \Add6~33_sumout\ : std_logic;
SIGNAL \Result~6_combout\ : std_logic;
SIGNAL \y1[6]~reg0_q\ : std_logic;
SIGNAL \Add6~37_sumout\ : std_logic;
SIGNAL \Result~7_combout\ : std_logic;
SIGNAL \y1[7]~reg0_q\ : std_logic;
SIGNAL \Add6~41_sumout\ : std_logic;
SIGNAL \Result~8_combout\ : std_logic;
SIGNAL \y1[8]~reg0_q\ : std_logic;
SIGNAL \Add6~45_sumout\ : std_logic;
SIGNAL \Result~9_combout\ : std_logic;
SIGNAL \y1[9]~reg0_q\ : std_logic;
SIGNAL \Add6~49_sumout\ : std_logic;
SIGNAL \Result~10_combout\ : std_logic;
SIGNAL \y1[10]~reg0_q\ : std_logic;
SIGNAL \Add6~53_sumout\ : std_logic;
SIGNAL \Result~11_combout\ : std_logic;
SIGNAL \y1[11]~reg0_q\ : std_logic;
SIGNAL \Add6~57_sumout\ : std_logic;
SIGNAL \Result~12_combout\ : std_logic;
SIGNAL \y1[12]~reg0_q\ : std_logic;
SIGNAL \Add6~61_sumout\ : std_logic;
SIGNAL \Result~13_combout\ : std_logic;
SIGNAL \y1[13]~reg0_q\ : std_logic;
SIGNAL \Add6~65_sumout\ : std_logic;
SIGNAL \Result~14_combout\ : std_logic;
SIGNAL \y1[14]~reg0_q\ : std_logic;
SIGNAL \Add6~69_sumout\ : std_logic;
SIGNAL \Result~15_combout\ : std_logic;
SIGNAL \y1[15]~reg0_q\ : std_logic;
SIGNAL \Add6~73_sumout\ : std_logic;
SIGNAL \Result~16_combout\ : std_logic;
SIGNAL \y1[16]~reg0_q\ : std_logic;
SIGNAL \y1[17]~0_combout\ : std_logic;
SIGNAL \y1[17]~reg0_q\ : std_logic;
SIGNAL \x2[17]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][0]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][0]~q\ : std_logic;
SIGNAL \Add8~7\ : std_logic;
SIGNAL \Add8~9_sumout\ : std_logic;
SIGNAL \x2[16]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-1]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-1]~q\ : std_logic;
SIGNAL \x2[15]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-2]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-2]~q\ : std_logic;
SIGNAL \x2[14]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-3]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-3]~q\ : std_logic;
SIGNAL \x2[13]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-4]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-4]~q\ : std_logic;
SIGNAL \x2[12]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-5]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-5]~q\ : std_logic;
SIGNAL \x2[11]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-6]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-6]~q\ : std_logic;
SIGNAL \x2[10]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-7]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-7]~q\ : std_logic;
SIGNAL \x2[9]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-8]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-8]~q\ : std_logic;
SIGNAL \x2[8]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-9]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-9]~q\ : std_logic;
SIGNAL \x2[7]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-10]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-10]~q\ : std_logic;
SIGNAL \x2[6]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-11]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-11]~q\ : std_logic;
SIGNAL \x2[5]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-12]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-12]~q\ : std_logic;
SIGNAL \x2[4]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-13]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-13]~q\ : std_logic;
SIGNAL \x2[3]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-14]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-14]~q\ : std_logic;
SIGNAL \x2[2]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-15]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-15]~q\ : std_logic;
SIGNAL \x2[1]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-16]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-16]~q\ : std_logic;
SIGNAL \x2[0]~input_o\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[0][-17]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35~portbdataout\ : std_logic;
SIGNAL \mv.qav.av[0].in_sr[15][-17]~q\ : std_logic;
SIGNAL \Add8~98_cout\ : std_logic;
SIGNAL \Add8~99\ : std_logic;
SIGNAL \Add8~21_sumout\ : std_logic;
SIGNAL \Result~223_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-17]~q\ : std_logic;
SIGNAL \Add8~22\ : std_logic;
SIGNAL \Add8~23\ : std_logic;
SIGNAL \Add8~25_sumout\ : std_logic;
SIGNAL \Result~224_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-16]~q\ : std_logic;
SIGNAL \Add8~26\ : std_logic;
SIGNAL \Add8~27\ : std_logic;
SIGNAL \Add8~29_sumout\ : std_logic;
SIGNAL \Result~225_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-15]~q\ : std_logic;
SIGNAL \Add8~30\ : std_logic;
SIGNAL \Add8~31\ : std_logic;
SIGNAL \Add8~17_sumout\ : std_logic;
SIGNAL \Result~222_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-14]~q\ : std_logic;
SIGNAL \Add8~18\ : std_logic;
SIGNAL \Add8~19\ : std_logic;
SIGNAL \Add8~13_sumout\ : std_logic;
SIGNAL \Result~221_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-13]~q\ : std_logic;
SIGNAL \Add8~14\ : std_logic;
SIGNAL \Add8~15\ : std_logic;
SIGNAL \Add8~37_sumout\ : std_logic;
SIGNAL \Result~227_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-12]~q\ : std_logic;
SIGNAL \Add8~38\ : std_logic;
SIGNAL \Add8~39\ : std_logic;
SIGNAL \Add8~45_sumout\ : std_logic;
SIGNAL \Result~229_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-11]~q\ : std_logic;
SIGNAL \Add8~46\ : std_logic;
SIGNAL \Add8~47\ : std_logic;
SIGNAL \Add8~33_sumout\ : std_logic;
SIGNAL \Result~226_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-10]~q\ : std_logic;
SIGNAL \Add8~34\ : std_logic;
SIGNAL \Add8~35\ : std_logic;
SIGNAL \Add8~41_sumout\ : std_logic;
SIGNAL \Result~228_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-9]~q\ : std_logic;
SIGNAL \Add8~42\ : std_logic;
SIGNAL \Add8~43\ : std_logic;
SIGNAL \Add8~49_sumout\ : std_logic;
SIGNAL \Result~230_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-8]~q\ : std_logic;
SIGNAL \Add8~50\ : std_logic;
SIGNAL \Add8~51\ : std_logic;
SIGNAL \Add8~53_sumout\ : std_logic;
SIGNAL \Result~231_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-7]~q\ : std_logic;
SIGNAL \Add8~54\ : std_logic;
SIGNAL \Add8~55\ : std_logic;
SIGNAL \Add8~57_sumout\ : std_logic;
SIGNAL \Result~232_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-6]~q\ : std_logic;
SIGNAL \Add8~58\ : std_logic;
SIGNAL \Add8~59\ : std_logic;
SIGNAL \Add8~61_sumout\ : std_logic;
SIGNAL \Result~233_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-5]~q\ : std_logic;
SIGNAL \Add8~62\ : std_logic;
SIGNAL \Add8~63\ : std_logic;
SIGNAL \Add8~65_sumout\ : std_logic;
SIGNAL \Result~234_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-4]~q\ : std_logic;
SIGNAL \Add8~66\ : std_logic;
SIGNAL \Add8~67\ : std_logic;
SIGNAL \Add8~69_sumout\ : std_logic;
SIGNAL \Result~235_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-3]~q\ : std_logic;
SIGNAL \Add8~70\ : std_logic;
SIGNAL \Add8~71\ : std_logic;
SIGNAL \Add8~73_sumout\ : std_logic;
SIGNAL \Result~236_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-2]~q\ : std_logic;
SIGNAL \Add8~74\ : std_logic;
SIGNAL \Add8~75\ : std_logic;
SIGNAL \Add8~77_sumout\ : std_logic;
SIGNAL \Result~237_combout\ : std_logic;
SIGNAL \mv.qav.av[0].sum[-1]~q\ : std_logic;
SIGNAL \Add8~78\ : std_logic;
SIGNAL \Add8~79\ : std_logic;
SIGNAL \Add8~81_sumout\ : std_logic;
SIGNAL \Result~238_combout\ : std_logic;
SIGNAL \Add8~82\ : std_logic;
SIGNAL \Add8~83\ : std_logic;
SIGNAL \Add8~85_sumout\ : std_logic;
SIGNAL \Result~239_combout\ : std_logic;
SIGNAL \Add8~86\ : std_logic;
SIGNAL \Add8~87\ : std_logic;
SIGNAL \Add8~89_sumout\ : std_logic;
SIGNAL \Result~240_combout\ : std_logic;
SIGNAL \Add8~90\ : std_logic;
SIGNAL \Add8~91\ : std_logic;
SIGNAL \Add8~95\ : std_logic;
SIGNAL \Add8~5_sumout\ : std_logic;
SIGNAL \Add8~93_sumout\ : std_logic;
SIGNAL \Result~241_combout\ : std_logic;
SIGNAL \Add8~94\ : std_logic;
SIGNAL \Add8~6\ : std_logic;
SIGNAL \Add8~10\ : std_logic;
SIGNAL \Add8~11\ : std_logic;
SIGNAL \Add8~1_sumout\ : std_logic;
SIGNAL \Add9~42\ : std_logic;
SIGNAL \Add9~46\ : std_logic;
SIGNAL \Add9~38\ : std_logic;
SIGNAL \Add9~34\ : std_logic;
SIGNAL \Add9~30\ : std_logic;
SIGNAL \Add9~26\ : std_logic;
SIGNAL \Add9~70\ : std_logic;
SIGNAL \Add9~74\ : std_logic;
SIGNAL \Add9~66\ : std_logic;
SIGNAL \Add9~62\ : std_logic;
SIGNAL \Add9~58\ : std_logic;
SIGNAL \Add9~22\ : std_logic;
SIGNAL \Add9~18\ : std_logic;
SIGNAL \Add9~14\ : std_logic;
SIGNAL \Add9~10\ : std_logic;
SIGNAL \Add9~54\ : std_logic;
SIGNAL \Add9~6\ : std_logic;
SIGNAL \Add9~1_sumout\ : std_logic;
SIGNAL \rounds~3_combout\ : std_logic;
SIGNAL \Add9~5_sumout\ : std_logic;
SIGNAL \Add9~9_sumout\ : std_logic;
SIGNAL \Add9~13_sumout\ : std_logic;
SIGNAL \Add9~17_sumout\ : std_logic;
SIGNAL \Add9~21_sumout\ : std_logic;
SIGNAL \Add9~25_sumout\ : std_logic;
SIGNAL \Add9~29_sumout\ : std_logic;
SIGNAL \Add9~33_sumout\ : std_logic;
SIGNAL \Add9~37_sumout\ : std_logic;
SIGNAL \Add9~41_sumout\ : std_logic;
SIGNAL \Add9~45_sumout\ : std_logic;
SIGNAL \Result~160_combout\ : std_logic;
SIGNAL \Result~161_combout\ : std_logic;
SIGNAL \Add9~2\ : std_logic;
SIGNAL \Add9~49_sumout\ : std_logic;
SIGNAL \Add9~53_sumout\ : std_logic;
SIGNAL \Add9~57_sumout\ : std_logic;
SIGNAL \Add9~61_sumout\ : std_logic;
SIGNAL \Add9~65_sumout\ : std_logic;
SIGNAL \Add9~69_sumout\ : std_logic;
SIGNAL \Add9~73_sumout\ : std_logic;
SIGNAL \Result~162_combout\ : std_logic;
SIGNAL \Result~163_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\ : std_logic;
SIGNAL \Add11~7\ : std_logic;
SIGNAL \Add11~9_sumout\ : std_logic;
SIGNAL \Result~164_combout\ : std_logic;
SIGNAL \Result~165_combout\ : std_logic;
SIGNAL \round_overflow~1_combout\ : std_logic;
SIGNAL \Result~198_combout\ : std_logic;
SIGNAL \Result~199_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19~portbdataout\ : std_logic;
SIGNAL \Result~196_combout\ : std_logic;
SIGNAL \Result~197_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20~portbdataout\ : std_logic;
SIGNAL \Result~194_combout\ : std_logic;
SIGNAL \Result~195_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21~portbdataout\ : std_logic;
SIGNAL \Result~192_combout\ : std_logic;
SIGNAL \Result~193_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22~portbdataout\ : std_logic;
SIGNAL \Result~190_combout\ : std_logic;
SIGNAL \Result~191_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23~portbdataout\ : std_logic;
SIGNAL \Result~188_combout\ : std_logic;
SIGNAL \Result~189_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24~portbdataout\ : std_logic;
SIGNAL \Result~186_combout\ : std_logic;
SIGNAL \Result~187_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25~portbdataout\ : std_logic;
SIGNAL \Result~184_combout\ : std_logic;
SIGNAL \Result~185_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26~portbdataout\ : std_logic;
SIGNAL \Result~182_combout\ : std_logic;
SIGNAL \Result~183_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27~portbdataout\ : std_logic;
SIGNAL \Result~180_combout\ : std_logic;
SIGNAL \Result~181_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28~portbdataout\ : std_logic;
SIGNAL \Result~178_combout\ : std_logic;
SIGNAL \Result~179_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29~portbdataout\ : std_logic;
SIGNAL \Result~176_combout\ : std_logic;
SIGNAL \Result~177_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30~portbdataout\ : std_logic;
SIGNAL \Result~172_combout\ : std_logic;
SIGNAL \Result~173_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31~portbdataout\ : std_logic;
SIGNAL \Result~166_combout\ : std_logic;
SIGNAL \Result~167_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32~portbdataout\ : std_logic;
SIGNAL \Result~174_combout\ : std_logic;
SIGNAL \Result~175_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33~portbdataout\ : std_logic;
SIGNAL \Result~170_combout\ : std_logic;
SIGNAL \Result~171_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34~portbdataout\ : std_logic;
SIGNAL \Result~168_combout\ : std_logic;
SIGNAL \Result~169_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35~portbdataout\ : std_logic;
SIGNAL \Add11~98_cout\ : std_logic;
SIGNAL \Add11~99\ : std_logic;
SIGNAL \Add11~17_sumout\ : std_logic;
SIGNAL \Result~100_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-17]~q\ : std_logic;
SIGNAL \Add11~18\ : std_logic;
SIGNAL \Add11~19\ : std_logic;
SIGNAL \Add11~21_sumout\ : std_logic;
SIGNAL \Result~101_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-16]~q\ : std_logic;
SIGNAL \Add11~22\ : std_logic;
SIGNAL \Add11~23\ : std_logic;
SIGNAL \Add11~29_sumout\ : std_logic;
SIGNAL \Result~103_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-15]~q\ : std_logic;
SIGNAL \Add11~30\ : std_logic;
SIGNAL \Add11~31\ : std_logic;
SIGNAL \Add11~14\ : std_logic;
SIGNAL \Add11~15\ : std_logic;
SIGNAL \Add11~25_sumout\ : std_logic;
SIGNAL \Result~102_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-13]~q\ : std_logic;
SIGNAL \Add11~26\ : std_logic;
SIGNAL \Add11~27\ : std_logic;
SIGNAL \Add11~33_sumout\ : std_logic;
SIGNAL \Result~104_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-12]~q\ : std_logic;
SIGNAL \Add11~34\ : std_logic;
SIGNAL \Add11~35\ : std_logic;
SIGNAL \Add11~37_sumout\ : std_logic;
SIGNAL \Result~105_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-11]~q\ : std_logic;
SIGNAL \Add11~38\ : std_logic;
SIGNAL \Add11~39\ : std_logic;
SIGNAL \Add11~41_sumout\ : std_logic;
SIGNAL \Result~106_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-10]~q\ : std_logic;
SIGNAL \Add11~42\ : std_logic;
SIGNAL \Add11~43\ : std_logic;
SIGNAL \Add11~45_sumout\ : std_logic;
SIGNAL \Result~107_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-9]~q\ : std_logic;
SIGNAL \Add11~46\ : std_logic;
SIGNAL \Add11~47\ : std_logic;
SIGNAL \Add11~49_sumout\ : std_logic;
SIGNAL \Result~108_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-8]~q\ : std_logic;
SIGNAL \Add11~50\ : std_logic;
SIGNAL \Add11~51\ : std_logic;
SIGNAL \Add11~53_sumout\ : std_logic;
SIGNAL \Result~109_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-7]~q\ : std_logic;
SIGNAL \Add11~54\ : std_logic;
SIGNAL \Add11~55\ : std_logic;
SIGNAL \Add11~57_sumout\ : std_logic;
SIGNAL \Result~110_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-6]~q\ : std_logic;
SIGNAL \Add11~58\ : std_logic;
SIGNAL \Add11~59\ : std_logic;
SIGNAL \Add11~61_sumout\ : std_logic;
SIGNAL \Result~111_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-5]~q\ : std_logic;
SIGNAL \Add11~62\ : std_logic;
SIGNAL \Add11~63\ : std_logic;
SIGNAL \Add11~65_sumout\ : std_logic;
SIGNAL \Result~112_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-4]~q\ : std_logic;
SIGNAL \Add11~66\ : std_logic;
SIGNAL \Add11~67\ : std_logic;
SIGNAL \Add11~69_sumout\ : std_logic;
SIGNAL \Result~113_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-3]~q\ : std_logic;
SIGNAL \Add11~70\ : std_logic;
SIGNAL \Add11~71\ : std_logic;
SIGNAL \Add11~73_sumout\ : std_logic;
SIGNAL \Result~114_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-2]~q\ : std_logic;
SIGNAL \Add11~74\ : std_logic;
SIGNAL \Add11~75\ : std_logic;
SIGNAL \Add11~77_sumout\ : std_logic;
SIGNAL \Result~115_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-1]~q\ : std_logic;
SIGNAL \Add11~78\ : std_logic;
SIGNAL \Add11~79\ : std_logic;
SIGNAL \Add11~81_sumout\ : std_logic;
SIGNAL \Result~116_combout\ : std_logic;
SIGNAL \Add11~82\ : std_logic;
SIGNAL \Add11~83\ : std_logic;
SIGNAL \Add11~85_sumout\ : std_logic;
SIGNAL \Result~117_combout\ : std_logic;
SIGNAL \Add11~86\ : std_logic;
SIGNAL \Add11~87\ : std_logic;
SIGNAL \Add11~89_sumout\ : std_logic;
SIGNAL \Result~118_combout\ : std_logic;
SIGNAL \Add11~90\ : std_logic;
SIGNAL \Add11~91\ : std_logic;
SIGNAL \Add11~95\ : std_logic;
SIGNAL \Add11~5_sumout\ : std_logic;
SIGNAL \Add11~93_sumout\ : std_logic;
SIGNAL \Result~119_combout\ : std_logic;
SIGNAL \Add11~94\ : std_logic;
SIGNAL \Add11~6\ : std_logic;
SIGNAL \Add11~10\ : std_logic;
SIGNAL \Add11~11\ : std_logic;
SIGNAL \Add11~1_sumout\ : std_logic;
SIGNAL \Add11~13_sumout\ : std_logic;
SIGNAL \Result~99_combout\ : std_logic;
SIGNAL \mv.qav.av[1].sum[-14]~q\ : std_logic;
SIGNAL \rounds~1_combout\ : std_logic;
SIGNAL \Add12~42\ : std_logic;
SIGNAL \Add12~46\ : std_logic;
SIGNAL \Add12~38\ : std_logic;
SIGNAL \Add12~34\ : std_logic;
SIGNAL \Add12~30\ : std_logic;
SIGNAL \Add12~26\ : std_logic;
SIGNAL \Add12~70\ : std_logic;
SIGNAL \Add12~74\ : std_logic;
SIGNAL \Add12~66\ : std_logic;
SIGNAL \Add12~62\ : std_logic;
SIGNAL \Add12~58\ : std_logic;
SIGNAL \Add12~22\ : std_logic;
SIGNAL \Add12~18\ : std_logic;
SIGNAL \Add12~14\ : std_logic;
SIGNAL \Add12~10\ : std_logic;
SIGNAL \Add12~54\ : std_logic;
SIGNAL \Add12~6\ : std_logic;
SIGNAL \Add12~1_sumout\ : std_logic;
SIGNAL \Add12~5_sumout\ : std_logic;
SIGNAL \Add12~9_sumout\ : std_logic;
SIGNAL \Add12~13_sumout\ : std_logic;
SIGNAL \Add12~17_sumout\ : std_logic;
SIGNAL \Add12~21_sumout\ : std_logic;
SIGNAL \Add12~25_sumout\ : std_logic;
SIGNAL \Add12~29_sumout\ : std_logic;
SIGNAL \Add12~33_sumout\ : std_logic;
SIGNAL \Add12~37_sumout\ : std_logic;
SIGNAL \Add12~41_sumout\ : std_logic;
SIGNAL \Add12~45_sumout\ : std_logic;
SIGNAL \Result~56_combout\ : std_logic;
SIGNAL \Result~57_combout\ : std_logic;
SIGNAL \Add12~2\ : std_logic;
SIGNAL \Add12~49_sumout\ : std_logic;
SIGNAL \Add12~53_sumout\ : std_logic;
SIGNAL \Add12~57_sumout\ : std_logic;
SIGNAL \Add12~61_sumout\ : std_logic;
SIGNAL \Add12~65_sumout\ : std_logic;
SIGNAL \Add12~69_sumout\ : std_logic;
SIGNAL \Add12~73_sumout\ : std_logic;
SIGNAL \Result~58_combout\ : std_logic;
SIGNAL \Result~59_combout\ : std_logic;
SIGNAL \Result~60_combout\ : std_logic;
SIGNAL \overflowx~1_combout\ : std_logic;
SIGNAL \Result~77_combout\ : std_logic;
SIGNAL \Result~76_combout\ : std_logic;
SIGNAL \Result~75_combout\ : std_logic;
SIGNAL \Result~74_combout\ : std_logic;
SIGNAL \Result~73_combout\ : std_logic;
SIGNAL \Result~72_combout\ : std_logic;
SIGNAL \Result~71_combout\ : std_logic;
SIGNAL \Result~70_combout\ : std_logic;
SIGNAL \Result~69_combout\ : std_logic;
SIGNAL \Result~68_combout\ : std_logic;
SIGNAL \Result~67_combout\ : std_logic;
SIGNAL \Result~66_combout\ : std_logic;
SIGNAL \Result~65_combout\ : std_logic;
SIGNAL \Result~64_combout\ : std_logic;
SIGNAL \Result~63_combout\ : std_logic;
SIGNAL \Result~62_combout\ : std_logic;
SIGNAL \Result~61_combout\ : std_logic;
SIGNAL \Add13~78_cout\ : std_logic;
SIGNAL \Add13~10\ : std_logic;
SIGNAL \Add13~14\ : std_logic;
SIGNAL \Add13~18\ : std_logic;
SIGNAL \Add13~22\ : std_logic;
SIGNAL \Add13~26\ : std_logic;
SIGNAL \Add13~30\ : std_logic;
SIGNAL \Add13~34\ : std_logic;
SIGNAL \Add13~38\ : std_logic;
SIGNAL \Add13~42\ : std_logic;
SIGNAL \Add13~46\ : std_logic;
SIGNAL \Add13~50\ : std_logic;
SIGNAL \Add13~54\ : std_logic;
SIGNAL \Add13~58\ : std_logic;
SIGNAL \Add13~62\ : std_logic;
SIGNAL \Add13~66\ : std_logic;
SIGNAL \Add13~70\ : std_logic;
SIGNAL \Add13~74\ : std_logic;
SIGNAL \Add13~1_sumout\ : std_logic;
SIGNAL \Add13~2\ : std_logic;
SIGNAL \Add13~5_sumout\ : std_logic;
SIGNAL \Add13~9_sumout\ : std_logic;
SIGNAL \Result~17_combout\ : std_logic;
SIGNAL \y2[0]~reg0_q\ : std_logic;
SIGNAL \Add13~13_sumout\ : std_logic;
SIGNAL \Result~18_combout\ : std_logic;
SIGNAL \y2[1]~reg0_q\ : std_logic;
SIGNAL \Add13~17_sumout\ : std_logic;
SIGNAL \Result~19_combout\ : std_logic;
SIGNAL \y2[2]~reg0_q\ : std_logic;
SIGNAL \Add13~21_sumout\ : std_logic;
SIGNAL \Result~20_combout\ : std_logic;
SIGNAL \y2[3]~reg0_q\ : std_logic;
SIGNAL \Add13~25_sumout\ : std_logic;
SIGNAL \Result~21_combout\ : std_logic;
SIGNAL \y2[4]~reg0_q\ : std_logic;
SIGNAL \Add13~29_sumout\ : std_logic;
SIGNAL \Result~22_combout\ : std_logic;
SIGNAL \y2[5]~reg0_q\ : std_logic;
SIGNAL \Add13~33_sumout\ : std_logic;
SIGNAL \Result~23_combout\ : std_logic;
SIGNAL \y2[6]~reg0_q\ : std_logic;
SIGNAL \Add13~37_sumout\ : std_logic;
SIGNAL \Result~24_combout\ : std_logic;
SIGNAL \y2[7]~reg0_q\ : std_logic;
SIGNAL \Add13~41_sumout\ : std_logic;
SIGNAL \Result~25_combout\ : std_logic;
SIGNAL \y2[8]~reg0_q\ : std_logic;
SIGNAL \Add13~45_sumout\ : std_logic;
SIGNAL \Result~26_combout\ : std_logic;
SIGNAL \y2[9]~reg0_q\ : std_logic;
SIGNAL \Add13~49_sumout\ : std_logic;
SIGNAL \Result~27_combout\ : std_logic;
SIGNAL \y2[10]~reg0_q\ : std_logic;
SIGNAL \Add13~53_sumout\ : std_logic;
SIGNAL \Result~28_combout\ : std_logic;
SIGNAL \y2[11]~reg0_q\ : std_logic;
SIGNAL \Add13~57_sumout\ : std_logic;
SIGNAL \Result~29_combout\ : std_logic;
SIGNAL \y2[12]~reg0_q\ : std_logic;
SIGNAL \Add13~61_sumout\ : std_logic;
SIGNAL \Result~30_combout\ : std_logic;
SIGNAL \y2[13]~reg0_q\ : std_logic;
SIGNAL \Add13~65_sumout\ : std_logic;
SIGNAL \Result~31_combout\ : std_logic;
SIGNAL \y2[14]~reg0_q\ : std_logic;
SIGNAL \Add13~69_sumout\ : std_logic;
SIGNAL \Result~32_combout\ : std_logic;
SIGNAL \y2[15]~reg0_q\ : std_logic;
SIGNAL \Add13~73_sumout\ : std_logic;
SIGNAL \Result~33_combout\ : std_logic;
SIGNAL \y2[16]~reg0_q\ : std_logic;
SIGNAL \y2[17]~0_combout\ : std_logic;
SIGNAL \y2[17]~reg0_q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.qav.av[0].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[0].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.qav.av[1].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \mv.iav.av[1].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_Add12~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a1~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a2~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a3~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a4~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a5~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a6~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a7~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a8~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a9~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a10~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a11~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a12~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a13~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a14~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a15~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a16~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a17~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\ : std_logic;
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
SIGNAL \ALT_INV_Add5~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add5~1_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add13~1_sumout\ : std_logic;
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
SIGNAL \ALT_INV_Add2~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add2~1_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~93_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~89_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~85_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~81_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~77_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add11~1_sumout\ : std_logic;
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
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_Add4~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add4~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a19~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a20~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a21~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a22~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a23~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a24~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a25~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a26~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a27~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a28~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a29~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a30~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a31~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a32~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a33~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a34~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a35~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a18~portbdataout\ : std_logic;
SIGNAL \ALT_INV_Add12~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add12~9_sumout\ : std_logic;
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
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~sumout\ : std_logic;
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
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a19~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a20~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a21~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a22~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a23~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a24~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a25~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a26~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a27~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a28~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a29~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a30~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a33~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a31~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a34~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a35~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a32~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a18~portbdataout\ : std_logic;
SIGNAL \ALT_INV_Add9~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add9~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a1~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a2~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a3~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a4~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a5~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a6~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a7~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a8~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a9~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a10~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a11~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a12~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a15~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a13~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a16~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a17~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a14~portbdataout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\ : std_logic;
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
SIGNAL \ALT_INV_rounds~0_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-13]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-14]~q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita1~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita2~sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~1_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~93_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~89_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~85_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~81_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~77_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~73_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~69_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~65_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~61_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~57_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~53_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~49_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~45_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~41_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add8~1_sumout\ : std_logic;
SIGNAL \ALT_INV_Add1~93_sumout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\ : std_logic_vector(1 DOWNTO 1);
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\ : std_logic;
SIGNAL \ALT_INV_Result~77_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_Result~76_combout\ : std_logic;
SIGNAL \ALT_INV_Result~75_combout\ : std_logic;
SIGNAL \ALT_INV_Result~74_combout\ : std_logic;
SIGNAL \ALT_INV_Result~73_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-1]~q\ : std_logic;
SIGNAL \ALT_INV_Result~72_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-2]~q\ : std_logic;
SIGNAL \ALT_INV_Result~71_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-3]~q\ : std_logic;
SIGNAL \ALT_INV_Result~70_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-4]~q\ : std_logic;
SIGNAL \ALT_INV_Result~69_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-5]~q\ : std_logic;
SIGNAL \ALT_INV_Result~68_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-6]~q\ : std_logic;
SIGNAL \ALT_INV_Result~67_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-7]~q\ : std_logic;
SIGNAL \ALT_INV_Result~66_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-8]~q\ : std_logic;
SIGNAL \ALT_INV_Result~65_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-9]~q\ : std_logic;
SIGNAL \ALT_INV_Result~64_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-10]~q\ : std_logic;
SIGNAL \ALT_INV_Result~63_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-11]~q\ : std_logic;
SIGNAL \ALT_INV_Result~62_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-12]~q\ : std_logic;
SIGNAL \ALT_INV_overflowx~1_combout\ : std_logic;
SIGNAL \ALT_INV_Result~61_combout\ : std_logic;
SIGNAL \ALT_INV_Result~60_combout\ : std_logic;
SIGNAL \ALT_INV_Result~59_combout\ : std_logic;
SIGNAL \ALT_INV_Result~58_combout\ : std_logic;
SIGNAL \ALT_INV_Result~57_combout\ : std_logic;
SIGNAL \ALT_INV_Result~56_combout\ : std_logic;
SIGNAL \ALT_INV_rounds~1_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-13]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[1].sum[-14]~q\ : std_logic;
SIGNAL \ALT_INV_Result~55_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_Result~54_combout\ : std_logic;
SIGNAL \ALT_INV_Result~53_combout\ : std_logic;
SIGNAL \ALT_INV_Result~52_combout\ : std_logic;
SIGNAL \ALT_INV_Result~51_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-1]~q\ : std_logic;
SIGNAL \ALT_INV_Result~50_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-2]~q\ : std_logic;
SIGNAL \ALT_INV_Result~49_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-3]~q\ : std_logic;
SIGNAL \ALT_INV_Result~48_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-4]~q\ : std_logic;
SIGNAL \ALT_INV_Result~47_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-5]~q\ : std_logic;
SIGNAL \ALT_INV_Result~46_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-6]~q\ : std_logic;
SIGNAL \ALT_INV_Result~45_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-7]~q\ : std_logic;
SIGNAL \ALT_INV_Result~44_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-8]~q\ : std_logic;
SIGNAL \ALT_INV_Result~43_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-9]~q\ : std_logic;
SIGNAL \ALT_INV_Result~42_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-10]~q\ : std_logic;
SIGNAL \ALT_INV_Result~41_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-11]~q\ : std_logic;
SIGNAL \ALT_INV_Result~40_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[1].sum[-12]~q\ : std_logic;
SIGNAL \ALT_INV_overflowx~0_combout\ : std_logic;
SIGNAL \ALT_INV_Result~39_combout\ : std_logic;
SIGNAL \ALT_INV_Result~38_combout\ : std_logic;
SIGNAL \ALT_INV_Result~37_combout\ : std_logic;
SIGNAL \ALT_INV_Result~36_combout\ : std_logic;
SIGNAL \ALT_INV_Result~35_combout\ : std_logic;
SIGNAL \ALT_INV_Result~34_combout\ : std_logic;
SIGNAL \ALT_INV_Result~168_combout\ : std_logic;
SIGNAL \ALT_INV_Result~167_combout\ : std_logic;
SIGNAL \ALT_INV_Result~166_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-10]~q\ : std_logic;
SIGNAL \ALT_INV_round_overflow~1_combout\ : std_logic;
SIGNAL \ALT_INV_Result~165_combout\ : std_logic;
SIGNAL \ALT_INV_Result~164_combout\ : std_logic;
SIGNAL \ALT_INV_Result~163_combout\ : std_logic;
SIGNAL \ALT_INV_Result~162_combout\ : std_logic;
SIGNAL \ALT_INV_Result~161_combout\ : std_logic;
SIGNAL \ALT_INV_Result~160_combout\ : std_logic;
SIGNAL \ALT_INV_rounds~3_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-14]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-13]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_Result~159_combout\ : std_logic;
SIGNAL \ALT_INV_Result~158_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_Result~157_combout\ : std_logic;
SIGNAL \ALT_INV_Result~156_combout\ : std_logic;
SIGNAL \ALT_INV_Result~155_combout\ : std_logic;
SIGNAL \ALT_INV_Result~154_combout\ : std_logic;
SIGNAL \ALT_INV_Result~153_combout\ : std_logic;
SIGNAL \ALT_INV_Result~152_combout\ : std_logic;
SIGNAL \ALT_INV_Result~151_combout\ : std_logic;
SIGNAL \ALT_INV_Result~150_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-1]~q\ : std_logic;
SIGNAL \ALT_INV_Result~149_combout\ : std_logic;
SIGNAL \ALT_INV_Result~148_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-2]~q\ : std_logic;
SIGNAL \ALT_INV_Result~147_combout\ : std_logic;
SIGNAL \ALT_INV_Result~146_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-3]~q\ : std_logic;
SIGNAL \ALT_INV_Result~145_combout\ : std_logic;
SIGNAL \ALT_INV_Result~144_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-4]~q\ : std_logic;
SIGNAL \ALT_INV_Result~143_combout\ : std_logic;
SIGNAL \ALT_INV_Result~142_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-5]~q\ : std_logic;
SIGNAL \ALT_INV_Result~141_combout\ : std_logic;
SIGNAL \ALT_INV_Result~140_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-6]~q\ : std_logic;
SIGNAL \ALT_INV_Result~139_combout\ : std_logic;
SIGNAL \ALT_INV_Result~138_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-7]~q\ : std_logic;
SIGNAL \ALT_INV_Result~137_combout\ : std_logic;
SIGNAL \ALT_INV_Result~136_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-8]~q\ : std_logic;
SIGNAL \ALT_INV_Result~135_combout\ : std_logic;
SIGNAL \ALT_INV_Result~134_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-11]~q\ : std_logic;
SIGNAL \ALT_INV_Result~133_combout\ : std_logic;
SIGNAL \ALT_INV_Result~132_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-9]~q\ : std_logic;
SIGNAL \ALT_INV_Result~131_combout\ : std_logic;
SIGNAL \ALT_INV_Result~130_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-12]~q\ : std_logic;
SIGNAL \ALT_INV_Result~129_combout\ : std_logic;
SIGNAL \ALT_INV_Result~128_combout\ : std_logic;
SIGNAL \ALT_INV_Result~127_combout\ : std_logic;
SIGNAL \ALT_INV_Result~126_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-10]~q\ : std_logic;
SIGNAL \ALT_INV_round_overflow~0_combout\ : std_logic;
SIGNAL \ALT_INV_Result~125_combout\ : std_logic;
SIGNAL \ALT_INV_Result~124_combout\ : std_logic;
SIGNAL \ALT_INV_Result~123_combout\ : std_logic;
SIGNAL \ALT_INV_Result~122_combout\ : std_logic;
SIGNAL \ALT_INV_Result~121_combout\ : std_logic;
SIGNAL \ALT_INV_Result~120_combout\ : std_logic;
SIGNAL \ALT_INV_rounds~2_combout\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-14]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].sum[-13]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit3~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit2~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-1]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-2]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-3]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-4]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-5]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-6]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-7]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-8]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-11]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-9]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-12]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-10]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-14]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][-13]~q\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].in_sr[15][0]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-1]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-2]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-3]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-4]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-5]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-6]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-7]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-8]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit3~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-11]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-9]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-12]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-10]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-15]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-16]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-17]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-14]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][-13]~q\ : std_logic;
SIGNAL \ALT_INV_mv.iav.av[0].in_sr[15][0]~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\ : std_logic_vector(1 DOWNTO 1);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\ : std_logic;
SIGNAL \ALT_INV_Result~199_combout\ : std_logic;
SIGNAL \ALT_INV_Result~198_combout\ : std_logic;
SIGNAL \ALT_INV_Result~197_combout\ : std_logic;
SIGNAL \ALT_INV_Result~196_combout\ : std_logic;
SIGNAL \ALT_INV_Result~195_combout\ : std_logic;
SIGNAL \ALT_INV_Result~194_combout\ : std_logic;
SIGNAL \ALT_INV_Result~193_combout\ : std_logic;
SIGNAL \ALT_INV_Result~192_combout\ : std_logic;
SIGNAL \ALT_INV_Result~191_combout\ : std_logic;
SIGNAL \ALT_INV_Result~190_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-1]~q\ : std_logic;
SIGNAL \ALT_INV_Result~189_combout\ : std_logic;
SIGNAL \ALT_INV_Result~188_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-2]~q\ : std_logic;
SIGNAL \ALT_INV_Result~187_combout\ : std_logic;
SIGNAL \ALT_INV_Result~186_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-3]~q\ : std_logic;
SIGNAL \ALT_INV_Result~185_combout\ : std_logic;
SIGNAL \ALT_INV_Result~184_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-4]~q\ : std_logic;
SIGNAL \ALT_INV_Result~183_combout\ : std_logic;
SIGNAL \ALT_INV_Result~182_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-5]~q\ : std_logic;
SIGNAL \ALT_INV_Result~181_combout\ : std_logic;
SIGNAL \ALT_INV_Result~180_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-6]~q\ : std_logic;
SIGNAL \ALT_INV_Result~179_combout\ : std_logic;
SIGNAL \ALT_INV_Result~178_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-7]~q\ : std_logic;
SIGNAL \ALT_INV_Result~177_combout\ : std_logic;
SIGNAL \ALT_INV_Result~176_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-8]~q\ : std_logic;
SIGNAL \ALT_INV_Result~175_combout\ : std_logic;
SIGNAL \ALT_INV_Result~174_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-11]~q\ : std_logic;
SIGNAL \ALT_INV_Result~173_combout\ : std_logic;
SIGNAL \ALT_INV_Result~172_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-9]~q\ : std_logic;
SIGNAL \ALT_INV_Result~171_combout\ : std_logic;
SIGNAL \ALT_INV_Result~170_combout\ : std_logic;
SIGNAL \ALT_INV_mv.qav.av[0].sum[-12]~q\ : std_logic;
SIGNAL \ALT_INV_Result~169_combout\ : std_logic;
SIGNAL \ALT_INV_x2[16]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[15]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[14]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[13]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[12]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[11]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[10]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[9]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[8]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_x2[17]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[16]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[15]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[14]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[13]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[12]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[11]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[10]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[9]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[8]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_x1[17]~input_o\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit1~q\ : std_logic;
SIGNAL \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit0~q\ : std_logic;
SIGNAL \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit2~q\ : std_logic;

BEGIN

ww_clk <= clk;
ww_rst_n <= rst_n;
ww_x1 <= x1;
ww_x2 <= x2;
y1 <= ww_y1;
y2 <= ww_y2;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][0]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-17]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-16]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-15]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-14]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-13]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-12]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-11]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-10]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-9]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-8]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-7]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-6]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-5]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-4]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-3]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-2]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTADATAIN_bus\(0) <= \mv.iav.av[0].in_sr[0][-1]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][0]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-17]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-16]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-15]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-14]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-13]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-12]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-11]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-10]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-9]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-8]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-7]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-6]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-5]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-4]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-3]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-2]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTBDATAOUT_bus\(0);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTADATAIN_bus\(0) <= \mv.qav.av[0].in_sr[0][-1]~q\;

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTAADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTBADDR_bus\ <= (\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19~portbdataout\ <= \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTADATAIN_bus\(0) <= \Result~123_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTADATAIN_bus\(0) <= \Result~127_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTADATAIN_bus\(0) <= \Result~129_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTADATAIN_bus\(0) <= \Result~131_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTADATAIN_bus\(0) <= \Result~133_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTADATAIN_bus\(0) <= \Result~135_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTADATAIN_bus\(0) <= \Result~137_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTADATAIN_bus\(0) <= \Result~139_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTADATAIN_bus\(0) <= \Result~141_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTADATAIN_bus\(0) <= \Result~143_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTADATAIN_bus\(0) <= \Result~145_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTADATAIN_bus\(0) <= \Result~147_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTADATAIN_bus\(0) <= \Result~149_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTADATAIN_bus\(0) <= \Result~151_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTADATAIN_bus\(0) <= \Result~153_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTADATAIN_bus\(0) <= \Result~155_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTADATAIN_bus\(0) <= \Result~157_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTADATAIN_bus\(0) <= \Result~159_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTADATAIN_bus\(0) <= \Result~163_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTADATAIN_bus\(0) <= \Result~167_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTADATAIN_bus\(0) <= \Result~169_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTADATAIN_bus\(0) <= \Result~171_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTADATAIN_bus\(0) <= \Result~173_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTADATAIN_bus\(0) <= \Result~175_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTADATAIN_bus\(0) <= \Result~177_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTADATAIN_bus\(0) <= \Result~179_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTADATAIN_bus\(0) <= \Result~181_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTADATAIN_bus\(0) <= \Result~183_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTADATAIN_bus\(0) <= \Result~185_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTADATAIN_bus\(0) <= \Result~187_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTADATAIN_bus\(0) <= \Result~189_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTADATAIN_bus\(0) <= \Result~191_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTADATAIN_bus\(0) <= \Result~193_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTADATAIN_bus\(0) <= \Result~195_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTADATAIN_bus\(0) <= \Result~197_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTBDATAOUT_bus\(0);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTADATAIN_bus\(0) <= \Result~199_combout\;

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTAADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTBADDR_bus\ <= (\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3) & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2) & 
\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ & \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19~portbdataout\ <= \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTBDATAOUT_bus\(0);
\ALT_INV_Add12~5_sumout\ <= NOT \Add12~5_sumout\;
\ALT_INV_Add12~1_sumout\ <= NOT \Add12~1_sumout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a1~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a2~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a3~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a4~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a5~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a6~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a7~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a8~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a9~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a10~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a11~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a12~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a13~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a14~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a15~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a16~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a17~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\;
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
\ALT_INV_Add5~13_sumout\ <= NOT \Add5~13_sumout\;
\ALT_INV_Add5~9_sumout\ <= NOT \Add5~9_sumout\;
\ALT_INV_Add5~5_sumout\ <= NOT \Add5~5_sumout\;
\ALT_INV_Add5~1_sumout\ <= NOT \Add5~1_sumout\;
\ALT_INV_Add13~73_sumout\ <= NOT \Add13~73_sumout\;
\ALT_INV_Add13~69_sumout\ <= NOT \Add13~69_sumout\;
\ALT_INV_Add13~65_sumout\ <= NOT \Add13~65_sumout\;
\ALT_INV_Add13~61_sumout\ <= NOT \Add13~61_sumout\;
\ALT_INV_Add13~57_sumout\ <= NOT \Add13~57_sumout\;
\ALT_INV_Add13~53_sumout\ <= NOT \Add13~53_sumout\;
\ALT_INV_Add13~49_sumout\ <= NOT \Add13~49_sumout\;
\ALT_INV_Add13~45_sumout\ <= NOT \Add13~45_sumout\;
\ALT_INV_Add13~41_sumout\ <= NOT \Add13~41_sumout\;
\ALT_INV_Add13~37_sumout\ <= NOT \Add13~37_sumout\;
\ALT_INV_Add13~33_sumout\ <= NOT \Add13~33_sumout\;
\ALT_INV_Add13~29_sumout\ <= NOT \Add13~29_sumout\;
\ALT_INV_Add13~25_sumout\ <= NOT \Add13~25_sumout\;
\ALT_INV_Add13~21_sumout\ <= NOT \Add13~21_sumout\;
\ALT_INV_Add13~17_sumout\ <= NOT \Add13~17_sumout\;
\ALT_INV_Add13~13_sumout\ <= NOT \Add13~13_sumout\;
\ALT_INV_Add13~9_sumout\ <= NOT \Add13~9_sumout\;
\ALT_INV_Add13~5_sumout\ <= NOT \Add13~5_sumout\;
\ALT_INV_Add13~1_sumout\ <= NOT \Add13~1_sumout\;
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
\ALT_INV_Add2~9_sumout\ <= NOT \Add2~9_sumout\;
\ALT_INV_Add2~5_sumout\ <= NOT \Add2~5_sumout\;
\ALT_INV_Add2~1_sumout\ <= NOT \Add2~1_sumout\;
\ALT_INV_Add11~93_sumout\ <= NOT \Add11~93_sumout\;
\ALT_INV_Add11~89_sumout\ <= NOT \Add11~89_sumout\;
\ALT_INV_Add11~85_sumout\ <= NOT \Add11~85_sumout\;
\ALT_INV_Add11~81_sumout\ <= NOT \Add11~81_sumout\;
\ALT_INV_Add11~77_sumout\ <= NOT \Add11~77_sumout\;
\ALT_INV_Add11~73_sumout\ <= NOT \Add11~73_sumout\;
\ALT_INV_Add11~69_sumout\ <= NOT \Add11~69_sumout\;
\ALT_INV_Add11~65_sumout\ <= NOT \Add11~65_sumout\;
\ALT_INV_Add11~61_sumout\ <= NOT \Add11~61_sumout\;
\ALT_INV_Add11~57_sumout\ <= NOT \Add11~57_sumout\;
\ALT_INV_Add11~53_sumout\ <= NOT \Add11~53_sumout\;
\ALT_INV_Add11~49_sumout\ <= NOT \Add11~49_sumout\;
\ALT_INV_Add11~45_sumout\ <= NOT \Add11~45_sumout\;
\ALT_INV_Add11~41_sumout\ <= NOT \Add11~41_sumout\;
\ALT_INV_Add11~37_sumout\ <= NOT \Add11~37_sumout\;
\ALT_INV_Add11~33_sumout\ <= NOT \Add11~33_sumout\;
\ALT_INV_Add11~29_sumout\ <= NOT \Add11~29_sumout\;
\ALT_INV_Add11~25_sumout\ <= NOT \Add11~25_sumout\;
\ALT_INV_Add11~21_sumout\ <= NOT \Add11~21_sumout\;
\ALT_INV_Add11~17_sumout\ <= NOT \Add11~17_sumout\;
\ALT_INV_Add11~13_sumout\ <= NOT \Add11~13_sumout\;
\ALT_INV_Add11~9_sumout\ <= NOT \Add11~9_sumout\;
\ALT_INV_Add11~5_sumout\ <= NOT \Add11~5_sumout\;
\ALT_INV_Add11~1_sumout\ <= NOT \Add11~1_sumout\;
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
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3) <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3);
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2) <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2);
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1) <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1);
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0) <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0);
\ALT_INV_Add4~29_sumout\ <= NOT \Add4~29_sumout\;
\ALT_INV_Add4~25_sumout\ <= NOT \Add4~25_sumout\;
\ALT_INV_Add4~21_sumout\ <= NOT \Add4~21_sumout\;
\ALT_INV_Add4~17_sumout\ <= NOT \Add4~17_sumout\;
\ALT_INV_Add4~13_sumout\ <= NOT \Add4~13_sumout\;
\ALT_INV_Add4~9_sumout\ <= NOT \Add4~9_sumout\;
\ALT_INV_Add4~5_sumout\ <= NOT \Add4~5_sumout\;
\ALT_INV_Add4~1_sumout\ <= NOT \Add4~1_sumout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a19~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a20~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a21~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a22~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a23~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a24~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a25~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a26~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a27~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a28~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a29~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a30~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a31~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a32~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a33~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a34~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a35~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a18~portbdataout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18~portbdataout\;
\ALT_INV_Add12~73_sumout\ <= NOT \Add12~73_sumout\;
\ALT_INV_Add12~69_sumout\ <= NOT \Add12~69_sumout\;
\ALT_INV_Add12~65_sumout\ <= NOT \Add12~65_sumout\;
\ALT_INV_Add12~61_sumout\ <= NOT \Add12~61_sumout\;
\ALT_INV_Add12~57_sumout\ <= NOT \Add12~57_sumout\;
\ALT_INV_Add12~53_sumout\ <= NOT \Add12~53_sumout\;
\ALT_INV_Add12~49_sumout\ <= NOT \Add12~49_sumout\;
\ALT_INV_Add12~45_sumout\ <= NOT \Add12~45_sumout\;
\ALT_INV_Add12~41_sumout\ <= NOT \Add12~41_sumout\;
\ALT_INV_Add12~37_sumout\ <= NOT \Add12~37_sumout\;
\ALT_INV_Add12~33_sumout\ <= NOT \Add12~33_sumout\;
\ALT_INV_Add12~29_sumout\ <= NOT \Add12~29_sumout\;
\ALT_INV_Add12~25_sumout\ <= NOT \Add12~25_sumout\;
\ALT_INV_Add12~21_sumout\ <= NOT \Add12~21_sumout\;
\ALT_INV_Add12~17_sumout\ <= NOT \Add12~17_sumout\;
\ALT_INV_Add12~13_sumout\ <= NOT \Add12~13_sumout\;
\ALT_INV_Add12~9_sumout\ <= NOT \Add12~9_sumout\;
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
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~sumout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\;
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
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a19~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a20~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a21~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a22~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a23~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a24~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a25~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a26~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a27~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a28~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a29~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a30~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a33~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a31~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a34~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a35~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a32~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a18~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\;
\ALT_INV_Add9~73_sumout\ <= NOT \Add9~73_sumout\;
\ALT_INV_Add9~69_sumout\ <= NOT \Add9~69_sumout\;
\ALT_INV_Add9~65_sumout\ <= NOT \Add9~65_sumout\;
\ALT_INV_Add9~61_sumout\ <= NOT \Add9~61_sumout\;
\ALT_INV_Add9~57_sumout\ <= NOT \Add9~57_sumout\;
\ALT_INV_Add9~53_sumout\ <= NOT \Add9~53_sumout\;
\ALT_INV_Add9~49_sumout\ <= NOT \Add9~49_sumout\;
\ALT_INV_Add9~45_sumout\ <= NOT \Add9~45_sumout\;
\ALT_INV_Add9~41_sumout\ <= NOT \Add9~41_sumout\;
\ALT_INV_Add9~37_sumout\ <= NOT \Add9~37_sumout\;
\ALT_INV_Add9~33_sumout\ <= NOT \Add9~33_sumout\;
\ALT_INV_Add9~29_sumout\ <= NOT \Add9~29_sumout\;
\ALT_INV_Add9~25_sumout\ <= NOT \Add9~25_sumout\;
\ALT_INV_Add9~21_sumout\ <= NOT \Add9~21_sumout\;
\ALT_INV_Add9~17_sumout\ <= NOT \Add9~17_sumout\;
\ALT_INV_Add9~13_sumout\ <= NOT \Add9~13_sumout\;
\ALT_INV_Add9~9_sumout\ <= NOT \Add9~9_sumout\;
\ALT_INV_Add9~5_sumout\ <= NOT \Add9~5_sumout\;
\ALT_INV_Add9~1_sumout\ <= NOT \Add9~1_sumout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a1~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a2~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a3~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a4~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a5~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a6~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a7~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a8~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a9~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a10~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a11~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a12~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12~portbdataout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_comb_bita3~1_sumout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~1_sumout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a15~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a13~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a16~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a17~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a14~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14~portbdataout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\;
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
\ALT_INV_rounds~0_combout\ <= NOT \rounds~0_combout\;
\ALT_INV_mv.iav.av[1].sum[-15]~q\ <= NOT \mv.iav.av[1].sum[-15]~q\;
\ALT_INV_mv.iav.av[1].sum[-13]~q\ <= NOT \mv.iav.av[1].sum[-13]~q\;
\ALT_INV_mv.iav.av[1].sum[-16]~q\ <= NOT \mv.iav.av[1].sum[-16]~q\;
\ALT_INV_mv.iav.av[1].sum[-17]~q\ <= NOT \mv.iav.av[1].sum[-17]~q\;
\ALT_INV_mv.iav.av[1].sum[-14]~q\ <= NOT \mv.iav.av[1].sum[-14]~q\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita1~sumout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita2~sumout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~sumout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita2~sumout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~1_sumout\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\;
\ALT_INV_Add8~93_sumout\ <= NOT \Add8~93_sumout\;
\ALT_INV_Add8~89_sumout\ <= NOT \Add8~89_sumout\;
\ALT_INV_Add8~85_sumout\ <= NOT \Add8~85_sumout\;
\ALT_INV_Add8~81_sumout\ <= NOT \Add8~81_sumout\;
\ALT_INV_Add8~77_sumout\ <= NOT \Add8~77_sumout\;
\ALT_INV_Add8~73_sumout\ <= NOT \Add8~73_sumout\;
\ALT_INV_Add8~69_sumout\ <= NOT \Add8~69_sumout\;
\ALT_INV_Add8~65_sumout\ <= NOT \Add8~65_sumout\;
\ALT_INV_Add8~61_sumout\ <= NOT \Add8~61_sumout\;
\ALT_INV_Add8~57_sumout\ <= NOT \Add8~57_sumout\;
\ALT_INV_Add8~53_sumout\ <= NOT \Add8~53_sumout\;
\ALT_INV_Add8~49_sumout\ <= NOT \Add8~49_sumout\;
\ALT_INV_Add8~45_sumout\ <= NOT \Add8~45_sumout\;
\ALT_INV_Add8~41_sumout\ <= NOT \Add8~41_sumout\;
\ALT_INV_Add8~37_sumout\ <= NOT \Add8~37_sumout\;
\ALT_INV_Add8~33_sumout\ <= NOT \Add8~33_sumout\;
\ALT_INV_Add8~29_sumout\ <= NOT \Add8~29_sumout\;
\ALT_INV_Add8~25_sumout\ <= NOT \Add8~25_sumout\;
\ALT_INV_Add8~21_sumout\ <= NOT \Add8~21_sumout\;
\ALT_INV_Add8~17_sumout\ <= NOT \Add8~17_sumout\;
\ALT_INV_Add8~13_sumout\ <= NOT \Add8~13_sumout\;
\ALT_INV_Add8~9_sumout\ <= NOT \Add8~9_sumout\;
\ALT_INV_Add8~5_sumout\ <= NOT \Add8~5_sumout\;
\ALT_INV_Add8~1_sumout\ <= NOT \Add8~1_sumout\;
\ALT_INV_Add1~93_sumout\ <= NOT \Add1~93_sumout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1) <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(1);
\mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe7~q\;
\ALT_INV_Result~77_combout\ <= NOT \Result~77_combout\;
\ALT_INV_mv.qav.av[1].sum\(3) <= NOT \mv.qav.av[1].sum\(3);
\ALT_INV_Result~76_combout\ <= NOT \Result~76_combout\;
\ALT_INV_mv.qav.av[1].sum\(2) <= NOT \mv.qav.av[1].sum\(2);
\ALT_INV_Result~75_combout\ <= NOT \Result~75_combout\;
\ALT_INV_mv.qav.av[1].sum\(1) <= NOT \mv.qav.av[1].sum\(1);
\ALT_INV_Result~74_combout\ <= NOT \Result~74_combout\;
\ALT_INV_mv.qav.av[1].sum\(0) <= NOT \mv.qav.av[1].sum\(0);
\ALT_INV_Result~73_combout\ <= NOT \Result~73_combout\;
\ALT_INV_mv.qav.av[1].sum[-1]~q\ <= NOT \mv.qav.av[1].sum[-1]~q\;
\ALT_INV_Result~72_combout\ <= NOT \Result~72_combout\;
\ALT_INV_mv.qav.av[1].sum[-2]~q\ <= NOT \mv.qav.av[1].sum[-2]~q\;
\ALT_INV_Result~71_combout\ <= NOT \Result~71_combout\;
\ALT_INV_mv.qav.av[1].sum[-3]~q\ <= NOT \mv.qav.av[1].sum[-3]~q\;
\ALT_INV_Result~70_combout\ <= NOT \Result~70_combout\;
\ALT_INV_mv.qav.av[1].sum[-4]~q\ <= NOT \mv.qav.av[1].sum[-4]~q\;
\ALT_INV_Result~69_combout\ <= NOT \Result~69_combout\;
\ALT_INV_mv.qav.av[1].sum[-5]~q\ <= NOT \mv.qav.av[1].sum[-5]~q\;
\ALT_INV_Result~68_combout\ <= NOT \Result~68_combout\;
\ALT_INV_mv.qav.av[1].sum[-6]~q\ <= NOT \mv.qav.av[1].sum[-6]~q\;
\ALT_INV_Result~67_combout\ <= NOT \Result~67_combout\;
\ALT_INV_mv.qav.av[1].sum[-7]~q\ <= NOT \mv.qav.av[1].sum[-7]~q\;
\ALT_INV_Result~66_combout\ <= NOT \Result~66_combout\;
\ALT_INV_mv.qav.av[1].sum[-8]~q\ <= NOT \mv.qav.av[1].sum[-8]~q\;
\ALT_INV_Result~65_combout\ <= NOT \Result~65_combout\;
\ALT_INV_mv.qav.av[1].sum[-9]~q\ <= NOT \mv.qav.av[1].sum[-9]~q\;
\ALT_INV_Result~64_combout\ <= NOT \Result~64_combout\;
\ALT_INV_mv.qav.av[1].sum[-10]~q\ <= NOT \mv.qav.av[1].sum[-10]~q\;
\ALT_INV_Result~63_combout\ <= NOT \Result~63_combout\;
\ALT_INV_mv.qav.av[1].sum[-11]~q\ <= NOT \mv.qav.av[1].sum[-11]~q\;
\ALT_INV_Result~62_combout\ <= NOT \Result~62_combout\;
\ALT_INV_mv.qav.av[1].sum[-12]~q\ <= NOT \mv.qav.av[1].sum[-12]~q\;
\ALT_INV_overflowx~1_combout\ <= NOT \overflowx~1_combout\;
\ALT_INV_Result~61_combout\ <= NOT \Result~61_combout\;
\ALT_INV_Result~60_combout\ <= NOT \Result~60_combout\;
\ALT_INV_Result~59_combout\ <= NOT \Result~59_combout\;
\ALT_INV_Result~58_combout\ <= NOT \Result~58_combout\;
\ALT_INV_Result~57_combout\ <= NOT \Result~57_combout\;
\ALT_INV_Result~56_combout\ <= NOT \Result~56_combout\;
\ALT_INV_mv.qav.av[1].sum\(4) <= NOT \mv.qav.av[1].sum\(4);
\ALT_INV_rounds~1_combout\ <= NOT \rounds~1_combout\;
\ALT_INV_mv.qav.av[1].sum[-15]~q\ <= NOT \mv.qav.av[1].sum[-15]~q\;
\ALT_INV_mv.qav.av[1].sum[-13]~q\ <= NOT \mv.qav.av[1].sum[-13]~q\;
\ALT_INV_mv.qav.av[1].sum[-16]~q\ <= NOT \mv.qav.av[1].sum[-16]~q\;
\ALT_INV_mv.qav.av[1].sum[-17]~q\ <= NOT \mv.qav.av[1].sum[-17]~q\;
\ALT_INV_mv.qav.av[1].sum[-14]~q\ <= NOT \mv.qav.av[1].sum[-14]~q\;
\ALT_INV_Result~55_combout\ <= NOT \Result~55_combout\;
\ALT_INV_mv.iav.av[1].sum\(3) <= NOT \mv.iav.av[1].sum\(3);
\ALT_INV_Result~54_combout\ <= NOT \Result~54_combout\;
\ALT_INV_mv.iav.av[1].sum\(2) <= NOT \mv.iav.av[1].sum\(2);
\ALT_INV_Result~53_combout\ <= NOT \Result~53_combout\;
\ALT_INV_mv.iav.av[1].sum\(1) <= NOT \mv.iav.av[1].sum\(1);
\ALT_INV_Result~52_combout\ <= NOT \Result~52_combout\;
\ALT_INV_mv.iav.av[1].sum\(0) <= NOT \mv.iav.av[1].sum\(0);
\ALT_INV_Result~51_combout\ <= NOT \Result~51_combout\;
\ALT_INV_mv.iav.av[1].sum[-1]~q\ <= NOT \mv.iav.av[1].sum[-1]~q\;
\ALT_INV_Result~50_combout\ <= NOT \Result~50_combout\;
\ALT_INV_mv.iav.av[1].sum[-2]~q\ <= NOT \mv.iav.av[1].sum[-2]~q\;
\ALT_INV_Result~49_combout\ <= NOT \Result~49_combout\;
\ALT_INV_mv.iav.av[1].sum[-3]~q\ <= NOT \mv.iav.av[1].sum[-3]~q\;
\ALT_INV_Result~48_combout\ <= NOT \Result~48_combout\;
\ALT_INV_mv.iav.av[1].sum[-4]~q\ <= NOT \mv.iav.av[1].sum[-4]~q\;
\ALT_INV_Result~47_combout\ <= NOT \Result~47_combout\;
\ALT_INV_mv.iav.av[1].sum[-5]~q\ <= NOT \mv.iav.av[1].sum[-5]~q\;
\ALT_INV_Result~46_combout\ <= NOT \Result~46_combout\;
\ALT_INV_mv.iav.av[1].sum[-6]~q\ <= NOT \mv.iav.av[1].sum[-6]~q\;
\ALT_INV_Result~45_combout\ <= NOT \Result~45_combout\;
\ALT_INV_mv.iav.av[1].sum[-7]~q\ <= NOT \mv.iav.av[1].sum[-7]~q\;
\ALT_INV_Result~44_combout\ <= NOT \Result~44_combout\;
\ALT_INV_mv.iav.av[1].sum[-8]~q\ <= NOT \mv.iav.av[1].sum[-8]~q\;
\ALT_INV_Result~43_combout\ <= NOT \Result~43_combout\;
\ALT_INV_mv.iav.av[1].sum[-9]~q\ <= NOT \mv.iav.av[1].sum[-9]~q\;
\ALT_INV_Result~42_combout\ <= NOT \Result~42_combout\;
\ALT_INV_mv.iav.av[1].sum[-10]~q\ <= NOT \mv.iav.av[1].sum[-10]~q\;
\ALT_INV_Result~41_combout\ <= NOT \Result~41_combout\;
\ALT_INV_mv.iav.av[1].sum[-11]~q\ <= NOT \mv.iav.av[1].sum[-11]~q\;
\ALT_INV_Result~40_combout\ <= NOT \Result~40_combout\;
\ALT_INV_mv.iav.av[1].sum[-12]~q\ <= NOT \mv.iav.av[1].sum[-12]~q\;
\ALT_INV_overflowx~0_combout\ <= NOT \overflowx~0_combout\;
\ALT_INV_Result~39_combout\ <= NOT \Result~39_combout\;
\ALT_INV_Result~38_combout\ <= NOT \Result~38_combout\;
\ALT_INV_Result~37_combout\ <= NOT \Result~37_combout\;
\ALT_INV_Result~36_combout\ <= NOT \Result~36_combout\;
\ALT_INV_Result~35_combout\ <= NOT \Result~35_combout\;
\ALT_INV_Result~34_combout\ <= NOT \Result~34_combout\;
\ALT_INV_mv.iav.av[1].sum\(4) <= NOT \mv.iav.av[1].sum\(4);
\ALT_INV_Result~168_combout\ <= NOT \Result~168_combout\;
\ALT_INV_Result~167_combout\ <= NOT \Result~167_combout\;
\ALT_INV_Result~166_combout\ <= NOT \Result~166_combout\;
\ALT_INV_mv.qav.av[0].sum[-10]~q\ <= NOT \mv.qav.av[0].sum[-10]~q\;
\ALT_INV_round_overflow~1_combout\ <= NOT \round_overflow~1_combout\;
\ALT_INV_Result~165_combout\ <= NOT \Result~165_combout\;
\ALT_INV_Result~164_combout\ <= NOT \Result~164_combout\;
\ALT_INV_Result~163_combout\ <= NOT \Result~163_combout\;
\ALT_INV_Result~162_combout\ <= NOT \Result~162_combout\;
\ALT_INV_Result~161_combout\ <= NOT \Result~161_combout\;
\ALT_INV_Result~160_combout\ <= NOT \Result~160_combout\;
\ALT_INV_rounds~3_combout\ <= NOT \rounds~3_combout\;
\ALT_INV_mv.qav.av[0].sum[-15]~q\ <= NOT \mv.qav.av[0].sum[-15]~q\;
\ALT_INV_mv.qav.av[0].sum[-16]~q\ <= NOT \mv.qav.av[0].sum[-16]~q\;
\ALT_INV_mv.qav.av[0].sum[-17]~q\ <= NOT \mv.qav.av[0].sum[-17]~q\;
\ALT_INV_mv.qav.av[0].sum[-14]~q\ <= NOT \mv.qav.av[0].sum[-14]~q\;
\ALT_INV_mv.qav.av[0].sum[-13]~q\ <= NOT \mv.qav.av[0].sum[-13]~q\;
\ALT_INV_mv.qav.av[0].sum\(4) <= NOT \mv.qav.av[0].sum\(4);
\ALT_INV_Result~159_combout\ <= NOT \Result~159_combout\;
\ALT_INV_Result~158_combout\ <= NOT \Result~158_combout\;
\ALT_INV_mv.iav.av[0].sum\(3) <= NOT \mv.iav.av[0].sum\(3);
\ALT_INV_Result~157_combout\ <= NOT \Result~157_combout\;
\ALT_INV_Result~156_combout\ <= NOT \Result~156_combout\;
\ALT_INV_mv.iav.av[0].sum\(2) <= NOT \mv.iav.av[0].sum\(2);
\ALT_INV_Result~155_combout\ <= NOT \Result~155_combout\;
\ALT_INV_Result~154_combout\ <= NOT \Result~154_combout\;
\ALT_INV_mv.iav.av[0].sum\(1) <= NOT \mv.iav.av[0].sum\(1);
\ALT_INV_Result~153_combout\ <= NOT \Result~153_combout\;
\ALT_INV_Result~152_combout\ <= NOT \Result~152_combout\;
\ALT_INV_mv.iav.av[0].sum\(0) <= NOT \mv.iav.av[0].sum\(0);
\ALT_INV_Result~151_combout\ <= NOT \Result~151_combout\;
\ALT_INV_Result~150_combout\ <= NOT \Result~150_combout\;
\ALT_INV_mv.iav.av[0].sum[-1]~q\ <= NOT \mv.iav.av[0].sum[-1]~q\;
\ALT_INV_Result~149_combout\ <= NOT \Result~149_combout\;
\ALT_INV_Result~148_combout\ <= NOT \Result~148_combout\;
\ALT_INV_mv.iav.av[0].sum[-2]~q\ <= NOT \mv.iav.av[0].sum[-2]~q\;
\ALT_INV_Result~147_combout\ <= NOT \Result~147_combout\;
\ALT_INV_Result~146_combout\ <= NOT \Result~146_combout\;
\ALT_INV_mv.iav.av[0].sum[-3]~q\ <= NOT \mv.iav.av[0].sum[-3]~q\;
\ALT_INV_Result~145_combout\ <= NOT \Result~145_combout\;
\ALT_INV_Result~144_combout\ <= NOT \Result~144_combout\;
\ALT_INV_mv.iav.av[0].sum[-4]~q\ <= NOT \mv.iav.av[0].sum[-4]~q\;
\ALT_INV_Result~143_combout\ <= NOT \Result~143_combout\;
\ALT_INV_Result~142_combout\ <= NOT \Result~142_combout\;
\ALT_INV_mv.iav.av[0].sum[-5]~q\ <= NOT \mv.iav.av[0].sum[-5]~q\;
\ALT_INV_Result~141_combout\ <= NOT \Result~141_combout\;
\ALT_INV_Result~140_combout\ <= NOT \Result~140_combout\;
\ALT_INV_mv.iav.av[0].sum[-6]~q\ <= NOT \mv.iav.av[0].sum[-6]~q\;
\ALT_INV_Result~139_combout\ <= NOT \Result~139_combout\;
\ALT_INV_Result~138_combout\ <= NOT \Result~138_combout\;
\ALT_INV_mv.iav.av[0].sum[-7]~q\ <= NOT \mv.iav.av[0].sum[-7]~q\;
\ALT_INV_Result~137_combout\ <= NOT \Result~137_combout\;
\ALT_INV_Result~136_combout\ <= NOT \Result~136_combout\;
\ALT_INV_mv.iav.av[0].sum[-8]~q\ <= NOT \mv.iav.av[0].sum[-8]~q\;
\ALT_INV_Result~135_combout\ <= NOT \Result~135_combout\;
\ALT_INV_Result~134_combout\ <= NOT \Result~134_combout\;
\ALT_INV_mv.iav.av[0].sum[-11]~q\ <= NOT \mv.iav.av[0].sum[-11]~q\;
\ALT_INV_Result~133_combout\ <= NOT \Result~133_combout\;
\ALT_INV_Result~132_combout\ <= NOT \Result~132_combout\;
\ALT_INV_mv.iav.av[0].sum[-9]~q\ <= NOT \mv.iav.av[0].sum[-9]~q\;
\ALT_INV_Result~131_combout\ <= NOT \Result~131_combout\;
\ALT_INV_Result~130_combout\ <= NOT \Result~130_combout\;
\ALT_INV_mv.iav.av[0].sum[-12]~q\ <= NOT \mv.iav.av[0].sum[-12]~q\;
\ALT_INV_Result~129_combout\ <= NOT \Result~129_combout\;
\ALT_INV_Result~128_combout\ <= NOT \Result~128_combout\;
\ALT_INV_Result~127_combout\ <= NOT \Result~127_combout\;
\ALT_INV_Result~126_combout\ <= NOT \Result~126_combout\;
\ALT_INV_mv.iav.av[0].sum[-10]~q\ <= NOT \mv.iav.av[0].sum[-10]~q\;
\ALT_INV_round_overflow~0_combout\ <= NOT \round_overflow~0_combout\;
\ALT_INV_Result~125_combout\ <= NOT \Result~125_combout\;
\ALT_INV_Result~124_combout\ <= NOT \Result~124_combout\;
\ALT_INV_Result~123_combout\ <= NOT \Result~123_combout\;
\ALT_INV_Result~122_combout\ <= NOT \Result~122_combout\;
\ALT_INV_Result~121_combout\ <= NOT \Result~121_combout\;
\ALT_INV_Result~120_combout\ <= NOT \Result~120_combout\;
\ALT_INV_rounds~2_combout\ <= NOT \rounds~2_combout\;
\ALT_INV_mv.iav.av[0].sum[-15]~q\ <= NOT \mv.iav.av[0].sum[-15]~q\;
\ALT_INV_mv.iav.av[0].sum[-16]~q\ <= NOT \mv.iav.av[0].sum[-16]~q\;
\ALT_INV_mv.iav.av[0].sum[-17]~q\ <= NOT \mv.iav.av[0].sum[-17]~q\;
\ALT_INV_mv.iav.av[0].sum[-14]~q\ <= NOT \mv.iav.av[0].sum[-14]~q\;
\ALT_INV_mv.iav.av[0].sum[-13]~q\ <= NOT \mv.iav.av[0].sum[-13]~q\;
\ALT_INV_mv.iav.av[0].sum\(4) <= NOT \mv.iav.av[0].sum\(4);
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit1~q\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit3~q\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit2~q\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-1]~q\ <= NOT \mv.qav.av[0].in_sr[15][-1]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-2]~q\ <= NOT \mv.qav.av[0].in_sr[15][-2]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-3]~q\ <= NOT \mv.qav.av[0].in_sr[15][-3]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-4]~q\ <= NOT \mv.qav.av[0].in_sr[15][-4]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-5]~q\ <= NOT \mv.qav.av[0].in_sr[15][-5]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-6]~q\ <= NOT \mv.qav.av[0].in_sr[15][-6]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-7]~q\ <= NOT \mv.qav.av[0].in_sr[15][-7]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-8]~q\ <= NOT \mv.qav.av[0].in_sr[15][-8]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-11]~q\ <= NOT \mv.qav.av[0].in_sr[15][-11]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-9]~q\ <= NOT \mv.qav.av[0].in_sr[15][-9]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-12]~q\ <= NOT \mv.qav.av[0].in_sr[15][-12]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-10]~q\ <= NOT \mv.qav.av[0].in_sr[15][-10]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-15]~q\ <= NOT \mv.qav.av[0].in_sr[15][-15]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-16]~q\ <= NOT \mv.qav.av[0].in_sr[15][-16]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-17]~q\ <= NOT \mv.qav.av[0].in_sr[15][-17]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-14]~q\ <= NOT \mv.qav.av[0].in_sr[15][-14]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][-13]~q\ <= NOT \mv.qav.av[0].in_sr[15][-13]~q\;
\ALT_INV_mv.qav.av[0].in_sr[15][0]~q\ <= NOT \mv.qav.av[0].in_sr[15][0]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-1]~q\ <= NOT \mv.iav.av[0].in_sr[15][-1]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-2]~q\ <= NOT \mv.iav.av[0].in_sr[15][-2]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-3]~q\ <= NOT \mv.iav.av[0].in_sr[15][-3]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-4]~q\ <= NOT \mv.iav.av[0].in_sr[15][-4]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-5]~q\ <= NOT \mv.iav.av[0].in_sr[15][-5]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-6]~q\ <= NOT \mv.iav.av[0].in_sr[15][-6]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-7]~q\ <= NOT \mv.iav.av[0].in_sr[15][-7]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-8]~q\ <= NOT \mv.iav.av[0].in_sr[15][-8]~q\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit3~q\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-11]~q\ <= NOT \mv.iav.av[0].in_sr[15][-11]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-9]~q\ <= NOT \mv.iav.av[0].in_sr[15][-9]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-12]~q\ <= NOT \mv.iav.av[0].in_sr[15][-12]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-10]~q\ <= NOT \mv.iav.av[0].in_sr[15][-10]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-15]~q\ <= NOT \mv.iav.av[0].in_sr[15][-15]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-16]~q\ <= NOT \mv.iav.av[0].in_sr[15][-16]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-17]~q\ <= NOT \mv.iav.av[0].in_sr[15][-17]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-14]~q\ <= NOT \mv.iav.av[0].in_sr[15][-14]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][-13]~q\ <= NOT \mv.iav.av[0].in_sr[15][-13]~q\;
\ALT_INV_mv.iav.av[0].in_sr[15][0]~q\ <= NOT \mv.iav.av[0].in_sr[15][0]~q\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1) <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(1);
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3) <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3);
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2) <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2);
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1) <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1);
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0) <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0);
\mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe6~q\;
\ALT_INV_Result~199_combout\ <= NOT \Result~199_combout\;
\ALT_INV_Result~198_combout\ <= NOT \Result~198_combout\;
\ALT_INV_mv.qav.av[0].sum\(3) <= NOT \mv.qav.av[0].sum\(3);
\ALT_INV_Result~197_combout\ <= NOT \Result~197_combout\;
\ALT_INV_Result~196_combout\ <= NOT \Result~196_combout\;
\ALT_INV_mv.qav.av[0].sum\(2) <= NOT \mv.qav.av[0].sum\(2);
\ALT_INV_Result~195_combout\ <= NOT \Result~195_combout\;
\ALT_INV_Result~194_combout\ <= NOT \Result~194_combout\;
\ALT_INV_mv.qav.av[0].sum\(1) <= NOT \mv.qav.av[0].sum\(1);
\ALT_INV_Result~193_combout\ <= NOT \Result~193_combout\;
\ALT_INV_Result~192_combout\ <= NOT \Result~192_combout\;
\ALT_INV_mv.qav.av[0].sum\(0) <= NOT \mv.qav.av[0].sum\(0);
\ALT_INV_Result~191_combout\ <= NOT \Result~191_combout\;
\ALT_INV_Result~190_combout\ <= NOT \Result~190_combout\;
\ALT_INV_mv.qav.av[0].sum[-1]~q\ <= NOT \mv.qav.av[0].sum[-1]~q\;
\ALT_INV_Result~189_combout\ <= NOT \Result~189_combout\;
\ALT_INV_Result~188_combout\ <= NOT \Result~188_combout\;
\ALT_INV_mv.qav.av[0].sum[-2]~q\ <= NOT \mv.qav.av[0].sum[-2]~q\;
\ALT_INV_Result~187_combout\ <= NOT \Result~187_combout\;
\ALT_INV_Result~186_combout\ <= NOT \Result~186_combout\;
\ALT_INV_mv.qav.av[0].sum[-3]~q\ <= NOT \mv.qav.av[0].sum[-3]~q\;
\ALT_INV_Result~185_combout\ <= NOT \Result~185_combout\;
\ALT_INV_Result~184_combout\ <= NOT \Result~184_combout\;
\ALT_INV_mv.qav.av[0].sum[-4]~q\ <= NOT \mv.qav.av[0].sum[-4]~q\;
\ALT_INV_Result~183_combout\ <= NOT \Result~183_combout\;
\ALT_INV_Result~182_combout\ <= NOT \Result~182_combout\;
\ALT_INV_mv.qav.av[0].sum[-5]~q\ <= NOT \mv.qav.av[0].sum[-5]~q\;
\ALT_INV_Result~181_combout\ <= NOT \Result~181_combout\;
\ALT_INV_Result~180_combout\ <= NOT \Result~180_combout\;
\ALT_INV_mv.qav.av[0].sum[-6]~q\ <= NOT \mv.qav.av[0].sum[-6]~q\;
\ALT_INV_Result~179_combout\ <= NOT \Result~179_combout\;
\ALT_INV_Result~178_combout\ <= NOT \Result~178_combout\;
\ALT_INV_mv.qav.av[0].sum[-7]~q\ <= NOT \mv.qav.av[0].sum[-7]~q\;
\ALT_INV_Result~177_combout\ <= NOT \Result~177_combout\;
\ALT_INV_Result~176_combout\ <= NOT \Result~176_combout\;
\ALT_INV_mv.qav.av[0].sum[-8]~q\ <= NOT \mv.qav.av[0].sum[-8]~q\;
\ALT_INV_Result~175_combout\ <= NOT \Result~175_combout\;
\ALT_INV_Result~174_combout\ <= NOT \Result~174_combout\;
\ALT_INV_mv.qav.av[0].sum[-11]~q\ <= NOT \mv.qav.av[0].sum[-11]~q\;
\ALT_INV_Result~173_combout\ <= NOT \Result~173_combout\;
\ALT_INV_Result~172_combout\ <= NOT \Result~172_combout\;
\ALT_INV_mv.qav.av[0].sum[-9]~q\ <= NOT \mv.qav.av[0].sum[-9]~q\;
\ALT_INV_Result~171_combout\ <= NOT \Result~171_combout\;
\ALT_INV_Result~170_combout\ <= NOT \Result~170_combout\;
\ALT_INV_mv.qav.av[0].sum[-12]~q\ <= NOT \mv.qav.av[0].sum[-12]~q\;
\ALT_INV_Result~169_combout\ <= NOT \Result~169_combout\;
\ALT_INV_x2[16]~input_o\ <= NOT \x2[16]~input_o\;
\ALT_INV_x2[15]~input_o\ <= NOT \x2[15]~input_o\;
\ALT_INV_x2[14]~input_o\ <= NOT \x2[14]~input_o\;
\ALT_INV_x2[13]~input_o\ <= NOT \x2[13]~input_o\;
\ALT_INV_x2[12]~input_o\ <= NOT \x2[12]~input_o\;
\ALT_INV_x2[11]~input_o\ <= NOT \x2[11]~input_o\;
\ALT_INV_x2[10]~input_o\ <= NOT \x2[10]~input_o\;
\ALT_INV_x2[9]~input_o\ <= NOT \x2[9]~input_o\;
\ALT_INV_x2[8]~input_o\ <= NOT \x2[8]~input_o\;
\ALT_INV_x2[7]~input_o\ <= NOT \x2[7]~input_o\;
\ALT_INV_x2[6]~input_o\ <= NOT \x2[6]~input_o\;
\ALT_INV_x2[5]~input_o\ <= NOT \x2[5]~input_o\;
\ALT_INV_x2[4]~input_o\ <= NOT \x2[4]~input_o\;
\ALT_INV_x2[3]~input_o\ <= NOT \x2[3]~input_o\;
\ALT_INV_x2[2]~input_o\ <= NOT \x2[2]~input_o\;
\ALT_INV_x2[1]~input_o\ <= NOT \x2[1]~input_o\;
\ALT_INV_x2[0]~input_o\ <= NOT \x2[0]~input_o\;
\ALT_INV_x2[17]~input_o\ <= NOT \x2[17]~input_o\;
\ALT_INV_x1[16]~input_o\ <= NOT \x1[16]~input_o\;
\ALT_INV_x1[15]~input_o\ <= NOT \x1[15]~input_o\;
\ALT_INV_x1[14]~input_o\ <= NOT \x1[14]~input_o\;
\ALT_INV_x1[13]~input_o\ <= NOT \x1[13]~input_o\;
\ALT_INV_x1[12]~input_o\ <= NOT \x1[12]~input_o\;
\ALT_INV_x1[11]~input_o\ <= NOT \x1[11]~input_o\;
\ALT_INV_x1[10]~input_o\ <= NOT \x1[10]~input_o\;
\ALT_INV_x1[9]~input_o\ <= NOT \x1[9]~input_o\;
\ALT_INV_x1[8]~input_o\ <= NOT \x1[8]~input_o\;
\ALT_INV_x1[7]~input_o\ <= NOT \x1[7]~input_o\;
\ALT_INV_x1[6]~input_o\ <= NOT \x1[6]~input_o\;
\ALT_INV_x1[5]~input_o\ <= NOT \x1[5]~input_o\;
\ALT_INV_x1[4]~input_o\ <= NOT \x1[4]~input_o\;
\ALT_INV_x1[3]~input_o\ <= NOT \x1[3]~input_o\;
\ALT_INV_x1[2]~input_o\ <= NOT \x1[2]~input_o\;
\ALT_INV_x1[1]~input_o\ <= NOT \x1[1]~input_o\;
\ALT_INV_x1[0]~input_o\ <= NOT \x1[0]~input_o\;
\ALT_INV_x1[17]~input_o\ <= NOT \x1[17]~input_o\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit0~q\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit1~q\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\;
\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit0~q\ <= NOT \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\;
\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit2~q\ <= NOT \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\;

\y1[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[0]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[0]~output_o\);

\y1[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[1]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[1]~output_o\);

\y1[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[2]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[2]~output_o\);

\y1[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[3]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[3]~output_o\);

\y1[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[4]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[4]~output_o\);

\y1[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[5]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[5]~output_o\);

\y1[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[6]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[6]~output_o\);

\y1[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[7]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[7]~output_o\);

\y1[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[8]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[8]~output_o\);

\y1[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[9]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[9]~output_o\);

\y1[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[10]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[10]~output_o\);

\y1[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[11]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[11]~output_o\);

\y1[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[12]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[12]~output_o\);

\y1[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[13]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[13]~output_o\);

\y1[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[14]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[14]~output_o\);

\y1[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[15]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[15]~output_o\);

\y1[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[16]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[16]~output_o\);

\y1[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y1[17]~reg0_q\,
	devoe => ww_devoe,
	o => \y1[17]~output_o\);

\y2[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[0]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[0]~output_o\);

\y2[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[1]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[1]~output_o\);

\y2[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[2]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[2]~output_o\);

\y2[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[3]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[3]~output_o\);

\y2[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[4]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[4]~output_o\);

\y2[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[5]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[5]~output_o\);

\y2[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[6]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[6]~output_o\);

\y2[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[7]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[7]~output_o\);

\y2[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[8]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[8]~output_o\);

\y2[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[9]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[9]~output_o\);

\y2[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[10]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[10]~output_o\);

\y2[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[11]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[11]~output_o\);

\y2[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[12]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[12]~output_o\);

\y2[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[13]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[13]~output_o\);

\y2[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[14]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[14]~output_o\);

\y2[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[15]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[15]~output_o\);

\y2[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[16]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[16]~output_o\);

\y2[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \y2[17]~reg0_q\,
	devoe => ww_devoe,
	o => \y2[17]~output_o\);

\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

\x1[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(17),
	o => \x1[17]~input_o\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ = CARRY(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit0~q\,
	cin => GND,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\);

\rst_n~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst_n,
	o => \rst_n~input_o\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~sumout\,
	clrn => \rst_n~input_o\,
	ena => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit0~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ = CARRY(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit1~q\,
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita0~COUT\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~sumout\,
	clrn => \rst_n~input_o\,
	ena => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit1~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\ = SUM(( !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ = CARRY(( !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit2~q\,
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita1~COUT\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\ = !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita2~sumout\,
	combout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit2~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\ = SUM(( !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\ = CARRY(( !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_reg_bit3~q\,
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita2~COUT\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\ = !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~sumout\,
	combout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_reg_bit3~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\ = SUM(( GND ) + ( GND ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~COUT\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe7~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe7~0_combout\ = !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|counter_comb_bita3~1_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr6|ALT_INV_counter_comb_bita3~1_sumout\,
	combout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe7~0_combout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe7~0_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe7~q\);

\mv.iav.av[0].in_sr[0][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[17]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][0]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ = CARRY(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ = CARRY(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	sclr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ = CARRY(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	sclr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\ = CARRY(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\,
	sclr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ = SUM(( GND ) + ( GND ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~COUT\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\ = ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ ) # ( !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~1_sumout\ & ( 
-- (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) & (!\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000100111111111111111100000000000001001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	datab => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	datac => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	datae => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_comb_bita3~1_sumout\,
	combout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	sclr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|cout_actual~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~1_sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~2\ = CARRY(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~2\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\ = (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000100010001000100010001000100010001000100010001000100010001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	datab => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	combout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\ = (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) & (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) & 
-- (!\mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) & \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000010000000000000001000000000000000100000000000000010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	datab => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	datac => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	combout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( (!\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\ & 
-- !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~2\ ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~6\ = CARRY(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( (!\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\ & 
-- !\mv.iav.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010101011111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\,
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\,
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~2\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~6\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ = !\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~5_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\,
	combout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(1));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ = !\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(1)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1),
	combout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~9_sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) # 
-- (\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\) ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~6\ ))
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~10\ = CARRY(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( (\mv.iav.av[0].in_sr_rtl_0|auto_generated|cmpr4_aeb_int~0_combout\) # 
-- (\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_2~0_combout\) ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010100000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_op_2~0_combout\,
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_cmpr4_aeb_int~0_combout\,
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~6\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	cout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~10\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(2));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~13_sumout\ = SUM(( \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[0].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	cin => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~10\,
	sumout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~13_sumout\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|op_1~13_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr_rtl_0|auto_generated|dffe3a\(3));

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 0,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][0]~q\);

\Add1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~5_sumout\ = SUM(( !\mv.iav.av[0].sum\(4) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~95\ ) + ( \Add1~94\ ))
-- \Add1~6\ = CARRY(( !\mv.iav.av[0].sum\(4) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~95\ ) + ( \Add1~94\ ))
-- \Add1~7\ = SHARE((!\mv.iav.av[0].sum\(4) & (\x1[17]~input_o\ & !\mv.iav.av[0].in_sr[15][0]~q\)) # (\mv.iav.av[0].sum\(4) & ((!\mv.iav.av[0].in_sr[15][0]~q\) # (\x1[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum\(4),
	datac => \ALT_INV_x1[17]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][0]~q\,
	cin => \Add1~94\,
	sharein => \Add1~95\,
	sumout => \Add1~5_sumout\,
	cout => \Add1~6\,
	shareout => \Add1~7\);

\Add1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~9_sumout\ = SUM(( !\mv.iav.av[0].sum\(4) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~7\ ) + ( \Add1~6\ ))
-- \Add1~10\ = CARRY(( !\mv.iav.av[0].sum\(4) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~7\ ) + ( \Add1~6\ ))
-- \Add1~11\ = SHARE((!\mv.iav.av[0].sum\(4) & (\x1[17]~input_o\ & !\mv.iav.av[0].in_sr[15][0]~q\)) # (\mv.iav.av[0].sum\(4) & ((!\mv.iav.av[0].in_sr[15][0]~q\) # (\x1[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum\(4),
	datac => \ALT_INV_x1[17]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][0]~q\,
	cin => \Add1~6\,
	sharein => \Add1~7\,
	sumout => \Add1~9_sumout\,
	cout => \Add1~10\,
	shareout => \Add1~11\);

\x1[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(16),
	o => \x1[16]~input_o\);

\mv.iav.av[0].in_sr[0][-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[16]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-1]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 1,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-1]~q\);

\x1[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(15),
	o => \x1[15]~input_o\);

\mv.iav.av[0].in_sr[0][-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[15]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-2]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 2,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-2]~q\);

\x1[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(14),
	o => \x1[14]~input_o\);

\mv.iav.av[0].in_sr[0][-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[14]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-3]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 3,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-3]~q\);

\x1[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(13),
	o => \x1[13]~input_o\);

\mv.iav.av[0].in_sr[0][-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[13]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-4]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 4,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-4]~q\);

\x1[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(12),
	o => \x1[12]~input_o\);

\mv.iav.av[0].in_sr[0][-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[12]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-5]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 5,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-5]~q\);

\x1[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(11),
	o => \x1[11]~input_o\);

\mv.iav.av[0].in_sr[0][-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[11]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-6]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 6,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-6]~q\);

\x1[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(10),
	o => \x1[10]~input_o\);

\mv.iav.av[0].in_sr[0][-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[10]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-7]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 7,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-7]~q\);

\x1[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(9),
	o => \x1[9]~input_o\);

\mv.iav.av[0].in_sr[0][-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[9]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-8]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 8,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-8]~q\);

\x1[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(8),
	o => \x1[8]~input_o\);

\mv.iav.av[0].in_sr[0][-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[8]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-9]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 9,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-9]~q\);

\x1[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(7),
	o => \x1[7]~input_o\);

\mv.iav.av[0].in_sr[0][-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[7]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-10]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 10,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-10]~q\);

\x1[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(6),
	o => \x1[6]~input_o\);

\mv.iav.av[0].in_sr[0][-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[6]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-11]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 11,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-11]~q\);

\x1[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(5),
	o => \x1[5]~input_o\);

\mv.iav.av[0].in_sr[0][-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[5]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-12]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 12,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-12]~q\);

\x1[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(4),
	o => \x1[4]~input_o\);

\mv.iav.av[0].in_sr[0][-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[4]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-13]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 13,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-13]~q\);

\x1[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(3),
	o => \x1[3]~input_o\);

\mv.iav.av[0].in_sr[0][-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[3]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-14]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 14,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-14]~q\);

\x1[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(2),
	o => \x1[2]~input_o\);

\mv.iav.av[0].in_sr[0][-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[2]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-15]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 15,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-15]~q\);

\x1[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(1),
	o => \x1[1]~input_o\);

\mv.iav.av[0].in_sr[0][-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[1]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-16]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 16,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-16]~q\);

\x1[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x1(0),
	o => \x1[0]~input_o\);

\mv.iav.av[0].in_sr[0][-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x1[0]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[0][-17]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
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
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 17,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17_PORTBDATAOUT_bus\);

\mv.iav.av[0].in_sr[15][-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].in_sr[15][-17]~q\);

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

\Add1~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~21_sumout\ = SUM(( !\mv.iav.av[0].sum[-17]~q\ $ (!\x1[0]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-17]~q\)) ) + ( \Add1~99\ ) + ( \Add1~98_cout\ ))
-- \Add1~22\ = CARRY(( !\mv.iav.av[0].sum[-17]~q\ $ (!\x1[0]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-17]~q\)) ) + ( \Add1~99\ ) + ( \Add1~98_cout\ ))
-- \Add1~23\ = SHARE((!\mv.iav.av[0].sum[-17]~q\ & (\x1[0]~input_o\ & !\mv.iav.av[0].in_sr[15][-17]~q\)) # (\mv.iav.av[0].sum[-17]~q\ & ((!\mv.iav.av[0].in_sr[15][-17]~q\) # (\x1[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-17]~q\,
	datac => \ALT_INV_x1[0]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-17]~q\,
	cin => \Add1~98_cout\,
	sharein => \Add1~99\,
	sumout => \Add1~21_sumout\,
	cout => \Add1~22\,
	shareout => \Add1~23\);

\Result~202\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~202_combout\ = (!\Add1~1_sumout\ & (((\Add1~21_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~21_sumout\,
	combout => \Result~202_combout\);

\mv.iav.av[0].sum[-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~202_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-17]~q\);

\Add1~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~25_sumout\ = SUM(( !\mv.iav.av[0].sum[-16]~q\ $ (!\x1[1]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-16]~q\)) ) + ( \Add1~23\ ) + ( \Add1~22\ ))
-- \Add1~26\ = CARRY(( !\mv.iav.av[0].sum[-16]~q\ $ (!\x1[1]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-16]~q\)) ) + ( \Add1~23\ ) + ( \Add1~22\ ))
-- \Add1~27\ = SHARE((!\mv.iav.av[0].sum[-16]~q\ & (\x1[1]~input_o\ & !\mv.iav.av[0].in_sr[15][-16]~q\)) # (\mv.iav.av[0].sum[-16]~q\ & ((!\mv.iav.av[0].in_sr[15][-16]~q\) # (\x1[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-16]~q\,
	datac => \ALT_INV_x1[1]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-16]~q\,
	cin => \Add1~22\,
	sharein => \Add1~23\,
	sumout => \Add1~25_sumout\,
	cout => \Add1~26\,
	shareout => \Add1~27\);

\Result~203\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~203_combout\ = (!\Add1~1_sumout\ & (((\Add1~25_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~25_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~25_sumout\,
	combout => \Result~203_combout\);

\mv.iav.av[0].sum[-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~203_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-16]~q\);

\Add1~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~29_sumout\ = SUM(( !\mv.iav.av[0].sum[-15]~q\ $ (!\x1[2]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-15]~q\)) ) + ( \Add1~27\ ) + ( \Add1~26\ ))
-- \Add1~30\ = CARRY(( !\mv.iav.av[0].sum[-15]~q\ $ (!\x1[2]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-15]~q\)) ) + ( \Add1~27\ ) + ( \Add1~26\ ))
-- \Add1~31\ = SHARE((!\mv.iav.av[0].sum[-15]~q\ & (\x1[2]~input_o\ & !\mv.iav.av[0].in_sr[15][-15]~q\)) # (\mv.iav.av[0].sum[-15]~q\ & ((!\mv.iav.av[0].in_sr[15][-15]~q\) # (\x1[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-15]~q\,
	datac => \ALT_INV_x1[2]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-15]~q\,
	cin => \Add1~26\,
	sharein => \Add1~27\,
	sumout => \Add1~29_sumout\,
	cout => \Add1~30\,
	shareout => \Add1~31\);

\Result~204\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~204_combout\ = (!\Add1~1_sumout\ & (((\Add1~29_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~29_sumout\,
	combout => \Result~204_combout\);

\mv.iav.av[0].sum[-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~204_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-15]~q\);

\Add1~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~17_sumout\ = SUM(( !\mv.iav.av[0].sum[-14]~q\ $ (!\x1[3]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-14]~q\)) ) + ( \Add1~31\ ) + ( \Add1~30\ ))
-- \Add1~18\ = CARRY(( !\mv.iav.av[0].sum[-14]~q\ $ (!\x1[3]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-14]~q\)) ) + ( \Add1~31\ ) + ( \Add1~30\ ))
-- \Add1~19\ = SHARE((!\mv.iav.av[0].sum[-14]~q\ & (\x1[3]~input_o\ & !\mv.iav.av[0].in_sr[15][-14]~q\)) # (\mv.iav.av[0].sum[-14]~q\ & ((!\mv.iav.av[0].in_sr[15][-14]~q\) # (\x1[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-14]~q\,
	datac => \ALT_INV_x1[3]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-14]~q\,
	cin => \Add1~30\,
	sharein => \Add1~31\,
	sumout => \Add1~17_sumout\,
	cout => \Add1~18\,
	shareout => \Add1~19\);

\Result~201\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~201_combout\ = (!\Add1~1_sumout\ & (((\Add1~17_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~17_sumout\,
	combout => \Result~201_combout\);

\mv.iav.av[0].sum[-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~201_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-14]~q\);

\Add1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~13_sumout\ = SUM(( !\mv.iav.av[0].sum[-13]~q\ $ (!\x1[4]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-13]~q\)) ) + ( \Add1~19\ ) + ( \Add1~18\ ))
-- \Add1~14\ = CARRY(( !\mv.iav.av[0].sum[-13]~q\ $ (!\x1[4]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-13]~q\)) ) + ( \Add1~19\ ) + ( \Add1~18\ ))
-- \Add1~15\ = SHARE((!\mv.iav.av[0].sum[-13]~q\ & (\x1[4]~input_o\ & !\mv.iav.av[0].in_sr[15][-13]~q\)) # (\mv.iav.av[0].sum[-13]~q\ & ((!\mv.iav.av[0].in_sr[15][-13]~q\) # (\x1[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-13]~q\,
	datac => \ALT_INV_x1[4]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-13]~q\,
	cin => \Add1~18\,
	sharein => \Add1~19\,
	sumout => \Add1~13_sumout\,
	cout => \Add1~14\,
	shareout => \Add1~15\);

\Result~200\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~200_combout\ = (!\Add1~1_sumout\ & (((\Add1~13_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~13_sumout\,
	combout => \Result~200_combout\);

\mv.iav.av[0].sum[-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~200_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-13]~q\);

\Add1~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~37_sumout\ = SUM(( !\mv.iav.av[0].sum[-12]~q\ $ (!\x1[5]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-12]~q\)) ) + ( \Add1~15\ ) + ( \Add1~14\ ))
-- \Add1~38\ = CARRY(( !\mv.iav.av[0].sum[-12]~q\ $ (!\x1[5]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-12]~q\)) ) + ( \Add1~15\ ) + ( \Add1~14\ ))
-- \Add1~39\ = SHARE((!\mv.iav.av[0].sum[-12]~q\ & (\x1[5]~input_o\ & !\mv.iav.av[0].in_sr[15][-12]~q\)) # (\mv.iav.av[0].sum[-12]~q\ & ((!\mv.iav.av[0].in_sr[15][-12]~q\) # (\x1[5]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-12]~q\,
	datac => \ALT_INV_x1[5]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-12]~q\,
	cin => \Add1~14\,
	sharein => \Add1~15\,
	sumout => \Add1~37_sumout\,
	cout => \Add1~38\,
	shareout => \Add1~39\);

\Result~206\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~206_combout\ = (!\Add1~1_sumout\ & (((\Add1~37_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~37_sumout\,
	combout => \Result~206_combout\);

\mv.iav.av[0].sum[-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~206_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-12]~q\);

\Add1~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~45_sumout\ = SUM(( !\mv.iav.av[0].sum[-11]~q\ $ (!\x1[6]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-11]~q\)) ) + ( \Add1~39\ ) + ( \Add1~38\ ))
-- \Add1~46\ = CARRY(( !\mv.iav.av[0].sum[-11]~q\ $ (!\x1[6]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-11]~q\)) ) + ( \Add1~39\ ) + ( \Add1~38\ ))
-- \Add1~47\ = SHARE((!\mv.iav.av[0].sum[-11]~q\ & (\x1[6]~input_o\ & !\mv.iav.av[0].in_sr[15][-11]~q\)) # (\mv.iav.av[0].sum[-11]~q\ & ((!\mv.iav.av[0].in_sr[15][-11]~q\) # (\x1[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-11]~q\,
	datac => \ALT_INV_x1[6]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-11]~q\,
	cin => \Add1~38\,
	sharein => \Add1~39\,
	sumout => \Add1~45_sumout\,
	cout => \Add1~46\,
	shareout => \Add1~47\);

\Result~208\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~208_combout\ = (!\Add1~1_sumout\ & (((\Add1~45_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~45_sumout\,
	combout => \Result~208_combout\);

\mv.iav.av[0].sum[-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~208_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-11]~q\);

\Add1~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~33_sumout\ = SUM(( !\mv.iav.av[0].sum[-10]~q\ $ (!\x1[7]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-10]~q\)) ) + ( \Add1~47\ ) + ( \Add1~46\ ))
-- \Add1~34\ = CARRY(( !\mv.iav.av[0].sum[-10]~q\ $ (!\x1[7]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-10]~q\)) ) + ( \Add1~47\ ) + ( \Add1~46\ ))
-- \Add1~35\ = SHARE((!\mv.iav.av[0].sum[-10]~q\ & (\x1[7]~input_o\ & !\mv.iav.av[0].in_sr[15][-10]~q\)) # (\mv.iav.av[0].sum[-10]~q\ & ((!\mv.iav.av[0].in_sr[15][-10]~q\) # (\x1[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-10]~q\,
	datac => \ALT_INV_x1[7]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-10]~q\,
	cin => \Add1~46\,
	sharein => \Add1~47\,
	sumout => \Add1~33_sumout\,
	cout => \Add1~34\,
	shareout => \Add1~35\);

\Result~205\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~205_combout\ = (!\Add1~1_sumout\ & (((\Add1~33_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~33_sumout\,
	combout => \Result~205_combout\);

\mv.iav.av[0].sum[-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~205_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-10]~q\);

\Add1~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~41_sumout\ = SUM(( !\mv.iav.av[0].sum[-9]~q\ $ (!\x1[8]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-9]~q\)) ) + ( \Add1~35\ ) + ( \Add1~34\ ))
-- \Add1~42\ = CARRY(( !\mv.iav.av[0].sum[-9]~q\ $ (!\x1[8]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-9]~q\)) ) + ( \Add1~35\ ) + ( \Add1~34\ ))
-- \Add1~43\ = SHARE((!\mv.iav.av[0].sum[-9]~q\ & (\x1[8]~input_o\ & !\mv.iav.av[0].in_sr[15][-9]~q\)) # (\mv.iav.av[0].sum[-9]~q\ & ((!\mv.iav.av[0].in_sr[15][-9]~q\) # (\x1[8]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-9]~q\,
	datac => \ALT_INV_x1[8]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-9]~q\,
	cin => \Add1~34\,
	sharein => \Add1~35\,
	sumout => \Add1~41_sumout\,
	cout => \Add1~42\,
	shareout => \Add1~43\);

\Result~207\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~207_combout\ = (!\Add1~1_sumout\ & (((\Add1~41_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~41_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~41_sumout\,
	combout => \Result~207_combout\);

\mv.iav.av[0].sum[-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~207_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-9]~q\);

\Add1~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~49_sumout\ = SUM(( !\mv.iav.av[0].sum[-8]~q\ $ (!\x1[9]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-8]~q\)) ) + ( \Add1~43\ ) + ( \Add1~42\ ))
-- \Add1~50\ = CARRY(( !\mv.iav.av[0].sum[-8]~q\ $ (!\x1[9]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-8]~q\)) ) + ( \Add1~43\ ) + ( \Add1~42\ ))
-- \Add1~51\ = SHARE((!\mv.iav.av[0].sum[-8]~q\ & (\x1[9]~input_o\ & !\mv.iav.av[0].in_sr[15][-8]~q\)) # (\mv.iav.av[0].sum[-8]~q\ & ((!\mv.iav.av[0].in_sr[15][-8]~q\) # (\x1[9]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-8]~q\,
	datac => \ALT_INV_x1[9]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-8]~q\,
	cin => \Add1~42\,
	sharein => \Add1~43\,
	sumout => \Add1~49_sumout\,
	cout => \Add1~50\,
	shareout => \Add1~51\);

\Result~209\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~209_combout\ = (!\Add1~1_sumout\ & (((\Add1~49_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~49_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~49_sumout\,
	combout => \Result~209_combout\);

\mv.iav.av[0].sum[-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~209_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-8]~q\);

\Add1~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~53_sumout\ = SUM(( !\mv.iav.av[0].sum[-7]~q\ $ (!\x1[10]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-7]~q\)) ) + ( \Add1~51\ ) + ( \Add1~50\ ))
-- \Add1~54\ = CARRY(( !\mv.iav.av[0].sum[-7]~q\ $ (!\x1[10]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-7]~q\)) ) + ( \Add1~51\ ) + ( \Add1~50\ ))
-- \Add1~55\ = SHARE((!\mv.iav.av[0].sum[-7]~q\ & (\x1[10]~input_o\ & !\mv.iav.av[0].in_sr[15][-7]~q\)) # (\mv.iav.av[0].sum[-7]~q\ & ((!\mv.iav.av[0].in_sr[15][-7]~q\) # (\x1[10]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-7]~q\,
	datac => \ALT_INV_x1[10]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-7]~q\,
	cin => \Add1~50\,
	sharein => \Add1~51\,
	sumout => \Add1~53_sumout\,
	cout => \Add1~54\,
	shareout => \Add1~55\);

\Result~210\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~210_combout\ = (!\Add1~1_sumout\ & (((\Add1~53_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~53_sumout\,
	combout => \Result~210_combout\);

\mv.iav.av[0].sum[-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~210_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-7]~q\);

\Add1~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~57_sumout\ = SUM(( !\mv.iav.av[0].sum[-6]~q\ $ (!\x1[11]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-6]~q\)) ) + ( \Add1~55\ ) + ( \Add1~54\ ))
-- \Add1~58\ = CARRY(( !\mv.iav.av[0].sum[-6]~q\ $ (!\x1[11]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-6]~q\)) ) + ( \Add1~55\ ) + ( \Add1~54\ ))
-- \Add1~59\ = SHARE((!\mv.iav.av[0].sum[-6]~q\ & (\x1[11]~input_o\ & !\mv.iav.av[0].in_sr[15][-6]~q\)) # (\mv.iav.av[0].sum[-6]~q\ & ((!\mv.iav.av[0].in_sr[15][-6]~q\) # (\x1[11]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-6]~q\,
	datac => \ALT_INV_x1[11]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-6]~q\,
	cin => \Add1~54\,
	sharein => \Add1~55\,
	sumout => \Add1~57_sumout\,
	cout => \Add1~58\,
	shareout => \Add1~59\);

\Result~211\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~211_combout\ = (!\Add1~1_sumout\ & (((\Add1~57_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~57_sumout\,
	combout => \Result~211_combout\);

\mv.iav.av[0].sum[-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~211_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-6]~q\);

\Add1~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~61_sumout\ = SUM(( !\mv.iav.av[0].sum[-5]~q\ $ (!\x1[12]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-5]~q\)) ) + ( \Add1~59\ ) + ( \Add1~58\ ))
-- \Add1~62\ = CARRY(( !\mv.iav.av[0].sum[-5]~q\ $ (!\x1[12]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-5]~q\)) ) + ( \Add1~59\ ) + ( \Add1~58\ ))
-- \Add1~63\ = SHARE((!\mv.iav.av[0].sum[-5]~q\ & (\x1[12]~input_o\ & !\mv.iav.av[0].in_sr[15][-5]~q\)) # (\mv.iav.av[0].sum[-5]~q\ & ((!\mv.iav.av[0].in_sr[15][-5]~q\) # (\x1[12]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-5]~q\,
	datac => \ALT_INV_x1[12]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-5]~q\,
	cin => \Add1~58\,
	sharein => \Add1~59\,
	sumout => \Add1~61_sumout\,
	cout => \Add1~62\,
	shareout => \Add1~63\);

\Result~212\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~212_combout\ = (!\Add1~1_sumout\ & (((\Add1~61_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~61_sumout\,
	combout => \Result~212_combout\);

\mv.iav.av[0].sum[-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~212_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-5]~q\);

\Add1~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~65_sumout\ = SUM(( !\mv.iav.av[0].sum[-4]~q\ $ (!\x1[13]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-4]~q\)) ) + ( \Add1~63\ ) + ( \Add1~62\ ))
-- \Add1~66\ = CARRY(( !\mv.iav.av[0].sum[-4]~q\ $ (!\x1[13]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-4]~q\)) ) + ( \Add1~63\ ) + ( \Add1~62\ ))
-- \Add1~67\ = SHARE((!\mv.iav.av[0].sum[-4]~q\ & (\x1[13]~input_o\ & !\mv.iav.av[0].in_sr[15][-4]~q\)) # (\mv.iav.av[0].sum[-4]~q\ & ((!\mv.iav.av[0].in_sr[15][-4]~q\) # (\x1[13]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-4]~q\,
	datac => \ALT_INV_x1[13]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-4]~q\,
	cin => \Add1~62\,
	sharein => \Add1~63\,
	sumout => \Add1~65_sumout\,
	cout => \Add1~66\,
	shareout => \Add1~67\);

\Result~213\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~213_combout\ = (!\Add1~1_sumout\ & (((\Add1~65_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~65_sumout\,
	combout => \Result~213_combout\);

\mv.iav.av[0].sum[-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~213_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-4]~q\);

\Add1~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~69_sumout\ = SUM(( !\mv.iav.av[0].sum[-3]~q\ $ (!\x1[14]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-3]~q\)) ) + ( \Add1~67\ ) + ( \Add1~66\ ))
-- \Add1~70\ = CARRY(( !\mv.iav.av[0].sum[-3]~q\ $ (!\x1[14]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-3]~q\)) ) + ( \Add1~67\ ) + ( \Add1~66\ ))
-- \Add1~71\ = SHARE((!\mv.iav.av[0].sum[-3]~q\ & (\x1[14]~input_o\ & !\mv.iav.av[0].in_sr[15][-3]~q\)) # (\mv.iav.av[0].sum[-3]~q\ & ((!\mv.iav.av[0].in_sr[15][-3]~q\) # (\x1[14]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-3]~q\,
	datac => \ALT_INV_x1[14]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-3]~q\,
	cin => \Add1~66\,
	sharein => \Add1~67\,
	sumout => \Add1~69_sumout\,
	cout => \Add1~70\,
	shareout => \Add1~71\);

\Result~214\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~214_combout\ = (!\Add1~1_sumout\ & (((\Add1~69_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~69_sumout\,
	combout => \Result~214_combout\);

\mv.iav.av[0].sum[-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~214_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-3]~q\);

\Add1~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~73_sumout\ = SUM(( !\mv.iav.av[0].sum[-2]~q\ $ (!\x1[15]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-2]~q\)) ) + ( \Add1~71\ ) + ( \Add1~70\ ))
-- \Add1~74\ = CARRY(( !\mv.iav.av[0].sum[-2]~q\ $ (!\x1[15]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-2]~q\)) ) + ( \Add1~71\ ) + ( \Add1~70\ ))
-- \Add1~75\ = SHARE((!\mv.iav.av[0].sum[-2]~q\ & (\x1[15]~input_o\ & !\mv.iav.av[0].in_sr[15][-2]~q\)) # (\mv.iav.av[0].sum[-2]~q\ & ((!\mv.iav.av[0].in_sr[15][-2]~q\) # (\x1[15]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-2]~q\,
	datac => \ALT_INV_x1[15]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-2]~q\,
	cin => \Add1~70\,
	sharein => \Add1~71\,
	sumout => \Add1~73_sumout\,
	cout => \Add1~74\,
	shareout => \Add1~75\);

\Result~215\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~215_combout\ = (!\Add1~1_sumout\ & (((\Add1~73_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~73_sumout\,
	combout => \Result~215_combout\);

\mv.iav.av[0].sum[-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~215_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-2]~q\);

\Add1~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~77_sumout\ = SUM(( !\mv.iav.av[0].sum[-1]~q\ $ (!\x1[16]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-1]~q\)) ) + ( \Add1~75\ ) + ( \Add1~74\ ))
-- \Add1~78\ = CARRY(( !\mv.iav.av[0].sum[-1]~q\ $ (!\x1[16]~input_o\ $ (!\mv.iav.av[0].in_sr[15][-1]~q\)) ) + ( \Add1~75\ ) + ( \Add1~74\ ))
-- \Add1~79\ = SHARE((!\mv.iav.av[0].sum[-1]~q\ & (\x1[16]~input_o\ & !\mv.iav.av[0].in_sr[15][-1]~q\)) # (\mv.iav.av[0].sum[-1]~q\ & ((!\mv.iav.av[0].in_sr[15][-1]~q\) # (\x1[16]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum[-1]~q\,
	datac => \ALT_INV_x1[16]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][-1]~q\,
	cin => \Add1~74\,
	sharein => \Add1~75\,
	sumout => \Add1~77_sumout\,
	cout => \Add1~78\,
	shareout => \Add1~79\);

\Result~216\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~216_combout\ = (!\Add1~1_sumout\ & (((\Add1~77_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~77_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~77_sumout\,
	combout => \Result~216_combout\);

\mv.iav.av[0].sum[-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~216_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum[-1]~q\);

\Add1~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~81_sumout\ = SUM(( !\mv.iav.av[0].sum\(0) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~79\ ) + ( \Add1~78\ ))
-- \Add1~82\ = CARRY(( !\mv.iav.av[0].sum\(0) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~79\ ) + ( \Add1~78\ ))
-- \Add1~83\ = SHARE((!\mv.iav.av[0].sum\(0) & (\x1[17]~input_o\ & !\mv.iav.av[0].in_sr[15][0]~q\)) # (\mv.iav.av[0].sum\(0) & ((!\mv.iav.av[0].in_sr[15][0]~q\) # (\x1[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum\(0),
	datac => \ALT_INV_x1[17]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][0]~q\,
	cin => \Add1~78\,
	sharein => \Add1~79\,
	sumout => \Add1~81_sumout\,
	cout => \Add1~82\,
	shareout => \Add1~83\);

\Result~217\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~217_combout\ = (!\Add1~1_sumout\ & (((\Add1~81_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~81_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~81_sumout\,
	combout => \Result~217_combout\);

\mv.iav.av[0].sum[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~217_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum\(0));

\Add1~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~85_sumout\ = SUM(( !\mv.iav.av[0].sum\(1) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~83\ ) + ( \Add1~82\ ))
-- \Add1~86\ = CARRY(( !\mv.iav.av[0].sum\(1) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~83\ ) + ( \Add1~82\ ))
-- \Add1~87\ = SHARE((!\mv.iav.av[0].sum\(1) & (\x1[17]~input_o\ & !\mv.iav.av[0].in_sr[15][0]~q\)) # (\mv.iav.av[0].sum\(1) & ((!\mv.iav.av[0].in_sr[15][0]~q\) # (\x1[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum\(1),
	datac => \ALT_INV_x1[17]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][0]~q\,
	cin => \Add1~82\,
	sharein => \Add1~83\,
	sumout => \Add1~85_sumout\,
	cout => \Add1~86\,
	shareout => \Add1~87\);

\Result~218\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~218_combout\ = (!\Add1~1_sumout\ & (((\Add1~85_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~85_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~85_sumout\,
	combout => \Result~218_combout\);

\mv.iav.av[0].sum[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~218_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum\(1));

\Add1~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~89_sumout\ = SUM(( !\mv.iav.av[0].sum\(2) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~87\ ) + ( \Add1~86\ ))
-- \Add1~90\ = CARRY(( !\mv.iav.av[0].sum\(2) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~87\ ) + ( \Add1~86\ ))
-- \Add1~91\ = SHARE((!\mv.iav.av[0].sum\(2) & (\x1[17]~input_o\ & !\mv.iav.av[0].in_sr[15][0]~q\)) # (\mv.iav.av[0].sum\(2) & ((!\mv.iav.av[0].in_sr[15][0]~q\) # (\x1[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum\(2),
	datac => \ALT_INV_x1[17]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][0]~q\,
	cin => \Add1~86\,
	sharein => \Add1~87\,
	sumout => \Add1~89_sumout\,
	cout => \Add1~90\,
	shareout => \Add1~91\);

\Result~219\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~219_combout\ = (!\Add1~1_sumout\ & (((\Add1~89_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~89_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~89_sumout\,
	combout => \Result~219_combout\);

\mv.iav.av[0].sum[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~219_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum\(2));

\Add1~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~93_sumout\ = SUM(( !\mv.iav.av[0].sum\(3) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~91\ ) + ( \Add1~90\ ))
-- \Add1~94\ = CARRY(( !\mv.iav.av[0].sum\(3) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~91\ ) + ( \Add1~90\ ))
-- \Add1~95\ = SHARE((!\mv.iav.av[0].sum\(3) & (\x1[17]~input_o\ & !\mv.iav.av[0].in_sr[15][0]~q\)) # (\mv.iav.av[0].sum\(3) & ((!\mv.iav.av[0].in_sr[15][0]~q\) # (\x1[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum\(3),
	datac => \ALT_INV_x1[17]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][0]~q\,
	cin => \Add1~90\,
	sharein => \Add1~91\,
	sumout => \Add1~93_sumout\,
	cout => \Add1~94\,
	shareout => \Add1~95\);

\Result~220\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~220_combout\ = (!\Add1~1_sumout\ & (((\Add1~93_sumout\) # (\Add1~9_sumout\)) # (\Add1~5_sumout\))) # (\Add1~1_sumout\ & (\Add1~5_sumout\ & (\Add1~9_sumout\ & \Add1~93_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add1~1_sumout\,
	datab => \ALT_INV_Add1~5_sumout\,
	datac => \ALT_INV_Add1~9_sumout\,
	datad => \ALT_INV_Add1~93_sumout\,
	combout => \Result~220_combout\);

\mv.iav.av[0].sum[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~220_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum\(3));

\Add1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~1_sumout\ = SUM(( !\mv.iav.av[0].sum\(4) $ (!\x1[17]~input_o\ $ (!\mv.iav.av[0].in_sr[15][0]~q\)) ) + ( \Add1~11\ ) + ( \Add1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.iav.av[0].sum\(4),
	datac => \ALT_INV_x1[17]~input_o\,
	datad => \ALT_INV_mv.iav.av[0].in_sr[15][0]~q\,
	cin => \Add1~10\,
	sharein => \Add1~11\,
	sumout => \Add1~1_sumout\);

\mv.iav.av[0].sum[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Add1~1_sumout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[0].sum\(4));

\Add2~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~41_sumout\ = SUM(( \mv.iav.av[0].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))
-- \Add2~42\ = CARRY(( \mv.iav.av[0].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-13]~q\,
	cin => GND,
	sumout => \Add2~41_sumout\,
	cout => \Add2~42\);

\Add2~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~45_sumout\ = SUM(( \mv.iav.av[0].sum[-12]~q\ ) + ( GND ) + ( \Add2~42\ ))
-- \Add2~46\ = CARRY(( \mv.iav.av[0].sum[-12]~q\ ) + ( GND ) + ( \Add2~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-12]~q\,
	cin => \Add2~42\,
	sumout => \Add2~45_sumout\,
	cout => \Add2~46\);

\Add2~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~37_sumout\ = SUM(( \mv.iav.av[0].sum[-11]~q\ ) + ( GND ) + ( \Add2~46\ ))
-- \Add2~38\ = CARRY(( \mv.iav.av[0].sum[-11]~q\ ) + ( GND ) + ( \Add2~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-11]~q\,
	cin => \Add2~46\,
	sumout => \Add2~37_sumout\,
	cout => \Add2~38\);

\Add2~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~33_sumout\ = SUM(( \mv.iav.av[0].sum[-10]~q\ ) + ( GND ) + ( \Add2~38\ ))
-- \Add2~34\ = CARRY(( \mv.iav.av[0].sum[-10]~q\ ) + ( GND ) + ( \Add2~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-10]~q\,
	cin => \Add2~38\,
	sumout => \Add2~33_sumout\,
	cout => \Add2~34\);

\Add2~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~29_sumout\ = SUM(( \mv.iav.av[0].sum[-9]~q\ ) + ( GND ) + ( \Add2~34\ ))
-- \Add2~30\ = CARRY(( \mv.iav.av[0].sum[-9]~q\ ) + ( GND ) + ( \Add2~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-9]~q\,
	cin => \Add2~34\,
	sumout => \Add2~29_sumout\,
	cout => \Add2~30\);

\Add2~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~25_sumout\ = SUM(( \mv.iav.av[0].sum[-8]~q\ ) + ( GND ) + ( \Add2~30\ ))
-- \Add2~26\ = CARRY(( \mv.iav.av[0].sum[-8]~q\ ) + ( GND ) + ( \Add2~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-8]~q\,
	cin => \Add2~30\,
	sumout => \Add2~25_sumout\,
	cout => \Add2~26\);

\Add2~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~69_sumout\ = SUM(( \mv.iav.av[0].sum[-7]~q\ ) + ( GND ) + ( \Add2~26\ ))
-- \Add2~70\ = CARRY(( \mv.iav.av[0].sum[-7]~q\ ) + ( GND ) + ( \Add2~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-7]~q\,
	cin => \Add2~26\,
	sumout => \Add2~69_sumout\,
	cout => \Add2~70\);

\Add2~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~73_sumout\ = SUM(( \mv.iav.av[0].sum[-6]~q\ ) + ( GND ) + ( \Add2~70\ ))
-- \Add2~74\ = CARRY(( \mv.iav.av[0].sum[-6]~q\ ) + ( GND ) + ( \Add2~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-6]~q\,
	cin => \Add2~70\,
	sumout => \Add2~73_sumout\,
	cout => \Add2~74\);

\Add2~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~65_sumout\ = SUM(( \mv.iav.av[0].sum[-5]~q\ ) + ( GND ) + ( \Add2~74\ ))
-- \Add2~66\ = CARRY(( \mv.iav.av[0].sum[-5]~q\ ) + ( GND ) + ( \Add2~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-5]~q\,
	cin => \Add2~74\,
	sumout => \Add2~65_sumout\,
	cout => \Add2~66\);

\Add2~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~61_sumout\ = SUM(( \mv.iav.av[0].sum[-4]~q\ ) + ( GND ) + ( \Add2~66\ ))
-- \Add2~62\ = CARRY(( \mv.iav.av[0].sum[-4]~q\ ) + ( GND ) + ( \Add2~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-4]~q\,
	cin => \Add2~66\,
	sumout => \Add2~61_sumout\,
	cout => \Add2~62\);

\Add2~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~57_sumout\ = SUM(( \mv.iav.av[0].sum[-3]~q\ ) + ( GND ) + ( \Add2~62\ ))
-- \Add2~58\ = CARRY(( \mv.iav.av[0].sum[-3]~q\ ) + ( GND ) + ( \Add2~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-3]~q\,
	cin => \Add2~62\,
	sumout => \Add2~57_sumout\,
	cout => \Add2~58\);

\Add2~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~21_sumout\ = SUM(( \mv.iav.av[0].sum[-2]~q\ ) + ( GND ) + ( \Add2~58\ ))
-- \Add2~22\ = CARRY(( \mv.iav.av[0].sum[-2]~q\ ) + ( GND ) + ( \Add2~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-2]~q\,
	cin => \Add2~58\,
	sumout => \Add2~21_sumout\,
	cout => \Add2~22\);

\Add2~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~17_sumout\ = SUM(( \mv.iav.av[0].sum[-1]~q\ ) + ( GND ) + ( \Add2~22\ ))
-- \Add2~18\ = CARRY(( \mv.iav.av[0].sum[-1]~q\ ) + ( GND ) + ( \Add2~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum[-1]~q\,
	cin => \Add2~22\,
	sumout => \Add2~17_sumout\,
	cout => \Add2~18\);

\Add2~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~13_sumout\ = SUM(( \mv.iav.av[0].sum\(0) ) + ( GND ) + ( \Add2~18\ ))
-- \Add2~14\ = CARRY(( \mv.iav.av[0].sum\(0) ) + ( GND ) + ( \Add2~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum\(0),
	cin => \Add2~18\,
	sumout => \Add2~13_sumout\,
	cout => \Add2~14\);

\Add2~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~9_sumout\ = SUM(( \mv.iav.av[0].sum\(1) ) + ( GND ) + ( \Add2~14\ ))
-- \Add2~10\ = CARRY(( \mv.iav.av[0].sum\(1) ) + ( GND ) + ( \Add2~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum\(1),
	cin => \Add2~14\,
	sumout => \Add2~9_sumout\,
	cout => \Add2~10\);

\Add2~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~53_sumout\ = SUM(( \mv.iav.av[0].sum\(2) ) + ( GND ) + ( \Add2~10\ ))
-- \Add2~54\ = CARRY(( \mv.iav.av[0].sum\(2) ) + ( GND ) + ( \Add2~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum\(2),
	cin => \Add2~10\,
	sumout => \Add2~53_sumout\,
	cout => \Add2~54\);

\Add2~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~5_sumout\ = SUM(( \mv.iav.av[0].sum\(3) ) + ( GND ) + ( \Add2~54\ ))
-- \Add2~6\ = CARRY(( \mv.iav.av[0].sum\(3) ) + ( GND ) + ( \Add2~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum\(3),
	cin => \Add2~54\,
	sumout => \Add2~5_sumout\,
	cout => \Add2~6\);

\Add2~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~1_sumout\ = SUM(( \mv.iav.av[0].sum\(4) ) + ( GND ) + ( \Add2~6\ ))
-- \Add2~2\ = CARRY(( \mv.iav.av[0].sum\(4) ) + ( GND ) + ( \Add2~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum\(4),
	cin => \Add2~6\,
	sumout => \Add2~1_sumout\,
	cout => \Add2~2\);

\rounds~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \rounds~2_combout\ = ( \mv.iav.av[0].sum[-15]~q\ & ( \mv.iav.av[0].sum[-14]~q\ ) ) # ( !\mv.iav.av[0].sum[-15]~q\ & ( (\mv.iav.av[0].sum[-14]~q\ & (((\mv.iav.av[0].sum[-16]~q\) # (\mv.iav.av[0].sum[-17]~q\)) # (\mv.iav.av[0].sum[-13]~q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001001100110011001100110011001100010011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-13]~q\,
	datab => \ALT_INV_mv.iav.av[0].sum[-14]~q\,
	datac => \ALT_INV_mv.iav.av[0].sum[-17]~q\,
	datad => \ALT_INV_mv.iav.av[0].sum[-16]~q\,
	datae => \ALT_INV_mv.iav.av[0].sum[-15]~q\,
	combout => \rounds~2_combout\);

\Result~120\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~120_combout\ = ( !\Add2~41_sumout\ & ( !\Add2~45_sumout\ & ( (!\Add2~25_sumout\ & (!\Add2~29_sumout\ & (!\Add2~33_sumout\ & !\Add2~37_sumout\))) ) ) )

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
	combout => \Result~120_combout\);

\Result~121\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~121_combout\ = ( !\Add2~21_sumout\ & ( \Result~120_combout\ & ( (!\Add2~5_sumout\ & (!\Add2~9_sumout\ & (!\Add2~13_sumout\ & !\Add2~17_sumout\))) ) ) )

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
	dataf => \ALT_INV_Result~120_combout\,
	combout => \Result~121_combout\);

\Add2~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~49_sumout\ = SUM(( \mv.iav.av[0].sum\(4) ) + ( GND ) + ( \Add2~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[0].sum\(4),
	cin => \Add2~2\,
	sumout => \Add2~49_sumout\);

\Result~122\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~122_combout\ = ( !\Add2~69_sumout\ & ( !\Add2~73_sumout\ & ( (!\Add2~53_sumout\ & (!\Add2~57_sumout\ & (!\Add2~61_sumout\ & !\Add2~65_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~53_sumout\,
	datab => \ALT_INV_Add2~57_sumout\,
	datac => \ALT_INV_Add2~61_sumout\,
	datad => \ALT_INV_Add2~65_sumout\,
	datae => \ALT_INV_Add2~69_sumout\,
	dataf => \ALT_INV_Add2~73_sumout\,
	combout => \Result~122_combout\);

\Result~123\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~123_combout\ = ( \Add2~49_sumout\ & ( \Result~122_combout\ & ( \mv.iav.av[0].sum\(4) ) ) ) # ( !\Add2~49_sumout\ & ( \Result~122_combout\ & ( (\mv.iav.av[0].sum\(4) & (((!\rounds~2_combout\) # (!\Result~121_combout\)) # (\Add2~1_sumout\))) ) ) ) # 
-- ( \Add2~49_sumout\ & ( !\Result~122_combout\ & ( \mv.iav.av[0].sum\(4) ) ) ) # ( !\Add2~49_sumout\ & ( !\Result~122_combout\ & ( \mv.iav.av[0].sum\(4) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010101010101010100010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_rounds~2_combout\,
	datad => \ALT_INV_Result~121_combout\,
	datae => \ALT_INV_Add2~49_sumout\,
	dataf => \ALT_INV_Result~122_combout\,
	combout => \Result~123_combout\);

\mv.iav.av[1].sum[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Add4~1_sumout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum\(4));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~sumout\ = SUM(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\ = CARRY(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit0~q\,
	cin => GND,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~sumout\,
	clrn => \rst_n~input_o\,
	ena => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit0~q\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\ = SUM(( !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\ ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\ = CARRY(( !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\ ) + ( VCC ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit1~q\,
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita0~COUT\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0_combout\ = !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita1~sumout\,
	combout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit1~q\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\ = SUM(( !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\ ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\ = CARRY(( !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\ ) + ( VCC ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit2~q\,
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita1~COUT\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0_combout\ = !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita2~sumout\,
	combout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit2~q\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\ = SUM(( !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\ ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\ = CARRY(( !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\ ) + ( VCC ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_reg_bit3~q\,
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita2~COUT\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0_combout\ = !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~sumout\,
	combout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~0_combout\,
	clrn => \rst_n~input_o\,
	ena => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_reg_bit3~q\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\ = SUM(( GND ) + ( GND ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~COUT\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe6~0_combout\ = !\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|counter_comb_bita3~1_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr5|ALT_INV_counter_comb_bita3~1_sumout\,
	combout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe6~0_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe6~0_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe6~q\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\ = SUM(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ = CARRY(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\ = SUM(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ = CARRY(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( GND ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita0~COUT\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\ = SUM(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ = CARRY(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita1~COUT\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\ = SUM(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita2~COUT\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_comb_bita3~sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~1_sumout\ = SUM(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~2\ = CARRY(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~2\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(0));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\ = SUM(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( VCC ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~2\ ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~6\ = CARRY(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(1) ) + ( VCC ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(1),
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~2\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~6\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\ = !\mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~5_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_op_1~5_sumout\,
	combout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(1));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\ = !\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(1)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe3a\(1),
	combout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[1]~_wirecell_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~9_sumout\ = SUM(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~6\ ))
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~10\ = CARRY(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(2) ) + ( GND ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(2),
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~6\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	cout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~10\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~9_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(2));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~13_sumout\ = SUM(( \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|counter_reg_bit\(3) ) + ( GND ) + ( \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|cntr1|ALT_INV_counter_reg_bit\(3),
	cin => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~10\,
	sumout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~13_sumout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[1].in_sr_rtl_0|auto_generated|op_1~13_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].in_sr_rtl_0|auto_generated|dffe3a\(3));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 0,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0_PORTBDATAOUT_bus\);

\Add4~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~5_sumout\ = SUM(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~95\ ) + ( \Add4~94\ ))
-- \Add4~6\ = CARRY(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~95\ ) + ( \Add4~94\ ))
-- \Add4~7\ = SHARE((!\Result~123_combout\ & (\mv.iav.av[1].sum\(4) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) # (\Result~123_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # (\mv.iav.av[1].sum\(4)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~123_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	cin => \Add4~94\,
	sharein => \Add4~95\,
	sumout => \Add4~5_sumout\,
	cout => \Add4~6\,
	shareout => \Add4~7\);

\Add4~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~9_sumout\ = SUM(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~7\ ) + ( \Add4~6\ ))
-- \Add4~10\ = CARRY(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~7\ ) + ( \Add4~6\ ))
-- \Add4~11\ = SHARE((!\Result~123_combout\ & (\mv.iav.av[1].sum\(4) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) # (\Result~123_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # (\mv.iav.av[1].sum\(4)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~123_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	cin => \Add4~6\,
	sharein => \Add4~7\,
	sumout => \Add4~9_sumout\,
	cout => \Add4~10\,
	shareout => \Add4~11\);

\Result~124\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~124_combout\ = (!\Add2~69_sumout\ & !\Add2~73_sumout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000100010001000100010001000100010001000100010001000100010001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~69_sumout\,
	datab => \ALT_INV_Add2~73_sumout\,
	combout => \Result~124_combout\);

\Result~125\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~125_combout\ = ( !\Add2~65_sumout\ & ( \Result~124_combout\ & ( (!\Add2~1_sumout\ & (!\Add2~53_sumout\ & (!\Add2~57_sumout\ & !\Add2~61_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add2~1_sumout\,
	datab => \ALT_INV_Add2~53_sumout\,
	datac => \ALT_INV_Add2~57_sumout\,
	datad => \ALT_INV_Add2~61_sumout\,
	datae => \ALT_INV_Add2~65_sumout\,
	dataf => \ALT_INV_Result~124_combout\,
	combout => \Result~125_combout\);

\round_overflow~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \round_overflow~0_combout\ = (\rounds~2_combout\ & (!\mv.iav.av[0].sum\(4) $ (!\Add2~1_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011000000110000001100000011000000110000001100000011000000110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Add2~1_sumout\,
	datac => \ALT_INV_rounds~2_combout\,
	combout => \round_overflow~0_combout\);

\Result~158\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~158_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum\(3))) # (\rounds~2_combout\ & ((\Add2~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(3),
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~5_sumout\,
	combout => \Result~158_combout\);

\Result~159\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~159_combout\ = ( \round_overflow~0_combout\ & ( \Result~158_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~158_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~158_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~158_combout\,
	combout => \Result~159_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 1,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1_PORTBDATAOUT_bus\);

\Result~156\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~156_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum\(2))) # (\rounds~2_combout\ & ((\Add2~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(2),
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~53_sumout\,
	combout => \Result~156_combout\);

\Result~157\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~157_combout\ = ( \round_overflow~0_combout\ & ( \Result~156_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~156_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~156_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~156_combout\,
	combout => \Result~157_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 2,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2_PORTBDATAOUT_bus\);

\Result~154\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~154_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum\(1))) # (\rounds~2_combout\ & ((\Add2~9_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(1),
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~9_sumout\,
	combout => \Result~154_combout\);

\Result~155\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~155_combout\ = ( \round_overflow~0_combout\ & ( \Result~154_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~154_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~154_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~154_combout\,
	combout => \Result~155_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 3,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3_PORTBDATAOUT_bus\);

\Result~152\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~152_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum\(0))) # (\rounds~2_combout\ & ((\Add2~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(0),
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~13_sumout\,
	combout => \Result~152_combout\);

\Result~153\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~153_combout\ = ( \round_overflow~0_combout\ & ( \Result~152_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~152_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~152_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~152_combout\,
	combout => \Result~153_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 4,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4_PORTBDATAOUT_bus\);

\Result~150\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~150_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-1]~q\)) # (\rounds~2_combout\ & ((\Add2~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-1]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~17_sumout\,
	combout => \Result~150_combout\);

\Result~151\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~151_combout\ = ( \round_overflow~0_combout\ & ( \Result~150_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~150_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~150_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~150_combout\,
	combout => \Result~151_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 5,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5_PORTBDATAOUT_bus\);

\Result~148\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~148_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-2]~q\)) # (\rounds~2_combout\ & ((\Add2~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-2]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~21_sumout\,
	combout => \Result~148_combout\);

\Result~149\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~149_combout\ = ( \round_overflow~0_combout\ & ( \Result~148_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~148_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~148_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~148_combout\,
	combout => \Result~149_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 6,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6_PORTBDATAOUT_bus\);

\Result~146\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~146_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-3]~q\)) # (\rounds~2_combout\ & ((\Add2~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-3]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~57_sumout\,
	combout => \Result~146_combout\);

\Result~147\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~147_combout\ = ( \round_overflow~0_combout\ & ( \Result~146_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~146_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~146_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~146_combout\,
	combout => \Result~147_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 7,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7_PORTBDATAOUT_bus\);

\Result~144\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~144_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-4]~q\)) # (\rounds~2_combout\ & ((\Add2~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-4]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~61_sumout\,
	combout => \Result~144_combout\);

\Result~145\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~145_combout\ = ( \round_overflow~0_combout\ & ( \Result~144_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~144_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~144_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~144_combout\,
	combout => \Result~145_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 8,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8_PORTBDATAOUT_bus\);

\Result~142\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~142_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-5]~q\)) # (\rounds~2_combout\ & ((\Add2~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-5]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~65_sumout\,
	combout => \Result~142_combout\);

\Result~143\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~143_combout\ = ( \round_overflow~0_combout\ & ( \Result~142_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~142_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~142_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~142_combout\,
	combout => \Result~143_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 9,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9_PORTBDATAOUT_bus\);

\Result~140\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~140_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-6]~q\)) # (\rounds~2_combout\ & ((\Add2~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-6]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~73_sumout\,
	combout => \Result~140_combout\);

\Result~141\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~141_combout\ = ( \round_overflow~0_combout\ & ( \Result~140_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~140_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~140_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~140_combout\,
	combout => \Result~141_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 10,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10_PORTBDATAOUT_bus\);

\Result~138\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~138_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-7]~q\)) # (\rounds~2_combout\ & ((\Add2~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-7]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~69_sumout\,
	combout => \Result~138_combout\);

\Result~139\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~139_combout\ = ( \round_overflow~0_combout\ & ( \Result~138_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~138_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~138_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~138_combout\,
	combout => \Result~139_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 11,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11_PORTBDATAOUT_bus\);

\Result~136\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~136_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-8]~q\)) # (\rounds~2_combout\ & ((\Add2~25_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-8]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~25_sumout\,
	combout => \Result~136_combout\);

\Result~137\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~137_combout\ = ( \round_overflow~0_combout\ & ( \Result~136_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~136_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~136_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~136_combout\,
	combout => \Result~137_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 12,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12_PORTBDATAOUT_bus\);

\Result~132\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~132_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-9]~q\)) # (\rounds~2_combout\ & ((\Add2~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-9]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~29_sumout\,
	combout => \Result~132_combout\);

\Result~133\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~133_combout\ = ( \round_overflow~0_combout\ & ( \Result~132_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~132_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~132_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~132_combout\,
	combout => \Result~133_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 13,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13_PORTBDATAOUT_bus\);

\Result~126\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~126_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-10]~q\)) # (\rounds~2_combout\ & ((\Add2~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-10]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~33_sumout\,
	combout => \Result~126_combout\);

\Result~127\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~127_combout\ = ( \round_overflow~0_combout\ & ( \Result~126_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~126_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~126_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~126_combout\,
	combout => \Result~127_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 14,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14_PORTBDATAOUT_bus\);

\Result~134\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~134_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-11]~q\)) # (\rounds~2_combout\ & ((\Add2~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-11]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~37_sumout\,
	combout => \Result~134_combout\);

\Result~135\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~135_combout\ = ( \round_overflow~0_combout\ & ( \Result~134_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~134_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~134_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~134_combout\,
	combout => \Result~135_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 15,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15_PORTBDATAOUT_bus\);

\Result~130\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~130_combout\ = (!\rounds~2_combout\ & (\mv.iav.av[0].sum[-12]~q\)) # (\rounds~2_combout\ & ((\Add2~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-12]~q\,
	datab => \ALT_INV_rounds~2_combout\,
	datac => \ALT_INV_Add2~45_sumout\,
	combout => \Result~130_combout\);

\Result~131\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~131_combout\ = ( \round_overflow~0_combout\ & ( \Result~130_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~130_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~130_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~130_combout\,
	combout => \Result~131_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 16,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16_PORTBDATAOUT_bus\);

\Result~128\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~128_combout\ = (!\mv.iav.av[0].sum[-13]~q\ & (((\rounds~2_combout\ & \Add2~41_sumout\)))) # (\mv.iav.av[0].sum[-13]~q\ & ((!\mv.iav.av[0].sum[-14]~q\) # ((\rounds~2_combout\ & \Add2~41_sumout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010001001111010001000100111101000100010011110100010001001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum[-13]~q\,
	datab => \ALT_INV_mv.iav.av[0].sum[-14]~q\,
	datac => \ALT_INV_rounds~2_combout\,
	datad => \ALT_INV_Add2~41_sumout\,
	combout => \Result~128_combout\);

\Result~129\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~129_combout\ = ( \round_overflow~0_combout\ & ( \Result~128_combout\ & ( (!\mv.iav.av[0].sum\(4)) # ((\Result~121_combout\ & (!\Add2~49_sumout\ & \Result~125_combout\))) ) ) ) # ( !\round_overflow~0_combout\ & ( \Result~128_combout\ ) ) # ( 
-- \round_overflow~0_combout\ & ( !\Result~128_combout\ & ( (!\mv.iav.av[0].sum\(4) & ((!\Result~121_combout\) # ((!\Result~125_combout\) # (\Add2~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[0].sum\(4),
	datab => \ALT_INV_Result~121_combout\,
	datac => \ALT_INV_Add2~49_sumout\,
	datad => \ALT_INV_Result~125_combout\,
	datae => \ALT_INV_round_overflow~0_combout\,
	dataf => \ALT_INV_Result~128_combout\,
	combout => \Result~129_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
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
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 17,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17_PORTBDATAOUT_bus\);

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

\Add4~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~17_sumout\ = SUM(( !\Result~129_combout\ $ (!\mv.iav.av[1].sum[-17]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17~portbdataout\)) ) + ( \Add4~99\ ) + ( \Add4~98_cout\ ))
-- \Add4~18\ = CARRY(( !\Result~129_combout\ $ (!\mv.iav.av[1].sum[-17]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17~portbdataout\)) ) + ( \Add4~99\ ) + ( \Add4~98_cout\ ))
-- \Add4~19\ = SHARE((!\Result~129_combout\ & (\mv.iav.av[1].sum[-17]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17~portbdataout\)) # (\Result~129_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a17~portbdataout\) # (\mv.iav.av[1].sum[-17]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~129_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-17]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a17~portbdataout\,
	cin => \Add4~98_cout\,
	sharein => \Add4~99\,
	sumout => \Add4~17_sumout\,
	cout => \Add4~18\,
	shareout => \Add4~19\);

\Result~79\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~79_combout\ = (!\Add4~1_sumout\ & (((\Add4~17_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~17_sumout\,
	combout => \Result~79_combout\);

\mv.iav.av[1].sum[-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~79_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-17]~q\);

\Add4~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~21_sumout\ = SUM(( !\Result~131_combout\ $ (!\mv.iav.av[1].sum[-16]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16~portbdataout\)) ) + ( \Add4~19\ ) + ( \Add4~18\ ))
-- \Add4~22\ = CARRY(( !\Result~131_combout\ $ (!\mv.iav.av[1].sum[-16]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16~portbdataout\)) ) + ( \Add4~19\ ) + ( \Add4~18\ ))
-- \Add4~23\ = SHARE((!\Result~131_combout\ & (\mv.iav.av[1].sum[-16]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16~portbdataout\)) # (\Result~131_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a16~portbdataout\) # (\mv.iav.av[1].sum[-16]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~131_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-16]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a16~portbdataout\,
	cin => \Add4~18\,
	sharein => \Add4~19\,
	sumout => \Add4~21_sumout\,
	cout => \Add4~22\,
	shareout => \Add4~23\);

\Result~80\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~80_combout\ = (!\Add4~1_sumout\ & (((\Add4~21_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~21_sumout\,
	combout => \Result~80_combout\);

\mv.iav.av[1].sum[-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~80_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-16]~q\);

\Add4~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~29_sumout\ = SUM(( !\Result~135_combout\ $ (!\mv.iav.av[1].sum[-15]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15~portbdataout\)) ) + ( \Add4~23\ ) + ( \Add4~22\ ))
-- \Add4~30\ = CARRY(( !\Result~135_combout\ $ (!\mv.iav.av[1].sum[-15]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15~portbdataout\)) ) + ( \Add4~23\ ) + ( \Add4~22\ ))
-- \Add4~31\ = SHARE((!\Result~135_combout\ & (\mv.iav.av[1].sum[-15]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15~portbdataout\)) # (\Result~135_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a15~portbdataout\) # (\mv.iav.av[1].sum[-15]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~135_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-15]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a15~portbdataout\,
	cin => \Add4~22\,
	sharein => \Add4~23\,
	sumout => \Add4~29_sumout\,
	cout => \Add4~30\,
	shareout => \Add4~31\);

\Result~82\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~82_combout\ = (!\Add4~1_sumout\ & (((\Add4~29_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~29_sumout\,
	combout => \Result~82_combout\);

\mv.iav.av[1].sum[-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~82_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-15]~q\);

\Add4~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~13_sumout\ = SUM(( !\Result~127_combout\ $ (!\mv.iav.av[1].sum[-14]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14~portbdataout\)) ) + ( \Add4~31\ ) + ( \Add4~30\ ))
-- \Add4~14\ = CARRY(( !\Result~127_combout\ $ (!\mv.iav.av[1].sum[-14]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14~portbdataout\)) ) + ( \Add4~31\ ) + ( \Add4~30\ ))
-- \Add4~15\ = SHARE((!\Result~127_combout\ & (\mv.iav.av[1].sum[-14]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14~portbdataout\)) # (\Result~127_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a14~portbdataout\) # (\mv.iav.av[1].sum[-14]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~127_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-14]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a14~portbdataout\,
	cin => \Add4~30\,
	sharein => \Add4~31\,
	sumout => \Add4~13_sumout\,
	cout => \Add4~14\,
	shareout => \Add4~15\);

\Add4~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~25_sumout\ = SUM(( !\Result~133_combout\ $ (!\mv.iav.av[1].sum[-13]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13~portbdataout\)) ) + ( \Add4~15\ ) + ( \Add4~14\ ))
-- \Add4~26\ = CARRY(( !\Result~133_combout\ $ (!\mv.iav.av[1].sum[-13]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13~portbdataout\)) ) + ( \Add4~15\ ) + ( \Add4~14\ ))
-- \Add4~27\ = SHARE((!\Result~133_combout\ & (\mv.iav.av[1].sum[-13]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13~portbdataout\)) # (\Result~133_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a13~portbdataout\) # (\mv.iav.av[1].sum[-13]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~133_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-13]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a13~portbdataout\,
	cin => \Add4~14\,
	sharein => \Add4~15\,
	sumout => \Add4~25_sumout\,
	cout => \Add4~26\,
	shareout => \Add4~27\);

\Result~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~81_combout\ = (!\Add4~1_sumout\ & (((\Add4~25_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~25_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~25_sumout\,
	combout => \Result~81_combout\);

\mv.iav.av[1].sum[-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~81_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-13]~q\);

\Add4~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~33_sumout\ = SUM(( !\Result~137_combout\ $ (!\mv.iav.av[1].sum[-12]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12~portbdataout\)) ) + ( \Add4~27\ ) + ( \Add4~26\ ))
-- \Add4~34\ = CARRY(( !\Result~137_combout\ $ (!\mv.iav.av[1].sum[-12]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12~portbdataout\)) ) + ( \Add4~27\ ) + ( \Add4~26\ ))
-- \Add4~35\ = SHARE((!\Result~137_combout\ & (\mv.iav.av[1].sum[-12]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12~portbdataout\)) # (\Result~137_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a12~portbdataout\) # (\mv.iav.av[1].sum[-12]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~137_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-12]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a12~portbdataout\,
	cin => \Add4~26\,
	sharein => \Add4~27\,
	sumout => \Add4~33_sumout\,
	cout => \Add4~34\,
	shareout => \Add4~35\);

\Result~83\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~83_combout\ = (!\Add4~1_sumout\ & (((\Add4~33_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~33_sumout\,
	combout => \Result~83_combout\);

\mv.iav.av[1].sum[-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~83_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-12]~q\);

\Add4~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~37_sumout\ = SUM(( !\Result~139_combout\ $ (!\mv.iav.av[1].sum[-11]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11~portbdataout\)) ) + ( \Add4~35\ ) + ( \Add4~34\ ))
-- \Add4~38\ = CARRY(( !\Result~139_combout\ $ (!\mv.iav.av[1].sum[-11]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11~portbdataout\)) ) + ( \Add4~35\ ) + ( \Add4~34\ ))
-- \Add4~39\ = SHARE((!\Result~139_combout\ & (\mv.iav.av[1].sum[-11]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11~portbdataout\)) # (\Result~139_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a11~portbdataout\) # (\mv.iav.av[1].sum[-11]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~139_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-11]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a11~portbdataout\,
	cin => \Add4~34\,
	sharein => \Add4~35\,
	sumout => \Add4~37_sumout\,
	cout => \Add4~38\,
	shareout => \Add4~39\);

\Result~84\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~84_combout\ = (!\Add4~1_sumout\ & (((\Add4~37_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~37_sumout\,
	combout => \Result~84_combout\);

\mv.iav.av[1].sum[-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~84_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-11]~q\);

\Add4~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~41_sumout\ = SUM(( !\Result~141_combout\ $ (!\mv.iav.av[1].sum[-10]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10~portbdataout\)) ) + ( \Add4~39\ ) + ( \Add4~38\ ))
-- \Add4~42\ = CARRY(( !\Result~141_combout\ $ (!\mv.iav.av[1].sum[-10]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10~portbdataout\)) ) + ( \Add4~39\ ) + ( \Add4~38\ ))
-- \Add4~43\ = SHARE((!\Result~141_combout\ & (\mv.iav.av[1].sum[-10]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10~portbdataout\)) # (\Result~141_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a10~portbdataout\) # (\mv.iav.av[1].sum[-10]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~141_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-10]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a10~portbdataout\,
	cin => \Add4~38\,
	sharein => \Add4~39\,
	sumout => \Add4~41_sumout\,
	cout => \Add4~42\,
	shareout => \Add4~43\);

\Result~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~85_combout\ = (!\Add4~1_sumout\ & (((\Add4~41_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~41_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~41_sumout\,
	combout => \Result~85_combout\);

\mv.iav.av[1].sum[-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~85_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-10]~q\);

\Add4~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~45_sumout\ = SUM(( !\Result~143_combout\ $ (!\mv.iav.av[1].sum[-9]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9~portbdataout\)) ) + ( \Add4~43\ ) + ( \Add4~42\ ))
-- \Add4~46\ = CARRY(( !\Result~143_combout\ $ (!\mv.iav.av[1].sum[-9]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9~portbdataout\)) ) + ( \Add4~43\ ) + ( \Add4~42\ ))
-- \Add4~47\ = SHARE((!\Result~143_combout\ & (\mv.iav.av[1].sum[-9]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9~portbdataout\)) # (\Result~143_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a9~portbdataout\) # (\mv.iav.av[1].sum[-9]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~143_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-9]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a9~portbdataout\,
	cin => \Add4~42\,
	sharein => \Add4~43\,
	sumout => \Add4~45_sumout\,
	cout => \Add4~46\,
	shareout => \Add4~47\);

\Result~86\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~86_combout\ = (!\Add4~1_sumout\ & (((\Add4~45_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~45_sumout\,
	combout => \Result~86_combout\);

\mv.iav.av[1].sum[-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~86_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-9]~q\);

\Add4~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~49_sumout\ = SUM(( !\Result~145_combout\ $ (!\mv.iav.av[1].sum[-8]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8~portbdataout\)) ) + ( \Add4~47\ ) + ( \Add4~46\ ))
-- \Add4~50\ = CARRY(( !\Result~145_combout\ $ (!\mv.iav.av[1].sum[-8]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8~portbdataout\)) ) + ( \Add4~47\ ) + ( \Add4~46\ ))
-- \Add4~51\ = SHARE((!\Result~145_combout\ & (\mv.iav.av[1].sum[-8]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8~portbdataout\)) # (\Result~145_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a8~portbdataout\) # (\mv.iav.av[1].sum[-8]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~145_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-8]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a8~portbdataout\,
	cin => \Add4~46\,
	sharein => \Add4~47\,
	sumout => \Add4~49_sumout\,
	cout => \Add4~50\,
	shareout => \Add4~51\);

\Result~87\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~87_combout\ = (!\Add4~1_sumout\ & (((\Add4~49_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~49_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~49_sumout\,
	combout => \Result~87_combout\);

\mv.iav.av[1].sum[-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~87_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-8]~q\);

\Add4~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~53_sumout\ = SUM(( !\Result~147_combout\ $ (!\mv.iav.av[1].sum[-7]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7~portbdataout\)) ) + ( \Add4~51\ ) + ( \Add4~50\ ))
-- \Add4~54\ = CARRY(( !\Result~147_combout\ $ (!\mv.iav.av[1].sum[-7]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7~portbdataout\)) ) + ( \Add4~51\ ) + ( \Add4~50\ ))
-- \Add4~55\ = SHARE((!\Result~147_combout\ & (\mv.iav.av[1].sum[-7]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7~portbdataout\)) # (\Result~147_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a7~portbdataout\) # (\mv.iav.av[1].sum[-7]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~147_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-7]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a7~portbdataout\,
	cin => \Add4~50\,
	sharein => \Add4~51\,
	sumout => \Add4~53_sumout\,
	cout => \Add4~54\,
	shareout => \Add4~55\);

\Result~88\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~88_combout\ = (!\Add4~1_sumout\ & (((\Add4~53_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~53_sumout\,
	combout => \Result~88_combout\);

\mv.iav.av[1].sum[-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~88_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-7]~q\);

\Add4~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~57_sumout\ = SUM(( !\Result~149_combout\ $ (!\mv.iav.av[1].sum[-6]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6~portbdataout\)) ) + ( \Add4~55\ ) + ( \Add4~54\ ))
-- \Add4~58\ = CARRY(( !\Result~149_combout\ $ (!\mv.iav.av[1].sum[-6]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6~portbdataout\)) ) + ( \Add4~55\ ) + ( \Add4~54\ ))
-- \Add4~59\ = SHARE((!\Result~149_combout\ & (\mv.iav.av[1].sum[-6]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6~portbdataout\)) # (\Result~149_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a6~portbdataout\) # (\mv.iav.av[1].sum[-6]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~149_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-6]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a6~portbdataout\,
	cin => \Add4~54\,
	sharein => \Add4~55\,
	sumout => \Add4~57_sumout\,
	cout => \Add4~58\,
	shareout => \Add4~59\);

\Result~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~89_combout\ = (!\Add4~1_sumout\ & (((\Add4~57_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~57_sumout\,
	combout => \Result~89_combout\);

\mv.iav.av[1].sum[-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~89_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-6]~q\);

\Add4~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~61_sumout\ = SUM(( !\Result~151_combout\ $ (!\mv.iav.av[1].sum[-5]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5~portbdataout\)) ) + ( \Add4~59\ ) + ( \Add4~58\ ))
-- \Add4~62\ = CARRY(( !\Result~151_combout\ $ (!\mv.iav.av[1].sum[-5]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5~portbdataout\)) ) + ( \Add4~59\ ) + ( \Add4~58\ ))
-- \Add4~63\ = SHARE((!\Result~151_combout\ & (\mv.iav.av[1].sum[-5]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5~portbdataout\)) # (\Result~151_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a5~portbdataout\) # (\mv.iav.av[1].sum[-5]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~151_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-5]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a5~portbdataout\,
	cin => \Add4~58\,
	sharein => \Add4~59\,
	sumout => \Add4~61_sumout\,
	cout => \Add4~62\,
	shareout => \Add4~63\);

\Result~90\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~90_combout\ = (!\Add4~1_sumout\ & (((\Add4~61_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~61_sumout\,
	combout => \Result~90_combout\);

\mv.iav.av[1].sum[-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~90_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-5]~q\);

\Add4~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~65_sumout\ = SUM(( !\Result~153_combout\ $ (!\mv.iav.av[1].sum[-4]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4~portbdataout\)) ) + ( \Add4~63\ ) + ( \Add4~62\ ))
-- \Add4~66\ = CARRY(( !\Result~153_combout\ $ (!\mv.iav.av[1].sum[-4]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4~portbdataout\)) ) + ( \Add4~63\ ) + ( \Add4~62\ ))
-- \Add4~67\ = SHARE((!\Result~153_combout\ & (\mv.iav.av[1].sum[-4]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4~portbdataout\)) # (\Result~153_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a4~portbdataout\) # (\mv.iav.av[1].sum[-4]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~153_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-4]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a4~portbdataout\,
	cin => \Add4~62\,
	sharein => \Add4~63\,
	sumout => \Add4~65_sumout\,
	cout => \Add4~66\,
	shareout => \Add4~67\);

\Result~91\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~91_combout\ = (!\Add4~1_sumout\ & (((\Add4~65_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~65_sumout\,
	combout => \Result~91_combout\);

\mv.iav.av[1].sum[-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~91_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-4]~q\);

\Add4~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~69_sumout\ = SUM(( !\Result~155_combout\ $ (!\mv.iav.av[1].sum[-3]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3~portbdataout\)) ) + ( \Add4~67\ ) + ( \Add4~66\ ))
-- \Add4~70\ = CARRY(( !\Result~155_combout\ $ (!\mv.iav.av[1].sum[-3]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3~portbdataout\)) ) + ( \Add4~67\ ) + ( \Add4~66\ ))
-- \Add4~71\ = SHARE((!\Result~155_combout\ & (\mv.iav.av[1].sum[-3]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3~portbdataout\)) # (\Result~155_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a3~portbdataout\) # (\mv.iav.av[1].sum[-3]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~155_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-3]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a3~portbdataout\,
	cin => \Add4~66\,
	sharein => \Add4~67\,
	sumout => \Add4~69_sumout\,
	cout => \Add4~70\,
	shareout => \Add4~71\);

\Result~92\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~92_combout\ = (!\Add4~1_sumout\ & (((\Add4~69_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~69_sumout\,
	combout => \Result~92_combout\);

\mv.iav.av[1].sum[-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~92_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-3]~q\);

\Add4~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~73_sumout\ = SUM(( !\Result~157_combout\ $ (!\mv.iav.av[1].sum[-2]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2~portbdataout\)) ) + ( \Add4~71\ ) + ( \Add4~70\ ))
-- \Add4~74\ = CARRY(( !\Result~157_combout\ $ (!\mv.iav.av[1].sum[-2]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2~portbdataout\)) ) + ( \Add4~71\ ) + ( \Add4~70\ ))
-- \Add4~75\ = SHARE((!\Result~157_combout\ & (\mv.iav.av[1].sum[-2]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2~portbdataout\)) # (\Result~157_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a2~portbdataout\) # (\mv.iav.av[1].sum[-2]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~157_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-2]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a2~portbdataout\,
	cin => \Add4~70\,
	sharein => \Add4~71\,
	sumout => \Add4~73_sumout\,
	cout => \Add4~74\,
	shareout => \Add4~75\);

\Result~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~93_combout\ = (!\Add4~1_sumout\ & (((\Add4~73_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~73_sumout\,
	combout => \Result~93_combout\);

\mv.iav.av[1].sum[-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~93_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-2]~q\);

\Add4~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~77_sumout\ = SUM(( !\Result~159_combout\ $ (!\mv.iav.av[1].sum[-1]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1~portbdataout\)) ) + ( \Add4~75\ ) + ( \Add4~74\ ))
-- \Add4~78\ = CARRY(( !\Result~159_combout\ $ (!\mv.iav.av[1].sum[-1]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1~portbdataout\)) ) + ( \Add4~75\ ) + ( \Add4~74\ ))
-- \Add4~79\ = SHARE((!\Result~159_combout\ & (\mv.iav.av[1].sum[-1]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1~portbdataout\)) # (\Result~159_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a1~portbdataout\) # (\mv.iav.av[1].sum[-1]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~159_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum[-1]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a1~portbdataout\,
	cin => \Add4~74\,
	sharein => \Add4~75\,
	sumout => \Add4~77_sumout\,
	cout => \Add4~78\,
	shareout => \Add4~79\);

\Result~94\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~94_combout\ = (!\Add4~1_sumout\ & (((\Add4~77_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~77_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~77_sumout\,
	combout => \Result~94_combout\);

\mv.iav.av[1].sum[-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~94_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-1]~q\);

\Add4~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~81_sumout\ = SUM(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(0) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~79\ ) + ( \Add4~78\ ))
-- \Add4~82\ = CARRY(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(0) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~79\ ) + ( \Add4~78\ ))
-- \Add4~83\ = SHARE((!\Result~123_combout\ & (\mv.iav.av[1].sum\(0) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) # (\Result~123_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # (\mv.iav.av[1].sum\(0)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~123_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(0),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	cin => \Add4~78\,
	sharein => \Add4~79\,
	sumout => \Add4~81_sumout\,
	cout => \Add4~82\,
	shareout => \Add4~83\);

\Result~95\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~95_combout\ = (!\Add4~1_sumout\ & (((\Add4~81_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~81_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~81_sumout\,
	combout => \Result~95_combout\);

\mv.iav.av[1].sum[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~95_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum\(0));

\Add4~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~85_sumout\ = SUM(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(1) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~83\ ) + ( \Add4~82\ ))
-- \Add4~86\ = CARRY(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(1) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~83\ ) + ( \Add4~82\ ))
-- \Add4~87\ = SHARE((!\Result~123_combout\ & (\mv.iav.av[1].sum\(1) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) # (\Result~123_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # (\mv.iav.av[1].sum\(1)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~123_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(1),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	cin => \Add4~82\,
	sharein => \Add4~83\,
	sumout => \Add4~85_sumout\,
	cout => \Add4~86\,
	shareout => \Add4~87\);

\Result~96\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~96_combout\ = (!\Add4~1_sumout\ & (((\Add4~85_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~85_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~85_sumout\,
	combout => \Result~96_combout\);

\mv.iav.av[1].sum[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~96_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum\(1));

\Add4~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~89_sumout\ = SUM(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(2) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~87\ ) + ( \Add4~86\ ))
-- \Add4~90\ = CARRY(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(2) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~87\ ) + ( \Add4~86\ ))
-- \Add4~91\ = SHARE((!\Result~123_combout\ & (\mv.iav.av[1].sum\(2) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) # (\Result~123_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # (\mv.iav.av[1].sum\(2)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~123_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(2),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	cin => \Add4~86\,
	sharein => \Add4~87\,
	sumout => \Add4~89_sumout\,
	cout => \Add4~90\,
	shareout => \Add4~91\);

\Result~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~97_combout\ = (!\Add4~1_sumout\ & (((\Add4~89_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~89_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~89_sumout\,
	combout => \Result~97_combout\);

\mv.iav.av[1].sum[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~97_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum\(2));

\Add4~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~93_sumout\ = SUM(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(3) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~91\ ) + ( \Add4~90\ ))
-- \Add4~94\ = CARRY(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(3) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~91\ ) + ( \Add4~90\ ))
-- \Add4~95\ = SHARE((!\Result~123_combout\ & (\mv.iav.av[1].sum\(3) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) # (\Result~123_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\) # (\mv.iav.av[1].sum\(3)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~123_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(3),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	cin => \Add4~90\,
	sharein => \Add4~91\,
	sumout => \Add4~93_sumout\,
	cout => \Add4~94\,
	shareout => \Add4~95\);

\Result~98\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~98_combout\ = (!\Add4~1_sumout\ & (((\Add4~93_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~93_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~93_sumout\,
	combout => \Result~98_combout\);

\mv.iav.av[1].sum[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~98_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum\(3));

\Add4~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add4~1_sumout\ = SUM(( !\Result~123_combout\ $ (!\mv.iav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a0~portbdataout\)) ) + ( \Add4~11\ ) + ( \Add4~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~123_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a0~portbdataout\,
	cin => \Add4~10\,
	sharein => \Add4~11\,
	sumout => \Add4~1_sumout\);

\Result~78\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~78_combout\ = (!\Add4~1_sumout\ & (((\Add4~13_sumout\) # (\Add4~9_sumout\)) # (\Add4~5_sumout\))) # (\Add4~1_sumout\ & (\Add4~5_sumout\ & (\Add4~9_sumout\ & \Add4~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add4~1_sumout\,
	datab => \ALT_INV_Add4~5_sumout\,
	datac => \ALT_INV_Add4~9_sumout\,
	datad => \ALT_INV_Add4~13_sumout\,
	combout => \Result~78_combout\);

\mv.iav.av[1].sum[-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~78_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.iav.av[1].sum[-14]~q\);

\rounds~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rounds~0_combout\ = ( \mv.iav.av[1].sum[-15]~q\ & ( \mv.iav.av[1].sum[-14]~q\ ) ) # ( !\mv.iav.av[1].sum[-15]~q\ & ( (\mv.iav.av[1].sum[-14]~q\ & (((\mv.iav.av[1].sum[-13]~q\) # (\mv.iav.av[1].sum[-16]~q\)) # (\mv.iav.av[1].sum[-17]~q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001010101010101010101010101010100010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[1].sum[-14]~q\,
	datab => \ALT_INV_mv.iav.av[1].sum[-17]~q\,
	datac => \ALT_INV_mv.iav.av[1].sum[-16]~q\,
	datad => \ALT_INV_mv.iav.av[1].sum[-13]~q\,
	datae => \ALT_INV_mv.iav.av[1].sum[-15]~q\,
	combout => \rounds~0_combout\);

\Add5~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~41_sumout\ = SUM(( \mv.iav.av[1].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))
-- \Add5~42\ = CARRY(( \mv.iav.av[1].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-13]~q\,
	cin => GND,
	sumout => \Add5~41_sumout\,
	cout => \Add5~42\);

\Add5~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~45_sumout\ = SUM(( \mv.iav.av[1].sum[-12]~q\ ) + ( GND ) + ( \Add5~42\ ))
-- \Add5~46\ = CARRY(( \mv.iav.av[1].sum[-12]~q\ ) + ( GND ) + ( \Add5~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-12]~q\,
	cin => \Add5~42\,
	sumout => \Add5~45_sumout\,
	cout => \Add5~46\);

\Add5~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~37_sumout\ = SUM(( \mv.iav.av[1].sum[-11]~q\ ) + ( GND ) + ( \Add5~46\ ))
-- \Add5~38\ = CARRY(( \mv.iav.av[1].sum[-11]~q\ ) + ( GND ) + ( \Add5~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-11]~q\,
	cin => \Add5~46\,
	sumout => \Add5~37_sumout\,
	cout => \Add5~38\);

\Add5~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~33_sumout\ = SUM(( \mv.iav.av[1].sum[-10]~q\ ) + ( GND ) + ( \Add5~38\ ))
-- \Add5~34\ = CARRY(( \mv.iav.av[1].sum[-10]~q\ ) + ( GND ) + ( \Add5~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-10]~q\,
	cin => \Add5~38\,
	sumout => \Add5~33_sumout\,
	cout => \Add5~34\);

\Add5~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~29_sumout\ = SUM(( \mv.iav.av[1].sum[-9]~q\ ) + ( GND ) + ( \Add5~34\ ))
-- \Add5~30\ = CARRY(( \mv.iav.av[1].sum[-9]~q\ ) + ( GND ) + ( \Add5~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-9]~q\,
	cin => \Add5~34\,
	sumout => \Add5~29_sumout\,
	cout => \Add5~30\);

\Add5~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~25_sumout\ = SUM(( \mv.iav.av[1].sum[-8]~q\ ) + ( GND ) + ( \Add5~30\ ))
-- \Add5~26\ = CARRY(( \mv.iav.av[1].sum[-8]~q\ ) + ( GND ) + ( \Add5~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-8]~q\,
	cin => \Add5~30\,
	sumout => \Add5~25_sumout\,
	cout => \Add5~26\);

\Add5~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~69_sumout\ = SUM(( \mv.iav.av[1].sum[-7]~q\ ) + ( GND ) + ( \Add5~26\ ))
-- \Add5~70\ = CARRY(( \mv.iav.av[1].sum[-7]~q\ ) + ( GND ) + ( \Add5~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-7]~q\,
	cin => \Add5~26\,
	sumout => \Add5~69_sumout\,
	cout => \Add5~70\);

\Add5~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~73_sumout\ = SUM(( \mv.iav.av[1].sum[-6]~q\ ) + ( GND ) + ( \Add5~70\ ))
-- \Add5~74\ = CARRY(( \mv.iav.av[1].sum[-6]~q\ ) + ( GND ) + ( \Add5~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-6]~q\,
	cin => \Add5~70\,
	sumout => \Add5~73_sumout\,
	cout => \Add5~74\);

\Add5~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~65_sumout\ = SUM(( \mv.iav.av[1].sum[-5]~q\ ) + ( GND ) + ( \Add5~74\ ))
-- \Add5~66\ = CARRY(( \mv.iav.av[1].sum[-5]~q\ ) + ( GND ) + ( \Add5~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-5]~q\,
	cin => \Add5~74\,
	sumout => \Add5~65_sumout\,
	cout => \Add5~66\);

\Add5~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~61_sumout\ = SUM(( \mv.iav.av[1].sum[-4]~q\ ) + ( GND ) + ( \Add5~66\ ))
-- \Add5~62\ = CARRY(( \mv.iav.av[1].sum[-4]~q\ ) + ( GND ) + ( \Add5~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-4]~q\,
	cin => \Add5~66\,
	sumout => \Add5~61_sumout\,
	cout => \Add5~62\);

\Add5~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~57_sumout\ = SUM(( \mv.iav.av[1].sum[-3]~q\ ) + ( GND ) + ( \Add5~62\ ))
-- \Add5~58\ = CARRY(( \mv.iav.av[1].sum[-3]~q\ ) + ( GND ) + ( \Add5~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-3]~q\,
	cin => \Add5~62\,
	sumout => \Add5~57_sumout\,
	cout => \Add5~58\);

\Add5~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~21_sumout\ = SUM(( \mv.iav.av[1].sum[-2]~q\ ) + ( GND ) + ( \Add5~58\ ))
-- \Add5~22\ = CARRY(( \mv.iav.av[1].sum[-2]~q\ ) + ( GND ) + ( \Add5~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-2]~q\,
	cin => \Add5~58\,
	sumout => \Add5~21_sumout\,
	cout => \Add5~22\);

\Add5~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~17_sumout\ = SUM(( \mv.iav.av[1].sum[-1]~q\ ) + ( GND ) + ( \Add5~22\ ))
-- \Add5~18\ = CARRY(( \mv.iav.av[1].sum[-1]~q\ ) + ( GND ) + ( \Add5~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum[-1]~q\,
	cin => \Add5~22\,
	sumout => \Add5~17_sumout\,
	cout => \Add5~18\);

\Add5~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~13_sumout\ = SUM(( \mv.iav.av[1].sum\(0) ) + ( GND ) + ( \Add5~18\ ))
-- \Add5~14\ = CARRY(( \mv.iav.av[1].sum\(0) ) + ( GND ) + ( \Add5~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum\(0),
	cin => \Add5~18\,
	sumout => \Add5~13_sumout\,
	cout => \Add5~14\);

\Add5~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~9_sumout\ = SUM(( \mv.iav.av[1].sum\(1) ) + ( GND ) + ( \Add5~14\ ))
-- \Add5~10\ = CARRY(( \mv.iav.av[1].sum\(1) ) + ( GND ) + ( \Add5~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum\(1),
	cin => \Add5~14\,
	sumout => \Add5~9_sumout\,
	cout => \Add5~10\);

\Add5~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~53_sumout\ = SUM(( \mv.iav.av[1].sum\(2) ) + ( GND ) + ( \Add5~10\ ))
-- \Add5~54\ = CARRY(( \mv.iav.av[1].sum\(2) ) + ( GND ) + ( \Add5~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum\(2),
	cin => \Add5~10\,
	sumout => \Add5~53_sumout\,
	cout => \Add5~54\);

\Add5~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~5_sumout\ = SUM(( \mv.iav.av[1].sum\(3) ) + ( GND ) + ( \Add5~54\ ))
-- \Add5~6\ = CARRY(( \mv.iav.av[1].sum\(3) ) + ( GND ) + ( \Add5~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum\(3),
	cin => \Add5~54\,
	sumout => \Add5~5_sumout\,
	cout => \Add5~6\);

\Add5~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~1_sumout\ = SUM(( \mv.iav.av[1].sum\(4) ) + ( GND ) + ( \Add5~6\ ))
-- \Add5~2\ = CARRY(( \mv.iav.av[1].sum\(4) ) + ( GND ) + ( \Add5~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum\(4),
	cin => \Add5~6\,
	sumout => \Add5~1_sumout\,
	cout => \Add5~2\);

\Result~34\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~34_combout\ = ( !\Add5~45_sumout\ & ( (!\Add5~29_sumout\ & (!\Add5~33_sumout\ & (!\Add5~37_sumout\ & !\Add5~41_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000010000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add5~29_sumout\,
	datab => \ALT_INV_Add5~33_sumout\,
	datac => \ALT_INV_Add5~37_sumout\,
	datad => \ALT_INV_Add5~41_sumout\,
	datae => \ALT_INV_Add5~45_sumout\,
	combout => \Result~34_combout\);

\Result~35\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~35_combout\ = ( \Result~34_combout\ & ( (!\Add5~13_sumout\ & (!\Add5~17_sumout\ & (!\Add5~21_sumout\ & !\Add5~25_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000100000000000000000000000000000001000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add5~13_sumout\,
	datab => \ALT_INV_Add5~17_sumout\,
	datac => \ALT_INV_Add5~21_sumout\,
	datad => \ALT_INV_Add5~25_sumout\,
	datae => \ALT_INV_Result~34_combout\,
	combout => \Result~35_combout\);

\Add5~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add5~49_sumout\ = SUM(( \mv.iav.av[1].sum\(4) ) + ( GND ) + ( \Add5~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.iav.av[1].sum\(4),
	cin => \Add5~2\,
	sumout => \Add5~49_sumout\);

\Result~36\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~36_combout\ = (!\Add5~61_sumout\ & (!\Add5~65_sumout\ & (!\Add5~69_sumout\ & !\Add5~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000100000000000000010000000000000001000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add5~61_sumout\,
	datab => \ALT_INV_Add5~65_sumout\,
	datac => \ALT_INV_Add5~69_sumout\,
	datad => \ALT_INV_Add5~73_sumout\,
	combout => \Result~36_combout\);

\Result~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~37_combout\ = (!\Add5~1_sumout\ & (!\Add5~53_sumout\ & (!\Add5~57_sumout\ & \Result~36_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010000000000000001000000000000000100000000000000010000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add5~1_sumout\,
	datab => \ALT_INV_Add5~53_sumout\,
	datac => \ALT_INV_Add5~57_sumout\,
	datad => \ALT_INV_Result~36_combout\,
	combout => \Result~37_combout\);

\Result~38\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~38_combout\ = ( \Result~37_combout\ & ( (((!\Result~35_combout\) # (\Add5~49_sumout\)) # (\Add5~9_sumout\)) # (\Add5~5_sumout\) ) ) # ( !\Result~37_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111101111111111111111111111111111111011111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add5~5_sumout\,
	datab => \ALT_INV_Add5~9_sumout\,
	datac => \ALT_INV_Result~35_combout\,
	datad => \ALT_INV_Add5~49_sumout\,
	datae => \ALT_INV_Result~37_combout\,
	combout => \Result~38_combout\);

\overflowx~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \overflowx~0_combout\ = (\Result~38_combout\ & (!\mv.iav.av[1].sum\(4) $ (!\Add5~1_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011000000110000001100000011000000110000001100000011000000110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[1].sum\(4),
	datab => \ALT_INV_Add5~1_sumout\,
	datac => \ALT_INV_Result~38_combout\,
	combout => \overflowx~0_combout\);

\Result~55\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~55_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum\(3))) # (\rounds~0_combout\ & ((\Add5~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum\(3),
	datac => \ALT_INV_Add5~5_sumout\,
	combout => \Result~55_combout\);

\Result~54\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~54_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum\(2))) # (\rounds~0_combout\ & ((\Add5~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum\(2),
	datac => \ALT_INV_Add5~53_sumout\,
	combout => \Result~54_combout\);

\Result~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~53_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum\(1))) # (\rounds~0_combout\ & ((\Add5~9_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum\(1),
	datac => \ALT_INV_Add5~9_sumout\,
	combout => \Result~53_combout\);

\Result~52\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~52_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum\(0))) # (\rounds~0_combout\ & ((\Add5~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum\(0),
	datac => \ALT_INV_Add5~13_sumout\,
	combout => \Result~52_combout\);

\Result~51\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~51_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-1]~q\)) # (\rounds~0_combout\ & ((\Add5~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-1]~q\,
	datac => \ALT_INV_Add5~17_sumout\,
	combout => \Result~51_combout\);

\Result~50\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~50_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-2]~q\)) # (\rounds~0_combout\ & ((\Add5~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-2]~q\,
	datac => \ALT_INV_Add5~21_sumout\,
	combout => \Result~50_combout\);

\Result~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~49_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-3]~q\)) # (\rounds~0_combout\ & ((\Add5~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-3]~q\,
	datac => \ALT_INV_Add5~57_sumout\,
	combout => \Result~49_combout\);

\Result~48\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~48_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-4]~q\)) # (\rounds~0_combout\ & ((\Add5~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-4]~q\,
	datac => \ALT_INV_Add5~61_sumout\,
	combout => \Result~48_combout\);

\Result~47\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~47_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-5]~q\)) # (\rounds~0_combout\ & ((\Add5~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-5]~q\,
	datac => \ALT_INV_Add5~65_sumout\,
	combout => \Result~47_combout\);

\Result~46\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~46_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-6]~q\)) # (\rounds~0_combout\ & ((\Add5~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-6]~q\,
	datac => \ALT_INV_Add5~73_sumout\,
	combout => \Result~46_combout\);

\Result~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~45_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-7]~q\)) # (\rounds~0_combout\ & ((\Add5~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-7]~q\,
	datac => \ALT_INV_Add5~69_sumout\,
	combout => \Result~45_combout\);

\Result~44\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~44_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-8]~q\)) # (\rounds~0_combout\ & ((\Add5~25_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-8]~q\,
	datac => \ALT_INV_Add5~25_sumout\,
	combout => \Result~44_combout\);

\Result~43\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~43_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-9]~q\)) # (\rounds~0_combout\ & ((\Add5~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-9]~q\,
	datac => \ALT_INV_Add5~29_sumout\,
	combout => \Result~43_combout\);

\Result~42\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~42_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-10]~q\)) # (\rounds~0_combout\ & ((\Add5~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-10]~q\,
	datac => \ALT_INV_Add5~33_sumout\,
	combout => \Result~42_combout\);

\Result~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~41_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-11]~q\)) # (\rounds~0_combout\ & ((\Add5~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-11]~q\,
	datac => \ALT_INV_Add5~37_sumout\,
	combout => \Result~41_combout\);

\Result~40\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~40_combout\ = (!\rounds~0_combout\ & (\mv.iav.av[1].sum[-12]~q\)) # (\rounds~0_combout\ & ((\Add5~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_mv.iav.av[1].sum[-12]~q\,
	datac => \ALT_INV_Add5~45_sumout\,
	combout => \Result~40_combout\);

\Result~39\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~39_combout\ = (!\mv.iav.av[1].sum[-14]~q\ & (((\rounds~0_combout\ & \Add5~41_sumout\)) # (\mv.iav.av[1].sum[-13]~q\))) # (\mv.iav.av[1].sum[-14]~q\ & (((\rounds~0_combout\ & \Add5~41_sumout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001000101111001000100010111100100010001011110010001000101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.iav.av[1].sum[-14]~q\,
	datab => \ALT_INV_mv.iav.av[1].sum[-13]~q\,
	datac => \ALT_INV_rounds~0_combout\,
	datad => \ALT_INV_Add5~41_sumout\,
	combout => \Result~39_combout\);

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

\Add6~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~9_sumout\ = SUM(( (!\rounds~0_combout\ & (!\Result~39_combout\)) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & (!\Result~39_combout\)) # (\overflowx~0_combout\ & ((\mv.iav.av[1].sum\(4)))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\ ) + ( \Add6~78_cout\ ))
-- \Add6~10\ = CARRY(( (!\rounds~0_combout\ & (!\Result~39_combout\)) # (\rounds~0_combout\ & ((!\overflowx~0_combout\ & (!\Result~39_combout\)) # (\overflowx~0_combout\ & ((\mv.iav.av[1].sum\(4)))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a17~portbdataout\ ) + ( \Add6~78_cout\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001100110010001101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_Result~39_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_overflowx~0_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a17~portbdataout\,
	cin => \Add6~78_cout\,
	sumout => \Add6~9_sumout\,
	cout => \Add6~10\);

\Add6~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~13_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~40_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~40_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\ ) + ( \Add6~10\ ))
-- \Add6~14\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~40_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~40_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a16~portbdataout\ ) + ( \Add6~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~40_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a16~portbdataout\,
	cin => \Add6~10\,
	sumout => \Add6~13_sumout\,
	cout => \Add6~14\);

\Add6~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~17_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~41_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~41_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\ ) + ( \Add6~14\ ))
-- \Add6~18\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~41_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~41_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a15~portbdataout\ ) + ( \Add6~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~41_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a15~portbdataout\,
	cin => \Add6~14\,
	sumout => \Add6~17_sumout\,
	cout => \Add6~18\);

\Add6~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~21_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~42_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~42_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\ ) + ( \Add6~18\ ))
-- \Add6~22\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~42_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~42_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a14~portbdataout\ ) + ( \Add6~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~42_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a14~portbdataout\,
	cin => \Add6~18\,
	sumout => \Add6~21_sumout\,
	cout => \Add6~22\);

\Add6~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~25_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~43_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~43_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\ ) + ( \Add6~22\ ))
-- \Add6~26\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~43_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~43_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a13~portbdataout\ ) + ( \Add6~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~43_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a13~portbdataout\,
	cin => \Add6~22\,
	sumout => \Add6~25_sumout\,
	cout => \Add6~26\);

\Add6~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~29_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~44_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~44_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\ ) + ( \Add6~26\ ))
-- \Add6~30\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~44_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~44_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a12~portbdataout\ ) + ( \Add6~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~44_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a12~portbdataout\,
	cin => \Add6~26\,
	sumout => \Add6~29_sumout\,
	cout => \Add6~30\);

\Add6~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~33_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~45_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~45_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\ ) + ( \Add6~30\ ))
-- \Add6~34\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~45_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~45_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a11~portbdataout\ ) + ( \Add6~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~45_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a11~portbdataout\,
	cin => \Add6~30\,
	sumout => \Add6~33_sumout\,
	cout => \Add6~34\);

\Add6~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~37_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~46_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~46_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\ ) + ( \Add6~34\ ))
-- \Add6~38\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~46_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~46_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a10~portbdataout\ ) + ( \Add6~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~46_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a10~portbdataout\,
	cin => \Add6~34\,
	sumout => \Add6~37_sumout\,
	cout => \Add6~38\);

\Add6~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~41_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~47_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~47_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\ ) + ( \Add6~38\ ))
-- \Add6~42\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~47_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~47_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a9~portbdataout\ ) + ( \Add6~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~47_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a9~portbdataout\,
	cin => \Add6~38\,
	sumout => \Add6~41_sumout\,
	cout => \Add6~42\);

\Add6~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~45_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~48_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~48_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\ ) + ( \Add6~42\ ))
-- \Add6~46\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~48_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~48_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a8~portbdataout\ ) + ( \Add6~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~48_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a8~portbdataout\,
	cin => \Add6~42\,
	sumout => \Add6~45_sumout\,
	cout => \Add6~46\);

\Add6~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~49_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~49_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~49_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\ ) + ( \Add6~46\ ))
-- \Add6~50\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~49_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~49_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a7~portbdataout\ ) + ( \Add6~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~49_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a7~portbdataout\,
	cin => \Add6~46\,
	sumout => \Add6~49_sumout\,
	cout => \Add6~50\);

\Add6~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~53_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~50_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~50_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\ ) + ( \Add6~50\ ))
-- \Add6~54\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~50_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~50_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a6~portbdataout\ ) + ( \Add6~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~50_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a6~portbdataout\,
	cin => \Add6~50\,
	sumout => \Add6~53_sumout\,
	cout => \Add6~54\);

\Add6~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~57_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~51_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~51_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\ ) + ( \Add6~54\ ))
-- \Add6~58\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~51_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~51_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a5~portbdataout\ ) + ( \Add6~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~51_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a5~portbdataout\,
	cin => \Add6~54\,
	sumout => \Add6~57_sumout\,
	cout => \Add6~58\);

\Add6~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~61_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~52_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~52_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\ ) + ( \Add6~58\ ))
-- \Add6~62\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~52_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~52_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a4~portbdataout\ ) + ( \Add6~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~52_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a4~portbdataout\,
	cin => \Add6~58\,
	sumout => \Add6~61_sumout\,
	cout => \Add6~62\);

\Add6~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~65_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~53_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~53_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\ ) + ( \Add6~62\ ))
-- \Add6~66\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~53_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~53_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a3~portbdataout\ ) + ( \Add6~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~53_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a3~portbdataout\,
	cin => \Add6~62\,
	sumout => \Add6~65_sumout\,
	cout => \Add6~66\);

\Add6~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~69_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~54_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~54_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\ ) + ( \Add6~66\ ))
-- \Add6~70\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~54_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~54_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a2~portbdataout\ ) + ( \Add6~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~54_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a2~portbdataout\,
	cin => \Add6~66\,
	sumout => \Add6~69_sumout\,
	cout => \Add6~70\);

\Add6~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~73_sumout\ = SUM(( (!\overflowx~0_combout\ & (((!\Result~55_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~55_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\ ) + ( \Add6~70\ ))
-- \Add6~74\ = CARRY(( (!\overflowx~0_combout\ & (((!\Result~55_combout\)))) # (\overflowx~0_combout\ & ((!\rounds~0_combout\ & ((!\Result~55_combout\))) # (\rounds~0_combout\ & (\mv.iav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a1~portbdataout\ ) + ( \Add6~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~0_combout\,
	datab => \ALT_INV_rounds~0_combout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~55_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a1~portbdataout\,
	cin => \Add6~70\,
	sumout => \Add6~73_sumout\,
	cout => \Add6~74\);

\Add6~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~1_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\mv.iav.av[1].sum\(4))))) # (\rounds~0_combout\ & ((!\Result~38_combout\ & (!\Add5~1_sumout\)) # (\Result~38_combout\ & ((!\mv.iav.av[1].sum\(4)))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ ) + ( \Add6~74\ ))
-- \Add6~2\ = CARRY(( (!\rounds~0_combout\ & (((!\mv.iav.av[1].sum\(4))))) # (\rounds~0_combout\ & ((!\Result~38_combout\ & (!\Add5~1_sumout\)) # (\Result~38_combout\ & ((!\mv.iav.av[1].sum\(4)))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ ) + ( \Add6~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110010011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_Add5~1_sumout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~38_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	cin => \Add6~74\,
	sumout => \Add6~1_sumout\,
	cout => \Add6~2\);

\Add6~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add6~5_sumout\ = SUM(( (!\rounds~0_combout\ & (((!\mv.iav.av[1].sum\(4))))) # (\rounds~0_combout\ & ((!\Result~38_combout\ & (!\Add5~1_sumout\)) # (\Result~38_combout\ & ((!\mv.iav.av[1].sum\(4)))))) ) + ( 
-- !\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a0~portbdataout\ ) + ( \Add6~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000001111111100000000000000001110010011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~0_combout\,
	datab => \ALT_INV_Add5~1_sumout\,
	datac => \ALT_INV_mv.iav.av[1].sum\(4),
	datad => \ALT_INV_Result~38_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a0~portbdataout\,
	cin => \Add6~2\,
	sumout => \Add6~5_sumout\);

\Result~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~0_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~9_sumout\)) # (\Add6~1_sumout\ & ((\Add6~9_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~9_sumout\,
	combout => \Result~0_combout\);

\y1[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~0_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[0]~reg0_q\);

\Result~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~1_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~13_sumout\)) # (\Add6~1_sumout\ & ((\Add6~13_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~13_sumout\,
	combout => \Result~1_combout\);

\y1[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~1_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[1]~reg0_q\);

\Result~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~2_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~17_sumout\)) # (\Add6~1_sumout\ & ((\Add6~17_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~17_sumout\,
	combout => \Result~2_combout\);

\y1[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~2_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[2]~reg0_q\);

\Result~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~3_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~21_sumout\)) # (\Add6~1_sumout\ & ((\Add6~21_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~21_sumout\,
	combout => \Result~3_combout\);

\y1[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~3_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[3]~reg0_q\);

\Result~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~4_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~25_sumout\)) # (\Add6~1_sumout\ & ((\Add6~25_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~25_sumout\,
	combout => \Result~4_combout\);

\y1[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~4_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[4]~reg0_q\);

\Result~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~5_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~29_sumout\)) # (\Add6~1_sumout\ & ((\Add6~29_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~29_sumout\,
	combout => \Result~5_combout\);

\y1[5]~reg0\ : dffeas
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
	q => \y1[5]~reg0_q\);

\Result~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~6_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~33_sumout\)) # (\Add6~1_sumout\ & ((\Add6~33_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~33_sumout\,
	combout => \Result~6_combout\);

\y1[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~6_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[6]~reg0_q\);

\Result~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~7_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~37_sumout\)) # (\Add6~1_sumout\ & ((\Add6~37_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~37_sumout\,
	combout => \Result~7_combout\);

\y1[7]~reg0\ : dffeas
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
	q => \y1[7]~reg0_q\);

\Result~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~8_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~41_sumout\)) # (\Add6~1_sumout\ & ((\Add6~41_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~41_sumout\,
	combout => \Result~8_combout\);

\y1[8]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~8_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[8]~reg0_q\);

\Result~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~9_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~45_sumout\)) # (\Add6~1_sumout\ & ((\Add6~45_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~45_sumout\,
	combout => \Result~9_combout\);

\y1[9]~reg0\ : dffeas
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
	q => \y1[9]~reg0_q\);

\Result~10\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~10_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~49_sumout\)) # (\Add6~1_sumout\ & ((\Add6~49_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~49_sumout\,
	combout => \Result~10_combout\);

\y1[10]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~10_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[10]~reg0_q\);

\Result~11\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~11_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~53_sumout\)) # (\Add6~1_sumout\ & ((\Add6~53_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~53_sumout\,
	combout => \Result~11_combout\);

\y1[11]~reg0\ : dffeas
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
	q => \y1[11]~reg0_q\);

\Result~12\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~12_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~57_sumout\)) # (\Add6~1_sumout\ & ((\Add6~57_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~57_sumout\,
	combout => \Result~12_combout\);

\y1[12]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~12_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[12]~reg0_q\);

\Result~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~13_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~61_sumout\)) # (\Add6~1_sumout\ & ((\Add6~61_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~61_sumout\,
	combout => \Result~13_combout\);

\y1[13]~reg0\ : dffeas
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
	q => \y1[13]~reg0_q\);

\Result~14\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~14_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~65_sumout\)) # (\Add6~1_sumout\ & ((\Add6~65_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~65_sumout\,
	combout => \Result~14_combout\);

\y1[14]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~14_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[14]~reg0_q\);

\Result~15\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~15_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~69_sumout\)) # (\Add6~1_sumout\ & ((\Add6~69_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~69_sumout\,
	combout => \Result~15_combout\);

\y1[15]~reg0\ : dffeas
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
	q => \y1[15]~reg0_q\);

\Result~16\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~16_combout\ = (!\Add6~1_sumout\ & (\Add6~5_sumout\ & \Add6~73_sumout\)) # (\Add6~1_sumout\ & ((\Add6~73_sumout\) # (\Add6~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~1_sumout\,
	datab => \ALT_INV_Add6~5_sumout\,
	datac => \ALT_INV_Add6~73_sumout\,
	combout => \Result~16_combout\);

\y1[16]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~16_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[16]~reg0_q\);

\y1[17]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \y1[17]~0_combout\ = !\Add6~5_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add6~5_sumout\,
	combout => \y1[17]~0_combout\);

\y1[17]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \y1[17]~0_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y1[17]~reg0_q\);

\x2[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(17),
	o => \x2[17]~input_o\);

\mv.qav.av[0].in_sr[0][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[17]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][0]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 18,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 18,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][0]~q\);

\Add8~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~5_sumout\ = SUM(( !\mv.qav.av[0].sum\(4) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~95\ ) + ( \Add8~94\ ))
-- \Add8~6\ = CARRY(( !\mv.qav.av[0].sum\(4) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~95\ ) + ( \Add8~94\ ))
-- \Add8~7\ = SHARE((!\mv.qav.av[0].sum\(4) & (\x2[17]~input_o\ & !\mv.qav.av[0].in_sr[15][0]~q\)) # (\mv.qav.av[0].sum\(4) & ((!\mv.qav.av[0].in_sr[15][0]~q\) # (\x2[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum\(4),
	datac => \ALT_INV_x2[17]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][0]~q\,
	cin => \Add8~94\,
	sharein => \Add8~95\,
	sumout => \Add8~5_sumout\,
	cout => \Add8~6\,
	shareout => \Add8~7\);

\Add8~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~9_sumout\ = SUM(( !\mv.qav.av[0].sum\(4) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~7\ ) + ( \Add8~6\ ))
-- \Add8~10\ = CARRY(( !\mv.qav.av[0].sum\(4) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~7\ ) + ( \Add8~6\ ))
-- \Add8~11\ = SHARE((!\mv.qav.av[0].sum\(4) & (\x2[17]~input_o\ & !\mv.qav.av[0].in_sr[15][0]~q\)) # (\mv.qav.av[0].sum\(4) & ((!\mv.qav.av[0].in_sr[15][0]~q\) # (\x2[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum\(4),
	datac => \ALT_INV_x2[17]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][0]~q\,
	cin => \Add8~6\,
	sharein => \Add8~7\,
	sumout => \Add8~9_sumout\,
	cout => \Add8~10\,
	shareout => \Add8~11\);

\x2[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(16),
	o => \x2[16]~input_o\);

\mv.qav.av[0].in_sr[0][-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[16]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-1]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 19,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 19,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-1]~q\);

\x2[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(15),
	o => \x2[15]~input_o\);

\mv.qav.av[0].in_sr[0][-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[15]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-2]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 20,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 20,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-2]~q\);

\x2[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(14),
	o => \x2[14]~input_o\);

\mv.qav.av[0].in_sr[0][-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[14]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-3]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 21,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 21,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-3]~q\);

\x2[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(13),
	o => \x2[13]~input_o\);

\mv.qav.av[0].in_sr[0][-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[13]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-4]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 22,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 22,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-4]~q\);

\x2[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(12),
	o => \x2[12]~input_o\);

\mv.qav.av[0].in_sr[0][-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[12]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-5]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 23,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 23,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-5]~q\);

\x2[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(11),
	o => \x2[11]~input_o\);

\mv.qav.av[0].in_sr[0][-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[11]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-6]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 24,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 24,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-6]~q\);

\x2[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(10),
	o => \x2[10]~input_o\);

\mv.qav.av[0].in_sr[0][-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[10]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-7]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 25,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 25,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-7]~q\);

\x2[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(9),
	o => \x2[9]~input_o\);

\mv.qav.av[0].in_sr[0][-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[9]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-8]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 26,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 26,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-8]~q\);

\x2[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(8),
	o => \x2[8]~input_o\);

\mv.qav.av[0].in_sr[0][-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[8]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-9]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 27,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 27,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-9]~q\);

\x2[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(7),
	o => \x2[7]~input_o\);

\mv.qav.av[0].in_sr[0][-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[7]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-10]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 28,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 28,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-10]~q\);

\x2[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(6),
	o => \x2[6]~input_o\);

\mv.qav.av[0].in_sr[0][-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[6]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-11]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 29,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 29,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-11]~q\);

\x2[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(5),
	o => \x2[5]~input_o\);

\mv.qav.av[0].in_sr[0][-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[5]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-12]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 30,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 30,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-12]~q\);

\x2[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(4),
	o => \x2[4]~input_o\);

\mv.qav.av[0].in_sr[0][-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[4]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-13]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 31,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 31,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-13]~q\);

\x2[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(3),
	o => \x2[3]~input_o\);

\mv.qav.av[0].in_sr[0][-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[3]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-14]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 32,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 32,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-14]~q\);

\x2[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(2),
	o => \x2[2]~input_o\);

\mv.qav.av[0].in_sr[0][-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[2]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-15]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 33,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 33,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-15]~q\);

\x2[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(1),
	o => \x2[1]~input_o\);

\mv.qav.av[0].in_sr[0][-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[1]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-16]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 34,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 34,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-16]~q\);

\x2[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x2(0),
	o => \x2[0]~input_o\);

\mv.qav.av[0].in_sr[0][-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \x2[0]~input_o\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[0][-17]~q\);

\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[0].in_sr_rtl_0|shift_taps_kev:auto_generated|altsyncram_uic1:altsyncram5|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 35,
	port_a_last_address => 13,
	port_a_logical_ram_depth => 14,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 35,
	port_b_last_address => 13,
	port_b_logical_ram_depth => 14,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[0].in_sr_rtl_0|auto_generated|ALT_INV_dffe7~q\,
	portadatain => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35_PORTBDATAOUT_bus\);

\mv.qav.av[0].in_sr[15][-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35~portbdataout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].in_sr[15][-17]~q\);

\Add8~98\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~98_cout\ = CARRY(( GND ) + ( !VCC ) + ( !VCC ))
-- \Add8~99\ = SHARE(VCC)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	cin => GND,
	sharein => GND,
	cout => \Add8~98_cout\,
	shareout => \Add8~99\);

\Add8~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~21_sumout\ = SUM(( !\mv.qav.av[0].sum[-17]~q\ $ (!\x2[0]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-17]~q\)) ) + ( \Add8~99\ ) + ( \Add8~98_cout\ ))
-- \Add8~22\ = CARRY(( !\mv.qav.av[0].sum[-17]~q\ $ (!\x2[0]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-17]~q\)) ) + ( \Add8~99\ ) + ( \Add8~98_cout\ ))
-- \Add8~23\ = SHARE((!\mv.qav.av[0].sum[-17]~q\ & (\x2[0]~input_o\ & !\mv.qav.av[0].in_sr[15][-17]~q\)) # (\mv.qav.av[0].sum[-17]~q\ & ((!\mv.qav.av[0].in_sr[15][-17]~q\) # (\x2[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-17]~q\,
	datac => \ALT_INV_x2[0]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-17]~q\,
	cin => \Add8~98_cout\,
	sharein => \Add8~99\,
	sumout => \Add8~21_sumout\,
	cout => \Add8~22\,
	shareout => \Add8~23\);

\Result~223\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~223_combout\ = (!\Add8~1_sumout\ & (((\Add8~21_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~21_sumout\,
	combout => \Result~223_combout\);

\mv.qav.av[0].sum[-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~223_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-17]~q\);

\Add8~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~25_sumout\ = SUM(( !\mv.qav.av[0].sum[-16]~q\ $ (!\x2[1]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-16]~q\)) ) + ( \Add8~23\ ) + ( \Add8~22\ ))
-- \Add8~26\ = CARRY(( !\mv.qav.av[0].sum[-16]~q\ $ (!\x2[1]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-16]~q\)) ) + ( \Add8~23\ ) + ( \Add8~22\ ))
-- \Add8~27\ = SHARE((!\mv.qav.av[0].sum[-16]~q\ & (\x2[1]~input_o\ & !\mv.qav.av[0].in_sr[15][-16]~q\)) # (\mv.qav.av[0].sum[-16]~q\ & ((!\mv.qav.av[0].in_sr[15][-16]~q\) # (\x2[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-16]~q\,
	datac => \ALT_INV_x2[1]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-16]~q\,
	cin => \Add8~22\,
	sharein => \Add8~23\,
	sumout => \Add8~25_sumout\,
	cout => \Add8~26\,
	shareout => \Add8~27\);

\Result~224\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~224_combout\ = (!\Add8~1_sumout\ & (((\Add8~25_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~25_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~25_sumout\,
	combout => \Result~224_combout\);

\mv.qav.av[0].sum[-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~224_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-16]~q\);

\Add8~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~29_sumout\ = SUM(( !\mv.qav.av[0].sum[-15]~q\ $ (!\x2[2]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-15]~q\)) ) + ( \Add8~27\ ) + ( \Add8~26\ ))
-- \Add8~30\ = CARRY(( !\mv.qav.av[0].sum[-15]~q\ $ (!\x2[2]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-15]~q\)) ) + ( \Add8~27\ ) + ( \Add8~26\ ))
-- \Add8~31\ = SHARE((!\mv.qav.av[0].sum[-15]~q\ & (\x2[2]~input_o\ & !\mv.qav.av[0].in_sr[15][-15]~q\)) # (\mv.qav.av[0].sum[-15]~q\ & ((!\mv.qav.av[0].in_sr[15][-15]~q\) # (\x2[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-15]~q\,
	datac => \ALT_INV_x2[2]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-15]~q\,
	cin => \Add8~26\,
	sharein => \Add8~27\,
	sumout => \Add8~29_sumout\,
	cout => \Add8~30\,
	shareout => \Add8~31\);

\Result~225\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~225_combout\ = (!\Add8~1_sumout\ & (((\Add8~29_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~29_sumout\,
	combout => \Result~225_combout\);

\mv.qav.av[0].sum[-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~225_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-15]~q\);

\Add8~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~17_sumout\ = SUM(( !\mv.qav.av[0].sum[-14]~q\ $ (!\x2[3]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-14]~q\)) ) + ( \Add8~31\ ) + ( \Add8~30\ ))
-- \Add8~18\ = CARRY(( !\mv.qav.av[0].sum[-14]~q\ $ (!\x2[3]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-14]~q\)) ) + ( \Add8~31\ ) + ( \Add8~30\ ))
-- \Add8~19\ = SHARE((!\mv.qav.av[0].sum[-14]~q\ & (\x2[3]~input_o\ & !\mv.qav.av[0].in_sr[15][-14]~q\)) # (\mv.qav.av[0].sum[-14]~q\ & ((!\mv.qav.av[0].in_sr[15][-14]~q\) # (\x2[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-14]~q\,
	datac => \ALT_INV_x2[3]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-14]~q\,
	cin => \Add8~30\,
	sharein => \Add8~31\,
	sumout => \Add8~17_sumout\,
	cout => \Add8~18\,
	shareout => \Add8~19\);

\Result~222\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~222_combout\ = (!\Add8~1_sumout\ & (((\Add8~17_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~17_sumout\,
	combout => \Result~222_combout\);

\mv.qav.av[0].sum[-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~222_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-14]~q\);

\Add8~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~13_sumout\ = SUM(( !\mv.qav.av[0].sum[-13]~q\ $ (!\x2[4]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-13]~q\)) ) + ( \Add8~19\ ) + ( \Add8~18\ ))
-- \Add8~14\ = CARRY(( !\mv.qav.av[0].sum[-13]~q\ $ (!\x2[4]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-13]~q\)) ) + ( \Add8~19\ ) + ( \Add8~18\ ))
-- \Add8~15\ = SHARE((!\mv.qav.av[0].sum[-13]~q\ & (\x2[4]~input_o\ & !\mv.qav.av[0].in_sr[15][-13]~q\)) # (\mv.qav.av[0].sum[-13]~q\ & ((!\mv.qav.av[0].in_sr[15][-13]~q\) # (\x2[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-13]~q\,
	datac => \ALT_INV_x2[4]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-13]~q\,
	cin => \Add8~18\,
	sharein => \Add8~19\,
	sumout => \Add8~13_sumout\,
	cout => \Add8~14\,
	shareout => \Add8~15\);

\Result~221\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~221_combout\ = (!\Add8~1_sumout\ & (((\Add8~13_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~13_sumout\,
	combout => \Result~221_combout\);

\mv.qav.av[0].sum[-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~221_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-13]~q\);

\Add8~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~37_sumout\ = SUM(( !\mv.qav.av[0].sum[-12]~q\ $ (!\x2[5]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-12]~q\)) ) + ( \Add8~15\ ) + ( \Add8~14\ ))
-- \Add8~38\ = CARRY(( !\mv.qav.av[0].sum[-12]~q\ $ (!\x2[5]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-12]~q\)) ) + ( \Add8~15\ ) + ( \Add8~14\ ))
-- \Add8~39\ = SHARE((!\mv.qav.av[0].sum[-12]~q\ & (\x2[5]~input_o\ & !\mv.qav.av[0].in_sr[15][-12]~q\)) # (\mv.qav.av[0].sum[-12]~q\ & ((!\mv.qav.av[0].in_sr[15][-12]~q\) # (\x2[5]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-12]~q\,
	datac => \ALT_INV_x2[5]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-12]~q\,
	cin => \Add8~14\,
	sharein => \Add8~15\,
	sumout => \Add8~37_sumout\,
	cout => \Add8~38\,
	shareout => \Add8~39\);

\Result~227\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~227_combout\ = (!\Add8~1_sumout\ & (((\Add8~37_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~37_sumout\,
	combout => \Result~227_combout\);

\mv.qav.av[0].sum[-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~227_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-12]~q\);

\Add8~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~45_sumout\ = SUM(( !\mv.qav.av[0].sum[-11]~q\ $ (!\x2[6]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-11]~q\)) ) + ( \Add8~39\ ) + ( \Add8~38\ ))
-- \Add8~46\ = CARRY(( !\mv.qav.av[0].sum[-11]~q\ $ (!\x2[6]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-11]~q\)) ) + ( \Add8~39\ ) + ( \Add8~38\ ))
-- \Add8~47\ = SHARE((!\mv.qav.av[0].sum[-11]~q\ & (\x2[6]~input_o\ & !\mv.qav.av[0].in_sr[15][-11]~q\)) # (\mv.qav.av[0].sum[-11]~q\ & ((!\mv.qav.av[0].in_sr[15][-11]~q\) # (\x2[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-11]~q\,
	datac => \ALT_INV_x2[6]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-11]~q\,
	cin => \Add8~38\,
	sharein => \Add8~39\,
	sumout => \Add8~45_sumout\,
	cout => \Add8~46\,
	shareout => \Add8~47\);

\Result~229\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~229_combout\ = (!\Add8~1_sumout\ & (((\Add8~45_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~45_sumout\,
	combout => \Result~229_combout\);

\mv.qav.av[0].sum[-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~229_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-11]~q\);

\Add8~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~33_sumout\ = SUM(( !\mv.qav.av[0].sum[-10]~q\ $ (!\x2[7]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-10]~q\)) ) + ( \Add8~47\ ) + ( \Add8~46\ ))
-- \Add8~34\ = CARRY(( !\mv.qav.av[0].sum[-10]~q\ $ (!\x2[7]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-10]~q\)) ) + ( \Add8~47\ ) + ( \Add8~46\ ))
-- \Add8~35\ = SHARE((!\mv.qav.av[0].sum[-10]~q\ & (\x2[7]~input_o\ & !\mv.qav.av[0].in_sr[15][-10]~q\)) # (\mv.qav.av[0].sum[-10]~q\ & ((!\mv.qav.av[0].in_sr[15][-10]~q\) # (\x2[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-10]~q\,
	datac => \ALT_INV_x2[7]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-10]~q\,
	cin => \Add8~46\,
	sharein => \Add8~47\,
	sumout => \Add8~33_sumout\,
	cout => \Add8~34\,
	shareout => \Add8~35\);

\Result~226\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~226_combout\ = (!\Add8~1_sumout\ & (((\Add8~33_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~33_sumout\,
	combout => \Result~226_combout\);

\mv.qav.av[0].sum[-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~226_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-10]~q\);

\Add8~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~41_sumout\ = SUM(( !\mv.qav.av[0].sum[-9]~q\ $ (!\x2[8]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-9]~q\)) ) + ( \Add8~35\ ) + ( \Add8~34\ ))
-- \Add8~42\ = CARRY(( !\mv.qav.av[0].sum[-9]~q\ $ (!\x2[8]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-9]~q\)) ) + ( \Add8~35\ ) + ( \Add8~34\ ))
-- \Add8~43\ = SHARE((!\mv.qav.av[0].sum[-9]~q\ & (\x2[8]~input_o\ & !\mv.qav.av[0].in_sr[15][-9]~q\)) # (\mv.qav.av[0].sum[-9]~q\ & ((!\mv.qav.av[0].in_sr[15][-9]~q\) # (\x2[8]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-9]~q\,
	datac => \ALT_INV_x2[8]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-9]~q\,
	cin => \Add8~34\,
	sharein => \Add8~35\,
	sumout => \Add8~41_sumout\,
	cout => \Add8~42\,
	shareout => \Add8~43\);

\Result~228\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~228_combout\ = (!\Add8~1_sumout\ & (((\Add8~41_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~41_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~41_sumout\,
	combout => \Result~228_combout\);

\mv.qav.av[0].sum[-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~228_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-9]~q\);

\Add8~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~49_sumout\ = SUM(( !\mv.qav.av[0].sum[-8]~q\ $ (!\x2[9]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-8]~q\)) ) + ( \Add8~43\ ) + ( \Add8~42\ ))
-- \Add8~50\ = CARRY(( !\mv.qav.av[0].sum[-8]~q\ $ (!\x2[9]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-8]~q\)) ) + ( \Add8~43\ ) + ( \Add8~42\ ))
-- \Add8~51\ = SHARE((!\mv.qav.av[0].sum[-8]~q\ & (\x2[9]~input_o\ & !\mv.qav.av[0].in_sr[15][-8]~q\)) # (\mv.qav.av[0].sum[-8]~q\ & ((!\mv.qav.av[0].in_sr[15][-8]~q\) # (\x2[9]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-8]~q\,
	datac => \ALT_INV_x2[9]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-8]~q\,
	cin => \Add8~42\,
	sharein => \Add8~43\,
	sumout => \Add8~49_sumout\,
	cout => \Add8~50\,
	shareout => \Add8~51\);

\Result~230\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~230_combout\ = (!\Add8~1_sumout\ & (((\Add8~49_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~49_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~49_sumout\,
	combout => \Result~230_combout\);

\mv.qav.av[0].sum[-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~230_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-8]~q\);

\Add8~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~53_sumout\ = SUM(( !\mv.qav.av[0].sum[-7]~q\ $ (!\x2[10]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-7]~q\)) ) + ( \Add8~51\ ) + ( \Add8~50\ ))
-- \Add8~54\ = CARRY(( !\mv.qav.av[0].sum[-7]~q\ $ (!\x2[10]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-7]~q\)) ) + ( \Add8~51\ ) + ( \Add8~50\ ))
-- \Add8~55\ = SHARE((!\mv.qav.av[0].sum[-7]~q\ & (\x2[10]~input_o\ & !\mv.qav.av[0].in_sr[15][-7]~q\)) # (\mv.qav.av[0].sum[-7]~q\ & ((!\mv.qav.av[0].in_sr[15][-7]~q\) # (\x2[10]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-7]~q\,
	datac => \ALT_INV_x2[10]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-7]~q\,
	cin => \Add8~50\,
	sharein => \Add8~51\,
	sumout => \Add8~53_sumout\,
	cout => \Add8~54\,
	shareout => \Add8~55\);

\Result~231\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~231_combout\ = (!\Add8~1_sumout\ & (((\Add8~53_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~53_sumout\,
	combout => \Result~231_combout\);

\mv.qav.av[0].sum[-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~231_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-7]~q\);

\Add8~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~57_sumout\ = SUM(( !\mv.qav.av[0].sum[-6]~q\ $ (!\x2[11]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-6]~q\)) ) + ( \Add8~55\ ) + ( \Add8~54\ ))
-- \Add8~58\ = CARRY(( !\mv.qav.av[0].sum[-6]~q\ $ (!\x2[11]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-6]~q\)) ) + ( \Add8~55\ ) + ( \Add8~54\ ))
-- \Add8~59\ = SHARE((!\mv.qav.av[0].sum[-6]~q\ & (\x2[11]~input_o\ & !\mv.qav.av[0].in_sr[15][-6]~q\)) # (\mv.qav.av[0].sum[-6]~q\ & ((!\mv.qav.av[0].in_sr[15][-6]~q\) # (\x2[11]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-6]~q\,
	datac => \ALT_INV_x2[11]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-6]~q\,
	cin => \Add8~54\,
	sharein => \Add8~55\,
	sumout => \Add8~57_sumout\,
	cout => \Add8~58\,
	shareout => \Add8~59\);

\Result~232\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~232_combout\ = (!\Add8~1_sumout\ & (((\Add8~57_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~57_sumout\,
	combout => \Result~232_combout\);

\mv.qav.av[0].sum[-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~232_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-6]~q\);

\Add8~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~61_sumout\ = SUM(( !\mv.qav.av[0].sum[-5]~q\ $ (!\x2[12]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-5]~q\)) ) + ( \Add8~59\ ) + ( \Add8~58\ ))
-- \Add8~62\ = CARRY(( !\mv.qav.av[0].sum[-5]~q\ $ (!\x2[12]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-5]~q\)) ) + ( \Add8~59\ ) + ( \Add8~58\ ))
-- \Add8~63\ = SHARE((!\mv.qav.av[0].sum[-5]~q\ & (\x2[12]~input_o\ & !\mv.qav.av[0].in_sr[15][-5]~q\)) # (\mv.qav.av[0].sum[-5]~q\ & ((!\mv.qav.av[0].in_sr[15][-5]~q\) # (\x2[12]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-5]~q\,
	datac => \ALT_INV_x2[12]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-5]~q\,
	cin => \Add8~58\,
	sharein => \Add8~59\,
	sumout => \Add8~61_sumout\,
	cout => \Add8~62\,
	shareout => \Add8~63\);

\Result~233\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~233_combout\ = (!\Add8~1_sumout\ & (((\Add8~61_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~61_sumout\,
	combout => \Result~233_combout\);

\mv.qav.av[0].sum[-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~233_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-5]~q\);

\Add8~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~65_sumout\ = SUM(( !\mv.qav.av[0].sum[-4]~q\ $ (!\x2[13]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-4]~q\)) ) + ( \Add8~63\ ) + ( \Add8~62\ ))
-- \Add8~66\ = CARRY(( !\mv.qav.av[0].sum[-4]~q\ $ (!\x2[13]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-4]~q\)) ) + ( \Add8~63\ ) + ( \Add8~62\ ))
-- \Add8~67\ = SHARE((!\mv.qav.av[0].sum[-4]~q\ & (\x2[13]~input_o\ & !\mv.qav.av[0].in_sr[15][-4]~q\)) # (\mv.qav.av[0].sum[-4]~q\ & ((!\mv.qav.av[0].in_sr[15][-4]~q\) # (\x2[13]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-4]~q\,
	datac => \ALT_INV_x2[13]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-4]~q\,
	cin => \Add8~62\,
	sharein => \Add8~63\,
	sumout => \Add8~65_sumout\,
	cout => \Add8~66\,
	shareout => \Add8~67\);

\Result~234\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~234_combout\ = (!\Add8~1_sumout\ & (((\Add8~65_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~65_sumout\,
	combout => \Result~234_combout\);

\mv.qav.av[0].sum[-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~234_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-4]~q\);

\Add8~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~69_sumout\ = SUM(( !\mv.qav.av[0].sum[-3]~q\ $ (!\x2[14]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-3]~q\)) ) + ( \Add8~67\ ) + ( \Add8~66\ ))
-- \Add8~70\ = CARRY(( !\mv.qav.av[0].sum[-3]~q\ $ (!\x2[14]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-3]~q\)) ) + ( \Add8~67\ ) + ( \Add8~66\ ))
-- \Add8~71\ = SHARE((!\mv.qav.av[0].sum[-3]~q\ & (\x2[14]~input_o\ & !\mv.qav.av[0].in_sr[15][-3]~q\)) # (\mv.qav.av[0].sum[-3]~q\ & ((!\mv.qav.av[0].in_sr[15][-3]~q\) # (\x2[14]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-3]~q\,
	datac => \ALT_INV_x2[14]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-3]~q\,
	cin => \Add8~66\,
	sharein => \Add8~67\,
	sumout => \Add8~69_sumout\,
	cout => \Add8~70\,
	shareout => \Add8~71\);

\Result~235\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~235_combout\ = (!\Add8~1_sumout\ & (((\Add8~69_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~69_sumout\,
	combout => \Result~235_combout\);

\mv.qav.av[0].sum[-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~235_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-3]~q\);

\Add8~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~73_sumout\ = SUM(( !\mv.qav.av[0].sum[-2]~q\ $ (!\x2[15]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-2]~q\)) ) + ( \Add8~71\ ) + ( \Add8~70\ ))
-- \Add8~74\ = CARRY(( !\mv.qav.av[0].sum[-2]~q\ $ (!\x2[15]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-2]~q\)) ) + ( \Add8~71\ ) + ( \Add8~70\ ))
-- \Add8~75\ = SHARE((!\mv.qav.av[0].sum[-2]~q\ & (\x2[15]~input_o\ & !\mv.qav.av[0].in_sr[15][-2]~q\)) # (\mv.qav.av[0].sum[-2]~q\ & ((!\mv.qav.av[0].in_sr[15][-2]~q\) # (\x2[15]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-2]~q\,
	datac => \ALT_INV_x2[15]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-2]~q\,
	cin => \Add8~70\,
	sharein => \Add8~71\,
	sumout => \Add8~73_sumout\,
	cout => \Add8~74\,
	shareout => \Add8~75\);

\Result~236\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~236_combout\ = (!\Add8~1_sumout\ & (((\Add8~73_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~73_sumout\,
	combout => \Result~236_combout\);

\mv.qav.av[0].sum[-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~236_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-2]~q\);

\Add8~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~77_sumout\ = SUM(( !\mv.qav.av[0].sum[-1]~q\ $ (!\x2[16]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-1]~q\)) ) + ( \Add8~75\ ) + ( \Add8~74\ ))
-- \Add8~78\ = CARRY(( !\mv.qav.av[0].sum[-1]~q\ $ (!\x2[16]~input_o\ $ (!\mv.qav.av[0].in_sr[15][-1]~q\)) ) + ( \Add8~75\ ) + ( \Add8~74\ ))
-- \Add8~79\ = SHARE((!\mv.qav.av[0].sum[-1]~q\ & (\x2[16]~input_o\ & !\mv.qav.av[0].in_sr[15][-1]~q\)) # (\mv.qav.av[0].sum[-1]~q\ & ((!\mv.qav.av[0].in_sr[15][-1]~q\) # (\x2[16]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum[-1]~q\,
	datac => \ALT_INV_x2[16]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][-1]~q\,
	cin => \Add8~74\,
	sharein => \Add8~75\,
	sumout => \Add8~77_sumout\,
	cout => \Add8~78\,
	shareout => \Add8~79\);

\Result~237\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~237_combout\ = (!\Add8~1_sumout\ & (((\Add8~77_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~77_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~77_sumout\,
	combout => \Result~237_combout\);

\mv.qav.av[0].sum[-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~237_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum[-1]~q\);

\Add8~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~81_sumout\ = SUM(( !\mv.qav.av[0].sum\(0) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~79\ ) + ( \Add8~78\ ))
-- \Add8~82\ = CARRY(( !\mv.qav.av[0].sum\(0) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~79\ ) + ( \Add8~78\ ))
-- \Add8~83\ = SHARE((!\mv.qav.av[0].sum\(0) & (\x2[17]~input_o\ & !\mv.qav.av[0].in_sr[15][0]~q\)) # (\mv.qav.av[0].sum\(0) & ((!\mv.qav.av[0].in_sr[15][0]~q\) # (\x2[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum\(0),
	datac => \ALT_INV_x2[17]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][0]~q\,
	cin => \Add8~78\,
	sharein => \Add8~79\,
	sumout => \Add8~81_sumout\,
	cout => \Add8~82\,
	shareout => \Add8~83\);

\Result~238\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~238_combout\ = (!\Add8~1_sumout\ & (((\Add8~81_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~81_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~81_sumout\,
	combout => \Result~238_combout\);

\mv.qav.av[0].sum[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~238_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum\(0));

\Add8~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~85_sumout\ = SUM(( !\mv.qav.av[0].sum\(1) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~83\ ) + ( \Add8~82\ ))
-- \Add8~86\ = CARRY(( !\mv.qav.av[0].sum\(1) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~83\ ) + ( \Add8~82\ ))
-- \Add8~87\ = SHARE((!\mv.qav.av[0].sum\(1) & (\x2[17]~input_o\ & !\mv.qav.av[0].in_sr[15][0]~q\)) # (\mv.qav.av[0].sum\(1) & ((!\mv.qav.av[0].in_sr[15][0]~q\) # (\x2[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum\(1),
	datac => \ALT_INV_x2[17]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][0]~q\,
	cin => \Add8~82\,
	sharein => \Add8~83\,
	sumout => \Add8~85_sumout\,
	cout => \Add8~86\,
	shareout => \Add8~87\);

\Result~239\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~239_combout\ = (!\Add8~1_sumout\ & (((\Add8~85_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~85_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~85_sumout\,
	combout => \Result~239_combout\);

\mv.qav.av[0].sum[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~239_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum\(1));

\Add8~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~89_sumout\ = SUM(( !\mv.qav.av[0].sum\(2) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~87\ ) + ( \Add8~86\ ))
-- \Add8~90\ = CARRY(( !\mv.qav.av[0].sum\(2) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~87\ ) + ( \Add8~86\ ))
-- \Add8~91\ = SHARE((!\mv.qav.av[0].sum\(2) & (\x2[17]~input_o\ & !\mv.qav.av[0].in_sr[15][0]~q\)) # (\mv.qav.av[0].sum\(2) & ((!\mv.qav.av[0].in_sr[15][0]~q\) # (\x2[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum\(2),
	datac => \ALT_INV_x2[17]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][0]~q\,
	cin => \Add8~86\,
	sharein => \Add8~87\,
	sumout => \Add8~89_sumout\,
	cout => \Add8~90\,
	shareout => \Add8~91\);

\Result~240\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~240_combout\ = (!\Add8~1_sumout\ & (((\Add8~89_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~89_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~89_sumout\,
	combout => \Result~240_combout\);

\mv.qav.av[0].sum[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~240_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum\(2));

\Add8~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~93_sumout\ = SUM(( !\mv.qav.av[0].sum\(3) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~91\ ) + ( \Add8~90\ ))
-- \Add8~94\ = CARRY(( !\mv.qav.av[0].sum\(3) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~91\ ) + ( \Add8~90\ ))
-- \Add8~95\ = SHARE((!\mv.qav.av[0].sum\(3) & (\x2[17]~input_o\ & !\mv.qav.av[0].in_sr[15][0]~q\)) # (\mv.qav.av[0].sum\(3) & ((!\mv.qav.av[0].in_sr[15][0]~q\) # (\x2[17]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum\(3),
	datac => \ALT_INV_x2[17]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][0]~q\,
	cin => \Add8~90\,
	sharein => \Add8~91\,
	sumout => \Add8~93_sumout\,
	cout => \Add8~94\,
	shareout => \Add8~95\);

\Result~241\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~241_combout\ = (!\Add8~1_sumout\ & (((\Add8~93_sumout\) # (\Add8~9_sumout\)) # (\Add8~5_sumout\))) # (\Add8~1_sumout\ & (\Add8~5_sumout\ & (\Add8~9_sumout\ & \Add8~93_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add8~1_sumout\,
	datab => \ALT_INV_Add8~5_sumout\,
	datac => \ALT_INV_Add8~9_sumout\,
	datad => \ALT_INV_Add8~93_sumout\,
	combout => \Result~241_combout\);

\mv.qav.av[0].sum[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~241_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum\(3));

\Add8~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add8~1_sumout\ = SUM(( !\mv.qav.av[0].sum\(4) $ (!\x2[17]~input_o\ $ (!\mv.qav.av[0].in_sr[15][0]~q\)) ) + ( \Add8~11\ ) + ( \Add8~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_mv.qav.av[0].sum\(4),
	datac => \ALT_INV_x2[17]~input_o\,
	datad => \ALT_INV_mv.qav.av[0].in_sr[15][0]~q\,
	cin => \Add8~10\,
	sharein => \Add8~11\,
	sumout => \Add8~1_sumout\);

\mv.qav.av[0].sum[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Add8~1_sumout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[0].sum\(4));

\Add9~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~41_sumout\ = SUM(( \mv.qav.av[0].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))
-- \Add9~42\ = CARRY(( \mv.qav.av[0].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-13]~q\,
	cin => GND,
	sumout => \Add9~41_sumout\,
	cout => \Add9~42\);

\Add9~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~45_sumout\ = SUM(( \mv.qav.av[0].sum[-12]~q\ ) + ( GND ) + ( \Add9~42\ ))
-- \Add9~46\ = CARRY(( \mv.qav.av[0].sum[-12]~q\ ) + ( GND ) + ( \Add9~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-12]~q\,
	cin => \Add9~42\,
	sumout => \Add9~45_sumout\,
	cout => \Add9~46\);

\Add9~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~37_sumout\ = SUM(( \mv.qav.av[0].sum[-11]~q\ ) + ( GND ) + ( \Add9~46\ ))
-- \Add9~38\ = CARRY(( \mv.qav.av[0].sum[-11]~q\ ) + ( GND ) + ( \Add9~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-11]~q\,
	cin => \Add9~46\,
	sumout => \Add9~37_sumout\,
	cout => \Add9~38\);

\Add9~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~33_sumout\ = SUM(( \mv.qav.av[0].sum[-10]~q\ ) + ( GND ) + ( \Add9~38\ ))
-- \Add9~34\ = CARRY(( \mv.qav.av[0].sum[-10]~q\ ) + ( GND ) + ( \Add9~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-10]~q\,
	cin => \Add9~38\,
	sumout => \Add9~33_sumout\,
	cout => \Add9~34\);

\Add9~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~29_sumout\ = SUM(( \mv.qav.av[0].sum[-9]~q\ ) + ( GND ) + ( \Add9~34\ ))
-- \Add9~30\ = CARRY(( \mv.qav.av[0].sum[-9]~q\ ) + ( GND ) + ( \Add9~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-9]~q\,
	cin => \Add9~34\,
	sumout => \Add9~29_sumout\,
	cout => \Add9~30\);

\Add9~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~25_sumout\ = SUM(( \mv.qav.av[0].sum[-8]~q\ ) + ( GND ) + ( \Add9~30\ ))
-- \Add9~26\ = CARRY(( \mv.qav.av[0].sum[-8]~q\ ) + ( GND ) + ( \Add9~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-8]~q\,
	cin => \Add9~30\,
	sumout => \Add9~25_sumout\,
	cout => \Add9~26\);

\Add9~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~69_sumout\ = SUM(( \mv.qav.av[0].sum[-7]~q\ ) + ( GND ) + ( \Add9~26\ ))
-- \Add9~70\ = CARRY(( \mv.qav.av[0].sum[-7]~q\ ) + ( GND ) + ( \Add9~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-7]~q\,
	cin => \Add9~26\,
	sumout => \Add9~69_sumout\,
	cout => \Add9~70\);

\Add9~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~73_sumout\ = SUM(( \mv.qav.av[0].sum[-6]~q\ ) + ( GND ) + ( \Add9~70\ ))
-- \Add9~74\ = CARRY(( \mv.qav.av[0].sum[-6]~q\ ) + ( GND ) + ( \Add9~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-6]~q\,
	cin => \Add9~70\,
	sumout => \Add9~73_sumout\,
	cout => \Add9~74\);

\Add9~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~65_sumout\ = SUM(( \mv.qav.av[0].sum[-5]~q\ ) + ( GND ) + ( \Add9~74\ ))
-- \Add9~66\ = CARRY(( \mv.qav.av[0].sum[-5]~q\ ) + ( GND ) + ( \Add9~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-5]~q\,
	cin => \Add9~74\,
	sumout => \Add9~65_sumout\,
	cout => \Add9~66\);

\Add9~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~61_sumout\ = SUM(( \mv.qav.av[0].sum[-4]~q\ ) + ( GND ) + ( \Add9~66\ ))
-- \Add9~62\ = CARRY(( \mv.qav.av[0].sum[-4]~q\ ) + ( GND ) + ( \Add9~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-4]~q\,
	cin => \Add9~66\,
	sumout => \Add9~61_sumout\,
	cout => \Add9~62\);

\Add9~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~57_sumout\ = SUM(( \mv.qav.av[0].sum[-3]~q\ ) + ( GND ) + ( \Add9~62\ ))
-- \Add9~58\ = CARRY(( \mv.qav.av[0].sum[-3]~q\ ) + ( GND ) + ( \Add9~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-3]~q\,
	cin => \Add9~62\,
	sumout => \Add9~57_sumout\,
	cout => \Add9~58\);

\Add9~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~21_sumout\ = SUM(( \mv.qav.av[0].sum[-2]~q\ ) + ( GND ) + ( \Add9~58\ ))
-- \Add9~22\ = CARRY(( \mv.qav.av[0].sum[-2]~q\ ) + ( GND ) + ( \Add9~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-2]~q\,
	cin => \Add9~58\,
	sumout => \Add9~21_sumout\,
	cout => \Add9~22\);

\Add9~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~17_sumout\ = SUM(( \mv.qav.av[0].sum[-1]~q\ ) + ( GND ) + ( \Add9~22\ ))
-- \Add9~18\ = CARRY(( \mv.qav.av[0].sum[-1]~q\ ) + ( GND ) + ( \Add9~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum[-1]~q\,
	cin => \Add9~22\,
	sumout => \Add9~17_sumout\,
	cout => \Add9~18\);

\Add9~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~13_sumout\ = SUM(( \mv.qav.av[0].sum\(0) ) + ( GND ) + ( \Add9~18\ ))
-- \Add9~14\ = CARRY(( \mv.qav.av[0].sum\(0) ) + ( GND ) + ( \Add9~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum\(0),
	cin => \Add9~18\,
	sumout => \Add9~13_sumout\,
	cout => \Add9~14\);

\Add9~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~9_sumout\ = SUM(( \mv.qav.av[0].sum\(1) ) + ( GND ) + ( \Add9~14\ ))
-- \Add9~10\ = CARRY(( \mv.qav.av[0].sum\(1) ) + ( GND ) + ( \Add9~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum\(1),
	cin => \Add9~14\,
	sumout => \Add9~9_sumout\,
	cout => \Add9~10\);

\Add9~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~53_sumout\ = SUM(( \mv.qav.av[0].sum\(2) ) + ( GND ) + ( \Add9~10\ ))
-- \Add9~54\ = CARRY(( \mv.qav.av[0].sum\(2) ) + ( GND ) + ( \Add9~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum\(2),
	cin => \Add9~10\,
	sumout => \Add9~53_sumout\,
	cout => \Add9~54\);

\Add9~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~5_sumout\ = SUM(( \mv.qav.av[0].sum\(3) ) + ( GND ) + ( \Add9~54\ ))
-- \Add9~6\ = CARRY(( \mv.qav.av[0].sum\(3) ) + ( GND ) + ( \Add9~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum\(3),
	cin => \Add9~54\,
	sumout => \Add9~5_sumout\,
	cout => \Add9~6\);

\Add9~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~1_sumout\ = SUM(( \mv.qav.av[0].sum\(4) ) + ( GND ) + ( \Add9~6\ ))
-- \Add9~2\ = CARRY(( \mv.qav.av[0].sum\(4) ) + ( GND ) + ( \Add9~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum\(4),
	cin => \Add9~6\,
	sumout => \Add9~1_sumout\,
	cout => \Add9~2\);

\rounds~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \rounds~3_combout\ = ( \mv.qav.av[0].sum[-15]~q\ & ( \mv.qav.av[0].sum[-14]~q\ ) ) # ( !\mv.qav.av[0].sum[-15]~q\ & ( (\mv.qav.av[0].sum[-14]~q\ & (((\mv.qav.av[0].sum[-16]~q\) # (\mv.qav.av[0].sum[-17]~q\)) # (\mv.qav.av[0].sum[-13]~q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001001100110011001100110011001100010011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-13]~q\,
	datab => \ALT_INV_mv.qav.av[0].sum[-14]~q\,
	datac => \ALT_INV_mv.qav.av[0].sum[-17]~q\,
	datad => \ALT_INV_mv.qav.av[0].sum[-16]~q\,
	datae => \ALT_INV_mv.qav.av[0].sum[-15]~q\,
	combout => \rounds~3_combout\);

\Result~160\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~160_combout\ = ( !\Add9~41_sumout\ & ( !\Add9~45_sumout\ & ( (!\Add9~25_sumout\ & (!\Add9~29_sumout\ & (!\Add9~33_sumout\ & !\Add9~37_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add9~25_sumout\,
	datab => \ALT_INV_Add9~29_sumout\,
	datac => \ALT_INV_Add9~33_sumout\,
	datad => \ALT_INV_Add9~37_sumout\,
	datae => \ALT_INV_Add9~41_sumout\,
	dataf => \ALT_INV_Add9~45_sumout\,
	combout => \Result~160_combout\);

\Result~161\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~161_combout\ = ( !\Add9~21_sumout\ & ( \Result~160_combout\ & ( (!\Add9~5_sumout\ & (!\Add9~9_sumout\ & (!\Add9~13_sumout\ & !\Add9~17_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add9~5_sumout\,
	datab => \ALT_INV_Add9~9_sumout\,
	datac => \ALT_INV_Add9~13_sumout\,
	datad => \ALT_INV_Add9~17_sumout\,
	datae => \ALT_INV_Add9~21_sumout\,
	dataf => \ALT_INV_Result~160_combout\,
	combout => \Result~161_combout\);

\Add9~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add9~49_sumout\ = SUM(( \mv.qav.av[0].sum\(4) ) + ( GND ) + ( \Add9~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[0].sum\(4),
	cin => \Add9~2\,
	sumout => \Add9~49_sumout\);

\Result~162\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~162_combout\ = ( !\Add9~69_sumout\ & ( !\Add9~73_sumout\ & ( (!\Add9~53_sumout\ & (!\Add9~57_sumout\ & (!\Add9~61_sumout\ & !\Add9~65_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add9~53_sumout\,
	datab => \ALT_INV_Add9~57_sumout\,
	datac => \ALT_INV_Add9~61_sumout\,
	datad => \ALT_INV_Add9~65_sumout\,
	datae => \ALT_INV_Add9~69_sumout\,
	dataf => \ALT_INV_Add9~73_sumout\,
	combout => \Result~162_combout\);

\Result~163\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~163_combout\ = ( \Add9~49_sumout\ & ( \Result~162_combout\ & ( \mv.qav.av[0].sum\(4) ) ) ) # ( !\Add9~49_sumout\ & ( \Result~162_combout\ & ( (\mv.qav.av[0].sum\(4) & (((!\rounds~3_combout\) # (!\Result~161_combout\)) # (\Add9~1_sumout\))) ) ) ) # 
-- ( \Add9~49_sumout\ & ( !\Result~162_combout\ & ( \mv.qav.av[0].sum\(4) ) ) ) # ( !\Add9~49_sumout\ & ( !\Result~162_combout\ & ( \mv.qav.av[0].sum\(4) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010101010101010100010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Add9~1_sumout\,
	datac => \ALT_INV_rounds~3_combout\,
	datad => \ALT_INV_Result~161_combout\,
	datae => \ALT_INV_Add9~49_sumout\,
	dataf => \ALT_INV_Result~162_combout\,
	combout => \Result~163_combout\);

\mv.qav.av[1].sum[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Add11~1_sumout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum\(4));

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 18,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 18,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18_PORTBDATAOUT_bus\);

\Add11~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~5_sumout\ = SUM(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~95\ ) + ( \Add11~94\ ))
-- \Add11~6\ = CARRY(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~95\ ) + ( \Add11~94\ ))
-- \Add11~7\ = SHARE((!\Result~163_combout\ & (\mv.qav.av[1].sum\(4) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) # (\Result~163_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\) # (\mv.qav.av[1].sum\(4)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~163_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a18~portbdataout\,
	cin => \Add11~94\,
	sharein => \Add11~95\,
	sumout => \Add11~5_sumout\,
	cout => \Add11~6\,
	shareout => \Add11~7\);

\Add11~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~9_sumout\ = SUM(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~7\ ) + ( \Add11~6\ ))
-- \Add11~10\ = CARRY(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~7\ ) + ( \Add11~6\ ))
-- \Add11~11\ = SHARE((!\Result~163_combout\ & (\mv.qav.av[1].sum\(4) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) # (\Result~163_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\) # (\mv.qav.av[1].sum\(4)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~163_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a18~portbdataout\,
	cin => \Add11~6\,
	sharein => \Add11~7\,
	sumout => \Add11~9_sumout\,
	cout => \Add11~10\,
	shareout => \Add11~11\);

\Result~164\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~164_combout\ = (!\Add9~69_sumout\ & !\Add9~73_sumout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000100010001000100010001000100010001000100010001000100010001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add9~69_sumout\,
	datab => \ALT_INV_Add9~73_sumout\,
	combout => \Result~164_combout\);

\Result~165\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~165_combout\ = ( !\Add9~65_sumout\ & ( \Result~164_combout\ & ( (!\Add9~1_sumout\ & (!\Add9~53_sumout\ & (!\Add9~57_sumout\ & !\Add9~61_sumout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add9~1_sumout\,
	datab => \ALT_INV_Add9~53_sumout\,
	datac => \ALT_INV_Add9~57_sumout\,
	datad => \ALT_INV_Add9~61_sumout\,
	datae => \ALT_INV_Add9~65_sumout\,
	dataf => \ALT_INV_Result~164_combout\,
	combout => \Result~165_combout\);

\round_overflow~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \round_overflow~1_combout\ = (\rounds~3_combout\ & (!\mv.qav.av[0].sum\(4) $ (!\Add9~1_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011000000110000001100000011000000110000001100000011000000110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Add9~1_sumout\,
	datac => \ALT_INV_rounds~3_combout\,
	combout => \round_overflow~1_combout\);

\Result~198\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~198_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum\(3))) # (\rounds~3_combout\ & ((\Add9~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(3),
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~5_sumout\,
	combout => \Result~198_combout\);

\Result~199\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~199_combout\ = ( \round_overflow~1_combout\ & ( \Result~198_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~198_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~198_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~198_combout\,
	combout => \Result~199_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 19,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 19,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19_PORTBDATAOUT_bus\);

\Result~196\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~196_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum\(2))) # (\rounds~3_combout\ & ((\Add9~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(2),
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~53_sumout\,
	combout => \Result~196_combout\);

\Result~197\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~197_combout\ = ( \round_overflow~1_combout\ & ( \Result~196_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~196_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~196_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~196_combout\,
	combout => \Result~197_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 20,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 20,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20_PORTBDATAOUT_bus\);

\Result~194\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~194_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum\(1))) # (\rounds~3_combout\ & ((\Add9~9_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(1),
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~9_sumout\,
	combout => \Result~194_combout\);

\Result~195\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~195_combout\ = ( \round_overflow~1_combout\ & ( \Result~194_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~194_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~194_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~194_combout\,
	combout => \Result~195_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 21,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 21,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21_PORTBDATAOUT_bus\);

\Result~192\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~192_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum\(0))) # (\rounds~3_combout\ & ((\Add9~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(0),
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~13_sumout\,
	combout => \Result~192_combout\);

\Result~193\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~193_combout\ = ( \round_overflow~1_combout\ & ( \Result~192_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~192_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~192_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~192_combout\,
	combout => \Result~193_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 22,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 22,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22_PORTBDATAOUT_bus\);

\Result~190\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~190_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-1]~q\)) # (\rounds~3_combout\ & ((\Add9~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-1]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~17_sumout\,
	combout => \Result~190_combout\);

\Result~191\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~191_combout\ = ( \round_overflow~1_combout\ & ( \Result~190_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~190_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~190_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~190_combout\,
	combout => \Result~191_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 23,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 23,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23_PORTBDATAOUT_bus\);

\Result~188\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~188_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-2]~q\)) # (\rounds~3_combout\ & ((\Add9~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-2]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~21_sumout\,
	combout => \Result~188_combout\);

\Result~189\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~189_combout\ = ( \round_overflow~1_combout\ & ( \Result~188_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~188_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~188_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~188_combout\,
	combout => \Result~189_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 24,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 24,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24_PORTBDATAOUT_bus\);

\Result~186\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~186_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-3]~q\)) # (\rounds~3_combout\ & ((\Add9~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-3]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~57_sumout\,
	combout => \Result~186_combout\);

\Result~187\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~187_combout\ = ( \round_overflow~1_combout\ & ( \Result~186_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~186_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~186_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~186_combout\,
	combout => \Result~187_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 25,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 25,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25_PORTBDATAOUT_bus\);

\Result~184\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~184_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-4]~q\)) # (\rounds~3_combout\ & ((\Add9~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-4]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~61_sumout\,
	combout => \Result~184_combout\);

\Result~185\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~185_combout\ = ( \round_overflow~1_combout\ & ( \Result~184_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~184_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~184_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~184_combout\,
	combout => \Result~185_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 26,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 26,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26_PORTBDATAOUT_bus\);

\Result~182\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~182_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-5]~q\)) # (\rounds~3_combout\ & ((\Add9~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-5]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~65_sumout\,
	combout => \Result~182_combout\);

\Result~183\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~183_combout\ = ( \round_overflow~1_combout\ & ( \Result~182_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~182_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~182_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~182_combout\,
	combout => \Result~183_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 27,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 27,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27_PORTBDATAOUT_bus\);

\Result~180\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~180_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-6]~q\)) # (\rounds~3_combout\ & ((\Add9~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-6]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~73_sumout\,
	combout => \Result~180_combout\);

\Result~181\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~181_combout\ = ( \round_overflow~1_combout\ & ( \Result~180_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~180_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~180_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~180_combout\,
	combout => \Result~181_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 28,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 28,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28_PORTBDATAOUT_bus\);

\Result~178\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~178_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-7]~q\)) # (\rounds~3_combout\ & ((\Add9~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-7]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~69_sumout\,
	combout => \Result~178_combout\);

\Result~179\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~179_combout\ = ( \round_overflow~1_combout\ & ( \Result~178_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~178_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~178_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~178_combout\,
	combout => \Result~179_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 29,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 29,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29_PORTBDATAOUT_bus\);

\Result~176\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~176_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-8]~q\)) # (\rounds~3_combout\ & ((\Add9~25_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-8]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~25_sumout\,
	combout => \Result~176_combout\);

\Result~177\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~177_combout\ = ( \round_overflow~1_combout\ & ( \Result~176_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~176_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~176_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~176_combout\,
	combout => \Result~177_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 30,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 30,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30_PORTBDATAOUT_bus\);

\Result~172\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~172_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-9]~q\)) # (\rounds~3_combout\ & ((\Add9~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-9]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~29_sumout\,
	combout => \Result~172_combout\);

\Result~173\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~173_combout\ = ( \round_overflow~1_combout\ & ( \Result~172_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~172_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~172_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~172_combout\,
	combout => \Result~173_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 31,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 31,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31_PORTBDATAOUT_bus\);

\Result~166\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~166_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-10]~q\)) # (\rounds~3_combout\ & ((\Add9~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-10]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~33_sumout\,
	combout => \Result~166_combout\);

\Result~167\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~167_combout\ = ( \round_overflow~1_combout\ & ( \Result~166_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~166_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~166_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~166_combout\,
	combout => \Result~167_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 32,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 32,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32_PORTBDATAOUT_bus\);

\Result~174\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~174_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-11]~q\)) # (\rounds~3_combout\ & ((\Add9~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-11]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~37_sumout\,
	combout => \Result~174_combout\);

\Result~175\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~175_combout\ = ( \round_overflow~1_combout\ & ( \Result~174_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~174_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~174_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~174_combout\,
	combout => \Result~175_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 33,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 33,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33_PORTBDATAOUT_bus\);

\Result~170\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~170_combout\ = (!\rounds~3_combout\ & (\mv.qav.av[0].sum[-12]~q\)) # (\rounds~3_combout\ & ((\Add9~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111010001110100011101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-12]~q\,
	datab => \ALT_INV_rounds~3_combout\,
	datac => \ALT_INV_Add9~45_sumout\,
	combout => \Result~170_combout\);

\Result~171\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~171_combout\ = ( \round_overflow~1_combout\ & ( \Result~170_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~170_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~170_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~170_combout\,
	combout => \Result~171_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 34,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 34,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34_PORTBDATAOUT_bus\);

\Result~168\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~168_combout\ = (!\mv.qav.av[0].sum[-13]~q\ & (((\rounds~3_combout\ & \Add9~41_sumout\)))) # (\mv.qav.av[0].sum[-13]~q\ & ((!\mv.qav.av[0].sum[-14]~q\) # ((\rounds~3_combout\ & \Add9~41_sumout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010001001111010001000100111101000100010011110100010001001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum[-13]~q\,
	datab => \ALT_INV_mv.qav.av[0].sum[-14]~q\,
	datac => \ALT_INV_rounds~3_combout\,
	datad => \ALT_INV_Add9~41_sumout\,
	combout => \Result~168_combout\);

\Result~169\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~169_combout\ = ( \round_overflow~1_combout\ & ( \Result~168_combout\ & ( (!\mv.qav.av[0].sum\(4)) # ((\Result~161_combout\ & (!\Add9~49_sumout\ & \Result~165_combout\))) ) ) ) # ( !\round_overflow~1_combout\ & ( \Result~168_combout\ ) ) # ( 
-- \round_overflow~1_combout\ & ( !\Result~168_combout\ & ( (!\mv.qav.av[0].sum\(4) & ((!\Result~161_combout\) # ((!\Result~165_combout\) # (\Add9~49_sumout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101000101011111111111111111010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[0].sum\(4),
	datab => \ALT_INV_Result~161_combout\,
	datac => \ALT_INV_Add9~49_sumout\,
	datad => \ALT_INV_Result~165_combout\,
	datae => \ALT_INV_round_overflow~1_combout\,
	dataf => \ALT_INV_Result~168_combout\,
	combout => \Result~169_combout\);

\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	clk1_output_clock_enable => "ena1",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "altshift_taps:mv.iav.av[1].in_sr_rtl_0|shift_taps_mev:auto_generated|altsyncram_2jc1:altsyncram4|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 1,
	port_a_first_address => 0,
	port_a_first_bit_number => 35,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 36,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "clear0",
	port_b_data_out_clock => "clock1",
	port_b_data_width => 1,
	port_b_first_address => 0,
	port_b_first_bit_number => 35,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 36,
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
	clr0 => \mv.iav.av[1].in_sr_rtl_0|auto_generated|ALT_INV_dffe6~q\,
	portadatain => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTADATAIN_bus\,
	portaaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTAADDR_bus\,
	portbaddr => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35_PORTBDATAOUT_bus\);

\Add11~98\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~98_cout\ = CARRY(( GND ) + ( !VCC ) + ( !VCC ))
-- \Add11~99\ = SHARE(VCC)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	cin => GND,
	sharein => GND,
	cout => \Add11~98_cout\,
	shareout => \Add11~99\);

\Add11~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~17_sumout\ = SUM(( !\Result~169_combout\ $ (!\mv.qav.av[1].sum[-17]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35~portbdataout\)) ) + ( \Add11~99\ ) + ( \Add11~98_cout\ ))
-- \Add11~18\ = CARRY(( !\Result~169_combout\ $ (!\mv.qav.av[1].sum[-17]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35~portbdataout\)) ) + ( \Add11~99\ ) + ( \Add11~98_cout\ ))
-- \Add11~19\ = SHARE((!\Result~169_combout\ & (\mv.qav.av[1].sum[-17]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35~portbdataout\)) # (\Result~169_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a35~portbdataout\) # (\mv.qav.av[1].sum[-17]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~169_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-17]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a35~portbdataout\,
	cin => \Add11~98_cout\,
	sharein => \Add11~99\,
	sumout => \Add11~17_sumout\,
	cout => \Add11~18\,
	shareout => \Add11~19\);

\Result~100\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~100_combout\ = (!\Add11~1_sumout\ & (((\Add11~17_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~17_sumout\,
	combout => \Result~100_combout\);

\mv.qav.av[1].sum[-17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~100_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-17]~q\);

\Add11~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~21_sumout\ = SUM(( !\Result~171_combout\ $ (!\mv.qav.av[1].sum[-16]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34~portbdataout\)) ) + ( \Add11~19\ ) + ( \Add11~18\ ))
-- \Add11~22\ = CARRY(( !\Result~171_combout\ $ (!\mv.qav.av[1].sum[-16]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34~portbdataout\)) ) + ( \Add11~19\ ) + ( \Add11~18\ ))
-- \Add11~23\ = SHARE((!\Result~171_combout\ & (\mv.qav.av[1].sum[-16]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34~portbdataout\)) # (\Result~171_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a34~portbdataout\) # (\mv.qav.av[1].sum[-16]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~171_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-16]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a34~portbdataout\,
	cin => \Add11~18\,
	sharein => \Add11~19\,
	sumout => \Add11~21_sumout\,
	cout => \Add11~22\,
	shareout => \Add11~23\);

\Result~101\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~101_combout\ = (!\Add11~1_sumout\ & (((\Add11~21_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~21_sumout\,
	combout => \Result~101_combout\);

\mv.qav.av[1].sum[-16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~101_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-16]~q\);

\Add11~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~29_sumout\ = SUM(( !\Result~175_combout\ $ (!\mv.qav.av[1].sum[-15]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33~portbdataout\)) ) + ( \Add11~23\ ) + ( \Add11~22\ ))
-- \Add11~30\ = CARRY(( !\Result~175_combout\ $ (!\mv.qav.av[1].sum[-15]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33~portbdataout\)) ) + ( \Add11~23\ ) + ( \Add11~22\ ))
-- \Add11~31\ = SHARE((!\Result~175_combout\ & (\mv.qav.av[1].sum[-15]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33~portbdataout\)) # (\Result~175_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a33~portbdataout\) # (\mv.qav.av[1].sum[-15]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~175_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-15]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a33~portbdataout\,
	cin => \Add11~22\,
	sharein => \Add11~23\,
	sumout => \Add11~29_sumout\,
	cout => \Add11~30\,
	shareout => \Add11~31\);

\Result~103\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~103_combout\ = (!\Add11~1_sumout\ & (((\Add11~29_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~29_sumout\,
	combout => \Result~103_combout\);

\mv.qav.av[1].sum[-15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~103_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-15]~q\);

\Add11~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~13_sumout\ = SUM(( !\Result~167_combout\ $ (!\mv.qav.av[1].sum[-14]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32~portbdataout\)) ) + ( \Add11~31\ ) + ( \Add11~30\ ))
-- \Add11~14\ = CARRY(( !\Result~167_combout\ $ (!\mv.qav.av[1].sum[-14]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32~portbdataout\)) ) + ( \Add11~31\ ) + ( \Add11~30\ ))
-- \Add11~15\ = SHARE((!\Result~167_combout\ & (\mv.qav.av[1].sum[-14]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32~portbdataout\)) # (\Result~167_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a32~portbdataout\) # (\mv.qav.av[1].sum[-14]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~167_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-14]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a32~portbdataout\,
	cin => \Add11~30\,
	sharein => \Add11~31\,
	sumout => \Add11~13_sumout\,
	cout => \Add11~14\,
	shareout => \Add11~15\);

\Add11~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~25_sumout\ = SUM(( !\Result~173_combout\ $ (!\mv.qav.av[1].sum[-13]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31~portbdataout\)) ) + ( \Add11~15\ ) + ( \Add11~14\ ))
-- \Add11~26\ = CARRY(( !\Result~173_combout\ $ (!\mv.qav.av[1].sum[-13]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31~portbdataout\)) ) + ( \Add11~15\ ) + ( \Add11~14\ ))
-- \Add11~27\ = SHARE((!\Result~173_combout\ & (\mv.qav.av[1].sum[-13]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31~portbdataout\)) # (\Result~173_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a31~portbdataout\) # (\mv.qav.av[1].sum[-13]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~173_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-13]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a31~portbdataout\,
	cin => \Add11~14\,
	sharein => \Add11~15\,
	sumout => \Add11~25_sumout\,
	cout => \Add11~26\,
	shareout => \Add11~27\);

\Result~102\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~102_combout\ = (!\Add11~1_sumout\ & (((\Add11~25_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~25_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~25_sumout\,
	combout => \Result~102_combout\);

\mv.qav.av[1].sum[-13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~102_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-13]~q\);

\Add11~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~33_sumout\ = SUM(( !\Result~177_combout\ $ (!\mv.qav.av[1].sum[-12]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30~portbdataout\)) ) + ( \Add11~27\ ) + ( \Add11~26\ ))
-- \Add11~34\ = CARRY(( !\Result~177_combout\ $ (!\mv.qav.av[1].sum[-12]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30~portbdataout\)) ) + ( \Add11~27\ ) + ( \Add11~26\ ))
-- \Add11~35\ = SHARE((!\Result~177_combout\ & (\mv.qav.av[1].sum[-12]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30~portbdataout\)) # (\Result~177_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a30~portbdataout\) # (\mv.qav.av[1].sum[-12]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~177_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-12]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a30~portbdataout\,
	cin => \Add11~26\,
	sharein => \Add11~27\,
	sumout => \Add11~33_sumout\,
	cout => \Add11~34\,
	shareout => \Add11~35\);

\Result~104\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~104_combout\ = (!\Add11~1_sumout\ & (((\Add11~33_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~33_sumout\,
	combout => \Result~104_combout\);

\mv.qav.av[1].sum[-12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~104_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-12]~q\);

\Add11~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~37_sumout\ = SUM(( !\Result~179_combout\ $ (!\mv.qav.av[1].sum[-11]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29~portbdataout\)) ) + ( \Add11~35\ ) + ( \Add11~34\ ))
-- \Add11~38\ = CARRY(( !\Result~179_combout\ $ (!\mv.qav.av[1].sum[-11]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29~portbdataout\)) ) + ( \Add11~35\ ) + ( \Add11~34\ ))
-- \Add11~39\ = SHARE((!\Result~179_combout\ & (\mv.qav.av[1].sum[-11]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29~portbdataout\)) # (\Result~179_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a29~portbdataout\) # (\mv.qav.av[1].sum[-11]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~179_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-11]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a29~portbdataout\,
	cin => \Add11~34\,
	sharein => \Add11~35\,
	sumout => \Add11~37_sumout\,
	cout => \Add11~38\,
	shareout => \Add11~39\);

\Result~105\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~105_combout\ = (!\Add11~1_sumout\ & (((\Add11~37_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~37_sumout\,
	combout => \Result~105_combout\);

\mv.qav.av[1].sum[-11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~105_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-11]~q\);

\Add11~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~41_sumout\ = SUM(( !\Result~181_combout\ $ (!\mv.qav.av[1].sum[-10]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28~portbdataout\)) ) + ( \Add11~39\ ) + ( \Add11~38\ ))
-- \Add11~42\ = CARRY(( !\Result~181_combout\ $ (!\mv.qav.av[1].sum[-10]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28~portbdataout\)) ) + ( \Add11~39\ ) + ( \Add11~38\ ))
-- \Add11~43\ = SHARE((!\Result~181_combout\ & (\mv.qav.av[1].sum[-10]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28~portbdataout\)) # (\Result~181_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a28~portbdataout\) # (\mv.qav.av[1].sum[-10]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~181_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-10]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a28~portbdataout\,
	cin => \Add11~38\,
	sharein => \Add11~39\,
	sumout => \Add11~41_sumout\,
	cout => \Add11~42\,
	shareout => \Add11~43\);

\Result~106\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~106_combout\ = (!\Add11~1_sumout\ & (((\Add11~41_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~41_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~41_sumout\,
	combout => \Result~106_combout\);

\mv.qav.av[1].sum[-10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~106_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-10]~q\);

\Add11~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~45_sumout\ = SUM(( !\Result~183_combout\ $ (!\mv.qav.av[1].sum[-9]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27~portbdataout\)) ) + ( \Add11~43\ ) + ( \Add11~42\ ))
-- \Add11~46\ = CARRY(( !\Result~183_combout\ $ (!\mv.qav.av[1].sum[-9]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27~portbdataout\)) ) + ( \Add11~43\ ) + ( \Add11~42\ ))
-- \Add11~47\ = SHARE((!\Result~183_combout\ & (\mv.qav.av[1].sum[-9]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27~portbdataout\)) # (\Result~183_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a27~portbdataout\) # (\mv.qav.av[1].sum[-9]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~183_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-9]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a27~portbdataout\,
	cin => \Add11~42\,
	sharein => \Add11~43\,
	sumout => \Add11~45_sumout\,
	cout => \Add11~46\,
	shareout => \Add11~47\);

\Result~107\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~107_combout\ = (!\Add11~1_sumout\ & (((\Add11~45_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~45_sumout\,
	combout => \Result~107_combout\);

\mv.qav.av[1].sum[-9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~107_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-9]~q\);

\Add11~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~49_sumout\ = SUM(( !\Result~185_combout\ $ (!\mv.qav.av[1].sum[-8]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26~portbdataout\)) ) + ( \Add11~47\ ) + ( \Add11~46\ ))
-- \Add11~50\ = CARRY(( !\Result~185_combout\ $ (!\mv.qav.av[1].sum[-8]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26~portbdataout\)) ) + ( \Add11~47\ ) + ( \Add11~46\ ))
-- \Add11~51\ = SHARE((!\Result~185_combout\ & (\mv.qav.av[1].sum[-8]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26~portbdataout\)) # (\Result~185_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a26~portbdataout\) # (\mv.qav.av[1].sum[-8]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~185_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-8]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a26~portbdataout\,
	cin => \Add11~46\,
	sharein => \Add11~47\,
	sumout => \Add11~49_sumout\,
	cout => \Add11~50\,
	shareout => \Add11~51\);

\Result~108\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~108_combout\ = (!\Add11~1_sumout\ & (((\Add11~49_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~49_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~49_sumout\,
	combout => \Result~108_combout\);

\mv.qav.av[1].sum[-8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~108_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-8]~q\);

\Add11~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~53_sumout\ = SUM(( !\Result~187_combout\ $ (!\mv.qav.av[1].sum[-7]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25~portbdataout\)) ) + ( \Add11~51\ ) + ( \Add11~50\ ))
-- \Add11~54\ = CARRY(( !\Result~187_combout\ $ (!\mv.qav.av[1].sum[-7]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25~portbdataout\)) ) + ( \Add11~51\ ) + ( \Add11~50\ ))
-- \Add11~55\ = SHARE((!\Result~187_combout\ & (\mv.qav.av[1].sum[-7]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25~portbdataout\)) # (\Result~187_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a25~portbdataout\) # (\mv.qav.av[1].sum[-7]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~187_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-7]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a25~portbdataout\,
	cin => \Add11~50\,
	sharein => \Add11~51\,
	sumout => \Add11~53_sumout\,
	cout => \Add11~54\,
	shareout => \Add11~55\);

\Result~109\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~109_combout\ = (!\Add11~1_sumout\ & (((\Add11~53_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~53_sumout\,
	combout => \Result~109_combout\);

\mv.qav.av[1].sum[-7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~109_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-7]~q\);

\Add11~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~57_sumout\ = SUM(( !\Result~189_combout\ $ (!\mv.qav.av[1].sum[-6]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24~portbdataout\)) ) + ( \Add11~55\ ) + ( \Add11~54\ ))
-- \Add11~58\ = CARRY(( !\Result~189_combout\ $ (!\mv.qav.av[1].sum[-6]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24~portbdataout\)) ) + ( \Add11~55\ ) + ( \Add11~54\ ))
-- \Add11~59\ = SHARE((!\Result~189_combout\ & (\mv.qav.av[1].sum[-6]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24~portbdataout\)) # (\Result~189_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a24~portbdataout\) # (\mv.qav.av[1].sum[-6]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~189_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-6]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a24~portbdataout\,
	cin => \Add11~54\,
	sharein => \Add11~55\,
	sumout => \Add11~57_sumout\,
	cout => \Add11~58\,
	shareout => \Add11~59\);

\Result~110\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~110_combout\ = (!\Add11~1_sumout\ & (((\Add11~57_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~57_sumout\,
	combout => \Result~110_combout\);

\mv.qav.av[1].sum[-6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~110_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-6]~q\);

\Add11~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~61_sumout\ = SUM(( !\Result~191_combout\ $ (!\mv.qav.av[1].sum[-5]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23~portbdataout\)) ) + ( \Add11~59\ ) + ( \Add11~58\ ))
-- \Add11~62\ = CARRY(( !\Result~191_combout\ $ (!\mv.qav.av[1].sum[-5]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23~portbdataout\)) ) + ( \Add11~59\ ) + ( \Add11~58\ ))
-- \Add11~63\ = SHARE((!\Result~191_combout\ & (\mv.qav.av[1].sum[-5]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23~portbdataout\)) # (\Result~191_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a23~portbdataout\) # (\mv.qav.av[1].sum[-5]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~191_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-5]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a23~portbdataout\,
	cin => \Add11~58\,
	sharein => \Add11~59\,
	sumout => \Add11~61_sumout\,
	cout => \Add11~62\,
	shareout => \Add11~63\);

\Result~111\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~111_combout\ = (!\Add11~1_sumout\ & (((\Add11~61_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~61_sumout\,
	combout => \Result~111_combout\);

\mv.qav.av[1].sum[-5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~111_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-5]~q\);

\Add11~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~65_sumout\ = SUM(( !\Result~193_combout\ $ (!\mv.qav.av[1].sum[-4]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22~portbdataout\)) ) + ( \Add11~63\ ) + ( \Add11~62\ ))
-- \Add11~66\ = CARRY(( !\Result~193_combout\ $ (!\mv.qav.av[1].sum[-4]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22~portbdataout\)) ) + ( \Add11~63\ ) + ( \Add11~62\ ))
-- \Add11~67\ = SHARE((!\Result~193_combout\ & (\mv.qav.av[1].sum[-4]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22~portbdataout\)) # (\Result~193_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a22~portbdataout\) # (\mv.qav.av[1].sum[-4]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~193_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-4]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a22~portbdataout\,
	cin => \Add11~62\,
	sharein => \Add11~63\,
	sumout => \Add11~65_sumout\,
	cout => \Add11~66\,
	shareout => \Add11~67\);

\Result~112\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~112_combout\ = (!\Add11~1_sumout\ & (((\Add11~65_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~65_sumout\,
	combout => \Result~112_combout\);

\mv.qav.av[1].sum[-4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~112_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-4]~q\);

\Add11~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~69_sumout\ = SUM(( !\Result~195_combout\ $ (!\mv.qav.av[1].sum[-3]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21~portbdataout\)) ) + ( \Add11~67\ ) + ( \Add11~66\ ))
-- \Add11~70\ = CARRY(( !\Result~195_combout\ $ (!\mv.qav.av[1].sum[-3]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21~portbdataout\)) ) + ( \Add11~67\ ) + ( \Add11~66\ ))
-- \Add11~71\ = SHARE((!\Result~195_combout\ & (\mv.qav.av[1].sum[-3]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21~portbdataout\)) # (\Result~195_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a21~portbdataout\) # (\mv.qav.av[1].sum[-3]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~195_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-3]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a21~portbdataout\,
	cin => \Add11~66\,
	sharein => \Add11~67\,
	sumout => \Add11~69_sumout\,
	cout => \Add11~70\,
	shareout => \Add11~71\);

\Result~113\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~113_combout\ = (!\Add11~1_sumout\ & (((\Add11~69_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~69_sumout\,
	combout => \Result~113_combout\);

\mv.qav.av[1].sum[-3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~113_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-3]~q\);

\Add11~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~73_sumout\ = SUM(( !\Result~197_combout\ $ (!\mv.qav.av[1].sum[-2]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20~portbdataout\)) ) + ( \Add11~71\ ) + ( \Add11~70\ ))
-- \Add11~74\ = CARRY(( !\Result~197_combout\ $ (!\mv.qav.av[1].sum[-2]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20~portbdataout\)) ) + ( \Add11~71\ ) + ( \Add11~70\ ))
-- \Add11~75\ = SHARE((!\Result~197_combout\ & (\mv.qav.av[1].sum[-2]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20~portbdataout\)) # (\Result~197_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a20~portbdataout\) # (\mv.qav.av[1].sum[-2]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~197_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-2]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a20~portbdataout\,
	cin => \Add11~70\,
	sharein => \Add11~71\,
	sumout => \Add11~73_sumout\,
	cout => \Add11~74\,
	shareout => \Add11~75\);

\Result~114\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~114_combout\ = (!\Add11~1_sumout\ & (((\Add11~73_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~73_sumout\,
	combout => \Result~114_combout\);

\mv.qav.av[1].sum[-2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~114_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-2]~q\);

\Add11~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~77_sumout\ = SUM(( !\Result~199_combout\ $ (!\mv.qav.av[1].sum[-1]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19~portbdataout\)) ) + ( \Add11~75\ ) + ( \Add11~74\ ))
-- \Add11~78\ = CARRY(( !\Result~199_combout\ $ (!\mv.qav.av[1].sum[-1]~q\ $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19~portbdataout\)) ) + ( \Add11~75\ ) + ( \Add11~74\ ))
-- \Add11~79\ = SHARE((!\Result~199_combout\ & (\mv.qav.av[1].sum[-1]~q\ & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19~portbdataout\)) # (\Result~199_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a19~portbdataout\) # (\mv.qav.av[1].sum[-1]~q\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~199_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum[-1]~q\,
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a19~portbdataout\,
	cin => \Add11~74\,
	sharein => \Add11~75\,
	sumout => \Add11~77_sumout\,
	cout => \Add11~78\,
	shareout => \Add11~79\);

\Result~115\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~115_combout\ = (!\Add11~1_sumout\ & (((\Add11~77_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~77_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~77_sumout\,
	combout => \Result~115_combout\);

\mv.qav.av[1].sum[-1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~115_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-1]~q\);

\Add11~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~81_sumout\ = SUM(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(0) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~79\ ) + ( \Add11~78\ ))
-- \Add11~82\ = CARRY(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(0) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~79\ ) + ( \Add11~78\ ))
-- \Add11~83\ = SHARE((!\Result~163_combout\ & (\mv.qav.av[1].sum\(0) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) # (\Result~163_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\) # (\mv.qav.av[1].sum\(0)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~163_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(0),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a18~portbdataout\,
	cin => \Add11~78\,
	sharein => \Add11~79\,
	sumout => \Add11~81_sumout\,
	cout => \Add11~82\,
	shareout => \Add11~83\);

\Result~116\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~116_combout\ = (!\Add11~1_sumout\ & (((\Add11~81_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~81_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~81_sumout\,
	combout => \Result~116_combout\);

\mv.qav.av[1].sum[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~116_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum\(0));

\Add11~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~85_sumout\ = SUM(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(1) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~83\ ) + ( \Add11~82\ ))
-- \Add11~86\ = CARRY(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(1) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~83\ ) + ( \Add11~82\ ))
-- \Add11~87\ = SHARE((!\Result~163_combout\ & (\mv.qav.av[1].sum\(1) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) # (\Result~163_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\) # (\mv.qav.av[1].sum\(1)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~163_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(1),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a18~portbdataout\,
	cin => \Add11~82\,
	sharein => \Add11~83\,
	sumout => \Add11~85_sumout\,
	cout => \Add11~86\,
	shareout => \Add11~87\);

\Result~117\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~117_combout\ = (!\Add11~1_sumout\ & (((\Add11~85_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~85_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~85_sumout\,
	combout => \Result~117_combout\);

\mv.qav.av[1].sum[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~117_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum\(1));

\Add11~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~89_sumout\ = SUM(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(2) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~87\ ) + ( \Add11~86\ ))
-- \Add11~90\ = CARRY(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(2) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~87\ ) + ( \Add11~86\ ))
-- \Add11~91\ = SHARE((!\Result~163_combout\ & (\mv.qav.av[1].sum\(2) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) # (\Result~163_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\) # (\mv.qav.av[1].sum\(2)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~163_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(2),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a18~portbdataout\,
	cin => \Add11~86\,
	sharein => \Add11~87\,
	sumout => \Add11~89_sumout\,
	cout => \Add11~90\,
	shareout => \Add11~91\);

\Result~118\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~118_combout\ = (!\Add11~1_sumout\ & (((\Add11~89_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~89_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~89_sumout\,
	combout => \Result~118_combout\);

\mv.qav.av[1].sum[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~118_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum\(2));

\Add11~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~93_sumout\ = SUM(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(3) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~91\ ) + ( \Add11~90\ ))
-- \Add11~94\ = CARRY(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(3) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~91\ ) + ( \Add11~90\ ))
-- \Add11~95\ = SHARE((!\Result~163_combout\ & (\mv.qav.av[1].sum\(3) & !\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) # (\Result~163_combout\ & 
-- ((!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\) # (\mv.qav.av[1].sum\(3)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001111110000001100000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~163_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(3),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a18~portbdataout\,
	cin => \Add11~90\,
	sharein => \Add11~91\,
	sumout => \Add11~93_sumout\,
	cout => \Add11~94\,
	shareout => \Add11~95\);

\Result~119\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~119_combout\ = (!\Add11~1_sumout\ & (((\Add11~93_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~93_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~93_sumout\,
	combout => \Result~119_combout\);

\mv.qav.av[1].sum[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~119_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum\(3));

\Add11~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add11~1_sumout\ = SUM(( !\Result~163_combout\ $ (!\mv.qav.av[1].sum\(4) $ (!\mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ram_block7a18~portbdataout\)) ) + ( \Add11~11\ ) + ( \Add11~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001100001100111100",
	shared_arith => "on")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Result~163_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \mv.iav.av[1].in_sr_rtl_0|auto_generated|altsyncram4|ALT_INV_ram_block7a18~portbdataout\,
	cin => \Add11~10\,
	sharein => \Add11~11\,
	sumout => \Add11~1_sumout\);

\Result~99\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~99_combout\ = (!\Add11~1_sumout\ & (((\Add11~13_sumout\) # (\Add11~9_sumout\)) # (\Add11~5_sumout\))) # (\Add11~1_sumout\ & (\Add11~5_sumout\ & (\Add11~9_sumout\ & \Add11~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010101010101011001010101010101100101010101010110010101010101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add11~1_sumout\,
	datab => \ALT_INV_Add11~5_sumout\,
	datac => \ALT_INV_Add11~9_sumout\,
	datad => \ALT_INV_Add11~13_sumout\,
	combout => \Result~99_combout\);

\mv.qav.av[1].sum[-14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~99_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \mv.qav.av[1].sum[-14]~q\);

\rounds~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \rounds~1_combout\ = ( \mv.qav.av[1].sum[-15]~q\ & ( \mv.qav.av[1].sum[-14]~q\ ) ) # ( !\mv.qav.av[1].sum[-15]~q\ & ( (\mv.qav.av[1].sum[-14]~q\ & (((\mv.qav.av[1].sum[-13]~q\) # (\mv.qav.av[1].sum[-16]~q\)) # (\mv.qav.av[1].sum[-17]~q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001010101010101010101010101010100010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[1].sum[-14]~q\,
	datab => \ALT_INV_mv.qav.av[1].sum[-17]~q\,
	datac => \ALT_INV_mv.qav.av[1].sum[-16]~q\,
	datad => \ALT_INV_mv.qav.av[1].sum[-13]~q\,
	datae => \ALT_INV_mv.qav.av[1].sum[-15]~q\,
	combout => \rounds~1_combout\);

\Add12~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~41_sumout\ = SUM(( \mv.qav.av[1].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))
-- \Add12~42\ = CARRY(( \mv.qav.av[1].sum[-13]~q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-13]~q\,
	cin => GND,
	sumout => \Add12~41_sumout\,
	cout => \Add12~42\);

\Add12~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~45_sumout\ = SUM(( \mv.qav.av[1].sum[-12]~q\ ) + ( GND ) + ( \Add12~42\ ))
-- \Add12~46\ = CARRY(( \mv.qav.av[1].sum[-12]~q\ ) + ( GND ) + ( \Add12~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-12]~q\,
	cin => \Add12~42\,
	sumout => \Add12~45_sumout\,
	cout => \Add12~46\);

\Add12~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~37_sumout\ = SUM(( \mv.qav.av[1].sum[-11]~q\ ) + ( GND ) + ( \Add12~46\ ))
-- \Add12~38\ = CARRY(( \mv.qav.av[1].sum[-11]~q\ ) + ( GND ) + ( \Add12~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-11]~q\,
	cin => \Add12~46\,
	sumout => \Add12~37_sumout\,
	cout => \Add12~38\);

\Add12~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~33_sumout\ = SUM(( \mv.qav.av[1].sum[-10]~q\ ) + ( GND ) + ( \Add12~38\ ))
-- \Add12~34\ = CARRY(( \mv.qav.av[1].sum[-10]~q\ ) + ( GND ) + ( \Add12~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-10]~q\,
	cin => \Add12~38\,
	sumout => \Add12~33_sumout\,
	cout => \Add12~34\);

\Add12~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~29_sumout\ = SUM(( \mv.qav.av[1].sum[-9]~q\ ) + ( GND ) + ( \Add12~34\ ))
-- \Add12~30\ = CARRY(( \mv.qav.av[1].sum[-9]~q\ ) + ( GND ) + ( \Add12~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-9]~q\,
	cin => \Add12~34\,
	sumout => \Add12~29_sumout\,
	cout => \Add12~30\);

\Add12~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~25_sumout\ = SUM(( \mv.qav.av[1].sum[-8]~q\ ) + ( GND ) + ( \Add12~30\ ))
-- \Add12~26\ = CARRY(( \mv.qav.av[1].sum[-8]~q\ ) + ( GND ) + ( \Add12~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-8]~q\,
	cin => \Add12~30\,
	sumout => \Add12~25_sumout\,
	cout => \Add12~26\);

\Add12~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~69_sumout\ = SUM(( \mv.qav.av[1].sum[-7]~q\ ) + ( GND ) + ( \Add12~26\ ))
-- \Add12~70\ = CARRY(( \mv.qav.av[1].sum[-7]~q\ ) + ( GND ) + ( \Add12~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-7]~q\,
	cin => \Add12~26\,
	sumout => \Add12~69_sumout\,
	cout => \Add12~70\);

\Add12~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~73_sumout\ = SUM(( \mv.qav.av[1].sum[-6]~q\ ) + ( GND ) + ( \Add12~70\ ))
-- \Add12~74\ = CARRY(( \mv.qav.av[1].sum[-6]~q\ ) + ( GND ) + ( \Add12~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-6]~q\,
	cin => \Add12~70\,
	sumout => \Add12~73_sumout\,
	cout => \Add12~74\);

\Add12~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~65_sumout\ = SUM(( \mv.qav.av[1].sum[-5]~q\ ) + ( GND ) + ( \Add12~74\ ))
-- \Add12~66\ = CARRY(( \mv.qav.av[1].sum[-5]~q\ ) + ( GND ) + ( \Add12~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-5]~q\,
	cin => \Add12~74\,
	sumout => \Add12~65_sumout\,
	cout => \Add12~66\);

\Add12~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~61_sumout\ = SUM(( \mv.qav.av[1].sum[-4]~q\ ) + ( GND ) + ( \Add12~66\ ))
-- \Add12~62\ = CARRY(( \mv.qav.av[1].sum[-4]~q\ ) + ( GND ) + ( \Add12~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-4]~q\,
	cin => \Add12~66\,
	sumout => \Add12~61_sumout\,
	cout => \Add12~62\);

\Add12~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~57_sumout\ = SUM(( \mv.qav.av[1].sum[-3]~q\ ) + ( GND ) + ( \Add12~62\ ))
-- \Add12~58\ = CARRY(( \mv.qav.av[1].sum[-3]~q\ ) + ( GND ) + ( \Add12~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-3]~q\,
	cin => \Add12~62\,
	sumout => \Add12~57_sumout\,
	cout => \Add12~58\);

\Add12~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~21_sumout\ = SUM(( \mv.qav.av[1].sum[-2]~q\ ) + ( GND ) + ( \Add12~58\ ))
-- \Add12~22\ = CARRY(( \mv.qav.av[1].sum[-2]~q\ ) + ( GND ) + ( \Add12~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-2]~q\,
	cin => \Add12~58\,
	sumout => \Add12~21_sumout\,
	cout => \Add12~22\);

\Add12~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~17_sumout\ = SUM(( \mv.qav.av[1].sum[-1]~q\ ) + ( GND ) + ( \Add12~22\ ))
-- \Add12~18\ = CARRY(( \mv.qav.av[1].sum[-1]~q\ ) + ( GND ) + ( \Add12~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum[-1]~q\,
	cin => \Add12~22\,
	sumout => \Add12~17_sumout\,
	cout => \Add12~18\);

\Add12~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~13_sumout\ = SUM(( \mv.qav.av[1].sum\(0) ) + ( GND ) + ( \Add12~18\ ))
-- \Add12~14\ = CARRY(( \mv.qav.av[1].sum\(0) ) + ( GND ) + ( \Add12~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum\(0),
	cin => \Add12~18\,
	sumout => \Add12~13_sumout\,
	cout => \Add12~14\);

\Add12~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~9_sumout\ = SUM(( \mv.qav.av[1].sum\(1) ) + ( GND ) + ( \Add12~14\ ))
-- \Add12~10\ = CARRY(( \mv.qav.av[1].sum\(1) ) + ( GND ) + ( \Add12~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum\(1),
	cin => \Add12~14\,
	sumout => \Add12~9_sumout\,
	cout => \Add12~10\);

\Add12~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~53_sumout\ = SUM(( \mv.qav.av[1].sum\(2) ) + ( GND ) + ( \Add12~10\ ))
-- \Add12~54\ = CARRY(( \mv.qav.av[1].sum\(2) ) + ( GND ) + ( \Add12~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum\(2),
	cin => \Add12~10\,
	sumout => \Add12~53_sumout\,
	cout => \Add12~54\);

\Add12~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~5_sumout\ = SUM(( \mv.qav.av[1].sum\(3) ) + ( GND ) + ( \Add12~54\ ))
-- \Add12~6\ = CARRY(( \mv.qav.av[1].sum\(3) ) + ( GND ) + ( \Add12~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum\(3),
	cin => \Add12~54\,
	sumout => \Add12~5_sumout\,
	cout => \Add12~6\);

\Add12~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~1_sumout\ = SUM(( \mv.qav.av[1].sum\(4) ) + ( GND ) + ( \Add12~6\ ))
-- \Add12~2\ = CARRY(( \mv.qav.av[1].sum\(4) ) + ( GND ) + ( \Add12~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum\(4),
	cin => \Add12~6\,
	sumout => \Add12~1_sumout\,
	cout => \Add12~2\);

\Result~56\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~56_combout\ = ( !\Add12~45_sumout\ & ( (!\Add12~29_sumout\ & (!\Add12~33_sumout\ & (!\Add12~37_sumout\ & !\Add12~41_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000010000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add12~29_sumout\,
	datab => \ALT_INV_Add12~33_sumout\,
	datac => \ALT_INV_Add12~37_sumout\,
	datad => \ALT_INV_Add12~41_sumout\,
	datae => \ALT_INV_Add12~45_sumout\,
	combout => \Result~56_combout\);

\Result~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~57_combout\ = ( \Result~56_combout\ & ( (!\Add12~13_sumout\ & (!\Add12~17_sumout\ & (!\Add12~21_sumout\ & !\Add12~25_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000100000000000000000000000000000001000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add12~13_sumout\,
	datab => \ALT_INV_Add12~17_sumout\,
	datac => \ALT_INV_Add12~21_sumout\,
	datad => \ALT_INV_Add12~25_sumout\,
	datae => \ALT_INV_Result~56_combout\,
	combout => \Result~57_combout\);

\Add12~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add12~49_sumout\ = SUM(( \mv.qav.av[1].sum\(4) ) + ( GND ) + ( \Add12~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_mv.qav.av[1].sum\(4),
	cin => \Add12~2\,
	sumout => \Add12~49_sumout\);

\Result~58\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~58_combout\ = (!\Add12~61_sumout\ & (!\Add12~65_sumout\ & (!\Add12~69_sumout\ & !\Add12~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000100000000000000010000000000000001000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add12~61_sumout\,
	datab => \ALT_INV_Add12~65_sumout\,
	datac => \ALT_INV_Add12~69_sumout\,
	datad => \ALT_INV_Add12~73_sumout\,
	combout => \Result~58_combout\);

\Result~59\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~59_combout\ = (!\Add12~1_sumout\ & (!\Add12~53_sumout\ & (!\Add12~57_sumout\ & \Result~58_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010000000000000001000000000000000100000000000000010000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add12~1_sumout\,
	datab => \ALT_INV_Add12~53_sumout\,
	datac => \ALT_INV_Add12~57_sumout\,
	datad => \ALT_INV_Result~58_combout\,
	combout => \Result~59_combout\);

\Result~60\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~60_combout\ = ( \Result~59_combout\ & ( (((!\Result~57_combout\) # (\Add12~49_sumout\)) # (\Add12~9_sumout\)) # (\Add12~5_sumout\) ) ) # ( !\Result~59_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111101111111111111111111111111111111011111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add12~5_sumout\,
	datab => \ALT_INV_Add12~9_sumout\,
	datac => \ALT_INV_Result~57_combout\,
	datad => \ALT_INV_Add12~49_sumout\,
	datae => \ALT_INV_Result~59_combout\,
	combout => \Result~60_combout\);

\overflowx~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \overflowx~1_combout\ = (\Result~60_combout\ & (!\mv.qav.av[1].sum\(4) $ (!\Add12~1_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011000000110000001100000011000000110000001100000011000000110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[1].sum\(4),
	datab => \ALT_INV_Add12~1_sumout\,
	datac => \ALT_INV_Result~60_combout\,
	combout => \overflowx~1_combout\);

\Result~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~77_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum\(3))) # (\rounds~1_combout\ & ((\Add12~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum\(3),
	datac => \ALT_INV_Add12~5_sumout\,
	combout => \Result~77_combout\);

\Result~76\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~76_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum\(2))) # (\rounds~1_combout\ & ((\Add12~53_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum\(2),
	datac => \ALT_INV_Add12~53_sumout\,
	combout => \Result~76_combout\);

\Result~75\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~75_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum\(1))) # (\rounds~1_combout\ & ((\Add12~9_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum\(1),
	datac => \ALT_INV_Add12~9_sumout\,
	combout => \Result~75_combout\);

\Result~74\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~74_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum\(0))) # (\rounds~1_combout\ & ((\Add12~13_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum\(0),
	datac => \ALT_INV_Add12~13_sumout\,
	combout => \Result~74_combout\);

\Result~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~73_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-1]~q\)) # (\rounds~1_combout\ & ((\Add12~17_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-1]~q\,
	datac => \ALT_INV_Add12~17_sumout\,
	combout => \Result~73_combout\);

\Result~72\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~72_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-2]~q\)) # (\rounds~1_combout\ & ((\Add12~21_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-2]~q\,
	datac => \ALT_INV_Add12~21_sumout\,
	combout => \Result~72_combout\);

\Result~71\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~71_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-3]~q\)) # (\rounds~1_combout\ & ((\Add12~57_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-3]~q\,
	datac => \ALT_INV_Add12~57_sumout\,
	combout => \Result~71_combout\);

\Result~70\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~70_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-4]~q\)) # (\rounds~1_combout\ & ((\Add12~61_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-4]~q\,
	datac => \ALT_INV_Add12~61_sumout\,
	combout => \Result~70_combout\);

\Result~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~69_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-5]~q\)) # (\rounds~1_combout\ & ((\Add12~65_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-5]~q\,
	datac => \ALT_INV_Add12~65_sumout\,
	combout => \Result~69_combout\);

\Result~68\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~68_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-6]~q\)) # (\rounds~1_combout\ & ((\Add12~73_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-6]~q\,
	datac => \ALT_INV_Add12~73_sumout\,
	combout => \Result~68_combout\);

\Result~67\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~67_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-7]~q\)) # (\rounds~1_combout\ & ((\Add12~69_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-7]~q\,
	datac => \ALT_INV_Add12~69_sumout\,
	combout => \Result~67_combout\);

\Result~66\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~66_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-8]~q\)) # (\rounds~1_combout\ & ((\Add12~25_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-8]~q\,
	datac => \ALT_INV_Add12~25_sumout\,
	combout => \Result~66_combout\);

\Result~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~65_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-9]~q\)) # (\rounds~1_combout\ & ((\Add12~29_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-9]~q\,
	datac => \ALT_INV_Add12~29_sumout\,
	combout => \Result~65_combout\);

\Result~64\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~64_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-10]~q\)) # (\rounds~1_combout\ & ((\Add12~33_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-10]~q\,
	datac => \ALT_INV_Add12~33_sumout\,
	combout => \Result~64_combout\);

\Result~63\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~63_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-11]~q\)) # (\rounds~1_combout\ & ((\Add12~37_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-11]~q\,
	datac => \ALT_INV_Add12~37_sumout\,
	combout => \Result~63_combout\);

\Result~62\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~62_combout\ = (!\rounds~1_combout\ & (\mv.qav.av[1].sum[-12]~q\)) # (\rounds~1_combout\ & ((\Add12~45_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010011100100111001001110010011100100111001001110010011100100111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_mv.qav.av[1].sum[-12]~q\,
	datac => \ALT_INV_Add12~45_sumout\,
	combout => \Result~62_combout\);

\Result~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~61_combout\ = (!\mv.qav.av[1].sum[-14]~q\ & (((\rounds~1_combout\ & \Add12~41_sumout\)) # (\mv.qav.av[1].sum[-13]~q\))) # (\mv.qav.av[1].sum[-14]~q\ & (((\rounds~1_combout\ & \Add12~41_sumout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001000101111001000100010111100100010001011110010001000101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_mv.qav.av[1].sum[-14]~q\,
	datab => \ALT_INV_mv.qav.av[1].sum[-13]~q\,
	datac => \ALT_INV_rounds~1_combout\,
	datad => \ALT_INV_Add12~41_sumout\,
	combout => \Result~61_combout\);

\Add13~78\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~78_cout\ = CARRY(( VCC ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => GND,
	cout => \Add13~78_cout\);

\Add13~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~9_sumout\ = SUM(( (!\rounds~1_combout\ & (!\Result~61_combout\)) # (\rounds~1_combout\ & ((!\overflowx~1_combout\ & (!\Result~61_combout\)) # (\overflowx~1_combout\ & ((\mv.qav.av[1].sum\(4)))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35~portbdataout\ ) + ( \Add13~78_cout\ ))
-- \Add13~10\ = CARRY(( (!\rounds~1_combout\ & (!\Result~61_combout\)) # (\rounds~1_combout\ & ((!\overflowx~1_combout\ & (!\Result~61_combout\)) # (\overflowx~1_combout\ & ((\mv.qav.av[1].sum\(4)))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a35~portbdataout\ ) + ( \Add13~78_cout\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001100110010001101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_Result~61_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_overflowx~1_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a35~portbdataout\,
	cin => \Add13~78_cout\,
	sumout => \Add13~9_sumout\,
	cout => \Add13~10\);

\Add13~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~13_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~62_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~62_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34~portbdataout\ ) + ( \Add13~10\ ))
-- \Add13~14\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~62_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~62_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a34~portbdataout\ ) + ( \Add13~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~62_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a34~portbdataout\,
	cin => \Add13~10\,
	sumout => \Add13~13_sumout\,
	cout => \Add13~14\);

\Add13~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~17_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~63_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~63_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33~portbdataout\ ) + ( \Add13~14\ ))
-- \Add13~18\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~63_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~63_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a33~portbdataout\ ) + ( \Add13~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~63_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a33~portbdataout\,
	cin => \Add13~14\,
	sumout => \Add13~17_sumout\,
	cout => \Add13~18\);

\Add13~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~21_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~64_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~64_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32~portbdataout\ ) + ( \Add13~18\ ))
-- \Add13~22\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~64_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~64_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a32~portbdataout\ ) + ( \Add13~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~64_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a32~portbdataout\,
	cin => \Add13~18\,
	sumout => \Add13~21_sumout\,
	cout => \Add13~22\);

\Add13~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~25_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~65_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~65_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31~portbdataout\ ) + ( \Add13~22\ ))
-- \Add13~26\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~65_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~65_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a31~portbdataout\ ) + ( \Add13~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~65_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a31~portbdataout\,
	cin => \Add13~22\,
	sumout => \Add13~25_sumout\,
	cout => \Add13~26\);

\Add13~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~29_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~66_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~66_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30~portbdataout\ ) + ( \Add13~26\ ))
-- \Add13~30\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~66_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~66_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a30~portbdataout\ ) + ( \Add13~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~66_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a30~portbdataout\,
	cin => \Add13~26\,
	sumout => \Add13~29_sumout\,
	cout => \Add13~30\);

\Add13~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~33_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~67_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~67_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29~portbdataout\ ) + ( \Add13~30\ ))
-- \Add13~34\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~67_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~67_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a29~portbdataout\ ) + ( \Add13~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~67_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a29~portbdataout\,
	cin => \Add13~30\,
	sumout => \Add13~33_sumout\,
	cout => \Add13~34\);

\Add13~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~37_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~68_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~68_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28~portbdataout\ ) + ( \Add13~34\ ))
-- \Add13~38\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~68_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~68_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a28~portbdataout\ ) + ( \Add13~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~68_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a28~portbdataout\,
	cin => \Add13~34\,
	sumout => \Add13~37_sumout\,
	cout => \Add13~38\);

\Add13~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~41_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~69_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~69_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27~portbdataout\ ) + ( \Add13~38\ ))
-- \Add13~42\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~69_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~69_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a27~portbdataout\ ) + ( \Add13~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~69_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a27~portbdataout\,
	cin => \Add13~38\,
	sumout => \Add13~41_sumout\,
	cout => \Add13~42\);

\Add13~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~45_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~70_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~70_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26~portbdataout\ ) + ( \Add13~42\ ))
-- \Add13~46\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~70_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~70_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a26~portbdataout\ ) + ( \Add13~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~70_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a26~portbdataout\,
	cin => \Add13~42\,
	sumout => \Add13~45_sumout\,
	cout => \Add13~46\);

\Add13~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~49_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~71_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~71_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25~portbdataout\ ) + ( \Add13~46\ ))
-- \Add13~50\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~71_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~71_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a25~portbdataout\ ) + ( \Add13~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~71_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a25~portbdataout\,
	cin => \Add13~46\,
	sumout => \Add13~49_sumout\,
	cout => \Add13~50\);

\Add13~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~53_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~72_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~72_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24~portbdataout\ ) + ( \Add13~50\ ))
-- \Add13~54\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~72_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~72_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a24~portbdataout\ ) + ( \Add13~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~72_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a24~portbdataout\,
	cin => \Add13~50\,
	sumout => \Add13~53_sumout\,
	cout => \Add13~54\);

\Add13~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~57_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~73_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~73_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23~portbdataout\ ) + ( \Add13~54\ ))
-- \Add13~58\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~73_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~73_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a23~portbdataout\ ) + ( \Add13~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~73_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a23~portbdataout\,
	cin => \Add13~54\,
	sumout => \Add13~57_sumout\,
	cout => \Add13~58\);

\Add13~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~61_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~74_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~74_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22~portbdataout\ ) + ( \Add13~58\ ))
-- \Add13~62\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~74_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~74_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a22~portbdataout\ ) + ( \Add13~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~74_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a22~portbdataout\,
	cin => \Add13~58\,
	sumout => \Add13~61_sumout\,
	cout => \Add13~62\);

\Add13~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~65_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~75_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~75_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21~portbdataout\ ) + ( \Add13~62\ ))
-- \Add13~66\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~75_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~75_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a21~portbdataout\ ) + ( \Add13~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~75_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a21~portbdataout\,
	cin => \Add13~62\,
	sumout => \Add13~65_sumout\,
	cout => \Add13~66\);

\Add13~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~69_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~76_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~76_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20~portbdataout\ ) + ( \Add13~66\ ))
-- \Add13~70\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~76_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~76_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a20~portbdataout\ ) + ( \Add13~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~76_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a20~portbdataout\,
	cin => \Add13~66\,
	sumout => \Add13~69_sumout\,
	cout => \Add13~70\);

\Add13~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~73_sumout\ = SUM(( (!\overflowx~1_combout\ & (((!\Result~77_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~77_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19~portbdataout\ ) + ( \Add13~70\ ))
-- \Add13~74\ = CARRY(( (!\overflowx~1_combout\ & (((!\Result~77_combout\)))) # (\overflowx~1_combout\ & ((!\rounds~1_combout\ & ((!\Result~77_combout\))) # (\rounds~1_combout\ & (\mv.qav.av[1].sum\(4))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a19~portbdataout\ ) + ( \Add13~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_overflowx~1_combout\,
	datab => \ALT_INV_rounds~1_combout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~77_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a19~portbdataout\,
	cin => \Add13~70\,
	sumout => \Add13~73_sumout\,
	cout => \Add13~74\);

\Add13~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~1_sumout\ = SUM(( (!\rounds~1_combout\ & (((!\mv.qav.av[1].sum\(4))))) # (\rounds~1_combout\ & ((!\Result~60_combout\ & (!\Add12~1_sumout\)) # (\Result~60_combout\ & ((!\mv.qav.av[1].sum\(4)))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18~portbdataout\ ) + ( \Add13~74\ ))
-- \Add13~2\ = CARRY(( (!\rounds~1_combout\ & (((!\mv.qav.av[1].sum\(4))))) # (\rounds~1_combout\ & ((!\Result~60_combout\ & (!\Add12~1_sumout\)) # (\Result~60_combout\ & ((!\mv.qav.av[1].sum\(4)))))) ) + ( 
-- \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18~portbdataout\ ) + ( \Add13~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000001110010011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_Add12~1_sumout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~60_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a18~portbdataout\,
	cin => \Add13~74\,
	sumout => \Add13~1_sumout\,
	cout => \Add13~2\);

\Add13~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add13~5_sumout\ = SUM(( (!\rounds~1_combout\ & (((!\mv.qav.av[1].sum\(4))))) # (\rounds~1_combout\ & ((!\Result~60_combout\ & (!\Add12~1_sumout\)) # (\Result~60_combout\ & ((!\mv.qav.av[1].sum\(4)))))) ) + ( 
-- !\mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ram_block8a18~portbdataout\ ) + ( \Add13~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000001111111100000000000000001110010011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rounds~1_combout\,
	datab => \ALT_INV_Add12~1_sumout\,
	datac => \ALT_INV_mv.qav.av[1].sum\(4),
	datad => \ALT_INV_Result~60_combout\,
	dataf => \mv.iav.av[0].in_sr_rtl_0|auto_generated|altsyncram5|ALT_INV_ram_block8a18~portbdataout\,
	cin => \Add13~2\,
	sumout => \Add13~5_sumout\);

\Result~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~17_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~9_sumout\)) # (\Add13~1_sumout\ & ((\Add13~9_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~9_sumout\,
	combout => \Result~17_combout\);

\y2[0]~reg0\ : dffeas
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
	q => \y2[0]~reg0_q\);

\Result~18\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~18_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~13_sumout\)) # (\Add13~1_sumout\ & ((\Add13~13_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~13_sumout\,
	combout => \Result~18_combout\);

\y2[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~18_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y2[1]~reg0_q\);

\Result~19\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~19_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~17_sumout\)) # (\Add13~1_sumout\ & ((\Add13~17_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~17_sumout\,
	combout => \Result~19_combout\);

\y2[2]~reg0\ : dffeas
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
	q => \y2[2]~reg0_q\);

\Result~20\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~20_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~21_sumout\)) # (\Add13~1_sumout\ & ((\Add13~21_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~21_sumout\,
	combout => \Result~20_combout\);

\y2[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~20_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y2[3]~reg0_q\);

\Result~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~21_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~25_sumout\)) # (\Add13~1_sumout\ & ((\Add13~25_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~25_sumout\,
	combout => \Result~21_combout\);

\y2[4]~reg0\ : dffeas
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
	q => \y2[4]~reg0_q\);

\Result~22\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~22_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~29_sumout\)) # (\Add13~1_sumout\ & ((\Add13~29_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~29_sumout\,
	combout => \Result~22_combout\);

\y2[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~22_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y2[5]~reg0_q\);

\Result~23\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~23_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~33_sumout\)) # (\Add13~1_sumout\ & ((\Add13~33_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~33_sumout\,
	combout => \Result~23_combout\);

\y2[6]~reg0\ : dffeas
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
	q => \y2[6]~reg0_q\);

\Result~24\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~24_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~37_sumout\)) # (\Add13~1_sumout\ & ((\Add13~37_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~37_sumout\,
	combout => \Result~24_combout\);

\y2[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~24_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y2[7]~reg0_q\);

\Result~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~25_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~41_sumout\)) # (\Add13~1_sumout\ & ((\Add13~41_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~41_sumout\,
	combout => \Result~25_combout\);

\y2[8]~reg0\ : dffeas
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
	q => \y2[8]~reg0_q\);

\Result~26\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~26_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~45_sumout\)) # (\Add13~1_sumout\ & ((\Add13~45_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~45_sumout\,
	combout => \Result~26_combout\);

\y2[9]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~26_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y2[9]~reg0_q\);

\Result~27\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~27_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~49_sumout\)) # (\Add13~1_sumout\ & ((\Add13~49_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~49_sumout\,
	combout => \Result~27_combout\);

\y2[10]~reg0\ : dffeas
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
	q => \y2[10]~reg0_q\);

\Result~28\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~28_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~53_sumout\)) # (\Add13~1_sumout\ & ((\Add13~53_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~53_sumout\,
	combout => \Result~28_combout\);

\y2[11]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~28_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y2[11]~reg0_q\);

\Result~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~29_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~57_sumout\)) # (\Add13~1_sumout\ & ((\Add13~57_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~57_sumout\,
	combout => \Result~29_combout\);

\y2[12]~reg0\ : dffeas
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
	q => \y2[12]~reg0_q\);

\Result~30\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~30_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~61_sumout\)) # (\Add13~1_sumout\ & ((\Add13~61_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~61_sumout\,
	combout => \Result~30_combout\);

\y2[13]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~30_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y2[13]~reg0_q\);

\Result~31\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~31_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~65_sumout\)) # (\Add13~1_sumout\ & ((\Add13~65_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~65_sumout\,
	combout => \Result~31_combout\);

\y2[14]~reg0\ : dffeas
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
	q => \y2[14]~reg0_q\);

\Result~32\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~32_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~69_sumout\)) # (\Add13~1_sumout\ & ((\Add13~69_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~69_sumout\,
	combout => \Result~32_combout\);

\y2[15]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \Result~32_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y2[15]~reg0_q\);

\Result~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~33_combout\ = (!\Add13~1_sumout\ & (\Add13~5_sumout\ & \Add13~73_sumout\)) # (\Add13~1_sumout\ & ((\Add13~73_sumout\) # (\Add13~5_sumout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~1_sumout\,
	datab => \ALT_INV_Add13~5_sumout\,
	datac => \ALT_INV_Add13~73_sumout\,
	combout => \Result~33_combout\);

\y2[16]~reg0\ : dffeas
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
	q => \y2[16]~reg0_q\);

\y2[17]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \y2[17]~0_combout\ = !\Add13~5_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Add13~5_sumout\,
	combout => \y2[17]~0_combout\);

\y2[17]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \y2[17]~0_combout\,
	ena => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \y2[17]~reg0_q\);

ww_y1(0) <= \y1[0]~output_o\;

ww_y1(1) <= \y1[1]~output_o\;

ww_y1(2) <= \y1[2]~output_o\;

ww_y1(3) <= \y1[3]~output_o\;

ww_y1(4) <= \y1[4]~output_o\;

ww_y1(5) <= \y1[5]~output_o\;

ww_y1(6) <= \y1[6]~output_o\;

ww_y1(7) <= \y1[7]~output_o\;

ww_y1(8) <= \y1[8]~output_o\;

ww_y1(9) <= \y1[9]~output_o\;

ww_y1(10) <= \y1[10]~output_o\;

ww_y1(11) <= \y1[11]~output_o\;

ww_y1(12) <= \y1[12]~output_o\;

ww_y1(13) <= \y1[13]~output_o\;

ww_y1(14) <= \y1[14]~output_o\;

ww_y1(15) <= \y1[15]~output_o\;

ww_y1(16) <= \y1[16]~output_o\;

ww_y1(17) <= \y1[17]~output_o\;

ww_y2(0) <= \y2[0]~output_o\;

ww_y2(1) <= \y2[1]~output_o\;

ww_y2(2) <= \y2[2]~output_o\;

ww_y2(3) <= \y2[3]~output_o\;

ww_y2(4) <= \y2[4]~output_o\;

ww_y2(5) <= \y2[5]~output_o\;

ww_y2(6) <= \y2[6]~output_o\;

ww_y2(7) <= \y2[7]~output_o\;

ww_y2(8) <= \y2[8]~output_o\;

ww_y2(9) <= \y2[9]~output_o\;

ww_y2(10) <= \y2[10]~output_o\;

ww_y2(11) <= \y2[11]~output_o\;

ww_y2(12) <= \y2[12]~output_o\;

ww_y2(13) <= \y2[13]~output_o\;

ww_y2(14) <= \y2[14]~output_o\;

ww_y2(15) <= \y2[15]~output_o\;

ww_y2(16) <= \y2[16]~output_o\;

ww_y2(17) <= \y2[17]~output_o\;
END structure;


