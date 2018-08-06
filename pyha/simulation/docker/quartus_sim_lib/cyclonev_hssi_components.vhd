-- Copyright (C) 2017 Intel Corporation. All rights reserved.
-- This simulation model contains highly confidential and
-- proprietary information of Intel and is being provided
-- in accordance with and subject to the protections of the
-- applicable Intel Program License Subscription Agreement
-- which governs its use and disclosure. Your use of Intel
-- Corporation's design tools, logic functions and other
-- software and tools, and its AMPP partner logic functions,
-- and any output files any of the foregoing (including device
-- programming or simulation files), and any associated
-- documentation or information are expressly subject to the
-- terms and conditions of the Intel Program License Subscription
-- Agreement, the Intel Quartus Prime License Agreement, the
-- Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is 
-- for the sole purpose of simulating designs for use exclusively
-- in logic devices manufactured by Intel and sold by Intel or 
-- its authorized distributors. Please refer to the applicable
-- agreement for further details. Intel products and services
-- are protected under numerous U.S. and foreign patents, 
-- maskwork rights, copyrights and other intellectual property laws.
-- Intel assumes no responsibility or liability arising out of the
-- application or use of this simulation model.
-- Quartus Prime 17.1.0 Build 590 10/25/2017
LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;

package CYCLONEV_HSSI_COMPONENTS is

-- GENERIC utility functions BEGIN
function bin2int (s : std_logic_vector) return integer;
function bin2int (s : bit_vector) return integer;
function bin2int (s : std_logic) return integer;
function bin2int (s : bit) return integer;
function int2bit (arg : boolean) return std_logic;
function str2bin (s : string) return std_logic_vector;
function str2int (s : string) return integer;
function int2bin (arg : integer; size : integer) return std_logic_vector;
function int2bin (arg : boolean; size : integer) return std_logic_vector;
function int2bit (arg : integer) return std_logic;

component	cyclonev_channel_pll
	generic
(
		sim_use_fast_model	:	string	:=	"true";
		enable_debug_info	:	string	:=	"false";
                cvp_en_iocsr            :       string  :=      "false";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0;
		reference_clock_frequency	:	string	:=	"";
		output_clock_frequency	:	string	:=	"";
		enabled_for_reconfig	:	string	:=	"false";
		bbpd_salatch_offset_ctrl_clk0	:	string	:=	"offset_0mv";
		bbpd_salatch_offset_ctrl_clk180	:	string	:=	"offset_0mv";
		bbpd_salatch_offset_ctrl_clk270	:	string	:=	"offset_0mv";
		bbpd_salatch_offset_ctrl_clk90	:	string	:=	"offset_0mv";
		bbpd_salatch_sel	:	string	:=	"normal";
		bypass_cp_rgla	:	string	:=	"false";
		cdr_atb_select	:	string	:=	"atb_disable";
		cgb_clk_enable	:	string	:=	"false";
		charge_pump_current_test	:	string	:=	"enable_ch_pump_normal";
		clklow_fref_to_ppm_div_sel	:	integer	:=	1;
		clock_monitor	:	string	:=	"lpbk_data";
		diag_rev_lpbk	:	string	:=	"false";
		enable_gpon_detection	:	string	:=	"false";
		fast_lock_mode	:	string	:=	"true";
		fb_sel	:	string	:=	"vcoclk";
		hs_levshift_power_supply_setting	:	integer	:=	1;
		ignore_phslock	:	string	:=	"false";
		l_counter_pd_clock_disable	:	string	:=	"false";
		m_counter	:	integer	:=	1;
		pcie_freq_control	:	string	:=	"pcie_100mhz";
		pd_charge_pump_current_ctrl	:	integer	:=	5;
		pd_l_counter	:	integer	:=	1;
		pfd_charge_pump_current_ctrl	:	integer	:=	20;
		pfd_l_counter	:	integer	:=	1;
		powerdown	:	string	:=	"false";
		ref_clk_div	:	integer	:=	1;
		regulator_volt_inc	:	string	:=	"0";
		replica_bias_ctrl	:	string	:=	"true";
		reverse_serial_lpbk	:	string	:=	"false";
		ripple_cap_ctrl	:	string	:=	"none";
		rxpll_pd_bw_ctrl	:	integer	:=	300;
		rxpll_pfd_bw_ctrl	:	integer	:=	3200;
		txpll_hclk_driver_enable	:	string	:=	"false";
		vco_overange_ref	:	string	:=	"ref_2";
		vco_range_ctrl_en	:	string	:=	"true"
	);
	port	(
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0';
		clkindeser	:	in	std_logic := '0';
		crurstb	:	in	std_logic := '0';
		earlyeios	:	in	std_logic := '0';
		extclk	:	in	std_logic := '0';
		lpbkpreen	:	in	std_logic := '0';
		ltd	:	in	std_logic := '0';
		ltr	:	in	std_logic := '0';
		occalen	:	in	std_logic := '0';
		pciel	:	in	std_logic := '0';
		pciesw	:	in	std_logic_vector(1 downto 0) := "00";
		ppmlock	:	in	std_logic := '0';
		refclk	:	in	std_logic := '0';
		rstn	:	in	std_logic := '0';
		rxp	:	in	std_logic := '0';
		sd	:	in	std_logic := '0';
		ck0pd	:	out	std_logic := '0';
		ck180pd	:	out	std_logic := '0';
		ck270pd	:	out	std_logic := '0';
		ck90pd	:	out	std_logic := '0';
		clk270bdes	:	out	std_logic := '0';
		clk90bdes	:	out	std_logic := '0';
		clkcdr	:	out	std_logic := '0';
		clklow	:	out	std_logic := '0';
		deven	:	out	std_logic := '0';
		dodd	:	out	std_logic := '0';
		fref	:	out	std_logic := '0';
		pdof	:	out	std_logic_vector(3 downto 0) := "0000";
		pfdmodelock	:	out	std_logic := '0';
		rxlpbdp	:	out	std_logic := '0';
		rxlpbp	:	out	std_logic := '0';
		rxplllock	:	out	std_logic := '0';
		txpllhclk	:	out	std_logic := '0';
		txrlpbk	:	out	std_logic := '0';
		vctrloverrange	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_8g_pcs_aggregate
	generic
(
		enable_debug_info	:	string	:=	"false";
		xaui_sm_operation	:	string	:=	"en_xaui_sm";
		dskw_sm_operation	:	string	:=	"dskw_xaui_sm";
		data_agg_bonding	:	string	:=	"agg_disable";
		prot_mode_tx	:	string	:=	"pipe_g1_tx";
		pcs_dw_datapath	:	string	:=	"sw_data_path";
		dskw_control	:	string	:=	"dskw_write_control";
		refclkdig_sel	:	string	:=	"dis_refclk_dig_sel";
		agg_pwdn	:	string	:=	"dis_agg_pwdn";
		dskw_mnumber_data	:	bit_vector	:=	B"100";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		aligndetsyncbotch2	:	in	std_logic_vector(1 downto 0) := "00";
		aligndetsyncch0	:	in	std_logic_vector(1 downto 0) := "00";
		aligndetsyncch1	:	in	std_logic_vector(1 downto 0) := "00";
		aligndetsyncch2	:	in	std_logic_vector(1 downto 0) := "00";
		aligndetsynctopch0	:	in	std_logic_vector(1 downto 0) := "00";
		aligndetsynctopch1	:	in	std_logic_vector(1 downto 0) := "00";
		alignstatussyncbotch2	:	in	std_logic := '0';
		alignstatussyncch0	:	in	std_logic := '0';
		alignstatussyncch1	:	in	std_logic := '0';
		alignstatussyncch2	:	in	std_logic := '0';
		alignstatussynctopch0	:	in	std_logic := '0';
		alignstatussynctopch1	:	in	std_logic := '0';
		cgcomprddinbotch2	:	in	std_logic_vector(1 downto 0) := "00";
		cgcomprddinch0	:	in	std_logic_vector(1 downto 0) := "00";
		cgcomprddinch1	:	in	std_logic_vector(1 downto 0) := "00";
		cgcomprddinch2	:	in	std_logic_vector(1 downto 0) := "00";
		cgcomprddintopch0	:	in	std_logic_vector(1 downto 0) := "00";
		cgcomprddintopch1	:	in	std_logic_vector(1 downto 0) := "00";
		cgcompwrinbotch2	:	in	std_logic_vector(1 downto 0) := "00";
		cgcompwrinch0	:	in	std_logic_vector(1 downto 0) := "00";
		cgcompwrinch1	:	in	std_logic_vector(1 downto 0) := "00";
		cgcompwrinch2	:	in	std_logic_vector(1 downto 0) := "00";
		cgcompwrintopch0	:	in	std_logic_vector(1 downto 0) := "00";
		cgcompwrintopch1	:	in	std_logic_vector(1 downto 0) := "00";
		decctlbotch2	:	in	std_logic := '0';
		decctlch0	:	in	std_logic := '0';
		decctlch1	:	in	std_logic := '0';
		decctlch2	:	in	std_logic := '0';
		decctltopch0	:	in	std_logic := '0';
		decctltopch1	:	in	std_logic := '0';
		decdatabotch2	:	in	std_logic_vector(7 downto 0) := "00000000";
		decdatach0	:	in	std_logic_vector(7 downto 0) := "00000000";
		decdatach1	:	in	std_logic_vector(7 downto 0) := "00000000";
		decdatach2	:	in	std_logic_vector(7 downto 0) := "00000000";
		decdatatopch0	:	in	std_logic_vector(7 downto 0) := "00000000";
		decdatatopch1	:	in	std_logic_vector(7 downto 0) := "00000000";
		decdatavalidbotch2	:	in	std_logic := '0';
		decdatavalidch0	:	in	std_logic := '0';
		decdatavalidch1	:	in	std_logic := '0';
		decdatavalidch2	:	in	std_logic := '0';
		decdatavalidtopch0	:	in	std_logic := '0';
		decdatavalidtopch1	:	in	std_logic := '0';
		dedicatedaggscaninch1	:	in	std_logic := '0';
		delcondmetinbotch2	:	in	std_logic := '0';
		delcondmetinch0	:	in	std_logic := '0';
		delcondmetinch1	:	in	std_logic := '0';
		delcondmetinch2	:	in	std_logic := '0';
		delcondmetintopch0	:	in	std_logic := '0';
		delcondmetintopch1	:	in	std_logic := '0';
		dprioagg	:	in	std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
		fifoovrinbotch2	:	in	std_logic := '0';
		fifoovrinch0	:	in	std_logic := '0';
		fifoovrinch1	:	in	std_logic := '0';
		fifoovrinch2	:	in	std_logic := '0';
		fifoovrintopch0	:	in	std_logic := '0';
		fifoovrintopch1	:	in	std_logic := '0';
		fifordinbotch2	:	in	std_logic := '0';
		fifordinch0	:	in	std_logic := '0';
		fifordinch1	:	in	std_logic := '0';
		fifordinch2	:	in	std_logic := '0';
		fifordintopch0	:	in	std_logic := '0';
		fifordintopch1	:	in	std_logic := '0';
		insertincompleteinbotch2	:	in	std_logic := '0';
		insertincompleteinch0	:	in	std_logic := '0';
		insertincompleteinch1	:	in	std_logic := '0';
		insertincompleteinch2	:	in	std_logic := '0';
		insertincompleteintopch0	:	in	std_logic := '0';
		insertincompleteintopch1	:	in	std_logic := '0';
		latencycompinbotch2	:	in	std_logic := '0';
		latencycompinch0	:	in	std_logic := '0';
		latencycompinch1	:	in	std_logic := '0';
		latencycompinch2	:	in	std_logic := '0';
		latencycompintopch0	:	in	std_logic := '0';
		latencycompintopch1	:	in	std_logic := '0';
		rcvdclkch0	:	in	std_logic := '0';
		rcvdclkch1	:	in	std_logic := '0';
		rdalignbotch2	:	in	std_logic_vector(1 downto 0) := "00";
		rdalignch0	:	in	std_logic_vector(1 downto 0) := "00";
		rdalignch1	:	in	std_logic_vector(1 downto 0) := "00";
		rdalignch2	:	in	std_logic_vector(1 downto 0) := "00";
		rdaligntopch0	:	in	std_logic_vector(1 downto 0) := "00";
		rdaligntopch1	:	in	std_logic_vector(1 downto 0) := "00";
		rdenablesyncbotch2	:	in	std_logic := '0';
		rdenablesyncch0	:	in	std_logic := '0';
		rdenablesyncch1	:	in	std_logic := '0';
		rdenablesyncch2	:	in	std_logic := '0';
		rdenablesynctopch0	:	in	std_logic := '0';
		rdenablesynctopch1	:	in	std_logic := '0';
		refclkdig	:	in	std_logic := '0';
		runningdispbotch2	:	in	std_logic_vector(1 downto 0) := "00";
		runningdispch0	:	in	std_logic_vector(1 downto 0) := "00";
		runningdispch1	:	in	std_logic_vector(1 downto 0) := "00";
		runningdispch2	:	in	std_logic_vector(1 downto 0) := "00";
		runningdisptopch0	:	in	std_logic_vector(1 downto 0) := "00";
		runningdisptopch1	:	in	std_logic_vector(1 downto 0) := "00";
		rxpcsrstn	:	in	std_logic := '0';
		scanmoden	:	in	std_logic := '0';
		scanshiftn	:	in	std_logic := '0';
		syncstatusbotch2	:	in	std_logic := '0';
		syncstatusch0	:	in	std_logic := '0';
		syncstatusch1	:	in	std_logic := '0';
		syncstatusch2	:	in	std_logic := '0';
		syncstatustopch0	:	in	std_logic := '0';
		syncstatustopch1	:	in	std_logic := '0';
		txctltcbotch2	:	in	std_logic := '0';
		txctltcch0	:	in	std_logic := '0';
		txctltcch1	:	in	std_logic := '0';
		txctltcch2	:	in	std_logic := '0';
		txctltctopch0	:	in	std_logic := '0';
		txctltctopch1	:	in	std_logic := '0';
		txdatatcbotch2	:	in	std_logic_vector(7 downto 0) := "00000000";
		txdatatcch0	:	in	std_logic_vector(7 downto 0) := "00000000";
		txdatatcch1	:	in	std_logic_vector(7 downto 0) := "00000000";
		txdatatcch2	:	in	std_logic_vector(7 downto 0) := "00000000";
		txdatatctopch0	:	in	std_logic_vector(7 downto 0) := "00000000";
		txdatatctopch1	:	in	std_logic_vector(7 downto 0) := "00000000";
		txpcsrstn	:	in	std_logic := '0';
		txpmaclk	:	in	std_logic := '0';
		aggtestbusch0	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		aggtestbusch1	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		aggtestbusch2	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		alignstatusbotch2	:	out	std_logic := '0';
		alignstatusch0	:	out	std_logic := '0';
		alignstatusch1	:	out	std_logic := '0';
		alignstatusch2	:	out	std_logic := '0';
		alignstatussync0botch2	:	out	std_logic := '0';
		alignstatussync0ch0	:	out	std_logic := '0';
		alignstatussync0ch1	:	out	std_logic := '0';
		alignstatussync0ch2	:	out	std_logic := '0';
		alignstatussync0topch0	:	out	std_logic := '0';
		alignstatussync0topch1	:	out	std_logic := '0';
		alignstatustopch0	:	out	std_logic := '0';
		alignstatustopch1	:	out	std_logic := '0';
		cgcomprddallbotch2	:	out	std_logic := '0';
		cgcomprddallch0	:	out	std_logic := '0';
		cgcomprddallch1	:	out	std_logic := '0';
		cgcomprddallch2	:	out	std_logic := '0';
		cgcomprddalltopch0	:	out	std_logic := '0';
		cgcomprddalltopch1	:	out	std_logic := '0';
		cgcompwrallbotch2	:	out	std_logic := '0';
		cgcompwrallch0	:	out	std_logic := '0';
		cgcompwrallch1	:	out	std_logic := '0';
		cgcompwrallch2	:	out	std_logic := '0';
		cgcompwralltopch0	:	out	std_logic := '0';
		cgcompwralltopch1	:	out	std_logic := '0';
		dedicatedaggscanoutch0tieoff	:	out	std_logic := '0';
		dedicatedaggscanoutch1	:	out	std_logic := '0';
		dedicatedaggscanoutch2tieoff	:	out	std_logic := '0';
		delcondmet0botch2	:	out	std_logic := '0';
		delcondmet0ch0	:	out	std_logic := '0';
		delcondmet0ch1	:	out	std_logic := '0';
		delcondmet0ch2	:	out	std_logic := '0';
		delcondmet0topch0	:	out	std_logic := '0';
		delcondmet0topch1	:	out	std_logic := '0';
		endskwqdbotch2	:	out	std_logic := '0';
		endskwqdch0	:	out	std_logic := '0';
		endskwqdch1	:	out	std_logic := '0';
		endskwqdch2	:	out	std_logic := '0';
		endskwqdtopch0	:	out	std_logic := '0';
		endskwqdtopch1	:	out	std_logic := '0';
		endskwrdptrsbotch2	:	out	std_logic := '0';
		endskwrdptrsch0	:	out	std_logic := '0';
		endskwrdptrsch1	:	out	std_logic := '0';
		endskwrdptrsch2	:	out	std_logic := '0';
		endskwrdptrstopch0	:	out	std_logic := '0';
		endskwrdptrstopch1	:	out	std_logic := '0';
		fifoovr0botch2	:	out	std_logic := '0';
		fifoovr0ch0	:	out	std_logic := '0';
		fifoovr0ch1	:	out	std_logic := '0';
		fifoovr0ch2	:	out	std_logic := '0';
		fifoovr0topch0	:	out	std_logic := '0';
		fifoovr0topch1	:	out	std_logic := '0';
		fifordoutcomp0botch2	:	out	std_logic := '0';
		fifordoutcomp0ch0	:	out	std_logic := '0';
		fifordoutcomp0ch1	:	out	std_logic := '0';
		fifordoutcomp0ch2	:	out	std_logic := '0';
		fifordoutcomp0topch0	:	out	std_logic := '0';
		fifordoutcomp0topch1	:	out	std_logic := '0';
		fiforstrdqdbotch2	:	out	std_logic := '0';
		fiforstrdqdch0	:	out	std_logic := '0';
		fiforstrdqdch1	:	out	std_logic := '0';
		fiforstrdqdch2	:	out	std_logic := '0';
		fiforstrdqdtopch0	:	out	std_logic := '0';
		fiforstrdqdtopch1	:	out	std_logic := '0';
		insertincomplete0botch2	:	out	std_logic := '0';
		insertincomplete0ch0	:	out	std_logic := '0';
		insertincomplete0ch1	:	out	std_logic := '0';
		insertincomplete0ch2	:	out	std_logic := '0';
		insertincomplete0topch0	:	out	std_logic := '0';
		insertincomplete0topch1	:	out	std_logic := '0';
		latencycomp0botch2	:	out	std_logic := '0';
		latencycomp0ch0	:	out	std_logic := '0';
		latencycomp0ch1	:	out	std_logic := '0';
		latencycomp0ch2	:	out	std_logic := '0';
		latencycomp0topch0	:	out	std_logic := '0';
		latencycomp0topch1	:	out	std_logic := '0';
		rcvdclkout	:	out	std_logic := '0';
		rcvdclkoutbot	:	out	std_logic := '0';
		rcvdclkouttop	:	out	std_logic := '0';
		rxctlrsbotch2	:	out	std_logic := '0';
		rxctlrsch0	:	out	std_logic := '0';
		rxctlrsch1	:	out	std_logic := '0';
		rxctlrsch2	:	out	std_logic := '0';
		rxctlrstopch0	:	out	std_logic := '0';
		rxctlrstopch1	:	out	std_logic := '0';
		rxdatarsbotch2	:	out	std_logic_vector(7 downto 0) := "00000000";
		rxdatarsch0	:	out	std_logic_vector(7 downto 0) := "00000000";
		rxdatarsch1	:	out	std_logic_vector(7 downto 0) := "00000000";
		rxdatarsch2	:	out	std_logic_vector(7 downto 0) := "00000000";
		rxdatarstopch0	:	out	std_logic_vector(7 downto 0) := "00000000";
		rxdatarstopch1	:	out	std_logic_vector(7 downto 0) := "00000000";
		txctltsbotch2	:	out	std_logic := '0';
		txctltsch0	:	out	std_logic := '0';
		txctltsch1	:	out	std_logic := '0';
		txctltsch2	:	out	std_logic := '0';
		txctltstopch0	:	out	std_logic := '0';
		txctltstopch1	:	out	std_logic := '0';
		txdatatsbotch2	:	out	std_logic_vector(7 downto 0) := "00000000";
		txdatatsch0	:	out	std_logic_vector(7 downto 0) := "00000000";
		txdatatsch1	:	out	std_logic_vector(7 downto 0) := "00000000";
		txdatatsch2	:	out	std_logic_vector(7 downto 0) := "00000000";
		txdatatstopch0	:	out	std_logic_vector(7 downto 0) := "00000000";
		txdatatstopch1	:	out	std_logic_vector(7 downto 0) := "00000000"
	);
end component;

component	cyclonev_hssi_8g_rx_pcs
	generic
(
		enable_debug_info	:	string	:=	"false";
		prot_mode	:	string	:=	"gige";
		tx_rx_parallel_loopback	:	string	:=	"dis_plpbk";
		pma_dw	:	string	:=	"eight_bit";
		pcs_bypass	:	string	:=	"dis_pcs_bypass";
		polarity_inversion	:	string	:=	"dis_pol_inv";
		wa_pd	:	string	:=	"wa_pd_10";
		wa_pd_data	:	bit_vector	:=	B"0";
		wa_boundary_lock_ctrl	:	string	:=	"bit_slip";
		wa_pld_controlled	:	string	:=	"dis_pld_ctrl";
		wa_sync_sm_ctrl	:	string	:=	"gige_sync_sm";
		wa_rknumber_data	:	bit_vector	:=	B"0";
		wa_renumber_data	:	bit_vector	:=	B"0";
		wa_rgnumber_data	:	bit_vector	:=	B"0";
		wa_rosnumber_data	:	bit_vector	:=	B"0";
		wa_kchar	:	string	:=	"dis_kchar";
		wa_det_latency_sync_status_beh	:	string	:=	"assert_sync_status_non_imm";
		wa_clk_slip_spacing	:	string	:=	"min_clk_slip_spacing";
		wa_clk_slip_spacing_data	:	bit_vector	:=	B"10000";
		bit_reversal	:	string	:=	"dis_bit_reversal";
		symbol_swap	:	string	:=	"dis_symbol_swap";
		deskew_pattern	:	bit_vector	:=	B"1101101000";
		deskew_prog_pattern_only	:	string	:=	"en_deskew_prog_pat_only";
		rate_match	:	string	:=	"dis_rm";
		eightb_tenb_decoder	:	string	:=	"dis_8b10b";
		err_flags_sel	:	string	:=	"err_flags_wa";
		polinv_8b10b_dec	:	string	:=	"dis_polinv_8b10b_dec";
		eightbtenb_decoder_output_sel	:	string	:=	"data_8b10b_decoder";
		invalid_code_flag_only	:	string	:=	"dis_invalid_code_only";
		auto_error_replacement	:	string	:=	"dis_err_replace";
		pad_or_edb_error_replace	:	string	:=	"replace_edb";
		byte_deserializer	:	string	:=	"dis_bds";
		byte_order	:	string	:=	"dis_bo";
		re_bo_on_wa	:	string	:=	"dis_re_bo_on_wa";
		bo_pattern	:	bit_vector	:=	B"0";
		bo_pad	:	bit_vector	:=	B"0";
		phase_compensation_fifo	:	string	:=	"low_latency";
		prbs_ver	:	string	:=	"dis_prbs";
		cid_pattern	:	string	:=	"cid_pattern_0";
		cid_pattern_len	:	bit_vector	:=	B"0";
		bist_ver	:	string	:=	"dis_bist";
		cdr_ctrl	:	string	:=	"dis_cdr_ctrl";
		cdr_ctrl_rxvalid_mask	:	string	:=	"dis_rxvalid_mask";
		wait_cnt	:	bit_vector	:=	B"0";
		mask_cnt	:	bit_vector	:=	X"3ff";
		eidle_entry_sd	:	string	:=	"dis_eidle_sd";
		eidle_entry_eios	:	string	:=	"dis_eidle_eios";
		eidle_entry_iei	:	string	:=	"dis_eidle_iei";
		rx_rcvd_clk	:	string	:=	"rcvd_clk_rcvd_clk";
		rx_clk1	:	string	:=	"rcvd_clk_clk1";
		rx_clk2	:	string	:=	"rcvd_clk_clk2";
		rx_rd_clk	:	string	:=	"pld_rx_clk";
		dw_one_or_two_symbol_bo	:	string	:=	"donot_care_one_two_bo";
		comp_fifo_rst_pld_ctrl	:	string	:=	"dis_comp_fifo_rst_pld_ctrl";
		bypass_pipeline_reg	:	string	:=	"dis_bypass_pipeline";
		agg_block_sel	:	string	:=	"same_smrt_pack";
		test_bus_sel	:	string	:=	"prbs_bist_testbus";
		wa_rvnumber_data	:	bit_vector	:=	B"0";
		ctrl_plane_bonding_compensation	:	string	:=	"dis_compensation";
		prbs_ver_clr_flag	:	string	:=	"dis_prbs_clr_flag";
		hip_mode	:	string	:=	"dis_hip";
		ctrl_plane_bonding_distribution	:	string	:=	"not_master_chnl_distr";
		ctrl_plane_bonding_consumption	:	string	:=	"individual";
		pma_done_count	:	bit_vector	:=	B"0";
		test_mode	:	string	:=	"prbs";
		bist_ver_clr_flag	:	string	:=	"dis_bist_clr_flag";
		wa_disp_err_flag	:	string	:=	"dis_disp_err_flag";
		runlength_check	:	string	:=	"en_runlength_sw";
		runlength_val	:	bit_vector	:=	B"0";
		force_signal_detect	:	string	:=	"en_force_signal_detect";
		deskew	:	string	:=	"dis_deskew";
		rx_wr_clk	:	string	:=	"rx_clk2_div_1_2_4";
		rx_clk_free_running	:	string	:=	"en_rx_clk_free_run";
		rx_pcs_urst	:	string	:=	"en_rx_pcs_urst";
		pipe_if_enable	:	string	:=	"dis_pipe_rx";
		pc_fifo_rst_pld_ctrl	:	string	:=	"dis_pc_fifo_rst_pld_ctrl";
		ibm_invalid_code	:	string	:=	"dis_ibm_invalid_code";
		channel_number	:	integer	:=	0;
		rx_refclk	:	string	:=	"dis_refclk_sel";
		clock_gate_dw_rm_wr	:	string	:=	"dis_dw_rm_wrclk_gating";
		clock_gate_bds_dec_asn	:	string	:=	"dis_bds_dec_asn_clk_gating";
		fixed_pat_det	:	string	:=	"dis_fixed_patdet";
		clock_gate_bist	:	string	:=	"dis_bist_clk_gating";
		clock_gate_cdr_eidle	:	string	:=	"dis_cdr_eidle_clk_gating";
		clkcmp_pattern_p	:	bit_vector	:=	B"0";
		clkcmp_pattern_n	:	bit_vector	:=	B"0";
		clock_gate_prbs	:	string	:=	"dis_prbs_clk_gating";
		clock_gate_pc_rdclk	:	string	:=	"dis_pc_rdclk_gating";
		wa_pd_polarity	:	string	:=	"dis_pd_both_pol";
		clock_gate_dskw_rd	:	string	:=	"dis_dskw_rdclk_gating";
		clock_gate_byteorder	:	string	:=	"dis_byteorder_clk_gating";
		clock_gate_dw_pc_wrclk	:	string	:=	"dis_dw_pc_wrclk_gating";
		sup_mode	:	string	:=	"user_mode";
		clock_gate_sw_wa	:	string	:=	"dis_sw_wa_clk_gating";
		clock_gate_dw_dskw_wr	:	string	:=	"dis_dw_dskw_wrclk_gating";
		clock_gate_sw_pc_wrclk	:	string	:=	"dis_sw_pc_wrclk_gating";
		clock_gate_sw_rm_rd	:	string	:=	"dis_sw_rm_rdclk_gating";
		clock_gate_sw_rm_wr	:	string	:=	"dis_sw_rm_wrclk_gating";
		auto_speed_nego	:	string	:=	"dis_asn";
		fixed_pat_num	:	bit_vector	:=	B"1111";
		clock_gate_sw_dskw_wr	:	string	:=	"dis_sw_dskw_wrclk_gating";
		clock_gate_dw_rm_rd	:	string	:=	"dis_dw_rm_rdclk_gating";
		clock_gate_dw_wa	:	string	:=	"dis_dw_wa_clk_gating";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		a1a2size	:	in	std_logic := '0';
		aggtestbus	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		alignstatus	:	in	std_logic := '0';
		alignstatussync0	:	in	std_logic := '0';
		alignstatussync0toporbot	:	in	std_logic := '0';
		alignstatustoporbot	:	in	std_logic := '0';
		bitreversalenable	:	in	std_logic := '0';
		bitslip	:	in	std_logic := '0';
		bytereversalenable	:	in	std_logic := '0';
		byteorder	:	in	std_logic := '0';
		cgcomprddall	:	in	std_logic := '0';
		cgcomprddalltoporbot	:	in	std_logic := '0';
		cgcompwrall	:	in	std_logic := '0';
		cgcompwralltoporbot	:	in	std_logic := '0';
		rmfifouserrst	:	in	std_logic := '0';
		configselinchnldown	:	in	std_logic := '0';
		configselinchnlup	:	in	std_logic := '0';
		delcondmet0	:	in	std_logic := '0';
		delcondmet0toporbot	:	in	std_logic := '0';
		dynclkswitchn	:	in	std_logic := '0';
		eidleinfersel	:	in	std_logic_vector(2 downto 0) := "000";
		endskwqd	:	in	std_logic := '0';
		endskwqdtoporbot	:	in	std_logic := '0';
		endskwrdptrs	:	in	std_logic := '0';
		endskwrdptrstoporbot	:	in	std_logic := '0';
		enablecommadetect	:	in	std_logic := '0';
		fifoovr0	:	in	std_logic := '0';
		fifoovr0toporbot	:	in	std_logic := '0';
		rmfifordincomp0	:	in	std_logic := '0';
		fifordincomp0toporbot	:	in	std_logic := '0';
		fiforstrdqd	:	in	std_logic := '0';
		fiforstrdqdtoporbot	:	in	std_logic := '0';
		gen2ngen1	:	in	std_logic := '0';
		hrdrst	:	in	std_logic := '0';
		insertincomplete0	:	in	std_logic := '0';
		insertincomplete0toporbot	:	in	std_logic := '0';
		latencycomp0	:	in	std_logic := '0';
		latencycomp0toporbot	:	in	std_logic := '0';
		phfifouserrst	:	in	std_logic := '0';
		phystatusinternal	:	in	std_logic := '0';
		phystatuspcsgen3	:	in	std_logic := '0';
		pipeloopbk	:	in	std_logic := '0';
		pldltr	:	in	std_logic := '0';
		pldrxclk	:	in	std_logic := '0';
		polinvrx	:	in	std_logic := '0';
		prbscidenable	:	in	std_logic := '0';
		datain	:	in	std_logic_vector(19 downto 0) := "00000000000000000000";
		rateswitchcontrol	:	in	std_logic := '0';
		rcvdclkagg	:	in	std_logic := '0';
		rcvdclkaggtoporbot	:	in	std_logic := '0';
		rcvdclkpma	:	in	std_logic := '0';
		rdenableinchnldown	:	in	std_logic := '0';
		rdenableinchnlup	:	in	std_logic := '0';
		rmfiforeadenable	:	in	std_logic := '0';
		pcfifordenable	:	in	std_logic := '0';
		refclkdig	:	in	std_logic := '0';
		refclkdig2	:	in	std_logic := '0';
		resetpcptrsinchnldown	:	in	std_logic := '0';
		resetpcptrsinchnlup	:	in	std_logic := '0';
		resetppmcntrsinchnldown	:	in	std_logic := '0';
		resetppmcntrsinchnlup	:	in	std_logic := '0';
		ctrlfromaggblock	:	in	std_logic := '0';
		rxcontrolrstoporbot	:	in	std_logic := '0';
		datafrinaggblock	:	in	std_logic_vector(7 downto 0) := "00000000";
		rxdatarstoporbot	:	in	std_logic_vector(7 downto 0) := "00000000";
		rxdivsyncinchnldown	:	in	std_logic_vector(1 downto 0) := "00";
		rxdivsyncinchnlup	:	in	std_logic_vector(1 downto 0) := "00";
		rxsynchdrpcsgen3	:	in	std_logic_vector(1 downto 0) := "00";
		rxweinchnldown	:	in	std_logic_vector(1 downto 0) := "00";
		rxweinchnlup	:	in	std_logic_vector(1 downto 0) := "00";
		rxstatusinternal	:	in	std_logic_vector(2 downto 0) := "000";
		rxpcsrst	:	in	std_logic := '0';
		rxvalidinternal	:	in	std_logic := '0';
		scanmode	:	in	std_logic := '0';
		sigdetfrompma	:	in	std_logic := '0';
		speedchangeinchnldown	:	in	std_logic := '0';
		speedchangeinchnlup	:	in	std_logic := '0';
		syncsmen	:	in	std_logic := '0';
		txctrlplanetestbus	:	in	std_logic_vector(19 downto 0) := "00000000000000000000";
		txdivsync	:	in	std_logic_vector(1 downto 0) := "00";
		txpmaclk	:	in	std_logic := '0';
		txtestbus	:	in	std_logic_vector(19 downto 0) := "00000000000000000000";
		parallelloopback	:	in	std_logic_vector(19 downto 0) := "00000000000000000000";
		wrenableinchnldown	:	in	std_logic := '0';
		wrenableinchnlup	:	in	std_logic := '0';
		pxfifowrdisable	:	in	std_logic := '0';
		rmfifowriteenable	:	in	std_logic := '0';
		a1a2k1k2flag	:	out	std_logic_vector(3 downto 0) := "0000";
		aggrxpcsrst	:	out	std_logic := '0';
		aligndetsync	:	out	std_logic_vector(1 downto 0) := "00";
		alignstatuspld	:	out	std_logic := '0';
		alignstatussync	:	out	std_logic := '0';
		rmfifopartialfull	:	out	std_logic := '0';
		rmfifopartialempty	:	out	std_logic := '0';
		bistdone	:	out	std_logic := '0';
		bisterr	:	out	std_logic := '0';
		byteordflag	:	out	std_logic := '0';
		cgcomprddout	:	out	std_logic_vector(1 downto 0) := "00";
		cgcompwrout	:	out	std_logic_vector(1 downto 0) := "00";
		channeltestbusout	:	out	std_logic_vector(19 downto 0) := "00000000000000000000";
		configseloutchnldown	:	out	std_logic := '0';
		configseloutchnlup	:	out	std_logic := '0';
		decoderctrl	:	out	std_logic := '0';
		decoderdata	:	out	std_logic_vector(7 downto 0) := "00000000";
		decoderdatavalid	:	out	std_logic := '0';
		delcondmetout	:	out	std_logic := '0';
		disablepcfifobyteserdes	:	out	std_logic := '0';
		earlyeios	:	out	std_logic := '0';
		eidleexit	:	out	std_logic := '0';
		rmfifoempty	:	out	std_logic := '0';
		pcfifoempty	:	out	std_logic := '0';
		errctrl	:	out	std_logic_vector(1 downto 0) := "00";
		errdata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		fifoovrout	:	out	std_logic := '0';
		fifordoutcomp	:	out	std_logic := '0';
		rmfifofull	:	out	std_logic := '0';
		pcfifofull	:	out	std_logic := '0';
		insertincompleteout	:	out	std_logic := '0';
		latencycompout	:	out	std_logic := '0';
		ltr	:	out	std_logic := '0';
		pcieswitch	:	out	std_logic := '0';
		phystatus	:	out	std_logic := '0';
		pipedata	:	out	std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
		prbsdone	:	out	std_logic := '0';
		prbserrlt	:	out	std_logic := '0';
		rdalign	:	out	std_logic_vector(1 downto 0) := "00";
		rdenableoutchnldown	:	out	std_logic := '0';
		rdenableoutchnlup	:	out	std_logic := '0';
		resetpcptrs	:	out	std_logic := '0';
		resetpcptrsinchnldownpipe	:	out	std_logic := '0';
		resetpcptrsinchnluppipe	:	out	std_logic := '0';
		resetpcptrsoutchnldown	:	out	std_logic := '0';
		resetpcptrsoutchnlup	:	out	std_logic := '0';
		resetppmcntrsoutchnldown	:	out	std_logic := '0';
		resetppmcntrsoutchnlup	:	out	std_logic := '0';
		resetppmcntrspcspma	:	out	std_logic := '0';
		parallelrevloopback	:	out	std_logic_vector(19 downto 0) := "00000000000000000000";
		runlengthviolation	:	out	std_logic := '0';
		rlvlt	:	out	std_logic := '0';
		runningdisparity	:	out	std_logic_vector(1 downto 0) := "00";
		rxblkstart	:	out	std_logic_vector(3 downto 0) := "0000";
		clocktopld	:	out	std_logic := '0';
		rxclkslip	:	out	std_logic := '0';
		rxdatavalid	:	out	std_logic_vector(3 downto 0) := "0000";
		rxdivsyncoutchnldown	:	out	std_logic_vector(1 downto 0) := "00";
		rxdivsyncoutchnlup	:	out	std_logic_vector(1 downto 0) := "00";
		rxpipeclk	:	out	std_logic := '0';
		rxpipesoftreset	:	out	std_logic := '0';
		rxsynchdr	:	out	std_logic_vector(1 downto 0) := "00";
		rxweoutchnldown	:	out	std_logic_vector(1 downto 0) := "00";
		rxweoutchnlup	:	out	std_logic_vector(1 downto 0) := "00";
		dataout	:	out	std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
		eidledetected	:	out	std_logic := '0';
		rxstatus	:	out	std_logic_vector(2 downto 0) := "000";
		rxvalid	:	out	std_logic := '0';
		selftestdone	:	out	std_logic := '0';
		selftesterr	:	out	std_logic := '0';
		signaldetectout	:	out	std_logic := '0';
		speedchange	:	out	std_logic := '0';
		speedchangeinchnldownpipe	:	out	std_logic := '0';
		speedchangeinchnluppipe	:	out	std_logic := '0';
		speedchangeoutchnldown	:	out	std_logic := '0';
		speedchangeoutchnlup	:	out	std_logic := '0';
		syncstatus	:	out	std_logic := '0';
		wordalignboundary	:	out	std_logic_vector(4 downto 0) := "00000";
		wrenableoutchnldown	:	out	std_logic := '0';
		wrenableoutchnlup	:	out	std_logic := '0';
		syncdatain	:	out	std_logic := '0';
		observablebyteserdesclock	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_8g_tx_pcs
	generic
(
		enable_debug_info	:	string	:=	"false";
		prot_mode	:	string	:=	"basic";
		hip_mode	:	string	:=	"dis_hip";
		pma_dw	:	string	:=	"eight_bit";
		pcs_bypass	:	string	:=	"dis_pcs_bypass";
		phase_compensation_fifo	:	string	:=	"low_latency";
		tx_compliance_controlled_disparity	:	string	:=	"dis_txcompliance";
		force_kchar	:	string	:=	"dis_force_kchar";
		force_echar	:	string	:=	"dis_force_echar";
		byte_serializer	:	string	:=	"dis_bs";
		data_selection_8b10b_encoder_input	:	string	:=	"normal_data_path";
		eightb_tenb_disp_ctrl	:	string	:=	"dis_disp_ctrl";
		eightb_tenb_encoder	:	string	:=	"dis_8b10b";
		prbs_gen	:	string	:=	"dis_prbs";
		cid_pattern	:	string	:=	"cid_pattern_0";
		cid_pattern_len	:	bit_vector	:=	B"0";
		bist_gen	:	string	:=	"dis_bist";
		bit_reversal	:	string	:=	"dis_bit_reversal";
		symbol_swap	:	string	:=	"dis_symbol_swap";
		polarity_inversion	:	string	:=	"dis_polinv";
		tx_bitslip	:	string	:=	"dis_tx_bitslip";
		agg_block_sel	:	string	:=	"same_smrt_pack";
		revloop_back_rm	:	string	:=	"dis_rev_loopback_rx_rm";
		phfifo_write_clk_sel	:	string	:=	"pld_tx_clk";
		ctrl_plane_bonding_consumption	:	string	:=	"individual";
		bypass_pipeline_reg	:	string	:=	"dis_bypass_pipeline";
		ctrl_plane_bonding_distribution	:	string	:=	"not_master_chnl_distr";
		test_mode	:	string	:=	"prbs";
		ctrl_plane_bonding_compensation	:	string	:=	"dis_compensation";
		refclk_b_clk_sel	:	string	:=	"tx_pma_clock";
		auto_speed_nego_gen2	:	string	:=	"dis_asn_g2";
		txpcs_urst	:	string	:=	"en_txpcs_urst";
		clock_gate_dw_fifowr	:	string	:=	"dis_dw_fifowr_clk_gating";
		clock_gate_prbs	:	string	:=	"dis_prbs_clk_gating";
		txclk_freerun	:	string	:=	"dis_freerun_tx";
		clock_gate_bs_enc	:	string	:=	"dis_bs_enc_clk_gating";
		clock_gate_bist	:	string	:=	"dis_bist_clk_gating";
		clock_gate_fiford	:	string	:=	"dis_fiford_clk_gating";
		pcfifo_urst	:	string	:=	"dis_pcfifourst";
		clock_gate_sw_fifowr	:	string	:=	"dis_sw_fifowr_clk_gating";
		sup_mode	:	string	:=	"user_mode";
		dynamic_clk_switch	:	string	:=	"dis_dyn_clk_switch";
		channel_number	:	integer	:=	0;
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		dispcbyte	:	in	std_logic := '0';
		elecidleinfersel	:	in	std_logic_vector(2 downto 0) := "000";
		fifoselectinchnldown	:	in	std_logic_vector(1 downto 0) := "00";
		fifoselectinchnlup	:	in	std_logic_vector(1 downto 0) := "00";
		rateswitch	:	in	std_logic := '0';
		hrdrst	:	in	std_logic := '1';
		pipetxdeemph	:	in	std_logic := '0';
		pipetxmargin	:	in	std_logic_vector(2 downto 0) := "000";
		phfiforeset	:	in	std_logic := '0';
		coreclk	:	in	std_logic := '0';
		polinvrxin	:	in	std_logic := '0';
		invpol	:	in	std_logic := '0';
		powerdn	:	in	std_logic_vector(1 downto 0) := "00";
		prbscidenable	:	in	std_logic := '0';
		rdenableinchnldown	:	in	std_logic := '0';
		rdenableinchnlup	:	in	std_logic := '0';
		phfiforddisable	:	in	std_logic := '0';
		refclkdig	:	in	std_logic := '0';
		resetpcptrs	:	in	std_logic := '0';
		resetpcptrsinchnldown	:	in	std_logic := '0';
		resetpcptrsinchnlup	:	in	std_logic := '0';
		revparallellpbkdata	:	in	std_logic_vector(19 downto 0) := "00000000000000000000";
		enrevparallellpbk	:	in	std_logic := '0';
		pipeenrevparallellpbkin	:	in	std_logic := '0';
		rxpolarityin	:	in	std_logic := '0';
		scanmode	:	in	std_logic := '0';
		txblkstart	:	in	std_logic_vector(3 downto 0) := "0000";
		bitslipboundaryselect	:	in	std_logic_vector(4 downto 0) := "00000";
		xgmctrl	:	in	std_logic := '0';
		xgmctrltoporbottom	:	in	std_logic := '0';
		xgmdatain	:	in	std_logic_vector(7 downto 0) := "00000000";
		xgmdataintoporbottom	:	in	std_logic_vector(7 downto 0) := "00000000";
		txdatavalid	:	in	std_logic_vector(3 downto 0) := "0000";
		txdivsyncinchnldown	:	in	std_logic_vector(1 downto 0) := "00";
		txdivsyncinchnlup	:	in	std_logic_vector(1 downto 0) := "00";
		txsynchdr	:	in	std_logic_vector(1 downto 0) := "00";
		datain	:	in	std_logic_vector(43 downto 0) := "00000000000000000000000000000000000000000000";
		detectrxloopin	:	in	std_logic := '0';
		txpmalocalclk	:	in	std_logic := '0';
		pipetxswing	:	in	std_logic := '0';
		txpcsreset	:	in	std_logic := '0';
		wrenableinchnldown	:	in	std_logic := '0';
		wrenableinchnlup	:	in	std_logic := '0';
		phfifowrenable	:	in	std_logic := '0';
		aggtxpcsrst	:	out	std_logic := '0';
		dynclkswitchn	:	out	std_logic := '0';
		phfifounderflow	:	out	std_logic := '0';
		fifoselectoutchnldown	:	out	std_logic_vector(1 downto 0) := "00";
		fifoselectoutchnlup	:	out	std_logic_vector(1 downto 0) := "00";
		phfifooverflow	:	out	std_logic := '0';
		grayelecidleinferselout	:	out	std_logic_vector(2 downto 0) := "000";
		phfifotxdeemph	:	out	std_logic := '0';
		phfifotxmargin	:	out	std_logic_vector(2 downto 0) := "000";
		phfifotxswing	:	out	std_logic := '0';
		polinvrxout	:	out	std_logic := '0';
		pipepowerdownout	:	out	std_logic_vector(1 downto 0) := "00";
		dataout	:	out	std_logic_vector(19 downto 0) := "00000000000000000000";
		rdenableoutchnldown	:	out	std_logic := '0';
		rdenableoutchnlup	:	out	std_logic := '0';
		rdenablesync	:	out	std_logic := '0';
		refclkb	:	out	std_logic := '0';
		refclkbreset	:	out	std_logic := '0';
		pipeenrevparallellpbkout	:	out	std_logic := '0';
		rxpolarityout	:	out	std_logic := '0';
		txblkstartout	:	out	std_logic_vector(3 downto 0) := "0000";
		clkout	:	out	std_logic := '0';
		xgmctrlenable	:	out	std_logic := '0';
		txctrlplanetestbus	:	out	std_logic_vector(19 downto 0) := "00000000000000000000";
		txdataouttogen3	:	out	std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
		xgmdataout	:	out	std_logic_vector(7 downto 0) := "00000000";
		txdatavalidouttogen3	:	out	std_logic_vector(3 downto 0) := "0000";
		txdatakouttogen3	:	out	std_logic_vector(3 downto 0) := "0000";
		txdivsync	:	out	std_logic_vector(1 downto 0) := "00";
		txdivsyncoutchnldown	:	out	std_logic_vector(1 downto 0) := "00";
		txdivsyncoutchnlup	:	out	std_logic_vector(1 downto 0) := "00";
		txpipeclk	:	out	std_logic := '0';
		txpipeelectidle	:	out	std_logic := '0';
		txpipesoftreset	:	out	std_logic := '0';
		txsynchdrout	:	out	std_logic_vector(1 downto 0) := "00";
		txtestbus	:	out	std_logic_vector(19 downto 0) := "00000000000000000000";
		txcomplianceout	:	out	std_logic := '0';
		detectrxloopout	:	out	std_logic := '0';
		txelecidleout	:	out	std_logic := '0';
		parallelfdbkout	:	out	std_logic_vector(19 downto 0) := "00000000000000000000";
		wrenableoutchnldown	:	out	std_logic := '0';
		wrenableoutchnlup	:	out	std_logic := '0';
		syncdatain	:	out	std_logic := '0';
		observablebyteserdesclock	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '1';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_avmm_interface
	generic
(
		num_ch0_atoms	:	integer	:=	0;
		num_ch1_atoms	:	integer	:=	0;
		num_ch2_atoms	:	integer	:=	0
	);
	port	(
		avmmrstn	:	in	std_logic := '0';
		avmmclk	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	in	std_logic_vector(89 downto 0) := "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
		readdatachnl	:	in	std_logic_vector(1439 downto 0) := "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		clkchnl	:	out	std_logic := '0';
		rstnchnl	:	out	std_logic := '0';
		writedatachnl	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		regaddrchnl	:	out	std_logic_vector(10 downto 0) := "00000000000";
		writechnl	:	out	std_logic := '0';
		readchnl	:	out	std_logic := '0';
		byteenchnl	:	out	std_logic_vector(1 downto 0) := "00";
		refclkdig	:	in	std_logic := '0';
		avmmreservedin	:	in	std_logic := '0';
		avmmreservedout	:	out	std_logic := '0';
		dpriorstntop	:	out	std_logic := '0';
		dprioclktop	:	out	std_logic := '0';
		mdiodistopchnl	:	out	std_logic := '0';
		dpriorstnmid	:	out	std_logic := '0';
		dprioclkmid	:	out	std_logic := '0';
		mdiodismidchnl	:	out	std_logic := '0';
		dpriorstnbot	:	out	std_logic := '0';
		dprioclkbot	:	out	std_logic := '0';
		mdiodisbotchnl	:	out	std_logic := '0';
		dpriotestsitopchnl	:	out	std_logic_vector(3 downto 0) := "0000";
		dpriotestsimidchnl	:	out	std_logic_vector(3 downto 0) := "0000";
		dpriotestsibotchnl	:	out	std_logic_vector(3 downto 0) := "0000";
		pmatestbussel	:	in	std_logic_vector(11 downto 0) := "000000000000";
		pmatestbus	:	out	std_logic_vector(23 downto 0) := "000000000000000000000000";
		scanmoden	:	in	std_logic := '0';
		scanshiftn	:	in	std_logic := '0';
		interfacesel	:	in	std_logic := '0';
		sershiftload	:	in	std_logic := '0'
	);
end component;

component	cyclonev_hssi_common_pcs_pma_interface
	generic
(
		enable_debug_info	:	string	:=	"false";
		prot_mode	:	string	:=	"disabled_prot_mode";
		force_freqdet	:	string	:=	"force_freqdet_dis";
		ppmsel	:	string	:=	"ppmsel_default";
		ppm_cnt_rst	:	string	:=	"ppm_cnt_rst_dis";
		auto_speed_ena	:	string	:=	"dis_auto_speed_ena";
		ppm_gen1_2_cnt	:	string	:=	"cnt_32k";
		ppm_post_eidle_delay	:	string	:=	"cnt_200_cycles";
		func_mode	:	string	:=	"disable";
		pma_if_dft_val	:	string	:=	"dft_0";
		sup_mode	:	string	:=	"user_mode";
		selectpcs	:	string	:=	"eight_g_pcs";
		ppm_deassert_early	:	string	:=	"deassert_early_dis";
		pipe_if_g3pcs	:	string	:=	"pipe_if_8gpcs";
		pma_if_dft_en	:	string	:=	"dft_dis";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		aggalignstatus	:	in	std_logic := '0';
		aggalignstatussync0	:	in	std_logic := '0';
		aggalignstatussync0toporbot	:	in	std_logic := '0';
		aggalignstatustoporbot	:	in	std_logic := '0';
		aggcgcomprddall	:	in	std_logic := '0';
		aggcgcomprddalltoporbot	:	in	std_logic := '0';
		aggcgcompwrall	:	in	std_logic := '0';
		aggcgcompwralltoporbot	:	in	std_logic := '0';
		aggdelcondmet0	:	in	std_logic := '0';
		aggdelcondmet0toporbot	:	in	std_logic := '0';
		aggendskwqd	:	in	std_logic := '0';
		aggendskwqdtoporbot	:	in	std_logic := '0';
		aggendskwrdptrs	:	in	std_logic := '0';
		aggendskwrdptrstoporbot	:	in	std_logic := '0';
		aggfifoovr0	:	in	std_logic := '0';
		aggfifoovr0toporbot	:	in	std_logic := '0';
		aggfifordincomp0	:	in	std_logic := '0';
		aggfifordincomp0toporbot	:	in	std_logic := '0';
		aggfiforstrdqd	:	in	std_logic := '0';
		aggfiforstrdqdtoporbot	:	in	std_logic := '0';
		agginsertincomplete0	:	in	std_logic := '0';
		agginsertincomplete0toporbot	:	in	std_logic := '0';
		agglatencycomp0	:	in	std_logic := '0';
		agglatencycomp0toporbot	:	in	std_logic := '0';
		aggrcvdclkagg	:	in	std_logic := '0';
		aggrcvdclkaggtoporbot	:	in	std_logic := '0';
		aggrxcontrolrs	:	in	std_logic := '0';
		aggrxcontrolrstoporbot	:	in	std_logic := '0';
		aggrxdatars	:	in	std_logic_vector(7 downto 0) := "00000000";
		aggrxdatarstoporbot	:	in	std_logic_vector(7 downto 0) := "00000000";
		aggtestsotopldin	:	in	std_logic := '0';
		aggtestbus	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		aggtxctlts	:	in	std_logic := '0';
		aggtxctltstoporbot	:	in	std_logic := '0';
		aggtxdatats	:	in	std_logic_vector(7 downto 0) := "00000000";
		aggtxdatatstoporbot	:	in	std_logic_vector(7 downto 0) := "00000000";
		hardreset	:	in	std_logic := '0';
		pcs8gearlyeios	:	in	std_logic := '0';
		pcs8geidleexit	:	in	std_logic := '0';
		pcs8gltrpma	:	in	std_logic := '0';
		pcs8gpcieswitch	:	in	std_logic := '0';
		pcs8gpmacurrentcoeff	:	in	std_logic_vector(17 downto 0) := "000000000000000000";
		pcs8gtxelecidle	:	in	std_logic := '0';
		pcs8gtxdetectrx	:	in	std_logic := '0';
		pcsaggaligndetsync	:	in	std_logic_vector(1 downto 0) := "00";
		pcsaggalignstatussync	:	in	std_logic := '0';
		pcsaggcgcomprddout	:	in	std_logic_vector(1 downto 0) := "00";
		pcsaggcgcompwrout	:	in	std_logic_vector(1 downto 0) := "00";
		pcsaggdecctl	:	in	std_logic := '0';
		pcsaggdecdata	:	in	std_logic_vector(7 downto 0) := "00000000";
		pcsaggdecdatavalid	:	in	std_logic := '0';
		pcsaggdelcondmetout	:	in	std_logic := '0';
		pcsaggfifoovrout	:	in	std_logic := '0';
		pcsaggfifordoutcomp	:	in	std_logic := '0';
		pcsagginsertincompleteout	:	in	std_logic := '0';
		pcsagglatencycompout	:	in	std_logic := '0';
		pcsaggrdalign	:	in	std_logic_vector(1 downto 0) := "00";
		pcsaggrdenablesync	:	in	std_logic := '0';
		pcsaggrefclkdig	:	in	std_logic := '0';
		pcsaggrunningdisp	:	in	std_logic_vector(1 downto 0) := "00";
		pcsaggrxpcsrst	:	in	std_logic := '0';
		pcsaggscanmoden	:	in	std_logic := '0';
		pcsaggscanshiftn	:	in	std_logic := '0';
		pcsaggsyncstatus	:	in	std_logic := '0';
		pcsaggtxctltc	:	in	std_logic := '0';
		pcsaggtxdatatc	:	in	std_logic_vector(7 downto 0) := "00000000";
		pcsaggtxpcsrst	:	in	std_logic := '0';
		pcsrefclkdig	:	in	std_logic := '0';
		pcsscanmoden	:	in	std_logic := '0';
		pcsscanshiftn	:	in	std_logic := '0';
		pldnfrzdrv	:	in	std_logic := '0';
		pldpartialreconfig	:	in	std_logic := '0';
		pldtestsitoaggin	:	in	std_logic := '0';
		clklow	:	in	std_logic := '0';
		fref	:	in	std_logic := '0';
		pmahclk	:	in	std_logic := '0';
		pmapcieswdone	:	in	std_logic_vector(1 downto 0) := "00";
		pmarxdetectvalid	:	in	std_logic := '0';
		pmarxfound	:	in	std_logic := '0';
		pmarxpmarstb	:	in	std_logic := '0';
		resetppmcntrs	:	in	std_logic := '0';
		aggaligndetsync	:	out	std_logic_vector(1 downto 0) := "00";
		aggalignstatussync	:	out	std_logic := '0';
		aggcgcomprddout	:	out	std_logic_vector(1 downto 0) := "00";
		aggcgcompwrout	:	out	std_logic_vector(1 downto 0) := "00";
		aggdecctl	:	out	std_logic := '0';
		aggdecdata	:	out	std_logic_vector(7 downto 0) := "00000000";
		aggdecdatavalid	:	out	std_logic := '0';
		aggdelcondmetout	:	out	std_logic := '0';
		aggfifoovrout	:	out	std_logic := '0';
		aggfifordoutcomp	:	out	std_logic := '0';
		agginsertincompleteout	:	out	std_logic := '0';
		agglatencycompout	:	out	std_logic := '0';
		aggrdalign	:	out	std_logic_vector(1 downto 0) := "00";
		aggrdenablesync	:	out	std_logic := '0';
		aggrefclkdig	:	out	std_logic := '0';
		aggrunningdisp	:	out	std_logic_vector(1 downto 0) := "00";
		aggrxpcsrst	:	out	std_logic := '0';
		aggscanmoden	:	out	std_logic := '0';
		aggscanshiftn	:	out	std_logic := '0';
		aggsyncstatus	:	out	std_logic := '0';
		aggtestsotopldout	:	out	std_logic := '0';
		aggtxctltc	:	out	std_logic := '0';
		aggtxdatatc	:	out	std_logic_vector(7 downto 0) := "00000000";
		aggtxpcsrst	:	out	std_logic := '0';
		pcs8ggen2ngen1	:	out	std_logic := '0';
		pcs8gpmarxfound	:	out	std_logic := '0';
		pcs8gpowerstatetransitiondone	:	out	std_logic := '0';
		pcs8grxdetectvalid	:	out	std_logic := '0';
		pcsaggalignstatus	:	out	std_logic := '0';
		pcsaggalignstatussync0	:	out	std_logic := '0';
		pcsaggalignstatussync0toporbot	:	out	std_logic := '0';
		pcsaggalignstatustoporbot	:	out	std_logic := '0';
		pcsaggcgcomprddall	:	out	std_logic := '0';
		pcsaggcgcomprddalltoporbot	:	out	std_logic := '0';
		pcsaggcgcompwrall	:	out	std_logic := '0';
		pcsaggcgcompwralltoporbot	:	out	std_logic := '0';
		pcsaggdelcondmet0	:	out	std_logic := '0';
		pcsaggdelcondmet0toporbot	:	out	std_logic := '0';
		pcsaggendskwqd	:	out	std_logic := '0';
		pcsaggendskwqdtoporbot	:	out	std_logic := '0';
		pcsaggendskwrdptrs	:	out	std_logic := '0';
		pcsaggendskwrdptrstoporbot	:	out	std_logic := '0';
		pcsaggfifoovr0	:	out	std_logic := '0';
		pcsaggfifoovr0toporbot	:	out	std_logic := '0';
		pcsaggfifordincomp0	:	out	std_logic := '0';
		pcsaggfifordincomp0toporbot	:	out	std_logic := '0';
		pcsaggfiforstrdqd	:	out	std_logic := '0';
		pcsaggfiforstrdqdtoporbot	:	out	std_logic := '0';
		pcsagginsertincomplete0	:	out	std_logic := '0';
		pcsagginsertincomplete0toporbot	:	out	std_logic := '0';
		pcsagglatencycomp0	:	out	std_logic := '0';
		pcsagglatencycomp0toporbot	:	out	std_logic := '0';
		pcsaggrcvdclkagg	:	out	std_logic := '0';
		pcsaggrcvdclkaggtoporbot	:	out	std_logic := '0';
		pcsaggrxcontrolrs	:	out	std_logic := '0';
		pcsaggrxcontrolrstoporbot	:	out	std_logic := '0';
		pcsaggrxdatars	:	out	std_logic_vector(7 downto 0) := "00000000";
		pcsaggrxdatarstoporbot	:	out	std_logic_vector(7 downto 0) := "00000000";
		pcsaggtestbus	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		pcsaggtxctlts	:	out	std_logic := '0';
		pcsaggtxctltstoporbot	:	out	std_logic := '0';
		pcsaggtxdatats	:	out	std_logic_vector(7 downto 0) := "00000000";
		pcsaggtxdatatstoporbot	:	out	std_logic_vector(7 downto 0) := "00000000";
		pldhclkout	:	out	std_logic := '0';
		pldtestsitoaggout	:	out	std_logic := '0';
		pmaclklowout	:	out	std_logic := '0';
		pmacurrentcoeff	:	out	std_logic_vector(17 downto 0) := "000000000000000000";
		pmaearlyeios	:	out	std_logic := '0';
		pmafrefout	:	out	std_logic := '0';
		pmaiftestbus	:	out	std_logic_vector(9 downto 0) := "0000000000";
		pmaltr	:	out	std_logic := '0';
		pmanfrzdrv	:	out	std_logic := '0';
		pmapartialreconfig	:	out	std_logic := '0';
		pmapcieswitch	:	out	std_logic_vector(1 downto 0) := "00";
		freqlock	:	out	std_logic := '0';
		pmatxelecidle	:	out	std_logic := '0';
		pmatxdetectrx	:	out	std_logic := '0';
		asynchdatain	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_common_pld_pcs_interface
	generic
(
		enable_debug_info	:	string	:=	"false";
		hip_enable	:	string	:=	"hip_disable";
		hrdrstctrl_en_cfgusr	:	string	:=	"hrst_dis_cfgusr";
		pld_side_reserved_source10	:	string	:=	"pld_res10";
		pld_side_data_source	:	string	:=	"pld";
		pld_side_reserved_source0	:	string	:=	"pld_res0";
		pld_side_reserved_source1	:	string	:=	"pld_res1";
		pld_side_reserved_source2	:	string	:=	"pld_res2";
		pld_side_reserved_source3	:	string	:=	"pld_res3";
		pld_side_reserved_source4	:	string	:=	"pld_res4";
		pld_side_reserved_source5	:	string	:=	"pld_res5";
		pld_side_reserved_source6	:	string	:=	"pld_res6";
		pld_side_reserved_source7	:	string	:=	"pld_res7";
		pld_side_reserved_source8	:	string	:=	"pld_res8";
		pld_side_reserved_source9	:	string	:=	"pld_res9";
		hrdrstctrl_en_cfg	:	string	:=	"hrst_dis_cfg";
		testbus_sel	:	string	:=	"eight_g_pcs";
		usrmode_sel4rst	:	string	:=	"usermode";
		pld_side_reserved_source11	:	string	:=	"pld_res11";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		emsipcomin	:	in	std_logic_vector(37 downto 0) := "00000000000000000000000000000000000000";
		pcs8gchnltestbusout	:	in	std_logic_vector(19 downto 0) := "00000000000000000000";
		pcs8gphystatus	:	in	std_logic := '0';
		pcs8gpldextraout	:	in	std_logic_vector(2 downto 0) := "000";
		pcs8grxelecidle	:	in	std_logic := '0';
		pcs8grxstatus	:	in	std_logic_vector(2 downto 0) := "000";
		pcs8grxvalid	:	in	std_logic := '0';
		pcs8gtestso	:	in	std_logic_vector(5 downto 0) := "000000";
		pcsaggtestso	:	in	std_logic := '0';
		pcspmaiftestso	:	in	std_logic := '0';
		pcspmaiftestbusout	:	in	std_logic_vector(9 downto 0) := "0000000000";
		pld8gpowerdown	:	in	std_logic_vector(1 downto 0) := "00";
		pld8gprbsciden	:	in	std_logic := '0';
		pld8grefclkdig	:	in	std_logic := '0';
		pld8grefclkdig2	:	in	std_logic := '0';
		pld8grxpolarity	:	in	std_logic := '0';
		pld8gtxdeemph	:	in	std_logic := '0';
		pld8gtxdetectrxloopback	:	in	std_logic := '0';
		pld8gtxelecidle	:	in	std_logic := '0';
		pld8gtxmargin	:	in	std_logic_vector(2 downto 0) := "000";
		pld8gtxswing	:	in	std_logic := '0';
		pldaggrefclkdig	:	in	std_logic := '0';
		pldeidleinfersel	:	in	std_logic_vector(2 downto 0) := "000";
		pldhclkin	:	in	std_logic := '0';
		pldltr	:	in	std_logic := '0';
		pldpartialreconfigin	:	in	std_logic := '0';
		pldpcspmaifrefclkdig	:	in	std_logic := '0';
		pldrate	:	in	std_logic := '0';
		pldreservedin	:	in	std_logic_vector(11 downto 0) := "000000000000";
		pldscanmoden	:	in	std_logic := '0';
		pldscanshiftn	:	in	std_logic := '0';
		pmaclklow	:	in	std_logic := '0';
		pmafref	:	in	std_logic := '0';
		emsipcomclkout	:	out	std_logic_vector(2 downto 0) := "000";
		emsipcomout	:	out	std_logic_vector(26 downto 0) := "000000000000000000000000000";
		emsipenablediocsrrdydly	:	out	std_logic := '0';
		pcs8geidleinfersel	:	out	std_logic_vector(2 downto 0) := "000";
		pcs8ghardreset	:	out	std_logic := '0';
		pcs8gltr	:	out	std_logic := '0';
		pcs8gpldextrain	:	out	std_logic_vector(3 downto 0) := "0000";
		pcs8gpowerdown	:	out	std_logic_vector(1 downto 0) := "00";
		pcs8gprbsciden	:	out	std_logic := '0';
		pcs8grate	:	out	std_logic := '0';
		pcs8grefclkdig	:	out	std_logic := '0';
		pcs8grefclkdig2	:	out	std_logic := '0';
		pcs8grxpolarity	:	out	std_logic := '0';
		pcs8gscanmoden	:	out	std_logic := '0';
		pcs8gscanshift	:	out	std_logic := '0';
		pcs8gtestsi	:	out	std_logic_vector(5 downto 0) := "000000";
		pcs8gtxdeemph	:	out	std_logic := '0';
		pcs8gtxdetectrxloopback	:	out	std_logic := '0';
		pcs8gtxelecidle	:	out	std_logic := '0';
		pcs8gtxmargin	:	out	std_logic_vector(2 downto 0) := "000";
		pcs8gtxswing	:	out	std_logic := '0';
		pcsaggrefclkdig	:	out	std_logic := '0';
		pcsaggscanmoden	:	out	std_logic := '0';
		pcsaggscanshift	:	out	std_logic := '0';
		pcsaggtestsi	:	out	std_logic := '0';
		pcspcspmaifrefclkdig	:	out	std_logic := '0';
		pcspcspmaifscanmoden	:	out	std_logic := '0';
		pcspcspmaifscanshiftn	:	out	std_logic := '0';
		pcspmaifhardreset	:	out	std_logic := '0';
		pcspmaiftestsi	:	out	std_logic := '0';
		pld8gphystatus	:	out	std_logic := '0';
		pld8grxelecidle	:	out	std_logic := '0';
		pld8grxstatus	:	out	std_logic_vector(2 downto 0) := "000";
		pld8grxvalid	:	out	std_logic := '0';
		pldclklow	:	out	std_logic := '0';
		pldfref	:	out	std_logic := '0';
		pldnfrzdrv	:	out	std_logic := '0';
		pldpartialreconfigout	:	out	std_logic := '0';
		pldreservedout	:	out	std_logic_vector(10 downto 0) := "00000000000";
		pldtestdata	:	out	std_logic_vector(19 downto 0) := "00000000000000000000";
		rstsel	:	out	std_logic := '0';
		usrrstsel	:	out	std_logic := '0';
		asynchdatain	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmrstn	:	in	std_logic := '0';
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_pipe_gen1_2
	generic
(
		enable_debug_info	:	string	:=	"false";
		prot_mode	:	string	:=	"pipe_g1";
		hip_mode	:	string	:=	"dis_hip";
		tx_pipe_enable	:	string	:=	"dis_pipe_tx";
		rx_pipe_enable	:	string	:=	"dis_pipe_rx";
		pipe_byte_de_serializer_en	:	string	:=	"dont_care_bds";
		txswing	:	string	:=	"dis_txswing";
		rxdetect_bypass	:	string	:=	"dis_rxdetect_bypass";
		error_replace_pad	:	string	:=	"replace_edb";
		ind_error_reporting	:	string	:=	"dis_ind_error_reporting";
		phystatus_rst_toggle	:	string	:=	"dis_phystatus_rst_toggle";
		elecidle_delay	:	string	:=	"elec_idle_delay";
		elec_idle_delay_val	:	bit_vector	:=	B"0";
		phy_status_delay	:	string	:=	"phystatus_delay";
		phystatus_delay_val	:	bit_vector	:=	B"0";
		rvod_sel_d_val	:	bit_vector	:=	B"0";
		rpre_emph_b_val	:	bit_vector	:=	B"0";
		rvod_sel_c_val	:	bit_vector	:=	B"0";
		rpre_emph_c_val	:	bit_vector	:=	B"0";
		rpre_emph_settings	:	bit_vector	:=	B"0";
		rvod_sel_a_val	:	bit_vector	:=	B"0";
		rpre_emph_d_val	:	bit_vector	:=	B"0";
		rvod_sel_settings	:	bit_vector	:=	B"0";
		rvod_sel_b_val	:	bit_vector	:=	B"0";
		rpre_emph_e_val	:	bit_vector	:=	B"0";
		sup_mode	:	string	:=	"user_mode";
		rvod_sel_e_val	:	bit_vector	:=	B"0";
		rpre_emph_a_val	:	bit_vector	:=	B"0";
		ctrl_plane_bonding_consumption	:	string	:=	"individual";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		pcieswitch	:	in	std_logic := '0';
		piperxclk	:	in	std_logic := '0';
		pipetxclk	:	in	std_logic := '0';
		polinvrx	:	in	std_logic := '0';
		powerstatetransitiondone	:	in	std_logic := '0';
		powerstatetransitiondoneena	:	in	std_logic := '0';
		powerdown	:	in	std_logic_vector(1 downto 0) := "00";
		refclkb	:	in	std_logic := '0';
		refclkbreset	:	in	std_logic := '0';
		revloopbkpcsgen3	:	in	std_logic := '0';
		revloopback	:	in	std_logic := '0';
		rxdetectvalid	:	in	std_logic := '0';
		rxfound	:	in	std_logic := '0';
		rxpipereset	:	in	std_logic := '0';
		rxd	:	in	std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
		rxelectricalidle	:	in	std_logic := '0';
		rxpolarity	:	in	std_logic := '0';
		sigdetni	:	in	std_logic := '0';
		speedchange	:	in	std_logic := '0';
		speedchangechnldown	:	in	std_logic := '0';
		speedchangechnlup	:	in	std_logic := '0';
		txelecidlecomp	:	in	std_logic := '0';
		txpipereset	:	in	std_logic := '0';
		txdch	:	in	std_logic_vector(43 downto 0) := "00000000000000000000000000000000000000000000";
		txdeemph	:	in	std_logic := '0';
		txdetectrxloopback	:	in	std_logic := '0';
		txelecidlein	:	in	std_logic := '0';
		txmargin	:	in	std_logic_vector(2 downto 0) := "000";
		txswingport	:	in	std_logic := '0';
		currentcoeff	:	out	std_logic_vector(17 downto 0) := "000000000000000000";
		phystatus	:	out	std_logic := '0';
		polinvrxint	:	out	std_logic := '0';
		revloopbk	:	out	std_logic := '0';
		rxdch	:	out	std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
		rxelecidle	:	out	std_logic := '0';
		rxelectricalidleout	:	out	std_logic := '0';
		rxstatus	:	out	std_logic_vector(2 downto 0) := "000";
		rxvalid	:	out	std_logic := '0';
		speedchangeout	:	out	std_logic := '0';
		txelecidleout	:	out	std_logic := '0';
		txd	:	out	std_logic_vector(43 downto 0) := "00000000000000000000000000000000000000000000";
		txdetectrx	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_pma_aux
	generic
(
		enable_debug_info	:	string	:=	"false";
		cal_clk_sel	:	string	:=	"pm_aux_iqclk_cal_clk_sel_cal_clk";
		cal_result_status	:	string	:=	"pm_aux_result_status_tx";
		continuous_calibration	:	string	:=	"false";
		pm_aux_cal_clk_test_sel	:	string	:=	"false";
		rx_cal_override_value	:	integer	:=	0;
		rx_cal_override_value_enable	:	string	:=	"false";
		rx_imp	:	string	:=	"cal_imp_46_ohm";
		test_counter_enable	:	string	:=	"false";
		tx_cal_override_value	:	integer	:=	0;
		tx_cal_override_value_enable	:	string	:=	"false";
		tx_imp	:	string	:=	"cal_imp_48_ohm";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		atb0out	:	inout	std_logic := '0';
		atb1out	:	inout	std_logic := '0';
		calclk	:	in	std_logic := '0';
		calpdb	:	in	std_logic := '0';
		refiqclk	:	in	std_logic_vector(5 downto 0) := "000000";
		testcntl	:	in	std_logic := '0';
		nonusertoio	:	out	std_logic := '0';
		zrxtx50	:	out	std_logic_vector(4 downto 0) := "00000"
	);
end component;

component	cyclonev_hssi_pma_cdr_refclk_select_mux
	generic
(
		lpm_type	:	string	:=	"cyclonev_hssi_pma_cdr_refclk_select_mux";
		channel_number	:	integer	:=	0;
		mux_type	:	string	:=	"cdr_refclk_select_mux";
		refclk_select	:	string	:=	"ref_iqclk0";
		reference_clock_frequency	:	string	:=	"0 ps";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0;
		inclk0_logical_to_physical_mapping	:	string	:=	"";
		inclk1_logical_to_physical_mapping	:	string	:=	"";
		inclk2_logical_to_physical_mapping	:	string	:=	"";
		inclk3_logical_to_physical_mapping	:	string	:=	"";
		inclk4_logical_to_physical_mapping	:	string	:=	"";
		inclk5_logical_to_physical_mapping	:	string	:=	"";
		inclk6_logical_to_physical_mapping	:	string	:=	"";
		inclk7_logical_to_physical_mapping	:	string	:=	"";
		inclk8_logical_to_physical_mapping	:	string	:=	"";
		inclk9_logical_to_physical_mapping	:	string	:=	"";
		inclk10_logical_to_physical_mapping	:	string	:=	"";
		inclk11_logical_to_physical_mapping	:	string	:=	"";
		inclk12_logical_to_physical_mapping	:	string	:=	"";
		inclk13_logical_to_physical_mapping	:	string	:=	"";
		inclk14_logical_to_physical_mapping	:	string	:=	"";
		inclk15_logical_to_physical_mapping	:	string	:=	"";
		inclk16_logical_to_physical_mapping	:	string	:=	"";
		inclk17_logical_to_physical_mapping	:	string	:=	"";
		inclk18_logical_to_physical_mapping	:	string	:=	"";
		inclk19_logical_to_physical_mapping	:	string	:=	"";
		inclk20_logical_to_physical_mapping	:	string	:=	"";
		inclk21_logical_to_physical_mapping	:	string	:=	"";
		inclk22_logical_to_physical_mapping	:	string	:=	"";
		inclk23_logical_to_physical_mapping	:	string	:=	"";
		inclk24_logical_to_physical_mapping	:	string	:=	"";
		inclk25_logical_to_physical_mapping	:	string	:=	""
	);
	port	(
		calclk	:	in	std_logic := '0';
		refclklc:	in	std_logic := '0';
		occalen		:	in	std_logic := '0';
		ffplloutbot	:	in	std_logic := '0';
		ffpllouttop	:	in	std_logic := '0';
		pldclk	:	in	std_logic := '0';
		refiqclk0	:	in	std_logic := '0';
		refiqclk1	:	in	std_logic := '0';
		refiqclk10	:	in	std_logic := '0';
		refiqclk2	:	in	std_logic := '0';
		refiqclk3	:	in	std_logic := '0';
		refiqclk4	:	in	std_logic := '0';
		refiqclk5	:	in	std_logic := '0';
		refiqclk6	:	in	std_logic := '0';
		refiqclk7	:	in	std_logic := '0';
		refiqclk8	:	in	std_logic := '0';
		refiqclk9	:	in	std_logic := '0';
		rxiqclk0	:	in	std_logic := '0';
		rxiqclk1	:	in	std_logic := '0';
		rxiqclk10	:	in	std_logic := '0';
		rxiqclk2	:	in	std_logic := '0';
		rxiqclk3	:	in	std_logic := '0';
		rxiqclk4	:	in	std_logic := '0';
		rxiqclk5	:	in	std_logic := '0';
		rxiqclk6	:	in	std_logic := '0';
		rxiqclk7	:	in	std_logic := '0';
		rxiqclk8	:	in	std_logic := '0';
		rxiqclk9	:	in	std_logic := '0';
		avmmclk	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0';
		clkout	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_pma_hi_pmaif
	generic
(
		lpm_type	:	string	:=	"cyclonev_hssi_pma_hi_pmaif";
		tx_pma_direction_sel	:	string	:=	"pcs"
	);
	port	(
		datainfromcore	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		datainfrompcs	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		dataouttopma	:	out	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
	);
end component;

component	cyclonev_hssi_pma_hi_xcvrif
	generic
(
		lpm_type	:	string	:=	"cyclonev_hssi_pma_hi_xcvrif";
		rx_pma_direction_sel	:	string	:=	"pcs"
	);
	port	(
		datainfrompma	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		datainfrompcs	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		dataouttopld	:	out	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
	);
end component;

component	cyclonev_hssi_pma_int
	generic
(
		enable_debug_info	:	string	:=	"false";
		channel_number	:	integer	:=	0;
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0;
		cvp_mode	:	string	:=	"cvp_mode_off";
		early_eios_sel	:	string	:=	"pcs_early_eios";
		ffclk_enable	:	string	:=	"ffclk_off";
		iqtxrxclk_a_sel	:	string	:=	"tristage_outa";
		iqtxrxclk_b_sel	:	string	:=	"tristage_outb";
		ltr_sel	:	string	:=	"pcs_ltr";
		pcie_switch_sel	:	string	:=	"pcs_pcie_switch_sw";
		pclk_0_clk_sel	:	string	:=	"pclk_0_power_down";
		pclk_1_clk_sel	:	string	:=	"pclk_1_power_down";
		tx_elec_idle_sel	:	string	:=	"pcs_tx_elec_idle";
		txdetectrx_sel	:	string	:=	"pcs_txdetectrx"
	);
	port	(
		bslip	:	in	std_logic := '0';
		ccrurstb	:	in	std_logic := '0';
		cearlyeios	:	in	std_logic := '0';
		clkdivrxi	:	in	std_logic := '0';
		clkdivtxi	:	in	std_logic := '0';
		clklowi	:	in	std_logic := '0';
		cltd	:	in	std_logic := '0';
		cltr	:	in	std_logic := '0';
		cpcieswitch	:	in	std_logic := '0';
		crslpbk	:	in	std_logic := '0';
		ctxdetectrx	:	in	std_logic := '0';
		ctxelecidle	:	in	std_logic := '0';
		ctxpmarstb	:	in	std_logic := '0';
		earlyeios	:	in	std_logic := '0';
		frefi	:	in	std_logic := '0';
		hclkpcsi	:	in	std_logic := '0';
		icoeff	:	in	std_logic_vector(11 downto 0) := "000000000000";
		ltr	:	in	std_logic := '0';
		pcieswdonei	:	in	std_logic := '0';
		pcieswitch	:	in	std_logic := '0';
		pcsrxclkout	:	in	std_logic := '0';
		pcstxclkout	:	in	std_logic := '0';
		pfdmodelocki	:	in	std_logic := '0';
		pldclk	:	in	std_logic := '0';
		ppmlock	:	in	std_logic := '0';
		rxdetclk	:	in	std_logic := '0';
		rxdetectvalidi	:	in	std_logic := '0';
		rxfoundi	:	in	std_logic := '0';
		rxplllocki	:	in	std_logic := '0';
		rxpmarstb	:	in	std_logic := '0';
		sdi	:	in	std_logic := '0';
		testbusi	:	in	std_logic_vector(7 downto 0) := "00000000";
		testsel	:	in	std_logic_vector(3 downto 0) := "0000";
		txdetectrx	:	in	std_logic := '0';
		txelecidle	:	in	std_logic := '0';
		bslipo	:	out	std_logic := '0';
		clklow	:	out	std_logic := '0';
		cpcieswdone	:	out	std_logic := '0';
		cpclk	:	out	std_logic_vector(1 downto 0) := "00";
		cpfdmodelock	:	out	std_logic := '0';
		crurstbo	:	out	std_logic := '0';
		crxdetectvalid	:	out	std_logic := '0';
		crxfound	:	out	std_logic := '0';
		crxplllock	:	out	std_logic := '0';
		csd	:	out	std_logic := '0';
		earlyeioso	:	out	std_logic := '0';
		fref	:	out	std_logic := '0';
		hclkpcs	:	out	std_logic := '0';
		icoeffo	:	out	std_logic_vector(11 downto 0) := "000000000000";
		iqtxrxclka	:	out	std_logic := '0';
		iqtxrxclkb	:	out	std_logic := '0';
		ltdo	:	out	std_logic := '0';
		ltro	:	out	std_logic := '0';
		pcieswdone	:	out	std_logic := '0';
		pcieswitcho	:	out	std_logic := '0';
		pfdmodelock	:	out	std_logic := '0';
		pldclko	:	out	std_logic := '0';
		ppmlocko	:	out	std_logic := '0';
		rxdetclko	:	out	std_logic := '0';
		rxdetectvalid	:	out	std_logic := '0';
		rxfound	:	out	std_logic := '0';
		rxplllock	:	out	std_logic := '0';
		rxpmarstbo	:	out	std_logic := '0';
		sd	:	out	std_logic := '0';
		slpbko	:	out	std_logic := '0';
		testbus	:	out	std_logic_vector(7 downto 0) := "00000000";
		testselo	:	out	std_logic_vector(3 downto 0) := "0000";
		txdetectrxo	:	out	std_logic := '0';
		txelecidleo	:	out	std_logic := '0';
		txpmarstbo	:	out	std_logic := '0';
		avmmrstn	:	in	std_logic := '0';
		avmmclk	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_pma_rx_buf
	generic
(
		enable_debug_info	:	string	:=	"false";
		cdrclk_to_cgb	:	string	:=	"cdrclk_2cgb_dis";
		channel_number	:	integer	:=	0;
		diagnostic_loopback	:	string	:=	"diag_lpbk_off";
		pdb_sd	:	string	:=	"false";
		rx_dc_gain	:	integer	:=	0;
		sd_off	:	integer	:=	1;
		sd_on	:	integer	:=	1;
		sd_threshold	:	integer	:=	3;
		term_sel	:	string	:=	"100 ohms";
		vcm_current_add	:	string	:=	"vcm_current_1";
		vcm_sel	:	string	:=	"vtt_0p80v";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0;
		rx_sel_half_bw	:	string	:=	"full_bw";
		rx_acgain_a	:	string	:=	"aref_volt_0";
		rx_acgain_v	:	string	:=	"vref_volt_1p0";
		ct_equalizer_setting	:	integer	:=	0;
		reverse_loopback	:	string	:=	"reverse_lpbk_cdr"
	);
	port	(
		ck0sigdet	:	in	std_logic := '0';
		datain	:	in	std_logic := '0';
		hardoccalen	:	in	std_logic := '0';
		lpbkp	:	in	std_logic := '0';
		rstn	:	in	std_logic := '0';
		slpbk	:	in	std_logic := '0';
		dataout	:	out	std_logic := '0';
		nonuserfrompmaux	:	in	std_logic := '0';
		rdlpbkp	:	out	std_logic := '0';
		sd	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmrstn	:	in	std_logic := '0';
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_pma_rx_deser
	generic
(
		enable_debug_info	:	string	:=	"false";
		auto_negotiation	:	string	:=	"false";
		channel_number	:	integer	:=	0;
		clk_forward_only_mode	:	string	:=	"false";
		enable_bit_slip	:	string	:=	"true";
		mode	:	integer	:=	8;
		sdclk_enable	:	string	:=	"false";
		vco_bypass	:	string	:=	"vco_bypass_normal";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0;
		pma_direct	:	string	:=	"false"
	);
	port	(
		bslip	:	in	std_logic := '0';
		clk270b	:	in	std_logic := '0';
		clk90b	:	in	std_logic := '0';
		deven	:	in	std_logic := '0';
		dodd	:	in	std_logic := '0';
		pciesw	:	in	std_logic := '0';
		rstn	:	in	std_logic := '0';
		clkdivrx	:	out	std_logic := '0';
		clkdivrxrx	:	out	std_logic := '0';
		dout	:	out	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		pciel	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmrstn	:	in	std_logic := '0';
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_pma_tx_buf
	generic
(
		enable_debug_info	:	string	:=	"false";
		channel_number	:	integer	:=	0;
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0;
		common_mode_driver_sel	:	string	:=	"volt_0p65v";
		driver_resolution_ctrl	:	string	:=	"disabled";
		fir_coeff_ctrl_sel	:	string	:=	"ram_ctl";
		local_ib_ctl	:	string	:=	"ib_29ohm";
		lst	:	string	:=	"atb_disabled";
		pre_emp_switching_ctrl_1st_post_tap	:	integer	:=	0;
		rx_det	:	integer	:=	0;
		rx_det_pdb	:	string	:=	"false";
		slew_rate_ctrl	:	integer	:=	5;
		swing_boost	:	string	:=	"not_boost";
		term_sel	:	string	:=	"100 ohms";
		vcm_current_addl	:	string	:=	"vcm_current_1";
		vod_boost	:	string	:=	"not_boost";
		vod_switching_ctrl_main_tap	:	integer	:=	10;
		local_ib_en	:	string	:=	"no_local_ib";
		cml_en	:	string	:=	"no_cml";
		tx_powerdown	:	string	:=	"normal_tx_on"
	);
	port	(
		avgvon	:	in	std_logic := '0';
		avgvop	:	in	std_logic := '0';
		datain	:	in	std_logic := '0';
		icoeff	:	in	std_logic_vector(11 downto 0) := "000000000000";
		rxdetclk	:	in	std_logic := '0';
		txdetrx	:	in	std_logic := '0';
		txelecidl	:	in	std_logic := '0';
		vrlpbkn	:	in	std_logic := '0';
		vrlpbkn1t	:	in	std_logic := '0';
		vrlpbkp	:	in	std_logic := '0';
		vrlpbkp1t	:	in	std_logic := '0';
		compass	:	out	std_logic := '0';
		dataout	:	out	std_logic := '0';
		detecton	:	out	std_logic_vector(1 downto 0) := "00";
		fixedclkout	:	out	std_logic := '0';
		nonuserfrompmaux	:	in	std_logic := '0';
		probepass	:	out	std_logic := '0';
		rxdetectvalid	:	out	std_logic := '0';
		rxfound	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_pma_tx_cgb
	generic
(
		enable_debug_info	:	string	:=	"false";
		auto_negotiation	:	string	:=	"false";
		cgb_iqclk_sel	:	string	:=	"tristate";
		cgb_sync	:	string	:=	"normal";
		channel_number	:	integer	:=	0;
		clk_mute	:	string	:=	"disable_clockmute";
		data_rate	:	string	:=	"";
		mode	:	integer	:=	8;
		reset_scheme	:	string	:=	"counter_reset_disable";
		tx_mux_power_down	:	string	:=	"normal";
		x1_clock_source_sel	:	string	:=	"x1_clk_unused";
		x1_div_m_sel	:	integer	:=	1;
		xn_clock_source_sel	:	string	:=	"cgb_x1_m_div";
		pcie_rst	:	string	:=	"normal_reset";
		fref_vco_bypass	:	string	:=	"normal_operation";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0;
		x1_clock0_logical_to_physical_mapping	:	string	:=	"x1_clk_unused";
		x1_clock1_logical_to_physical_mapping	:	string	:=	"x1_clk_unused";
		x1_clock2_logical_to_physical_mapping	:	string	:=	"x1_clk_unused";
		x1_clock3_logical_to_physical_mapping	:	string	:=	"x1_clk_unused";
		x1_clock4_logical_to_physical_mapping	:	string	:=	"x1_clk_unused";
		x1_clock5_logical_to_physical_mapping	:	string	:=	"x1_clk_unused";
		x1_clock6_logical_to_physical_mapping	:	string	:=	"x1_clk_unused";
		x1_clock7_logical_to_physical_mapping	:	string	:=	"x1_clk_unused";
		reserved_transmit_channel	:	string	:=	"false"
	);
	port	(
		clkbcdr1b	:	in	std_logic := '0';
		clkbcdr1t	:	in	std_logic := '0';
		clkbcdrloc	:	in	std_logic := '0';
		clkbdnseg	:	in	std_logic := '0';
		clkbffpll	:	in	std_logic := '0';
		clkbupseg	:	in	std_logic := '0';
		clkcdr1b	:	in	std_logic := '0';
		clkcdr1t	:	in	std_logic := '0';
		clkcdrloc	:	in	std_logic := '0';
		clkdnseg	:	in	std_logic := '0';
		clkffpll	:	in	std_logic := '0';
		clkupseg	:	in	std_logic := '0';
		cpulsex6dn	:	in	std_logic := '0';
		cpulsex6up	:	in	std_logic := '0';
		cpulsexndn	:	in	std_logic := '0';
		cpulsexnup	:	in	std_logic := '0';
		hfclknx6dn	:	in	std_logic := '0';
		hfclknx6up	:	in	std_logic := '0';
		hfclknxndn	:	in	std_logic := '0';
		hfclknxnup	:	in	std_logic := '0';
		hfclkpx6dn	:	in	std_logic := '0';
		hfclkpx6up	:	in	std_logic := '0';
		hfclkpxndn	:	in	std_logic := '0';
		hfclkpxnup	:	in	std_logic := '0';
		lfclknx6dn	:	in	std_logic := '0';
		lfclknx6up	:	in	std_logic := '0';
		lfclknxndn	:	in	std_logic := '0';
		lfclknxnup	:	in	std_logic := '0';
		lfclkpx6dn	:	in	std_logic := '0';
		lfclkpx6up	:	in	std_logic := '0';
		lfclkpxndn	:	in	std_logic := '0';
		lfclkpxnup	:	in	std_logic := '0';
		pciesw	:	in	std_logic := '0';
		pclkx6dn	:	in	std_logic := '0';
		pclkx6up	:	in	std_logic := '0';
		pclkxndn	:	in	std_logic := '0';
		pclkxnup	:	in	std_logic := '0';
		rstn	:	in	std_logic := '0';
		rxclk	:	in	std_logic := '0';
		cpulse	:	out	std_logic := '0';
		cpulseout	:	out	std_logic := '0';
		hfclkn	:	out	std_logic := '0';
		hfclknout	:	out	std_logic := '0';
		hfclkp	:	out	std_logic := '0';
		hfclkpout	:	out	std_logic := '0';
		lfclkn	:	out	std_logic := '0';
		lfclknout	:	out	std_logic := '0';
		lfclkp	:	out	std_logic := '0';
		lfclkpout	:	out	std_logic := '0';
		pcieswdone	:	out	std_logic := '0';
		pciesyncp	:	out	std_logic := '0';
		pclk	:	out	std_logic_vector(2 downto 0) := "000";
		pclkout	:	out	std_logic := '0';
		rxiqclk	:	out	std_logic := '0';
		fref	:	in	std_logic := '0';
		pcsrstn	:	in	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '1';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_pma_tx_ser
	generic
(
		enable_debug_info	:	string	:=	"false";
		auto_negotiation	:	string	:=	"false";
		channel_number	:	integer	:=	0;
		clk_divtx_deskew	:	integer	:=	0;
		clk_forward_only_mode	:	string	:=	"false";
		forced_data_mode	:	bit	:=	'0';
		mode	:	integer	:=	8;
		post_tap_1_en	:	string	:=	"false";
		ser_loopback	:	string	:=	"false";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0;
		pma_direct	:	string	:=	"false";
		duty_cycle_tune	:	string	:=	"duty_cycle3"
	);
	port	(
		cpulse	:	in	std_logic := '0';
		datain	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		hfclk	:	in	std_logic := '0';
		hfclkn	:	in	std_logic := '0';
		lfclk	:	in	std_logic := '0';
		lfclkn	:	in	std_logic := '0';
		pclk	:	in	std_logic_vector(2 downto 0) := "000";
		rstn	:	in	std_logic := '1';
		slpbk	:	in	std_logic := '0';
		clkdivtx	:	out	std_logic := '0';
		dataout	:	out	std_logic := '0';
		lbvop	:	out	std_logic := '0';
		preenout	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmrstn	:	in	std_logic := '1';
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0';
		avgvon	:	out	std_logic := '0';
		avgvop	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_refclk_divider
	generic
(
		lpm_type	:	string	:=	"cyclonev_hssi_refclk_divider";
		divide_by	:	integer	:=	1;
		enabled	:	string	:=	"true";
		refclk_coupling_termination	:	string	:=	"normal_100_ohm_termination"
	);
	port	(
		refclkin	:	in	std_logic := '0';
		refclkout	:	out	std_logic := '0';
		nonuserfrompmaux	:	in	std_logic := '0'
	);
end component;

component	cyclonev_hssi_rx_pcs_pma_interface
	generic
(
		enable_debug_info	:	string	:=	"false";
		selectpcs	:	string	:=	"eight_g_pcs";
		clkslip_sel	:	string	:=	"pld";
		prot_mode	:	string	:=	"other_protocols";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		pcs8grxclkiqout	:	in	std_logic := '0';
		pcs8grxclkslip	:	in	std_logic := '0';
		pldrxclkslip	:	in	std_logic := '0';
		pldrxpmarstb	:	in	std_logic := '0';
		pmareservedin	:	in	std_logic_vector(4 downto 0) := "00000";
		datainfrompma	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		pmarxpllphaselockin	:	in	std_logic := '0';
		clockinfrompma	:	in	std_logic := '0';
		pmasigdet	:	in	std_logic := '0';
		dataoutto8gpcs	:	out	std_logic_vector(19 downto 0) := "00000000000000000000";
		clockoutto8gpcs	:	out	std_logic := '0';
		pcs8gsigdetni	:	out	std_logic := '0';
		pmareservedout	:	out	std_logic_vector(4 downto 0) := "00000";
		pmarxclkout	:	out	std_logic := '0';
		pmarxpllphaselockout	:	out	std_logic := '0';
		pmarxclkslip	:	out	std_logic := '0';
		pmarxpmarstb	:	out	std_logic := '0';
		asynchdatain	:	out	std_logic := '0';
		reset	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_rx_pld_pcs_interface
	generic
(
		enable_debug_info	:	string	:=	"false";
		is_8g_0ppm	:	string	:=	"false";
		pcs_side_block_sel	:	string	:=	"eight_g_pcs";
		pld_side_data_source	:	string	:=	"pld";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		emsipenablediocsrrdydly	:	in	std_logic := '0';
		emsiprxspecialin	:	in	std_logic_vector(12 downto 0) := "0000000000000";
		pcs8ga1a2k1k2flag	:	in	std_logic_vector(3 downto 0) := "0000";
		pcs8galignstatus	:	in	std_logic := '0';
		pcs8gbistdone	:	in	std_logic := '0';
		pcs8gbisterr	:	in	std_logic := '0';
		pcs8gbyteordflag	:	in	std_logic := '0';
		pcs8gemptyrmf	:	in	std_logic := '0';
		pcs8gemptyrx	:	in	std_logic := '0';
		pcs8gfullrmf	:	in	std_logic := '0';
		pcs8gfullrx	:	in	std_logic := '0';
		pcs8grlvlt	:	in	std_logic := '0';
		clockinfrom8gpcs	:	in	std_logic := '0';
		pcs8grxdatavalid	:	in	std_logic_vector(3 downto 0) := "0000";
		datainfrom8gpcs	:	in	std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
		pcs8gsignaldetectout	:	in	std_logic := '0';
		pcs8gwaboundary	:	in	std_logic_vector(4 downto 0) := "00000";
		pld8ga1a2size	:	in	std_logic := '0';
		pld8gbitlocreven	:	in	std_logic := '0';
		pld8gbitslip	:	in	std_logic := '0';
		pld8gbytereven	:	in	std_logic := '0';
		pld8gbytordpld	:	in	std_logic := '0';
		pld8gcmpfifourstn	:	in	std_logic := '0';
		pld8gencdt	:	in	std_logic := '0';
		pld8gphfifourstrxn	:	in	std_logic := '0';
		pld8gpldrxclk	:	in	std_logic := '0';
		pld8gpolinvrx	:	in	std_logic := '0';
		pld8grdenablermf	:	in	std_logic := '0';
		pld8grdenablerx	:	in	std_logic := '0';
		pld8grxurstpcsn	:	in	std_logic := '0';
		pld8gwrdisablerx	:	in	std_logic := '0';
		pld8gwrenablermf	:	in	std_logic := '0';
		pldrxclkslipin	:	in	std_logic := '0';
		pldrxpmarstbin	:	in	std_logic := '0';
		pld8gsyncsmeninput	:	in	std_logic := '0';
		pmarxplllock	:	in	std_logic := '0';
		rstsel	:	in	std_logic := '0';
		usrrstsel	:	in	std_logic := '0';
		emsiprxout	:	out	std_logic_vector(128 downto 0) := "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
		emsiprxspecialout	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		pcs8ga1a2size	:	out	std_logic := '0';
		pcs8gbitlocreven	:	out	std_logic := '0';
		pcs8gbitslip	:	out	std_logic := '0';
		pcs8gbytereven	:	out	std_logic := '0';
		pcs8gbytordpld	:	out	std_logic := '0';
		pcs8gcmpfifourst	:	out	std_logic := '0';
		pcs8gencdt	:	out	std_logic := '0';
		pcs8gphfifourstrx	:	out	std_logic := '0';
		pcs8gpldrxclk	:	out	std_logic := '0';
		pcs8gpolinvrx	:	out	std_logic := '0';
		pcs8grdenablermf	:	out	std_logic := '0';
		pcs8grdenablerx	:	out	std_logic := '0';
		pcs8grxurstpcs	:	out	std_logic := '0';
		pcs8gsyncsmenoutput	:	out	std_logic := '0';
		pcs8gwrdisablerx	:	out	std_logic := '0';
		pcs8gwrenablermf	:	out	std_logic := '0';
		pld8ga1a2k1k2flag	:	out	std_logic_vector(3 downto 0) := "0000";
		pld8galignstatus	:	out	std_logic := '0';
		pld8gbistdone	:	out	std_logic := '0';
		pld8gbisterr	:	out	std_logic := '0';
		pld8gbyteordflag	:	out	std_logic := '0';
		pld8gemptyrmf	:	out	std_logic := '0';
		pld8gemptyrx	:	out	std_logic := '0';
		pld8gfullrmf	:	out	std_logic := '0';
		pld8gfullrx	:	out	std_logic := '0';
		pld8grlvlt	:	out	std_logic := '0';
		pld8grxclkout	:	out	std_logic := '0';
		pld8grxdatavalid	:	out	std_logic_vector(3 downto 0) := "0000";
		pld8gsignaldetectout	:	out	std_logic := '0';
		pld8gwaboundary	:	out	std_logic_vector(4 downto 0) := "00000";
		pldrxclkslipout	:	out	std_logic := '0';
		dataouttopld	:	out	std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
		pldrxpmarstbout	:	out	std_logic := '0';
		asynchdatain	:	out	std_logic := '0';
		reset	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmrstn	:	in	std_logic := '0';
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_tx_pcs_pma_interface
	generic
(
		enable_debug_info	:	string	:=	"false";
		selectpcs	:	string	:=	"eight_g_pcs";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		datainfrom8gpcs	:	in	std_logic_vector(19 downto 0) := "00000000000000000000";
		pcs8gtxclkiqout	:	in	std_logic := '0';
		pmarxfreqtxcmuplllockin	:	in	std_logic := '0';
		clockinfrompma	:	in	std_logic := '0';
		clockoutto8gpcs	:	out	std_logic := '0';
		pmarxfreqtxcmuplllockout	:	out	std_logic := '0';
		pmatxclkout	:	out	std_logic := '0';
		dataouttopma	:	out	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		asynchdatain	:	out	std_logic := '0';
		reset	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmrstn	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_hssi_tx_pld_pcs_interface
	generic
(
		enable_debug_info	:	string	:=	"false";
		is_8g_0ppm	:	string	:=	"false";
		pld_side_data_source	:	string	:=	"pld";
		avmm_group_channel_index	:	integer	:=	0;
		use_default_base_address	:	string	:=	"true";
		user_base_address	:	integer	:=	0
	);
	port	(
		emsipenablediocsrrdydly	:	in	std_logic := '0';
		emsiptxin	:	in	std_logic_vector(103 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
		emsiptxspecialin	:	in	std_logic_vector(12 downto 0) := "0000000000000";
		pcs8gemptytx	:	in	std_logic := '0';
		pcs8gfulltx	:	in	std_logic := '0';
		clockinfrom8gpcs	:	in	std_logic := '0';
		pld8gphfifoursttxn	:	in	std_logic := '0';
		pld8gpldtxclk	:	in	std_logic := '0';
		pld8gpolinvtx	:	in	std_logic := '0';
		pld8grddisabletx	:	in	std_logic := '0';
		pld8grevloopbk	:	in	std_logic := '0';
		pld8gtxboundarysel	:	in	std_logic_vector(4 downto 0) := "00000";
		pld8gtxdatavalid	:	in	std_logic_vector(3 downto 0) := "0000";
		pld8gtxurstpcsn	:	in	std_logic := '0';
		pld8gwrenabletx	:	in	std_logic := '0';
		datainfrompld	:	in	std_logic_vector(43 downto 0) := "00000000000000000000000000000000000000000000";
		pmatxcmuplllock	:	in	std_logic := '0';
		rstsel	:	in	std_logic := '0';
		usrrstsel	:	in	std_logic := '0';
		emsippcstxclkout	:	out	std_logic_vector(2 downto 0) := "000";
		emsiptxspecialout	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		pcs8gphfifoursttx	:	out	std_logic := '0';
		pcs8gpldtxclk	:	out	std_logic := '0';
		pcs8gpolinvtx	:	out	std_logic := '0';
		pcs8grddisabletx	:	out	std_logic := '0';
		pcs8grevloopbk	:	out	std_logic := '0';
		pcs8gtxboundarysel	:	out	std_logic_vector(4 downto 0) := "00000";
		pcs8gtxdatavalid	:	out	std_logic_vector(3 downto 0) := "0000";
		dataoutto8gpcs	:	out	std_logic_vector(43 downto 0) := "00000000000000000000000000000000000000000000";
		pcs8gtxurstpcs	:	out	std_logic := '0';
		pcs8gwrenabletx	:	out	std_logic := '0';
		pld8gemptytx	:	out	std_logic := '0';
		pld8gfulltx	:	out	std_logic := '0';
		pld8gtxclkout	:	out	std_logic := '0';
		asynchdatain	:	out	std_logic := '0';
		reset	:	out	std_logic := '0';
		avmmaddress	:	in	std_logic_vector(10 downto 0) := "00000000000";
		avmmbyteen	:	in	std_logic_vector(1 downto 0) := "00";
		avmmrstn	:	in	std_logic := '0';
		avmmclk	:	in	std_logic := '0';
		avmmread	:	in	std_logic := '0';
		avmmwrite	:	in	std_logic := '0';
		avmmwritedata	:	in	std_logic_vector(15 downto 0) := "0000000000000000";
		avmmreaddata	:	out	std_logic_vector(15 downto 0) := "0000000000000000";
		blockselect	:	out	std_logic := '0'
	);
end component;

component	cyclonev_pll_aux
	generic
(
		lpm_type	:	string	:=	"cyclonev_pll_aux";
		pl_aux_atb_atben0_precomp	:	bit	:=	'1';
		pl_aux_atb_atben1_precomp	:	bit	:=	'1';
		pl_aux_atb_comp_minus	:	bit	:=	'0';
		pl_aux_atb_comp_plus	:	bit	:=	'0';
		pl_aux_comp_pwr_dn	:	bit	:=	'1'
	);
	port	(
		atb0out	:	in	std_logic := '0';
		atb1out	:	in	std_logic := '0';
		atbcompout	:	out	std_logic := '0'
	);
end component;

end CYCLONEV_HSSI_COMPONENTS;

package body CYCLONEV_HSSI_COMPONENTS is

function bin2int (s : std_logic_vector) return integer is

      constant temp      : std_logic_vector(s'high-s'low DOWNTO 0) := s;      
      variable result      : integer := 0;
   begin
      for i in temp'range loop
         if (temp(i) = '1') then
            result := result + (2**i);
         end if;
      end loop;
      return(result);
   end bin2int;

function bin2int (s : bit_vector) return integer is

      constant temp      : bit_vector(s'high-s'low DOWNTO 0) := s;      
      variable result      : integer := 0;
   begin
      for i in temp'range loop
         if (temp(i) = '1') then
            result := result + (2**i);
         end if;
      end loop;
      return(result);
   end bin2int;
                  
function bin2int (s : std_logic) return integer is
      constant temp      : std_logic := s;      
      variable result      : integer := 0;
   begin
         if (temp = '1') then
            result := 1;
         else
         	result := 0;
     	 end if;
      return(result);
	end bin2int;
                  
function bin2int (s : bit) return integer is
      constant temp      : bit := s;      
      variable result      : integer := 0;
   begin
         if (temp = '1') then
            result := 1;
         else
         	result := 0;
     	 end if;
      return(result);
	end bin2int;
	
function str2bin (s : string) return std_logic_vector is
variable len : integer := s'length;
variable result : std_logic_vector(39 DOWNTO 0) := (OTHERS => '0');
variable i : integer;
begin
    for i in 1 to len loop
        case s(i) is
            when '0' => result(len - i) := '0';
            when '1' => result(len - i) := '1';
            when others =>
                ASSERT FALSE
                REPORT "Illegal Character "&  s(i) & "in string parameter! "
                SEVERITY ERROR;
        end case;
    end loop;
    return result;
end;

function str2int (s : string) return integer is
variable len : integer := s'length;
variable newdigit : integer := 0;
variable sign : integer := 1;
variable digit : integer := 0;
begin
    for i in 1 to len loop
        case s(i) is
            when '-' =>
                if i = 1 then
                    sign := -1;
                else
                    ASSERT FALSE
                    REPORT "Illegal Character "&  s(i) & "i n string parameter! " SEVERITY ERROR;
                end if;
            when '0' =>
                digit := 0;
            when '1' =>
                digit := 1;
            when '2' =>
                digit := 2;
            when '3' =>
                digit := 3;
            when '4' =>
                digit := 4;
            when '5' =>
                digit := 5;
            when '6' =>
                digit := 6;
            when '7' =>
                digit := 7;
            when '8' =>
                digit := 8;
            when '9' =>
                digit := 9;
            when others =>
                ASSERT FALSE
                REPORT "Illegal Character "&  s(i) & "in string parameter! "
                SEVERITY ERROR;
        end case;
        newdigit := newdigit * 10 + digit;
    end loop;

    return (sign*newdigit);
end;

function int2bin (arg : integer; size : integer) return std_logic_vector is
    variable int_val : integer := arg;
    variable result : std_logic_vector(size-1 downto 0);
    begin
        for i in 0 to result'left loop
            if ((int_val mod 2) = 0) then
                result(i) := '0';
            else
                result(i) := '1';
            end if;
            int_val := int_val/2;
        end loop;
        return result;
    end int2bin;
    
function int2bin (arg : boolean; size : integer) return std_logic_vector is
    variable result : std_logic_vector(size-1 downto 0);
    begin
		if(arg)then
			result := (OTHERS => '1');
		else
			result := (OTHERS => '0');
		end if;
        return result;
    end int2bin;

function int2bit (arg : integer) return std_logic is
    variable int_val : integer := arg;
    variable result : std_logic;
    begin
        
            if (int_val  = 0) then
                result := '0';
            else
                result := '1';
            end if;
            
        return result;
end int2bit;

function int2bit (arg : boolean) return std_logic is
    variable int_val : boolean := arg;
    variable result : std_logic;
    begin
        
            if (int_val ) then
                result := '1';
            else
                result := '0';
            end if;
            
        return result;
end int2bit;


end CYCLONEV_HSSI_COMPONENTS;
