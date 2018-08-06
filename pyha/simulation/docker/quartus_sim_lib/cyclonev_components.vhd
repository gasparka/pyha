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
use work.cyclonev_atom_pack.all;

package cyclonev_components is


--
-- cyclonev_ff
--

COMPONENT cyclonev_ff
    generic (
             power_up : string := "low";
             x_on_violation : string := "on";
             lpm_type : string := "cyclonev_ff";
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
-- cyclonev_pseudo_diff_out
--

COMPONENT cyclonev_pseudo_diff_out
 GENERIC (
             tipd_i                           : VitalDelayType01 := DefPropDelay01;
             tpd_i_o                          : VitalDelayType01 := DefPropDelay01;
             tpd_i_obar                       : VitalDelayType01 := DefPropDelay01;
             tipd_oein                        : VitalDelayType01 := DefPropDelay01;
             tpd_oein_oeout                   : VitalDelayType01 := DefPropDelay01;
             tpd_oein_oebout                  : VitalDelayType01 := DefPropDelay01;
             tipd_dtcin                       : VitalDelayType01 := DefPropDelay01;
             tpd_dtcin_dtc                    : VitalDelayType01 := DefPropDelay01;
             tpd_dtcin_dtcbar                 : VitalDelayType01 := DefPropDelay01;             
             XOn                           : Boolean := DefGlitchXOn;
             MsgOn                         : Boolean := DefGlitchMsgOn;
             lpm_type                         :  string := "stratuxv_pseudo_diff_out"
            );
 PORT (
           i                       : IN std_logic := '0';
           o                       : OUT std_logic;
           obar                    : OUT std_logic;
           dtcin                   : in std_logic := '0';
           oein                    : in std_logic := '0';
           dtc                     : OUT std_logic;
           dtcbar                  : OUT std_logic;
           oeout                   : OUT std_logic;
           oebout                  : OUT std_logic                      
           );
END COMPONENT;

--
-- cyclonev_lcell_comb
--

COMPONENT cyclonev_lcell_comb
    generic (
             lut_mask : std_logic_vector(63 downto 0) := (OTHERS => '1');
             shared_arith : string := "off";
             extended_lut : string := "off";
             dont_touch : string := "off";
             lpm_type : string := "cyclonev_lcell_comb";
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
             tpd_datae_combout : VitalDelayType01 := DefPropDelay01;
             tpd_dataf_combout : VitalDelayType01 := DefPropDelay01;
             tpd_datag_combout : VitalDelayType01 := DefPropDelay01;
             tpd_dataa_sumout : VitalDelayType01 := DefPropDelay01;
             tpd_datab_sumout : VitalDelayType01 := DefPropDelay01;
             tpd_datac_sumout : VitalDelayType01 := DefPropDelay01;
             tpd_datad_sumout : VitalDelayType01 := DefPropDelay01;
             tpd_dataf_sumout : VitalDelayType01 := DefPropDelay01;
             tpd_cin_sumout : VitalDelayType01 := DefPropDelay01;
             tpd_sharein_sumout : VitalDelayType01 := DefPropDelay01;
             tpd_dataa_cout : VitalDelayType01 := DefPropDelay01;
             tpd_datab_cout : VitalDelayType01 := DefPropDelay01;
             tpd_datac_cout : VitalDelayType01 := DefPropDelay01;
             tpd_datad_cout : VitalDelayType01 := DefPropDelay01;
             tpd_dataf_cout : VitalDelayType01 := DefPropDelay01;
             tpd_cin_cout : VitalDelayType01 := DefPropDelay01;
             tpd_sharein_cout : VitalDelayType01 := DefPropDelay01;
             tpd_dataa_shareout : VitalDelayType01 := DefPropDelay01;
             tpd_datab_shareout : VitalDelayType01 := DefPropDelay01;
             tpd_datac_shareout : VitalDelayType01 := DefPropDelay01;
             tpd_datad_shareout : VitalDelayType01 := DefPropDelay01;
             tipd_dataa : VitalDelayType01 := DefPropDelay01; 
             tipd_datab : VitalDelayType01 := DefPropDelay01; 
             tipd_datac : VitalDelayType01 := DefPropDelay01; 
             tipd_datad : VitalDelayType01 := DefPropDelay01; 
             tipd_datae : VitalDelayType01 := DefPropDelay01; 
             tipd_dataf : VitalDelayType01 := DefPropDelay01; 
             tipd_datag : VitalDelayType01 := DefPropDelay01; 
             tipd_cin : VitalDelayType01 := DefPropDelay01; 
             tipd_sharein : VitalDelayType01 := DefPropDelay01
            );
    port (
          dataa : in std_logic := '0';
          datab : in std_logic := '0';
          datac : in std_logic := '0';
          datad : in std_logic := '0';
          datae : in std_logic := '0';
          dataf : in std_logic := '0';
          datag : in std_logic := '0';
          cin : in std_logic := '0';
          sharein : in std_logic := '0';
          combout : out std_logic;
          sumout : out std_logic;
          cout : out std_logic;
          shareout : out std_logic
         );
END COMPONENT;

--
-- cyclonev_routing_wire
--

COMPONENT cyclonev_routing_wire
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
-- cyclonev_ram_block
--

COMPONENT cyclonev_ram_block
    GENERIC (
        operation_mode                 :  STRING := "single_port";    
        mixed_port_feed_through_mode   :  STRING := "dont_care";    
        ram_block_type                 :  STRING := "auto";    
        logical_ram_name               :  STRING := "ram_name";    
        init_file                      :  STRING := "init_file.hex";    
        init_file_layout               :  STRING := "none";    
        ecc_pipeline_stage_enabled     :  STRING := "false";
        enable_ecc                     :  STRING := "false";
	width_eccstatus		       :  INTEGER := 2;   
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
        lpm_type                  : string := "cyclonev_ram_block";
        lpm_hint                  : string := "true";
        clk0_input_clock_enable  : STRING := "none"; -- ena0,ena2,none
        clk0_core_clock_enable   : STRING := "none"; -- ena0,ena2,none
        clk0_output_clock_enable : STRING := "none"; -- ena0,none
        clk1_input_clock_enable  : STRING := "none"; -- ena1,ena3,none
        clk1_core_clock_enable   : STRING := "none"; -- ena1,ena3,none
        clk1_output_clock_enable : STRING := "none"; -- ena1,none
        mem_init0 : STRING := "";
        mem_init1 : STRING := "";
        mem_init2 : STRING := "";
        mem_init3 : STRING := "";
        mem_init4 : STRING := "";
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
        portaaddrstall : IN STD_LOGIC := '0';
        portbaddrstall : IN STD_LOGIC := '0';
        eccstatus : OUT STD_LOGIC_VECTOR(width_eccstatus - 1 DOWNTO 0) := (OTHERS => '0');
        dftout : OUT STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
        portadataout            : OUT STD_LOGIC_VECTOR(port_a_data_width - 1 DOWNTO 0);   
        portbdataout            : OUT STD_LOGIC_VECTOR(port_b_data_width - 1 DOWNTO 0)
        );
END COMPONENT;

--
-- cyclonev_mlab_cell
--

COMPONENT cyclonev_mlab_cell
   GENERIC (
      logical_ram_name                  : STRING := "lutram";
      logical_ram_depth                 : INTEGER := 0;
      logical_ram_width                 : INTEGER := 0;
      first_address                 : INTEGER := 0;
      last_address                  : INTEGER := 0;
      first_bit_number              : INTEGER := 0;
      init_file                  : STRING := "NONE";
      data_width                    : INTEGER := 20;
      address_width                 : INTEGER := 5;
      byte_enable_mask_width           : INTEGER := 1;
      byte_size                     : INTEGER := 1;
      port_b_data_out_clock         : STRING := "none";
      port_b_data_out_clear         : STRING := "none";
      lpm_type                      : STRING := "cyclonev_mlab_cell";
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
      clr                          : IN STD_LOGIC := '0';
      devclrn                       : IN STD_LOGIC := '1';
      devpor                        : IN STD_LOGIC := '1';
      portbdataout                  : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
   );
END COMPONENT;

--
-- cyclonev_io_ibuf
--

COMPONENT cyclonev_io_ibuf
    GENERIC (
             tipd_i                  : VitalDelayType01 := DefPropDelay01;
             tipd_ibar               : VitalDelayType01 := DefPropDelay01;
             tipd_dynamicterminationcontrol   : VitalDelayType01 := DefPropDelay01;  
             tpd_i_o                 : VitalDelayType01 := DefPropDelay01;
             tpd_ibar_o              : VitalDelayType01 := DefPropDelay01;
             XOn                           : Boolean := DefGlitchXOn;
             MsgOn                         : Boolean := DefGlitchMsgOn;
             differential_mode       :  string := "false";
             bus_hold                :  string := "false";
             simulate_z_as          : string    := "Z";
             lpm_type                :  string := "cyclonev_io_ibuf"
            );    
    PORT (
          i                       : IN std_logic := '0';   
          ibar                    : IN std_logic := '0';   
          dynamicterminationcontrol   : IN std_logic := '0';                                 
          o                       : OUT std_logic
         );       
END COMPONENT;

--
-- cyclonev_io_obuf
--

COMPONENT cyclonev_io_obuf
    GENERIC (
             tipd_i                           : VitalDelayType01 := DefPropDelay01;
             tipd_oe                          : VitalDelayType01 := DefPropDelay01;
             tipd_dynamicterminationcontrol   : VitalDelayType01 := DefPropDelay01;  
             tipd_seriesterminationcontrol    : VitalDelayArrayType01(15 DOWNTO 0) := (others => DefPropDelay01 );
             tipd_parallelterminationcontrol  : VitalDelayArrayType01(15 DOWNTO 0) := (others => DefPropDelay01 );
             tpd_i_o                          : VitalDelayType01 := DefPropDelay01;
             tpd_oe_o                         : VitalDelayType01 := DefPropDelay01;
             tpd_i_obar                       : VitalDelayType01 := DefPropDelay01;
             tpd_oe_obar                      : VitalDelayType01 := DefPropDelay01;
             XOn                           : Boolean := DefGlitchXOn;
             MsgOn                         : Boolean := DefGlitchMsgOn;  
             open_drain_output                :  string := "false";              
             shift_series_termination_control :  string := "false";  
             sim_dynamic_termination_control_is_connected :  string := "false";                
             bus_hold                         :  string := "false";              
             lpm_type                         :  string := "cyclonev_io_obuf"
            );               
    PORT (
           i                       : IN std_logic := '0';                                                 
           oe                      : IN std_logic := '1';                                                 
           dynamicterminationcontrol   : IN std_logic := '0'; 
           seriesterminationcontrol    : IN std_logic_vector(15 DOWNTO 0) := (others => '0'); 
           parallelterminationcontrol  : IN std_logic_vector(15 DOWNTO 0) := (others => '0'); 
           devoe                       : IN std_logic := '1';
           o                       : OUT std_logic;                                                       
           obar                    : OUT std_logic
         );                                                      
END COMPONENT;

--
-- cyclonev_ddio_in
--

COMPONENT cyclonev_ddio_in
    generic(                                                                                                  
            tipd_datain                        : VitalDelayType01 := DefPropDelay01;                          
            tipd_clk                           : VitalDelayType01 := DefPropDelay01;                          
            tipd_clkn                          : VitalDelayType01 := DefPropDelay01;                          
            tipd_ena                           : VitalDelayType01 := DefPropDelay01;                          
            tipd_areset                        : VitalDelayType01 := DefPropDelay01;                          
            tipd_sreset                        : VitalDelayType01 := DefPropDelay01;                          
            XOn                                : Boolean := DefGlitchXOn;                                     
            MsgOn                              : Boolean := DefGlitchMsgOn;                                   
            power_up                           :  string := "low";                                            
            async_mode                         :  string := "none";                                           
            sync_mode                          :  string := "none";                                           
            use_clkn                           :  string := "false";                                          
            lpm_type                           :  string := "cyclonev_ddio_in"                                   
           );                                                                                                 
    PORT (                                                                                                    
           datain                  : IN std_logic := '0';                                                     
           clk                     : IN std_logic := '0';                                                     
           clkn                    : IN std_logic := '0';                                                     
           ena                     : IN std_logic := '1';                                                     
           areset                  : IN std_logic := '0';                                                     
           sreset                  : IN std_logic := '0';                                                     
           regoutlo                : OUT std_logic;                                                           
           regouthi                : OUT std_logic;                                                           
           dfflo                   : OUT std_logic;                                                           
           devclrn                 : IN std_logic := '1';                                                     
           devpor                  : IN std_logic := '1'                                                      
        );                                                                                                    
END COMPONENT;

--
-- cyclonev_ddio_oe
--

COMPONENT cyclonev_ddio_oe
    generic(
            tipd_oe                            : VitalDelayType01 := DefPropDelay01;
			tipd_octreadcontrol                : VitalDelayType01 := DefPropDelay01;	
            tipd_clk                           : VitalDelayType01 := DefPropDelay01;
            tipd_ena                           : VitalDelayType01 := DefPropDelay01;
            tipd_areset                        : VitalDelayType01 := DefPropDelay01;
            tipd_sreset                        : VitalDelayType01 := DefPropDelay01;
            XOn                                : Boolean := DefGlitchXOn;           
            MsgOn                              : Boolean := DefGlitchMsgOn;         
            power_up              	       :  string := "low";    
            async_mode            	       :  string := "none";    
            sync_mode             	       :  string := "none";
	    disable_second_level_register      :  string := "false";	
            lpm_type              	       :  string := "cyclonev_ddio_oe"
           );    
    PORT (
          oe                      : IN std_logic := '1';
          octreadcontrol	  : IN std_logic := '1';		
          clk                     : IN std_logic := '0';   
          ena                     : IN std_logic := '1';   
          areset                  : IN std_logic := '0';   
          sreset                  : IN std_logic := '0';   
          dataout                 : OUT std_logic;         
          dfflo                   : OUT std_logic;         
          dffhi                   : OUT std_logic;         
          devclrn                 : IN std_logic := '1';               
          devpor                  : IN std_logic := '1'
         );             
END COMPONENT;

--
-- cyclonev_ddio_out
--

COMPONENT cyclonev_ddio_out
    generic(
            tipd_datainlo                      : VitalDelayType01 := DefPropDelay01;
            tipd_datainhi                      : VitalDelayType01 := DefPropDelay01;
            tipd_clk                           : VitalDelayType01 := DefPropDelay01;
            tipd_clkhi                         : VitalDelayType01 := DefPropDelay01;
            tipd_clklo                         : VitalDelayType01 := DefPropDelay01;
            tipd_muxsel                        : VitalDelayType01 := DefPropDelay01;
			tipd_hrbsel                        : VitalDelayType01 := DefPropDelay01;	
            tipd_ena                           : VitalDelayType01 := DefPropDelay01;
            tipd_areset                        : VitalDelayType01 := DefPropDelay01;
            tipd_sreset                        : VitalDelayType01 := DefPropDelay01;
            XOn                                : Boolean := DefGlitchXOn;           
            MsgOn                              : Boolean := DefGlitchMsgOn;         
            power_up                           :  string := "low";          
            async_mode                         :  string := "none";       
            sync_mode                          :  string := "none";
            half_rate_mode                     :  string := "false";       
            use_new_clocking_model             :  string := "false";
            lpm_type                           :  string := "cyclonev_ddio_out"
           );
    PORT (
          datainlo                : IN std_logic := '0';   
          datainhi                : IN std_logic := '0';   
          clk                     : IN std_logic := '0'; 
          clkhi                   : IN std_logic := '0'; 
          clklo                   : IN std_logic := '0'; 
          muxsel                  : IN std_logic := '0';   
          ena                     : IN std_logic := '1';   
          areset                  : IN std_logic := '0';   
          sreset                  : IN std_logic := '0';   
          dataout                 : OUT std_logic;         
          dfflo                   : OUT std_logic;         
          dffhi                   : OUT std_logic;      
	      hrbypass                 : IN std_logic := '0';   
          devclrn                 : IN std_logic := '1';   
          devpor                  : IN std_logic := '1'   
        );   
END COMPONENT;

--
-- cyclonev_io_pad
--

COMPONENT cyclonev_io_pad
    GENERIC (
        lpm_type                       :  string := "cyclonev_io_pad");    
    PORT (
        padin                   : IN std_logic := '0';   -- Input Pad
        padout                  : OUT std_logic);   -- Output Pad
END COMPONENT;

--
-- cyclonev_bias_block
--

COMPONENT cyclonev_bias_block
    GENERIC (
        lpm_type : string := "cyclonev_bias_block";
        tipd_clk : VitalDelayType01 := DefPropDelay01;
        tipd_shiftnld : VitalDelayType01 := DefPropDelay01;
        tipd_captnupdt : VitalDelayType01 := DefPropDelay01;
        tipd_din : VitalDelayType01 := DefPropDelay01;
        tsetup_din_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
        tsetup_shiftnld_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
        tsetup_captnupdt_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
        thold_din_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
        thold_shiftnld_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
        thold_captnupdt_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
        tpd_clk_dout_posedge : VitalDelayType01 := DefPropDelay01;
        MsgOn: Boolean := DefGlitchMsgOn;
        XOn: Boolean := DefGlitchXOn;
        MsgOnChecks: Boolean := DefMsgOnChecks;
        XOnChecks: Boolean := DefXOnChecks
        );
    PORT (
        clk : in std_logic := '0';
        shiftnld : in std_logic := '0';
        captnupdt : in std_logic := '0';
        din : in std_logic := '0';
        dout : out std_logic := '0'
        );
END COMPONENT;

--
-- cyclonev_clk_phase_select
--

COMPONENT cyclonev_clk_phase_select
    generic (
        phase_setting : integer := 0;
        invert_phase : string := "dynamic";
        use_phasectrlin : string := "true";
        physical_clock_source : string := "dqs_2x_clk";
        use_dqs_input : string := "false"
    );
    port (
        clkin : in std_logic_vector(3 downto 0) := (OTHERS => '0');
        dqsin : in std_logic := '0';
        phaseinvertctrl : in std_logic := '0';
        clkout : out std_logic;
        phasectrlin : in std_logic_vector(1 downto 0) := (OTHERS => '0')
    );
END COMPONENT;

--
-- cyclonev_clkena
--

COMPONENT cyclonev_clkena
    generic    (
        clock_type    :    string    :=    "auto";
        ena_register_mode    :    string    :=    "always enabled";
        lpm_type    :    string    :=    "cyclonev_clkena";
        ena_register_power_up    :    string    :=    "high";
        disable_mode    :    string    :=    "low";
        test_syn    :    string    :=    "high"
    );
    port    (
        inclk    :    in    std_logic    :=    '1';
        ena    :    in    std_logic    :=    '1';
        enaout    :    out    std_logic;
        outclk    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_clkselect
--

COMPONENT cyclonev_clkselect
    generic    (
        lpm_type    :    string    :=    "cyclonev_clkselect";
        test_cff    :    string    :=    "low"
    );
    port    (
        inclk    :    in    std_logic_vector(3 downto 0)    :=    "0000";
        clkselect    :    in    std_logic_vector(1 downto 0)    :=    "00";
        outclk    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_delay_chain
--

COMPONENT cyclonev_delay_chain
    generic    (
        sim_intrinsic_rising_delay    :    integer    :=    200;
        sim_intrinsic_falling_delay    :    integer    :=    200;
        sim_rising_delay_increment    :    integer    :=    10;
        sim_falling_delay_increment    :    integer    :=    10;
        lpm_type    :    string    :=    "cyclonev_delay_chain"
    );
    port    (
        datain    :    in    std_logic	:= '0';
        delayctrlin    :    in    std_logic_vector(4 downto 0)	:= (OTHERS => '0');
        dataout    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_dll
--

COMPONENT cyclonev_dll
    generic    (
        input_frequency    :    string    :=    "0 MHz";
        delayctrlout_mode    :    string    :=    "normal";
        jitter_reduction    :    string    :=    "false";
        use_upndnin    :    string    :=    "false";
        use_upndninclkena    :    string    :=    "false";
        dual_phase_comparators    :    string    :=    "true";
        sim_valid_lock    :    integer    :=    16;
        sim_valid_lockcount    :    integer    :=    0;
        sim_buffer_intrinsic_delay    :    integer    :=    175;
        sim_buffer_delay_increment    :    integer    :=    10;
        static_delay_ctrl    :    integer    :=    0;
        lpm_type    :    string    :=    "cyclonev_dll";
        lpm_hint    :    string    :=    "unused";
        delay_chain_length    :    integer    :=    8
    );
    port    (
        aload    :    in    std_logic	:= '0';
        clk    :    in    std_logic	:= '0';
        upndnin    :    in    std_logic	:= '0';
        upndninclkena    :    in    std_logic	:= '0';
        delayctrlout    :    out    std_logic_vector(6 downto 0);
        dqsupdate    :    out    std_logic;
        offsetdelayctrlout    :    out    std_logic_vector(6 downto 0);
        offsetdelayctrlclkout    :    out    std_logic;
        upndnout    :    out    std_logic;
        dffin    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_dqs_config
--

COMPONENT cyclonev_dqs_config
    generic (
        lpm_type : string := "cyclonev_dqs_config"
    );
    port (
        datain : in std_logic := '0';
        dqsenablegatingdelaysetting : out std_logic_vector(4 downto 0);
        dqshalfratebypass : out std_logic;
        enadqsenablephasetransferreg : out std_logic;
        postamblephaseinvert : out std_logic;
        dqsenableungatingdelaysetting : out std_logic_vector(4 downto 0);
        octdelaysetting : out std_logic_vector(4 downto 0);
        clk : in std_logic := '0';
        dqsbusoutdelaysetting : out std_logic_vector(4 downto 0);
        postamblephasesetting : out std_logic_vector(1 downto 0);
        ena : in std_logic := '0';
        dataout : out std_logic;
        update : in std_logic := '0'
    );
END COMPONENT;

--
-- cyclonev_dqs_delay_chain
--

COMPONENT cyclonev_dqs_delay_chain
    generic    (
        dqs_input_frequency    :    string    :=    "unused";
        dqs_phase_shift    :    integer    :=    0;
        use_phasectrlin    :    string    :=    "false";
        phase_setting    :    integer    :=    0;
        dqs_offsetctrl_enable    :    string    :=    "false";
        dqs_ctrl_latches_enable    :    string    :=    "false";
        use_alternate_input_for_first_stage_delayctrl    :    string    :=    "false";
        use_alternate_input_for_multi_stage_delayctrl    :    string    :=    "false";
        sim_buffer_intrinsic_delay    :    integer    :=    175;
        sim_buffer_delay_increment    :    integer    :=    10;
        test_enable    :    string    :=    "false"
    );
    port    (
        dqsin    :    in    std_logic	:= '0';
        dqsenable    :    in    std_logic	:= '1';
        delayctrlin    :    in    std_logic_vector(6 downto 0)	:= (OTHERS => '0');
        offsetctrlin    :    in    std_logic_vector(6 downto 0)	:= (OTHERS => '0');
        dqsupdateen    :    in    std_logic	:= '1';
        phasectrlin    :    in    std_logic_vector(2 downto 0)	:= (OTHERS => '0');
        testin    :    in    std_logic	:= '0';
        dffin    :    out    std_logic;
        dqsbusout    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_dqs_enable_ctrl
--

COMPONENT cyclonev_dqs_enable_ctrl
    generic    (
        delay_dqs_enable_by_half_cycle    :    string    :=    "false";
        add_phase_transfer_reg    :    string    :=    "false"
    );
    port    (
        dqsenablein    :    in    std_logic	:= '1';
        zerophaseclk    :    in    std_logic	:= '1';
        enaphasetransferreg    :    in    std_logic	:= '0';
        levelingclk    :    in    std_logic	:= '1';
        dffin    :    out    std_logic;
        dffphasetransfer    :    out    std_logic;
        dffextenddqsenable    :    out    std_logic;
        dqsenableout    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_fractional_pll
--

COMPONENT cyclonev_fractional_pll
    generic    (
        output_clock_frequency    :    string    :=    "";
        reference_clock_frequency    :    string    :=    "";
        mimic_fbclk_type    :    string    :=    "cdb_pll_mimic_fbclk_gclk";
        dsm_accumulator_reset_value    :    integer    :=    0;
        forcelock    :    string    :=    "false";
        nreset_invert    :    string    :=    "false";
        pll_atb    :    integer    :=    0;
        pll_bwctrl    :    integer    :=    10000;
        pll_cmp_buf_dly    :    string    :=    "0 ps";
        pll_cp_comp    :    string    :=    "true";
        pll_cp_current    :    integer    :=    20;
        pll_ctrl_override_setting    :    string    :=    "false";
		pll_dsm_dither    :    string    :=    "disable";
		pll_dsm_out_sel    :    string    :=    "disable";
		pll_dsm_reset    :    string    :=    "false";
		pll_ecn_bypass    :    string    :=    "false";
		pll_ecn_test_en    :    string    :=    "false";
        pll_enable    :    string    :=    "true";
        pll_fbclk_mux_1    :    string    :=    "glb";
        pll_fbclk_mux_2    :    string    :=    "fb_1";
		pll_fractional_carry_out    :    integer    :=    24;
		pll_fractional_division    :    integer    :=    1;
		pll_fractional_division_string   :    string    :=    "1";
		pll_fractional_value_ready    :    string    :=    "true"; 
		pll_lf_testen    :    string    :=    "false";
        pll_lock_fltr_cfg    :    integer    :=    0;
        pll_lock_fltr_test    :    string    :=    "false";
        pll_m_cnt_bypass_en    :    string    :=    "false";
        pll_m_cnt_coarse_dly    :    string    :=    "0 ps";
        pll_m_cnt_fine_dly    :    string    :=    "0 ps";
		pll_m_cnt_hi_div    :    integer    :=    1;
        pll_m_cnt_in_src    :    string    :=    "ph_mux_clk";
		pll_m_cnt_lo_div    :    integer    :=    1;
        pll_m_cnt_odd_div_duty_en    :    string    :=    "false";
        pll_m_cnt_ph_mux_prst    :    integer    :=    0;
		pll_m_cnt_prst    :    integer    :=    1;
        pll_n_cnt_bypass_en    :    string    :=    "false";
        pll_n_cnt_coarse_dly    :    string    :=    "0 ps";
        pll_n_cnt_fine_dly    :    string    :=    "0 ps";
        pll_n_cnt_hi_div    :    integer    :=    1;
        pll_n_cnt_lo_div    :    integer    :=    1;
        pll_n_cnt_odd_div_duty_en    :    string    :=    "false";
		pll_ref_buf_dly    :    string    :=    "0 ps";
		pll_reg_boost    :    integer    :=    0;
		pll_regulator_bypass    :    string    :=    "false";
		pll_ripplecap_ctrl    :    integer    :=    0;
		pll_slf_rst    :    string    :=    "false";
        pll_tclk_mux_en    :    string    :=    "false";
		pll_tclk_sel    :    string    :=    "cdb_pll_tclk_sel_m_src";
		pll_test_enable    :    string    :=    "false";
		pll_testdn_enable    :    string    :=    "false";
		pll_testup_enable    :    string    :=    "false";
        pll_unlock_fltr_cfg    :    integer    :=    0;
		pll_vco_div    :    integer    :=    2;
        pll_vco_ph0_en    :    string    :=    "false";
        pll_vco_ph1_en    :    string    :=    "false";
        pll_vco_ph2_en    :    string    :=    "false";
        pll_vco_ph3_en    :    string    :=    "false";
        pll_vco_ph4_en    :    string    :=    "false";
        pll_vco_ph5_en    :    string    :=    "false";
        pll_vco_ph6_en    :    string    :=    "false";
        pll_vco_ph7_en    :    string    :=    "false";
		pll_vctrl_test_voltage    :    integer    :=    750;
		vccd0g_atb    :    string    :=    "disable";
		vccd0g_output    :    integer    :=    0;
		vccd1g_atb    :    string    :=    "disable";
		vccd1g_output    :    integer    :=    0;
		vccm1g_tap    :    integer    :=    2;
		vccr_pd    :    string    :=    "false";
		vcodiv_override    :    string    :=    "false";
		fractional_pll_index  :    integer    :=    1
    );
    port    (
        coreclkfb    :    in    std_logic;
        ecnc1test    :    in    std_logic := '0';
        ecnc2test    :    in    std_logic := '0';
        fbclkfpll    :    in    std_logic := '0'; 
        lvdsfbin    :    in    std_logic := '0';
        nresync    :    in    std_logic;
        pfden    :    in    std_logic := '0';
        refclkin    :    in    std_logic;
        shift    :    in    std_logic;
        shiftdonein    :    in    std_logic;
        shiften    :    in    std_logic;
        up    :    in    std_logic;
        vsspl    :    in    std_logic := '0';
        zdb    :    in    std_logic := '0';
        cntnen    :    out    std_logic;
        fbclk    :    out    std_logic;
        fblvdsout    :    out    std_logic;
        lock    :    out    std_logic;
        mhi    :    out    std_logic_vector(7 downto 0);
        mcntout    :    out    std_logic;
        plniotribuf    :    out    std_logic;
        shiftdoneout    :    out    std_logic;
        tclk    :    out    std_logic;
        vcoph    :    out    std_logic_vector(7 downto 0)
    );
END COMPONENT;

--
-- cyclonev_io_config
--

COMPONENT cyclonev_io_config
    generic (
        lpm_type : string := "cyclonev_io_config"
    );
    port (
        outputenabledelaysetting : out std_logic_vector(4 downto 0);
        outputhalfratebypass : out std_logic;
        datain : in std_logic := '0';
        readfifomode : out std_logic_vector(2 downto 0);
        readfiforeadclockselect : out std_logic_vector(1 downto 0);
        padtoinputregisterdelaysetting : out std_logic_vector(4 downto 0);
        clk : in std_logic := '0';
        ena : in std_logic := '0';
        outputregdelaysetting : out std_logic_vector(4 downto 0);
        dataout : out std_logic;
        update : in std_logic := '0'
    );
END COMPONENT;

--
-- cyclonev_leveling_delay_chain
--

COMPONENT cyclonev_leveling_delay_chain
    generic    (
        physical_clock_source    :    string    :=    "dqs";
        sim_buffer_intrinsic_delay    :    integer    :=    175;
        sim_buffer_delay_increment    :    integer    :=    10
    );
    port    (
        clkin    :    in    std_logic	:= '0';
        delayctrlin    :    in    std_logic_vector(6 downto 0)	:= (OTHERS => '0');
        clkout    :    out    std_logic_vector(3 downto 0)
    );
END COMPONENT;

--
-- cyclonev_mem_phy
--

COMPONENT cyclonev_mem_phy
    generic (
        hphy_use_hphy : string := "true";
        hphy_reset_delay_en : string := "false";
        hphy_hhp_hps : string := "false";
        hphy_wrap_back_en : string := "false";
        hphy_datapath_delay : string := "zero_cycles";
        hphy_datapath_ac_delay : string := "zero_cycles";
        m_hphy_ac_rom_init_file : string := "ac_ROM.hex";
        hphy_ac_ddr_disable : string := "true";
        hphy_csr_pipelineglobalenable : string := "true";
        m_hphy_inst_rom_init_file : string := "inst_ROM.hex";
        hphy_atpg_en : string := "false"
    );
    port (
        iointaddrdout : in std_logic_vector(63 downto 0) := (OTHERS => '0');
        iointresetndout : in std_logic_vector(3 downto 0) := (OTHERS => '0');
        iointckedout : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        afirlat : out std_logic_vector(4 downto 0);
        iointdqoe : in std_logic_vector(89 downto 0) := (OTHERS => '0');
        afiaddr : in std_logic_vector(19 downto 0) := (OTHERS => '0');
        cfgtwr : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        afidm : in std_logic_vector(9 downto 0) := (OTHERS => '0');
        afiwdatavalid : in std_logic_vector(4 downto 0) := (OTHERS => '0');
        avlread : in std_logic := '0';
        phyddiockndout : out std_logic_vector(3 downto 0);
        iointckndout : in std_logic_vector(3 downto 0) := (OTHERS => '0');
        iointbadout : in std_logic_vector(11 downto 0) := (OTHERS => '0');
        cfgdevicewidth : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        cfgcoladdrwidth : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        iointdqdin : out std_logic_vector(179 downto 0);
        scanen : in std_logic := '0';
        afiwlat : out std_logic_vector(3 downto 0);
        phyddiodqsoe : out std_logic_vector(9 downto 0);
        cfgaddlat : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        afirdataen : in std_logic_vector(4 downto 0) := (OTHERS => '0');
        phyddiodqslogicincrdataen : out std_logic_vector(9 downto 0);
        phyddiodqslogicoct : out std_logic_vector(9 downto 0);
        iointdqsoe : in std_logic_vector(9 downto 0) := (OTHERS => '0');
        phyddiodqslogicaclrpstamble : out std_logic_vector(4 downto 0);
        phyddiodqsboe : out std_logic_vector(9 downto 0);
        phyddiodqdout : out std_logic_vector(179 downto 0);
        iointaficalfail : out std_logic;
        avlwritedata : in std_logic_vector(31 downto 0) := (OTHERS => '0');
        iointdqsboe : in std_logic_vector(9 downto 0) := (OTHERS => '0');
        phyddiodqslogicreadlatency : out std_logic_vector(24 downto 0);
        iointwendout : in std_logic_vector(3 downto 0) := (OTHERS => '0');
        afiodt : in std_logic_vector(1 downto 0) := (OTHERS => '0');
        iointcsndout : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        phyddiorasndout : out std_logic_vector(3 downto 0);
        phyddiocsndout : out std_logic_vector(7 downto 0);
        iointdqslogicoct : in std_logic_vector(9 downto 0) := (OTHERS => '0');
        softresetn : in std_logic := '0';
        phyddiodqsdout : out std_logic_vector(19 downto 0);
        iointafiwlat : out std_logic_vector(3 downto 0);
        iointdqslogicdqsena : in std_logic_vector(9 downto 0) := (OTHERS => '0');
        afiba : in std_logic_vector(2 downto 0) := (OTHERS => '0');
        phyddiodqslogicdqsena : out std_logic_vector(9 downto 0);
        pllavlclk : in std_logic := '0';
        aficasn : in std_logic := '0';
        cfgbankaddrwidth : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        phyddiowendout : out std_logic_vector(3 downto 0);
        phyddiockedout : out std_logic_vector(7 downto 0);
        cfgdramconfig : in std_logic_vector(23 downto 0) := (OTHERS => '0');
        aficsn : in std_logic_vector(1 downto 0) := (OTHERS => '0');
        avlwaitrequest : out std_logic;
        phyddioodtdout : out std_logic_vector(7 downto 0);
        ddiophydqslogicrdatavalid : in std_logic_vector(4 downto 0) := (OTHERS => '0');
        avlwrite : in std_logic := '0';
        afirasn : in std_logic := '0';
        plladdrcmdclk : in std_logic := '0';
        phyddioaddrdout : out std_logic_vector(63 downto 0);
        aficalfail : out std_logic;
        afimemclkdisable : in std_logic := '0';
        afiwdata : in std_logic_vector(79 downto 0) := (OTHERS => '0');
        iointdqslogicreadlatency : in std_logic_vector(24 downto 0) := (OTHERS => '0');
        phyddiodmdout : out std_logic_vector(19 downto 0);
        pllaficlk : in std_logic := '0';
        cfgtrfc : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        iointckdout : in std_logic_vector(3 downto 0) := (OTHERS => '0');
        aficke : in std_logic_vector(1 downto 0) := (OTHERS => '0');
        iointrasndout : in std_logic_vector(3 downto 0) := (OTHERS => '0');
        phyddioresetndout : out std_logic_vector(3 downto 0);
        aficalsuccess : out std_logic;
        ddiophydqdin : in std_logic_vector(179 downto 0) := (OTHERS => '0');
        iointcasndout : in std_logic_vector(3 downto 0) := (OTHERS => '0');
        iointdqsdout : in std_logic_vector(19 downto 0) := (OTHERS => '0');
        cfgcsaddrwidth : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        phyddiockdout : out std_logic_vector(3 downto 0);
        avlreaddata : out std_logic_vector(31 downto 0);
        afirdata : out std_logic_vector(79 downto 0);
        phyresetn : out std_logic;
        iointdqslogicincrdataen : in std_logic_vector(9 downto 0) := (OTHERS => '0');
        afiwen : in std_logic := '0';
        globalresetn : in std_logic := '0';
        phyddiodqsbdout : out std_logic_vector(19 downto 0);
        plllocked : in std_logic := '0';
        phyddiodqslogicfiforeset : out std_logic_vector(4 downto 0);
        iointdqslogicfiforeset : in std_logic_vector(4 downto 0) := (OTHERS => '0');
        iointodtdout : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        iointafirlat : out std_logic_vector(4 downto 0);
        iointaficalsuccess : out std_logic;
        iointdqdout : in std_logic_vector(179 downto 0) := (OTHERS => '0');
        cfgrowaddrwidth : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        phyddiodqslogicaclrfifoctrl : out std_logic_vector(4 downto 0);
        phyddiobadout : out std_logic_vector(11 downto 0);
        afirdatavalid : out std_logic;
        cfgtrefi : in std_logic_vector(15 downto 0) := (OTHERS => '0');
        cfgcaswrlat : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        afirstn : in std_logic := '0';
        avlresetn : in std_logic := '0';
        iointdqsbdout : in std_logic_vector(19 downto 0) := (OTHERS => '0');
        phyddiodqoe : out std_logic_vector(89 downto 0);
        iointdqslogicrdatavalid : out std_logic_vector(4 downto 0);
        avladdress : in std_logic_vector(15 downto 0) := (OTHERS => '0');
        afidqsburst : in std_logic_vector(4 downto 0) := (OTHERS => '0');
        iointdqslogicincwrptr : in std_logic_vector(9 downto 0) := (OTHERS => '0');
        phyddiodqslogicincwrptr : out std_logic_vector(9 downto 0);
        cfgtcl : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        ctlresetn : out std_logic;
        cfginterfacewidth : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        phyddiocasndout : out std_logic_vector(3 downto 0);
        afirdataenfull : in std_logic_vector(4 downto 0) := (OTHERS => '0');
        cfgtmrd : in std_logic_vector(7 downto 0) := (OTHERS => '0');
        iointdmdout : in std_logic_vector(19 downto 0) := (OTHERS => '0')
    );
END COMPONENT;

--
-- cyclonev_phy_clkbuf
--

COMPONENT cyclonev_phy_clkbuf
    port (
        outclk : out std_logic_vector(3 downto 0);
        inclk : in std_logic_vector(3 downto 0) := (OTHERS => '0')
    );
END COMPONENT;

--
-- cyclonev_pll_dll_output
--

COMPONENT cyclonev_pll_dll_output
    generic    (
        pll_dll_src    :    string    :=    "vss"
    );
    port    (
        cclk    :    in    std_logic_vector(17 downto 0);
        clkin    :    in    std_logic_vector(3 downto 0) := "0000";
        clkout    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_pll_dpa_output
--

COMPONENT cyclonev_pll_dpa_output
    generic    (
        output_clock_frequency    :    string    :=    "";
        pll_vcoph_div    :    integer    :=    1
    );
    port    (
        pd    :    in    std_logic;
        phin    :    in    std_logic_vector(7 downto 0);
        phout    :    out    std_logic_vector(7 downto 0)
    );
END COMPONENT;

--
-- cyclonev_pll_extclk_output
--

COMPONENT cyclonev_pll_extclk_output
    generic    (
        pll_extclk_cnt_src    :    string    :=    "vss";
        pll_extclk_enable    :    string    :=    "true";
        pll_extclk_invert    :    string    :=    "false"
    );
    port    (
        cclk    :    in    std_logic_vector(17 downto 0);
        clken    :    in    std_logic := '0';
        mcnt0    :    in    std_logic := '0';
        mcnt1    :    in    std_logic := '0';
        extclk    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_pll_lvds_output
--

COMPONENT cyclonev_pll_lvds_output
    generic    (
        pll_loaden_coarse_dly    :    string    :=    "0 ps";
        pll_loaden_fine_dly    :    string    :=    "0 ps";
        pll_lvdsclk_coarse_dly    :    string    :=    "0 ps";
        pll_lvdsclk_fine_dly    :    string    :=    "0 ps";
        pll_loaden_enable_disable    :    string    :=    "false";
        pll_lvdsclk_enable_disable    :    string    :=    "false"
    );
    port    (
        ccout    :    in    std_logic_vector(1 downto 0);
        loaden    :    out    std_logic;
        lvdsclk    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_pll_output_counter
--

COMPONENT cyclonev_pll_output_counter
    generic    (
        duty_cycle    :    integer    :=    50;
        output_clock_frequency    :    string    :=    "";
        phase_shift    :    string    :=    "";
        c_cnt_coarse_dly    :    string    :=    "0 ps";
        c_cnt_fine_dly    :    string    :=    "0 ps";
        c_cnt_in_src    :    string    :=    "test_clk0";
        c_cnt_ph_mux_prst    :    integer    :=    0;
        cnt_fpll_src    :    string    :=    "fpll_0";
        c_cnt_prst    :    integer    :=    1;
        dprio0_cnt_bypass_en    :    string    :=    "false";
        dprio0_cnt_hi_div    :    integer    :=    1;       
        dprio0_cnt_lo_div    :    integer    :=    1;
        dprio0_cnt_odd_div_even_duty_en    :    string    :=    "false";
        fractional_pll_index    :    integer    :=    1;
        output_counter_index    :    integer    :=    1
    );
    port    (
        cascadein    :    in    std_logic := '0';
        nen0    :    in    std_logic := '0';
        shift0    :    in    std_logic := '0';
        shiftdone0i    :    in    std_logic := '0';
        shiften    :    in    std_logic := '0';
        tclk0    :    in    std_logic := '0';
        up0    :    in    std_logic := '0';
        vco0ph    :    in    std_logic_vector(7 downto 0) := (OTHERS => '0');
        cascadeout    :    out    std_logic;
        divclk    :    out    std_logic;
        shiftdone0o    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_pll_reconfig
--

COMPONENT cyclonev_pll_reconfig
    generic    (
        fractional_pll_index    :    integer    :=    1
    );
    port    (
        addr    :    in    std_logic_vector(5 downto 0) := (OTHERS => '0');
        atpgmode    :    in    std_logic := '0';
        byteen    :    in    std_logic_vector(1 downto 0) := (OTHERS => '0');
        clk    :    in    std_logic := '0';
		cntnen    :    in    std_logic := '0';
        cntsel    :    in    std_logic_vector(4 downto 0) := (OTHERS => '0');
        din    :    in    std_logic_vector(15 downto 0) := (OTHERS => '0');       
        fpllcsrtest    :    in    std_logic := '0';       
        iocsrclkin    :    in    std_logic := '0';   
        iocsrdatain    :    in    std_logic := '0';
        iocsren    :    in    std_logic := '0';       
        iocsrrstn    :    in    std_logic := '0';       
        mdiodis    :    in    std_logic := '0';
        mhi    :    in    std_logic_vector(7 downto 0) := (OTHERS => '0');      
        phaseen    :    in    std_logic := '0';
        read    :    in    std_logic := '0';
        rstn    :    in    std_logic := '0';
        scanen    :    in    std_logic := '0';
        sershiftload    :    in    std_logic := '0';
        shiftdonei    :    in    std_logic := '0';
        updn    :    in    std_logic := '0';
        write    :    in    std_logic := '0';
        blockselect    :    out    std_logic;
        dout    :    out    std_logic_vector(15 downto 0);
        dprioout    :    out    std_logic_vector(815 downto 0);
        iocsrdataout    :    out    std_logic;
        iocsrenbuf    :    out    std_logic;
        iocsrrstnbuf    :    out    std_logic;
        phasedone    :    out    std_logic;
        shift    :    out    std_logic;
        shiften    :    out    std_logic_vector(8 downto 0);
        shiftenm    :    out    std_logic;
        up    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_pll_refclk_select
--

COMPONENT cyclonev_pll_refclk_select
    generic    (
        pll_auto_clk_sw_en    :    string    :=    "false";
        pll_clk_loss_edge    :    string    :=    "both_edges";
        pll_clk_loss_sw_en    :    string    :=    "false";
        pll_clk_sw_dly    :    integer    :=    0;
        pll_clkin_0_src    :    string    :=    "ref_clk0";
        pll_clkin_1_src    :    string    :=    "ref_clk1";
        pll_manu_clk_sw_en    :    string    :=    "false";
        pll_sw_refclk_src    :    string    :=    "clk_0"
    );
    port    (
        adjpllin    :    in    std_logic := '0';
        cclk    :    in    std_logic := '0';
        clkin    :    in    std_logic_vector(3 downto 0) := (OTHERS => '0');
        coreclkin    :    in    std_logic := '0';
        extswitch    :    in    std_logic := '0';
        iqtxrxclkin    :    in    std_logic := '0';
        plliqclkin    :    in    std_logic := '0';
        refiqclk    :    in    std_logic_vector(1 downto 0) := (OTHERS => '0');
        rxiqclkin    :    in    std_logic := '0';
        pllen	   :	in 	std_logic := '0';
        clk0bad    :    out    std_logic;
        clk1bad    :    out    std_logic;
        clkout    :    out    std_logic;
        extswitchbuf    :    out    std_logic;
        pllclksel    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_termination_logic
--

COMPONENT cyclonev_termination_logic
    generic    (
        lpm_type    :    string    :=    "cyclonev_termination_logic";
		a_iob_oct_test : string := "a_iob_oct_test_off"
    );
    port    (
        s2pload : in std_logic := '0';
        serdata : in std_logic := '0';
        scanenable : in std_logic := '0';
        scanin : in std_logic := '0';
        scanclk : in std_logic := '0';
        scanout : out std_logic;
        seriesterminationcontrol : out std_logic_vector(15 downto 0);
        parallelterminationcontrol : out std_logic_vector(15 downto 0)
    );
END COMPONENT;

--
-- cyclonev_termination
--

COMPONENT cyclonev_termination
    generic    (
        lpm_type    :    string    :=    "cyclonev_termination";
        a_oct_nclrusr_inv : string :=  "a_oct_nclrusr_inv_off";
        a_oct_pwrdn : string :=  "true";
        a_oct_clkdiv : string :=  "a_oct_clkdiv_20";
        a_oct_intosc : string :=  "a_oct_intosc_2";
        a_oct_vref : string :=  "a_oct_vref_rupm_rdnm";
        a_oct_test_0 : string :=  "a_oct_test_0_off";
        a_oct_test_1 : string :=  "a_oct_test_1_off";
        a_oct_test_2 : string :=  "a_oct_test_2_off";
        a_oct_test_3 : string :=  "a_oct_test_3_off";
        a_oct_test_4 : string :=  "a_oct_test_4_off";
        a_oct_test_5 : string :=  "a_oct_test_5_off";
        a_oct_pllbiasen : string :=  "a_oct_pllbiasen_low";
        a_oct_usermode : string :=  "false"
    );
    port    (
        rzqin : in std_logic := '0';
        enserusr : in std_logic := '0';
        nclrusr : in std_logic := '0';
        clkenusr : in std_logic := '0';
        clkusr : in std_logic := '0';
        serdatafromcore : in std_logic := '0';
        scanclk : in std_logic := '0';
        otherenser : in std_logic_vector(8 downto 0) := (OTHERS => '0');
        serdataout : out std_logic;
        enserout : out std_logic;
        compoutrup : out std_logic;
        compoutrdn : out std_logic;
        serdatatocore : out std_logic;
        scanin  : out std_logic;
        scanout : out std_logic
    );
END COMPONENT;

--
-- cyclonev_asmiblock
--

COMPONENT cyclonev_asmiblock
    generic    (
        lpm_type    :    string    :=    "cyclonev_asmiblock";
		enable_sim	:    string    :=    "false"
    );
    port    (
        dclk    	:   in  std_logic;
        sce    		:   in  std_logic;
        oe    		:   in  std_logic;
        data0out    :   in  std_logic;
        data1out    :   in  std_logic;
        data2out    :   in  std_logic;
        data3out    :   in  std_logic;
        data0oe    	:   in  std_logic;
        data1oe    	:   in  std_logic;
        data2oe    	:   in  std_logic;
        data3oe   	:   in  std_logic;
        data0in    	:   out	std_logic;
        data1in    	:   out std_logic;
        data2in    	:   out std_logic;
        data3in    	:   out	std_logic;
		spidclk		: 	out std_logic;
		spidataout	: 	out std_logic_vector(3 downto 0);
		spisce 		: 	out std_logic;
		spidatain	: 	in  std_logic_vector(3 downto 0)
    );
END COMPONENT;

--
-- cyclonev_chipidblock
--

COMPONENT cyclonev_chipidblock
    generic    (
        lpm_type    :    string    :=    "cyclonev_chipidblock";
		ID_VALUE	:	 std_logic_vector(63 downto 0) := (others => '1')
    );
    port    (
        clk    :    in    std_logic;
        shiftnld    :    in    std_logic;
        regout    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_controller
--

COMPONENT cyclonev_controller
    generic    (
        lpm_type    :    string    :=    "cyclonev_controller"
    );
    port    (
        nceout    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_crcblock
--

COMPONENT cyclonev_crcblock
generic    (
        oscillator_divider  		:    integer    :=    256;
		error_delay    				:    integer    :=    0;
		error_dra_dl_bypass			:    string		:=    "false";
		crc_deld_disable			:    string		:=    "false";
		triple_adj_err_correction	:    string		:=    "false";
		quad_adj_err_correction		:    string		:=    "false";
        lpm_type    :    string    :=    "cyclonev_crcblock"
    );
    port    (
        clk    			:    in    std_logic;
        shiftnld    	:    in    std_logic;
        crcerror    	:    out    std_logic;
        regout    		:    out    std_logic;
		endofedfullchip	:    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_jtag
--

COMPONENT cyclonev_jtag
    generic    (
        lpm_type    :    string    :=    "cyclonev_jtag"
    );
    port    (
        tms    :    in    std_logic := '0';
        tck    :    in    std_logic := '0';
        tdi    :    in    std_logic := '0';
        ntrst    :    in    std_logic := '0';
        tdoutap    :    in    std_logic := '0';
        tdouser    :    in    std_logic := '0';
        corectl    :    in    std_logic := '0';
        ntdopinena    :    in    std_logic := '0';
        tckcore    :    in    std_logic := '0';
        tdicore    :    in    std_logic := '0';
        tmscore    :    in    std_logic := '0';
        tdocore    :    out    std_logic;
        tdo        :    out    std_logic;
        tmsutap    :    out    std_logic;
        tckutap    :    out    std_logic;
        tdiutap    :    out    std_logic;
        shiftuser    :    out    std_logic;
        clkdruser    :    out    std_logic;
        updateuser    :    out    std_logic;
        runidleuser    :    out    std_logic;
        usr1user    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_prblock
--

COMPONENT cyclonev_prblock
    generic    (
        lpm_type    :    string    :=    "cyclonev_prblock"
    );
    port    (
        clk    :    in    std_logic;
        corectl    :    in    std_logic;
        prrequest    :    in    std_logic;
        data    :    in    std_logic_vector(15 downto 0);
        externalrequest    :    out    std_logic;
        error    :    out    std_logic;
        ready    :    out    std_logic;
        done    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_rublock
--

COMPONENT cyclonev_rublock
    generic    (
        sim_init_watchdog_value    :    integer    :=    0;
        sim_init_status    :    integer    :=    0;
        sim_init_config_is_application    :    string    :=    "false";
        sim_init_watchdog_enabled    :    string    :=    "false";
        lpm_type    :    string    :=    "cyclonev_rublock"
    );
    port    (
        clk    :    in    std_logic;
        shiftnld    :    in    std_logic;
        captnupdt    :    in    std_logic;
        regin    :    in    std_logic;
        rsttimer    :    in    std_logic;
        rconfig    :    in    std_logic;
        regout    :    out    std_logic
    );
END COMPONENT;

--
-- cyclonev_mac
--

COMPONENT cyclonev_mac
	generic	(
        ax_width	:				integer    :=    16;
        ay_scan_in_width	:    	integer    :=    16;
        az_width    :    			integer    :=    1;
        bx_width    :    			integer    :=    16;
        by_width    :    			integer    :=    16;
        bz_width    :    			integer    :=    1;
        scan_out_width    :    		integer    :=    1;
        result_a_width    :    		integer    :=    33;
        result_b_width    :   		integer    :=    1;
        operation_mode    :    		string    :=    "m18x18_sumof2";
        mode_sub_location    :    	integer    :=    0;
        operand_source_max    :   	string    :=    "input";
        operand_source_may    :    	string    :=    "input";
        operand_source_mbx    :    	string    :=    "input";
        operand_source_mby    :   	string    :=    "input";
        preadder_subtract_a    :    string    :=    "false";
        preadder_subtract_b    :    string    :=    "false";
        signed_max    :    			string    :=    "false";
        signed_may    :    			string    :=    "false";
        signed_mbx    :    			string    :=    "false";
        signed_mby    :    			string    :=    "false";
        ay_use_scan_in    :    		string    :=    "false";
        by_use_scan_in    :    		string    :=    "false";
        delay_scan_out_ay    :    	string    :=    "false";
        delay_scan_out_by    :    	string    :=    "false";
        use_chainadder    :    		string    :=    "false";
        enable_double_accum    :    string    :=    "false";
        load_const_value    :    	integer    :=    0;
        coef_a_0    :    integer    :=    0;
        coef_a_1    :    integer    :=    0;
        coef_a_2    :    integer    :=    0;
        coef_a_3    :    integer    :=    0;
        coef_a_4    :    integer    :=    0;
        coef_a_5    :    integer    :=    0;
        coef_a_6    :    integer    :=    0;
        coef_a_7    :    integer    :=    0;
        coef_b_0    :    integer    :=    0;
        coef_b_1    :    integer    :=    0;
        coef_b_2    :    integer    :=    0;
        coef_b_3    :    integer    :=    0;
        coef_b_4    :    integer    :=    0;
        coef_b_5    :    integer    :=    0;
        coef_b_6    :    integer    :=    0;
        coef_b_7    :    integer    :=    0;
        ax_clock    :    			string    :=    "none";
        ay_scan_in_clock    :    	string    :=    "none";
        az_clock    :    			string    :=    "none";
        bx_clock    :    			string    :=    "none";
        by_clock    :    			string    :=    "none";
        bz_clock    :    			string    :=    "none";
        coef_sel_a_clock    :    	string    :=    "none";
        coef_sel_b_clock    :    	string    :=    "none";
        sub_clock    :    			string    :=    "none";
        negate_clock    :    		string    :=    "none";
        accumulate_clock    :    	string    :=    "none";
        load_const_clock    :    	string    :=    "none";
        output_clock    :    		string    :=    "none"
    );
    port    (
        sub    :    in    		std_logic := '0';
        negate    :    in    	std_logic := '0';
        accumulate    :    in   std_logic := '0';
        loadconst    :    in    std_logic := '0';
        ax    :    in    		std_logic_vector(ax_width-1 downto 0) := (others => '0');
        ay    :    in    		std_logic_vector(ay_scan_in_width-1 downto 0) := (others => '0');
        scanin    :    in    	std_logic_vector(ay_scan_in_width-1 downto 0) := (others => '0');
        az    :    in    		std_logic_vector(az_width-1 downto 0) := (others => '0');
        bx    :    in    		std_logic_vector(bx_width-1 downto 0) := (others => '0');
        by    :    in    		std_logic_vector(by_width-1 downto 0) := (others => '0');
        bz    :    in    		std_logic_vector(bz_width-1 downto 0) := (others => '0');
        coefsela    :    in    	std_logic_vector(2 downto 0) := (others => '0');
        coefselb    :    in    	std_logic_vector(2 downto 0) := (others => '0');
        chainin    :    in    	std_logic_vector(63 downto 0) := (others => '0');
        clk    :    in    		std_logic_vector(2 downto 0) := (others => '0');
        aclr    :    in    		std_logic_vector(1 downto 0) := (others => '0');
        ena    :    in    		std_logic_vector(2 downto 0) := (others => '1');
        dftout    :    out    	std_logic;
        resulta    :    out    	std_logic_vector(result_a_width-1 downto 0);
        resultb    :    out    	std_logic_vector(result_b_width-1 downto 0);
        scanout    :    out    	std_logic_vector(scan_out_width-1 downto 0);
        chainout    :    out    std_logic_vector(63 downto 0)
    );
END COMPONENT;

--
-- cyclonev_ir_fifo_userdes
--

COMPONENT cyclonev_ir_fifo_userdes
    generic (
        a_rb_bypass_serializer : string := "false";
        a_use_dynamic_fifo_mode : string := "false";
        a_rb_fifo_mode : string := "serializer_mode";
        a_rb_data_width : integer := 9;
        a_enable_soft_cdr : string := "false";
        a_rb_tx_outclk : string := "false";
        a_rb_bslipcfg : integer := 0;
        a_sim_wclk_pre_delay : integer := 0;
        a_sim_readenable_pre_delay : integer := 0
    );
    port (
        bslipmax : out std_logic;
        dynfifomode : in std_logic_vector(2 downto 0) := (OTHERS => '0');
        observableout : out std_logic;
        writeenable : in std_logic := '0';
        readclk : in std_logic := '0';
        txin : in std_logic_vector(9 downto 0) := (OTHERS => '0');
        regscanovrd : in std_logic := '0';
        rxout : out std_logic_vector(9 downto 0);
        bslipout : out std_logic;
        rstn : in std_logic := '0';
        loaden : in std_logic := '0';
        lvdsmodeen : out std_logic;
        bslipctl : in std_logic := '0';
        observablefout3 : out std_logic;
        scanin : in std_logic := '0';
        readenable : in std_logic := '0';
        scanout : out std_logic;
        writeclk : in std_logic := '0';
        observablefout2 : out std_logic;
        dinfiforx : in std_logic_vector(1 downto 0) := (OTHERS => '0');
        tstclk : in std_logic := '0';
        observablefout4 : out std_logic;
        observablefout1 : out std_logic;
        dout : out std_logic_vector(3 downto 0);
        bslipin : in std_logic := '0';
        txout : out std_logic;
        regscan : in std_logic := '0';
        observablewaddrcnt : out std_logic;
        lvdstxsel : out std_logic
    );
END COMPONENT;

--
-- cyclonev_oscillator
--

COMPONENT cyclonev_oscillator
    generic    (
        lpm_type    :    string    :=    "cyclonev_oscillator");
    port    (
        oscena    :    in    std_logic;
        clkout    :    out    std_logic;
        clkout1   :    out    std_logic
    );
END COMPONENT;

end cyclonev_components;
