-- Copyright (C) 1991-2010 Altera Corporation
-- This simulation model contains highly confidential and
-- proprietary information of Altera and is being provided
-- in accordance with and subject to the protections of the
-- applicable Altera Program License Subscription Agreement
-- which governs its use and disclosure. Your use of Altera
-- Corporation's design tools, logic functions and other
-- software and tools, and its AMPP partner logic functions,
-- and any output files any of the foregoing (including device
-- programming or simulation files), and any associated
-- documentation or information are expressly subject to the
-- terms and conditions of the Altera Program License Subscription
-- Agreement, Altera MegaCore Function License Agreement, or other
-- applicable license agreement, including, without limitation,
-- that your use is for the sole purpose of simulating designs for
-- use exclusively in logic devices manufactured by Altera and sold
-- by Altera or its authorized distributors. Please refer to the
-- applicable agreement for further details. Altera products and
-- services are protected under numerous U.S. and foreign patents,
-- maskwork rights, copyrights and other intellectual property laws.
-- Altera assumes no responsibility or liability arising out of the
-- application or use of this simulation model.

library ieee;
use ieee.std_logic_1164.all;

package altera_lnsim_components is

component altera_pll 
    generic(
        reference_clock_frequency: string  := "0 ps";
        fractional_vco_multiplier : string := "false";
        pll_type        : string  := "General";
        pll_subtype        : string  := "General";
        number_of_clocks: integer := 1;
        operation_mode  : string  := "internal feedback";
        deserialization_factor: integer := 4;
        data_rate       : integer := 0;
        sim_additional_refclk_cycles_to_lock: integer := 0;
        output_clock_frequency0: string  := "0 ps";
        phase_shift0    : string  := "0 ps";
        duty_cycle0     : integer := 50;
        output_clock_frequency1: string  := "0 ps";
        phase_shift1    : string  := "0 ps";
        duty_cycle1     : integer := 50;
        output_clock_frequency2: string  := "0 ps";
        phase_shift2    : string  := "0 ps";
        duty_cycle2     : integer := 50;
        output_clock_frequency3: string  := "0 ps";
        phase_shift3    : string  := "0 ps";
        duty_cycle3     : integer := 50;
        output_clock_frequency4: string  := "0 ps";
        phase_shift4    : string  := "0 ps";
        duty_cycle4     : integer := 50;
        output_clock_frequency5: string  := "0 ps";
        phase_shift5    : string  := "0 ps";
        duty_cycle5     : integer := 50;
        output_clock_frequency6: string  := "0 ps";
        phase_shift6    : string  := "0 ps";
        duty_cycle6     : integer := 50;
        output_clock_frequency7: string  := "0 ps";
        phase_shift7    : string  := "0 ps";
        duty_cycle7     : integer := 50;
        output_clock_frequency8: string  := "0 ps";
        phase_shift8    : string  := "0 ps";
        duty_cycle8     : integer := 50;
        output_clock_frequency9: string  := "0 ps";
        phase_shift9    : string  := "0 ps";
        duty_cycle9     : integer := 50;
        output_clock_frequency10: string  := "0 ps";
        phase_shift10   : string  := "0 ps";
        duty_cycle10    : integer := 50;
        output_clock_frequency11: string  := "0 ps";
        phase_shift11   : string  := "0 ps";
        duty_cycle11    : integer := 50;
        output_clock_frequency12: string  := "0 ps";
        phase_shift12   : string  := "0 ps";
        duty_cycle12    : integer := 50;
        output_clock_frequency13: string  := "0 ps";
        phase_shift13   : string  := "0 ps";
        duty_cycle13    : integer := 50;
        output_clock_frequency14: string  := "0 ps";
        phase_shift14   : string  := "0 ps";
        duty_cycle14    : integer := 50;
        output_clock_frequency15: string  := "0 ps";
        phase_shift15   : string  := "0 ps";
        duty_cycle15    : integer := 50;
        output_clock_frequency16: string  := "0 ps";
        phase_shift16   : string  := "0 ps";
        duty_cycle16    : integer := 50;
        output_clock_frequency17: string  := "0 ps";
        phase_shift17   : string  := "0 ps";
        duty_cycle17    : integer := 50;

        m_cnt_hi_div :integer := 1;
        m_cnt_lo_div :integer := 1;
        m_cnt_bypass_en :string := "false";
        m_cnt_odd_div_duty_en :string := "false";
        n_cnt_hi_div :integer :=  1;
        n_cnt_lo_div :integer :=  1;
        n_cnt_bypass_en :string := "false";
        n_cnt_odd_div_duty_en :string := "false";
        c_cnt_hi_div0 :integer :=  1;
        c_cnt_lo_div0 :integer :=  1;
        c_cnt_bypass_en0 :string := "false";
        c_cnt_in_src0 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en0 :string := "false";
        c_cnt_prst0 :integer := 1;
        c_cnt_ph_mux_prst0 :integer := 0;
        c_cnt_hi_div1 :integer :=  1;
        c_cnt_lo_div1 :integer :=  1;
        c_cnt_bypass_en1 :string := "false";
        c_cnt_in_src1 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en1 :string := "false";
        c_cnt_prst1 :integer := 1;
        c_cnt_ph_mux_prst1 :integer := 0;
        c_cnt_hi_div2 :integer :=  1;
        c_cnt_lo_div2 :integer :=  1;
        c_cnt_bypass_en2 :string := "false";
        c_cnt_in_src2 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en2 :string := "false";
        c_cnt_prst2 :integer := 1;
        c_cnt_ph_mux_prst2 :integer := 0;
        c_cnt_hi_div3 :integer :=  1;
        c_cnt_lo_div3 :integer :=  1;
        c_cnt_bypass_en3 :string := "false";
        c_cnt_in_src3 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en3 :string := "false";
        c_cnt_prst3 :integer := 1;
        c_cnt_ph_mux_prst3 :integer := 0;
        c_cnt_hi_div4 :integer :=  1;
        c_cnt_lo_div4 :integer :=  1;
        c_cnt_bypass_en4 :string := "false";
        c_cnt_in_src4 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en4 :string := "false";
        c_cnt_prst4 :integer := 1;
        c_cnt_ph_mux_prst4 :integer := 0;
        c_cnt_hi_div5 :integer :=  1;
        c_cnt_lo_div5 :integer :=  1;
        c_cnt_bypass_en5 :string := "false";
        c_cnt_in_src5 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en5 :string := "false";
        c_cnt_prst5 :integer := 1;
        c_cnt_ph_mux_prst5 :integer := 0;
        c_cnt_hi_div6 :integer :=  1;
        c_cnt_lo_div6 :integer :=  1;
        c_cnt_bypass_en6 :string := "false";
        c_cnt_in_src6 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en6 :string := "false";
        c_cnt_prst6 :integer := 1;
        c_cnt_ph_mux_prst6 :integer := 0;
        c_cnt_hi_div7 :integer :=  1;
        c_cnt_lo_div7 :integer :=  1;
        c_cnt_bypass_en7 :string := "false";
        c_cnt_in_src7 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en7 :string := "false";
        c_cnt_prst7 :integer := 1;
        c_cnt_ph_mux_prst7 :integer := 0;
        c_cnt_hi_div8 :integer :=  1;
        c_cnt_lo_div8 :integer :=  1;
        c_cnt_bypass_en8 :string := "false";
        c_cnt_in_src8 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en8 :string := "false";
        c_cnt_prst8 :integer := 1;
        c_cnt_ph_mux_prst8 :integer := 0;
        c_cnt_hi_div9 :integer :=  1;
        c_cnt_lo_div9 :integer :=  1;
        c_cnt_bypass_en9 :string := "false";
        c_cnt_in_src9 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en9 :string := "false";
        c_cnt_prst9 :integer := 1;
        c_cnt_ph_mux_prst9 :integer := 0;
        c_cnt_hi_div10 :integer :=  1;
        c_cnt_lo_div10 :integer :=  1;
        c_cnt_bypass_en10 :string := "false";
        c_cnt_in_src10 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en10 :string := "false";
        c_cnt_prst10 :integer := 1;
        c_cnt_ph_mux_prst10 :integer := 0;
        c_cnt_hi_div11 :integer :=  1;
        c_cnt_lo_div11 :integer :=  1;
        c_cnt_bypass_en11 :string := "false";
        c_cnt_in_src11 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en11 :string := "false";
        c_cnt_prst11 :integer := 1;
        c_cnt_ph_mux_prst11 :integer := 0;
        c_cnt_hi_div12 :integer :=  1;
        c_cnt_lo_div12 :integer :=  1;
        c_cnt_bypass_en12 :string := "false";
        c_cnt_in_src12 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en12 :string := "false";
        c_cnt_prst12 :integer := 1;
        c_cnt_ph_mux_prst12 :integer := 0;
        c_cnt_hi_div13 :integer :=  1;
        c_cnt_lo_div13 :integer :=  1;
        c_cnt_bypass_en13 :string := "false";
        c_cnt_in_src13 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en13 :string := "false";
        c_cnt_prst13 :integer := 1;
        c_cnt_ph_mux_prst13 :integer := 0;
        c_cnt_hi_div14 :integer :=  1;
        c_cnt_lo_div14 :integer :=  1;
        c_cnt_bypass_en14 :string := "false";
        c_cnt_in_src14 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en14 :string := "false";
        c_cnt_prst14 :integer := 1;
        c_cnt_ph_mux_prst14 :integer := 0;
        c_cnt_hi_div15 :integer :=  1;
        c_cnt_lo_div15 :integer :=  1;
        c_cnt_bypass_en15 :string := "false";
        c_cnt_in_src15 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en15 :string := "false";
        c_cnt_prst15 :integer := 1;
        c_cnt_ph_mux_prst15 :integer := 0;
        c_cnt_hi_div16 :integer :=  1;
        c_cnt_lo_div16 :integer :=  1;
        c_cnt_bypass_en16 :string := "false";
        c_cnt_in_src16 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en16 :string := "false";
        c_cnt_prst16 :integer := 1;
        c_cnt_ph_mux_prst16 :integer := 0;
        c_cnt_hi_div17 :integer :=  1;
        c_cnt_lo_div17 :integer :=  1;
        c_cnt_bypass_en17 :string := "false";
        c_cnt_in_src17 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en17 :string := "false";
        c_cnt_prst17 :integer := 1;
        c_cnt_ph_mux_prst17 :integer := 0;
        pll_vco_div :integer :=  0;
        pll_bwctrl :integer :=  0;
        pll_cp_current :integer :=  0;
        pll_fractional_division :integer :=  0;
        pll_fractional_cout :integer :=  24;
		pll_dsm_out_sel :string := "1st_order";
        pll_output_clk_frequency :string := "0 MHz";
        refclk1_frequency :string := "0 MHz";
        pll_clkin_0_src :string := "clk_0";
        pll_clkin_1_src :string := "clk_0";
        pll_clk_loss_sw_en :string := "false";
        pll_auto_clk_sw_en :string := "false";
        pll_manu_clk_sw_en :string := "false";
        mimic_fbclk_type :string:= "gclk";
        pll_fbclk_mux_1 :string:= "glb";
        pll_fbclk_mux_2 :string:= "fb_1";
        pll_m_cnt_in_src :string:= "ph_mux_clk";
        pll_vcoph_div : integer := 1;
        pll_clk_sw_dly :integer := 0;
		pll_slf_rst :string := "false";
		pll_bw_sel :string := "low";
		pll_extclk_0_cnt_src :string := "pll_extclk_cnt_src_vss";
		pll_extclk_1_cnt_src :string := "pll_extclk_cnt_src_vss";

		clock_name_0 : string := "";
		clock_name_1 : string := "";
		clock_name_2 : string := "";
		clock_name_3 : string := "";
		clock_name_4 : string := "";
		clock_name_5 : string := "";
		clock_name_6 : string := "";
		clock_name_7 : string := "";
		clock_name_8 : string := "";
		clock_name_global_0 : string := "false";
		clock_name_global_1 : string := "false";
		clock_name_global_2 : string := "false";
		clock_name_global_3 : string := "false";
		clock_name_global_4 : string := "false";
		clock_name_global_5 : string := "false";
		clock_name_global_6 : string := "false";
		clock_name_global_7 : string := "false";
		clock_name_global_8 : string := "false"		
        );
    port(
        refclk          : in    std_logic := '0';
        refclk1         : in    std_logic := '0';
		adjpllin		: in	std_logic := '0';
		cclk			: in	std_logic := '0';
        fbclk           : in    std_logic := '0';
        scanclk         : in    std_logic := '0';
        rst             : in    std_logic := '0';
        extswitch       : in    std_logic := '0';
        phase_en        : in    std_logic := '0';
        updn            : in    std_logic := '0';
        cntsel          : in    std_logic_vector(4 downto 0):= (others => '0');
        num_phase_shifts          : in    std_logic_vector(2 downto 0):= (others => '0');

        reconfig_to_pll : in    std_logic_vector(63 downto 0) := (others => '0');
        outclk          : out   std_logic_vector(number_of_clocks - 1 downto 0);
        cascade_out     : out   std_logic_vector(number_of_clocks - 1 downto 0);
        fboutclk        : out   std_logic;
        locked          : out   std_logic;
        phase_done      : out   std_logic;
        activeclk       : out   std_logic;
        clkbad          : out   std_logic_vector(1 downto 0);
        phout 		: out   std_logic_vector(7 downto 0);
        lvds_clk 		: out   std_logic_vector(1 downto 0);
        loaden 			: out   std_logic_vector(1 downto 0);
        extclk_out 		: out   std_logic_vector(1 downto 0);
        reconfig_from_pll : out    std_logic_vector(63 downto 0);
        zdbfbclk        : inout std_logic
    );
end component;

component altera_iopll 
    generic(
        reference_clock_frequency: string  := "0 ps";
        pll_type        : string  := "General";
        pll_subtype        : string  := "General";
        number_of_clocks: integer := 1;
        operation_mode  : string  := "internal feedback";
        output_clock_frequency0: string  := "0 ps";
        phase_shift0    : string  := "0 ps";
        duty_cycle0     : integer := 50;
        output_clock_frequency1: string  := "0 ps";
        phase_shift1    : string  := "0 ps";
        duty_cycle1     : integer := 50;
        output_clock_frequency2: string  := "0 ps";
        phase_shift2    : string  := "0 ps";
        duty_cycle2     : integer := 50;
        output_clock_frequency3: string  := "0 ps";
        phase_shift3    : string  := "0 ps";
        duty_cycle3     : integer := 50;
        output_clock_frequency4: string  := "0 ps";
        phase_shift4    : string  := "0 ps";
        duty_cycle4     : integer := 50;
        output_clock_frequency5: string  := "0 ps";
        phase_shift5    : string  := "0 ps";
        duty_cycle5     : integer := 50;
        output_clock_frequency6: string  := "0 ps";
        phase_shift6    : string  := "0 ps";
        duty_cycle6     : integer := 50;
        output_clock_frequency7: string  := "0 ps";
        phase_shift7    : string  := "0 ps";
        duty_cycle7     : integer := 50;
        output_clock_frequency8: string  := "0 ps";
        phase_shift8    : string  := "0 ps";
        duty_cycle8     : integer := 50;
        m_cnt_hi_div :integer := 1;
        m_cnt_lo_div :integer := 1;
        m_cnt_bypass_en :string := "false";
        m_cnt_odd_div_duty_en :string := "false";
        n_cnt_hi_div :integer :=  1;
        n_cnt_lo_div :integer :=  1;
        n_cnt_bypass_en :string := "false";
        n_cnt_odd_div_duty_en :string := "false";
        c_cnt_hi_div0 :integer :=  1;
        c_cnt_lo_div0 :integer :=  1;
        c_cnt_bypass_en0 :string := "false";
        c_cnt_in_src0 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en0 :string := "false";
        c_cnt_prst0 :integer := 1;
        c_cnt_ph_mux_prst0 :integer := 0;
        c_cnt_hi_div1 :integer :=  1;
        c_cnt_lo_div1 :integer :=  1;
        c_cnt_bypass_en1 :string := "false";
        c_cnt_in_src1 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en1 :string := "false";
        c_cnt_prst1 :integer := 1;
        c_cnt_ph_mux_prst1 :integer := 0;
        c_cnt_hi_div2 :integer :=  1;
        c_cnt_lo_div2 :integer :=  1;
        c_cnt_bypass_en2 :string := "false";
        c_cnt_in_src2 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en2 :string := "false";
        c_cnt_prst2 :integer := 1;
        c_cnt_ph_mux_prst2 :integer := 0;
        c_cnt_hi_div3 :integer :=  1;
        c_cnt_lo_div3 :integer :=  1;
        c_cnt_bypass_en3 :string := "false";
        c_cnt_in_src3 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en3 :string := "false";
        c_cnt_prst3 :integer := 1;
        c_cnt_ph_mux_prst3 :integer := 0;
        c_cnt_hi_div4 :integer :=  1;
        c_cnt_lo_div4 :integer :=  1;
        c_cnt_bypass_en4 :string := "false";
        c_cnt_in_src4 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en4 :string := "false";
        c_cnt_prst4 :integer := 1;
        c_cnt_ph_mux_prst4 :integer := 0;
        c_cnt_hi_div5 :integer :=  1;
        c_cnt_lo_div5 :integer :=  1;
        c_cnt_bypass_en5 :string := "false";
        c_cnt_in_src5 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en5 :string := "false";
        c_cnt_prst5 :integer := 1;
        c_cnt_ph_mux_prst5 :integer := 0;
        c_cnt_hi_div6 :integer :=  1;
        c_cnt_lo_div6 :integer :=  1;
        c_cnt_bypass_en6 :string := "false";
        c_cnt_in_src6 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en6 :string := "false";
        c_cnt_prst6 :integer := 1;
        c_cnt_ph_mux_prst6 :integer := 0;
        c_cnt_hi_div7 :integer :=  1;
        c_cnt_lo_div7 :integer :=  1;
        c_cnt_bypass_en7 :string := "false";
        c_cnt_in_src7 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en7 :string := "false";
        c_cnt_prst7 :integer := 1;
        c_cnt_ph_mux_prst7 :integer := 0;
        c_cnt_hi_div8 :integer :=  1;
        c_cnt_lo_div8 :integer :=  1;
        c_cnt_bypass_en8 :string := "false";
        c_cnt_in_src8 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en8 :string := "false";
        c_cnt_prst8 :integer := 1;
        c_cnt_ph_mux_prst8 :integer := 0;
        pll_bwctrl :integer :=  0;
        pll_cp_current :integer :=  0;
        pll_output_clk_frequency :string := "0 MHz";
        pll_clkin_0_src :string := "clk_0";
        pll_clkin_1_src :string := "clk_0";
        pll_clk_loss_sw_en :string := "false";
        pll_auto_clk_sw_en :string := "false";
        pll_manu_clk_sw_en :string := "false";
        pll_fbclk_mux_1 :string:= "glb";
        pll_fbclk_mux_2 :string:= "fb_1";
        pll_m_cnt_in_src :string:= "ph_mux_clk";
        pll_clk_sw_dly :integer := 0;
		pll_slf_rst :string := "false";
		pll_bw_sel :string := "low";
		pll_extclk_0_cnt_src :string := "pll_extclk_cnt_src_vss";
		pll_extclk_1_cnt_src :string := "pll_extclk_cnt_src_vss";		
		clock_name_0 : string := "";
		clock_name_1 : string := "";
		clock_name_2 : string := "";
		clock_name_3 : string := "";
		clock_name_4 : string := "";
		clock_name_5 : string := "";
		clock_name_6 : string := "";
		clock_name_7 : string := "";
		clock_name_8 : string := "";
		clock_name_global_0 : string := "false";
		clock_name_global_1 : string := "false";
		clock_name_global_2 : string := "false";
		clock_name_global_3 : string := "false";
		clock_name_global_4 : string := "false";
		clock_name_global_5 : string := "false";
		clock_name_global_6 : string := "false";
		clock_name_global_7 : string := "false";
		clock_name_global_8 : string := "false"		
        );
    port(
        refclk            : in    std_logic := '0';
        refclk1           : in    std_logic := '0';
		adjpllin		  : in	std_logic := '0';
        fbclk             : in    std_logic := '0';
        scanclk           : in    std_logic := '0';
        rst               : in    std_logic := '0';
        extswitch         : in    std_logic := '0';
        phase_en          : in    std_logic := '0';
        updn              : in    std_logic := '0';
        cntsel            : in    std_logic_vector(3 downto 0):= (others => '0');
        num_phase_shifts  : in    std_logic_vector(2 downto 0):= (others => '0');
        reconfig_to_pll   : in    std_logic_vector(63 downto 0) := (others => '0');

        outclk            : out   std_logic_vector(number_of_clocks - 1 downto 0);
        cascade_out       : out   std_logic_vector(number_of_clocks - 1 downto 0);
        fboutclk          : out   std_logic;
        locked            : out   std_logic;
        phase_done        : out   std_logic;
        activeclk         : out   std_logic;
        clkbad            : out   std_logic_vector(1 downto 0);
        phout 		      : out   std_logic_vector(7 downto 0);
        lvds_clk 	 	  : out   std_logic_vector(1 downto 0);
        loaden 		      : out   std_logic_vector(1 downto 0);
        extclk_out 		  : out   std_logic_vector(1 downto 0);
        reconfig_from_pll : out    std_logic_vector(63 downto 0);
        zdbfbclk          : inout std_logic	
    );
end component;

component fourteennm_altera_iopll 
    generic(
        reference_clock_frequency: string  := "0 ps";
        pll_type        : string  := "General";
        pll_subtype        : string  := "General";
        number_of_clocks: integer := 1;
        operation_mode  : string  := "internal feedback";
        output_clock_frequency0: string  := "0 ps";
        phase_shift0    : string  := "0 ps";
        duty_cycle0     : integer := 50;
        output_clock_frequency1: string  := "0 ps";
        phase_shift1    : string  := "0 ps";
        duty_cycle1     : integer := 50;
        output_clock_frequency2: string  := "0 ps";
        phase_shift2    : string  := "0 ps";
        duty_cycle2     : integer := 50;
        output_clock_frequency3: string  := "0 ps";
        phase_shift3    : string  := "0 ps";
        duty_cycle3     : integer := 50;
        output_clock_frequency4: string  := "0 ps";
        phase_shift4    : string  := "0 ps";
        duty_cycle4     : integer := 50;
        output_clock_frequency5: string  := "0 ps";
        phase_shift5    : string  := "0 ps";
        duty_cycle5     : integer := 50;
        output_clock_frequency6: string  := "0 ps";
        phase_shift6    : string  := "0 ps";
        duty_cycle6     : integer := 50;
        output_clock_frequency7: string  := "0 ps";
        phase_shift7    : string  := "0 ps";
        duty_cycle7     : integer := 50;
        output_clock_frequency8: string  := "0 ps";
        phase_shift8    : string  := "0 ps";
        duty_cycle8     : integer := 50;
        m_cnt_hi_div :integer := 1;
        m_cnt_lo_div :integer := 1;
        m_cnt_bypass_en :string := "false";
        m_cnt_odd_div_duty_en :string := "false";
        n_cnt_hi_div :integer :=  1;
        n_cnt_lo_div :integer :=  1;
        n_cnt_bypass_en :string := "false";
        n_cnt_odd_div_duty_en :string := "false";
        c_cnt_hi_div0 :integer :=  1;
        c_cnt_lo_div0 :integer :=  1;
        c_cnt_bypass_en0 :string := "false";
        c_cnt_in_src0 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en0 :string := "false";
        c_cnt_prst0 :integer := 1;
        c_cnt_ph_mux_prst0 :integer := 0;
        c_cnt_hi_div1 :integer :=  1;
        c_cnt_lo_div1 :integer :=  1;
        c_cnt_bypass_en1 :string := "false";
        c_cnt_in_src1 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en1 :string := "false";
        c_cnt_prst1 :integer := 1;
        c_cnt_ph_mux_prst1 :integer := 0;
        c_cnt_hi_div2 :integer :=  1;
        c_cnt_lo_div2 :integer :=  1;
        c_cnt_bypass_en2 :string := "false";
        c_cnt_in_src2 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en2 :string := "false";
        c_cnt_prst2 :integer := 1;
        c_cnt_ph_mux_prst2 :integer := 0;
        c_cnt_hi_div3 :integer :=  1;
        c_cnt_lo_div3 :integer :=  1;
        c_cnt_bypass_en3 :string := "false";
        c_cnt_in_src3 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en3 :string := "false";
        c_cnt_prst3 :integer := 1;
        c_cnt_ph_mux_prst3 :integer := 0;
        c_cnt_hi_div4 :integer :=  1;
        c_cnt_lo_div4 :integer :=  1;
        c_cnt_bypass_en4 :string := "false";
        c_cnt_in_src4 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en4 :string := "false";
        c_cnt_prst4 :integer := 1;
        c_cnt_ph_mux_prst4 :integer := 0;
        c_cnt_hi_div5 :integer :=  1;
        c_cnt_lo_div5 :integer :=  1;
        c_cnt_bypass_en5 :string := "false";
        c_cnt_in_src5 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en5 :string := "false";
        c_cnt_prst5 :integer := 1;
        c_cnt_ph_mux_prst5 :integer := 0;
        c_cnt_hi_div6 :integer :=  1;
        c_cnt_lo_div6 :integer :=  1;
        c_cnt_bypass_en6 :string := "false";
        c_cnt_in_src6 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en6 :string := "false";
        c_cnt_prst6 :integer := 1;
        c_cnt_ph_mux_prst6 :integer := 0;
        c_cnt_hi_div7 :integer :=  1;
        c_cnt_lo_div7 :integer :=  1;
        c_cnt_bypass_en7 :string := "false";
        c_cnt_in_src7 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en7 :string := "false";
        c_cnt_prst7 :integer := 1;
        c_cnt_ph_mux_prst7 :integer := 0;
        c_cnt_hi_div8 :integer :=  1;
        c_cnt_lo_div8 :integer :=  1;
        c_cnt_bypass_en8 :string := "false";
        c_cnt_in_src8 :string := "ph_mux_clk";
        c_cnt_odd_div_duty_en8 :string := "false";
        c_cnt_prst8 :integer := 1;
        c_cnt_ph_mux_prst8 :integer := 0;
        pll_bwctrl :integer :=  0;
        pll_cp_current :integer :=  0;
        pll_output_clk_frequency :string := "0 MHz";
        pll_clkin_0_src :string := "clk_0";
        pll_clkin_1_src :string := "clk_0";
        pll_clk_loss_sw_en :string := "false";
        pll_auto_clk_sw_en :string := "false";
        pll_manu_clk_sw_en :string := "false";
        pll_fbclk_mux_1 :string:= "glb";
        pll_fbclk_mux_2 :string:= "fb_1";
        pll_m_cnt_in_src :string:= "ph_mux_clk";
        pll_clk_sw_dly :integer := 0;
		pll_slf_rst :string := "false";
		pll_bw_sel :string := "low";
		pll_extclk_0_cnt_src :string := "pll_extclk_cnt_src_vss";
		pll_extclk_1_cnt_src :string := "pll_extclk_cnt_src_vss";		
		clock_name_0 : string := "";
		clock_name_1 : string := "";
		clock_name_2 : string := "";
		clock_name_3 : string := "";
		clock_name_4 : string := "";
		clock_name_5 : string := "";
		clock_name_6 : string := "";
		clock_name_7 : string := "";
		clock_name_8 : string := "";
		clock_name_global_0 : string := "false";
		clock_name_global_1 : string := "false";
		clock_name_global_2 : string := "false";
		clock_name_global_3 : string := "false";
		clock_name_global_4 : string := "false";
		clock_name_global_5 : string := "false";
		clock_name_global_6 : string := "false";
		clock_name_global_7 : string := "false";
		clock_name_global_8 : string := "false"		
        );
    port(
        refclk            : in    std_logic := '0';
        refclk1           : in    std_logic := '0';
		adjpllin		  : in	std_logic := '0';
        fbclk             : in    std_logic := '0';
        scanclk           : in    std_logic := '0';
        rst               : in    std_logic := '0';
        extswitch         : in    std_logic := '0';
        phase_en          : in    std_logic := '0';
        updn              : in    std_logic := '0';
        cntsel            : in    std_logic_vector(3 downto 0):= (others => '0');
        num_phase_shifts  : in    std_logic_vector(2 downto 0):= (others => '0');
        reconfig_to_pll   : in    std_logic_vector(63 downto 0) := (others => '0');

        outclk            : out   std_logic_vector(number_of_clocks - 1 downto 0);
        cascade_out       : out   std_logic_vector(number_of_clocks - 1 downto 0);
        fboutclk          : out   std_logic;
        locked            : out   std_logic;
        phase_done        : out   std_logic;
        activeclk         : out   std_logic;
        clkbad            : out   std_logic_vector(1 downto 0);
        phout 		      : out   std_logic_vector(7 downto 0);
        lvds_clk 	 	  : out   std_logic_vector(1 downto 0);
        loaden 		      : out   std_logic_vector(1 downto 0);
        extclk_out 		  : out   std_logic_vector(1 downto 0);
        reconfig_from_pll : out    std_logic_vector(63 downto 0);
        zdbfbclk          : inout std_logic	
    );
end component;

component altera_iopll_rotation_lcells
    generic(
        pll_type      : string  := "Arria 10"	
    );
    port(
        cntsel_user	   		:	in	std_logic_vector(3 downto 0) := (others => '0');
        cntsel_physical	   	:	out	std_logic_vector(3 downto 0)
    );
end component;

component altera_pll_dps_lcell_comb
    generic(
        family        : string  := "Stratix V";
        lut_mask      : std_logic_vector(63 downto 0) := (OTHERS => '1');
        dont_touch    : string  := "on"		
    );
    port(
        dataa				:	in	std_logic := '0';
        datab				:	in	std_logic := '0';
        datac				:	in	std_logic := '0';
        datad				:	in	std_logic := '0';
        datae				:	in	std_logic := '0';
        dataf				:	in	std_logic := '0';
        combout				:	out	std_logic
    );
end component;

component generic_pll 
    generic(
        lpm_type        : string  := "generic_pll";
        duty_cycle      : integer := 50;
        output_clock_frequency: string  := "0 ps";
        phase_shift     : string  := "0 ps";
        reference_clock_frequency: string  := "0 ps";
        sim_additional_refclk_cycles_to_lock: integer := 0;
		fractional_vco_multiplier: string := "false";
		use_khz : integer := 1;
		clock_name : string := "";
		clock_name_global : string := "false"
    );
    port(
        refclk				:	in	std_logic := '0';
        rst					:	in	std_logic := '0';
        fbclk				:	in	std_logic := '0';
		writerefclkdata		:	in	std_logic_vector(63 downto 0) := (others => '0');
		writeoutclkdata		:	in	std_logic_vector(63 downto 0) := (others => '0');
		writephaseshiftdata	:	in	std_logic_vector(63 downto 0) := (others => '0');
		writedutycycledata	:	in	std_logic_vector(63 downto 0) := (others => '0'); 

        outclk				:	out	std_logic;
        locked				:	out	std_logic;
        fboutclk			:	out	std_logic;
		readrefclkdata		:	out	std_logic_vector(63 downto 0); 
		readoutclkdata		:	out	std_logic_vector(63 downto 0); 
		readphaseshiftdata	:	out	std_logic_vector(63 downto 0);
		readdutycycledata	:	out	std_logic_vector(63 downto 0)
    );
end component;

component generic_cdr 
    generic(
        reference_clock_frequency: string  := "0 ps";
        output_clock_frequency: string  := "0 ps"
    );
    port(
        extclk          : in    std_logic;
        ltd             : in    std_logic;
        ltr             : in    std_logic;
        ppmlock         : in    std_logic;
        refclk          : in    std_logic;
        rst             : in    std_logic;
        sd              : in    std_logic;
        rxp             : in    std_logic;
        clk90bdes       : out   std_logic;
        clk270bdes      : out   std_logic;
        clklow          : out   std_logic;
        deven           : out   std_logic;
        dodd            : out   std_logic;
        fref            : out   std_logic;
        pfdmodelock     : out   std_logic;
        rxplllock       : out   std_logic
    );
end component;

COMPONENT generic_m20k
    GENERIC (
        operation_mode                 :  STRING := "single_port";    
        mixed_port_feed_through_mode   :  STRING := "dont_care";    
        ram_block_type                 :  STRING := "auto";    
        logical_ram_name               :  STRING := "ram_name";    
        init_file                      :  STRING := "init_file.hex";    
        init_file_layout               :  STRING := "none";    
        ecc_pipeline_stage_enabled     :  STRING := "false";
        enable_ecc                     :  STRING := "false";
        width_eccstatus                :  INTEGER := 2;   
        data_interleave_width_in_bits  :  INTEGER := 1;    
        data_interleave_offset_in_bits :  INTEGER := 1;    
        port_a_logical_ram_depth       :  INTEGER := 0;    
        port_a_logical_ram_width       :  INTEGER := 0;    
        port_a_first_address           :  INTEGER := 0;    
        port_a_last_address            :  INTEGER := 0;    
        port_a_first_bit_number        :  INTEGER := 0;    
        bist_ena                       :  STRING := "false";
        port_a_address_clear           :  STRING := "none";    
        port_a_data_out_clear          :  STRING := "none";    
        port_a_data_in_clock           :  STRING := "clock0";    
        port_a_address_clock           :  STRING := "clock0";    
        port_a_write_enable_clock      :  STRING := "clock0";    
        port_a_read_enable_clock       :  STRING := "clock0";           
        port_a_byte_enable_clock       :  STRING := "clock0";    
        port_a_data_out_clock          :  STRING := "none";    
        port_a_data_width              :  INTEGER := 1;    
        port_a_address_width           :  INTEGER := 1;    
        port_a_byte_enable_mask_width  :  INTEGER := 1;    
        port_b_logical_ram_depth       :  INTEGER := 0;    
        port_b_logical_ram_width       :  INTEGER := 0;    
        port_b_first_address           :  INTEGER := 0;    
        port_b_last_address            :  INTEGER := 0;    
        port_b_first_bit_number        :  INTEGER := 0;    
        port_b_address_clear           :  STRING := "none";    
        port_b_data_out_clear          :  STRING := "none";    
        port_b_data_in_clock           :  STRING := "clock1";    
        port_b_address_clock           :  STRING := "clock1";    
        port_b_write_enable_clock      :  STRING := "clock1";    
        port_b_read_enable_clock       :  STRING := "clock1";    
        port_b_byte_enable_clock       :  STRING := "clock1";    
        port_b_data_out_clock          :  STRING := "none";    
        port_b_data_width              :  INTEGER := 1;    
        port_b_address_width           :  INTEGER := 1;    
        port_b_byte_enable_mask_width  :  INTEGER := 1;    
        port_a_read_during_write_mode  :  STRING  := "new_data_no_nbe_read";
        port_b_read_during_write_mode  :  STRING  := "new_data_no_nbe_read";    
        power_up_uninitialized         :  STRING := "false";  
        port_b_byte_size               :  INTEGER := 0;
        port_a_byte_size               :  INTEGER := 0;  
        lpm_type                       :  STRING := "stratixv_ram_block";
        lpm_hint                       :  STRING := "true";
        clk0_input_clock_enable        :  STRING := "none"; -- ena0,ena2,none
        clk0_core_clock_enable         :  STRING := "none"; -- ena0,ena2,none
        clk0_output_clock_enable : STRING := "none"; -- ena0,none
        clk1_input_clock_enable  : STRING := "none"; -- ena1,ena3,none
        clk1_core_clock_enable   : STRING := "none"; -- ena1,ena3,none
        clk1_output_clock_enable : STRING := "none"; -- ena1,none
        mem_init0 : STRING := "";
        mem_init1 : STRING := "";
        mem_init2 : STRING := "";
        mem_init3 : STRING := "";
        mem_init4 : STRING := "";
        mem_init5 : STRING := "";
        mem_init6 : STRING := "";
        mem_init7 : STRING := "";
        mem_init8 : STRING := "";
        mem_init9 : STRING := "";
        connectivity_checking     : string := "off"
        );    
    PORT (
        portadatain             : IN STD_LOGIC_VECTOR(port_a_data_width - 1 DOWNTO 0)    := (OTHERS => '0');   
        portaaddr               : IN STD_LOGIC_VECTOR(port_a_address_width - 1 DOWNTO 0) := (OTHERS => '0');   
        portawe                 : IN STD_LOGIC := '0';   
        portare                 : IN STD_LOGIC := '1';   
        portbdatain             : IN STD_LOGIC_VECTOR(port_b_data_width - 1 DOWNTO 0)    := (OTHERS => '0');   
        portbaddr               : IN STD_LOGIC_VECTOR(port_b_address_width - 1 DOWNTO 0) := (OTHERS => '0');   
        portbwe                 : IN STD_LOGIC := '0';   
        portbre                 : IN STD_LOGIC := '1';   
        clk0                    : IN STD_LOGIC := '0';   
        clk1                    : IN STD_LOGIC := '0';   
        ena0                    : IN STD_LOGIC := '1';   
        ena1                    : IN STD_LOGIC := '1';   
        ena2                    : IN STD_LOGIC := '1';   
        ena3                    : IN STD_LOGIC := '1';   
        clr0                    : IN STD_LOGIC := '0';   
        clr1                    : IN STD_LOGIC := '0';   
        nerror                  : IN STD_LOGIC := '1';   
        portabyteenamasks       : IN STD_LOGIC_VECTOR(port_a_byte_enable_mask_width - 1 DOWNTO 0) := (OTHERS => '1');   
        portbbyteenamasks       : IN STD_LOGIC_VECTOR(port_b_byte_enable_mask_width - 1 DOWNTO 0) := (OTHERS => '1');   
        devclrn                 : IN STD_LOGIC := '1';   
        devpor                  : IN STD_LOGIC := '1';   
        portaaddrstall          : IN STD_LOGIC := '0';
        portbaddrstall          : IN STD_LOGIC := '0';
        eccstatus               : OUT STD_LOGIC_VECTOR(width_eccstatus - 1 DOWNTO 0) := (OTHERS => '0');
        dftout                  : OUT STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
        portadataout            : OUT STD_LOGIC_VECTOR(port_a_data_width - 1 DOWNTO 0);   
        portbdataout            : OUT STD_LOGIC_VECTOR(port_b_data_width - 1 DOWNTO 0)
        );
END COMPONENT;

COMPONENT generic_m10k
    GENERIC (
        operation_mode                 :  STRING := "single_port";    
        mixed_port_feed_through_mode   :  STRING := "dont_care";    
        ram_block_type                 :  STRING := "auto";    
        logical_ram_name               :  STRING := "ram_name";    
        init_file                      :  STRING := "init_file.hex";    
        init_file_layout               :  STRING := "none";    
        ecc_pipeline_stage_enabled     :  STRING := "false";
        enable_ecc                     :  STRING := "false";
        width_eccstatus                :  INTEGER := 2;   
        data_interleave_width_in_bits  :  INTEGER := 1;    
        data_interleave_offset_in_bits :  INTEGER := 1;    
        port_a_logical_ram_depth       :  INTEGER := 0;    
        port_a_logical_ram_width       :  INTEGER := 0;    
        port_a_first_address           :  INTEGER := 0;    
        port_a_last_address            :  INTEGER := 0;    
        port_a_first_bit_number        :  INTEGER := 0;    
        bist_ena                       :  STRING := "false";
        port_a_address_clear           :  STRING := "none";    
        port_a_data_out_clear          :  STRING := "none";    
        port_a_data_in_clock           :  STRING := "clock0";    
        port_a_address_clock           :  STRING := "clock0";    
        port_a_write_enable_clock      :  STRING := "clock0";    
        port_a_read_enable_clock       :  STRING := "clock0";           
        port_a_byte_enable_clock       :  STRING := "clock0";    
        port_a_data_out_clock          :  STRING := "none";    
        port_a_data_width              :  INTEGER := 1;    
        port_a_address_width           :  INTEGER := 1;    
        port_a_byte_enable_mask_width  :  INTEGER := 1;    
        port_b_logical_ram_depth       :  INTEGER := 0;    
        port_b_logical_ram_width       :  INTEGER := 0;    
        port_b_first_address           :  INTEGER := 0;    
        port_b_last_address            :  INTEGER := 0;    
        port_b_first_bit_number        :  INTEGER := 0;    
        port_b_address_clear           :  STRING := "none";    
        port_b_data_out_clear          :  STRING := "none";    
        port_b_data_in_clock           :  STRING := "clock1";    
        port_b_address_clock           :  STRING := "clock1";    
        port_b_write_enable_clock      :  STRING := "clock1";    
        port_b_read_enable_clock       :  STRING := "clock1";    
        port_b_byte_enable_clock       :  STRING := "clock1";    
        port_b_data_out_clock          :  STRING := "none";    
        port_b_data_width              :  INTEGER := 1;    
        port_b_address_width           :  INTEGER := 1;    
        port_b_byte_enable_mask_width  :  INTEGER := 1;    
        port_a_read_during_write_mode  :  STRING  := "new_data_no_nbe_read";
        port_b_read_during_write_mode  :  STRING  := "new_data_no_nbe_read";    
        power_up_uninitialized         :  STRING := "false";  
        port_b_byte_size               :  INTEGER := 0;
        port_a_byte_size               :  INTEGER := 0;  
        lpm_type                       :  STRING := "arriav_ram_block";
        lpm_hint                       :  STRING := "true";
        clk0_input_clock_enable        :  STRING := "none"; -- ena0,ena2,none
        clk0_core_clock_enable         :  STRING := "none"; -- ena0,ena2,none
        clk0_output_clock_enable       :  STRING := "none"; -- ena0,none
        clk1_input_clock_enable        :  STRING := "none"; -- ena1,ena3,none
        clk1_core_clock_enable         :  STRING := "none"; -- ena1,ena3,none
        clk1_output_clock_enable       :  STRING := "none"; -- ena1,none
        mem_init0                      :  STRING := "";
        mem_init1                      :  STRING := "";
        mem_init2                      :  STRING := "";
        mem_init3                      :  STRING := "";
        mem_init4                      :  STRING := "";
        connectivity_checking          :  STRING := "off"
        );    
    PORT (
        portadatain             : IN STD_LOGIC_VECTOR(port_a_data_width - 1 DOWNTO 0)    := (OTHERS => '0');   
        portaaddr               : IN STD_LOGIC_VECTOR(port_a_address_width - 1 DOWNTO 0) := (OTHERS => '0');   
        portawe                 : IN STD_LOGIC := '0';   
        portare                 : IN STD_LOGIC := '1';   
        portbdatain             : IN STD_LOGIC_VECTOR(port_b_data_width - 1 DOWNTO 0)    := (OTHERS => '0');   
        portbaddr               : IN STD_LOGIC_VECTOR(port_b_address_width - 1 DOWNTO 0) := (OTHERS => '0');   
        portbwe                 : IN STD_LOGIC := '0';   
        portbre                 : IN STD_LOGIC := '1';   
        clk0                    : IN STD_LOGIC := '0';   
        clk1                    : IN STD_LOGIC := '0';   
        ena0                    : IN STD_LOGIC := '1';   
        ena1                    : IN STD_LOGIC := '1';   
        ena2                    : IN STD_LOGIC := '1';   
        ena3                    : IN STD_LOGIC := '1';   
        clr0                    : IN STD_LOGIC := '0';   
        clr1                    : IN STD_LOGIC := '0';   
        nerror                  : IN STD_LOGIC := '1';   
        portabyteenamasks       : IN STD_LOGIC_VECTOR(port_a_byte_enable_mask_width - 1 DOWNTO 0) := (OTHERS => '1');   
        portbbyteenamasks       : IN STD_LOGIC_VECTOR(port_b_byte_enable_mask_width - 1 DOWNTO 0) := (OTHERS => '1');   
        devclrn                 : IN STD_LOGIC := '1';   
        devpor                  : IN STD_LOGIC := '1';   
        portaaddrstall          : IN STD_LOGIC := '0';
        portbaddrstall          : IN STD_LOGIC := '0';
        eccstatus               : OUT STD_LOGIC_VECTOR(width_eccstatus - 1 DOWNTO 0) := (OTHERS => '0');
        dftout                  : OUT STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
        portadataout            : OUT STD_LOGIC_VECTOR(port_a_data_width - 1 DOWNTO 0);   
        portbdataout            : OUT STD_LOGIC_VECTOR(port_b_data_width - 1 DOWNTO 0)
        );
END COMPONENT;

COMPONENT generic_mlab_cell
   GENERIC (
      logical_ram_name              : STRING := "lutram";
      logical_ram_depth             : INTEGER := 0;
      logical_ram_width             : INTEGER := 0;
      first_address                 : INTEGER := 0;
      last_address                  : INTEGER := 0;
      first_bit_number              : INTEGER := 0;
      init_file                     : STRING := "NONE";
      data_width                    : INTEGER := 20;
      address_width                 : INTEGER := 6;
      byte_enable_mask_width        : INTEGER := 1;
      byte_size                     : INTEGER := 1;
      port_b_data_out_clock         : STRING := "none";
      port_b_data_out_clear         : STRING := "none";
      lpm_type                      : STRING := "stratixv_lutram";
      lpm_hint                      : STRING := "true";
      mem_init0                     : STRING := "";
      mixed_port_feed_through_mode  : STRING := "new"
   );
   PORT (
      portadatain                   : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (others => '0');
      portaaddr                     : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0) := (others => '0');
      portabyteenamasks             : IN STD_LOGIC_VECTOR(byte_enable_mask_width - 1 DOWNTO 0) := (others => '1');
      portbaddr                     : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0) := (others => '0');
      clk0                          : IN STD_LOGIC := '0';
      clk1                          : IN STD_LOGIC := '0';
      ena0                          : IN STD_LOGIC := '1';
      ena1                          : IN STD_LOGIC := '1';
      ena2                          : IN STD_LOGIC := '1';
      clr                           : IN STD_LOGIC := '0';
      devclrn                       : IN STD_LOGIC := '1';
      devpor                        : IN STD_LOGIC := '1';
      portbdataout                  : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
   );
END COMPONENT;

COMPONENT generic_28nm_hp_mlab_cell_impl
   GENERIC (
      logical_ram_name              : STRING := "lutram";
      logical_ram_depth             : INTEGER := 0;
      logical_ram_width             : INTEGER := 0;
      first_address                 : INTEGER := 0;
      last_address                  : INTEGER := 0;
      first_bit_number              : INTEGER := 0;
      init_file                     : STRING := "NONE";
      data_width                    : INTEGER := 20;
      address_width                 : INTEGER := 6;
      byte_enable_mask_width        : INTEGER := 1;
      byte_size                     : INTEGER := 1;
      port_b_data_out_clock         : STRING := "none";
      port_b_data_out_clear         : STRING := "none";
      lpm_type                      : STRING := "stratixv_lutram";
      lpm_hint                      : STRING := "true";
      mem_init0                     : STRING := "";
      mixed_port_feed_through_mode  : STRING := "new"
   );
   PORT (
      portadatain                   : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (others => '0');
      portaaddr                     : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0) := (others => '0');
      portabyteenamasks             : IN STD_LOGIC_VECTOR(byte_enable_mask_width - 1 DOWNTO 0) := (others => '1');
      portbaddr                     : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0) := (others => '0');
      clk0                          : IN STD_LOGIC := '0';
      clk1                          : IN STD_LOGIC := '0';
      ena0                          : IN STD_LOGIC := '1';
      ena1                          : IN STD_LOGIC := '1';
      ena2                          : IN STD_LOGIC := '1';
      clr                           : IN STD_LOGIC := '0';
      devclrn                       : IN STD_LOGIC := '1';
      devpor                        : IN STD_LOGIC := '1';
      portbdataout                  : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
   );
END COMPONENT;

COMPONENT generic_28nm_lc_mlab_cell_impl
   GENERIC (
      logical_ram_name              : STRING := "lutram";
      logical_ram_depth             : INTEGER := 0;
      logical_ram_width             : INTEGER := 0;
      first_address                 : INTEGER := 0;
      last_address                  : INTEGER := 0;
      first_bit_number              : INTEGER := 0;
      init_file                     : STRING := "NONE";
      data_width                    : INTEGER := 20;
      address_width                 : INTEGER := 5;
      byte_enable_mask_width        : INTEGER := 1;
      byte_size                     : INTEGER := 1;
      port_b_data_out_clock         : STRING := "none";
      port_b_data_out_clear         : STRING := "none";
      lpm_type                      : STRING := "arriav_lutram";
      lpm_hint                      : STRING := "true";
      mem_init0                     : STRING := "";
      mixed_port_feed_through_mode  : STRING := "new"
   );
   PORT (
      portadatain                   : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (others => '0');
      portaaddr                     : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0) := (others => '0');
      portabyteenamasks             : IN STD_LOGIC_VECTOR(byte_enable_mask_width - 1 DOWNTO 0) := (others => '1');
      portbaddr                     : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0) := (others => '0');
      clk0                          : IN STD_LOGIC := '0';
      clk1                          : IN STD_LOGIC := '0';
      ena0                          : IN STD_LOGIC := '1';
      ena1                          : IN STD_LOGIC := '1';
      ena2                          : IN STD_LOGIC := '1';
      clr                           : IN STD_LOGIC := '0';
      devclrn                       : IN STD_LOGIC := '1';
      devpor                        : IN STD_LOGIC := '1';
      portbdataout                  : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
   );
END COMPONENT;

COMPONENT generic_14nm_mlab_cell_impl
   GENERIC (
      logical_ram_name              : STRING := "lutram";
      logical_ram_depth             : INTEGER := 0;
      logical_ram_width             : INTEGER := 0;
      first_address                 : INTEGER := 0;
      last_address                  : INTEGER := 0;
      first_bit_number              : INTEGER := 0;
      init_file                     : STRING := "NONE";
      data_width                    : INTEGER := 20;
      address_width                 : INTEGER := 5;
      byte_enable_mask_width        : INTEGER := 1;
      byte_size                     : INTEGER := 1;
      port_b_data_out_clock         : STRING := "none";
      port_b_data_out_clear         : STRING := "none";
      lpm_type                      : STRING := "nadder_lutram";
      lpm_hint                      : STRING := "true";
      mem_init0                     : STRING := "";
      mixed_port_feed_through_mode  : STRING := "new"
   );
   PORT (
      portadatain                   : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (others => '0');
      portaaddr                     : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0) := (others => '0');
      portabyteenamasks             : IN STD_LOGIC_VECTOR(byte_enable_mask_width - 1 DOWNTO 0) := (others => '1');
      portbaddr                     : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0) := (others => '0');
      clk0                          : IN STD_LOGIC := '0';
      clk1                          : IN STD_LOGIC := '0';
      ena0                          : IN STD_LOGIC := '1';
      ena1                          : IN STD_LOGIC := '1';
      clr                           : IN STD_LOGIC := '0';
      devclrn                       : IN STD_LOGIC := '1';
      devpor                        : IN STD_LOGIC := '1';
      portbdataout                  : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
   );
END COMPONENT;

component altera_functions 
end component;

component generic_mux
    port(
        din				: in    std_logic_vector(63 downto 0);
        sel				: in    std_logic_vector(5 downto 0);
        dout			: out   std_logic_vector
    );
end component;

component generic_device_pll
    generic(
		reference_clock_frequency	: string	:= "0 ps";
		output_clock_frequency		: string	:= "0 ps";
		forcelock					: string	:= "false";
		nreset_invert				: string	:= "false";
		pll_enable					: string	:= "true";
		pll_fbclk_mux_1				: string	:= "glb";
		pll_fbclk_mux_2				: string	:= "fb_1";
		pll_m_cnt_bypass_en			: string	:= "false";
		pll_m_cnt_hi_div			: integer	:= 1;
		pll_m_cnt_in_src			: string	:= "ph_mux_clk";
		pll_m_cnt_lo_div			: integer	:= 1;
		pll_n_cnt_bypass_en			: string	:= "false";
		pll_n_cnt_hi_div			: integer	:= 1;
		pll_n_cnt_lo_div			: integer	:= 1;
		pll_vco_ph0_en				: string	:= "false";
		pll_vco_ph1_en				: string	:= "false";
		pll_vco_ph2_en				: string	:= "false";
		pll_vco_ph3_en				: string	:= "false";
		pll_vco_ph4_en				: string	:= "false";
		pll_vco_ph5_en				: string	:= "false";
		pll_vco_ph6_en				: string	:= "false";
		pll_vco_ph7_en				: string	:= "false"
    );
    port(
		coreclkfb		: in	std_logic;
		fbclkfpll		: in	std_logic;
		lvdsfbin		: in	std_logic;
		nresync			: in	std_logic;
		pfden			: in	std_logic;
		refclkin		: in	std_logic;
		zdb				: in	std_logic;

		fbclk			: out	std_logic;
		fblvdsout		: out	std_logic;
		lock			: out	std_logic;
		vcoph			: out	std_logic_vector(7 downto 0)
    );
end component;



component altera_mult_add 
   GENERIC (
	   	extra_latency							: INTEGER :=  0;
		dedicated_multiplier_circuitry			: STRING :=  "AUTO";
		dsp_block_balancing						: STRING :=  "AUTO";
		selected_device_family					: STRING :=  "Stratix V";
		lpm_type								: STRING :=  "altera_mult_add";
		lpm_hint								: STRING :=  "UNUSED";
		width_a									: INTEGER :=  1;
		input_register_a0						: STRING :=  "UNREGISTERED";
		input_aclr_a0							: STRING :=  "NONE";
		input_sclr_a0      						: STRING :=  "NONE"; 	--added for sclr support
		input_source_a0							: STRING :=  "DATAA";
		input_register_a1						: STRING :=  "UNREGISTERED";
		input_aclr_a1							: STRING :=  "NONE";
		input_sclr_a1							: STRING :=  "NONE";	--added for sclr support
		input_source_a1							: STRING :=  "DATAA";
		input_register_a2						: STRING :=  "UNREGISTERED";
		input_aclr_a2							: STRING :=  "NONE";
		input_sclr_a2							: STRING :=  "NONE";	--added for sclr support
		input_source_a2							: STRING :=  "DATAA";
		input_register_a3						: STRING :=  "UNREGISTERED";
		input_aclr_a3							: STRING :=  "NONE";
		input_sclr_a3							: STRING :=  "NONE";	--added for sclr support
		input_source_a3							: STRING :=  "DATAA";
		width_b									: INTEGER :=  1;
		input_register_b0						: STRING :=  "UNREGISTERED";
		input_aclr_b0							: STRING :=  "NONE";
		input_sclr_b0							: STRING :=  "NONE";	--added for sclr support
		input_source_b0							: STRING :=  "DATAB";
		input_register_b1						: STRING :=  "UNREGISTERED";
		input_aclr_b1							: STRING :=  "NONE";
		input_sclr_b1							: STRING :=  "NONE";	--added for sclr support
		input_source_b1							: STRING :=  "DATAB";
		input_register_b2						: STRING :=  "UNREGISTERED";
		input_aclr_b2							: STRING :=  "NONE";
		input_sclr_b2							: STRING :=  "NONE";	--added for sclr support
		input_source_b2							: STRING :=  "DATAB";
		input_register_b3						: STRING :=  "UNREGISTERED";
		input_aclr_b3							: STRING :=  "NONE";
		input_sclr_b3							: STRING :=  "NONE";	--added for sclr support
		input_source_b3							: STRING :=  "DATAB";
		width_c									: INTEGER :=  1;
		input_register_c0						: STRING :=  "UNREGISTERED";
		input_aclr_c0							: STRING :=  "NONE";
		input_sclr_c0							: STRING :=  "NONE";	--added for sclr support
		input_register_c1						: STRING :=  "UNREGISTERED";
		input_aclr_c1							: STRING :=  "NONE";
		input_sclr_c1							: STRING :=  "NONE";	--added for sclr support
		input_register_c2						: STRING :=  "UNREGISTERED";
		input_aclr_c2							: STRING :=  "NONE";
		input_sclr_c2							: STRING :=  "NONE";	--added for sclr support
		input_register_c3						: STRING :=  "UNREGISTERED";
		input_aclr_c3							: STRING :=  "NONE";
		input_sclr_c3							: STRING :=  "NONE";	--added for sclr support
		width_result							: INTEGER :=  34;
		output_register							: STRING :=  "UNREGISTERED";
		output_aclr								: STRING :=  "NONE";
		output_sclr								: STRING :=  "NONE";	--added for sclr support
		port_signa								: STRING :=  "PORT_UNUSED";
		representation_a						: STRING :=  "UNSIGNED";
		signed_register_a						: STRING :=  "UNREGISTERED";
		signed_aclr_a							: STRING :=  "NONE";
		signed_sclr_a							: STRING :=  "NONE";	--added for sclr support
		signed_pipeline_register_a				: STRING :=  "UNREGISTERED";
		signed_pipeline_aclr_a					: STRING :=  "NONE";
		port_signb								: STRING :=  "PORT_UNUSED";
		representation_b						: STRING :=  "UNSIGNED";
		signed_register_b						: STRING :=  "UNREGISTERED";
		signed_aclr_b							: STRING :=  "NONE";
		signed_sclr_b							: STRING :=  "NONE";	--added for sclr support
		signed_pipeline_register_b				: STRING :=  "UNREGISTERED";
		signed_pipeline_aclr_b					: STRING :=  "NONE";
		number_of_multipliers					: INTEGER :=  1;
		multiplier1_direction					: STRING :=  "UNUSED";
		multiplier3_direction					: STRING :=  "UNUSED";
		multiplier_register0					: STRING :=  "UNREGISTERED";
		multiplier_aclr0						: STRING :=  "NONE";
		multiplier_sclr0						: STRING :=  "NONE";	--added for sclr support
		multiplier_register1					: STRING :=  "UNREGISTERED";
		multiplier_aclr1						: STRING :=  "NONE";
		multiplier_sclr1						: STRING :=  "NONE";	--added for sclr support
		multiplier_register2					: STRING :=  "UNREGISTERED";
		multiplier_aclr2						: STRING :=  "NONE";
		multiplier_sclr2						: STRING :=  "NONE";	--added for sclr support
		multiplier_register3					: STRING :=  "UNREGISTERED";
		multiplier_aclr3						: STRING :=  "NONE";
		multiplier_sclr3						: STRING :=  "NONE";	--added for sclr support
		port_addnsub1							: STRING :=  "PORT_UNUSED";
		addnsub_multiplier_register1			: STRING :=  "UNREGISTERED";
		addnsub_multiplier_aclr1				: STRING :=  "NONE";
		addnsub_multiplier_sclr1				: STRING :=  "NONE";	--added for sclr support
		addnsub_multiplier_pipeline_register1	: STRING :=  "UNREGISTERED";
		addnsub_multiplier_pipeline_aclr1		: STRING :=  "NONE";
		--addnsub_multiplier_pipeline_sclr1		: STRING :=  "NONE";	--added for sclr support
		port_addnsub3							: STRING :=  "PORT_UNUSED";
		use_subnadd								: STRING :=  "NO";
		addnsub_multiplier_register3			: STRING :=  "UNREGISTERED";
		addnsub_multiplier_aclr3				: STRING :=  "NONE";
		addnsub_multiplier_sclr3				: STRING :=  "NONE";	--added for sclr support
		addnsub_multiplier_pipeline_register3	: STRING :=  "UNREGISTERED";
		addnsub_multiplier_pipeline_aclr3		: STRING :=  "NONE";
		--addnsub_multiplier_pipeline_sclr3		: STRING :=  "NONE";	--added for sclr support
		adder1_rounding							: STRING :=  "NO";
		addnsub1_round_register					: STRING :=  "UNREGISTERED";
		addnsub1_round_aclr						: STRING :=  "NONE";
		addnsub1_round_sclr						: STRING :=  "NONE";	--added for sclr support
		addnsub1_round_pipeline_register		: STRING :=  "UNREGISTERED";
		addnsub1_round_pipeline_aclr			: STRING :=  "NONE";
		addnsub1_round_pipeline_sclr			: STRING :=  "NONE";	--added for sclr support
		adder3_rounding							: STRING :=  "NO";
		addnsub3_round_register					: STRING :=  "UNREGISTERED";
		addnsub3_round_aclr						: STRING :=  "NONE";
		addnsub3_round_sclr						: STRING :=  "NONE";	--added for sclr support
		addnsub3_round_pipeline_register		: STRING :=  "UNREGISTERED";
		addnsub3_round_pipeline_aclr			: STRING :=  "NONE";
		addnsub3_round_pipeline_sclr			: STRING :=  "NONE";	--added for sclr support
		multiplier01_rounding					: STRING :=  "NO";
		mult01_round_register					: STRING :=  "UNREGISTERED";
		mult01_round_aclr						: STRING :=  "NONE";
		mult01_round_sclr						: STRING :=  "NONE";	--added for sclr support
		multiplier23_rounding					: STRING :=  "NO";
		mult23_round_register					: STRING :=  "UNREGISTERED";
		mult23_round_aclr						: STRING :=  "NONE";
		mult23_round_sclr						: STRING :=  "NONE";	--added for sclr support
		width_msb								: INTEGER :=  17;
		output_rounding							: STRING :=  "NO";
		output_round_type						: STRING :=  "NEAREST_INTEGER";
		output_round_register					: STRING :=  "UNREGISTERED";
		output_round_aclr						: STRING :=  "NONE";
		output_round_sclr						: STRING :=  "NONE";	--added for sclr support
		output_round_pipeline_register			: STRING :=  "UNREGISTERED";
		output_round_pipeline_aclr				: STRING :=  "NONE";
		output_round_pipeline_sclr				: STRING :=  "NONE";	--added for sclr support
		chainout_rounding						: STRING :=  "NO";
		chainout_round_register					: STRING :=  "UNREGISTERED";
		chainout_round_aclr						: STRING :=  "NONE";
		chainout_round_sclr						: STRING :=  "NONE";	--added for sclr support
		chainout_round_pipeline_register		: STRING :=  "UNREGISTERED";
		chainout_round_pipeline_aclr			: STRING :=  "NONE";
		chainout_round_pipeline_sclr			: STRING :=  "NONE";	--added for sclr support
		chainout_round_output_register			: STRING :=  "UNREGISTERED";
		chainout_round_output_aclr				: STRING :=  "NONE";
		chainout_round_output_sclr				: STRING :=  "NONE";	--added for sclr support
		multiplier01_saturation					: STRING :=  "NO";
		mult01_saturation_register				: STRING :=  "UNREGISTERED";
		mult01_saturation_aclr					: STRING :=  "NONE";
		mult01_saturation_sclr					: STRING :=  "NONE";	--added for sclr support
		multiplier23_saturation					: STRING :=  "NO";
		mult23_saturation_register				: STRING :=  "UNREGISTERED";
		mult23_saturation_aclr					: STRING :=  "NONE";
		mult23_saturation_sclr					: STRING :=  "NONE";	--added for sclr support
		port_mult0_is_saturated					: STRING :=  "UNUSED";
		port_mult1_is_saturated					: STRING :=  "UNUSED";
		port_mult2_is_saturated					: STRING :=  "UNUSED";
		port_mult3_is_saturated					: STRING :=  "UNUSED";
		width_saturate_sign						: INTEGER :=  1;
		output_saturation						: STRING :=  "NO";
		port_output_is_overflow					: STRING :=  "PORT_UNUSED";
		output_saturate_type					: STRING :=  "ASYMMETRIC";
		output_saturate_register				: STRING :=  "UNREGISTERED";
		output_saturate_aclr					: STRING :=  "NONE";
		output_saturate_sclr					: STRING :=  "NONE";	--added for sclr support
		output_saturate_pipeline_register		: STRING :=  "UNREGISTERED";
		output_saturate_pipeline_aclr			: STRING :=  "NONE";
		output_saturate_pipeline_sclr			: STRING :=  "NONE";	--added for sclr support
		chainout_saturation						: STRING :=  "NO";
		port_chainout_sat_is_overflow			: STRING :=  "PORT_UNUSED";
		chainout_saturate_register				: STRING :=  "UNREGISTERED";
		chainout_saturate_aclr					: STRING :=  "NONE";
		chainout_saturate_sclr					: STRING :=  "NONE";	--added for sclr support
		chainout_saturate_pipeline_register		: STRING :=  "UNREGISTERED";
		chainout_saturate_pipeline_aclr			: STRING :=  "NONE";
		chainout_saturate_pipeline_sclr			: STRING :=  "NONE";	--added for sclr support
		chainout_saturate_output_register		: STRING :=  "UNREGISTERED";
		chainout_saturate_output_aclr			: STRING :=  "NONE";
		chainout_saturate_output_sclr			: STRING :=  "NONE";	--added for sclr support
		scanouta_register						: STRING :=  "UNREGISTERED";
		scanouta_aclr							: STRING :=  "NONE";
		scanouta_sclr							: STRING :=  "NONE";	--added for sclr support
		width_chainin							: INTEGER :=  1;
		chainout_adder							: STRING :=  "NO";
		chainout_adder_direction				: STRING :=  "ADD";		
		chainout_register						: STRING :=  "UNREGISTERED";
		chainout_aclr							: STRING :=  "NONE";
		chainout_sclr							: STRING :=  "NONE";	--added for sclr support	
		port_negate		 						: STRING := "PORT_UNUSED";
		negate_register 	 					: STRING := "UNREGISTERED";
		negate_aclr 	    					: STRING := "NONE";
		negate_sclr 	    					: STRING := "NONE";		--added for sclr support
		negate_latency_clock 	 				: STRING := "UNREGISTERED";
		negate_latency_aclr	 					: STRING := "NONE";
		negate_latency_sclr	 					: STRING := "NONE";		--added for sclr support
		zero_chainout_output_register			: STRING :=  "UNREGISTERED";
		zero_chainout_output_aclr				: STRING :=  "NONE";
		shift_mode								: STRING :=  "NO";
		rotate_register							: STRING :=  "UNREGISTERED";
		rotate_aclr								: STRING :=  "NONE";
		rotate_sclr								: STRING :=  "NONE";	--added for sclr support
		rotate_pipeline_register				: STRING :=  "UNREGISTERED";
		rotate_pipeline_aclr					: STRING :=  "NONE";
		rotate_pipeline_sclr					: STRING :=  "NONE";	--added for sclr support
		rotate_output_register					: STRING :=  "UNREGISTERED";
		rotate_output_aclr						: STRING :=  "NONE";
		rotate_output_sclr						: STRING :=  "NONE";	--added for sclr support
		shift_right_register					: STRING :=  "UNREGISTERED";
		shift_right_aclr						: STRING :=  "NONE";
		shift_right_sclr						: STRING :=  "NONE";	--added for sclr support
		shift_right_pipeline_register			: STRING :=  "UNREGISTERED";
		shift_right_pipeline_aclr				: STRING :=  "NONE";
		shift_right_pipeline_sclr				: STRING :=  "NONE";	--added for sclr support
		shift_right_output_register				: STRING :=  "UNREGISTERED";
		shift_right_output_aclr					: STRING :=  "NONE";
		shift_right_output_sclr					: STRING :=  "NONE";	--added for sclr support
		zero_loopback_register					: STRING :=  "UNREGISTERED";
		zero_loopback_aclr						: STRING :=  "NONE";
		zero_loopback_sclr						: STRING :=  "NONE";	--added for sclr support
		zero_loopback_pipeline_register			: STRING :=  "UNREGISTERED";
		zero_loopback_pipeline_aclr				: STRING :=  "NONE";
		zero_loopback_pipeline_sclr				: STRING :=  "NONE";	-- added for sclr support
		zero_loopback_output_register			: STRING :=  "UNREGISTERED";
		zero_loopback_output_aclr				: STRING :=  "NONE";
		zero_loopback_output_sclr				: STRING :=  "NONE";	-- added for sclr support
		accumulator								: STRING :=  "NO";
		accum_direction							: STRING :=  "ADD";
		double_accum							: STRING :=  "NO";
		loadconst_value							: INTEGER :=  0;
		use_sload_accum_port					: STRING :=  "NO";
		accum_sload_register					: STRING :=  "UNREGISTERED";
		accum_sload_aclr						: STRING :=  "NONE";
		accum_sload_sclr						: STRING :=  "NONE";	-- added for sclr support
		accum_sload_pipeline_register			: STRING :=  "UNREGISTERED";
		accum_sload_pipeline_aclr				: STRING :=  "NONE";
		loadconst_control_register				: STRING :=  "UNREGISTERED";
		loadconst_control_aclr					: STRING :=  "NONE";
		loadconst_control_sclr					: STRING :=  "NONE";	-- added for sclr support
		systolic_delay1							: STRING :=  "UNREGISTERED";
		systolic_delay3							: STRING :=  "UNREGISTERED";
		systolic_aclr1							: STRING :=  "NONE";
		systolic_sclr1							: STRING :=  "NONE";	-- added for sclr support
		systolic_aclr3							: STRING :=  "NONE";
		systolic_sclr3							: STRING :=  "NONE";	-- added for sclr support
		preadder_mode							: STRING :=  "SIMPLE";
		preadder_direction_0					: STRING :=  "ADD";
		preadder_direction_1					: STRING :=  "ADD";
		preadder_direction_2					: STRING :=  "ADD";
		preadder_direction_3					: STRING :=  "ADD";
		width_coef								: INTEGER :=  1;
		coefsel0_register						: STRING :=  "UNREGISTERED";
		coefsel0_aclr							: STRING :=  "NONE";
		coefsel0_sclr							: STRING :=  "NONE";	-- added for sclr support
		coefsel1_register						: STRING :=  "UNREGISTERED";
		coefsel1_aclr							: STRING :=  "NONE";
		coefsel1_sclr							: STRING :=  "NONE";	-- added for sclr support
		coefsel2_register						: STRING :=  "UNREGISTERED";
		coefsel2_aclr							: STRING :=  "NONE";
		coefsel2_sclr							: STRING :=  "NONE";	-- added for sclr support
		coefsel3_register						: STRING :=  "UNREGISTERED";
		coefsel3_aclr							: STRING :=  "NONE";
		coefsel3_sclr							: STRING :=  "NONE";	-- added for sclr support
		coef0_0									: INTEGER :=  0;
		coef0_1									: INTEGER :=  0;
		coef0_2									: INTEGER :=  0;
		coef0_3									: INTEGER :=  0;
		coef0_4									: INTEGER :=  0;
		coef0_5									: INTEGER :=  0;
		coef0_6									: INTEGER :=  0;
		coef0_7									: INTEGER :=  0;
		coef1_0									: INTEGER :=  0;
		coef1_1									: INTEGER :=  0;
		coef1_2									: INTEGER :=  0;
		coef1_3									: INTEGER :=  0;
		coef1_4									: INTEGER :=  0;
		coef1_5									: INTEGER :=  0;
		coef1_6									: INTEGER :=  0;
		coef1_7									: INTEGER :=  0;
		coef2_0									: INTEGER :=  0;
		coef2_1									: INTEGER :=  0;
		coef2_2									: INTEGER :=  0;
		coef2_3									: INTEGER :=  0;
		coef2_4									: INTEGER :=  0;
		coef2_5									: INTEGER :=  0;
		coef2_6									: INTEGER :=  0;
		coef2_7									: INTEGER :=  0;
		coef3_0									: INTEGER :=  0;
		coef3_1									: INTEGER :=  0;
		coef3_2									: INTEGER :=  0;
		coef3_3									: INTEGER :=  0;
		coef3_4									: INTEGER :=  0;
		coef3_5									: INTEGER :=  0;
		coef3_6									: INTEGER :=  0;
		coef3_7									: INTEGER :=  0;
		latency									: INTEGER :=  0;
		input_a0_latency_clock					: STRING :=  "UNREGISTERED";
		input_a0_latency_aclr					: STRING :=  "NONE";
		input_a0_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_a1_latency_clock					: STRING :=  "UNREGISTERED";
		input_a1_latency_aclr					: STRING :=  "NONE";
		input_a1_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_a2_latency_clock					: STRING :=  "UNREGISTERED";
		input_a2_latency_aclr					: STRING :=  "NONE";
		input_a2_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_a3_latency_clock					: STRING :=  "UNREGISTERED";
		input_a3_latency_aclr					: STRING :=  "NONE";	
		input_a3_latency_sclr					: STRING :=  "NONE";	-- added for sclr support	
		input_b0_latency_clock					: STRING :=  "UNREGISTERED";
		input_b0_latency_aclr					: STRING :=  "NONE";
		input_b0_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_b1_latency_clock					: STRING :=  "UNREGISTERED";
		input_b1_latency_aclr					: STRING :=  "NONE";
		input_b1_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_b2_latency_clock					: STRING :=  "UNREGISTERED";
		input_b2_latency_aclr					: STRING :=  "NONE";
		input_b2_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_b3_latency_clock					: STRING :=  "UNREGISTERED";
		input_b3_latency_aclr					: STRING :=  "NONE";
		input_b3_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_c0_latency_clock					: STRING :=  "UNREGISTERED";
		input_c0_latency_aclr					: STRING :=  "NONE";
		input_c0_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_c1_latency_clock					: STRING :=  "UNREGISTERED";
		input_c1_latency_aclr					: STRING :=  "NONE";
		input_c1_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_c2_latency_clock					: STRING :=  "UNREGISTERED";
		input_c2_latency_aclr					: STRING :=  "NONE";
		input_c2_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		input_c3_latency_clock					: STRING :=  "UNREGISTERED";
		input_c3_latency_aclr					: STRING :=  "NONE";
		input_c3_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		coefsel0_latency_clock					: STRING :=  "UNREGISTERED";
		coefsel0_latency_aclr					: STRING :=  "NONE";
		coefsel0_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		coefsel1_latency_clock					: STRING :=  "UNREGISTERED";
		coefsel1_latency_aclr					: STRING :=  "NONE";
		coefsel1_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		coefsel2_latency_clock					: STRING :=  "UNREGISTERED";
		coefsel2_latency_aclr					: STRING :=  "NONE";
		coefsel2_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		coefsel3_latency_clock					: STRING :=  "UNREGISTERED";
		coefsel3_latency_aclr					: STRING :=  "NONE";
		coefsel3_latency_sclr					: STRING :=  "NONE";	-- added for sclr support
		signed_latency_clock_a					: STRING :=  "UNREGISTERED";
		signed_latency_aclr_a					: STRING :=  "NONE";
		signed_latency_sclr_a					: STRING :=  "NONE";	-- added for sclr support
		signed_latency_clock_b					: STRING :=  "UNREGISTERED";
		signed_latency_aclr_b					: STRING :=  "NONE";
		signed_latency_sclr_b					: STRING :=  "NONE";	-- added for sclr support
		addnsub_multiplier_latency_clock1		: STRING :=  "UNREGISTERED";
		addnsub_multiplier_latency_aclr1		: STRING :=  "NONE";
		addnsub_multiplier_latency_sclr1		: STRING :=  "NONE";	-- added for sclr support
		addnsub_multiplier_latency_clock3		: STRING :=  "UNREGISTERED";
		addnsub_multiplier_latency_aclr3		: STRING :=  "NONE";
		addnsub_multiplier_latency_sclr3		: STRING :=  "NONE";	-- added for sclr support
		accum_sload_latency_clock				: STRING :=  "UNREGISTERED";
		accum_sload_latency_aclr				: STRING :=  "NONE";
		accum_sload_latency_sclr				: STRING :=  "NONE"		-- added for sclr support
		
    );
   PORT (
		dataa						: IN    STD_LOGIC_VECTOR(width_a * number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		datab						: IN    STD_LOGIC_VECTOR(width_b * number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		datac						: IN    STD_LOGIC_VECTOR(width_c * number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		scanina						: IN    STD_LOGIC_VECTOR(width_a - 1 downto 0) := (OTHERS => '0');
		scaninb						: IN    STD_LOGIC_VECTOR(width_b - 1 downto 0) := (OTHERS => '0');
		sourcea						: IN    STD_LOGIC_VECTOR(number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		sourceb						: IN    STD_LOGIC_VECTOR(number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		clock3						: IN    STD_LOGIC := '0';
		clock2 						: IN    STD_LOGIC := '0';
		clock1 						: IN    STD_LOGIC := '0';
		clock0 						: IN    STD_LOGIC := '0';
		aclr3 						: IN    STD_LOGIC := '0';
		aclr2 						: IN    STD_LOGIC := '0';
		aclr1 						: IN    STD_LOGIC := '0';
		aclr0 						: IN    STD_LOGIC := '0';
		sclr3 						: IN    STD_LOGIC := '0';			-- added for sclr support
		sclr2 						: IN    STD_LOGIC := '0';			-- added for sclr support
		sclr1 						: IN    STD_LOGIC := '0';			-- added for sclr support
		sclr0 						: IN    STD_LOGIC := '0';			-- added for sclr support
		ena3 						: IN    STD_LOGIC := '1';
		ena2 						: IN    STD_LOGIC := '1';
		ena1 						: IN    STD_LOGIC := '1';
		ena0 						: IN    STD_LOGIC := '1';
		signa 						: IN    STD_LOGIC := '0';
		signb 						: IN    STD_LOGIC := '0';
		addnsub1 					: IN    STD_LOGIC := '0';
		addnsub3 					: IN    STD_LOGIC := '0';
		result 						: OUT    STD_LOGIC_VECTOR(width_result - 1 downto 0);
		scanouta					: OUT    STD_LOGIC_VECTOR(width_a - 1 downto 0);
		scanoutb					: OUT    STD_LOGIC_VECTOR(width_b - 1 downto 0);
		mult01_round 				: IN    STD_LOGIC := '0';
		mult23_round 				: IN    STD_LOGIC := '0';
		mult01_saturation 			: IN    STD_LOGIC := '0';
		mult23_saturation 			: IN    STD_LOGIC := '0';
		addnsub1_round 				: IN    STD_LOGIC := '0';
		addnsub3_round 				: IN    STD_LOGIC := '0';
		mult0_is_saturated 			: OUT    STD_LOGIC;
		mult1_is_saturated 			: OUT    STD_LOGIC;
		mult2_is_saturated 			: OUT    STD_LOGIC;
		mult3_is_saturated 			: OUT    STD_LOGIC;
		output_round 				: IN    STD_LOGIC := '0';
		chainout_round 				: IN    STD_LOGIC := '0';
		output_saturate 			: IN    STD_LOGIC := '0';
		chainout_saturate 			: IN    STD_LOGIC := '0';
		overflow 					: OUT    STD_LOGIC;
		chainout_sat_overflow 		: OUT    STD_LOGIC;
		chainin						: IN    STD_LOGIC_VECTOR(width_chainin - 1 downto 0) := (OTHERS => '0');
		zero_chainout 				: IN    STD_LOGIC := '0';
		rotate 						: IN    STD_LOGIC := '0';
		shift_right 				: IN    STD_LOGIC := '0';
		zero_loopback 				: IN    STD_LOGIC := '0';
		accum_sload 				: IN    STD_LOGIC := '0';
		sload_accum 				: IN    STD_LOGIC := '0';
		negate 						: IN    STD_LOGIC := '0';
		coefsel0					: IN    STD_LOGIC_VECTOR(2 downto 0) := (OTHERS => '0');
		coefsel1					: IN    STD_LOGIC_VECTOR(2 downto 0) := (OTHERS => '0');
		coefsel2					: IN    STD_LOGIC_VECTOR(2 downto 0) := (OTHERS => '0');
		coefsel3					: IN    STD_LOGIC_VECTOR(2 downto 0) := (OTHERS => '0')
    );
end component;

component altera_mult_add_rtl 
   GENERIC (
	   	extra_latency							: INTEGER :=  0;
		dedicated_multiplier_circuitry			: STRING :=  "AUTO";
		dsp_block_balancing						: STRING :=  "AUTO";
		selected_device_family					: STRING :=  "Stratix V";
		lpm_type								: STRING :=  "altera_mult_add";
		lpm_hint								: STRING :=  "UNUSED";
		width_a									: INTEGER :=  1;
		input_register_a0						: STRING :=  "UNREGISTERED";
		input_aclr_a0							: STRING :=  "NONE";
		input_sclr_a0							: STRING :=  "NONE";			-- added for sclr support
		input_source_a0							: STRING :=  "DATAA";
		input_register_a1						: STRING :=  "UNREGISTERED";
		input_aclr_a1							: STRING :=  "NONE";
		input_sclr_a1							: STRING :=  "NONE";			-- added for sclr support
		input_source_a1							: STRING :=  "DATAA";
		input_register_a2						: STRING :=  "UNREGISTERED";
		input_aclr_a2							: STRING :=  "NONE";
		input_sclr_a2							: STRING :=  "NONE";			-- added for sclr support
		input_source_a2							: STRING :=  "DATAA";
		input_register_a3						: STRING :=  "UNREGISTERED";
		input_aclr_a3							: STRING :=  "NONE";
		input_sclr_a3							: STRING :=  "NONE";			-- added for sclr support
		input_source_a3							: STRING :=  "DATAA";
		width_b									: INTEGER :=  1;
		input_register_b0						: STRING :=  "UNREGISTERED";
		input_aclr_b0							: STRING :=  "NONE";
		input_sclr_b0							: STRING :=  "NONE";			-- added for sclr support
		input_source_b0							: STRING :=  "DATAB";
		input_register_b1						: STRING :=  "UNREGISTERED";
		input_aclr_b1							: STRING :=  "NONE";
		input_sclr_b1							: STRING :=  "NONE";			-- added for sclr support		
		input_source_b1							: STRING :=  "DATAB";
		input_register_b2						: STRING :=  "UNREGISTERED";
		input_aclr_b2							: STRING :=  "NONE";
		input_sclr_b2							: STRING :=  "NONE";			-- added for sclr support		
		input_source_b2							: STRING :=  "DATAB";
		input_register_b3						: STRING :=  "UNREGISTERED";
		input_aclr_b3							: STRING :=  "NONE";
		input_sclr_b3							: STRING :=  "NONE";			-- added for sclr support
		input_source_b3							: STRING :=  "DATAB";
		width_c									: INTEGER :=  1;
		input_register_c0						: STRING :=  "UNREGISTERED";
		input_aclr_c0							: STRING :=  "NONE";
		input_sclr_c0							: STRING :=  "NONE";			-- added for sclr support	
		input_register_c1						: STRING :=  "UNREGISTERED";
		input_aclr_c1							: STRING :=  "NONE";
		input_sclr_c1							: STRING :=  "NONE";			-- added for sclr support		
		input_register_c2						: STRING :=  "UNREGISTERED";
		input_aclr_c2							: STRING :=  "NONE";
		input_sclr_c2							: STRING :=  "NONE";			-- added for sclr support	
		input_register_c3						: STRING :=  "UNREGISTERED";
		input_aclr_c3							: STRING :=  "NONE";
		input_sclr_c3							: STRING :=  "NONE";			-- added for sclr support
		width_result							: INTEGER :=  34;
		output_register							: STRING :=  "UNREGISTERED";
		output_aclr								: STRING :=  "NONE";
		output_sclr								: STRING :=  "NONE";			-- added for sclr support
		port_signa								: STRING :=  "PORT_UNUSED";
		representation_a						: STRING :=  "UNSIGNED";
		signed_register_a						: STRING :=  "UNREGISTERED";
		signed_aclr_a							: STRING :=  "NONE";
		signed_sclr_a							: STRING :=  "NONE";			-- added for sclr support
		signed_pipeline_register_a				: STRING :=  "UNREGISTERED";
		signed_pipeline_aclr_a					: STRING :=  "NONE";
		signed_pipeline_sclr_a					: STRING :=  "NONE";			-- added for sclr support
		port_signb								: STRING :=  "PORT_UNUSED";
		representation_b						: STRING :=  "UNSIGNED";
		signed_register_b						: STRING :=  "UNREGISTERED";
		signed_aclr_b							: STRING :=  "NONE";
		signed_sclr_b							: STRING :=  "NONE";			-- added for sclr support
		signed_pipeline_register_b				: STRING :=  "UNREGISTERED";
		signed_pipeline_aclr_b					: STRING :=  "NONE";
		signed_pipeline_sclr_b					: STRING :=  "NONE";			-- added for sclr support
		number_of_multipliers					: INTEGER :=  1;
		multiplier1_direction					: STRING :=  "UNUSED";
		multiplier3_direction					: STRING :=  "UNUSED";
		multiplier_register0					: STRING :=  "UNREGISTERED";
		multiplier_aclr0						: STRING :=  "NONE";
		multiplier_sclr0						: STRING :=  "NONE";			-- added for sclr support
		multiplier_register1					: STRING :=  "UNREGISTERED";
		multiplier_aclr1						: STRING :=  "NONE";
		multiplier_sclr1						: STRING :=  "NONE";			-- added for sclr support
		multiplier_register2					: STRING :=  "UNREGISTERED";
		multiplier_aclr2						: STRING :=  "NONE";
		multiplier_sclr2						: STRING :=  "NONE";			-- added for sclr support
		multiplier_register3					: STRING :=  "UNREGISTERED";
		multiplier_aclr3						: STRING :=  "NONE";
		multiplier_sclr3						: STRING :=  "NONE";			-- added for sclr support
		port_addnsub1							: STRING :=  "PORT_UNUSED";
		addnsub_multiplier_register1			: STRING :=  "UNREGISTERED";
		addnsub_multiplier_aclr1				: STRING :=  "NONE";
		addnsub_multiplier_sclr1				: STRING :=  "NONE";			-- added for sclr support	
		addnsub_multiplier_pipeline_register1	: STRING :=  "UNREGISTERED";
		addnsub_multiplier_pipeline_aclr1		: STRING :=  "NONE";
		--addnsub_multiplier_pipeline_sclr1		: STRING :=  "NONE";			-- added for sclr support		
		port_addnsub3							: STRING :=  "PORT_UNUSED";
		use_subnadd								: STRING :=  "NO";
		addnsub_multiplier_register3			: STRING :=  "UNREGISTERED";
		addnsub_multiplier_aclr3				: STRING :=  "NONE";
		addnsub_multiplier_sclr3				: STRING :=  "NONE";			-- added for sclr support
		addnsub_multiplier_pipeline_register3	: STRING :=  "UNREGISTERED";
		addnsub_multiplier_pipeline_aclr3		: STRING :=  "NONE";
		addnsub_multiplier_pipeline_sclr3		: STRING :=  "NONE";			-- added for sclr support
		adder1_rounding							: STRING :=  "NO";
		addnsub1_round_register					: STRING :=  "UNREGISTERED";
		addnsub1_round_aclr						: STRING :=  "NONE";
		addnsub1_round_sclr						: STRING :=  "NONE";			-- added for sclr support
		addnsub1_round_pipeline_register		: STRING :=  "UNREGISTERED";
		addnsub1_round_pipeline_aclr			: STRING :=  "NONE";
		addnsub1_round_pipeline_sclr			: STRING :=  "NONE";			-- added for sclr support
		adder3_rounding							: STRING :=  "NO";
		addnsub3_round_register					: STRING :=  "UNREGISTERED";
		addnsub3_round_aclr						: STRING :=  "NONE";
		addnsub3_round_sclr						: STRING :=  "NONE";			-- added for sclr support
		addnsub3_round_pipeline_register		: STRING :=  "UNREGISTERED";
		addnsub3_round_pipeline_aclr			: STRING :=  "NONE";
		addnsub3_round_pipeline_sclr			: STRING :=  "NONE";			-- added for sclr support
		multiplier01_rounding					: STRING :=  "NO";
		mult01_round_register					: STRING :=  "UNREGISTERED";
		mult01_round_aclr						: STRING :=  "NONE";
		mult01_round_sclr						: STRING :=  "NONE";			-- added for sclr support
		multiplier23_rounding					: STRING :=  "NO";
		mult23_round_register					: STRING :=  "UNREGISTERED";
		mult23_round_aclr						: STRING :=  "NONE";
		mult23_round_sclr						: STRING :=  "NONE";			-- added for sclr support
		width_msb								: INTEGER :=  17;
		output_rounding							: STRING :=  "NO";				
		output_round_type						: STRING :=  "NEAREST_INTEGER";
		output_round_register					: STRING :=  "UNREGISTERED";
		output_round_aclr						: STRING :=  "NONE";
		output_round_sclr						: STRING :=  "NONE";			-- added for sclr support
		output_round_pipeline_register			: STRING :=  "UNREGISTERED";
		output_round_pipeline_aclr				: STRING :=  "NONE";
		output_round_pipeline_sclr				: STRING :=  "NONE";			-- added for sclr support
		chainout_rounding						: STRING :=  "NO";
		chainout_round_register					: STRING :=  "UNREGISTERED";
		chainout_round_aclr						: STRING :=  "NONE";
		chainout_round_sclr						: STRING :=  "NONE";			-- added for sclr support
		chainout_round_pipeline_register		: STRING :=  "UNREGISTERED";
		chainout_round_pipeline_aclr			: STRING :=  "NONE";
		chainout_round_pipeline_sclr			: STRING :=  "NONE";			-- added for sclr support
		chainout_round_output_register			: STRING :=  "UNREGISTERED";
		chainout_round_output_aclr				: STRING :=  "NONE";
		chainout_round_output_sclr				: STRING :=  "NONE";			-- added for sclr support	
		multiplier01_saturation					: STRING :=  "NO";
		mult01_saturation_register				: STRING :=  "UNREGISTERED";
		mult01_saturation_aclr					: STRING :=  "NONE";
		mult01_saturation_sclr					: STRING :=  "NONE";			-- added for sclr support	
		multiplier23_saturation					: STRING :=  "NO";
		mult23_saturation_register				: STRING :=  "UNREGISTERED";
		mult23_saturation_aclr					: STRING :=  "NONE";
		mult23_saturation_sclr					: STRING :=  "NONE";			-- added for sclr support		
		port_mult0_is_saturated					: STRING :=  "UNUSED";
		port_mult1_is_saturated					: STRING :=  "UNUSED";
		port_mult2_is_saturated					: STRING :=  "UNUSED";
		port_mult3_is_saturated					: STRING :=  "UNUSED";
		width_saturate_sign						: INTEGER :=  1;
		output_saturation						: STRING :=  "NO";
		port_output_is_overflow					: STRING :=  "PORT_UNUSED";
		output_saturate_type					: STRING :=  "ASYMMETRIC";
		output_saturate_register				: STRING :=  "UNREGISTERED";
		output_saturate_aclr					: STRING :=  "NONE";
		output_saturate_sclr					: STRING :=  "NONE";
		output_saturate_pipeline_register		: STRING :=  "UNREGISTERED";
		output_saturate_pipeline_aclr			: STRING :=  "NONE";
		output_saturate_pipeline_sclr			: STRING :=  "NONE";			-- added for sclr support		
		chainout_saturation						: STRING :=  "NO";
		port_chainout_sat_is_overflow			: STRING :=  "PORT_UNUSED";
		chainout_saturate_register				: STRING :=  "UNREGISTERED";
		chainout_saturate_aclr					: STRING :=  "NONE";
		chainout_saturate_sclr					: STRING :=  "NONE";			-- added for sclr support		
		chainout_saturate_pipeline_register		: STRING :=  "UNREGISTERED";
		chainout_saturate_pipeline_aclr			: STRING :=  "NONE";
		chainout_saturate_pipeline_sclr			: STRING :=  "NONE";			-- added for sclr support	
		chainout_saturate_output_register		: STRING :=  "UNREGISTERED";
		chainout_saturate_output_aclr			: STRING :=  "NONE";
		chainout_saturate_output_sclr			: STRING :=  "NONE";			-- added for sclr support		
		scanouta_register						: STRING :=  "UNREGISTERED";
		scanouta_aclr							: STRING :=  "NONE";
		scanouta_sclr							: STRING :=  "NONE";			-- added for sclr support
		width_chainin							: INTEGER :=  1;	
		chainout_adder							: STRING :=  "NO";
		chainout_adder_direction				: STRING :=  "ADD";		
		chainout_register						: STRING :=  "UNREGISTERED";
		chainout_aclr							: STRING :=  "NONE";
		chainout_sclr							: STRING :=  "NONE";			-- added for sclr support
		port_negate		 						: STRING := "PORT_UNUSED";
		negate_register 	 					: STRING := "UNREGISTERED";
		negate_aclr 	    					: STRING := "NONE";
		negate_sclr 	    					: STRING := "NONE";				-- added for sclr support
		negate_latency_clock 	 				: STRING := "UNREGISTERED";
		negate_latency_aclr	 					: STRING := "NONE";
		negate_latency_sclr	 					: STRING := "NONE";				-- added for sclr support
		zero_chainout_output_register			: STRING :=  "UNREGISTERED";
		zero_chainout_output_aclr				: STRING :=  "NONE";
		zero_chainout_output_sclr				: STRING :=  "NONE";			-- added for sclr support	
		shift_mode								: STRING :=  "NO";	
		rotate_register							: STRING :=  "UNREGISTERED";
		rotate_aclr								: STRING :=  "NONE";
		rotate_sclr								: STRING :=  "NONE";			-- added for sclr support	
		rotate_pipeline_register				: STRING :=  "UNREGISTERED";
		rotate_pipeline_aclr					: STRING :=  "NONE";
		rotate_pipeline_sclr					: STRING :=  "NONE";			-- added for sclr support	
		rotate_output_register					: STRING :=  "UNREGISTERED";
		rotate_output_aclr						: STRING :=  "NONE";
		rotate_output_sclr						: STRING :=  "NONE";			-- added for sclr support	
		shift_right_register					: STRING :=  "UNREGISTERED";
		shift_right_aclr						: STRING :=  "NONE";
		shift_right_sclr						: STRING :=  "NONE";			-- added for sclr support	
		shift_right_pipeline_register			: STRING :=  "UNREGISTERED";
		shift_right_pipeline_aclr				: STRING :=  "NONE";
		shift_right_pipeline_sclr				: STRING :=  "NONE";			-- added for sclr support	
		shift_right_output_register				: STRING :=  "UNREGISTERED";
		shift_right_output_aclr					: STRING :=  "NONE";
		shift_right_output_sclr					: STRING :=  "NONE";			-- added for sclr support	
		zero_loopback_register					: STRING :=  "UNREGISTERED";
		zero_loopback_aclr						: STRING :=  "NONE";
		zero_loopback_sclr						: STRING :=  "NONE";			-- added for sclr support	
		zero_loopback_pipeline_register			: STRING :=  "UNREGISTERED";
		zero_loopback_pipeline_aclr				: STRING :=  "NONE";
		zero_loopback_pipeline_sclr				: STRING :=  "NONE";			-- added for sclr support	
		zero_loopback_output_register			: STRING :=  "UNREGISTERED";
		zero_loopback_output_aclr				: STRING :=  "NONE";
		zero_loopback_output_sclr				: STRING :=  "NONE";			-- added for sclr support	
		accumulator								: STRING :=  "NO";
		accum_direction							: STRING :=  "ADD";
		double_accum							: STRING :=  "NO";
		loadconst_value							: INTEGER :=  0;
		use_sload_accum_port					: STRING :=  "NO";
		accum_sload_register					: STRING :=  "UNREGISTERED";
		accum_sload_aclr						: STRING :=  "NONE";
		accum_sload_sclr						: STRING :=  "NONE";			-- added for sclr support		
		accum_sload_pipeline_register			: STRING :=  "UNREGISTERED";
		accum_sload_pipeline_aclr				: STRING :=  "NONE";
		accum_sload_pipeline_sclr				: STRING :=  "NONE";			-- added for sclr support		
		loadconst_control_register				: STRING :=  "UNREGISTERED";
		loadconst_control_aclr					: STRING :=  "NONE";
		loadconst_control_sclr					: STRING :=  "NONE";			-- added for sclr support
		systolic_delay1							: STRING :=  "UNREGISTERED";
		systolic_delay3							: STRING :=  "UNREGISTERED";
		systolic_aclr1							: STRING :=  "NONE";
		systolic_sclr1							: STRING :=  "NONE";			-- added for sclr support
		systolic_aclr3							: STRING :=  "NONE";
		systolic_sclr3							: STRING :=  "NONE";			-- added for sclr support
		preadder_mode							: STRING :=  "SIMPLE";
		preadder_direction_0					: STRING :=  "ADD";
		preadder_direction_1					: STRING :=  "ADD";
		preadder_direction_2					: STRING :=  "ADD";
		preadder_direction_3					: STRING :=  "ADD";
		width_coef								: INTEGER :=  1;
		coefsel0_register						: STRING :=  "UNREGISTERED";
		coefsel0_aclr							: STRING :=  "NONE";
		coefsel0_sclr							: STRING :=  "NONE";			-- added for sclr support
		coefsel1_register						: STRING :=  "UNREGISTERED";
		coefsel1_aclr							: STRING :=  "NONE";
		coefsel1_sclr							: STRING :=  "NONE";			-- added for sclr support
		coefsel2_register						: STRING :=  "UNREGISTERED";
		coefsel2_aclr							: STRING :=  "NONE";
		coefsel2_sclr							: STRING :=  "NONE";			-- added for sclr support
		coefsel3_register						: STRING :=  "UNREGISTERED";
		coefsel3_aclr							: STRING :=  "NONE";
		coefsel3_sclr							: STRING :=  "NONE";			-- added for sclr support
		coef0_0									: INTEGER :=  0;
		coef0_1									: INTEGER :=  0;
		coef0_2									: INTEGER :=  0;
		coef0_3									: INTEGER :=  0;
		coef0_4									: INTEGER :=  0;
		coef0_5									: INTEGER :=  0;
		coef0_6									: INTEGER :=  0;
		coef0_7									: INTEGER :=  0;
		coef1_0									: INTEGER :=  0;
		coef1_1									: INTEGER :=  0;
		coef1_2									: INTEGER :=  0;
		coef1_3									: INTEGER :=  0;
		coef1_4									: INTEGER :=  0;
		coef1_5									: INTEGER :=  0;
		coef1_6									: INTEGER :=  0;
		coef1_7									: INTEGER :=  0;
		coef2_0									: INTEGER :=  0;
		coef2_1									: INTEGER :=  0;
		coef2_2									: INTEGER :=  0;
		coef2_3									: INTEGER :=  0;
		coef2_4									: INTEGER :=  0;
		coef2_5									: INTEGER :=  0;
		coef2_6									: INTEGER :=  0;
		coef2_7									: INTEGER :=  0;
		coef3_0									: INTEGER :=  0;
		coef3_1									: INTEGER :=  0;
		coef3_2									: INTEGER :=  0;
		coef3_3									: INTEGER :=  0;
		coef3_4									: INTEGER :=  0;
		coef3_5									: INTEGER :=  0;
		coef3_6									: INTEGER :=  0;
		coef3_7									: INTEGER :=  0;
		latency									: INTEGER :=  0;
		input_a0_latency_clock					: STRING :=  "UNREGISTERED";
		input_a0_latency_aclr					: STRING :=  "NONE";
		input_a0_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		input_a1_latency_clock					: STRING :=  "UNREGISTERED";
		input_a1_latency_aclr					: STRING :=  "NONE";
		input_a1_latency_sclr					: STRING :=  "NONE";			-- added for sclr support	
		input_a2_latency_clock					: STRING :=  "UNREGISTERED";
		input_a2_latency_aclr					: STRING :=  "NONE";
		input_a2_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		input_a3_latency_clock					: STRING :=  "UNREGISTERED";
		input_a3_latency_aclr					: STRING :=  "NONE";	
		input_a3_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		input_b0_latency_clock					: STRING :=  "UNREGISTERED";
		input_b0_latency_aclr					: STRING :=  "NONE";
		input_b0_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		input_b1_latency_clock					: STRING :=  "UNREGISTERED";
		input_b1_latency_aclr					: STRING :=  "NONE";
		input_b1_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		input_b2_latency_clock					: STRING :=  "UNREGISTERED";
		input_b2_latency_aclr					: STRING :=  "NONE";
		input_b2_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		input_b3_latency_clock					: STRING :=  "UNREGISTERED";
		input_b3_latency_aclr					: STRING :=  "NONE";
		input_b3_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		input_c0_latency_clock					: STRING :=  "UNREGISTERED";
		input_c0_latency_aclr					: STRING :=  "NONE";
		input_c0_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		input_c1_latency_clock					: STRING :=  "UNREGISTERED";
		input_c1_latency_aclr					: STRING :=  "NONE";
		input_c1_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		input_c2_latency_clock					: STRING :=  "UNREGISTERED";
		input_c2_latency_aclr					: STRING :=  "NONE";
		input_c2_latency_sclr					: STRING :=  "NONE";			-- added for sclr support	
		input_c3_latency_clock					: STRING :=  "UNREGISTERED";
		input_c3_latency_aclr					: STRING :=  "NONE";
		input_c3_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		coefsel0_latency_clock					: STRING :=  "UNREGISTERED";
		coefsel0_latency_aclr					: STRING :=  "NONE";	
		coefsel0_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		coefsel1_latency_clock					: STRING :=  "UNREGISTERED";
		coefsel1_latency_aclr					: STRING :=  "NONE";
		coefsel1_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		coefsel2_latency_clock					: STRING :=  "UNREGISTERED";
		coefsel2_latency_aclr					: STRING :=  "NONE";
		coefsel2_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		coefsel3_latency_clock					: STRING :=  "UNREGISTERED";
		coefsel3_latency_aclr					: STRING :=  "NONE";
		coefsel3_latency_sclr					: STRING :=  "NONE";			-- added for sclr support
		signed_latency_clock_a					: STRING :=  "UNREGISTERED";
		signed_latency_aclr_a					: STRING :=  "NONE";
		signed_latency_sclr_a					: STRING :=  "NONE";			-- added for sclr support	
		signed_latency_clock_b					: STRING :=  "UNREGISTERED";
		signed_latency_aclr_b					: STRING :=  "NONE";
		signed_latency_sclr_b					: STRING :=  "NONE";			-- added for sclr support	
		addnsub_multiplier_latency_clock1		: STRING :=  "UNREGISTERED";
		addnsub_multiplier_latency_aclr1		: STRING :=  "NONE";
		addnsub_multiplier_latency_sclr1		: STRING :=  "NONE";			-- added for sclr support	
		addnsub_multiplier_latency_clock3		: STRING :=  "UNREGISTERED";
		addnsub_multiplier_latency_aclr3		: STRING :=  "NONE";
		addnsub_multiplier_latency_sclr3		: STRING :=  "NONE";			-- added for sclr support
		accum_sload_latency_clock				: STRING :=  "UNREGISTERED";
		accum_sload_latency_aclr				: STRING :=  "NONE";
		accum_sload_latency_sclr				: STRING :=  "NONE"			-- added for sclr support
    );
   PORT (
		dataa						: IN    STD_LOGIC_VECTOR(width_a * number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		datab						: IN    STD_LOGIC_VECTOR(width_b * number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		datac						: IN    STD_LOGIC_VECTOR(width_c * number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		scanina						: IN    STD_LOGIC_VECTOR(width_a - 1 downto 0) := (OTHERS => '0');
		scaninb						: IN    STD_LOGIC_VECTOR(width_b - 1 downto 0) := (OTHERS => '0');
		sourcea						: IN    STD_LOGIC_VECTOR(number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		sourceb						: IN    STD_LOGIC_VECTOR(number_of_multipliers - 1 downto 0) := (OTHERS => '0');
		clock3						: IN    STD_LOGIC := '0';
		clock2 						: IN    STD_LOGIC := '0';
		clock1 						: IN    STD_LOGIC := '0';
		clock0 						: IN    STD_LOGIC := '0';
		aclr3 						: IN    STD_LOGIC := '0';
		aclr2 						: IN    STD_LOGIC := '0';
		aclr1 						: IN    STD_LOGIC := '0';
		aclr0 						: IN    STD_LOGIC := '0';
		sclr3 						: IN    STD_LOGIC := '0';		-- added for sclr support
		sclr2 						: IN    STD_LOGIC := '0';		-- added for sclr support
		sclr1 						: IN    STD_LOGIC := '0';		-- added for sclr support
		sclr0 						: IN    STD_LOGIC := '0';		-- added for sclr support
		ena3 						: IN    STD_LOGIC := '1';
		ena2 						: IN    STD_LOGIC := '1';
		ena1 						: IN    STD_LOGIC := '1';
		ena0 						: IN    STD_LOGIC := '1';
		signa 						: IN    STD_LOGIC := '0';
		signb 						: IN    STD_LOGIC := '0';
		addnsub1 					: IN    STD_LOGIC := '0';
		addnsub3 					: IN    STD_LOGIC := '0';
		result 						: OUT    STD_LOGIC_VECTOR(width_result - 1 downto 0);
		scanouta					: OUT    STD_LOGIC_VECTOR(width_a - 1 downto 0);
		scanoutb					: OUT    STD_LOGIC_VECTOR(width_b - 1 downto 0);
		mult01_round 				: IN    STD_LOGIC := '0';
		mult23_round 				: IN    STD_LOGIC := '0';
		mult01_saturation 			: IN    STD_LOGIC := '0';
		mult23_saturation 			: IN    STD_LOGIC := '0';
		addnsub1_round 				: IN    STD_LOGIC := '0';
		addnsub3_round 				: IN    STD_LOGIC := '0';
		mult0_is_saturated 			: OUT    STD_LOGIC;
		mult1_is_saturated 			: OUT    STD_LOGIC;
		mult2_is_saturated 			: OUT    STD_LOGIC;
		mult3_is_saturated 			: OUT    STD_LOGIC;
		output_round 				: IN    STD_LOGIC := '0';
		chainout_round 				: IN    STD_LOGIC := '0';
		output_saturate 			: IN    STD_LOGIC := '0';
		chainout_saturate 			: IN    STD_LOGIC := '0';
		overflow 					: OUT    STD_LOGIC;
		chainout_sat_overflow 		: OUT    STD_LOGIC;
		chainin						: IN    STD_LOGIC_VECTOR(width_chainin - 1 downto 0) := (OTHERS => '0');
		zero_chainout 				: IN    STD_LOGIC := '0';
		rotate 						: IN    STD_LOGIC := '0';
		shift_right 				: IN    STD_LOGIC := '0';
		zero_loopback 				: IN    STD_LOGIC := '0';
		accum_sload 				: IN    STD_LOGIC := '0';
		sload_accum 				: IN    STD_LOGIC := '0';
		negate 						: IN    STD_LOGIC := '0';
		coefsel0					: IN    STD_LOGIC_VECTOR(2 downto 0) := (OTHERS => '0');
		coefsel1					: IN    STD_LOGIC_VECTOR(2 downto 0) := (OTHERS => '0');
		coefsel2					: IN    STD_LOGIC_VECTOR(2 downto 0) := (OTHERS => '0');
		coefsel3					: IN    STD_LOGIC_VECTOR(2 downto 0) := (OTHERS => '0')
    );
end component;
	
component altera_pll_reconfig_tasks 
    generic(
		number_of_fplls :integer := 1
    );
end component;
	
component altera_syncram
    generic (
        operation_mode                 : string := "BIDIR_DUAL_PORT";
        -- port a parameters
        width_a                        : integer := 1;
        widthad_a                      : integer := 1;
	widthad2_a                     : integer := 1;			   
        numwords_a                     : integer := 0;
        -- registering parameters
        -- port a read parameters
        outdata_reg_a                  : string := "UNREGISTERED";
        -- clearing parameters
        address_aclr_a                 : string := "NONE";
        outdata_aclr_a                 : string := "NONE";
        -- clearing parameters
        -- port a write parameters
        -- width of the byte enable ports. if it is used, must be WIDTH_WRITE_A/8 or /9
        width_byteena_a                : integer := 1;
        -- port b parameters
        width_b                        : integer := 1;
        widthad_b                      : integer := 1;
	widthad2_b                     : integer := 1;
        numwords_b                     : integer := 0;
        -- registering parameters
        -- port b read parameters
        rdcontrol_reg_b                : string := "CLOCK1";
        address_reg_b                  : string := "CLOCK1";
        outdata_reg_b                  : string := "UNREGISTERED";
        -- clearing parameters
        outdata_aclr_b                 : string := "NONE";
        -- registering parameters
        -- port b write parameters
        indata_reg_b                   : string := "CLOCK1";
        -- registering parameter for the byte enable reister for port b
        byteena_reg_b                  : string := "CLOCK1";
        -- clearing parameters
        address_aclr_b                 : string := "NONE";
        -- clear parameter for byte enable port register
        clock_enable_input_a           : string := "NORMAL";
        clock_enable_output_a          : string := "NORMAL";
        clock_enable_input_b           : string := "NORMAL";
        clock_enable_output_b          : string := "NORMAL";
        -- width of the byte enable ports. if it is used, must be WIDTH_WRITE_A/8 or /9
        width_byteena_b                : integer := 1;
        -- clock enable setting for the core
        clock_enable_core_a            : string := "USE_INPUT_CLKEN";
        clock_enable_core_b            : string := "USE_INPUT_CLKEN";
        -- read-during-write-same-port setting
        read_during_write_mode_port_a  : string := "NEW_DATA_NO_NBE_READ";
        read_during_write_mode_port_b  : string := "NEW_DATA_NO_NBE_READ";
        -- ECC status ports setting
        enable_ecc                     : string := "FALSE";
		ecc_pipeline_stage_enabled	   : string := "FALSE";
		
		width_eccstatus                : integer := 2;
        -- global parameters
        -- width of a byte for byte enables
        byte_size                      : integer := 0;
        read_during_write_mode_mixed_ports: string := "DONT_CARE";
        -- ram block type choices are "AUTO", "M20K", "M10K" and "MLAB"
        ram_block_type                 : string := "AUTO";
        -- determine whether LE support is turned on or off for altsyncram
        implement_in_les               : string := "OFF";
        -- determine whether RAM would be power up to uninitialized or not
        power_up_uninitialized         : string := "FALSE";

        sim_show_memory_data_in_port_b_layout :  string  := "OFF";

        -- Nadder New Features
        outdata_sclr_a                 : string := "NONE";
        outdata_sclr_b                 : string := "NONE";
        enable_ecc_encoder_bypass      : string := "FALSE";
        enable_coherent_read           : string := "FALSE";
	enable_force_to_zero	       : string := "FALSE";
        width_eccencparity             : integer := 8;
        
        -- general operation parameters
        init_file                      : string := "UNUSED";
        init_file_layout               : string := "UNUSED";
        maximum_depth                  : integer := 0;
        intended_device_family         : string := "Arria 10";
        lpm_hint                       : string := "UNUSED";
        lpm_type                       : string := "altsyncram" );
    port (
        wren_a    : in std_logic := '0';
        wren_b    : in std_logic := '0';
        rden_a    : in std_logic := '1';
        rden_b    : in std_logic := '1';
        data_a    : in std_logic_vector(width_a - 1 downto 0):= (others => '1');
        data_b    : in std_logic_vector(width_b - 1 downto 0):= (others => '1');
        address_a : in std_logic_vector(widthad_a - 1 downto 0);
        address_b : in std_logic_vector(widthad_b - 1 downto 0) := (others => '1');

        clock0    : in std_logic := '1';
        clock1    : in std_logic := 'Z';
        clocken0  : in std_logic := '1';
        clocken1  : in std_logic := '1';
        clocken2  : in std_logic := '1';
        clocken3  : in std_logic := '1';
        aclr0     : in std_logic := '0';
        aclr1     : in std_logic := '0';
        byteena_a : in std_logic_vector( (width_byteena_a - 1) downto 0) := (others => '1');
        byteena_b : in std_logic_vector( (width_byteena_b - 1) downto 0) := (others => 'Z');

        -- Nadder New Features
        eccencbypass    : in std_logic := '0';
        eccencparity    : in std_logic_vector( (width_eccencparity - 1) downto 0) := (others => '1');
        sclr            : in std_logic := '0';
        address2_a 	: in std_logic_vector(widthad2_a - 1 downto 0) := (others => '1');
        address2_b 	: in std_logic_vector(widthad2_b - 1 downto 0) := (others => '1');
        
        addressstall_a : in std_logic := '0';
        addressstall_b : in std_logic := '0';

        q_a            : out std_logic_vector(width_a - 1 downto 0);
        q_b            : out std_logic_vector(width_b - 1 downto 0);

        eccstatus      : out std_logic_vector(width_eccstatus-1 downto 0) := (others => '0') );
end component;

component iopll_bootstrap
    generic(
        PLL_CTR_RESYNC                 : integer := 0;
        PLL_AUTO_RESET_ON_LOSS_OF_LOCK : integer := 0
    );
    port(
      u_dprio_clk       :  in	std_logic := '0';
      u_dprio_rst_n     :  in	std_logic := '0';
      u_dprio_address   :  in std_logic_vector(8 downto 0) := (others => '0');
      u_dprio_write     :  in	std_logic := '0';
      u_dprio_writedata :  in std_logic_vector(7 downto 0) := (others => '0');
      u_rst_n           :  in	std_logic := '0';
      pll_locked        :  in	std_logic := '0';
    
      pll_dprio_clk        :  out std_logic;
      pll_dprio_rst_n      :  out std_logic;
      pll_dprio_address    :  out std_logic_vector(8 downto 0);
      pll_dprio_write      :  out std_logic;
      pll_dprio_writedata  :  out std_logic_vector(7 downto 0);
      pll_rst_n            :  out std_logic;
      u_locked             :  out std_logic
    );
end component;

end altera_lnsim_components;
