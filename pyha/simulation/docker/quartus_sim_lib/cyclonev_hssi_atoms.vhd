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
library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_8g_pcs_aggregate	is
	generic	(
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
end	cyclonev_hssi_8g_pcs_aggregate;

architecture behavior of cyclonev_hssi_8g_pcs_aggregate is

component	cyclonev_hssi_8g_pcs_aggregate_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_8g_pcs_aggregate_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		xaui_sm_operation	=>	xaui_sm_operation,
		dskw_sm_operation	=>	dskw_sm_operation,
		data_agg_bonding	=>	data_agg_bonding,
		prot_mode_tx	=>	prot_mode_tx,
		pcs_dw_datapath	=>	pcs_dw_datapath,
		dskw_control	=>	dskw_control,
		refclkdig_sel	=>	refclkdig_sel,
		agg_pwdn	=>	agg_pwdn,
		dskw_mnumber_data	=>	dskw_mnumber_data,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		aligndetsyncbotch2	=>	aligndetsyncbotch2,
		aligndetsyncch0	=>	aligndetsyncch0,
		aligndetsyncch1	=>	aligndetsyncch1,
		aligndetsyncch2	=>	aligndetsyncch2,
		aligndetsynctopch0	=>	aligndetsynctopch0,
		aligndetsynctopch1	=>	aligndetsynctopch1,
		alignstatussyncbotch2	=>	alignstatussyncbotch2,
		alignstatussyncch0	=>	alignstatussyncch0,
		alignstatussyncch1	=>	alignstatussyncch1,
		alignstatussyncch2	=>	alignstatussyncch2,
		alignstatussynctopch0	=>	alignstatussynctopch0,
		alignstatussynctopch1	=>	alignstatussynctopch1,
		cgcomprddinbotch2	=>	cgcomprddinbotch2,
		cgcomprddinch0	=>	cgcomprddinch0,
		cgcomprddinch1	=>	cgcomprddinch1,
		cgcomprddinch2	=>	cgcomprddinch2,
		cgcomprddintopch0	=>	cgcomprddintopch0,
		cgcomprddintopch1	=>	cgcomprddintopch1,
		cgcompwrinbotch2	=>	cgcompwrinbotch2,
		cgcompwrinch0	=>	cgcompwrinch0,
		cgcompwrinch1	=>	cgcompwrinch1,
		cgcompwrinch2	=>	cgcompwrinch2,
		cgcompwrintopch0	=>	cgcompwrintopch0,
		cgcompwrintopch1	=>	cgcompwrintopch1,
		decctlbotch2	=>	decctlbotch2,
		decctlch0	=>	decctlch0,
		decctlch1	=>	decctlch1,
		decctlch2	=>	decctlch2,
		decctltopch0	=>	decctltopch0,
		decctltopch1	=>	decctltopch1,
		decdatabotch2	=>	decdatabotch2,
		decdatach0	=>	decdatach0,
		decdatach1	=>	decdatach1,
		decdatach2	=>	decdatach2,
		decdatatopch0	=>	decdatatopch0,
		decdatatopch1	=>	decdatatopch1,
		decdatavalidbotch2	=>	decdatavalidbotch2,
		decdatavalidch0	=>	decdatavalidch0,
		decdatavalidch1	=>	decdatavalidch1,
		decdatavalidch2	=>	decdatavalidch2,
		decdatavalidtopch0	=>	decdatavalidtopch0,
		decdatavalidtopch1	=>	decdatavalidtopch1,
		dedicatedaggscaninch1	=>	dedicatedaggscaninch1,
		delcondmetinbotch2	=>	delcondmetinbotch2,
		delcondmetinch0	=>	delcondmetinch0,
		delcondmetinch1	=>	delcondmetinch1,
		delcondmetinch2	=>	delcondmetinch2,
		delcondmetintopch0	=>	delcondmetintopch0,
		delcondmetintopch1	=>	delcondmetintopch1,
		dprioagg	=>	dprioagg,
		fifoovrinbotch2	=>	fifoovrinbotch2,
		fifoovrinch0	=>	fifoovrinch0,
		fifoovrinch1	=>	fifoovrinch1,
		fifoovrinch2	=>	fifoovrinch2,
		fifoovrintopch0	=>	fifoovrintopch0,
		fifoovrintopch1	=>	fifoovrintopch1,
		fifordinbotch2	=>	fifordinbotch2,
		fifordinch0	=>	fifordinch0,
		fifordinch1	=>	fifordinch1,
		fifordinch2	=>	fifordinch2,
		fifordintopch0	=>	fifordintopch0,
		fifordintopch1	=>	fifordintopch1,
		insertincompleteinbotch2	=>	insertincompleteinbotch2,
		insertincompleteinch0	=>	insertincompleteinch0,
		insertincompleteinch1	=>	insertincompleteinch1,
		insertincompleteinch2	=>	insertincompleteinch2,
		insertincompleteintopch0	=>	insertincompleteintopch0,
		insertincompleteintopch1	=>	insertincompleteintopch1,
		latencycompinbotch2	=>	latencycompinbotch2,
		latencycompinch0	=>	latencycompinch0,
		latencycompinch1	=>	latencycompinch1,
		latencycompinch2	=>	latencycompinch2,
		latencycompintopch0	=>	latencycompintopch0,
		latencycompintopch1	=>	latencycompintopch1,
		rcvdclkch0	=>	rcvdclkch0,
		rcvdclkch1	=>	rcvdclkch1,
		rdalignbotch2	=>	rdalignbotch2,
		rdalignch0	=>	rdalignch0,
		rdalignch1	=>	rdalignch1,
		rdalignch2	=>	rdalignch2,
		rdaligntopch0	=>	rdaligntopch0,
		rdaligntopch1	=>	rdaligntopch1,
		rdenablesyncbotch2	=>	rdenablesyncbotch2,
		rdenablesyncch0	=>	rdenablesyncch0,
		rdenablesyncch1	=>	rdenablesyncch1,
		rdenablesyncch2	=>	rdenablesyncch2,
		rdenablesynctopch0	=>	rdenablesynctopch0,
		rdenablesynctopch1	=>	rdenablesynctopch1,
		refclkdig	=>	refclkdig,
		runningdispbotch2	=>	runningdispbotch2,
		runningdispch0	=>	runningdispch0,
		runningdispch1	=>	runningdispch1,
		runningdispch2	=>	runningdispch2,
		runningdisptopch0	=>	runningdisptopch0,
		runningdisptopch1	=>	runningdisptopch1,
		rxpcsrstn	=>	rxpcsrstn,
		scanmoden	=>	scanmoden,
		scanshiftn	=>	scanshiftn,
		syncstatusbotch2	=>	syncstatusbotch2,
		syncstatusch0	=>	syncstatusch0,
		syncstatusch1	=>	syncstatusch1,
		syncstatusch2	=>	syncstatusch2,
		syncstatustopch0	=>	syncstatustopch0,
		syncstatustopch1	=>	syncstatustopch1,
		txctltcbotch2	=>	txctltcbotch2,
		txctltcch0	=>	txctltcch0,
		txctltcch1	=>	txctltcch1,
		txctltcch2	=>	txctltcch2,
		txctltctopch0	=>	txctltctopch0,
		txctltctopch1	=>	txctltctopch1,
		txdatatcbotch2	=>	txdatatcbotch2,
		txdatatcch0	=>	txdatatcch0,
		txdatatcch1	=>	txdatatcch1,
		txdatatcch2	=>	txdatatcch2,
		txdatatctopch0	=>	txdatatctopch0,
		txdatatctopch1	=>	txdatatctopch1,
		txpcsrstn	=>	txpcsrstn,
		txpmaclk	=>	txpmaclk,
		aggtestbusch0	=>	aggtestbusch0,
		aggtestbusch1	=>	aggtestbusch1,
		aggtestbusch2	=>	aggtestbusch2,
		alignstatusbotch2	=>	alignstatusbotch2,
		alignstatusch0	=>	alignstatusch0,
		alignstatusch1	=>	alignstatusch1,
		alignstatusch2	=>	alignstatusch2,
		alignstatussync0botch2	=>	alignstatussync0botch2,
		alignstatussync0ch0	=>	alignstatussync0ch0,
		alignstatussync0ch1	=>	alignstatussync0ch1,
		alignstatussync0ch2	=>	alignstatussync0ch2,
		alignstatussync0topch0	=>	alignstatussync0topch0,
		alignstatussync0topch1	=>	alignstatussync0topch1,
		alignstatustopch0	=>	alignstatustopch0,
		alignstatustopch1	=>	alignstatustopch1,
		cgcomprddallbotch2	=>	cgcomprddallbotch2,
		cgcomprddallch0	=>	cgcomprddallch0,
		cgcomprddallch1	=>	cgcomprddallch1,
		cgcomprddallch2	=>	cgcomprddallch2,
		cgcomprddalltopch0	=>	cgcomprddalltopch0,
		cgcomprddalltopch1	=>	cgcomprddalltopch1,
		cgcompwrallbotch2	=>	cgcompwrallbotch2,
		cgcompwrallch0	=>	cgcompwrallch0,
		cgcompwrallch1	=>	cgcompwrallch1,
		cgcompwrallch2	=>	cgcompwrallch2,
		cgcompwralltopch0	=>	cgcompwralltopch0,
		cgcompwralltopch1	=>	cgcompwralltopch1,
		dedicatedaggscanoutch0tieoff	=>	dedicatedaggscanoutch0tieoff,
		dedicatedaggscanoutch1	=>	dedicatedaggscanoutch1,
		dedicatedaggscanoutch2tieoff	=>	dedicatedaggscanoutch2tieoff,
		delcondmet0botch2	=>	delcondmet0botch2,
		delcondmet0ch0	=>	delcondmet0ch0,
		delcondmet0ch1	=>	delcondmet0ch1,
		delcondmet0ch2	=>	delcondmet0ch2,
		delcondmet0topch0	=>	delcondmet0topch0,
		delcondmet0topch1	=>	delcondmet0topch1,
		endskwqdbotch2	=>	endskwqdbotch2,
		endskwqdch0	=>	endskwqdch0,
		endskwqdch1	=>	endskwqdch1,
		endskwqdch2	=>	endskwqdch2,
		endskwqdtopch0	=>	endskwqdtopch0,
		endskwqdtopch1	=>	endskwqdtopch1,
		endskwrdptrsbotch2	=>	endskwrdptrsbotch2,
		endskwrdptrsch0	=>	endskwrdptrsch0,
		endskwrdptrsch1	=>	endskwrdptrsch1,
		endskwrdptrsch2	=>	endskwrdptrsch2,
		endskwrdptrstopch0	=>	endskwrdptrstopch0,
		endskwrdptrstopch1	=>	endskwrdptrstopch1,
		fifoovr0botch2	=>	fifoovr0botch2,
		fifoovr0ch0	=>	fifoovr0ch0,
		fifoovr0ch1	=>	fifoovr0ch1,
		fifoovr0ch2	=>	fifoovr0ch2,
		fifoovr0topch0	=>	fifoovr0topch0,
		fifoovr0topch1	=>	fifoovr0topch1,
		fifordoutcomp0botch2	=>	fifordoutcomp0botch2,
		fifordoutcomp0ch0	=>	fifordoutcomp0ch0,
		fifordoutcomp0ch1	=>	fifordoutcomp0ch1,
		fifordoutcomp0ch2	=>	fifordoutcomp0ch2,
		fifordoutcomp0topch0	=>	fifordoutcomp0topch0,
		fifordoutcomp0topch1	=>	fifordoutcomp0topch1,
		fiforstrdqdbotch2	=>	fiforstrdqdbotch2,
		fiforstrdqdch0	=>	fiforstrdqdch0,
		fiforstrdqdch1	=>	fiforstrdqdch1,
		fiforstrdqdch2	=>	fiforstrdqdch2,
		fiforstrdqdtopch0	=>	fiforstrdqdtopch0,
		fiforstrdqdtopch1	=>	fiforstrdqdtopch1,
		insertincomplete0botch2	=>	insertincomplete0botch2,
		insertincomplete0ch0	=>	insertincomplete0ch0,
		insertincomplete0ch1	=>	insertincomplete0ch1,
		insertincomplete0ch2	=>	insertincomplete0ch2,
		insertincomplete0topch0	=>	insertincomplete0topch0,
		insertincomplete0topch1	=>	insertincomplete0topch1,
		latencycomp0botch2	=>	latencycomp0botch2,
		latencycomp0ch0	=>	latencycomp0ch0,
		latencycomp0ch1	=>	latencycomp0ch1,
		latencycomp0ch2	=>	latencycomp0ch2,
		latencycomp0topch0	=>	latencycomp0topch0,
		latencycomp0topch1	=>	latencycomp0topch1,
		rcvdclkout	=>	rcvdclkout,
		rcvdclkoutbot	=>	rcvdclkoutbot,
		rcvdclkouttop	=>	rcvdclkouttop,
		rxctlrsbotch2	=>	rxctlrsbotch2,
		rxctlrsch0	=>	rxctlrsch0,
		rxctlrsch1	=>	rxctlrsch1,
		rxctlrsch2	=>	rxctlrsch2,
		rxctlrstopch0	=>	rxctlrstopch0,
		rxctlrstopch1	=>	rxctlrstopch1,
		rxdatarsbotch2	=>	rxdatarsbotch2,
		rxdatarsch0	=>	rxdatarsch0,
		rxdatarsch1	=>	rxdatarsch1,
		rxdatarsch2	=>	rxdatarsch2,
		rxdatarstopch0	=>	rxdatarstopch0,
		rxdatarstopch1	=>	rxdatarstopch1,
		txctltsbotch2	=>	txctltsbotch2,
		txctltsch0	=>	txctltsch0,
		txctltsch1	=>	txctltsch1,
		txctltsch2	=>	txctltsch2,
		txctltstopch0	=>	txctltstopch0,
		txctltstopch1	=>	txctltstopch1,
		txdatatsbotch2	=>	txdatatsbotch2,
		txdatatsch0	=>	txdatatsch0,
		txdatatsch1	=>	txdatatsch1,
		txdatatsch2	=>	txdatatsch2,
		txdatatstopch0	=>	txdatatstopch0,
		txdatatstopch1	=>	txdatatstopch1
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.CYCLONEV_HSSI_COMPONENTS.all;


entity	cyclonev_hssi_8g_rx_pcs	is
	generic	(
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
end	cyclonev_hssi_8g_rx_pcs;

architecture behavior of cyclonev_hssi_8g_rx_pcs is

constant cid_pattern_len_int	:	integer	:= bin2int(cid_pattern_len);
constant wa_rgnumber_data_int	:	integer	:= bin2int(wa_rgnumber_data);
constant wa_renumber_data_int	:	integer	:= bin2int(wa_renumber_data);
constant wa_rknumber_data_int	:	integer	:= bin2int(wa_rknumber_data);
constant deskew_pattern_int	:	integer	:= bin2int(deskew_pattern);
constant wa_rvnumber_data_int	:	integer	:= bin2int(wa_rvnumber_data);
constant fixed_pat_num_int	:	integer	:= bin2int(fixed_pat_num);
constant bo_pattern_int	:	integer	:= bin2int(bo_pattern);
constant wait_cnt_int	:	integer	:= bin2int(wait_cnt);
constant clkcmp_pattern_n_int	:	integer	:= bin2int(clkcmp_pattern_n);
constant pma_done_count_int	:	integer	:= bin2int(pma_done_count);
constant wa_rosnumber_data_int	:	integer	:= bin2int(wa_rosnumber_data);
constant bo_pad_int	:	integer	:= bin2int(bo_pad);
constant clkcmp_pattern_p_int	:	integer	:= bin2int(clkcmp_pattern_p);
constant wa_clk_slip_spacing_data_int	:	integer	:= bin2int(wa_clk_slip_spacing_data);
constant runlength_val_int	:	integer	:= bin2int(runlength_val);
constant wa_pd_data_int	:	integer	:= bin2int(wa_pd_data);
constant mask_cnt_int	:	integer	:= bin2int(mask_cnt);

component	cyclonev_hssi_8g_rx_pcs_encrypted
	generic	(
		enable_debug_info	:	string	:=	"false";
		prot_mode	:	string	:=	"gige";
		tx_rx_parallel_loopback	:	string	:=	"dis_plpbk";
		pma_dw	:	string	:=	"eight_bit";
		pcs_bypass	:	string	:=	"dis_pcs_bypass";
		polarity_inversion	:	string	:=	"dis_pol_inv";
		wa_pd	:	string	:=	"wa_pd_10";
		wa_pd_data	:	integer	:=	0;
		wa_boundary_lock_ctrl	:	string	:=	"bit_slip";
		wa_pld_controlled	:	string	:=	"dis_pld_ctrl";
		wa_sync_sm_ctrl	:	string	:=	"gige_sync_sm";
		wa_rknumber_data	:	integer	:=	0;
		wa_renumber_data	:	integer	:=	0;
		wa_rgnumber_data	:	integer	:=	0;
		wa_rosnumber_data	:	integer	:=	0;
		wa_kchar	:	string	:=	"dis_kchar";
		wa_det_latency_sync_status_beh	:	string	:=	"assert_sync_status_non_imm";
		wa_clk_slip_spacing	:	string	:=	"min_clk_slip_spacing";
		wa_clk_slip_spacing_data	:	integer	:=	16;
		bit_reversal	:	string	:=	"dis_bit_reversal";
		symbol_swap	:	string	:=	"dis_symbol_swap";
		deskew_pattern	:	integer	:=	872;
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
		bo_pattern	:	integer	:=	0;
		bo_pad	:	integer	:=	0;
		phase_compensation_fifo	:	string	:=	"low_latency";
		prbs_ver	:	string	:=	"dis_prbs";
		cid_pattern	:	string	:=	"cid_pattern_0";
		cid_pattern_len	:	integer	:=	0;
		bist_ver	:	string	:=	"dis_bist";
		cdr_ctrl	:	string	:=	"dis_cdr_ctrl";
		cdr_ctrl_rxvalid_mask	:	string	:=	"dis_rxvalid_mask";
		wait_cnt	:	integer	:=	0;
		mask_cnt	:	integer	:=	1023;
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
		wa_rvnumber_data	:	integer	:=	0;
		ctrl_plane_bonding_compensation	:	string	:=	"dis_compensation";
		prbs_ver_clr_flag	:	string	:=	"dis_prbs_clr_flag";
		hip_mode	:	string	:=	"dis_hip";
		ctrl_plane_bonding_distribution	:	string	:=	"not_master_chnl_distr";
		ctrl_plane_bonding_consumption	:	string	:=	"individual";
		pma_done_count	:	integer	:=	0;
		test_mode	:	string	:=	"prbs";
		bist_ver_clr_flag	:	string	:=	"dis_bist_clr_flag";
		wa_disp_err_flag	:	string	:=	"dis_disp_err_flag";
		runlength_check	:	string	:=	"en_runlength_sw";
		runlength_val	:	integer	:=	0;
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
		clkcmp_pattern_p	:	integer	:=	0;
		clkcmp_pattern_n	:	integer	:=	0;
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
		fixed_pat_num	:	integer	:=	15;
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

begin


inst : cyclonev_hssi_8g_rx_pcs_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		prot_mode	=>	prot_mode,
		tx_rx_parallel_loopback	=>	tx_rx_parallel_loopback,
		pma_dw	=>	pma_dw,
		pcs_bypass	=>	pcs_bypass,
		polarity_inversion	=>	polarity_inversion,
		wa_pd	=>	wa_pd,
		wa_pd_data	=>	wa_pd_data_int,
		wa_boundary_lock_ctrl	=>	wa_boundary_lock_ctrl,
		wa_pld_controlled	=>	wa_pld_controlled,
		wa_sync_sm_ctrl	=>	wa_sync_sm_ctrl,
		wa_rknumber_data	=>	wa_rknumber_data_int,
		wa_renumber_data	=>	wa_renumber_data_int,
		wa_rgnumber_data	=>	wa_rgnumber_data_int,
		wa_rosnumber_data	=>	wa_rosnumber_data_int,
		wa_kchar	=>	wa_kchar,
		wa_det_latency_sync_status_beh	=>	wa_det_latency_sync_status_beh,
		wa_clk_slip_spacing	=>	wa_clk_slip_spacing,
		wa_clk_slip_spacing_data	=>	wa_clk_slip_spacing_data_int,
		bit_reversal	=>	bit_reversal,
		symbol_swap	=>	symbol_swap,
		deskew_pattern	=>	deskew_pattern_int,
		deskew_prog_pattern_only	=>	deskew_prog_pattern_only,
		rate_match	=>	rate_match,
		eightb_tenb_decoder	=>	eightb_tenb_decoder,
		err_flags_sel	=>	err_flags_sel,
		polinv_8b10b_dec	=>	polinv_8b10b_dec,
		eightbtenb_decoder_output_sel	=>	eightbtenb_decoder_output_sel,
		invalid_code_flag_only	=>	invalid_code_flag_only,
		auto_error_replacement	=>	auto_error_replacement,
		pad_or_edb_error_replace	=>	pad_or_edb_error_replace,
		byte_deserializer	=>	byte_deserializer,
		byte_order	=>	byte_order,
		re_bo_on_wa	=>	re_bo_on_wa,
		bo_pattern	=>	bo_pattern_int,
		bo_pad	=>	bo_pad_int,
		phase_compensation_fifo	=>	phase_compensation_fifo,
		prbs_ver	=>	prbs_ver,
		cid_pattern	=>	cid_pattern,
		cid_pattern_len	=>	cid_pattern_len_int,
		bist_ver	=>	bist_ver,
		cdr_ctrl	=>	cdr_ctrl,
		cdr_ctrl_rxvalid_mask	=>	cdr_ctrl_rxvalid_mask,
		wait_cnt	=>	wait_cnt_int,
		mask_cnt	=>	mask_cnt_int,
		eidle_entry_sd	=>	eidle_entry_sd,
		eidle_entry_eios	=>	eidle_entry_eios,
		eidle_entry_iei	=>	eidle_entry_iei,
		rx_rcvd_clk	=>	rx_rcvd_clk,
		rx_clk1	=>	rx_clk1,
		rx_clk2	=>	rx_clk2,
		rx_rd_clk	=>	rx_rd_clk,
		dw_one_or_two_symbol_bo	=>	dw_one_or_two_symbol_bo,
		comp_fifo_rst_pld_ctrl	=>	comp_fifo_rst_pld_ctrl,
		bypass_pipeline_reg	=>	bypass_pipeline_reg,
		agg_block_sel	=>	agg_block_sel,
		test_bus_sel	=>	test_bus_sel,
		wa_rvnumber_data	=>	wa_rvnumber_data_int,
		ctrl_plane_bonding_compensation	=>	ctrl_plane_bonding_compensation,
		prbs_ver_clr_flag	=>	prbs_ver_clr_flag,
		hip_mode	=>	hip_mode,
		ctrl_plane_bonding_distribution	=>	ctrl_plane_bonding_distribution,
		ctrl_plane_bonding_consumption	=>	ctrl_plane_bonding_consumption,
		pma_done_count	=>	pma_done_count_int,
		test_mode	=>	test_mode,
		bist_ver_clr_flag	=>	bist_ver_clr_flag,
		wa_disp_err_flag	=>	wa_disp_err_flag,
		runlength_check	=>	runlength_check,
		runlength_val	=>	runlength_val_int,
		force_signal_detect	=>	force_signal_detect,
		deskew	=>	deskew,
		rx_wr_clk	=>	rx_wr_clk,
		rx_clk_free_running	=>	rx_clk_free_running,
		rx_pcs_urst	=>	rx_pcs_urst,
		pipe_if_enable	=>	pipe_if_enable,
		pc_fifo_rst_pld_ctrl	=>	pc_fifo_rst_pld_ctrl,
		ibm_invalid_code	=>	ibm_invalid_code,
		channel_number	=>	channel_number,
		rx_refclk	=>	rx_refclk,
		clock_gate_dw_rm_wr	=>	clock_gate_dw_rm_wr,
		clock_gate_bds_dec_asn	=>	clock_gate_bds_dec_asn,
		fixed_pat_det	=>	fixed_pat_det,
		clock_gate_bist	=>	clock_gate_bist,
		clock_gate_cdr_eidle	=>	clock_gate_cdr_eidle,
		clkcmp_pattern_p	=>	clkcmp_pattern_p_int,
		clkcmp_pattern_n	=>	clkcmp_pattern_n_int,
		clock_gate_prbs	=>	clock_gate_prbs,
		clock_gate_pc_rdclk	=>	clock_gate_pc_rdclk,
		wa_pd_polarity	=>	wa_pd_polarity,
		clock_gate_dskw_rd	=>	clock_gate_dskw_rd,
		clock_gate_byteorder	=>	clock_gate_byteorder,
		clock_gate_dw_pc_wrclk	=>	clock_gate_dw_pc_wrclk,
		sup_mode	=>	sup_mode,
		clock_gate_sw_wa	=>	clock_gate_sw_wa,
		clock_gate_dw_dskw_wr	=>	clock_gate_dw_dskw_wr,
		clock_gate_sw_pc_wrclk	=>	clock_gate_sw_pc_wrclk,
		clock_gate_sw_rm_rd	=>	clock_gate_sw_rm_rd,
		clock_gate_sw_rm_wr	=>	clock_gate_sw_rm_wr,
		auto_speed_nego	=>	auto_speed_nego,
		fixed_pat_num	=>	fixed_pat_num_int,
		clock_gate_sw_dskw_wr	=>	clock_gate_sw_dskw_wr,
		clock_gate_dw_rm_rd	=>	clock_gate_dw_rm_rd,
		clock_gate_dw_wa	=>	clock_gate_dw_wa,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		a1a2size	=>	a1a2size,
		aggtestbus	=>	aggtestbus,
		alignstatus	=>	alignstatus,
		alignstatussync0	=>	alignstatussync0,
		alignstatussync0toporbot	=>	alignstatussync0toporbot,
		alignstatustoporbot	=>	alignstatustoporbot,
		bitreversalenable	=>	bitreversalenable,
		bitslip	=>	bitslip,
		bytereversalenable	=>	bytereversalenable,
		byteorder	=>	byteorder,
		cgcomprddall	=>	cgcomprddall,
		cgcomprddalltoporbot	=>	cgcomprddalltoporbot,
		cgcompwrall	=>	cgcompwrall,
		cgcompwralltoporbot	=>	cgcompwralltoporbot,
		rmfifouserrst	=>	rmfifouserrst,
		configselinchnldown	=>	configselinchnldown,
		configselinchnlup	=>	configselinchnlup,
		delcondmet0	=>	delcondmet0,
		delcondmet0toporbot	=>	delcondmet0toporbot,
		dynclkswitchn	=>	dynclkswitchn,
		eidleinfersel	=>	eidleinfersel,
		endskwqd	=>	endskwqd,
		endskwqdtoporbot	=>	endskwqdtoporbot,
		endskwrdptrs	=>	endskwrdptrs,
		endskwrdptrstoporbot	=>	endskwrdptrstoporbot,
		enablecommadetect	=>	enablecommadetect,
		fifoovr0	=>	fifoovr0,
		fifoovr0toporbot	=>	fifoovr0toporbot,
		rmfifordincomp0	=>	rmfifordincomp0,
		fifordincomp0toporbot	=>	fifordincomp0toporbot,
		fiforstrdqd	=>	fiforstrdqd,
		fiforstrdqdtoporbot	=>	fiforstrdqdtoporbot,
		gen2ngen1	=>	gen2ngen1,
		hrdrst	=>	hrdrst,
		insertincomplete0	=>	insertincomplete0,
		insertincomplete0toporbot	=>	insertincomplete0toporbot,
		latencycomp0	=>	latencycomp0,
		latencycomp0toporbot	=>	latencycomp0toporbot,
		phfifouserrst	=>	phfifouserrst,
		phystatusinternal	=>	phystatusinternal,
		phystatuspcsgen3	=>	phystatuspcsgen3,
		pipeloopbk	=>	pipeloopbk,
		pldltr	=>	pldltr,
		pldrxclk	=>	pldrxclk,
		polinvrx	=>	polinvrx,
		prbscidenable	=>	prbscidenable,
		datain	=>	datain,
		rateswitchcontrol	=>	rateswitchcontrol,
		rcvdclkagg	=>	rcvdclkagg,
		rcvdclkaggtoporbot	=>	rcvdclkaggtoporbot,
		rcvdclkpma	=>	rcvdclkpma,
		rdenableinchnldown	=>	rdenableinchnldown,
		rdenableinchnlup	=>	rdenableinchnlup,
		rmfiforeadenable	=>	rmfiforeadenable,
		pcfifordenable	=>	pcfifordenable,
		refclkdig	=>	refclkdig,
		refclkdig2	=>	refclkdig2,
		resetpcptrsinchnldown	=>	resetpcptrsinchnldown,
		resetpcptrsinchnlup	=>	resetpcptrsinchnlup,
		resetppmcntrsinchnldown	=>	resetppmcntrsinchnldown,
		resetppmcntrsinchnlup	=>	resetppmcntrsinchnlup,
		ctrlfromaggblock	=>	ctrlfromaggblock,
		rxcontrolrstoporbot	=>	rxcontrolrstoporbot,
		datafrinaggblock	=>	datafrinaggblock,
		rxdatarstoporbot	=>	rxdatarstoporbot,
		rxdivsyncinchnldown	=>	rxdivsyncinchnldown,
		rxdivsyncinchnlup	=>	rxdivsyncinchnlup,
		rxsynchdrpcsgen3	=>	rxsynchdrpcsgen3,
		rxweinchnldown	=>	rxweinchnldown,
		rxweinchnlup	=>	rxweinchnlup,
		rxstatusinternal	=>	rxstatusinternal,
		rxpcsrst	=>	rxpcsrst,
		rxvalidinternal	=>	rxvalidinternal,
		scanmode	=>	scanmode,
		sigdetfrompma	=>	sigdetfrompma,
		speedchangeinchnldown	=>	speedchangeinchnldown,
		speedchangeinchnlup	=>	speedchangeinchnlup,
		syncsmen	=>	syncsmen,
		txctrlplanetestbus	=>	txctrlplanetestbus,
		txdivsync	=>	txdivsync,
		txpmaclk	=>	txpmaclk,
		txtestbus	=>	txtestbus,
		parallelloopback	=>	parallelloopback,
		wrenableinchnldown	=>	wrenableinchnldown,
		wrenableinchnlup	=>	wrenableinchnlup,
		pxfifowrdisable	=>	pxfifowrdisable,
		rmfifowriteenable	=>	rmfifowriteenable,
		a1a2k1k2flag	=>	a1a2k1k2flag,
		aggrxpcsrst	=>	aggrxpcsrst,
		aligndetsync	=>	aligndetsync,
		alignstatuspld	=>	alignstatuspld,
		alignstatussync	=>	alignstatussync,
		rmfifopartialfull	=>	rmfifopartialfull,
		rmfifopartialempty	=>	rmfifopartialempty,
		bistdone	=>	bistdone,
		bisterr	=>	bisterr,
		byteordflag	=>	byteordflag,
		cgcomprddout	=>	cgcomprddout,
		cgcompwrout	=>	cgcompwrout,
		channeltestbusout	=>	channeltestbusout,
		configseloutchnldown	=>	configseloutchnldown,
		configseloutchnlup	=>	configseloutchnlup,
		decoderctrl	=>	decoderctrl,
		decoderdata	=>	decoderdata,
		decoderdatavalid	=>	decoderdatavalid,
		delcondmetout	=>	delcondmetout,
		disablepcfifobyteserdes	=>	disablepcfifobyteserdes,
		earlyeios	=>	earlyeios,
		eidleexit	=>	eidleexit,
		rmfifoempty	=>	rmfifoempty,
		pcfifoempty	=>	pcfifoempty,
		errctrl	=>	errctrl,
		errdata	=>	errdata,
		fifoovrout	=>	fifoovrout,
		fifordoutcomp	=>	fifordoutcomp,
		rmfifofull	=>	rmfifofull,
		pcfifofull	=>	pcfifofull,
		insertincompleteout	=>	insertincompleteout,
		latencycompout	=>	latencycompout,
		ltr	=>	ltr,
		pcieswitch	=>	pcieswitch,
		phystatus	=>	phystatus,
		pipedata	=>	pipedata,
		prbsdone	=>	prbsdone,
		prbserrlt	=>	prbserrlt,
		rdalign	=>	rdalign,
		rdenableoutchnldown	=>	rdenableoutchnldown,
		rdenableoutchnlup	=>	rdenableoutchnlup,
		resetpcptrs	=>	resetpcptrs,
		resetpcptrsinchnldownpipe	=>	resetpcptrsinchnldownpipe,
		resetpcptrsinchnluppipe	=>	resetpcptrsinchnluppipe,
		resetpcptrsoutchnldown	=>	resetpcptrsoutchnldown,
		resetpcptrsoutchnlup	=>	resetpcptrsoutchnlup,
		resetppmcntrsoutchnldown	=>	resetppmcntrsoutchnldown,
		resetppmcntrsoutchnlup	=>	resetppmcntrsoutchnlup,
		resetppmcntrspcspma	=>	resetppmcntrspcspma,
		parallelrevloopback	=>	parallelrevloopback,
		runlengthviolation	=>	runlengthviolation,
		rlvlt	=>	rlvlt,
		runningdisparity	=>	runningdisparity,
		rxblkstart	=>	rxblkstart,
		clocktopld	=>	clocktopld,
		rxclkslip	=>	rxclkslip,
		rxdatavalid	=>	rxdatavalid,
		rxdivsyncoutchnldown	=>	rxdivsyncoutchnldown,
		rxdivsyncoutchnlup	=>	rxdivsyncoutchnlup,
		rxpipeclk	=>	rxpipeclk,
		rxpipesoftreset	=>	rxpipesoftreset,
		rxsynchdr	=>	rxsynchdr,
		rxweoutchnldown	=>	rxweoutchnldown,
		rxweoutchnlup	=>	rxweoutchnlup,
		dataout	=>	dataout,
		eidledetected	=>	eidledetected,
		rxstatus	=>	rxstatus,
		rxvalid	=>	rxvalid,
		selftestdone	=>	selftestdone,
		selftesterr	=>	selftesterr,
		signaldetectout	=>	signaldetectout,
		speedchange	=>	speedchange,
		speedchangeinchnldownpipe	=>	speedchangeinchnldownpipe,
		speedchangeinchnluppipe	=>	speedchangeinchnluppipe,
		speedchangeoutchnldown	=>	speedchangeoutchnldown,
		speedchangeoutchnlup	=>	speedchangeoutchnlup,
		syncstatus	=>	syncstatus,
		wordalignboundary	=>	wordalignboundary,
		wrenableoutchnldown	=>	wrenableoutchnldown,
		wrenableoutchnlup	=>	wrenableoutchnlup,
		syncdatain	=>	syncdatain,
		observablebyteserdesclock	=>	observablebyteserdesclock,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.CYCLONEV_HSSI_COMPONENTS.all;


entity	cyclonev_hssi_8g_tx_pcs	is
	generic	(
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
end	cyclonev_hssi_8g_tx_pcs;

architecture behavior of cyclonev_hssi_8g_tx_pcs is

constant cid_pattern_len_int	:	integer	:= bin2int(cid_pattern_len);

component	cyclonev_hssi_8g_tx_pcs_encrypted
	generic	(
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
		cid_pattern_len	:	integer	:=	0;
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

begin


inst : cyclonev_hssi_8g_tx_pcs_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		prot_mode	=>	prot_mode,
		hip_mode	=>	hip_mode,
		pma_dw	=>	pma_dw,
		pcs_bypass	=>	pcs_bypass,
		phase_compensation_fifo	=>	phase_compensation_fifo,
		tx_compliance_controlled_disparity	=>	tx_compliance_controlled_disparity,
		force_kchar	=>	force_kchar,
		force_echar	=>	force_echar,
		byte_serializer	=>	byte_serializer,
		data_selection_8b10b_encoder_input	=>	data_selection_8b10b_encoder_input,
		eightb_tenb_disp_ctrl	=>	eightb_tenb_disp_ctrl,
		eightb_tenb_encoder	=>	eightb_tenb_encoder,
		prbs_gen	=>	prbs_gen,
		cid_pattern	=>	cid_pattern,
		cid_pattern_len	=>	cid_pattern_len_int,
		bist_gen	=>	bist_gen,
		bit_reversal	=>	bit_reversal,
		symbol_swap	=>	symbol_swap,
		polarity_inversion	=>	polarity_inversion,
		tx_bitslip	=>	tx_bitslip,
		agg_block_sel	=>	agg_block_sel,
		revloop_back_rm	=>	revloop_back_rm,
		phfifo_write_clk_sel	=>	phfifo_write_clk_sel,
		ctrl_plane_bonding_consumption	=>	ctrl_plane_bonding_consumption,
		bypass_pipeline_reg	=>	bypass_pipeline_reg,
		ctrl_plane_bonding_distribution	=>	ctrl_plane_bonding_distribution,
		test_mode	=>	test_mode,
		ctrl_plane_bonding_compensation	=>	ctrl_plane_bonding_compensation,
		refclk_b_clk_sel	=>	refclk_b_clk_sel,
		auto_speed_nego_gen2	=>	auto_speed_nego_gen2,
		txpcs_urst	=>	txpcs_urst,
		clock_gate_dw_fifowr	=>	clock_gate_dw_fifowr,
		clock_gate_prbs	=>	clock_gate_prbs,
		txclk_freerun	=>	txclk_freerun,
		clock_gate_bs_enc	=>	clock_gate_bs_enc,
		clock_gate_bist	=>	clock_gate_bist,
		clock_gate_fiford	=>	clock_gate_fiford,
		pcfifo_urst	=>	pcfifo_urst,
		clock_gate_sw_fifowr	=>	clock_gate_sw_fifowr,
		sup_mode	=>	sup_mode,
		dynamic_clk_switch	=>	dynamic_clk_switch,
		channel_number	=>	channel_number,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		dispcbyte	=>	dispcbyte,
		elecidleinfersel	=>	elecidleinfersel,
		fifoselectinchnldown	=>	fifoselectinchnldown,
		fifoselectinchnlup	=>	fifoselectinchnlup,
		rateswitch	=>	rateswitch,
		hrdrst	=>	hrdrst,
		pipetxdeemph	=>	pipetxdeemph,
		pipetxmargin	=>	pipetxmargin,
		phfiforeset	=>	phfiforeset,
		coreclk	=>	coreclk,
		polinvrxin	=>	polinvrxin,
		invpol	=>	invpol,
		powerdn	=>	powerdn,
		prbscidenable	=>	prbscidenable,
		rdenableinchnldown	=>	rdenableinchnldown,
		rdenableinchnlup	=>	rdenableinchnlup,
		phfiforddisable	=>	phfiforddisable,
		refclkdig	=>	refclkdig,
		resetpcptrs	=>	resetpcptrs,
		resetpcptrsinchnldown	=>	resetpcptrsinchnldown,
		resetpcptrsinchnlup	=>	resetpcptrsinchnlup,
		revparallellpbkdata	=>	revparallellpbkdata,
		enrevparallellpbk	=>	enrevparallellpbk,
		pipeenrevparallellpbkin	=>	pipeenrevparallellpbkin,
		rxpolarityin	=>	rxpolarityin,
		scanmode	=>	scanmode,
		txblkstart	=>	txblkstart,
		bitslipboundaryselect	=>	bitslipboundaryselect,
		xgmctrl	=>	xgmctrl,
		xgmctrltoporbottom	=>	xgmctrltoporbottom,
		xgmdatain	=>	xgmdatain,
		xgmdataintoporbottom	=>	xgmdataintoporbottom,
		txdatavalid	=>	txdatavalid,
		txdivsyncinchnldown	=>	txdivsyncinchnldown,
		txdivsyncinchnlup	=>	txdivsyncinchnlup,
		txsynchdr	=>	txsynchdr,
		datain	=>	datain,
		detectrxloopin	=>	detectrxloopin,
		txpmalocalclk	=>	txpmalocalclk,
		pipetxswing	=>	pipetxswing,
		txpcsreset	=>	txpcsreset,
		wrenableinchnldown	=>	wrenableinchnldown,
		wrenableinchnlup	=>	wrenableinchnlup,
		phfifowrenable	=>	phfifowrenable,
		aggtxpcsrst	=>	aggtxpcsrst,
		dynclkswitchn	=>	dynclkswitchn,
		phfifounderflow	=>	phfifounderflow,
		fifoselectoutchnldown	=>	fifoselectoutchnldown,
		fifoselectoutchnlup	=>	fifoselectoutchnlup,
		phfifooverflow	=>	phfifooverflow,
		grayelecidleinferselout	=>	grayelecidleinferselout,
		phfifotxdeemph	=>	phfifotxdeemph,
		phfifotxmargin	=>	phfifotxmargin,
		phfifotxswing	=>	phfifotxswing,
		polinvrxout	=>	polinvrxout,
		pipepowerdownout	=>	pipepowerdownout,
		dataout	=>	dataout,
		rdenableoutchnldown	=>	rdenableoutchnldown,
		rdenableoutchnlup	=>	rdenableoutchnlup,
		rdenablesync	=>	rdenablesync,
		refclkb	=>	refclkb,
		refclkbreset	=>	refclkbreset,
		pipeenrevparallellpbkout	=>	pipeenrevparallellpbkout,
		rxpolarityout	=>	rxpolarityout,
		txblkstartout	=>	txblkstartout,
		clkout	=>	clkout,
		xgmctrlenable	=>	xgmctrlenable,
		txctrlplanetestbus	=>	txctrlplanetestbus,
		txdataouttogen3	=>	txdataouttogen3,
		xgmdataout	=>	xgmdataout,
		txdatavalidouttogen3	=>	txdatavalidouttogen3,
		txdatakouttogen3	=>	txdatakouttogen3,
		txdivsync	=>	txdivsync,
		txdivsyncoutchnldown	=>	txdivsyncoutchnldown,
		txdivsyncoutchnlup	=>	txdivsyncoutchnlup,
		txpipeclk	=>	txpipeclk,
		txpipeelectidle	=>	txpipeelectidle,
		txpipesoftreset	=>	txpipesoftreset,
		txsynchdrout	=>	txsynchdrout,
		txtestbus	=>	txtestbus,
		txcomplianceout	=>	txcomplianceout,
		detectrxloopout	=>	detectrxloopout,
		txelecidleout	=>	txelecidleout,
		parallelfdbkout	=>	parallelfdbkout,
		wrenableoutchnldown	=>	wrenableoutchnldown,
		wrenableoutchnlup	=>	wrenableoutchnlup,
		syncdatain	=>	syncdatain,
		observablebyteserdesclock	=>	observablebyteserdesclock,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_common_pcs_pma_interface	is
	generic	(
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
end	cyclonev_hssi_common_pcs_pma_interface;

architecture behavior of cyclonev_hssi_common_pcs_pma_interface is

component	cyclonev_hssi_common_pcs_pma_interface_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_common_pcs_pma_interface_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		prot_mode	=>	prot_mode,
		force_freqdet	=>	force_freqdet,
		ppmsel	=>	ppmsel,
		ppm_cnt_rst	=>	ppm_cnt_rst,
		auto_speed_ena	=>	auto_speed_ena,
		ppm_gen1_2_cnt	=>	ppm_gen1_2_cnt,
		ppm_post_eidle_delay	=>	ppm_post_eidle_delay,
		func_mode	=>	func_mode,
		pma_if_dft_val	=>	pma_if_dft_val,
		sup_mode	=>	sup_mode,
		selectpcs	=>	selectpcs,
		ppm_deassert_early	=>	ppm_deassert_early,
		pipe_if_g3pcs	=>	pipe_if_g3pcs,
		pma_if_dft_en	=>	pma_if_dft_en,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		aggalignstatus	=>	aggalignstatus,
		aggalignstatussync0	=>	aggalignstatussync0,
		aggalignstatussync0toporbot	=>	aggalignstatussync0toporbot,
		aggalignstatustoporbot	=>	aggalignstatustoporbot,
		aggcgcomprddall	=>	aggcgcomprddall,
		aggcgcomprddalltoporbot	=>	aggcgcomprddalltoporbot,
		aggcgcompwrall	=>	aggcgcompwrall,
		aggcgcompwralltoporbot	=>	aggcgcompwralltoporbot,
		aggdelcondmet0	=>	aggdelcondmet0,
		aggdelcondmet0toporbot	=>	aggdelcondmet0toporbot,
		aggendskwqd	=>	aggendskwqd,
		aggendskwqdtoporbot	=>	aggendskwqdtoporbot,
		aggendskwrdptrs	=>	aggendskwrdptrs,
		aggendskwrdptrstoporbot	=>	aggendskwrdptrstoporbot,
		aggfifoovr0	=>	aggfifoovr0,
		aggfifoovr0toporbot	=>	aggfifoovr0toporbot,
		aggfifordincomp0	=>	aggfifordincomp0,
		aggfifordincomp0toporbot	=>	aggfifordincomp0toporbot,
		aggfiforstrdqd	=>	aggfiforstrdqd,
		aggfiforstrdqdtoporbot	=>	aggfiforstrdqdtoporbot,
		agginsertincomplete0	=>	agginsertincomplete0,
		agginsertincomplete0toporbot	=>	agginsertincomplete0toporbot,
		agglatencycomp0	=>	agglatencycomp0,
		agglatencycomp0toporbot	=>	agglatencycomp0toporbot,
		aggrcvdclkagg	=>	aggrcvdclkagg,
		aggrcvdclkaggtoporbot	=>	aggrcvdclkaggtoporbot,
		aggrxcontrolrs	=>	aggrxcontrolrs,
		aggrxcontrolrstoporbot	=>	aggrxcontrolrstoporbot,
		aggrxdatars	=>	aggrxdatars,
		aggrxdatarstoporbot	=>	aggrxdatarstoporbot,
		aggtestsotopldin	=>	aggtestsotopldin,
		aggtestbus	=>	aggtestbus,
		aggtxctlts	=>	aggtxctlts,
		aggtxctltstoporbot	=>	aggtxctltstoporbot,
		aggtxdatats	=>	aggtxdatats,
		aggtxdatatstoporbot	=>	aggtxdatatstoporbot,
		hardreset	=>	hardreset,
		pcs8gearlyeios	=>	pcs8gearlyeios,
		pcs8geidleexit	=>	pcs8geidleexit,
		pcs8gltrpma	=>	pcs8gltrpma,
		pcs8gpcieswitch	=>	pcs8gpcieswitch,
		pcs8gpmacurrentcoeff	=>	pcs8gpmacurrentcoeff,
		pcs8gtxelecidle	=>	pcs8gtxelecidle,
		pcs8gtxdetectrx	=>	pcs8gtxdetectrx,
		pcsaggaligndetsync	=>	pcsaggaligndetsync,
		pcsaggalignstatussync	=>	pcsaggalignstatussync,
		pcsaggcgcomprddout	=>	pcsaggcgcomprddout,
		pcsaggcgcompwrout	=>	pcsaggcgcompwrout,
		pcsaggdecctl	=>	pcsaggdecctl,
		pcsaggdecdata	=>	pcsaggdecdata,
		pcsaggdecdatavalid	=>	pcsaggdecdatavalid,
		pcsaggdelcondmetout	=>	pcsaggdelcondmetout,
		pcsaggfifoovrout	=>	pcsaggfifoovrout,
		pcsaggfifordoutcomp	=>	pcsaggfifordoutcomp,
		pcsagginsertincompleteout	=>	pcsagginsertincompleteout,
		pcsagglatencycompout	=>	pcsagglatencycompout,
		pcsaggrdalign	=>	pcsaggrdalign,
		pcsaggrdenablesync	=>	pcsaggrdenablesync,
		pcsaggrefclkdig	=>	pcsaggrefclkdig,
		pcsaggrunningdisp	=>	pcsaggrunningdisp,
		pcsaggrxpcsrst	=>	pcsaggrxpcsrst,
		pcsaggscanmoden	=>	pcsaggscanmoden,
		pcsaggscanshiftn	=>	pcsaggscanshiftn,
		pcsaggsyncstatus	=>	pcsaggsyncstatus,
		pcsaggtxctltc	=>	pcsaggtxctltc,
		pcsaggtxdatatc	=>	pcsaggtxdatatc,
		pcsaggtxpcsrst	=>	pcsaggtxpcsrst,
		pcsrefclkdig	=>	pcsrefclkdig,
		pcsscanmoden	=>	pcsscanmoden,
		pcsscanshiftn	=>	pcsscanshiftn,
		pldnfrzdrv	=>	pldnfrzdrv,
		pldpartialreconfig	=>	pldpartialreconfig,
		pldtestsitoaggin	=>	pldtestsitoaggin,
		clklow	=>	clklow,
		fref	=>	fref,
		pmahclk	=>	pmahclk,
		pmapcieswdone	=>	pmapcieswdone,
		pmarxdetectvalid	=>	pmarxdetectvalid,
		pmarxfound	=>	pmarxfound,
		pmarxpmarstb	=>	pmarxpmarstb,
		resetppmcntrs	=>	resetppmcntrs,
		aggaligndetsync	=>	aggaligndetsync,
		aggalignstatussync	=>	aggalignstatussync,
		aggcgcomprddout	=>	aggcgcomprddout,
		aggcgcompwrout	=>	aggcgcompwrout,
		aggdecctl	=>	aggdecctl,
		aggdecdata	=>	aggdecdata,
		aggdecdatavalid	=>	aggdecdatavalid,
		aggdelcondmetout	=>	aggdelcondmetout,
		aggfifoovrout	=>	aggfifoovrout,
		aggfifordoutcomp	=>	aggfifordoutcomp,
		agginsertincompleteout	=>	agginsertincompleteout,
		agglatencycompout	=>	agglatencycompout,
		aggrdalign	=>	aggrdalign,
		aggrdenablesync	=>	aggrdenablesync,
		aggrefclkdig	=>	aggrefclkdig,
		aggrunningdisp	=>	aggrunningdisp,
		aggrxpcsrst	=>	aggrxpcsrst,
		aggscanmoden	=>	aggscanmoden,
		aggscanshiftn	=>	aggscanshiftn,
		aggsyncstatus	=>	aggsyncstatus,
		aggtestsotopldout	=>	aggtestsotopldout,
		aggtxctltc	=>	aggtxctltc,
		aggtxdatatc	=>	aggtxdatatc,
		aggtxpcsrst	=>	aggtxpcsrst,
		pcs8ggen2ngen1	=>	pcs8ggen2ngen1,
		pcs8gpmarxfound	=>	pcs8gpmarxfound,
		pcs8gpowerstatetransitiondone	=>	pcs8gpowerstatetransitiondone,
		pcs8grxdetectvalid	=>	pcs8grxdetectvalid,
		pcsaggalignstatus	=>	pcsaggalignstatus,
		pcsaggalignstatussync0	=>	pcsaggalignstatussync0,
		pcsaggalignstatussync0toporbot	=>	pcsaggalignstatussync0toporbot,
		pcsaggalignstatustoporbot	=>	pcsaggalignstatustoporbot,
		pcsaggcgcomprddall	=>	pcsaggcgcomprddall,
		pcsaggcgcomprddalltoporbot	=>	pcsaggcgcomprddalltoporbot,
		pcsaggcgcompwrall	=>	pcsaggcgcompwrall,
		pcsaggcgcompwralltoporbot	=>	pcsaggcgcompwralltoporbot,
		pcsaggdelcondmet0	=>	pcsaggdelcondmet0,
		pcsaggdelcondmet0toporbot	=>	pcsaggdelcondmet0toporbot,
		pcsaggendskwqd	=>	pcsaggendskwqd,
		pcsaggendskwqdtoporbot	=>	pcsaggendskwqdtoporbot,
		pcsaggendskwrdptrs	=>	pcsaggendskwrdptrs,
		pcsaggendskwrdptrstoporbot	=>	pcsaggendskwrdptrstoporbot,
		pcsaggfifoovr0	=>	pcsaggfifoovr0,
		pcsaggfifoovr0toporbot	=>	pcsaggfifoovr0toporbot,
		pcsaggfifordincomp0	=>	pcsaggfifordincomp0,
		pcsaggfifordincomp0toporbot	=>	pcsaggfifordincomp0toporbot,
		pcsaggfiforstrdqd	=>	pcsaggfiforstrdqd,
		pcsaggfiforstrdqdtoporbot	=>	pcsaggfiforstrdqdtoporbot,
		pcsagginsertincomplete0	=>	pcsagginsertincomplete0,
		pcsagginsertincomplete0toporbot	=>	pcsagginsertincomplete0toporbot,
		pcsagglatencycomp0	=>	pcsagglatencycomp0,
		pcsagglatencycomp0toporbot	=>	pcsagglatencycomp0toporbot,
		pcsaggrcvdclkagg	=>	pcsaggrcvdclkagg,
		pcsaggrcvdclkaggtoporbot	=>	pcsaggrcvdclkaggtoporbot,
		pcsaggrxcontrolrs	=>	pcsaggrxcontrolrs,
		pcsaggrxcontrolrstoporbot	=>	pcsaggrxcontrolrstoporbot,
		pcsaggrxdatars	=>	pcsaggrxdatars,
		pcsaggrxdatarstoporbot	=>	pcsaggrxdatarstoporbot,
		pcsaggtestbus	=>	pcsaggtestbus,
		pcsaggtxctlts	=>	pcsaggtxctlts,
		pcsaggtxctltstoporbot	=>	pcsaggtxctltstoporbot,
		pcsaggtxdatats	=>	pcsaggtxdatats,
		pcsaggtxdatatstoporbot	=>	pcsaggtxdatatstoporbot,
		pldhclkout	=>	pldhclkout,
		pldtestsitoaggout	=>	pldtestsitoaggout,
		pmaclklowout	=>	pmaclklowout,
		pmacurrentcoeff	=>	pmacurrentcoeff,
		pmaearlyeios	=>	pmaearlyeios,
		pmafrefout	=>	pmafrefout,
		pmaiftestbus	=>	pmaiftestbus,
		pmaltr	=>	pmaltr,
		pmanfrzdrv	=>	pmanfrzdrv,
		pmapartialreconfig	=>	pmapartialreconfig,
		pmapcieswitch	=>	pmapcieswitch,
		freqlock	=>	freqlock,
		pmatxelecidle	=>	pmatxelecidle,
		pmatxdetectrx	=>	pmatxdetectrx,
		asynchdatain	=>	asynchdatain,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_common_pld_pcs_interface	is
	generic	(
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
end	cyclonev_hssi_common_pld_pcs_interface;

architecture behavior of cyclonev_hssi_common_pld_pcs_interface is

component	cyclonev_hssi_common_pld_pcs_interface_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_common_pld_pcs_interface_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		hip_enable	=>	hip_enable,
		hrdrstctrl_en_cfgusr	=>	hrdrstctrl_en_cfgusr,
		pld_side_reserved_source10	=>	pld_side_reserved_source10,
		pld_side_data_source	=>	pld_side_data_source,
		pld_side_reserved_source0	=>	pld_side_reserved_source0,
		pld_side_reserved_source1	=>	pld_side_reserved_source1,
		pld_side_reserved_source2	=>	pld_side_reserved_source2,
		pld_side_reserved_source3	=>	pld_side_reserved_source3,
		pld_side_reserved_source4	=>	pld_side_reserved_source4,
		pld_side_reserved_source5	=>	pld_side_reserved_source5,
		pld_side_reserved_source6	=>	pld_side_reserved_source6,
		pld_side_reserved_source7	=>	pld_side_reserved_source7,
		pld_side_reserved_source8	=>	pld_side_reserved_source8,
		pld_side_reserved_source9	=>	pld_side_reserved_source9,
		hrdrstctrl_en_cfg	=>	hrdrstctrl_en_cfg,
		testbus_sel	=>	testbus_sel,
		usrmode_sel4rst	=>	usrmode_sel4rst,
		pld_side_reserved_source11	=>	pld_side_reserved_source11,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		emsipcomin	=>	emsipcomin,
		pcs8gchnltestbusout	=>	pcs8gchnltestbusout,
		pcs8gphystatus	=>	pcs8gphystatus,
		pcs8gpldextraout	=>	pcs8gpldextraout,
		pcs8grxelecidle	=>	pcs8grxelecidle,
		pcs8grxstatus	=>	pcs8grxstatus,
		pcs8grxvalid	=>	pcs8grxvalid,
		pcs8gtestso	=>	pcs8gtestso,
		pcsaggtestso	=>	pcsaggtestso,
		pcspmaiftestso	=>	pcspmaiftestso,
		pcspmaiftestbusout	=>	pcspmaiftestbusout,
		pld8gpowerdown	=>	pld8gpowerdown,
		pld8gprbsciden	=>	pld8gprbsciden,
		pld8grefclkdig	=>	pld8grefclkdig,
		pld8grefclkdig2	=>	pld8grefclkdig2,
		pld8grxpolarity	=>	pld8grxpolarity,
		pld8gtxdeemph	=>	pld8gtxdeemph,
		pld8gtxdetectrxloopback	=>	pld8gtxdetectrxloopback,
		pld8gtxelecidle	=>	pld8gtxelecidle,
		pld8gtxmargin	=>	pld8gtxmargin,
		pld8gtxswing	=>	pld8gtxswing,
		pldaggrefclkdig	=>	pldaggrefclkdig,
		pldeidleinfersel	=>	pldeidleinfersel,
		pldhclkin	=>	pldhclkin,
		pldltr	=>	pldltr,
		pldpartialreconfigin	=>	pldpartialreconfigin,
		pldpcspmaifrefclkdig	=>	pldpcspmaifrefclkdig,
		pldrate	=>	pldrate,
		pldreservedin	=>	pldreservedin,
		pldscanmoden	=>	pldscanmoden,
		pldscanshiftn	=>	pldscanshiftn,
		pmaclklow	=>	pmaclklow,
		pmafref	=>	pmafref,
		emsipcomclkout	=>	emsipcomclkout,
		emsipcomout	=>	emsipcomout,
		emsipenablediocsrrdydly	=>	emsipenablediocsrrdydly,
		pcs8geidleinfersel	=>	pcs8geidleinfersel,
		pcs8ghardreset	=>	pcs8ghardreset,
		pcs8gltr	=>	pcs8gltr,
		pcs8gpldextrain	=>	pcs8gpldextrain,
		pcs8gpowerdown	=>	pcs8gpowerdown,
		pcs8gprbsciden	=>	pcs8gprbsciden,
		pcs8grate	=>	pcs8grate,
		pcs8grefclkdig	=>	pcs8grefclkdig,
		pcs8grefclkdig2	=>	pcs8grefclkdig2,
		pcs8grxpolarity	=>	pcs8grxpolarity,
		pcs8gscanmoden	=>	pcs8gscanmoden,
		pcs8gscanshift	=>	pcs8gscanshift,
		pcs8gtestsi	=>	pcs8gtestsi,
		pcs8gtxdeemph	=>	pcs8gtxdeemph,
		pcs8gtxdetectrxloopback	=>	pcs8gtxdetectrxloopback,
		pcs8gtxelecidle	=>	pcs8gtxelecidle,
		pcs8gtxmargin	=>	pcs8gtxmargin,
		pcs8gtxswing	=>	pcs8gtxswing,
		pcsaggrefclkdig	=>	pcsaggrefclkdig,
		pcsaggscanmoden	=>	pcsaggscanmoden,
		pcsaggscanshift	=>	pcsaggscanshift,
		pcsaggtestsi	=>	pcsaggtestsi,
		pcspcspmaifrefclkdig	=>	pcspcspmaifrefclkdig,
		pcspcspmaifscanmoden	=>	pcspcspmaifscanmoden,
		pcspcspmaifscanshiftn	=>	pcspcspmaifscanshiftn,
		pcspmaifhardreset	=>	pcspmaifhardreset,
		pcspmaiftestsi	=>	pcspmaiftestsi,
		pld8gphystatus	=>	pld8gphystatus,
		pld8grxelecidle	=>	pld8grxelecidle,
		pld8grxstatus	=>	pld8grxstatus,
		pld8grxvalid	=>	pld8grxvalid,
		pldclklow	=>	pldclklow,
		pldfref	=>	pldfref,
		pldnfrzdrv	=>	pldnfrzdrv,
		pldpartialreconfigout	=>	pldpartialreconfigout,
		pldreservedout	=>	pldreservedout,
		pldtestdata	=>	pldtestdata,
		rstsel	=>	rstsel,
		usrrstsel	=>	usrrstsel,
		asynchdatain	=>	asynchdatain,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmrstn	=>	avmmrstn,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.CYCLONEV_HSSI_COMPONENTS.all;


entity	cyclonev_hssi_pipe_gen1_2	is
	generic	(
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
end	cyclonev_hssi_pipe_gen1_2;

architecture behavior of cyclonev_hssi_pipe_gen1_2 is

constant elec_idle_delay_val_int	:	integer	:= bin2int(elec_idle_delay_val);
constant phystatus_delay_val_int	:	integer	:= bin2int(phystatus_delay_val);
constant rvod_sel_d_val_int	:	integer	:= bin2int(rvod_sel_d_val);
constant rpre_emph_b_val_int	:	integer	:= bin2int(rpre_emph_b_val);
constant rvod_sel_c_val_int	:	integer	:= bin2int(rvod_sel_c_val);
constant rpre_emph_c_val_int	:	integer	:= bin2int(rpre_emph_c_val);
constant rpre_emph_settings_int	:	integer	:= bin2int(rpre_emph_settings);
constant rvod_sel_a_val_int	:	integer	:= bin2int(rvod_sel_a_val);
constant rpre_emph_d_val_int	:	integer	:= bin2int(rpre_emph_d_val);
constant rvod_sel_settings_int	:	integer	:= bin2int(rvod_sel_settings);
constant rvod_sel_b_val_int	:	integer	:= bin2int(rvod_sel_b_val);
constant rpre_emph_e_val_int	:	integer	:= bin2int(rpre_emph_e_val);
constant rvod_sel_e_val_int	:	integer	:= bin2int(rvod_sel_e_val);
constant rpre_emph_a_val_int	:	integer	:= bin2int(rpre_emph_a_val);

component	cyclonev_hssi_pipe_gen1_2_encrypted
	generic	(
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
		elec_idle_delay_val	:	integer	:=	0;
		phy_status_delay	:	string	:=	"phystatus_delay";
		phystatus_delay_val	:	integer	:=	0;
		rvod_sel_d_val	:	integer	:=	0;
		rpre_emph_b_val	:	integer	:=	0;
		rvod_sel_c_val	:	integer	:=	0;
		rpre_emph_c_val	:	integer	:=	0;
		rpre_emph_settings	:	integer	:=	0;
		rvod_sel_a_val	:	integer	:=	0;
		rpre_emph_d_val	:	integer	:=	0;
		rvod_sel_settings	:	integer	:=	0;
		rvod_sel_b_val	:	integer	:=	0;
		rpre_emph_e_val	:	integer	:=	0;
		sup_mode	:	string	:=	"user_mode";
		rvod_sel_e_val	:	integer	:=	0;
		rpre_emph_a_val	:	integer	:=	0;
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

begin


inst : cyclonev_hssi_pipe_gen1_2_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		prot_mode	=>	prot_mode,
		hip_mode	=>	hip_mode,
		tx_pipe_enable	=>	tx_pipe_enable,
		rx_pipe_enable	=>	rx_pipe_enable,
		pipe_byte_de_serializer_en	=>	pipe_byte_de_serializer_en,
		txswing	=>	txswing,
		rxdetect_bypass	=>	rxdetect_bypass,
		error_replace_pad	=>	error_replace_pad,
		ind_error_reporting	=>	ind_error_reporting,
		phystatus_rst_toggle	=>	phystatus_rst_toggle,
		elecidle_delay	=>	elecidle_delay,
		elec_idle_delay_val	=>	elec_idle_delay_val_int,
		phy_status_delay	=>	phy_status_delay,
		phystatus_delay_val	=>	phystatus_delay_val_int,
		rvod_sel_d_val	=>	rvod_sel_d_val_int,
		rpre_emph_b_val	=>	rpre_emph_b_val_int,
		rvod_sel_c_val	=>	rvod_sel_c_val_int,
		rpre_emph_c_val	=>	rpre_emph_c_val_int,
		rpre_emph_settings	=>	rpre_emph_settings_int,
		rvod_sel_a_val	=>	rvod_sel_a_val_int,
		rpre_emph_d_val	=>	rpre_emph_d_val_int,
		rvod_sel_settings	=>	rvod_sel_settings_int,
		rvod_sel_b_val	=>	rvod_sel_b_val_int,
		rpre_emph_e_val	=>	rpre_emph_e_val_int,
		sup_mode	=>	sup_mode,
		rvod_sel_e_val	=>	rvod_sel_e_val_int,
		rpre_emph_a_val	=>	rpre_emph_a_val_int,
		ctrl_plane_bonding_consumption	=>	ctrl_plane_bonding_consumption,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		pcieswitch	=>	pcieswitch,
		piperxclk	=>	piperxclk,
		pipetxclk	=>	pipetxclk,
		polinvrx	=>	polinvrx,
		powerstatetransitiondone	=>	powerstatetransitiondone,
		powerstatetransitiondoneena	=>	powerstatetransitiondoneena,
		powerdown	=>	powerdown,
		refclkb	=>	refclkb,
		refclkbreset	=>	refclkbreset,
		revloopbkpcsgen3	=>	revloopbkpcsgen3,
		revloopback	=>	revloopback,
		rxdetectvalid	=>	rxdetectvalid,
		rxfound	=>	rxfound,
		rxpipereset	=>	rxpipereset,
		rxd	=>	rxd,
		rxelectricalidle	=>	rxelectricalidle,
		rxpolarity	=>	rxpolarity,
		sigdetni	=>	sigdetni,
		speedchange	=>	speedchange,
		speedchangechnldown	=>	speedchangechnldown,
		speedchangechnlup	=>	speedchangechnlup,
		txelecidlecomp	=>	txelecidlecomp,
		txpipereset	=>	txpipereset,
		txdch	=>	txdch,
		txdeemph	=>	txdeemph,
		txdetectrxloopback	=>	txdetectrxloopback,
		txelecidlein	=>	txelecidlein,
		txmargin	=>	txmargin,
		txswingport	=>	txswingport,
		currentcoeff	=>	currentcoeff,
		phystatus	=>	phystatus,
		polinvrxint	=>	polinvrxint,
		revloopbk	=>	revloopbk,
		rxdch	=>	rxdch,
		rxelecidle	=>	rxelecidle,
		rxelectricalidleout	=>	rxelectricalidleout,
		rxstatus	=>	rxstatus,
		rxvalid	=>	rxvalid,
		speedchangeout	=>	speedchangeout,
		txelecidleout	=>	txelecidleout,
		txd	=>	txd,
		txdetectrx	=>	txdetectrx,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_pma_aux	is
	generic	(
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
end	cyclonev_hssi_pma_aux;

architecture behavior of cyclonev_hssi_pma_aux is

component	cyclonev_hssi_pma_aux_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_pma_aux_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		cal_clk_sel	=>	cal_clk_sel,
		cal_result_status	=>	cal_result_status,
		continuous_calibration	=>	continuous_calibration,
		pm_aux_cal_clk_test_sel	=>	pm_aux_cal_clk_test_sel,
		rx_cal_override_value	=>	rx_cal_override_value,
		rx_cal_override_value_enable	=>	rx_cal_override_value_enable,
		rx_imp	=>	rx_imp,
		test_counter_enable	=>	test_counter_enable,
		tx_cal_override_value	=>	tx_cal_override_value,
		tx_cal_override_value_enable	=>	tx_cal_override_value_enable,
		tx_imp	=>	tx_imp,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		atb0out	=>	atb0out,
		atb1out	=>	atb1out,
		calclk	=>	calclk,
		calpdb	=>	calpdb,
		refiqclk	=>	refiqclk,
		testcntl	=>	testcntl,
		nonusertoio	=>	nonusertoio,
		zrxtx50	=>	zrxtx50
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_pma_int	is
	generic	(
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
end	cyclonev_hssi_pma_int;

architecture behavior of cyclonev_hssi_pma_int is

component	cyclonev_hssi_pma_int_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_pma_int_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		channel_number	=>	channel_number,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address,
		cvp_mode	=>	cvp_mode,
		early_eios_sel	=>	early_eios_sel,
		ffclk_enable	=>	ffclk_enable,
		iqtxrxclk_a_sel	=>	iqtxrxclk_a_sel,
		iqtxrxclk_b_sel	=>	iqtxrxclk_b_sel,
		ltr_sel	=>	ltr_sel,
		pcie_switch_sel	=>	pcie_switch_sel,
		pclk_0_clk_sel	=>	pclk_0_clk_sel,
		pclk_1_clk_sel	=>	pclk_1_clk_sel,
		tx_elec_idle_sel	=>	tx_elec_idle_sel,
		txdetectrx_sel	=>	txdetectrx_sel
	)
	port map	(
		bslip	=>	bslip,
		ccrurstb	=>	ccrurstb,
		cearlyeios	=>	cearlyeios,
		clkdivrxi	=>	clkdivrxi,
		clkdivtxi	=>	clkdivtxi,
		clklowi	=>	clklowi,
		cltd	=>	cltd,
		cltr	=>	cltr,
		cpcieswitch	=>	cpcieswitch,
		crslpbk	=>	crslpbk,
		ctxdetectrx	=>	ctxdetectrx,
		ctxelecidle	=>	ctxelecidle,
		ctxpmarstb	=>	ctxpmarstb,
		earlyeios	=>	earlyeios,
		frefi	=>	frefi,
		hclkpcsi	=>	hclkpcsi,
		icoeff	=>	icoeff,
		ltr	=>	ltr,
		pcieswdonei	=>	pcieswdonei,
		pcieswitch	=>	pcieswitch,
		pcsrxclkout	=>	pcsrxclkout,
		pcstxclkout	=>	pcstxclkout,
		pfdmodelocki	=>	pfdmodelocki,
		pldclk	=>	pldclk,
		ppmlock	=>	ppmlock,
		rxdetclk	=>	rxdetclk,
		rxdetectvalidi	=>	rxdetectvalidi,
		rxfoundi	=>	rxfoundi,
		rxplllocki	=>	rxplllocki,
		rxpmarstb	=>	rxpmarstb,
		sdi	=>	sdi,
		testbusi	=>	testbusi,
		testsel	=>	testsel,
		txdetectrx	=>	txdetectrx,
		txelecidle	=>	txelecidle,
		bslipo	=>	bslipo,
		clklow	=>	clklow,
		cpcieswdone	=>	cpcieswdone,
		cpclk	=>	cpclk,
		cpfdmodelock	=>	cpfdmodelock,
		crurstbo	=>	crurstbo,
		crxdetectvalid	=>	crxdetectvalid,
		crxfound	=>	crxfound,
		crxplllock	=>	crxplllock,
		csd	=>	csd,
		earlyeioso	=>	earlyeioso,
		fref	=>	fref,
		hclkpcs	=>	hclkpcs,
		icoeffo	=>	icoeffo,
		iqtxrxclka	=>	iqtxrxclka,
		iqtxrxclkb	=>	iqtxrxclkb,
		ltdo	=>	ltdo,
		ltro	=>	ltro,
		pcieswdone	=>	pcieswdone,
		pcieswitcho	=>	pcieswitcho,
		pfdmodelock	=>	pfdmodelock,
		pldclko	=>	pldclko,
		ppmlocko	=>	ppmlocko,
		rxdetclko	=>	rxdetclko,
		rxdetectvalid	=>	rxdetectvalid,
		rxfound	=>	rxfound,
		rxplllock	=>	rxplllock,
		rxpmarstbo	=>	rxpmarstbo,
		sd	=>	sd,
		slpbko	=>	slpbko,
		testbus	=>	testbus,
		testselo	=>	testselo,
		txdetectrxo	=>	txdetectrxo,
		txelecidleo	=>	txelecidleo,
		txpmarstbo	=>	txpmarstbo,
		avmmrstn	=>	avmmrstn,
		avmmclk	=>	avmmclk,
		avmmwrite	=>	avmmwrite,
		avmmread	=>	avmmread,
		avmmbyteen	=>	avmmbyteen,
		avmmaddress	=>	avmmaddress,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_pma_rx_buf	is
	generic	(
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
end	cyclonev_hssi_pma_rx_buf;

architecture behavior of cyclonev_hssi_pma_rx_buf is

component	cyclonev_hssi_pma_rx_buf_encrypted
	generic	(
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
		rx_acgain_v	:	string	:=	"vref_volt_1p0"
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

begin


inst : cyclonev_hssi_pma_rx_buf_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		cdrclk_to_cgb	=>	cdrclk_to_cgb,
		channel_number	=>	channel_number,
		diagnostic_loopback	=>	diagnostic_loopback,
		pdb_sd	=>	pdb_sd,
		rx_dc_gain	=>	rx_dc_gain,
		sd_off	=>	sd_off,
		sd_on	=>	sd_on,
		sd_threshold	=>	sd_threshold,
		term_sel	=>	term_sel,
		vcm_current_add	=>	vcm_current_add,
		vcm_sel	=>	vcm_sel,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address,
		rx_sel_half_bw	=>	rx_sel_half_bw,
		rx_acgain_a	=>	rx_acgain_a,
		rx_acgain_v	=>	rx_acgain_v
	)
	port map	(
		ck0sigdet	=>	ck0sigdet,
		datain	=>	datain,
		hardoccalen	=>	hardoccalen,
		lpbkp	=>	lpbkp,
		rstn	=>	rstn,
		slpbk	=>	slpbk,
		dataout	=>	dataout,
		nonuserfrompmaux	=>	nonuserfrompmaux,
		rdlpbkp	=>	rdlpbkp,
		sd	=>	sd,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmrstn	=>	avmmrstn,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_pma_rx_deser	is
	generic	(
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
end	cyclonev_hssi_pma_rx_deser;

architecture behavior of cyclonev_hssi_pma_rx_deser is

component	cyclonev_hssi_pma_rx_deser_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_pma_rx_deser_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		auto_negotiation	=>	auto_negotiation,
		channel_number	=>	channel_number,
		clk_forward_only_mode	=>	clk_forward_only_mode,
		enable_bit_slip	=>	enable_bit_slip,
		mode	=>	mode,
		sdclk_enable	=>	sdclk_enable,
		vco_bypass	=>	vco_bypass,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address,
		pma_direct	=>	pma_direct
	)
	port map	(
		bslip	=>	bslip,
		clk270b	=>	clk270b,
		clk90b	=>	clk90b,
		deven	=>	deven,
		dodd	=>	dodd,
		pciesw	=>	pciesw,
		rstn	=>	rstn,
		clkdivrx	=>	clkdivrx,
		clkdivrxrx	=>	clkdivrxrx,
		dout	=>	dout,
		pciel	=>	pciel,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmrstn	=>	avmmrstn,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_pma_tx_buf	is
	generic	(
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
end	cyclonev_hssi_pma_tx_buf;

architecture behavior of cyclonev_hssi_pma_tx_buf is

component	cyclonev_hssi_pma_tx_buf_encrypted
	generic	(
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
		cml_en	:	string	:=	"no_cml"
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

begin


inst : cyclonev_hssi_pma_tx_buf_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		channel_number	=>	channel_number,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address,
		common_mode_driver_sel	=>	common_mode_driver_sel,
		driver_resolution_ctrl	=>	driver_resolution_ctrl,
		fir_coeff_ctrl_sel	=>	fir_coeff_ctrl_sel,
		local_ib_ctl	=>	local_ib_ctl,
		lst	=>	lst,
		pre_emp_switching_ctrl_1st_post_tap	=>	pre_emp_switching_ctrl_1st_post_tap,
		rx_det	=>	rx_det,
		rx_det_pdb	=>	rx_det_pdb,
		slew_rate_ctrl	=>	slew_rate_ctrl,
		swing_boost	=>	swing_boost,
		term_sel	=>	term_sel,
		vcm_current_addl	=>	vcm_current_addl,
		vod_boost	=>	vod_boost,
		vod_switching_ctrl_main_tap	=>	vod_switching_ctrl_main_tap,
		local_ib_en	=>	local_ib_en,
		cml_en	=>	cml_en
	)
	port map	(
		avgvon	=>	avgvon,
		avgvop	=>	avgvop,
		datain	=>	datain,
		icoeff	=>	icoeff,
		rxdetclk	=>	rxdetclk,
		txdetrx	=>	txdetrx,
		txelecidl	=>	txelecidl,
		vrlpbkn	=>	vrlpbkn,
		vrlpbkn1t	=>	vrlpbkn1t,
		vrlpbkp	=>	vrlpbkp,
		vrlpbkp1t	=>	vrlpbkp1t,
		compass	=>	compass,
		dataout	=>	dataout,
		detecton	=>	detecton,
		fixedclkout	=>	fixedclkout,
		nonuserfrompmaux	=>	nonuserfrompmaux,
		probepass	=>	probepass,
		rxdetectvalid	=>	rxdetectvalid,
		rxfound	=>	rxfound,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_pma_tx_cgb	is
	generic	(
		enable_debug_info	:	string	:=	"false";
		reserved_transmit_channel	:	string	:=	"false";
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
		x1_clock7_logical_to_physical_mapping	:	string	:=	"x1_clk_unused"
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
end	cyclonev_hssi_pma_tx_cgb;

architecture behavior of cyclonev_hssi_pma_tx_cgb is

component	cyclonev_hssi_pma_tx_cgb_encrypted
	generic	(
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
		x1_clock7_logical_to_physical_mapping	:	string	:=	"x1_clk_unused"
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

begin


inst : cyclonev_hssi_pma_tx_cgb_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		auto_negotiation	=>	auto_negotiation,
		cgb_iqclk_sel	=>	cgb_iqclk_sel,
		cgb_sync	=>	cgb_sync,
		channel_number	=>	channel_number,
		clk_mute	=>	clk_mute,
		data_rate	=>	data_rate,
		mode	=>	mode,
		reset_scheme	=>	reset_scheme,
		tx_mux_power_down	=>	tx_mux_power_down,
		x1_clock_source_sel	=>	x1_clock_source_sel,
		x1_div_m_sel	=>	x1_div_m_sel,
		xn_clock_source_sel	=>	xn_clock_source_sel,
		pcie_rst	=>	pcie_rst,
		fref_vco_bypass	=>	fref_vco_bypass,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address,
		x1_clock0_logical_to_physical_mapping	=>	x1_clock0_logical_to_physical_mapping,
		x1_clock1_logical_to_physical_mapping	=>	x1_clock1_logical_to_physical_mapping,
		x1_clock2_logical_to_physical_mapping	=>	x1_clock2_logical_to_physical_mapping,
		x1_clock3_logical_to_physical_mapping	=>	x1_clock3_logical_to_physical_mapping,
		x1_clock4_logical_to_physical_mapping	=>	x1_clock4_logical_to_physical_mapping,
		x1_clock5_logical_to_physical_mapping	=>	x1_clock5_logical_to_physical_mapping,
		x1_clock6_logical_to_physical_mapping	=>	x1_clock6_logical_to_physical_mapping,
		x1_clock7_logical_to_physical_mapping	=>	x1_clock7_logical_to_physical_mapping
	)
	port map	(
		clkbcdr1b	=>	clkbcdr1b,
		clkbcdr1t	=>	clkbcdr1t,
		clkbcdrloc	=>	clkbcdrloc,
		clkbdnseg	=>	clkbdnseg,
		clkbffpll	=>	clkbffpll,
		clkbupseg	=>	clkbupseg,
		clkcdr1b	=>	clkcdr1b,
		clkcdr1t	=>	clkcdr1t,
		clkcdrloc	=>	clkcdrloc,
		clkdnseg	=>	clkdnseg,
		clkffpll	=>	clkffpll,
		clkupseg	=>	clkupseg,
		cpulsex6dn	=>	cpulsex6dn,
		cpulsex6up	=>	cpulsex6up,
		cpulsexndn	=>	cpulsexndn,
		cpulsexnup	=>	cpulsexnup,
		hfclknx6dn	=>	hfclknx6dn,
		hfclknx6up	=>	hfclknx6up,
		hfclknxndn	=>	hfclknxndn,
		hfclknxnup	=>	hfclknxnup,
		hfclkpx6dn	=>	hfclkpx6dn,
		hfclkpx6up	=>	hfclkpx6up,
		hfclkpxndn	=>	hfclkpxndn,
		hfclkpxnup	=>	hfclkpxnup,
		lfclknx6dn	=>	lfclknx6dn,
		lfclknx6up	=>	lfclknx6up,
		lfclknxndn	=>	lfclknxndn,
		lfclknxnup	=>	lfclknxnup,
		lfclkpx6dn	=>	lfclkpx6dn,
		lfclkpx6up	=>	lfclkpx6up,
		lfclkpxndn	=>	lfclkpxndn,
		lfclkpxnup	=>	lfclkpxnup,
		pciesw	=>	pciesw,
		pclkx6dn	=>	pclkx6dn,
		pclkx6up	=>	pclkx6up,
		pclkxndn	=>	pclkxndn,
		pclkxnup	=>	pclkxnup,
		rstn	=>	rstn,
		rxclk	=>	rxclk,
		cpulse	=>	cpulse,
		cpulseout	=>	cpulseout,
		hfclkn	=>	hfclkn,
		hfclknout	=>	hfclknout,
		hfclkp	=>	hfclkp,
		hfclkpout	=>	hfclkpout,
		lfclkn	=>	lfclkn,
		lfclknout	=>	lfclknout,
		lfclkp	=>	lfclkp,
		lfclkpout	=>	lfclkpout,
		pcieswdone	=>	pcieswdone,
		pciesyncp	=>	pciesyncp,
		pclk	=>	pclk,
		pclkout	=>	pclkout,
		rxiqclk	=>	rxiqclk,
		fref	=>	fref,
		pcsrstn	=>	pcsrstn,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.CYCLONEV_HSSI_COMPONENTS.all;


entity	cyclonev_hssi_pma_tx_ser	is
	generic	(
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
end	cyclonev_hssi_pma_tx_ser;

architecture behavior of cyclonev_hssi_pma_tx_ser is

constant forced_data_mode_int	:	integer	:= bin2int(forced_data_mode);

component	cyclonev_hssi_pma_tx_ser_encrypted
	generic	(
		enable_debug_info	:	string	:=	"false";
		auto_negotiation	:	string	:=	"false";
		channel_number	:	integer	:=	0;
		clk_divtx_deskew	:	integer	:=	0;
		clk_forward_only_mode	:	string	:=	"false";
		forced_data_mode	:	integer	:=	0;
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

begin


inst : cyclonev_hssi_pma_tx_ser_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		auto_negotiation	=>	auto_negotiation,
		channel_number	=>	channel_number,
		clk_divtx_deskew	=>	clk_divtx_deskew,
		clk_forward_only_mode	=>	clk_forward_only_mode,
		forced_data_mode	=>	forced_data_mode_int,
		mode	=>	mode,
		post_tap_1_en	=>	post_tap_1_en,
		ser_loopback	=>	ser_loopback,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address,
		pma_direct	=>	pma_direct,
		duty_cycle_tune	=>	duty_cycle_tune
	)
	port map	(
		cpulse	=>	cpulse,
		datain	=>	datain,
		hfclk	=>	hfclk,
		hfclkn	=>	hfclkn,
		lfclk	=>	lfclk,
		lfclkn	=>	lfclkn,
		pclk	=>	pclk,
		rstn	=>	rstn,
		slpbk	=>	slpbk,
		clkdivtx	=>	clkdivtx,
		dataout	=>	dataout,
		lbvop	=>	lbvop,
		preenout	=>	preenout,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmrstn	=>	avmmrstn,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect,
		avgvon	=>	avgvon,
		avgvop	=>	avgvop
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_pma_cdr_refclk_select_mux	is
	generic	(
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
end	cyclonev_hssi_pma_cdr_refclk_select_mux;

architecture behavior of cyclonev_hssi_pma_cdr_refclk_select_mux is

component	cyclonev_hssi_pma_cdr_refclk_select_mux_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_pma_cdr_refclk_select_mux_encrypted
	generic map	(
		lpm_type	=>	lpm_type,
		channel_number	=>	channel_number,
		mux_type	=>	mux_type,
		refclk_select	=>	refclk_select,
		reference_clock_frequency	=>	reference_clock_frequency,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address,
		inclk0_logical_to_physical_mapping	=>	inclk0_logical_to_physical_mapping,
		inclk1_logical_to_physical_mapping	=>	inclk1_logical_to_physical_mapping,
		inclk2_logical_to_physical_mapping	=>	inclk2_logical_to_physical_mapping,
		inclk3_logical_to_physical_mapping	=>	inclk3_logical_to_physical_mapping,
		inclk4_logical_to_physical_mapping	=>	inclk4_logical_to_physical_mapping,
		inclk5_logical_to_physical_mapping	=>	inclk5_logical_to_physical_mapping,
		inclk6_logical_to_physical_mapping	=>	inclk6_logical_to_physical_mapping,
		inclk7_logical_to_physical_mapping	=>	inclk7_logical_to_physical_mapping,
		inclk8_logical_to_physical_mapping	=>	inclk8_logical_to_physical_mapping,
		inclk9_logical_to_physical_mapping	=>	inclk9_logical_to_physical_mapping,
		inclk10_logical_to_physical_mapping	=>	inclk10_logical_to_physical_mapping,
		inclk11_logical_to_physical_mapping	=>	inclk11_logical_to_physical_mapping,
		inclk12_logical_to_physical_mapping	=>	inclk12_logical_to_physical_mapping,
		inclk13_logical_to_physical_mapping	=>	inclk13_logical_to_physical_mapping,
		inclk14_logical_to_physical_mapping	=>	inclk14_logical_to_physical_mapping,
		inclk15_logical_to_physical_mapping	=>	inclk15_logical_to_physical_mapping,
		inclk16_logical_to_physical_mapping	=>	inclk16_logical_to_physical_mapping,
		inclk17_logical_to_physical_mapping	=>	inclk17_logical_to_physical_mapping,
		inclk18_logical_to_physical_mapping	=>	inclk18_logical_to_physical_mapping,
		inclk19_logical_to_physical_mapping	=>	inclk19_logical_to_physical_mapping,
		inclk20_logical_to_physical_mapping	=>	inclk20_logical_to_physical_mapping,
		inclk21_logical_to_physical_mapping	=>	inclk21_logical_to_physical_mapping,
		inclk22_logical_to_physical_mapping	=>	inclk22_logical_to_physical_mapping,
		inclk23_logical_to_physical_mapping	=>	inclk23_logical_to_physical_mapping,
		inclk24_logical_to_physical_mapping	=>	inclk24_logical_to_physical_mapping,
		inclk25_logical_to_physical_mapping	=>	inclk25_logical_to_physical_mapping
	)
	port map	(
		calclk	=>	calclk,
		refclklc	=>	calclk,
		occalen		=>	calclk,
		ffplloutbot	=>	ffplloutbot,
		ffpllouttop	=>	ffpllouttop,
		pldclk	=>	pldclk,
		refiqclk0	=>	refiqclk0,
		refiqclk1	=>	refiqclk1,
		refiqclk10	=>	refiqclk10,
		refiqclk2	=>	refiqclk2,
		refiqclk3	=>	refiqclk3,
		refiqclk4	=>	refiqclk4,
		refiqclk5	=>	refiqclk5,
		refiqclk6	=>	refiqclk6,
		refiqclk7	=>	refiqclk7,
		refiqclk8	=>	refiqclk8,
		refiqclk9	=>	refiqclk9,
		rxiqclk0	=>	rxiqclk0,
		rxiqclk1	=>	rxiqclk1,
		rxiqclk10	=>	rxiqclk10,
		rxiqclk2	=>	rxiqclk2,
		rxiqclk3	=>	rxiqclk3,
		rxiqclk4	=>	rxiqclk4,
		rxiqclk5	=>	rxiqclk5,
		rxiqclk6	=>	rxiqclk6,
		rxiqclk7	=>	rxiqclk7,
		rxiqclk8	=>	rxiqclk8,
		rxiqclk9	=>	rxiqclk9,
		avmmclk	=>	avmmclk,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmread	=>	avmmread,
		avmmbyteen	=>	avmmbyteen,
		avmmaddress	=>	avmmaddress,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect,
		clkout	=>	clkout
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_rx_pcs_pma_interface	is
	generic	(
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
end	cyclonev_hssi_rx_pcs_pma_interface;

architecture behavior of cyclonev_hssi_rx_pcs_pma_interface is

component	cyclonev_hssi_rx_pcs_pma_interface_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_rx_pcs_pma_interface_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		selectpcs	=>	selectpcs,
		clkslip_sel	=>	clkslip_sel,
		prot_mode	=>	prot_mode,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		pcs8grxclkiqout	=>	pcs8grxclkiqout,
		pcs8grxclkslip	=>	pcs8grxclkslip,
		pldrxclkslip	=>	pldrxclkslip,
		pldrxpmarstb	=>	pldrxpmarstb,
		pmareservedin	=>	pmareservedin,
		datainfrompma	=>	datainfrompma,
		pmarxpllphaselockin	=>	pmarxpllphaselockin,
		clockinfrompma	=>	clockinfrompma,
		pmasigdet	=>	pmasigdet,
		dataoutto8gpcs	=>	dataoutto8gpcs,
		clockoutto8gpcs	=>	clockoutto8gpcs,
		pcs8gsigdetni	=>	pcs8gsigdetni,
		pmareservedout	=>	pmareservedout,
		pmarxclkout	=>	pmarxclkout,
		pmarxpllphaselockout	=>	pmarxpllphaselockout,
		pmarxclkslip	=>	pmarxclkslip,
		pmarxpmarstb	=>	pmarxpmarstb,
		asynchdatain	=>	asynchdatain,
		reset	=>	reset,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_rx_pld_pcs_interface	is
	generic	(
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
end	cyclonev_hssi_rx_pld_pcs_interface;

architecture behavior of cyclonev_hssi_rx_pld_pcs_interface is

component	cyclonev_hssi_rx_pld_pcs_interface_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_rx_pld_pcs_interface_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		is_8g_0ppm	=>	is_8g_0ppm,
		pcs_side_block_sel	=>	pcs_side_block_sel,
		pld_side_data_source	=>	pld_side_data_source,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		emsipenablediocsrrdydly	=>	emsipenablediocsrrdydly,
		emsiprxspecialin	=>	emsiprxspecialin,
		pcs8ga1a2k1k2flag	=>	pcs8ga1a2k1k2flag,
		pcs8galignstatus	=>	pcs8galignstatus,
		pcs8gbistdone	=>	pcs8gbistdone,
		pcs8gbisterr	=>	pcs8gbisterr,
		pcs8gbyteordflag	=>	pcs8gbyteordflag,
		pcs8gemptyrmf	=>	pcs8gemptyrmf,
		pcs8gemptyrx	=>	pcs8gemptyrx,
		pcs8gfullrmf	=>	pcs8gfullrmf,
		pcs8gfullrx	=>	pcs8gfullrx,
		pcs8grlvlt	=>	pcs8grlvlt,
		clockinfrom8gpcs	=>	clockinfrom8gpcs,
		pcs8grxdatavalid	=>	pcs8grxdatavalid,
		datainfrom8gpcs	=>	datainfrom8gpcs,
		pcs8gsignaldetectout	=>	pcs8gsignaldetectout,
		pcs8gwaboundary	=>	pcs8gwaboundary,
		pld8ga1a2size	=>	pld8ga1a2size,
		pld8gbitlocreven	=>	pld8gbitlocreven,
		pld8gbitslip	=>	pld8gbitslip,
		pld8gbytereven	=>	pld8gbytereven,
		pld8gbytordpld	=>	pld8gbytordpld,
		pld8gcmpfifourstn	=>	pld8gcmpfifourstn,
		pld8gencdt	=>	pld8gencdt,
		pld8gphfifourstrxn	=>	pld8gphfifourstrxn,
		pld8gpldrxclk	=>	pld8gpldrxclk,
		pld8gpolinvrx	=>	pld8gpolinvrx,
		pld8grdenablermf	=>	pld8grdenablermf,
		pld8grdenablerx	=>	pld8grdenablerx,
		pld8grxurstpcsn	=>	pld8grxurstpcsn,
		pld8gwrdisablerx	=>	pld8gwrdisablerx,
		pld8gwrenablermf	=>	pld8gwrenablermf,
		pldrxclkslipin	=>	pldrxclkslipin,
		pldrxpmarstbin	=>	pldrxpmarstbin,
		pld8gsyncsmeninput	=>	pld8gsyncsmeninput,
		pmarxplllock	=>	pmarxplllock,
		rstsel	=>	rstsel,
		usrrstsel	=>	usrrstsel,
		emsiprxout	=>	emsiprxout,
		emsiprxspecialout	=>	emsiprxspecialout,
		pcs8ga1a2size	=>	pcs8ga1a2size,
		pcs8gbitlocreven	=>	pcs8gbitlocreven,
		pcs8gbitslip	=>	pcs8gbitslip,
		pcs8gbytereven	=>	pcs8gbytereven,
		pcs8gbytordpld	=>	pcs8gbytordpld,
		pcs8gcmpfifourst	=>	pcs8gcmpfifourst,
		pcs8gencdt	=>	pcs8gencdt,
		pcs8gphfifourstrx	=>	pcs8gphfifourstrx,
		pcs8gpldrxclk	=>	pcs8gpldrxclk,
		pcs8gpolinvrx	=>	pcs8gpolinvrx,
		pcs8grdenablermf	=>	pcs8grdenablermf,
		pcs8grdenablerx	=>	pcs8grdenablerx,
		pcs8grxurstpcs	=>	pcs8grxurstpcs,
		pcs8gsyncsmenoutput	=>	pcs8gsyncsmenoutput,
		pcs8gwrdisablerx	=>	pcs8gwrdisablerx,
		pcs8gwrenablermf	=>	pcs8gwrenablermf,
		pld8ga1a2k1k2flag	=>	pld8ga1a2k1k2flag,
		pld8galignstatus	=>	pld8galignstatus,
		pld8gbistdone	=>	pld8gbistdone,
		pld8gbisterr	=>	pld8gbisterr,
		pld8gbyteordflag	=>	pld8gbyteordflag,
		pld8gemptyrmf	=>	pld8gemptyrmf,
		pld8gemptyrx	=>	pld8gemptyrx,
		pld8gfullrmf	=>	pld8gfullrmf,
		pld8gfullrx	=>	pld8gfullrx,
		pld8grlvlt	=>	pld8grlvlt,
		pld8grxclkout	=>	pld8grxclkout,
		pld8grxdatavalid	=>	pld8grxdatavalid,
		pld8gsignaldetectout	=>	pld8gsignaldetectout,
		pld8gwaboundary	=>	pld8gwaboundary,
		pldrxclkslipout	=>	pldrxclkslipout,
		dataouttopld	=>	dataouttopld,
		pldrxpmarstbout	=>	pldrxpmarstbout,
		asynchdatain	=>	asynchdatain,
		reset	=>	reset,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmrstn	=>	avmmrstn,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_tx_pcs_pma_interface	is
	generic	(
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
end	cyclonev_hssi_tx_pcs_pma_interface;

architecture behavior of cyclonev_hssi_tx_pcs_pma_interface is

component	cyclonev_hssi_tx_pcs_pma_interface_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_tx_pcs_pma_interface_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		selectpcs	=>	selectpcs,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		datainfrom8gpcs	=>	datainfrom8gpcs,
		pcs8gtxclkiqout	=>	pcs8gtxclkiqout,
		pmarxfreqtxcmuplllockin	=>	pmarxfreqtxcmuplllockin,
		clockinfrompma	=>	clockinfrompma,
		clockoutto8gpcs	=>	clockoutto8gpcs,
		pmarxfreqtxcmuplllockout	=>	pmarxfreqtxcmuplllockout,
		pmatxclkout	=>	pmatxclkout,
		dataouttopma	=>	dataouttopma,
		asynchdatain	=>	asynchdatain,
		reset	=>	reset,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_tx_pld_pcs_interface	is
	generic	(
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
end	cyclonev_hssi_tx_pld_pcs_interface;

architecture behavior of cyclonev_hssi_tx_pld_pcs_interface is

component	cyclonev_hssi_tx_pld_pcs_interface_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_tx_pld_pcs_interface_encrypted
	generic map	(
		enable_debug_info	=>	enable_debug_info,
		is_8g_0ppm	=>	is_8g_0ppm,
		pld_side_data_source	=>	pld_side_data_source,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address
	)
	port map	(
		emsipenablediocsrrdydly	=>	emsipenablediocsrrdydly,
		emsiptxin	=>	emsiptxin,
		emsiptxspecialin	=>	emsiptxspecialin,
		pcs8gemptytx	=>	pcs8gemptytx,
		pcs8gfulltx	=>	pcs8gfulltx,
		clockinfrom8gpcs	=>	clockinfrom8gpcs,
		pld8gphfifoursttxn	=>	pld8gphfifoursttxn,
		pld8gpldtxclk	=>	pld8gpldtxclk,
		pld8gpolinvtx	=>	pld8gpolinvtx,
		pld8grddisabletx	=>	pld8grddisabletx,
		pld8grevloopbk	=>	pld8grevloopbk,
		pld8gtxboundarysel	=>	pld8gtxboundarysel,
		pld8gtxdatavalid	=>	pld8gtxdatavalid,
		pld8gtxurstpcsn	=>	pld8gtxurstpcsn,
		pld8gwrenabletx	=>	pld8gwrenabletx,
		datainfrompld	=>	datainfrompld,
		pmatxcmuplllock	=>	pmatxcmuplllock,
		rstsel	=>	rstsel,
		usrrstsel	=>	usrrstsel,
		emsippcstxclkout	=>	emsippcstxclkout,
		emsiptxspecialout	=>	emsiptxspecialout,
		pcs8gphfifoursttx	=>	pcs8gphfifoursttx,
		pcs8gpldtxclk	=>	pcs8gpldtxclk,
		pcs8gpolinvtx	=>	pcs8gpolinvtx,
		pcs8grddisabletx	=>	pcs8grddisabletx,
		pcs8grevloopbk	=>	pcs8grevloopbk,
		pcs8gtxboundarysel	=>	pcs8gtxboundarysel,
		pcs8gtxdatavalid	=>	pcs8gtxdatavalid,
		dataoutto8gpcs	=>	dataoutto8gpcs,
		pcs8gtxurstpcs	=>	pcs8gtxurstpcs,
		pcs8gwrenabletx	=>	pcs8gwrenabletx,
		pld8gemptytx	=>	pld8gemptytx,
		pld8gfulltx	=>	pld8gfulltx,
		pld8gtxclkout	=>	pld8gtxclkout,
		asynchdatain	=>	asynchdatain,
		reset	=>	reset,
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmrstn	=>	avmmrstn,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_refclk_divider	is
	generic	(
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
end	cyclonev_hssi_refclk_divider;

architecture behavior of cyclonev_hssi_refclk_divider is

component	cyclonev_hssi_refclk_divider_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_refclk_divider_encrypted
	generic map	(
		lpm_type	=>	lpm_type,
		divide_by	=>	divide_by,
		enabled	=>	enabled,
		refclk_coupling_termination	=>	refclk_coupling_termination
	)
	port map	(
		refclkin	=>	refclkin,
		refclkout	=>	refclkout,
		nonuserfrompmaux	=>	nonuserfrompmaux
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_pll_aux	is
	generic	(
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
end	cyclonev_pll_aux;

architecture behavior of cyclonev_pll_aux is

begin

--empty


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_channel_pll	is
	generic	(
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
end	cyclonev_channel_pll;

architecture behavior of cyclonev_channel_pll is

component	cyclonev_channel_pll_encrypted
	generic	(
		sim_use_fast_model	:	string	:=	"true";
		enable_debug_info	:	string	:=	"false";
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

begin


inst : cyclonev_channel_pll_encrypted
	generic map	(
		sim_use_fast_model	=>	sim_use_fast_model,
		enable_debug_info	=>	enable_debug_info,
		avmm_group_channel_index	=>	avmm_group_channel_index,
		use_default_base_address	=>	use_default_base_address,
		user_base_address	=>	user_base_address,
		reference_clock_frequency	=>	reference_clock_frequency,
		output_clock_frequency	=>	output_clock_frequency,
		enabled_for_reconfig	=>	enabled_for_reconfig,
		bbpd_salatch_offset_ctrl_clk0	=>	bbpd_salatch_offset_ctrl_clk0,
		bbpd_salatch_offset_ctrl_clk180	=>	bbpd_salatch_offset_ctrl_clk180,
		bbpd_salatch_offset_ctrl_clk270	=>	bbpd_salatch_offset_ctrl_clk270,
		bbpd_salatch_offset_ctrl_clk90	=>	bbpd_salatch_offset_ctrl_clk90,
		bbpd_salatch_sel	=>	bbpd_salatch_sel,
		bypass_cp_rgla	=>	bypass_cp_rgla,
		cdr_atb_select	=>	cdr_atb_select,
		cgb_clk_enable	=>	cgb_clk_enable,
		charge_pump_current_test	=>	charge_pump_current_test,
		clklow_fref_to_ppm_div_sel	=>	clklow_fref_to_ppm_div_sel,
		clock_monitor	=>	clock_monitor,
		diag_rev_lpbk	=>	diag_rev_lpbk,
		enable_gpon_detection	=>	enable_gpon_detection,
		fast_lock_mode	=>	fast_lock_mode,
		fb_sel	=>	fb_sel,
		hs_levshift_power_supply_setting	=>	hs_levshift_power_supply_setting,
		ignore_phslock	=>	ignore_phslock,
		l_counter_pd_clock_disable	=>	l_counter_pd_clock_disable,
		m_counter	=>	m_counter,
		pcie_freq_control	=>	pcie_freq_control,
		pd_charge_pump_current_ctrl	=>	pd_charge_pump_current_ctrl,
		pd_l_counter	=>	pd_l_counter,
		pfd_charge_pump_current_ctrl	=>	pfd_charge_pump_current_ctrl,
		pfd_l_counter	=>	pfd_l_counter,
		powerdown	=>	powerdown,
		ref_clk_div	=>	ref_clk_div,
		regulator_volt_inc	=>	regulator_volt_inc,
		replica_bias_ctrl	=>	replica_bias_ctrl,
		reverse_serial_lpbk	=>	reverse_serial_lpbk,
		ripple_cap_ctrl	=>	ripple_cap_ctrl,
		rxpll_pd_bw_ctrl	=>	rxpll_pd_bw_ctrl,
		rxpll_pfd_bw_ctrl	=>	rxpll_pfd_bw_ctrl,
		txpll_hclk_driver_enable	=>	txpll_hclk_driver_enable,
		vco_overange_ref	=>	vco_overange_ref,
		vco_range_ctrl_en	=>	vco_range_ctrl_en
	)
	port map	(
		avmmaddress	=>	avmmaddress,
		avmmbyteen	=>	avmmbyteen,
		avmmclk	=>	avmmclk,
		avmmread	=>	avmmread,
		avmmrstn	=>	avmmrstn,
		avmmwrite	=>	avmmwrite,
		avmmwritedata	=>	avmmwritedata,
		avmmreaddata	=>	avmmreaddata,
		blockselect	=>	blockselect,
		clkindeser	=>	clkindeser,
		crurstb	=>	crurstb,
		earlyeios	=>	earlyeios,
		extclk	=>	extclk,
		lpbkpreen	=>	lpbkpreen,
		ltd	=>	ltd,
		ltr	=>	ltr,
		occalen	=>	occalen,
		pciel	=>	pciel,
		pciesw	=>	pciesw,
		ppmlock	=>	ppmlock,
		refclk	=>	refclk,
		rstn	=>	rstn,
		rxp	=>	rxp,
		sd	=>	sd,
		ck0pd	=>	ck0pd,
		ck180pd	=>	ck180pd,
		ck270pd	=>	ck270pd,
		ck90pd	=>	ck90pd,
		clk270bdes	=>	clk270bdes,
		clk90bdes	=>	clk90bdes,
		clkcdr	=>	clkcdr,
		clklow	=>	clklow,
		deven	=>	deven,
		dodd	=>	dodd,
		fref	=>	fref,
		pdof	=>	pdof,
		pfdmodelock	=>	pfdmodelock,
		rxlpbdp	=>	rxlpbdp,
		rxlpbp	=>	rxlpbp,
		rxplllock	=>	rxplllock,
		txpllhclk	=>	txpllhclk,
		txrlpbk	=>	txrlpbk,
		vctrloverrange	=>	vctrloverrange
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_avmm_interface	is
	generic	(
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
end	cyclonev_hssi_avmm_interface;

architecture behavior of cyclonev_hssi_avmm_interface is

component	cyclonev_hssi_avmm_interface_encrypted
	generic	(
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

begin


inst : cyclonev_hssi_avmm_interface_encrypted
	generic map	(
		num_ch0_atoms	=>	num_ch0_atoms,
		num_ch1_atoms	=>	num_ch1_atoms,
		num_ch2_atoms	=>	num_ch2_atoms
	)
	port map	(
		avmmrstn	=>	avmmrstn,
		avmmclk	=>	avmmclk,
		avmmwrite	=>	avmmwrite,
		avmmread	=>	avmmread,
		avmmbyteen	=>	avmmbyteen,
		avmmaddress	=>	avmmaddress,
		avmmwritedata	=>	avmmwritedata,
		blockselect	=>	blockselect,
		readdatachnl	=>	readdatachnl,
		avmmreaddata	=>	avmmreaddata,
		clkchnl	=>	clkchnl,
		rstnchnl	=>	rstnchnl,
		writedatachnl	=>	writedatachnl,
		regaddrchnl	=>	regaddrchnl,
		writechnl	=>	writechnl,
		readchnl	=>	readchnl,
		byteenchnl	=>	byteenchnl,
		refclkdig	=>	refclkdig,
		avmmreservedin	=>	avmmreservedin,
		avmmreservedout	=>	avmmreservedout,
		dpriorstntop	=>	dpriorstntop,
		dprioclktop	=>	dprioclktop,
		mdiodistopchnl	=>	mdiodistopchnl,
		dpriorstnmid	=>	dpriorstnmid,
		dprioclkmid	=>	dprioclkmid,
		mdiodismidchnl	=>	mdiodismidchnl,
		dpriorstnbot	=>	dpriorstnbot,
		dprioclkbot	=>	dprioclkbot,
		mdiodisbotchnl	=>	mdiodisbotchnl,
		dpriotestsitopchnl	=>	dpriotestsitopchnl,
		dpriotestsimidchnl	=>	dpriotestsimidchnl,
		dpriotestsibotchnl	=>	dpriotestsibotchnl,
		pmatestbussel	=>	pmatestbussel,
		pmatestbus	=>	pmatestbus,
		scanmoden	=>	scanmoden,
		scanshiftn	=>	scanshiftn,
		interfacesel	=>	interfacesel,
		sershiftload	=>	sershiftload
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_pma_hi_pmaif	is
	generic	(
		lpm_type	:	string	:=	"cyclonev_hssi_pma_hi_pmaif";
		tx_pma_direction_sel	:	string	:=	"pcs"
	);
	port	(
		datainfromcore	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		datainfrompcs	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		dataouttopma	:	out	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
	);
end	cyclonev_hssi_pma_hi_pmaif;

architecture behavior of cyclonev_hssi_pma_hi_pmaif is

component	cyclonev_hssi_pma_hi_pmaif_encrypted
	generic	(
		tx_pma_direction_sel	:	string	:=	"pcs"
	);
	port	(
		datainfromcore	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		datainfrompcs	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		dataouttopma	:	out	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
	);
end component;

begin


inst : cyclonev_hssi_pma_hi_pmaif_encrypted
	generic map	(
		tx_pma_direction_sel	=>	tx_pma_direction_sel
	)
	port map	(
		datainfromcore	=>	datainfromcore,
		datainfrompcs	=>	datainfrompcs,
		dataouttopma	=>	dataouttopma
	);


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity	cyclonev_hssi_pma_hi_xcvrif	is
	generic	(
		lpm_type	:	string	:=	"cyclonev_hssi_pma_hi_xcvrif";
		rx_pma_direction_sel	:	string	:=	"pcs"
	);
	port	(
		datainfrompma	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		datainfrompcs	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		dataouttopld	:	out	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
	);
end	cyclonev_hssi_pma_hi_xcvrif;

architecture behavior of cyclonev_hssi_pma_hi_xcvrif is

component	cyclonev_hssi_pma_hi_xcvrif_encrypted
	generic	(
		rx_pma_direction_sel	:	string	:=	"pcs"
	);
	port	(
		datainfrompma	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		datainfrompcs	:	in	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		dataouttopld	:	out	std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
	);
end component;

begin


inst : cyclonev_hssi_pma_hi_xcvrif_encrypted
	generic map	(
		rx_pma_direction_sel	=>	rx_pma_direction_sel
	)
	port map	(
		datainfrompma	=>	datainfrompma,
		datainfrompcs	=>	datainfrompcs,
		dataouttopld	=>	dataouttopld
	);


end behavior;

