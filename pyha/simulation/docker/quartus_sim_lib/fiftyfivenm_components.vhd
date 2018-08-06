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
use IEEE.VITAL_Timing.all;
use work.fiftyfivenm_atom_pack.all;

package fiftyfivenm_components is


--
-- fiftyfivenm_lcell_comb
--

COMPONENT fiftyfivenm_lcell_comb
    generic (
             lut_mask : std_logic_vector(15 downto 0) := (OTHERS => '1');
             sum_lutc_input : string := "datac";
              dont_touch : string := "off";
             lpm_type : string := "fiftyfivenm_lcell_comb";
             TimingChecksOn: Boolean := True;
             MsgOn: Boolean := DefGlitchMsgOn;
             XOn: Boolean := DefGlitchXOn;
             MsgOnChecks: Boolean := DefMsgOnChecks;
             XOnChecks: Boolean := DefXOnChecks;
             InstancePath: STRING := "*";
             tpd_dataa_combout : VitalDelayType01 := DefPropDelay01;
             tpd_datab_combout : VitalDelayType01 := DefPropDelay01;
             tpd_datac_combout : VitalDelayType01 := DefPropDelay01;
             tpd_datad_combout : VitalDelayType01 := DefPropDelay01;
             tpd_cin_combout : VitalDelayType01 := DefPropDelay01;
             tpd_dataa_cout : VitalDelayType01 := DefPropDelay01;
             tpd_datab_cout : VitalDelayType01 := DefPropDelay01;
             tpd_datac_cout : VitalDelayType01 := DefPropDelay01;
             tpd_datad_cout : VitalDelayType01 := DefPropDelay01;
             tpd_cin_cout : VitalDelayType01 := DefPropDelay01;
             tipd_dataa : VitalDelayType01 := DefPropDelay01; 
             tipd_datab : VitalDelayType01 := DefPropDelay01; 
             tipd_datac : VitalDelayType01 := DefPropDelay01; 
             tipd_datad : VitalDelayType01 := DefPropDelay01; 
             tipd_cin : VitalDelayType01 := DefPropDelay01
            );
    port (
          dataa : in std_logic := '1';
          datab : in std_logic := '1';
          datac : in std_logic := '1';
          datad : in std_logic := '1';
          cin : in std_logic := '0';
          combout : out std_logic;
          cout : out std_logic
         );
END COMPONENT;

--
-- fiftyfivenm_routing_wire
--

COMPONENT fiftyfivenm_routing_wire
    generic (
             MsgOn : Boolean := DefGlitchMsgOn;
             XOn : Boolean := DefGlitchXOn;
             tpd_datain_dataout : VitalDelayType01 := DefPropDelay01;
             tpd_datainglitch_dataout : VitalDelayType01 := DefPropDelay01;
             tipd_datain : VitalDelayType01 := DefPropDelay01
            );
    PORT (
          datain : in std_logic;
          dataout : out std_logic
         );
END COMPONENT;

--
-- fiftyfivenm_ff
--

COMPONENT fiftyfivenm_ff
    generic (
             power_up : string := "low";
             x_on_violation : string := "on";
             lpm_type : string := "fiftyfivenm_ff";
             tsetup_d_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             tsetup_asdata_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             tsetup_sclr_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             tsetup_sload_clk_noedge_posedge	: VitalDelayType := DefSetupHoldCnst;
             tsetup_ena_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             thold_d_clk_noedge_posedge	: VitalDelayType := DefSetupHoldCnst;
             thold_asdata_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             thold_sclr_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             thold_sload_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             thold_ena_clk_noedge_posedge	: VitalDelayType := DefSetupHoldCnst;
             tpd_clk_q_posedge : VitalDelayType01 := DefPropDelay01;
             tpd_clrn_q_posedge : VitalDelayType01 := DefPropDelay01;
             tpd_aload_q_posedge : VitalDelayType01 := DefPropDelay01;
             tpd_asdata_q: VitalDelayType01 := DefPropDelay01;
             tipd_clk : VitalDelayType01 := DefPropDelay01;
             tipd_d : VitalDelayType01 := DefPropDelay01;
             tipd_asdata : VitalDelayType01 := DefPropDelay01;
             tipd_sclr : VitalDelayType01 := DefPropDelay01; 
             tipd_sload : VitalDelayType01 := DefPropDelay01;
             tipd_clrn : VitalDelayType01 := DefPropDelay01; 
             tipd_aload : VitalDelayType01 := DefPropDelay01; 
             tipd_ena : VitalDelayType01 := DefPropDelay01; 
             TimingChecksOn: Boolean := True;
             MsgOn: Boolean := DefGlitchMsgOn;
             XOn: Boolean := DefGlitchXOn;
             MsgOnChecks: Boolean := DefMsgOnChecks;
             XOnChecks: Boolean := DefXOnChecks;
             InstancePath: STRING := "*"
            );
    port (
          d : in std_logic := '0';
          clk : in std_logic := '0';
          clrn : in std_logic := '1';
          aload : in std_logic := '0';
          sclr : in std_logic := '0';
          sload : in std_logic := '0';
          ena : in std_logic := '1';
          asdata : in std_logic := '0';
          devclrn : in std_logic := '1';
          devpor : in std_logic := '1';
          q : out std_logic
         );
END COMPONENT;

--
-- fiftyfivenm_ram_block
--

COMPONENT fiftyfivenm_ram_block
    GENERIC (
        operation_mode                 :  STRING := "single_port";    
        mixed_port_feed_through_mode   :  STRING := "dont_care";    
        ram_block_type                 :  STRING := "auto";    
        logical_ram_name               :  STRING := "ram_name";    
        init_file                      :  STRING := "init_file.hex";    
        init_file_layout               :  STRING := "none";    
        data_interleave_width_in_bits  :  INTEGER := 1;    
        data_interleave_offset_in_bits :  INTEGER := 1;    
        port_a_logical_ram_depth       :  INTEGER := 0;    
        port_a_logical_ram_width       :  INTEGER := 0;    
        port_a_first_address           :  INTEGER := 0;    
        port_a_last_address            :  INTEGER := 0;    
        port_a_first_bit_number        :  INTEGER := 0;    
        port_a_address_clear           :  STRING := "none";    
        port_a_data_out_clear          :  STRING := "none";    
        port_a_data_in_clock           :  STRING := "clock0";    
        port_a_address_clock           :  STRING := "clock0";    
        port_a_write_enable_clock      :  STRING := "clock0";    
        port_a_read_enable_clock     :  STRING := "clock0";           
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
        port_b_write_enable_clock: STRING := "clock1";    
        port_b_read_enable_clock: STRING := "clock1";    
        port_b_byte_enable_clock       :  STRING := "clock1";    
        port_b_data_out_clock          :  STRING := "none";    
        port_b_data_width              :  INTEGER := 1;    
        port_b_address_width           :  INTEGER := 1;    
        port_b_byte_enable_mask_width  :  INTEGER := 1;    
        port_a_read_during_write_mode  :  STRING  := "new_data_no_nbe_read";
        port_b_read_during_write_mode  :  STRING  := "new_data_no_nbe_read";    
        power_up_uninitialized         :  STRING := "false";  
        port_b_byte_size : INTEGER := 0;
        port_a_byte_size : INTEGER := 0;  
        safe_write : STRING := "err_on_2clk";  
        init_file_restructured : STRING := "unused";  
        lpm_type                  : string := "fiftyfivenm_ram_block";
        lpm_hint                  : string := "true";
        clk0_input_clock_enable  : STRING := "none"; -- ena0,ena2,none
        clk0_core_clock_enable   : STRING := "none"; -- ena0,ena2,none
        clk0_output_clock_enable : STRING := "none"; -- ena0,none
        clk1_input_clock_enable  : STRING := "none"; -- ena1,ena3,none
        clk1_core_clock_enable   : STRING := "none"; -- ena1,ena3,none
        clk1_output_clock_enable : STRING := "none"; -- ena1,none
        mem_init0 : BIT_VECTOR  := X"0";
        mem_init1 : BIT_VECTOR  := X"0";
        mem_init2 : BIT_VECTOR := X"0";
        mem_init3 : BIT_VECTOR := X"0";
        mem_init4 : BIT_VECTOR := X"0";
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
        portabyteenamasks       : IN STD_LOGIC_VECTOR(port_a_byte_enable_mask_width - 1 DOWNTO 0) := (OTHERS => '1');   
        portbbyteenamasks       : IN STD_LOGIC_VECTOR(port_b_byte_enable_mask_width - 1 DOWNTO 0) := (OTHERS => '1');   
        devclrn                 : IN STD_LOGIC := '1';   
        devpor                  : IN STD_LOGIC := '1';   
         portaaddrstall : IN STD_LOGIC := '0';
         portbaddrstall : IN STD_LOGIC := '0';
        portadataout            : OUT STD_LOGIC_VECTOR(port_a_data_width - 1 DOWNTO 0);   
        portbdataout            : OUT STD_LOGIC_VECTOR(port_b_data_width - 1 DOWNTO 0)
        );
END COMPONENT;

--
-- fiftyfivenm_mac_mult
--

COMPONENT fiftyfivenm_mac_mult
    GENERIC (
             dataa_width : integer := 18;    
             datab_width : integer := 18;
             dataa_clock : string := "none";    
             datab_clock : string := "none";    
             signa_clock : string := "none";    
             signb_clock : string := "none";    
             TimingChecksOn : Boolean := True;
             MsgOn : Boolean := DefGlitchMsgOn;
             XOn : Boolean := DefGlitchXOn;
             MsgOnChecks : Boolean := DefMsgOnChecks;
             XOnChecks : Boolean := DefXOnChecks;
             InstancePath : STRING := "*";
             lpm_hint : string := "true";    
             lpm_type : string := "fiftyfivenm_mac_mult"
            );
    PORT (
          dataa : IN std_logic_vector(dataa_width-1 DOWNTO 0) := (OTHERS => '0');
          datab : IN std_logic_vector(datab_width-1 DOWNTO 0) := (OTHERS => '0');
          signa : IN std_logic := '1';
          signb : IN std_logic := '1';
          clk : IN std_logic := '0';
          aclr : IN std_logic := '0';
          ena : IN std_logic := '0';
          dataout : OUT std_logic_vector((dataa_width+datab_width)-1 DOWNTO 0);   
          devclrn : IN std_logic := '1';
          devpor : IN std_logic := '1'
         );   
END COMPONENT;

--
-- fiftyfivenm_mac_out
--

COMPONENT fiftyfivenm_mac_out
    GENERIC (
             dataa_width : integer := 1;
             output_clock : string := "none";    
			 TimingChecksOn : Boolean := True;
             MsgOn : Boolean := DefGlitchMsgOn;
             XOn : Boolean := DefGlitchXOn;
             MsgOnChecks : Boolean := DefMsgOnChecks;
             XOnChecks : Boolean := DefXOnChecks;
             InstancePath : STRING := "*";
             tipd_dataa : VitalDelayArrayType01(35 downto 0)
                                   := (OTHERS => DefPropDelay01);
             tipd_clk : VitalDelayType01 := DefPropDelay01;
             tipd_ena : VitalDelayType01 := DefPropDelay01;
             tipd_aclr : VitalDelayType01 := DefPropDelay01;
             tpd_dataa_dataout :VitalDelayArrayType01(36*36 -1 downto 0) :=(others => DefPropDelay01);
             tpd_aclr_dataout_posedge : VitalDelayArrayType01(35 downto 0) :=(others => DefPropDelay01);
             tpd_clk_dataout_posedge :VitalDelayArrayType01(35  downto 0) :=(others => DefPropDelay01);
             tsetup_dataa_clk_noedge_posedge : VitalDelayArrayType(35 downto 0) := (OTHERS => DefSetupHoldCnst);
             thold_dataa_clk_noedge_posedge :  VitalDelayArrayType(35 downto 0) := (OTHERS => DefSetupHoldCnst);
             tsetup_ena_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             thold_ena_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             lpm_hint : string := "true";    
             lpm_type : string := "fiftyfivenm_mac_out");    
    PORT (
          dataa : IN std_logic_vector(dataa_width-1 DOWNTO 0) := (OTHERS => '0');
          clk : IN std_logic := '0';
          aclr : IN std_logic := '0';
          ena : IN std_logic := '1';
          dataout : OUT std_logic_vector(dataa_width-1 DOWNTO 0);   
          devclrn : IN std_logic := '1';
          devpor : IN std_logic := '1'
         );   
END COMPONENT;

--
-- fiftyfivenm_pseudo_diff_out
--

COMPONENT fiftyfivenm_pseudo_diff_out
 GENERIC (
             tipd_i                           : VitalDelayType01 := DefPropDelay01;
             tpd_i_o                          : VitalDelayType01 := DefPropDelay01;
             tpd_i_obar                       : VitalDelayType01 := DefPropDelay01;
             XOn                           : Boolean := DefGlitchXOn;
             MsgOn                         : Boolean := DefGlitchMsgOn;
             lpm_type                         :  string := "fiftyfivenm_pseudo_diff_out"
            );
 PORT (
           i                       : IN std_logic := '0';
           o                       : OUT std_logic;
           obar                    : OUT std_logic
         );
END COMPONENT;

--
-- fiftyfivenm_io_pad
--

COMPONENT fiftyfivenm_io_pad
    GENERIC (
        lpm_type                       :  string := "fiftyfivenm_io_pad");    
    PORT (
        padin                   : IN std_logic := '0';   -- Input Pad
        padout                  : OUT std_logic);   -- Output Pad
END COMPONENT;

--
-- fiftyfivenm_pll
--

COMPONENT fiftyfivenm_pll
    GENERIC (
        operation_mode              : string := "normal";
        pll_type                    : string := "auto";  -- AUTO/FAST/ENHANCED/LEFT_RIGHT/TOP_BOTTOM
        compensate_clock            : string := "clock0";
        inclk0_input_frequency      : integer := 0;
        inclk1_input_frequency      : integer := 0;
        self_reset_on_loss_lock     : string  := "off";
        switch_over_type            : string  := "auto";
        switch_over_counter         : integer := 1;
        enable_switch_over_counter  : string := "off";
        bandwidth                    : integer := 0;
        bandwidth_type               : string  := "auto";
        use_dc_coupling              : string  := "false";
        lock_c                      : integer := 4;
        sim_gate_lock_device_behavior : string := "off";
        lock_high                   : integer := 0;
        lock_low                    : integer := 0;
        lock_window_ui              : string := "0.05";
        lock_window                 : time := 5 ps;
        test_bypass_lock_detect     : string := "off";
        clk0_output_frequency       : integer := 0;
        clk0_multiply_by            : integer := 0;
        clk0_divide_by              : integer := 0;
        clk0_phase_shift            : string := "0";
        clk0_duty_cycle             : integer := 50;
        clk1_output_frequency       : integer := 0;
        clk1_multiply_by            : integer := 0;
        clk1_divide_by              : integer := 0;
        clk1_phase_shift            : string := "0";
        clk1_duty_cycle             : integer := 50;
        clk2_output_frequency       : integer := 0;
        clk2_multiply_by            : integer := 0;
        clk2_divide_by              : integer := 0;
        clk2_phase_shift            : string := "0";
        clk2_duty_cycle             : integer := 50;
        clk3_output_frequency       : integer := 0;
        clk3_multiply_by            : integer := 0;
        clk3_divide_by              : integer := 0;
        clk3_phase_shift            : string := "0";
        clk3_duty_cycle             : integer := 50;
        clk4_output_frequency       : integer := 0;
        clk4_multiply_by            : integer := 0;
        clk4_divide_by              : integer := 0;
        clk4_phase_shift            : string := "0";
        clk4_duty_cycle             : integer := 50;
        pfd_min                     : integer := 0;
        pfd_max                     : integer := 0;
        vco_min                     : integer := 0;
        vco_max                     : integer := 0;
        vco_center                  : integer := 0;
        m_initial                   : integer := 1;
        m                           : integer := 0;
        n                           : integer := 1;
        c0_high                     : integer := 1;
        c0_low                      : integer := 1;
        c0_initial                  : integer := 1; 
        c0_mode                     : string := "bypass";
        c0_ph                       : integer := 0;
        c1_high                     : integer := 1;
        c1_low                      : integer := 1;
        c1_initial                  : integer := 1;
        c1_mode                     : string := "bypass";
        c1_ph                       : integer := 0;
        c2_high                     : integer := 1;
        c2_low                      : integer := 1;
        c2_initial                  : integer := 1;
        c2_mode                     : string := "bypass";
        c2_ph                       : integer := 0;
        c3_high                     : integer := 1;
        c3_low                      : integer := 1;
        c3_initial                  : integer := 1;
        c3_mode                     : string := "bypass";
        c3_ph                       : integer := 0;
        c4_high                     : integer := 1;
        c4_low                      : integer := 1;
        c4_initial                  : integer := 1;
        c4_mode                     : string := "bypass";
        c4_ph                       : integer := 0;
        m_ph                        : integer := 0;
        clk0_counter                : string := "unused";
        clk1_counter                : string := "unused";
        clk2_counter                : string := "unused";
        clk3_counter                : string := "unused";
        clk4_counter                : string := "unused";
        c1_use_casc_in              : string := "off";
        c2_use_casc_in              : string := "off";
        c3_use_casc_in              : string := "off";
        c4_use_casc_in              : string := "off";
        m_test_source               : integer := -1;
        c0_test_source              : integer := -1;
        c1_test_source              : integer := -1;
        c2_test_source              : integer := -1;
        c3_test_source              : integer := -1;
        c4_test_source              : integer := -1;
        vco_multiply_by             : integer := 0;
        vco_divide_by               : integer := 0;
        vco_post_scale              : integer := 1;
        vco_frequency_control       : string  := "auto";
        vco_phase_shift_step        : integer := 0;
        charge_pump_current         : integer := 10;
        loop_filter_r               : string := " 1.0";
        loop_filter_c               : integer := 0;
        pll_compensation_delay      : integer := 0;
        simulation_type             : string := "functional";
        lpm_type                    : string := "fiftyfivenm_pll";
        clk0_use_even_counter_mode  : string := "off";
        clk1_use_even_counter_mode  : string := "off";
        clk2_use_even_counter_mode  : string := "off";
        clk3_use_even_counter_mode  : string := "off";
        clk4_use_even_counter_mode  : string := "off";
        clk0_use_even_counter_value : string := "off";
        clk1_use_even_counter_value : string := "off";
        clk2_use_even_counter_value : string := "off";
        clk3_use_even_counter_value : string := "off";
        clk4_use_even_counter_value : string := "off";
        init_block_reset_a_count    : integer := 1;
        init_block_reset_b_count    : integer := 1;
        charge_pump_current_bits : integer := 0;
        lock_window_ui_bits : integer := 0;
        loop_filter_c_bits : integer := 0;
        loop_filter_r_bits : integer := 0;
        test_counter_c0_delay_chain_bits : integer := 0;
        test_counter_c1_delay_chain_bits : integer := 0;
        test_counter_c2_delay_chain_bits : integer := 0;
        test_counter_c3_delay_chain_bits : integer := 0;
        test_counter_c4_delay_chain_bits : integer := 0;
        test_counter_c5_delay_chain_bits : integer := 0;
        test_counter_m_delay_chain_bits : integer := 0;
        test_counter_n_delay_chain_bits : integer := 0;
        test_feedback_comp_delay_chain_bits : integer := 0;
        test_input_comp_delay_chain_bits : integer := 0;
        test_volt_reg_output_mode_bits : integer := 0;
        test_volt_reg_output_voltage_bits : integer := 0;
        test_volt_reg_test_mode : string := "false";
        vco_range_detector_high_bits : integer := -1;
        vco_range_detector_low_bits : integer := -1;
        scan_chain_mif_file : string := "";
        auto_settings : string  := "true";     
        family_name                 : string  := "Fiftyfivenm";
        XOn                         : Boolean := DefGlitchXOn;
        MsgOn                       : Boolean := DefGlitchMsgOn;
        MsgOnChecks                 : Boolean := DefMsgOnChecks;
        XOnChecks                   : Boolean := DefXOnChecks;
        TimingChecksOn              : Boolean := true;
        InstancePath                : STRING := "*";
        tipd_inclk                  : VitalDelayArrayType01(1 downto 0) := (OTHERS => DefPropDelay01);
        tipd_ena                    : VitalDelayType01 := DefPropDelay01;
        tipd_pfdena                 : VitalDelayType01 := DefPropDelay01;
        tipd_areset                 : VitalDelayType01 := DefPropDelay01;
       tipd_fbin                   : VitalDelayType01 := DefPropDelay01;
       tipd_scanclk                : VitalDelayType01 := DefPropDelay01;
       tipd_scanclkena             : VitalDelayType01 := DefPropDelay01;
       tipd_scandata               : VitalDelayType01 := DefPropDelay01;
       tipd_configupdate           : VitalDelayType01 := DefPropDelay01;
       tipd_clkswitch              : VitalDelayType01 := DefPropDelay01;
       tipd_phaseupdown            : VitalDelayType01 := DefPropDelay01;
       tipd_phasecounterselect     : VitalDelayArrayType01(2 DOWNTO 0) := (OTHERS => DefPropDelay01);
       tipd_phasestep              : VitalDelayType01 := DefPropDelay01;
       tsetup_scandata_scanclk_noedge_negedge : VitalDelayType := DefSetupHoldCnst;
       thold_scandata_scanclk_noedge_negedge  : VitalDelayType := DefSetupHoldCnst;
       tsetup_scanclkena_scanclk_noedge_negedge : VitalDelayType := DefSetupHoldCnst;
       thold_scanclkena_scanclk_noedge_negedge  : VitalDelayType := DefSetupHoldCnst;
        use_vco_bypass              : string := "false"
    );
    PORT
    (
        inclk                       : in std_logic_vector(1 downto 0);
        fbin                         : in std_logic := '0';
        fbout                        : out std_logic;
        clkswitch                   : in std_logic := '0';
        areset                      : in std_logic := '0';
        pfdena                      : in std_logic := '1';
        scandata                    : in std_logic := '0';
        scanclk                     : in std_logic := '0';
        scanclkena                  : in std_logic := '1';
        configupdate                : in std_logic := '0';
        clk                         : out std_logic_vector(4 downto 0);
        phasecounterselect          : in std_logic_vector(2 downto 0) := "000";
        phaseupdown                 : in std_logic := '0';
        phasestep                   : in std_logic := '0';
        clkbad                      : out std_logic_vector(1 downto 0);
        activeclock                 : out std_logic;
        locked                      : out std_logic;
        scandataout                 : out std_logic;
        scandone                    : out std_logic;
        phasedone                   : out std_logic;
        vcooverrange                : out std_logic;
        vcounderrange               : out std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_clkctrl
--

COMPONENT fiftyfivenm_clkctrl
    generic (
             clock_type : STRING := "Auto";
             lpm_type : STRING := "fiftyfivenm_clkctrl";
             ena_register_mode : STRING := "Falling Edge";
             TimingChecksOn : Boolean := True;
             MsgOn : Boolean := DefGlitchMsgOn;
             XOn : Boolean := DefGlitchXOn;
             MsgOnChecks : Boolean := DefMsgOnChecks;
             XOnChecks : Boolean := DefXOnChecks;
             InstancePath : STRING := "*";
             tpd_inclk_outclk : VitalDelayArrayType01(3 downto 0) := (OTHERS => DefPropDelay01);
             tipd_inclk : VitalDelayArrayType01(3 downto 0) := (OTHERS => DefPropDelay01); 
             tipd_clkselect : VitalDelayArrayType01(1 downto 0) := (OTHERS => DefPropDelay01); 
             tipd_ena : VitalDelayType01 := DefPropDelay01
             );
    port (
          inclk : in std_logic_vector(3 downto 0) := "0000";
          clkselect : in std_logic_vector(1 downto 0) := "00";
          ena : in std_logic := '1';
          devclrn : in std_logic := '1';
          devpor : in std_logic := '1';
          outclk : out std_logic
          );    
END COMPONENT;

--
-- fiftyfivenm_phy_clkbuf
--

COMPONENT fiftyfivenm_phy_clkbuf
    port (
        outclk : out std_logic_vector(3 downto 0);
        inclk : in std_logic_vector(3 downto 0) := (OTHERS => '0')
    );
END COMPONENT;

--
-- fiftyfivenm_io_clock_divider
--

COMPONENT fiftyfivenm_io_clock_divider
    generic    (
        invert_input_clock_phase    :    string    :=    "false";
        invert_output_clock_phase    :    string    :=    "false";
        use_phasectrlin    :    string    :=    "false";
        sync_mode    :    string    :=    "none"
    );
    port    (
        clk    :    in    std_logic	:= '0';
        sreset    :    in    std_logic	:= '0';
        phaseinvertctrl    :    in    std_logic	:= '0';
        clkout    :    out    std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_io_ibuf
--

COMPONENT fiftyfivenm_io_ibuf
    generic    (
        bus_hold					: string := "false";
		simulate_z_as				: string := "Z";
        listen_to_nsleep_signal		: string := "false";
		differential_mode			: string := "false";
		lpm_type					: string := "fiftyfivenm_io_ibuf"
    );
    port    (
        i    	:  in    std_logic	:= '0';
		ibar	:  in    std_logic	:= '0';
        nsleep	:  in    std_logic	:= '1';
        o    	:  out   std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_io_obuf
--

COMPONENT fiftyfivenm_io_obuf
    generic    (
        open_drain_output    : string := "false";
        bus_hold		     : string := "false"
    );
    port    (
		i   :  in    std_logic	:= '0';
        oe  :  in    std_logic	:= '1';
		devoe : in    std_logic	:= '1';
		seriesterminationcontrol	:  in    std_logic_vector(15 downto 0)	:= (OTHERS => '0');
        o   :  out    std_logic	;
        obar  : out    std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_ddio_out
--

COMPONENT fiftyfivenm_ddio_out
    generic    (
        power_up      				  : string := "low";
        async_mode    				  : string := "none";
        sync_mode     				  : string := "none";
        use_new_clocking_model    	  : string := "false";
		bypass_three_quarter_register : string := "true";
		use_enhanced_ddr_hio          : string := "false";
		lpm_type					  : string := "fiftyfivenm_ddio_out"
    );
    port    (
        datainlo    : in  std_logic	:= '0';
		datainhi	: in  std_logic	:= '0';
        clk    		: in  std_logic	:= '0';
        clkhi    	: in  std_logic	:= '0';
		clklo		: in  std_logic	:= '0';
		muxsel		: in  std_logic	:= '0';
        ena    		: in  std_logic	:= '1';
        areset    	: in  std_logic	:= '0';
		sreset		: in  std_logic	:= '0';
		dataout		: out std_logic;
        dfflo    	: out std_logic;
        dffhi    	: out std_logic;
		devpor 		: in  std_logic := '1';
		devclrn 	: in  std_logic	:= '1';
		phymemclock : in  std_logic	:= '0'
    );
END COMPONENT;

--
-- fiftyfivenm_ddio_oe
--

COMPONENT fiftyfivenm_ddio_oe
    generic    (
        power_up    					:    string    :=    "low";
        async_mode  					:    string    :=    "none";
        sync_mode  						:    string    :=    "none";
        bypass_three_quarter_register   :    string    :=    "true";
		enable_half_cycle_delay         :    string    :=    "true";
		use_enhanced_ddr_hio 			:    string    :=    "false";
		lpm_type					    :    string    :=    "fiftyfivenm_ddio_oe"
    );
    port    (
        oe    		:  in    std_logic	:= '1';
		clk			:  in    std_logic	:= '0';
        ena    		:  in    std_logic	:= '1';
        areset    	:  in    std_logic	:= '0';
		sreset 		:  in    std_logic	:= '0';
		dataout		:  out   std_logic;
		dfflo		:  out   std_logic;
		dffhi		:  out   std_logic;
		devpor		:  in    std_logic := '1';
		devclrn		:  in    std_logic	:= '1';
		phymemclock :  in    std_logic	:= '0'
    );
END COMPONENT;

--
-- fiftyfivenm_ddio_in
--

COMPONENT fiftyfivenm_ddio_in
    generic    (
        power_up    : string    :=    "low";
        async_mode  : string    :=    "none";
        sync_mode   : string    :=    "none";
        invert_input_clock   : string    :=    "false";
		lpm_type    : string    :=    "fiftyfivenm_ddio_in"
    );
    port    (
        datain    			:  in std_logic := '0';
		clk					:  in std_logic := '0';
        ena   				:  in std_logic := '1';
		areset				:  in std_logic := '0';
		sreset				:  in std_logic := '0';
        regoutlo    		:  out std_logic;
        regouthi    		:  out std_logic;
		dfflo				:  out std_logic;
		devpor				:  in std_logic := '1';
        devclrn    			:  in std_logic := '1';
        halfrateresyncclk   :  in std_logic := '0';
		clkout				:  out std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_unvm
--

COMPONENT fiftyfivenm_unvm
    generic    (
        device_id			: string	:= "02";
        init_filename_sim	: string    := "";
        identifier			: string    := "dummy";
        part_name			: string    := "dummy";
        is_dual_boot		: string    := "false";
        is_eram_skip		: string    := "false";
        is_compressed_image	: string    := "false";
        init_filename		: string    := "dummy";
        min_valid_addr		: integer   := 1;
        max_valid_addr		: integer   := 1;
        min_ufm_valid_addr	: integer   := 1;
        max_ufm_valid_addr	: integer   := 1;
        addr_range1_end_addr: integer   := 1;
        addr_range1_offset	: integer   := 1;
        addr_range2_offset	: integer   := 1;
        reserve_block       : string    :=  "false"
    );
    port    (
        arclk    				:  in std_logic := '1';
		arshft					:  in std_logic := '0';
        drclk   				:  in std_logic := '1';
		drshft					:  in std_logic := '0';
		drdin					:  in std_logic := '0';
        nprogram    			:  in std_logic := '1';
        nerase    				:  in std_logic := '1';
		nosc_ena				:  in std_logic := '0';
		par_en					:  in std_logic := '0';
        xe_ye    				:  in std_logic := '0';
        se						:  in std_logic := '0';
        ardin					:  in std_logic_vector(22 downto 0) := (OTHERS => '0');
		busy					:  out std_logic;
		osc						:  out std_logic;
		bgpbusy					:  out std_logic;
		se_pass					:  out std_logic;
		sp_pass					:  out std_logic;
		drdout					:  out std_logic_vector(31 downto 0)
    );
END COMPONENT;

--
-- fiftyfivenm_asmiblock
--

COMPONENT fiftyfivenm_asmiblock
    generic    (
        lpm_type    :    string :=  "fiftyfivenm_asmiblock";
		enable_sim  :	 string	:=  "false"
    );
    port    (
        dclkin    	:    in    std_logic;
        scein 		:    in    std_logic;
        oe    		:    in    std_logic;
		sdoin	    :    in    std_logic;
        data0out    :    out    std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_chipidblock
--

COMPONENT fiftyfivenm_chipidblock
    generic    (
        lpm_type     :   string    := "fiftyfivenm_chipidblock";
        id_value     :	 string    := "00000000ffffffff"
    );
    port    (
        clk         :    in    std_logic;
        shiftnld    :    in    std_logic;
        regout      :    out    std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_oscillator
--

COMPONENT fiftyfivenm_oscillator
    generic    (
        lpm_type        :   string    := "fiftyfivenm_oscillator";
        device_id       :   string    := "08";
        clock_frequency :   string    := "dummy"
    );
    port    (
        oscena       :    in    std_logic;
        clkout       :    out    std_logic;
        clkout1      :    out    std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_controller
--

COMPONENT fiftyfivenm_controller
    port    (
        nconfigcore       :    in    std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_crcblock
--

COMPONENT fiftyfivenm_crcblock
    generic    (
        lpm_type           :   string    := "fiftyfivenm_crcblock";
        oscillator_divider :   integer   := 1
    );
    port    (
        clk            :    in    std_logic;
        shiftnld       :    in    std_logic;
        ldsrc          :    in    std_logic;
        crcerror       :    out    std_logic;
        cyclecomplete  :    out    std_logic;
        regout         :    out    std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_rublock
--

COMPONENT fiftyfivenm_rublock
    generic    (
        sim_init_watchdog_value         :    integer    :=    0;
        sim_init_status                 :    integer    :=    0;
        sim_init_config_is_application  :    string    :=    "false";
        sim_init_watchdog_enabled       :    string    :=    "false";
        lpm_type                        :    string    :=    "fiftyfivenm_rublock"
    );
    port    (
        clk         :    in    std_logic;
        shiftnld    :    in    std_logic;
        captnupdt   :    in    std_logic;
        regin       :    in    std_logic;
        rsttimer    :    in    std_logic;
        rconfig     :    in    std_logic;
        regout      :    out    std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_jtag
--

COMPONENT fiftyfivenm_jtag
    generic    (
        lpm_type    :    string    :=    "fiftyfivenm_jtag"
    );
    port    (
        tms    		:    in    std_logic;
        tck    		:    in    std_logic;
        tdi    		:    in    std_logic;
        tdoutap    	:    in    std_logic;
        tdouser    	:    in    std_logic;
        tmscore     :    in    std_logic;
        tckcore     :    in    std_logic;
        tdicore     :    in    std_logic;
        corectl     :    in    std_logic;
        ntdopinena  :    in    std_logic;
        tdo    		:    out    std_logic;
        tmsutap    	:    out    std_logic;
        tckutap    	:    out    std_logic;
        tdiutap    	:    out    std_logic;
        shiftuser   :    out    std_logic;
        clkdruser   :    out    std_logic;
        updateuser  :    out    std_logic;
        runidleuser :    out    std_logic;
        usr1user    :    out    std_logic;
        tdocore     :    out    std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_adcblock
--

COMPONENT fiftyfivenm_adcblock
    generic    (
        clkdiv                                   : integer:=  1;
        tsclkdiv                                 : integer:=  0;
        tsclksel                                 : integer:=  0;
        prescalar                                : integer:=  0;
        refsel                                   : integer:=  0;
        pwd                                      : integer:=  0;
        testbits                                 : integer:=  0;
        device_partname_fivechar_prefix          : string :=  "10M08";
        is_this_first_or_second_adc              : integer:=  1;
        analog_input_pin_mask                    : integer:=  0;
        reserve_block                            : string :=  "false";
        enable_usr_sim                           : integer:=  0;
        reference_voltage_sim                    : integer:=  65536;
        simfilename_ch0                          : string :=  "simfilename_ch0";
        simfilename_ch1                          : string :=  "simfilename_ch1";
        simfilename_ch2                          : string :=  "simfilename_ch2";
        simfilename_ch3                          : string :=  "simfilename_ch3";
        simfilename_ch4                          : string :=  "simfilename_ch4";
        simfilename_ch5                          : string :=  "simfilename_ch5";
        simfilename_ch6                          : string :=  "simfilename_ch6";
        simfilename_ch7                          : string :=  "simfilename_ch7";
        simfilename_ch8                          : string :=  "simfilename_ch8";
        simfilename_ch9                          : string :=  "simfilename_ch9";
        simfilename_ch10                         : string :=  "simfilename_ch10";
        simfilename_ch11                         : string :=  "simfilename_ch11";
        simfilename_ch12                         : string :=  "simfilename_ch12";
        simfilename_ch13                         : string :=  "simfilename_ch13";
        simfilename_ch14                         : string :=  "simfilename_ch14";
        simfilename_ch15                         : string :=  "simfilename_ch15";
        simfilename_ch16                         : string :=  "simfilename_ch16"
    );
    port    (
        clkin_from_pll_c0                        : in  std_logic := '0';
        usr_pwd                                  : in  std_logic := '1';
        tsen                                     : in  std_logic := '0';
        chsel                                    : in  std_logic_vector(4 downto 0) := (OTHERS => '0');
        soc                                      : in  std_logic := '0';
        eoc                                      : out std_logic;
        dout                                     : out std_logic_vector(11 downto 0);
        clk_dft                                  : out std_logic
    );
END COMPONENT;

--
-- fiftyfivenm_phase_detector
--

COMPONENT fiftyfivenm_phase_detector
    port    (
        reset    	 : in  std_logic	:= '0';
        phasedone	 : in  std_logic	:= '0';
		clk          : in  std_logic_vector(2 downto 0) := (OTHERS => '0');
		up			 : out std_logic;
        down    	 : out std_logic;
        dftout	 	 : out std_logic_vector(11 downto 0)
    );
END COMPONENT;

end fiftyfivenm_components;
