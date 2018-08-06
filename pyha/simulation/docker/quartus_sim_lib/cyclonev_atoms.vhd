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
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

package cyclonev_atom_pack is

function str_to_bin (lut_mask : string ) return std_logic_vector;

function product(list : std_logic_vector) return std_logic ;

function alt_conv_integer(arg : in std_logic_vector) return integer;


-- default generic values
    CONSTANT DefWireDelay        : VitalDelayType01      := (0 ns, 0 ns);
    CONSTANT DefPropDelay01      : VitalDelayType01      := (0 ns, 0 ns);
    CONSTANT DefPropDelay01Z     : VitalDelayType01Z     := (OTHERS => 0 ns);
    CONSTANT DefSetupHoldCnst    : TIME := 0 ns;
    CONSTANT DefPulseWdthCnst    : TIME := 0 ns;
-- default control options
--    CONSTANT DefGlitchMode       : VitalGlitchKindType   := OnEvent;
-- change default delay type to Transport : for spr 68748
    CONSTANT DefGlitchMode       : VitalGlitchKindType   := VitalTransport;
    CONSTANT DefGlitchMsgOn      : BOOLEAN       := FALSE;
    CONSTANT DefGlitchXOn        : BOOLEAN       := FALSE;
    CONSTANT DefMsgOnChecks      : BOOLEAN       := TRUE;
    CONSTANT DefXOnChecks        : BOOLEAN       := TRUE;
-- output strength mapping
                                                --  UX01ZWHL-
    CONSTANT PullUp      : VitalOutputMapType    := "UX01HX01X";
    CONSTANT NoPullUpZ   : VitalOutputMapType    := "UX01ZX01X";
    CONSTANT PullDown    : VitalOutputMapType    := "UX01LX01X";
-- primitive result strength mapping
    CONSTANT wiredOR     : VitalResultMapType    := ( 'U', 'X', 'L', '1' );
    CONSTANT wiredAND    : VitalResultMapType    := ( 'U', 'X', '0', 'H' );
    CONSTANT L : VitalTableSymbolType := '0';
    CONSTANT H : VitalTableSymbolType := '1';
    CONSTANT x : VitalTableSymbolType := '-';
    CONSTANT S : VitalTableSymbolType := 'S';
    CONSTANT R : VitalTableSymbolType := '/';
    CONSTANT U : VitalTableSymbolType := 'X';
    CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

-- Declare array types for CAM_SLICE
    TYPE cyclonev_mem_data IS ARRAY (0 to 31) of STD_LOGIC_VECTOR (31 downto 0);

function int2str( value : integer ) return string;

function map_x_to_0 (value : std_logic) return std_logic;

function SelectDelay (CONSTANT Paths: IN  VitalPathArray01Type) return TIME;

function int2bit (arg : boolean) return std_logic;
function int2bit (arg : integer) return std_logic;
function bin2int (s : bit_vector) return integer;
function bin2int (s : bit) return integer;
function bin2int (s : std_logic_vector) return integer;
function bin2int (s : std_logic) return integer;
function int2bin (arg : integer; size : integer) return std_logic_vector;
function int2bin (arg : boolean; size : integer) return std_logic_vector;
function calc_sum_len( widtha : integer; widthb : integer) return integer;

end cyclonev_atom_pack;

library IEEE;
use IEEE.std_logic_1164.all;

package body cyclonev_atom_pack is

type masklength is array (4 downto 1) of std_logic_vector(3 downto 0);
function str_to_bin (lut_mask : string) return std_logic_vector is
variable slice : masklength := (OTHERS => "0000");
variable mask : std_logic_vector(15 downto 0);


begin

    for i in 1 to lut_mask'length loop
        case lut_mask(i) is
            when '0' => slice(i) := "0000";
            when '1' => slice(i) := "0001";
            when '2' => slice(i) := "0010";
            when '3' => slice(i) := "0011";
            when '4' => slice(i) := "0100";
            when '5' => slice(i) := "0101";
            when '6' => slice(i) := "0110";
            when '7' => slice(i) := "0111";
            when '8' => slice(i) := "1000";
            when '9' => slice(i) := "1001";
            when 'a' => slice(i) := "1010";
            when 'A' => slice(i) := "1010";
            when 'b' => slice(i) := "1011";
            when 'B' => slice(i) := "1011";
            when 'c' => slice(i) := "1100";
            when 'C' => slice(i) := "1100";
            when 'd' => slice(i) := "1101";
            when 'D' => slice(i) := "1101";
            when 'e' => slice(i) := "1110";
            when 'E' => slice(i) := "1110";
            when others => slice(i) := "1111";
        end case;
    end loop;
 
 
    mask := (slice(1) & slice(2) & slice(3) & slice(4));
    return (mask);
 
end str_to_bin;
 
function product (list: std_logic_vector) return std_logic is
begin

    for i in 0 to 31 loop
        if list(i) = '0' then
            return ('0');
        end if;
    end loop;
    return ('1');

end product;

function alt_conv_integer(arg : in std_logic_vector) return integer is
variable result : integer;
begin
    result := 0;
    for i in arg'range loop
        if arg(i) = '1' then
            result := result + 2**i;
        end if;
    end loop;
    return result;
end alt_conv_integer;

function int2str( value : integer ) return string is
variable ivalue,index : integer;
variable digit : integer;
variable line_no: string(8 downto 1) := "        ";
begin
    ivalue := value;
    index := 1;
    if (ivalue = 0) then
        line_no := "       0";
    end if;
    while (ivalue > 0) loop
        digit := ivalue MOD 10;
        ivalue := ivalue/10;
        case digit is
            when 0 =>
                    line_no(index) := '0';
            when 1 =>
                    line_no(index) := '1';
            when 2 =>
                    line_no(index) := '2';
            when 3 =>
                    line_no(index) := '3';
            when 4 =>
                    line_no(index) := '4';
            when 5 =>
                    line_no(index) := '5';
            when 6 =>
                    line_no(index) := '6';
            when 7 =>
                    line_no(index) := '7';
            when 8 =>
                    line_no(index) := '8';
            when 9 =>
                    line_no(index) := '9';
            when others =>
                    ASSERT FALSE
                    REPORT "Illegal number!"
                    SEVERITY ERROR;
        end case;
        index := index + 1;
    end loop;
    return line_no;
end;

function map_x_to_0 (value : std_logic) return std_logic is
begin
    if (Is_X (value) = TRUE) then
        return '0';
    else
        return value;
    end if;
end;

function SelectDelay (CONSTANT Paths : IN  VitalPathArray01Type) return TIME IS

variable Temp  : TIME;
variable TransitionTime  : TIME := TIME'HIGH;
variable PathDelay : TIME := TIME'HIGH;

begin

    for i IN Paths'RANGE loop
        next when not Paths(i).PathCondition;

        next when Paths(i).InputChangeTime > TransitionTime;

        Temp := Paths(i).PathDelay(tr01);

        if Paths(i).InputChangeTime < TransitionTime then
            PathDelay := Temp;
        else
            if Temp < PathDelay then
                PathDelay := Temp;
            end if;
        end if;
        TransitionTime := Paths(i).InputChangeTime;
    end loop;

    return PathDelay;

end;

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

function calc_sum_len( widtha : integer; widthb : integer) return integer is
variable result: integer;
begin
        if(widtha >= widthb) then
                result := widtha + 1;
        else
                result := widthb + 1;
        end if;
        return result;
end calc_sum_len;

end cyclonev_atom_pack;

Library ieee;
use ieee.std_logic_1164.all;

Package cyclonev_pllpack is


    procedure find_simple_integer_fraction( numerator   : in integer;
                                            denominator : in integer;
                                            max_denom   : in integer;
                                            fraction_num : out integer; 
                                            fraction_div : out integer);

    procedure find_m_and_n_4_manual_phase ( inclock_period : in integer;
                                            vco_phase_shift_step : in integer;
                                            clk0_mult: in integer; clk1_mult: in integer;
                                            clk2_mult: in integer; clk3_mult: in integer;
                                            clk4_mult: in integer; clk5_mult: in integer;
                                            clk6_mult: in integer; clk7_mult: in integer;
                                            clk8_mult: in integer; clk9_mult: in integer;
                                            clk0_div : in integer; clk1_div : in integer;
                                            clk2_div : in integer; clk3_div : in integer;
                                            clk4_div : in integer; clk5_div : in integer;
                                            clk6_div : in integer; clk7_div : in integer;
                                            clk8_div : in integer; clk9_div : in integer;
                                            clk0_used : in string; clk1_used : in string;
                                            clk2_used : in string; clk3_used : in string;
                                            clk4_used : in string; clk5_used : in string;
                                            clk6_used : in string; clk7_used : in string;
                                            clk8_used : in string; clk9_used : in string;
                                            m : out integer;
                                            n : out integer );

    function gcd (X: integer; Y: integer) return integer;

    function count_digit (X: integer) return integer;

    function scale_num (X: integer; Y: integer) return integer;

    function lcm (A1: integer; A2: integer; A3: integer; A4: integer;
                A5: integer; A6: integer; A7: integer;
                A8: integer; A9: integer; A10: integer; P: integer) return integer;

    function output_counter_value (clk_divide: integer; clk_mult : integer ;
            M: integer; N: integer ) return integer;

    function counter_mode (duty_cycle: integer; output_counter_value: integer) return string;

    function counter_high (output_counter_value: integer := 1; duty_cycle: integer)
                        return integer;

    function counter_low (output_counter_value: integer; duty_cycle: integer)
                        return integer;

    function mintimedelay (t1: integer; t2: integer; t3: integer; t4: integer;
                        t5: integer; t6: integer; t7: integer; t8: integer;
                        t9: integer; t10: integer) return integer;

    function maxnegabs (t1: integer; t2: integer; t3: integer; t4: integer;
                        t5: integer; t6: integer; t7: integer; t8: integer;
                        t9: integer; t10: integer) return integer;

    function counter_time_delay ( clk_time_delay: integer;
                        m_time_delay: integer; n_time_delay: integer)
                        return integer;

    function get_phase_degree (phase_shift: integer; clk_period: integer) return integer;

    function counter_initial (tap_phase: integer; m: integer; n: integer)
                        return integer;

    function counter_ph (tap_phase: integer; m : integer; n: integer) return integer;

    function ph_adjust (tap_phase: integer; ph_base : integer) return integer;

    function translate_string (mode : string) return string;
    
    function str2int (s : string) return integer;

    function dqs_str2int (s : string) return integer;

end cyclonev_pllpack;

package body cyclonev_pllpack is


-- finds the closest integer fraction of a given pair of numerator and denominator. 
procedure find_simple_integer_fraction( numerator   : in integer;
                                        denominator : in integer;
                                        max_denom   : in integer;
                                        fraction_num : out integer; 
                                        fraction_div : out integer) is
    constant MAX_ITER : integer := 20; 
    type INT_ARRAY is array ((MAX_ITER-1) downto 0) of integer;

    variable quotient_array : INT_ARRAY;
    variable int_loop_iter : integer;
    variable int_quot  : integer;
    variable m_value   : integer;
    variable d_value   : integer;
    variable old_m_value : integer;
    variable swap  : integer;
    variable loop_iter : integer;
    variable num   : integer;
    variable den   : integer;
    variable i_max_iter : integer;

begin      
    loop_iter := 0;

    if (numerator = 0) then
        num := 1;
    else
        num := numerator;
    end if;

    if (denominator = 0) then
        den := 1;
    else
        den := denominator;
    end if;

    i_max_iter := max_iter;
   
    while (loop_iter < i_max_iter) loop
        int_quot := num / den;
        quotient_array(loop_iter) := int_quot;
        num := num - (den*int_quot);
        loop_iter := loop_iter+1;
        
        if ((num = 0) or (max_denom /= -1) or (loop_iter = i_max_iter)) then
            -- calculate the numerator and denominator if there is a restriction on the
            -- max denom value or if the loop is ending
            m_value := 0;
            d_value := 1;
            -- get the rounded value at this stage for the remaining fraction
            if (den /= 0) then
                m_value := (2*num/den);
            end if;
            -- calculate the fraction numerator and denominator at this stage
            for int_loop_iter in (loop_iter-1) downto 0 loop
                if (m_value = 0) then
                    m_value := quotient_array(int_loop_iter);
                    d_value := 1;
                else
                    old_m_value := m_value;
                    m_value := (quotient_array(int_loop_iter)*m_value) + d_value;
                    d_value := old_m_value;
                end if;
            end loop;
            -- if the denominator is less than the maximum denom_value or if there is no restriction save it
            if ((d_value <= max_denom) or (max_denom = -1)) then
                if ((m_value = 0) or (d_value = 0)) then
                    fraction_num := numerator;
                    fraction_div := denominator;
                else
                    fraction_num := m_value;
                    fraction_div := d_value;
                end if;
            end if;
            -- end the loop if the denomitor has overflown or the numerator is zero (no remainder during this round)
            if (((d_value > max_denom) and (max_denom /= -1)) or (num = 0)) then
                i_max_iter := loop_iter;
            end if;
        end if;
        -- swap the numerator and denominator for the next round
        swap := den;
        den := num;
        num := swap;
    end loop;
end find_simple_integer_fraction;

-- find the M and N values for Manual phase based on the following 5 criterias:
-- 1. The PFD frequency (i.e. Fin / N) must be in the range 5 MHz to 720 MHz
-- 2. The VCO frequency (i.e. Fin * M / N) must be in the range 300 MHz to 1300 MHz
-- 3. M is less than 512
-- 4. N is less than 512
-- 5. It's the smallest M/N which satisfies all the above constraints, and is within 2ps
--    of the desired vco-phase-shift-step
procedure find_m_and_n_4_manual_phase ( inclock_period : in integer;
                                        vco_phase_shift_step : in integer;
                                        clk0_mult: in integer; clk1_mult: in integer;
                                        clk2_mult: in integer; clk3_mult: in integer;
                                        clk4_mult: in integer; clk5_mult: in integer;
                                        clk6_mult: in integer; clk7_mult: in integer;
                                        clk8_mult: in integer; clk9_mult: in integer;
                                        clk0_div : in integer; clk1_div : in integer;
                                        clk2_div : in integer; clk3_div : in integer;
                                        clk4_div : in integer; clk5_div : in integer;
                                        clk6_div : in integer; clk7_div : in integer;
                                        clk8_div : in integer; clk9_div : in integer;
                                        clk0_used : in string; clk1_used : in string;
                                        clk2_used : in string; clk3_used : in string;
                                        clk4_used : in string; clk5_used : in string;
                                        clk6_used : in string; clk7_used : in string;
                                        clk8_used : in string; clk9_used : in string;
                                        m : out integer;
                                        n : out integer ) is
        constant MAX_M : integer := 511;
        constant MAX_N : integer := 511;
        constant MAX_PFD : integer := 720;
        constant MIN_PFD : integer := 5;
        constant MAX_VCO : integer := 1600; -- max vco frequency. (in mHz)
        constant MIN_VCO : integer := 300;  -- min vco frequency. (in mHz)
        constant MAX_OFFSET : real := 0.004;

        variable vco_period : integer;
        variable pfd_freq : integer;
        variable vco_freq : integer;
        variable vco_ps_step_value : integer;

        variable i_m : integer;
        variable i_n : integer;

        variable i_pre_m : integer;
        variable i_pre_n : integer;

        variable closest_vco_step_value : integer;

        variable i_max_iter : integer;
        variable loop_iter : integer;
        
        variable clk0_div_factor_real : real;
        variable clk1_div_factor_real : real;
        variable clk2_div_factor_real : real;
        variable clk3_div_factor_real : real;
        variable clk4_div_factor_real : real;
        variable clk5_div_factor_real : real;
        variable clk6_div_factor_real : real;
        variable clk7_div_factor_real : real;
        variable clk8_div_factor_real : real;
        variable clk9_div_factor_real : real;
        variable clk0_div_factor_int : integer;
        variable clk1_div_factor_int : integer;
        variable clk2_div_factor_int : integer;
        variable clk3_div_factor_int : integer;
        variable clk4_div_factor_int : integer;
        variable clk5_div_factor_int : integer;
        variable clk6_div_factor_int : integer;
        variable clk7_div_factor_int : integer;
        variable clk8_div_factor_int : integer;
        variable clk9_div_factor_int : integer;
begin
    vco_period := vco_phase_shift_step * 8;
    i_pre_m := 0;
    i_pre_n := 0;
    closest_vco_step_value := 0;

    LOOP_1 :   for i_n_out in 1 to MAX_N loop
        for i_m_out in 1 to MAX_M loop
        
            clk0_div_factor_real := real(clk0_div * i_m_out) / real(clk0_mult * i_n_out);
            clk1_div_factor_real := real(clk1_div * i_m_out) / real(clk1_mult * i_n_out);
            clk2_div_factor_real := real(clk2_div * i_m_out) / real(clk2_mult * i_n_out);
            clk3_div_factor_real := real(clk3_div * i_m_out) / real(clk3_mult * i_n_out);
            clk4_div_factor_real := real(clk4_div * i_m_out) / real(clk4_mult * i_n_out);
            clk5_div_factor_real := real(clk5_div * i_m_out) / real(clk5_mult * i_n_out);
            clk6_div_factor_real := real(clk6_div * i_m_out) / real(clk6_mult * i_n_out);
            clk7_div_factor_real := real(clk7_div * i_m_out) / real(clk7_mult * i_n_out);
            clk8_div_factor_real := real(clk8_div * i_m_out) / real(clk8_mult * i_n_out);
            clk9_div_factor_real := real(clk9_div * i_m_out) / real(clk9_mult * i_n_out);

            clk0_div_factor_int := integer(clk0_div_factor_real);
            clk1_div_factor_int := integer(clk1_div_factor_real);
            clk2_div_factor_int := integer(clk2_div_factor_real);
            clk3_div_factor_int := integer(clk3_div_factor_real);
            clk4_div_factor_int := integer(clk4_div_factor_real);
            clk5_div_factor_int := integer(clk5_div_factor_real);
            clk6_div_factor_int := integer(clk6_div_factor_real);
            clk7_div_factor_int := integer(clk7_div_factor_real);
            clk8_div_factor_int := integer(clk8_div_factor_real);
            clk9_div_factor_int := integer(clk9_div_factor_real);
                        
            if (((abs(clk0_div_factor_real - real(clk0_div_factor_int)) < MAX_OFFSET) or (clk0_used = "unused")) and
                ((abs(clk1_div_factor_real - real(clk1_div_factor_int)) < MAX_OFFSET) or (clk1_used = "unused")) and
                ((abs(clk2_div_factor_real - real(clk2_div_factor_int)) < MAX_OFFSET) or (clk2_used = "unused")) and
                ((abs(clk3_div_factor_real - real(clk3_div_factor_int)) < MAX_OFFSET) or (clk3_used = "unused")) and
                ((abs(clk4_div_factor_real - real(clk4_div_factor_int)) < MAX_OFFSET) or (clk4_used = "unused")) and
                ((abs(clk5_div_factor_real - real(clk5_div_factor_int)) < MAX_OFFSET) or (clk5_used = "unused")) and
                ((abs(clk6_div_factor_real - real(clk6_div_factor_int)) < MAX_OFFSET) or (clk6_used = "unused")) and
                ((abs(clk7_div_factor_real - real(clk7_div_factor_int)) < MAX_OFFSET) or (clk7_used = "unused")) and
                ((abs(clk8_div_factor_real - real(clk8_div_factor_int)) < MAX_OFFSET) or (clk8_used = "unused")) and
                ((abs(clk9_div_factor_real - real(clk9_div_factor_int)) < MAX_OFFSET) or (clk9_used = "unused")) )
            then
                if ((i_m_out /= 0) and (i_n_out /= 0))
                then
                    pfd_freq := 1000000 / (inclock_period * i_n_out);
                    vco_freq := (1000000 * i_m_out) / (inclock_period * i_n_out);
                    vco_ps_step_value := (inclock_period * i_n_out) / (8 * i_m_out);
    
                    if ( (i_m_out < max_m) and (i_n_out < max_n) and (pfd_freq >= min_pfd) and (pfd_freq <= max_pfd) and
                        (vco_freq >= min_vco) and (vco_freq <= max_vco) )
                    then
                        if (abs(vco_ps_step_value - vco_phase_shift_step) <= 2)
                        then
                            i_pre_m := i_m_out;
                            i_pre_n := i_n_out;
                            exit LOOP_1;
                        else
                            if ((closest_vco_step_value = 0) or (abs(vco_ps_step_value - vco_phase_shift_step) < abs(closest_vco_step_value - vco_phase_shift_step)))
                            then
                                i_pre_m := i_m_out;
                                i_pre_n := i_n_out;
                                closest_vco_step_value := vco_ps_step_value;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end loop;
    end loop;
    
    if ((i_pre_m /= 0) and (i_pre_n /= 0))
    then
        find_simple_integer_fraction(i_pre_m, i_pre_n,
                    MAX_N, m, n);
    else
        n := 1;
        m := lcm  (clk0_mult, clk1_mult, clk2_mult, clk3_mult,
                clk4_mult, clk5_mult, clk6_mult,
                clk7_mult, clk8_mult, clk9_mult, inclock_period);
    end if;
end find_m_and_n_4_manual_phase;

-- find the greatest common denominator of X and Y
function gcd (X: integer; Y: integer) return integer is
variable L, S, R, G : integer := 1;
begin
    if (X < Y) then -- find which is smaller.
        S := X;
        L := Y;
    else
        S := Y;
        L := X;
    end if;

    R := S;
    while ( R > 1) loop
        S := L;
        L := R;
        R := S rem L;   -- divide bigger number by smaller.
                        -- remainder becomes smaller number.
    end loop;
    if (R = 0) then  -- if evenly divisible then L is gcd else it is 1.
        G := L;
    else
        G := R;
    end if;

    return G;
end gcd;

-- count the number of digits in the given integer
function count_digit (X: integer)
        return integer is
variable count, result: integer := 0;
begin
    result := X;
    while (result /= 0) loop
        result := (result / 10);
        count := count + 1;
    end loop;
    
    return count;
end count_digit;
    
-- reduce the given huge number to Y significant digits
function scale_num (X: integer; Y: integer)
        return integer is
variable count : integer := 0; 
variable lc, fac_ten, result: integer := 1;
begin
    count := count_digit(X);

    for lc in 1 to (count-Y) loop
        fac_ten := fac_ten * 10;
    end loop;
    
    result := (X / fac_ten);
    
    return result;
end scale_num;

-- find the least common multiple of A1 to A10
function lcm (A1: integer; A2: integer; A3: integer; A4: integer;
            A5: integer; A6: integer; A7: integer;
            A8: integer; A9: integer; A10: integer; P: integer)
        return integer is
variable M1, M2, M3, M4, M5 , M6, M7, M8, M9, R: integer := 1;
begin
    M1 := (A1 * A2)/gcd(A1, A2);
    M2 := (M1 * A3)/gcd(M1, A3);
    M3 := (M2 * A4)/gcd(M2, A4);
    M4 := (M3 * A5)/gcd(M3, A5);
    M5 := (M4 * A6)/gcd(M4, A6);
    M6 := (M5 * A7)/gcd(M5, A7);
    M7 := (M6 * A8)/gcd(M6, A8);
    M8 := (M7 * A9)/gcd(M7, A9);
    M9 := (M8 * A10)/gcd(M8, A10);
    if (M9 < 3) then
        R := 10;
    elsif (M9 = 3) then
        R := 9;
    elsif ((M9 <= 10) and (M9 > 3)) then
        R := 4 * M9;
    elsif (M9 > 1000) then
        R := scale_num(M9,3);
    else
        R := M9 ;
    end if;

    return R;
end lcm;

-- find the factor of division of the output clock frequency compared to the VCO
function output_counter_value (clk_divide: integer; clk_mult: integer ;
                                M: integer; N: integer ) return integer is
variable r_real : real := 1.0;
variable r: integer := 1;
begin
    r_real := real(clk_divide * M)/ real(clk_mult * N);
    r := integer(r_real);

    return R;
end output_counter_value;

-- find the mode of each PLL counter - bypass, even or odd
function counter_mode (duty_cycle: integer; output_counter_value: integer)
        return string is
variable R: string (1 to 6) := "      ";
variable counter_value: integer := 1;
begin
    counter_value := (2*duty_cycle*output_counter_value)/100;
    if output_counter_value = 1 then
        R := "bypass";
    elsif (counter_value REM 2) = 0 then
        R := "  even";
    else
        R := "   odd";
    end if;

    return R;
end counter_mode;

-- find the number of VCO clock cycles to hold the output clock high
function counter_high (output_counter_value: integer := 1; duty_cycle: integer)
        return integer is
variable R: integer := 1;
variable half_cycle_high : integer := 1;
begin
    half_cycle_high := (duty_cycle * output_counter_value *2)/100 ;
    if (half_cycle_high REM 2 = 0) then
        R := half_cycle_high/2 ;
    else
        R := (half_cycle_high/2) + 1;
    end if;

    return R;
end;

-- find the number of VCO clock cycles to hold the output clock low
function counter_low (output_counter_value: integer; duty_cycle: integer)
        return integer is
variable R, R1: integer := 1;
variable half_cycle_high : integer := 1;
begin
    half_cycle_high := (duty_cycle * output_counter_value*2)/100 ;
    if (half_cycle_high REM 2 = 0) then
        R1 := half_cycle_high/2 ;
    else
        R1 := (half_cycle_high/2) + 1;
    end if;

    R := output_counter_value - R1;

    if (R = 0) then
        R := 1;
    end if;

    return R;
end;

-- find the smallest time delay amongst t1 to t10
function mintimedelay (t1: integer; t2: integer; t3: integer; t4: integer;
                        t5: integer; t6: integer; t7: integer; t8: integer;
                        t9: integer; t10: integer) return integer is
variable m1,m2,m3,m4,m5,m6,m7,m8,m9 : integer := 0;
begin
    if (t1 < t2) then m1 := t1; else m1 := t2; end if;
    if (m1 < t3) then m2 := m1; else m2 := t3; end if;
    if (m2 < t4) then m3 := m2; else m3 := t4; end if;
    if (m3 < t5) then m4 := m3; else m4 := t5; end if;
    if (m4 < t6) then m5 := m4; else m5 := t6; end if;
    if (m5 < t7) then m6 := m5; else m6 := t7; end if;
    if (m6 < t8) then m7 := m6; else m7 := t8; end if;
    if (m7 < t9) then m8 := m7; else m8 := t9; end if;
    if (m8 < t10) then m9 := m8; else m9 := t10; end if;
    if (m9 > 0) then return m9; else return 0; end if;
end;

-- find the numerically largest negative number, and return its absolute value
function maxnegabs (t1: integer; t2: integer; t3: integer; t4: integer;
                    t5: integer; t6: integer; t7: integer; t8: integer;
                    t9: integer; t10: integer) return integer is
variable m1,m2,m3,m4,m5,m6,m7,m8,m9 : integer := 0;
begin
    if (t1 < t2) then m1 := t1; else m1 := t2; end if;
    if (m1 < t3) then m2 := m1; else m2 := t3; end if;
    if (m2 < t4) then m3 := m2; else m3 := t4; end if;
    if (m3 < t5) then m4 := m3; else m4 := t5; end if;
    if (m4 < t6) then m5 := m4; else m5 := t6; end if;
    if (m5 < t7) then m6 := m5; else m6 := t7; end if;
    if (m6 < t8) then m7 := m6; else m7 := t8; end if;
    if (m7 < t9) then m8 := m7; else m8 := t9; end if;
    if (m8 < t10) then m9 := m8; else m9 := t10; end if;
    if (m9 < 0) then return (0 - m9); else return 0; end if;
end;

-- adjust the phase (tap_phase) with the largest negative number (ph_base)
function ph_adjust (tap_phase: integer; ph_base : integer) return integer is
begin
    return (tap_phase + ph_base);
end;

-- find the time delay for each PLL counter
function counter_time_delay (clk_time_delay: integer;
                            m_time_delay: integer; n_time_delay: integer)
        return integer is
variable R: integer := 0;
begin
    R := clk_time_delay + m_time_delay - n_time_delay;

    return R;
end;

-- calculate the given phase shift (in ps) in terms of degrees
function get_phase_degree (phase_shift: integer; clk_period: integer)
        return integer is
variable result: integer := 0;
begin
    result := ( phase_shift * 360 ) / clk_period;
    -- to round up the calculation result
    if (result > 0) then
        result := result + 1;
    elsif (result < 0) then
        result := result - 1;
    else
        result := 0;
    end if;

    return result;
end;

-- find the number of VCO clock cycles to wait initially before the first rising
-- edge of the output clock
function counter_initial (tap_phase: integer; m: integer; n: integer)
        return integer is
variable R: integer;
variable R1: real;
begin
    R1 := (real(abs(tap_phase)) * real(m))/(360.0 * real(n)) + 0.6;
    -- Note NCSim VHDL had problem in rounding up for 0.5 - 0.99. 
    -- This checking will ensure that the rounding up is done.
    if (R1 >= 0.5) and (R1 <= 1.0) then
        R1 := 1.0;
    end if;

    R := integer(R1);

    return R;
end;

-- find which VCO phase tap (0 to 7) to align the rising edge of the output clock to
function counter_ph (tap_phase: integer; m: integer; n: integer) return integer is
variable R: integer := 0;
begin
    -- 0.5 is added for proper rounding of the tap_phase.
    R := integer(real(integer(real(tap_phase * m / n)+ 0.5) REM 360)/45.0) rem 8;

    return R;
end;

-- convert given string to length 6 by padding with spaces
function translate_string (mode : string) return string is
variable new_mode : string (1 to 6) := "      ";
begin
    if (mode = "bypass") then
        new_mode := "bypass";
    elsif (mode = "even") then
        new_mode := "  even";
    elsif (mode = "odd") then
        new_mode := "   odd";
    end if;

    return new_mode;
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
                    REPORT "Illegal Character "&  s(i) & "i n string parameter! "
                    SEVERITY ERROR;
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

function dqs_str2int (s : string) return integer is
variable len : integer := s'length;
variable newdigit : integer := 0;
variable sign : integer := 1;
variable digit : integer := 0;
variable err : boolean := false;
begin
    for i in 1 to len loop
        case s(i) is
            when '-' =>
                if i = 1 then
                    sign := -1;
                else
                    ASSERT FALSE
                    REPORT "Illegal Character "&  s(i) & " in string parameter! "
                    SEVERITY ERROR;
                    err := true;
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
                -- set error flag
                err := true;
        end case;
        if (err) then
            err := false;
        else
            newdigit := newdigit * 10 + digit;
        end if;
    end loop;

    return (sign*newdigit);
end;

end cyclonev_pllpack;

--
--
--  DFFE Model
--
--

LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use work.cyclonev_atom_pack.all;

entity cyclonev_dffe is
    generic(
        TimingChecksOn: Boolean := True;
        XOn: Boolean := DefGlitchXOn;
        MsgOn: Boolean := DefGlitchMsgOn;
        MsgOnChecks: Boolean := DefMsgOnChecks;
        XOnChecks: Boolean := DefXOnChecks;
        InstancePath: STRING := "*";
        tpd_PRN_Q_negedge              :  VitalDelayType01 := DefPropDelay01;
        tpd_CLRN_Q_negedge             :  VitalDelayType01 := DefPropDelay01;
        tpd_CLK_Q_posedge              :  VitalDelayType01 := DefPropDelay01;
        tpd_ENA_Q_posedge              :  VitalDelayType01 := DefPropDelay01;
        tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
        tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
        tsetup_ENA_CLK_noedge_posedge  :  VitalDelayType := DefSetupHoldCnst;
        thold_D_CLK_noedge_posedge     :   VitalDelayType := DefSetupHoldCnst;
        thold_D_CLK_noedge_negedge     :   VitalDelayType := DefSetupHoldCnst;
        thold_ENA_CLK_noedge_posedge   :   VitalDelayType := DefSetupHoldCnst;
        tipd_D                         :  VitalDelayType01 := DefPropDelay01;
        tipd_CLRN                      :  VitalDelayType01 := DefPropDelay01;
        tipd_PRN                       :  VitalDelayType01 := DefPropDelay01;
        tipd_CLK                       :  VitalDelayType01 := DefPropDelay01;
        tipd_ENA                       :  VitalDelayType01 := DefPropDelay01);

    port(
        Q                              :  out   STD_LOGIC := '0';
        D                              :  in    STD_LOGIC;
        CLRN                           :  in    STD_LOGIC;
        PRN                            :  in    STD_LOGIC;
        CLK                            :  in    STD_LOGIC;
        ENA                            :  in    STD_LOGIC);
    attribute VITAL_LEVEL0 of cyclonev_dffe : entity is TRUE;
end cyclonev_dffe;

-- architecture body --

architecture behave of cyclonev_dffe is
    attribute VITAL_LEVEL0 of behave : architecture is TRUE;
    
    signal D_ipd  : STD_ULOGIC := 'U';
    signal CLRN_ipd       : STD_ULOGIC := 'U';
    signal PRN_ipd        : STD_ULOGIC := 'U';
    signal CLK_ipd        : STD_ULOGIC := 'U';
    signal ENA_ipd        : STD_ULOGIC := 'U';

begin

    ---------------------
    --  INPUT PATH DELAYs
    ---------------------
    WireDelay : block
    begin
        VitalWireDelay (D_ipd, D, tipd_D);
        VitalWireDelay (CLRN_ipd, CLRN, tipd_CLRN);
        VitalWireDelay (PRN_ipd, PRN, tipd_PRN);
        VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
        VitalWireDelay (ENA_ipd, ENA, tipd_ENA);
    end block;
    --------------------
    --  BEHAVIOR SECTION
    --------------------
    VITALBehavior : process (D_ipd, CLRN_ipd, PRN_ipd, CLK_ipd, ENA_ipd)
    
    -- timing check results
    VARIABLE Tviol_D_CLK : STD_ULOGIC := '0';
    VARIABLE Tviol_ENA_CLK       : STD_ULOGIC := '0';
    VARIABLE TimingData_D_CLK : VitalTimingDataType := VitalTimingDataInit;
    VARIABLE TimingData_ENA_CLK : VitalTimingDataType := VitalTimingDataInit;
    
    -- functionality results
    VARIABLE Violation : STD_ULOGIC := '0';
    VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 7);
    VARIABLE D_delayed : STD_ULOGIC := 'U';
    VARIABLE CLK_delayed : STD_ULOGIC := 'U';
    VARIABLE ENA_delayed : STD_ULOGIC := 'U';
    VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => '0');

    -- output glitch detection variables
    VARIABLE Q_VitalGlitchData   : VitalGlitchDataType;


    CONSTANT dffe_Q_tab : VitalStateTableType := (
        ( L,  L,  x,  x,  x,  x,  x,  x,  x,  L ),
        ( L,  H,  L,  H,  H,  x,  x,  H,  x,  H ),
        ( L,  H,  L,  H,  x,  L,  x,  H,  x,  H ),
        ( L,  H,  L,  x,  H,  H,  x,  H,  x,  H ),
        ( L,  H,  H,  x,  x,  x,  H,  x,  x,  S ),
        ( L,  H,  x,  x,  x,  x,  L,  x,  x,  H ),
        ( L,  H,  x,  x,  x,  x,  H,  L,  x,  S ),
        ( L,  x,  L,  L,  L,  x,  H,  H,  x,  L ),
        ( L,  x,  L,  L,  x,  L,  H,  H,  x,  L ),
        ( L,  x,  L,  x,  L,  H,  H,  H,  x,  L ),
        ( L,  x,  x,  x,  x,  x,  x,  x,  x,  S ));
    begin

        ------------------------
        --  Timing Check Section
        ------------------------
        if (TimingChecksOn) then
            VitalSetupHoldCheck (
                Violation       => Tviol_D_CLK,
                TimingData      => TimingData_D_CLK,
                TestSignal      => D_ipd,
                TestSignalName  => "D",
                RefSignal       => CLK_ipd,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_D_CLK_noedge_posedge,
                SetupLow        => tsetup_D_CLK_noedge_posedge,
                HoldHigh        => thold_D_CLK_noedge_posedge,
                HoldLow         => thold_D_CLK_noedge_posedge,
                CheckEnabled    => TO_X01(( (NOT PRN_ipd) ) OR ( (NOT CLRN_ipd) ) OR ( (NOT ENA_ipd) )) /= '1',
                RefTransition   => '/',
                HeaderMsg       => InstancePath & "/DFFE",
                XOn             => XOnChecks,
                MsgOn           => MsgOnChecks );

            VitalSetupHoldCheck (
                Violation       => Tviol_ENA_CLK,
                TimingData      => TimingData_ENA_CLK,
                TestSignal      => ENA_ipd,
                TestSignalName  => "ENA",
                RefSignal       => CLK_ipd,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_ENA_CLK_noedge_posedge,
                SetupLow        => tsetup_ENA_CLK_noedge_posedge,
                HoldHigh        => thold_ENA_CLK_noedge_posedge,
                HoldLow         => thold_ENA_CLK_noedge_posedge,
                CheckEnabled    => TO_X01(( (NOT PRN_ipd) ) OR ( (NOT CLRN_ipd) ) ) /= '1',
                RefTransition   => '/',
                HeaderMsg       => InstancePath & "/DFFE",
                XOn             => XOnChecks,
                MsgOn           => MsgOnChecks );
        end if;

        -------------------------
        --  Functionality Section
        -------------------------
        Violation := Tviol_D_CLK or Tviol_ENA_CLK;
        VitalStateTable(
        StateTable => dffe_Q_tab,
        DataIn => (
                Violation, CLRN_ipd, CLK_delayed, Results(1), D_delayed, ENA_delayed, PRN_ipd, CLK_ipd),
        Result => Results,
        NumStates => 1,
        PreviousDataIn => PrevData_Q);
        D_delayed := D_ipd;
        CLK_delayed := CLK_ipd;
        ENA_delayed := ENA_ipd;

        ----------------------
        --  Path Delay Section
        ----------------------
        VitalPathDelay01 (
        OutSignal => Q,
        OutSignalName => "Q",
        OutTemp => Results(1),
        Paths => (  0 => (PRN_ipd'last_event, tpd_PRN_Q_negedge, TRUE),
                    1 => (CLRN_ipd'last_event, tpd_CLRN_Q_negedge, TRUE),
                    2 => (CLK_ipd'last_event, tpd_CLK_Q_posedge, TRUE)),
        GlitchData => Q_VitalGlitchData,
        Mode => DefGlitchMode,
        XOn  => XOn,
        MsgOn        => MsgOn );

    end process;

end behave;

--
--
--  cyclonev_mux21 Model
--
--

LIBRARY IEEE;
use ieee.std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use work.cyclonev_atom_pack.all;

entity cyclonev_mux21 is
    generic(
        TimingChecksOn: Boolean := True;
        MsgOn: Boolean := DefGlitchMsgOn;
        XOn: Boolean := DefGlitchXOn;
        InstancePath: STRING := "*";
        tpd_A_MO                      :   VitalDelayType01 := DefPropDelay01;
        tpd_B_MO                      :   VitalDelayType01 := DefPropDelay01;
        tpd_S_MO                      :   VitalDelayType01 := DefPropDelay01;
        tipd_A                       :    VitalDelayType01 := DefPropDelay01;
        tipd_B                       :    VitalDelayType01 := DefPropDelay01;
        tipd_S                       :    VitalDelayType01 := DefPropDelay01);
    port (
        A : in std_logic := '0';
        B : in std_logic := '0';
        S : in std_logic := '0';
        MO : out std_logic);
    attribute VITAL_LEVEL0 of cyclonev_mux21 : entity is TRUE;
end cyclonev_mux21;

architecture AltVITAL of cyclonev_mux21 is
    attribute VITAL_LEVEL0 of AltVITAL : architecture is TRUE;

    signal A_ipd, B_ipd, S_ipd  : std_logic;

begin

    ---------------------
    --  INPUT PATH DELAYs
    ---------------------
    WireDelay : block
    begin
        VitalWireDelay (A_ipd, A, tipd_A);
        VitalWireDelay (B_ipd, B, tipd_B);
        VitalWireDelay (S_ipd, S, tipd_S);
    end block;

    --------------------
    --  BEHAVIOR SECTION
    --------------------
    VITALBehavior : process (A_ipd, B_ipd, S_ipd)

    -- output glitch detection variables
    VARIABLE MO_GlitchData       : VitalGlitchDataType;

    variable tmp_MO : std_logic;
    begin
        -------------------------
        --  Functionality Section
        -------------------------
        if (S_ipd = '1') then
            tmp_MO := B_ipd;
        else
            tmp_MO := A_ipd;
        end if;

        ----------------------
        --  Path Delay Section
        ----------------------
        VitalPathDelay01 (
        OutSignal => MO,
        OutSignalName => "MO",
        OutTemp => tmp_MO,
        Paths => (  0 => (A_ipd'last_event, tpd_A_MO, TRUE),
                    1 => (B_ipd'last_event, tpd_B_MO, TRUE),
                    2 => (S_ipd'last_event, tpd_S_MO, TRUE)),
        GlitchData => MO_GlitchData,
        Mode => DefGlitchMode,
        XOn  => XOn,
        MsgOn        => MsgOn );

    end process;
end AltVITAL;

--
--
--  cyclonev_mux41 Model
--
--

LIBRARY IEEE;
use ieee.std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use work.cyclonev_atom_pack.all;

entity cyclonev_mux41 is
    generic(
            TimingChecksOn: Boolean := True;
            MsgOn: Boolean := DefGlitchMsgOn;
            XOn: Boolean := DefGlitchXOn;
            InstancePath: STRING := "*";
            tpd_IN0_MO : VitalDelayType01 := DefPropDelay01;
            tpd_IN1_MO : VitalDelayType01 := DefPropDelay01;
            tpd_IN2_MO : VitalDelayType01 := DefPropDelay01;
            tpd_IN3_MO : VitalDelayType01 := DefPropDelay01;
            tpd_S_MO : VitalDelayArrayType01(1 downto 0) := (OTHERS => DefPropDelay01);
            tipd_IN0 : VitalDelayType01 := DefPropDelay01;
            tipd_IN1 : VitalDelayType01 := DefPropDelay01;
            tipd_IN2 : VitalDelayType01 := DefPropDelay01;
            tipd_IN3 : VitalDelayType01 := DefPropDelay01;
            tipd_S : VitalDelayArrayType01(1 downto 0) := (OTHERS => DefPropDelay01)
        );
    port (
            IN0 : in std_logic := '0';
            IN1 : in std_logic := '0';
            IN2 : in std_logic := '0';
            IN3 : in std_logic := '0';
            S : in std_logic_vector(1 downto 0) := (OTHERS => '0');
            MO : out std_logic
        );
    attribute VITAL_LEVEL0 of cyclonev_mux41 : entity is TRUE;
end cyclonev_mux41;

architecture AltVITAL of cyclonev_mux41 is
    attribute VITAL_LEVEL0 of AltVITAL : architecture is TRUE;

    signal IN0_ipd, IN1_ipd, IN2_ipd, IN3_ipd  : std_logic;
    signal S_ipd : std_logic_vector(1 downto 0);

begin

    ---------------------
    --  INPUT PATH DELAYs
    ---------------------
    WireDelay : block
    begin
        VitalWireDelay (IN0_ipd, IN0, tipd_IN0);
        VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
        VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
        VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
        VitalWireDelay (S_ipd(0), S(0), tipd_S(0));
        VitalWireDelay (S_ipd(1), S(1), tipd_S(1));
    end block;

    --------------------
    --  BEHAVIOR SECTION
    --------------------
    VITALBehavior : process (IN0_ipd, IN1_ipd, IN2_ipd, IN3_ipd, S_ipd(0), S_ipd(1))

    -- output glitch detection variables
    VARIABLE MO_GlitchData       : VitalGlitchDataType;

    variable tmp_MO : std_logic;
    begin
        -------------------------
        --  Functionality Section
        -------------------------
        if ((S_ipd(1) = '1') AND (S_ipd(0) = '1')) then
            tmp_MO := IN3_ipd;
        elsif ((S_ipd(1) = '1') AND (S_ipd(0) = '0')) then
            tmp_MO := IN2_ipd;
        elsif ((S_ipd(1) = '0') AND (S_ipd(0) = '1')) then
            tmp_MO := IN1_ipd;
        else
            tmp_MO := IN0_ipd;
        end if;

        ----------------------
        --  Path Delay Section
        ----------------------
        VitalPathDelay01 (
                        OutSignal => MO,
                        OutSignalName => "MO",
                        OutTemp => tmp_MO,
                        Paths => (  0 => (IN0_ipd'last_event, tpd_IN0_MO, TRUE),
                                    1 => (IN1_ipd'last_event, tpd_IN1_MO, TRUE),
                                    2 => (IN2_ipd'last_event, tpd_IN2_MO, TRUE),
                                    3 => (IN3_ipd'last_event, tpd_IN3_MO, TRUE),
                                    4 => (S_ipd(0)'last_event, tpd_S_MO(0), TRUE),
                                    5 => (S_ipd(1)'last_event, tpd_S_MO(1), TRUE)),
                        GlitchData => MO_GlitchData,
                        Mode => DefGlitchMode,
                        XOn  => XOn,
                        MsgOn => MsgOn );

    end process;
end AltVITAL;

--
--
--  cyclonev_and1 Model
--
--
LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use work.cyclonev_atom_pack.all;

-- entity declaration --
entity cyclonev_and1 is
    generic(
        TimingChecksOn: Boolean := True;
        MsgOn: Boolean := DefGlitchMsgOn;
        XOn: Boolean := DefGlitchXOn;
        InstancePath: STRING := "*";
        tpd_IN1_Y                      :  VitalDelayType01 := DefPropDelay01;
        tipd_IN1                       :  VitalDelayType01 := DefPropDelay01);

    port(
        Y                              :  out   STD_LOGIC;
        IN1                            :  in    STD_LOGIC);
    attribute VITAL_LEVEL0 of cyclonev_and1 : entity is TRUE;
end cyclonev_and1;

-- architecture body --

architecture AltVITAL of cyclonev_and1 is
    attribute VITAL_LEVEL0 of AltVITAL : architecture is TRUE;

    SIGNAL IN1_ipd    : STD_ULOGIC := 'U';

begin

    ---------------------
    --  INPUT PATH DELAYs
    ---------------------
    WireDelay : block
    begin
    VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
    end block;
    --------------------
    --  BEHAVIOR SECTION
    --------------------
    VITALBehavior : process (IN1_ipd)


    -- functionality results
    VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
    ALIAS Y_zd : STD_ULOGIC is Results(1);

    -- output glitch detection variables
    VARIABLE Y_GlitchData    : VitalGlitchDataType;

    begin

        -------------------------
        --  Functionality Section
        -------------------------
        Y_zd := TO_X01(IN1_ipd);

        ----------------------
        --  Path Delay Section
        ----------------------
        VitalPathDelay01 (
            OutSignal => Y,
            OutSignalName => "Y",
            OutTemp => Y_zd,
            Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE)),
            GlitchData => Y_GlitchData,
            Mode => DefGlitchMode,
            XOn  => XOn,
            MsgOn        => MsgOn );

    end process;
end AltVITAL;
---------------------------------------------------------------------
--
-- Entity Name :  cyclonev_ff
-- 
-- Description :  CycloneV FF VHDL simulation model
--  
--
---------------------------------------------------------------------
LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use work.cyclonev_atom_pack.all;
use work.cyclonev_and1;

entity cyclonev_ff is
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
   attribute VITAL_LEVEL0 of cyclonev_ff : entity is TRUE;
end cyclonev_ff;
        
architecture vital_lcell_ff of cyclonev_ff is
   attribute VITAL_LEVEL0 of vital_lcell_ff : architecture is TRUE;
   signal clk_ipd : std_logic;
   signal d_ipd : std_logic;
   signal d_dly : std_logic;
   signal asdata_ipd : std_logic;
   signal asdata_dly : std_logic;
   signal asdata_dly1 : std_logic;
   signal sclr_ipd : std_logic;
   signal sload_ipd : std_logic;
   signal clrn_ipd : std_logic;
   signal aload_ipd : std_logic;
   signal ena_ipd : std_logic;

component cyclonev_and1
    generic (XOn                  : Boolean := DefGlitchXOn;
             MsgOn                : Boolean := DefGlitchMsgOn;
             tpd_IN1_Y            : VitalDelayType01 := DefPropDelay01;
             tipd_IN1             : VitalDelayType01 := DefPropDelay01
            );
        
    port    (Y                    :  out   STD_LOGIC;
             IN1                  :  in    STD_LOGIC
            );
end component;

begin

ddelaybuffer: cyclonev_and1
                   port map(IN1 => d_ipd,
                            Y => d_dly);

asdatadelaybuffer: cyclonev_and1
                   port map(IN1 => asdata_ipd,
                            Y => asdata_dly);

asdatadelaybuffer1: cyclonev_and1
                   port map(IN1 => asdata_dly,
                            Y => asdata_dly1);


    ---------------------
    --  INPUT PATH DELAYs
    ---------------------
    WireDelay : block
    begin
        VitalWireDelay (clk_ipd, clk, tipd_clk);
        VitalWireDelay (d_ipd, d, tipd_d);
        VitalWireDelay (asdata_ipd, asdata, tipd_asdata);
        VitalWireDelay (sclr_ipd, sclr, tipd_sclr);
        VitalWireDelay (sload_ipd, sload, tipd_sload);
        VitalWireDelay (clrn_ipd, clrn, tipd_clrn);
        VitalWireDelay (aload_ipd, aload, tipd_aload);
        VitalWireDelay (ena_ipd, ena, tipd_ena);
    end block;

    VITALtiming : process (clk_ipd, d_dly, asdata_dly1,
                           sclr_ipd, sload_ipd, clrn_ipd, aload_ipd,
                           ena_ipd, devclrn, devpor)
    
    variable Tviol_d_clk : std_ulogic := '0';
    variable Tviol_asdata_clk : std_ulogic := '0';
    variable Tviol_sclr_clk : std_ulogic := '0';
    variable Tviol_sload_clk : std_ulogic := '0';
    variable Tviol_ena_clk : std_ulogic := '0';
    variable TimingData_d_clk : VitalTimingDataType := VitalTimingDataInit;
    variable TimingData_asdata_clk : VitalTimingDataType := VitalTimingDataInit;
    variable TimingData_sclr_clk : VitalTimingDataType := VitalTimingDataInit;
    variable TimingData_sload_clk : VitalTimingDataType := VitalTimingDataInit;
    variable TimingData_ena_clk : VitalTimingDataType := VitalTimingDataInit;
    variable q_VitalGlitchData : VitalGlitchDataType;
    
    variable iq : std_logic := '0';
    variable idata: std_logic := '0';
    
    -- variables for 'X' generation
    variable violation : std_logic := '0';
    
    begin
      
        if (now = 0 ns) then
            if (power_up = "low") then
                iq := '0';
            elsif (power_up = "high") then
                iq := '1';
            end if;
        end if;

        ------------------------
        --  Timing Check Section
        ------------------------
        if (TimingChecksOn) then
        
            VitalSetupHoldCheck (
                Violation       => Tviol_d_clk,
                TimingData      => TimingData_d_clk,
                TestSignal      => d,
                TestSignalName  => "DATAIN",
                RefSignal       => clk_ipd,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_d_clk_noedge_posedge,
                SetupLow        => tsetup_d_clk_noedge_posedge,
                HoldHigh        => thold_d_clk_noedge_posedge,
                HoldLow         => thold_d_clk_noedge_posedge,
                CheckEnabled    => TO_X01((NOT clrn_ipd) OR
                                          (sload_ipd) OR
                                          (sclr_ipd) OR
                                          (NOT devpor) OR
                                          (NOT devclrn) OR
                                          (NOT ena_ipd)) /= '1',
                RefTransition   => '/',
                HeaderMsg       => InstancePath & "/LCELL_FF",
                XOn             => XOnChecks,
                MsgOn           => MsgOnChecks );
            
            VitalSetupHoldCheck (
                Violation       => Tviol_asdata_clk,
                TimingData      => TimingData_asdata_clk,
                TestSignal      => asdata_ipd,
                TestSignalName  => "ASDATA",
                RefSignal       => clk_ipd,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_asdata_clk_noedge_posedge,
                SetupLow        => tsetup_asdata_clk_noedge_posedge,
                HoldHigh        => thold_asdata_clk_noedge_posedge,
                HoldLow         => thold_asdata_clk_noedge_posedge,
                CheckEnabled    => TO_X01((NOT clrn_ipd) OR
                                          (NOT sload_ipd) OR
                                          (NOT devpor) OR
                                          (NOT devclrn) OR
                                          (NOT ena_ipd)) /= '1',
                RefTransition   => '/',
                HeaderMsg       => InstancePath & "/LCELL_FF",
                XOn             => XOnChecks,
                MsgOn           => MsgOnChecks );
    
            VitalSetupHoldCheck (
                Violation       => Tviol_sclr_clk,
                TimingData      => TimingData_sclr_clk,
                TestSignal      => sclr_ipd,
                TestSignalName  => "SCLR",
                RefSignal       => clk_ipd,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_sclr_clk_noedge_posedge,
                SetupLow        => tsetup_sclr_clk_noedge_posedge,
                HoldHigh        => thold_sclr_clk_noedge_posedge,
                HoldLow         => thold_sclr_clk_noedge_posedge,
                CheckEnabled    => TO_X01((NOT clrn_ipd) OR
                                          (NOT devpor) OR
                                          (NOT devclrn) OR
                                          (NOT ena_ipd)) /= '1',
                RefTransition   => '/',
                HeaderMsg       => InstancePath & "/LCELL_FF",
                XOn             => XOnChecks,
                MsgOn           => MsgOnChecks );
            
            VitalSetupHoldCheck (
                Violation       => Tviol_sload_clk,
                TimingData      => TimingData_sload_clk,
                TestSignal      => sload_ipd,
                TestSignalName  => "SLOAD",
                RefSignal       => clk_ipd,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_sload_clk_noedge_posedge,
                SetupLow        => tsetup_sload_clk_noedge_posedge,
                HoldHigh        => thold_sload_clk_noedge_posedge,
                HoldLow         => thold_sload_clk_noedge_posedge,
                CheckEnabled    => TO_X01((NOT clrn_ipd) OR
                                          (NOT devpor) OR
                                          (NOT devclrn) OR
                                          (NOT ena_ipd)) /= '1',
                RefTransition   => '/',
                HeaderMsg       => InstancePath & "/LCELL_FF",
                XOn             => XOnChecks,
                MsgOn           => MsgOnChecks );
        
            VitalSetupHoldCheck (
                Violation       => Tviol_ena_clk,
                TimingData      => TimingData_ena_clk,
                TestSignal      => ena_ipd,
                TestSignalName  => "ENA",
                RefSignal       => clk_ipd,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_ena_clk_noedge_posedge,
                SetupLow        => tsetup_ena_clk_noedge_posedge,
                HoldHigh        => thold_ena_clk_noedge_posedge,
                HoldLow         => thold_ena_clk_noedge_posedge,
                CheckEnabled    => TO_X01((NOT clrn_ipd) OR
                                          (NOT devpor) OR
                                          (NOT devclrn) ) /= '1',
                RefTransition   => '/',
                HeaderMsg       => InstancePath & "/LCELL_FF",
                XOn             => XOnChecks,
                MsgOn           => MsgOnChecks );
    
        end if;
    
        violation := Tviol_d_clk or Tviol_asdata_clk or 
                     Tviol_sclr_clk or Tviol_sload_clk or Tviol_ena_clk;
    
    
        if ((devpor = '0') or (devclrn = '0') or (clrn_ipd = '0'))  then
            iq := '0';
        elsif (aload_ipd = '1') then
            iq := asdata_dly1;
        elsif (violation = 'X' and x_on_violation = "on") then
            iq := 'X';
        elsif clk_ipd'event and clk_ipd = '1' and clk_ipd'last_value = '0' then
            if (ena_ipd = '1') then
                if (sclr_ipd = '1') then
                    iq := '0';
                elsif (sload_ipd = '1') then
                    iq := asdata_dly1;
                else
                    iq := d_dly;
                end if;
            end if;
        end if;
    
        ----------------------
        --  Path Delay Section
        ----------------------
        VitalPathDelay01 (
            OutSignal => q,
            OutSignalName => "Q",
            OutTemp => iq,
            Paths => (0 => (clrn_ipd'last_event, tpd_clrn_q_posedge, TRUE),
                      1 => (aload_ipd'last_event, tpd_aload_q_posedge, TRUE),
                      2 => (asdata_ipd'last_event, tpd_asdata_q, TRUE),
                      3 => (clk_ipd'last_event, tpd_clk_q_posedge, TRUE)),
            GlitchData => q_VitalGlitchData,
            Mode => DefGlitchMode,
            XOn  => XOn,
            MsgOn  => MsgOn );
    
    end process;

end vital_lcell_ff;	

----------------------------------------------------------------------------------
--Module Name:                    cyclonev_pseudo_diff_out                          --
--Description:                    Simulation model for Stratix V Pseudo Differential --
--                                Output Buffer                                  --
----------------------------------------------------------------------------------

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use work.cyclonev_atom_pack.all;

ENTITY cyclonev_pseudo_diff_out IS
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
END cyclonev_pseudo_diff_out;

ARCHITECTURE arch OF cyclonev_pseudo_diff_out IS
        SIGNAL i_ipd                  : std_logic ;
        SIGNAL o_tmp                  :  std_logic ;
        SIGNAL obar_tmp               :  std_logic;
        SIGNAL dtcin_ipd                  : std_logic ;
        SIGNAL dtc_tmp                  :  std_logic ;
        SIGNAL dtcbar_tmp               :  std_logic;
        SIGNAL oein_ipd                  : std_logic ;
        SIGNAL oeout_tmp                  :  std_logic ;
        SIGNAL oebout_tmp               :  std_logic;

BEGIN
    WireDelay : block
    begin
        VitalWireDelay (i_ipd, i, tipd_i);
    end block;

    PROCESS( i_ipd)
        BEGIN
            IF (i_ipd = '0') THEN
                o_tmp <= '0';
                obar_tmp <= '1';
            ELSE
                IF (i_ipd = '1') THEN
                    o_tmp <= '1';
                    obar_tmp <= '0';
                ELSE
                    o_tmp <= i_ipd;
                    obar_tmp <= i_ipd;
                END IF;
            END IF;
        END PROCESS;

        ---------------------
     --  Path Delay Section
     ----------------------
    PROCESS( o_tmp,obar_tmp)
        variable o_VitalGlitchData : VitalGlitchDataType;
        variable obar_VitalGlitchData : VitalGlitchDataType;
        BEGIN
            VitalPathDelay01 (
                              OutSignal => o,
                              OutSignalName => "o",
                              OutTemp => o_tmp,
                              Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE)),
                              GlitchData => o_VitalGlitchData,
                              Mode => DefGlitchMode,
                              XOn  => XOn,
                              MsgOn  => MsgOn
                              );
            VitalPathDelay01 (
                  OutSignal => obar,
                  OutSignalName => "obar",
                  OutTemp => obar_tmp,
                  Paths => (0 => (i_ipd'last_event, tpd_i_obar, TRUE)),
                  GlitchData => obar_VitalGlitchData,
                  Mode => DefGlitchMode,
                  XOn  => XOn,
                  MsgOn  => MsgOn
                  );
        END PROCESS;

-- oe     
         WireDelay_OE : block
    begin
        VitalWireDelay (oein_ipd, oein, tipd_oein);
    end block;

    PROCESS( oein_ipd)
        BEGIN
            IF (oein_ipd = '0') THEN
                oeout_tmp <= '0';
                oebout_tmp <= '0';
            ELSE
                IF (oein_ipd = '1') THEN
                    oeout_tmp <= '1';
                    oebout_tmp <= '1';
                ELSE
                    oeout_tmp <= oein_ipd;
                    oebout_tmp <= oein_ipd;
                END IF;
            END IF;
        END PROCESS;

        ---------------------
     --  Path Delay Section
     ----------------------
    PROCESS( oeout_tmp,oebout_tmp)
        variable o_VitalGlitchData : VitalGlitchDataType;
        variable obar_VitalGlitchData : VitalGlitchDataType;
        BEGIN
            VitalPathDelay01 (
                              OutSignal => oeout,
                              OutSignalName => "oeout",
                              OutTemp => oeout_tmp,
                              Paths => (0 => (oein_ipd'last_event, tpd_oein_oeout, TRUE)),
                              GlitchData => o_VitalGlitchData,
                              Mode => DefGlitchMode,
                              XOn  => XOn,
                              MsgOn  => MsgOn
                              );
            VitalPathDelay01 (
                  OutSignal => oebout,
                  OutSignalName => "oebout",
                  OutTemp => oebout_tmp,
                  Paths => (0 => (oein_ipd'last_event, tpd_oein_oebout, TRUE)),
                  GlitchData => obar_VitalGlitchData,
                  Mode => DefGlitchMode,
                  XOn  => XOn,
                  MsgOn  => MsgOn
                  );
        END PROCESS;



-- dtc
        
         WireDelay_DTC : block
    begin
        VitalWireDelay (dtcin_ipd, dtcin, tipd_dtcin);
    end block;

    PROCESS( dtcin_ipd)
        BEGIN
            IF (dtcin_ipd = '0') THEN
                dtc_tmp <= '0';
                dtcbar_tmp <= '0';
            ELSE
                IF (dtcin_ipd = '1') THEN
                    dtc_tmp <= '1';
                    dtcbar_tmp <= '1';
                ELSE
                    dtc_tmp <= dtcin_ipd;
                    dtcbar_tmp <= dtcin_ipd;
                END IF;
            END IF;
        END PROCESS;

        ---------------------
     --  Path Delay Section
     ----------------------
    PROCESS( dtc_tmp,dtcbar_tmp)
        variable o_VitalGlitchData : VitalGlitchDataType;
        variable dtcbar_VitalGlitchData : VitalGlitchDataType;
        BEGIN
            VitalPathDelay01 (
                              OutSignal => dtc,
                              OutSignalName => "dtc",
                              OutTemp => dtc_tmp,
                              Paths => (0 => (dtcin_ipd'last_event, tpd_dtcin_dtc, TRUE)),
                              GlitchData => o_VitalGlitchData,
                              Mode => DefGlitchMode,
                              XOn  => XOn,
                              MsgOn  => MsgOn
                              );
            VitalPathDelay01 (
                  OutSignal => dtcbar,
                  OutSignalName => "dtcbar",
                  OutTemp => dtcbar_tmp,
                  Paths => (0 => (dtcin_ipd'last_event, tpd_dtcin_dtcbar, TRUE)),
                  GlitchData => dtcbar_VitalGlitchData,
                  Mode => DefGlitchMode,
                  XOn  => XOn,
                  MsgOn  => MsgOn
                  );
        END PROCESS;
END arch;
---------------------------------------------------------------------
--
-- Entity Name :  cyclonev_lcell_comb
-- 
-- Description :  CYCLONEV LCELL_COMB VHDL simulation model
--  
--
---------------------------------------------------------------------

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use work.cyclonev_atom_pack.all;

entity cyclonev_lcell_comb is
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
   attribute VITAL_LEVEL0 of cyclonev_lcell_comb : entity is TRUE;
end cyclonev_lcell_comb;
        
architecture vital_lcell_comb of cyclonev_lcell_comb is
    attribute VITAL_LEVEL0 of vital_lcell_comb : architecture is TRUE;
    signal dataa_ipd : std_logic;
    signal datab_ipd : std_logic;
    signal datac_ipd : std_logic;
    signal datad_ipd : std_logic;
    signal datae_ipd : std_logic;
    signal dataf_ipd : std_logic;
    signal datag_ipd : std_logic;
    signal cin_ipd : std_logic;
    signal sharein_ipd : std_logic;
    signal f2_input3 : std_logic;
    -- sub masks
    signal f0_mask : std_logic_vector(15 downto 0);
    signal f1_mask : std_logic_vector(15 downto 0);
    signal f2_mask : std_logic_vector(15 downto 0);
    signal f3_mask : std_logic_vector(15 downto 0);
begin

    ---------------------
    --  INPUT PATH DELAYs
    ---------------------
    WireDelay : block
    begin
        VitalWireDelay (dataa_ipd, dataa, tipd_dataa);
        VitalWireDelay (datab_ipd, datab, tipd_datab);
        VitalWireDelay (datac_ipd, datac, tipd_datac);
        VitalWireDelay (datad_ipd, datad, tipd_datad);
        VitalWireDelay (datae_ipd, datae, tipd_datae);
        VitalWireDelay (dataf_ipd, dataf, tipd_dataf);
        VitalWireDelay (datag_ipd, datag, tipd_datag);
        VitalWireDelay (cin_ipd, cin, tipd_cin);
        VitalWireDelay (sharein_ipd, sharein, tipd_sharein);
    end block;

    f0_mask <= lut_mask(15 downto 0);
    f1_mask <= lut_mask(31 downto 16);
    f2_mask <= lut_mask(47 downto 32);
    f3_mask <= lut_mask(63 downto 48);

    f2_input3 <= datag_ipd WHEN (extended_lut = "on") ELSE datac_ipd;

VITALtiming : process(dataa_ipd, datab_ipd, datac_ipd, datad_ipd,
                      datae_ipd, dataf_ipd, f2_input3, cin_ipd, 
                      sharein_ipd)

variable combout_VitalGlitchData : VitalGlitchDataType;
variable sumout_VitalGlitchData : VitalGlitchDataType;
variable cout_VitalGlitchData : VitalGlitchDataType;
variable shareout_VitalGlitchData : VitalGlitchDataType;
-- sub lut outputs
variable f0_out : std_logic;
variable f1_out : std_logic;
variable f2_out : std_logic;
variable f3_out : std_logic;
-- muxed output
variable g0_out : std_logic;
variable g1_out : std_logic;
-- internal variables
variable f2_f : std_logic;
variable adder_input2 : std_logic;
-- output variables
variable combout_tmp : std_logic;
variable sumout_tmp : std_logic;
variable cout_tmp : std_logic;
-- temp variable for NCVHDL
variable lut_mask_var : std_logic_vector(63 downto 0) := (OTHERS => '1');

begin
  
    lut_mask_var := lut_mask;

    ------------------------
    --  Timing Check Section
    ------------------------

    f0_out := VitalMUX(data => f0_mask,
                       dselect => (datad_ipd,
                                   datac_ipd,
                                   datab_ipd,
                                   dataa_ipd));
    f1_out := VitalMUX(data => f1_mask,
                       dselect => (datad_ipd,
                                   f2_input3,
                                   datab_ipd,
                                   dataa_ipd));
    f2_out := VitalMUX(data => f2_mask,
                       dselect => (datad_ipd,
                                   datac_ipd,
                                   datab_ipd,
                                   dataa_ipd));
    f3_out := VitalMUX(data => f3_mask,
                       dselect => (datad_ipd,
                                   f2_input3,
                                   datab_ipd,
                                   dataa_ipd));
    
    -- combout 
    if (extended_lut = "on") then
        if (datae_ipd = '0') then
            g0_out := f0_out;
            g1_out := f2_out;
        elsif (datae_ipd = '1') then
            g0_out := f1_out;
            g1_out := f3_out;
        else
            g0_out := 'X';
            g1_out := 'X';
        end if;

        if (dataf_ipd = '0') then
            combout_tmp := g0_out;
        elsif ((dataf_ipd = '1')  or (g0_out = g1_out))then
            combout_tmp := g1_out;
        else
            combout_tmp := 'X';
        end if;
    else
        combout_tmp := VitalMUX(data => lut_mask_var,
                                dselect => (dataf_ipd,
                                            datae_ipd,
                                            datad_ipd,
                                            datac_ipd,
                                            datab_ipd,
                                            dataa_ipd));
    end if;

    -- sumout and cout
    f2_f := VitalMUX(data => f2_mask,
                     dselect => (dataf_ipd,
                                 datac_ipd,
                                 datab_ipd,
                                 dataa_ipd));

    if (shared_arith = "on") then
        adder_input2 := sharein_ipd;
    else
        adder_input2 := NOT f2_f;
    end if;

    sumout_tmp := cin_ipd XOR f0_out XOR adder_input2;
    cout_tmp := (cin_ipd AND f0_out) OR (cin_ipd AND adder_input2) OR
                (f0_out AND adder_input2);

    ----------------------
    --  Path Delay Section
    ----------------------

    VitalPathDelay01 (
        OutSignal => combout,
        OutSignalName => "COMBOUT",
        OutTemp => combout_tmp,
        Paths => (0 => (dataa_ipd'last_event, tpd_dataa_combout, TRUE),
                  1 => (datab_ipd'last_event, tpd_datab_combout, TRUE),
                  2 => (datac_ipd'last_event, tpd_datac_combout, TRUE),
                  3 => (datad_ipd'last_event, tpd_datad_combout, TRUE),
                  4 => (datae_ipd'last_event, tpd_datae_combout, TRUE),
                  5 => (dataf_ipd'last_event, tpd_dataf_combout, TRUE),
                  6 => (datag_ipd'last_event, tpd_datag_combout, TRUE)),
        GlitchData => combout_VitalGlitchData,
        Mode => DefGlitchMode,
        XOn  => XOn,
        MsgOn => MsgOn );

    VitalPathDelay01 (
        OutSignal => sumout,
        OutSignalName => "SUMOUT",
        OutTemp => sumout_tmp,
        Paths => (0 => (dataa_ipd'last_event, tpd_dataa_sumout, TRUE),
                  1 => (datab_ipd'last_event, tpd_datab_sumout, TRUE),
                  2 => (datac_ipd'last_event, tpd_datac_sumout, TRUE),
                  3 => (datad_ipd'last_event, tpd_datad_sumout, TRUE),
                  4 => (dataf_ipd'last_event, tpd_dataf_sumout, TRUE),
                  5 => (cin_ipd'last_event, tpd_cin_sumout, TRUE),
                  6 => (sharein_ipd'last_event, tpd_sharein_sumout, TRUE)),
        GlitchData => sumout_VitalGlitchData,
        Mode => DefGlitchMode,
        XOn  => XOn,
        MsgOn => MsgOn );

    VitalPathDelay01 (
        OutSignal => cout,
        OutSignalName => "COUT",
        OutTemp => cout_tmp,
        Paths => (0 => (dataa_ipd'last_event, tpd_dataa_cout, TRUE),
                  1 => (datab_ipd'last_event, tpd_datab_cout, TRUE),
                  2 => (datac_ipd'last_event, tpd_datac_cout, TRUE),
                  3 => (datad_ipd'last_event, tpd_datad_cout, TRUE),
                  4 => (dataf_ipd'last_event, tpd_dataf_cout, TRUE),
                  5 => (cin_ipd'last_event, tpd_cin_cout, TRUE),
                  6 => (sharein_ipd'last_event, tpd_sharein_cout, TRUE)),
        GlitchData => cout_VitalGlitchData,
        Mode => DefGlitchMode,
        XOn  => XOn,
        MsgOn => MsgOn );

    VitalPathDelay01 (
        OutSignal => shareout,
        OutSignalName => "SHAREOUT",
        OutTemp => f2_out,
        Paths => (0 => (dataa_ipd'last_event, tpd_dataa_shareout, TRUE),
                  1 => (datab_ipd'last_event, tpd_datab_shareout, TRUE),
                  2 => (datac_ipd'last_event, tpd_datac_shareout, TRUE),
                  3 => (datad_ipd'last_event, tpd_datad_shareout, TRUE)),
        GlitchData => shareout_VitalGlitchData,
        Mode => DefGlitchMode,
        XOn  => XOn,
        MsgOn => MsgOn );

end process;

end vital_lcell_comb;	


---------------------------------------------------------------------
--
-- Entity Name :  cyclonev_routing_wire
--
-- Description :  CycloneV Routing Wire VHDL simulation model
--
--
---------------------------------------------------------------------

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use work.cyclonev_atom_pack.all;

ENTITY cyclonev_routing_wire is
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
   attribute VITAL_LEVEL0 of cyclonev_routing_wire : entity is TRUE;
end cyclonev_routing_wire;

ARCHITECTURE behave of cyclonev_routing_wire is
attribute VITAL_LEVEL0 of behave : architecture is TRUE;
signal datain_ipd : std_logic;
signal datainglitch_inert : std_logic;
begin
    ---------------------
    --  INPUT PATH DELAYs
    ---------------------
    WireDelay : block
    begin
        VitalWireDelay (datain_ipd, datain, tipd_datain);
    end block;

    VITAL: process(datain_ipd, datainglitch_inert)
    variable datain_inert_VitalGlitchData : VitalGlitchDataType;
    variable dataout_VitalGlitchData : VitalGlitchDataType;

    begin
        ----------------------
        --  Path Delay Section
        ----------------------
        VitalPathDelay01 (
            OutSignal => datainglitch_inert,
            OutSignalName => "datainglitch_inert",
            OutTemp => datain_ipd,
            Paths => (1 => (datain_ipd'last_event, tpd_datainglitch_dataout, TRUE)),
            GlitchData => datain_inert_VitalGlitchData,
            Mode => VitalInertial,
            XOn  => XOn,
            MsgOn  => MsgOn );
    
        VitalPathDelay01 (
            OutSignal => dataout,
            OutSignalName => "dataout",
            OutTemp => datainglitch_inert,
            Paths => (1 => (datain_ipd'last_event, tpd_datain_dataout, TRUE)),
            GlitchData => dataout_VitalGlitchData,
            Mode => DefGlitchMode,
            XOn  => XOn,
            MsgOn  => MsgOn );

    end process;

end behave;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY altera_lnsim;
use altera_lnsim.altera_lnsim_components.all;
ENTITY cyclonev_ram_block IS
    GENERIC (
        -- -------- GLOBAL PARAMETERS ---------
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
    -- -------- PORT DECLARATIONS ---------
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

END cyclonev_ram_block;

ARCHITECTURE block_arch OF cyclonev_ram_block IS

BEGIN

inst : generic_m10k 
    generic map (
        operation_mode                 =>        operation_mode,
        mixed_port_feed_through_mode   =>        mixed_port_feed_through_mode,
        ram_block_type                 =>        ram_block_type,
        logical_ram_name               =>        logical_ram_name,
        init_file                      =>        init_file,
        init_file_layout               =>        init_file_layout,
        ecc_pipeline_stage_enabled     =>        ecc_pipeline_stage_enabled,
        enable_ecc                     =>        enable_ecc,
        width_eccstatus                =>        width_eccstatus,
        data_interleave_width_in_bits  =>        data_interleave_width_in_bits,
        data_interleave_offset_in_bits =>        data_interleave_offset_in_bits,
        port_a_logical_ram_depth       =>        port_a_logical_ram_depth,
        port_a_logical_ram_width       =>        port_a_logical_ram_width,
        port_a_first_address           =>        port_a_first_address,
        port_a_last_address            =>        port_a_last_address,
        port_a_first_bit_number        =>        port_a_first_bit_number,
        port_a_data_out_clear          =>        port_a_data_out_clear,
        port_a_data_out_clock          =>        port_a_data_out_clock,
        port_a_data_width              =>        port_a_data_width,
        port_a_address_width           =>        port_a_address_width,
        port_a_byte_enable_mask_width  =>        port_a_byte_enable_mask_width,
        port_b_logical_ram_depth       =>        port_b_logical_ram_depth,
        port_b_logical_ram_width       =>        port_b_logical_ram_width,
        port_b_first_address           =>        port_b_first_address,
        port_b_last_address            =>        port_b_last_address,
        port_b_first_bit_number        =>        port_b_first_bit_number,
        port_b_address_clear           =>        port_b_address_clear,
        port_b_data_out_clear          =>        port_b_data_out_clear,
        port_b_data_in_clock           =>        port_b_data_in_clock,
        port_b_address_clock           =>        port_b_address_clock,
        port_b_write_enable_clock      =>        port_b_write_enable_clock,
        port_b_read_enable_clock       =>        port_b_read_enable_clock,
        port_b_byte_enable_clock       =>        port_b_byte_enable_clock,
        port_b_data_out_clock          =>        port_b_data_out_clock,
        port_b_data_width              =>        port_b_data_width,
        port_b_address_width           =>        port_b_address_width,
        port_b_byte_enable_mask_width  =>        port_b_byte_enable_mask_width,
        port_a_read_during_write_mode  =>        port_a_read_during_write_mode,
        port_b_read_during_write_mode  =>        port_b_read_during_write_mode,
        power_up_uninitialized         =>        power_up_uninitialized,
        lpm_type                       =>        lpm_type,
        lpm_hint                       =>        lpm_hint,
        connectivity_checking          =>        connectivity_checking,
        mem_init0                      =>        mem_init0,
        mem_init1                      =>        mem_init1,
        mem_init2                      =>        mem_init2,
        mem_init3                      =>        mem_init3,
        mem_init4                      =>        mem_init4,
        port_a_byte_size               =>        port_a_byte_size,
        port_b_byte_size               =>        port_b_byte_size,
        clk0_input_clock_enable        =>        clk0_input_clock_enable,
        clk0_core_clock_enable         =>        clk0_core_clock_enable,
        clk0_output_clock_enable       =>        clk0_output_clock_enable,
        clk1_input_clock_enable        =>        clk1_input_clock_enable,
        clk1_core_clock_enable         =>        clk1_core_clock_enable,
        clk1_output_clock_enable       =>        clk1_output_clock_enable,
        bist_ena                       =>        bist_ena,
        port_a_address_clear           =>        port_a_address_clear,
        port_a_data_in_clock           =>        port_a_data_in_clock,
        port_a_address_clock           =>        port_a_address_clock,
        port_a_write_enable_clock      =>        port_a_write_enable_clock,
        port_a_byte_enable_clock       =>        port_a_byte_enable_clock,
        port_a_read_enable_clock       =>        port_a_read_enable_clock
    )
    port map (
        portadatain     =>        portadatain    ,
        portaaddr       =>        portaaddr      ,
        portawe         =>        portawe        ,
        portare         =>        portare        ,
        portbdatain     =>        portbdatain    ,
        portbaddr       =>        portbaddr      ,
        portbwe         =>        portbwe        ,
        portbre         =>        portbre        ,
        clk0            =>        clk0           ,
        clk1            =>        clk1           ,
        ena0            =>        ena0           ,
        ena1            =>        ena1           ,
        ena2            =>        ena2           ,
        ena3            =>        ena3           ,
        clr0            =>        clr0           ,
        clr1            =>        clr1           ,
        nerror          =>        nerror         ,
        portabyteenamasks =>        portabyteenamasks,
        portbbyteenamasks =>        portbbyteenamasks,
        portaaddrstall  =>        portaaddrstall ,
        portbaddrstall  =>        portbaddrstall ,
        devclrn         =>        devclrn        ,
        devpor          =>        devpor         ,
        eccstatus       =>        eccstatus      ,
        portadataout    =>        portadataout   ,
        portbdataout    =>        portbdataout   ,
        dftout          =>        dftout
    );

END block_arch;


----------------------------------------------------------------------------
-- Entity Name     : cyclonev_mlab_cell
-- Description     : LUTRAM VHDL Simulation Model
----------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE work.cyclonev_atom_pack.all;

LIBRARY altera_lnsim;
use altera_lnsim.altera_lnsim_components.all;

ENTITY cyclonev_mlab_cell IS
   GENERIC (
      -- -------- GLOBAL PARAMETERS ---------      
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
      -- -------- PORT DECLARATIONS ---------
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
END cyclonev_mlab_cell;

ARCHITECTURE trans OF cyclonev_mlab_cell IS

BEGIN

inst : generic_28nm_lc_mlab_cell_impl
    generic map (
      logical_ram_name              => logical_ram_name              ,
      logical_ram_depth             => logical_ram_depth             ,
      logical_ram_width             => logical_ram_width             ,
      first_address                 => first_address                 ,
      last_address                  => last_address                  ,
      first_bit_number              => first_bit_number              ,
      init_file                     => init_file                     ,
      data_width                    => data_width                    ,
      address_width                 => address_width                 ,
      byte_enable_mask_width        => byte_enable_mask_width        ,
      byte_size                     => byte_size                     ,
      port_b_data_out_clock         => port_b_data_out_clock         ,
      port_b_data_out_clear         => port_b_data_out_clear         ,
      lpm_type                      => lpm_type                      ,
      lpm_hint                      => lpm_hint                      ,
      mem_init0                     => mem_init0                     ,
      mixed_port_feed_through_mode  => mixed_port_feed_through_mode  
   )
   port map (
      portadatain                   => portadatain                   ,
      portaaddr                     => portaaddr                     ,
      portabyteenamasks             => portabyteenamasks             ,
      portbaddr                     => portbaddr                     ,
      clk0                          => clk0                          ,
      clk1                          => clk1                          ,
      ena0                          => ena0                          ,
      ena1                          => ena1                          ,
      ena2                          => ena2                          ,
      clr                           => clr                           ,
      devclrn                       => devclrn                       ,
      devpor                        => devpor                        ,
      portbdataout                  => portbdataout                  
   );

          
END trans;
---------------------------------------------------------------------
--
-- Entity Name :  cyclonev_io_ibuf
-- 
-- Description :  CycloneV IO Ibuf VHDL simulation model
--  
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use work.cyclonev_atom_pack.all;

ENTITY cyclonev_io_ibuf IS
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
END cyclonev_io_ibuf;

ARCHITECTURE arch OF cyclonev_io_ibuf IS
    SIGNAL i_ipd    : std_logic := '0';   
    SIGNAL ibar_ipd : std_logic := '0';     
    SIGNAL o_tmp    :  std_logic; 
    SIGNAL out_tmp    :  std_logic;
    SIGNAL prev_value : std_logic := '0'; 
BEGIN
    WireDelay : block
        begin                                                             
            VitalWireDelay (i_ipd, i, tipd_i);          
            VitalWireDelay (ibar_ipd, ibar, tipd_ibar);
        end block;                                                        

    PROCESS(i_ipd, ibar_ipd)
        BEGIN                                             
            IF (differential_mode = "false") THEN         
                IF (i_ipd = '1') THEN                         
                    o_tmp <= '1'; 
                    prev_value <= '1';                            
                ELSIF (i_ipd = '0') THEN                                     
                    o_tmp <= '0';                               
                    prev_value <= '0';
                ELSE
                    o_tmp <= i_ipd;
                END IF;
            ELSE                                          
                IF (( i_ipd =  '0' ) and (ibar_ipd = '1')) then       
                        o_tmp <= '0';                             
                ELSIF (( i_ipd =  '1' ) and (ibar_ipd = '0')) then
                    o_tmp <= '1';                             
                ELSIF((( i_ipd =  '1' ) and (ibar_ipd = '1'))  or (( i_ipd =  '0' ) and (ibar_ipd = '0')))then    
                    o_tmp <= 'X';
                ELSE                                   
                    o_tmp <= 'X';                             
                END IF;                                   
            END IF;        
        END PROCESS;
                
    out_tmp <= prev_value when (bus_hold = "true") else 
                'Z' when((o_tmp = 'Z') AND (simulate_z_as = "Z")) else
                'X' when((o_tmp = 'Z') AND (simulate_z_as = "X")) else
                '1' when((o_tmp = 'Z') AND (simulate_z_as = "vcc")) else
                '0' when((o_tmp = 'Z') AND (simulate_z_as = "gnd")) else
                o_tmp;    
             ----------------------
             --  Path Delay Section
             ----------------------
    PROCESS( out_tmp)
        variable output_VitalGlitchData : VitalGlitchDataType;
    BEGIN                                                                             
        VitalPathDelay01 (                                                            
                           OutSignal => o,                                                 
                           OutSignalName => "o",                                           
                           OutTemp => out_tmp,                                               
                           Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),             
                                     1 => (ibar_ipd'last_event, tpd_ibar_o, TRUE)),   
                           GlitchData => output_VitalGlitchData,                                
                           Mode => DefGlitchMode,                                                
                           XOn  => XOn,                                                          
                           MsgOn  => MsgOn                                            
                         );                                                           
    END PROCESS;
 END arch;
 
 
 
---------------------------------------------------------------------
--
-- Entity Name :  cyclonev_io_obuf
-- 
-- Description :  CycloneV IO Obuf VHDL simulation model
--  
--
---------------------------------------------------------------------

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use work.cyclonev_atom_pack.all;

ENTITY cyclonev_io_obuf IS
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
END cyclonev_io_obuf;

ARCHITECTURE arch OF cyclonev_io_obuf IS
    --INTERNAL Signals
    SIGNAL i_ipd                    : std_logic := '0'; 
    SIGNAL oe_ipd                   : std_logic := '0'; 
    SIGNAL dynamicterminationcontrol_ipd : std_logic := '0';   
    SIGNAL out_tmp                  :  std_logic := 'Z';   
    SIGNAL out_tmp_bar              :  std_logic;   
    SIGNAL prev_value               :  std_logic := '0';     
    SIGNAL o_tmp                    :  std_logic;    
    SIGNAL obar_tmp                 :  std_logic;  
    SIGNAL o_tmp1                    :  std_logic;    
    SIGNAL obar_tmp1                 :  std_logic;  
    SIGNAL seriesterminationcontrol_ipd    : std_logic_vector(15 DOWNTO 0) := (others => '0'); 
    SIGNAL parallelterminationcontrol_ipd    : std_logic_vector(15 DOWNTO 0) := (others => '0');   
 
BEGIN

WireDelay : block
    begin                                                             
        VitalWireDelay (i_ipd, i, tipd_i);          
        VitalWireDelay (oe_ipd, oe, tipd_oe); 
        VitalWireDelay (dynamicterminationcontrol_ipd, dynamicterminationcontrol, tipd_dynamicterminationcontrol);   
        g1 :for i in seriesterminationcontrol'range generate
            VitalWireDelay (seriesterminationcontrol_ipd(i), seriesterminationcontrol(i), tipd_seriesterminationcontrol(i));
        end generate;
        g2 :for i in parallelterminationcontrol'range generate                                                                         
            VitalWireDelay (parallelterminationcontrol_ipd(i), parallelterminationcontrol(i), tipd_parallelterminationcontrol(i));     
        end generate;                                                                                                                  


    end block;                                                                              
    PROCESS( i_ipd, oe_ipd)
        BEGIN                                              
            IF (oe_ipd = '1') THEN                      
                IF (open_drain_output = "true") THEN
                    IF (i_ipd = '0') THEN               
                        out_tmp <= '0';             
                        out_tmp_bar <= '1';         
                        prev_value <= '0';          
                    ELSE                            
                        out_tmp <= 'Z';             
                        out_tmp_bar <= 'Z';         
                    END IF;                         
                ELSE                                
                    IF (i_ipd = '0') THEN               
                        out_tmp <= '0';             
                        out_tmp_bar <= '1';         
                        prev_value <= '0';          
                    ELSE                            
                        IF (i_ipd = '1') THEN           
                            out_tmp <= '1';         
                            out_tmp_bar <= '0';     
                            prev_value <= '1';      
                        ELSE                        
                            out_tmp <= i_ipd;           
                            out_tmp_bar <= i_ipd;       
                        END IF;                     
                    END IF;                         
                END IF;                             
            ELSE                                    
                IF (oe_ipd = '0') THEN                  
                    out_tmp <= 'Z';                 
                    out_tmp_bar <= 'Z';             
                ELSE                                
                    out_tmp <= 'X';                 
                    out_tmp_bar <= 'X';             
                END IF;                             
            END IF;                                     
    END PROCESS;
    o_tmp1 <= prev_value WHEN (bus_hold = "true") ELSE out_tmp;
    obar_tmp1 <= NOT prev_value WHEN (bus_hold = "true") ELSE out_tmp_bar;  
    o_tmp <= 'X' when (( oe_ipd = '1') and (dynamicterminationcontrol = '1')) else o_tmp1 WHEN (devoe = '1') ELSE 'Z'; 
    obar_tmp <= 'X' when (( oe_ipd = '1') and (dynamicterminationcontrol = '1')) else obar_tmp1 WHEN (devoe = '1') ELSE 'Z';  
         ---------------------
     --  Path Delay Section
     ----------------------
    PROCESS( o_tmp,obar_tmp)
        variable o_VitalGlitchData : VitalGlitchDataType;
        variable obar_VitalGlitchData : VitalGlitchDataType;
        BEGIN
            VitalPathDelay01 (                                                                  
                              OutSignal => o,                                                  
                              OutSignalName => "o",                                            
                              OutTemp => o_tmp,                                                
                              Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),                
                                        1 => (oe_ipd'last_event, tpd_oe_o, TRUE)),   
                              GlitchData => o_VitalGlitchData,                           
                              Mode => DefGlitchMode,                                           
                              XOn  => XOn,                                                     
                              MsgOn  => MsgOn                                                  
                              ); 
            VitalPathDelay01 (                                                               
                  OutSignal => obar,                                                
                  OutSignalName => "obar",                                          
                  OutTemp => obar_tmp,                                              
                  Paths => (0 => (i_ipd'last_event, tpd_i_obar, TRUE),              
                            1 => (oe_ipd'last_event, tpd_oe_obar, TRUE)),   
                  GlitchData => obar_VitalGlitchData,                         
                  Mode => DefGlitchMode,                                         
                  XOn  => XOn,                                                   
                  MsgOn  => MsgOn                                                
                  ); 
        END PROCESS;                                                                                                                                              
END arch;

-----------------------------------------------------------------------                                       
--                                                                                                            
-- Entity Name :  cyclonev_ddio_in                                                                               
--                                                                                                            
-- Description :  CycloneV DDIO_IN VHDL simulation model                                                         
--                                                                                                            
--                                                                                                            
---------------------------------------------------------------------                                         
LIBRARY IEEE;                                                                                                 
LIBRARY altera;                                                                                               
use IEEE.std_logic_1164.all;                                                                                  
use IEEE.std_logic_arith.all;                                                                                 
use IEEE.VITAL_Timing.all;                                                                                    
use IEEE.VITAL_Primitives.all;                                                                                
use altera.all;                                                                  
use work.cyclonev_atom_pack.all;                                                                              
                                                                                                           
                                                                                                              
ENTITY cyclonev_ddio_in IS                                                                                       
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
END cyclonev_ddio_in;                                                                                            
                                                                                                              
ARCHITECTURE arch OF cyclonev_ddio_in IS                                                                         
                                                                                                              
component dffeas                                                                                              
    generic (                                                                                                 
             power_up : string := "DONT_CARE";                                                                
             is_wysiwyg : string := "false";                                                                  
             x_on_violation : string := "on";                                                                 
             lpm_type : string := "DFFEAS";                                                                   
             tsetup_d_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                                
             tsetup_asdata_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                           
             tsetup_sclr_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                             
             tsetup_sload_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                            
             tsetup_ena_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                              
             thold_d_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                                 
             thold_asdata_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                            
             thold_sclr_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                              
             thold_sload_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                             
             thold_ena_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;                               
             tpd_clk_q_posedge : VitalDelayType01 := DefPropDelay01;                                          
             tpd_clrn_q_negedge : VitalDelayType01 := DefPropDelay01;                                       
             tpd_prn_q_negedge : VitalDelayType01 := DefPropDelay01;                                         
             tpd_aload_q_posedge : VitalDelayType01 := DefPropDelay01;                                        
             tpd_asdata_q: VitalDelayType01 := DefPropDelay01;                                                
             tipd_clk : VitalDelayType01 := DefPropDelay01;                                                   
             tipd_d : VitalDelayType01 := DefPropDelay01;                                                     
             tipd_asdata : VitalDelayType01 := DefPropDelay01;                                                
             tipd_sclr : VitalDelayType01 := DefPropDelay01;                                                  
             tipd_sload : VitalDelayType01 := DefPropDelay01;                                                 
             tipd_clrn : VitalDelayType01 := DefPropDelay01;                                                  
             tipd_prn : VitalDelayType01 := DefPropDelay01;                                                   
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
           ena : in std_logic := '1';                                                                         
           clrn : in std_logic := '1';                                                                        
           prn : in std_logic := '1';                                                                         
           aload : in std_logic := '0';                                                                       
           asdata : in std_logic := '1';                                                                      
           sclr : in std_logic := '0';                                                                        
           sload : in std_logic := '0';                                                                       
           devclrn : in std_logic := '1';                                                                     
           devpor : in std_logic := '1';                                                                      
           q : out std_logic                                                                                  
         );                                                                                                   
end component;                                                                                                
                                                                                                              
    --Internal Signals                                                                                        
    SIGNAL datain_ipd               : std_logic := '0';                                                       
    SIGNAL clk_ipd                  : std_logic := '0';                                                       
    SIGNAL clkn_ipd                 : std_logic := '0';                                                       
    SIGNAL ena_ipd                  : std_logic := '0';                                                       
    SIGNAL areset_ipd               : std_logic := '0';                                                       
    SIGNAL sreset_ipd               : std_logic := '0';                                                       
    SIGNAL ddioreg_aclr             :  std_logic;                                                             
    SIGNAL ddioreg_prn              :  std_logic;                                                             
    SIGNAL ddioreg_adatasdata       :  std_logic;                                                             
    SIGNAL ddioreg_sclr             :  std_logic;                                                             
    SIGNAL ddioreg_sload            :  std_logic;                                                             
    SIGNAL ddioreg_clk              :  std_logic;                                                             
    SIGNAL dfflo_tmp                :  std_logic;                                                             
    SIGNAL regout_tmp_hi            :  std_logic;                                                             
    SIGNAL regout_tmp_lo            :  std_logic;                                                             
    SIGNAL regouthi_tmp            :  std_logic;                                                              
    SIGNAL regoutlo_tmp            :  std_logic;                                                              
                                                                                                              
                                                                                                              
BEGIN                                                                                                         
                                                                                                              
WireDelay : block                                                                                             
    begin                                                                                                     
        VitalWireDelay (datain_ipd, datain, tipd_datain);                                                    
        VitalWireDelay (clk_ipd, clk, tipd_clk);                                                              
        VitalWireDelay (clkn_ipd, clkn, tipd_clkn);                                                           
        VitalWireDelay (ena_ipd, ena, tipd_ena);                                                              
        VitalWireDelay (areset_ipd, areset, tipd_areset);                                                     
        VitalWireDelay (sreset_ipd, sreset, tipd_sreset);                                                     
    end block;                                                                                                
                                                                                                              
                                                                                                           
    ddioreg_clk <= NOT clk_ipd WHEN (use_clkn = "false") ELSE clkn_ipd;                                       
                                                                                                              
    --Decode the control values for the DDIO registers                                                     
    PROCESS                                                                                                
        BEGIN                                                                                              
            WAIT UNTIL areset_ipd'EVENT OR sreset_ipd'EVENT;                                               
                IF (async_mode = "clear") THEN                                                             
                    ddioreg_aclr <= NOT areset_ipd;                                                        
                    ddioreg_prn <= '1';                                                                    
                ELSIF (async_mode = "preset") THEN                                                        
                    ddioreg_aclr <= '1';                                                                   
                    ddioreg_prn <= NOT areset_ipd;                                                         
                ELSE                                                                                       
                    ddioreg_aclr <= '1';                                                                   
                    ddioreg_prn <= '1';                                                                    
                END IF;                                                                                    
                                                                                                           
                IF (sync_mode = "clear") THEN                                                              
                    ddioreg_adatasdata <= '0';                                                             
                    ddioreg_sclr <= sreset_ipd;                                                            
                    ddioreg_sload <= '0';                                                                  
                ELSIF (sync_mode = "preset") THEN                                                        
                    ddioreg_adatasdata <= '1';                                                             
                    ddioreg_sclr <= '0';                                                                   
                    ddioreg_sload <= sreset_ipd;                                                             
                ELSE                                                                                                                
                    ddioreg_adatasdata <= '0';                                                             
                    ddioreg_sclr <= '0';                                                                   
                    ddioreg_sload <= '0';                                                                                                                                               
                END IF;                                                                                    
    END PROCESS;                                                                                              
                                                                                                              
       --DDIO High Register                                                                                   
    ddioreg_hi : dffeas                                                                                       
        GENERIC MAP (                                                                                         
                      power_up => power_up                                                                    
                    )                                                                                         
        PORT MAP (                                                                                            
                  d => datain_ipd,                                                                            
                  clk => clk_ipd,                                                                             
                  clrn => ddioreg_aclr,                                                                       
                  prn  => ddioreg_prn,                                                                     
                  sclr => ddioreg_sclr,                                                                       
                  sload => ddioreg_sload,                                                                     
                  asdata => ddioreg_adatasdata,                                                               
                  ena => ena_ipd,                                                                             
                  q => regout_tmp_hi,                                                                         
                  devpor => devpor,                                                                           
                  devclrn => devclrn                                                                          
                 );                                                                                           
                                                                                                              
    --DDIO Low Register                                                                                       
    ddioreg_lo : dffeas                                                                                       
        GENERIC MAP (                                                                                         
                     power_up => power_up                                                                     
                    )                                                                                         
        PORT MAP (                                                                                            
                  d => datain_ipd,                                                                            
                  clk => ddioreg_clk,                                                                         
                  clrn => ddioreg_aclr,                                                                       
                  prn  => ddioreg_prn,                                                                     
                  sclr => ddioreg_sclr,                                                                       
                  sload => ddioreg_sload,                                                                     
                  asdata => ddioreg_adatasdata,                                                               
                  ena => ena_ipd,                                                                             
                  q => dfflo_tmp,                                                                             
                  devpor => devpor,                                                                           
                  devclrn => devclrn                                                                          
                );                                                                                            
                                                                                                              
    ddioreg_lo1 : dffeas                                                                                      
        GENERIC MAP (                                                                                         
                     power_up => power_up                                                                     
                    )                                                                                         
        PORT MAP (                                                                                            
                   d => dfflo_tmp,                                                                            
                   clk => clk_ipd,                                                                            
                   clrn => ddioreg_aclr,                                                                      
                   prn  => ddioreg_prn,                                                                    
                   sclr => ddioreg_sclr,                                                                      
                   sload => ddioreg_sload,                                                                    
                   asdata => ddioreg_adatasdata,                                                              
                   ena => ena_ipd,                                                                            
                   q => regout_tmp_lo,                                                                        
                   devpor => devpor,                                                                          
                   devclrn => devclrn                                                                         
                );                                                                                            
                                                                                                              
    regouthi <= regout_tmp_hi ;                                                                               
    regoutlo <= regout_tmp_lo ;                                                                               
    dfflo <= dfflo_tmp ;                                                                                      
END arch;                                                                                                     
                                                                                                              
---------------------------------------------------------------------      
--                                                                         
-- Entity Name :  cyclonev_ddio_oe                                            
-- 
-- Description :  CycloneV DDIO_OE VHDL simulation model
--  
--
---------------------------------------------------------------------

LIBRARY IEEE;
LIBRARY altera;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use altera.all;
use work.cyclonev_atom_pack.all;



ENTITY cyclonev_ddio_oe IS
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
END cyclonev_ddio_oe;

ARCHITECTURE arch OF cyclonev_ddio_oe IS

component cyclonev_mux21
    generic(
            TimingChecksOn: Boolean := True;                                      
            MsgOn: Boolean := DefGlitchMsgOn;                                     
            XOn: Boolean := DefGlitchXOn;                                         
            InstancePath: STRING := "*";                                          
            tpd_A_MO                      :   VitalDelayType01 := DefPropDelay01; 
            tpd_B_MO                      :   VitalDelayType01 := DefPropDelay01; 
            tpd_S_MO                      :   VitalDelayType01 := DefPropDelay01; 
            tipd_A                       :    VitalDelayType01 := DefPropDelay01; 
            tipd_B                       :    VitalDelayType01 := DefPropDelay01; 
            tipd_S                       :    VitalDelayType01 := DefPropDelay01
           );
    port (
          A : in std_logic := '0';
          B : in std_logic := '0';
          S : in std_logic := '0';
          MO : out std_logic
         );    
end component;

component dffeas
    generic (
             power_up : string := "DONT_CARE";                                     
             is_wysiwyg : string := "false";                                       
             x_on_violation : string := "on";                                      
             lpm_type : string := "DFFEAS";                                        
             tsetup_d_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;     
             tsetup_asdata_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             tsetup_sclr_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;  
             tsetup_sload_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst; 
             tsetup_ena_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;   
             thold_d_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;      
             thold_asdata_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst; 
             thold_sclr_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;   
             thold_sload_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;  
             thold_ena_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;    
             tpd_clk_q_posedge : VitalDelayType01 := DefPropDelay01;               
             tpd_clrn_q_negedge : VitalDelayType01 := DefPropDelay01;  
             tpd_prn_q_negedge : VitalDelayType01 := DefPropDelay01;               
             tpd_aload_q_posedge : VitalDelayType01 := DefPropDelay01;             
             tpd_asdata_q: VitalDelayType01 := DefPropDelay01;                     
             tipd_clk : VitalDelayType01 := DefPropDelay01;                        
             tipd_d : VitalDelayType01 := DefPropDelay01;                          
             tipd_asdata : VitalDelayType01 := DefPropDelay01;                     
             tipd_sclr : VitalDelayType01 := DefPropDelay01;                       
             tipd_sload : VitalDelayType01 := DefPropDelay01;                      
             tipd_clrn : VitalDelayType01 := DefPropDelay01;                       
             tipd_prn : VitalDelayType01 := DefPropDelay01;                        
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
           ena : in std_logic := '1';    
           clrn : in std_logic := '1';   
           prn : in std_logic := '1';    
           aload : in std_logic := '0';  
           asdata : in std_logic := '1'; 
           sclr : in std_logic := '0';   
           sload : in std_logic := '0';  
           devclrn : in std_logic := '1';
           devpor : in std_logic := '1'; 
           q : out std_logic 
        );          
end component;
   
    --Internal Signals
    SIGNAL oe_ipd               : std_logic := '0';
	SIGNAL octreadcontrol_ipd   : std_logic := '0';	
    SIGNAL clk_ipd                  : std_logic := '0';                      
    SIGNAL ena_ipd                  : std_logic := '0';           
    SIGNAL areset_ipd               : std_logic := '0';           
    SIGNAL sreset_ipd               : std_logic := '0';           
    SIGNAL ddioreg_aclr             :  std_logic;   
    SIGNAL ddioreg_prn              :  std_logic;   
    SIGNAL ddioreg_adatasdata       :  std_logic;   
    SIGNAL ddioreg_sclr             :  std_logic;   
    SIGNAL ddioreg_sload            :  std_logic;   
    SIGNAL dfflo_tmp                :  std_logic;   
    SIGNAL dffhi_tmp                :  std_logic;  
    signal nclk                     :  std_logic;
    signal dataout_tmp              :  std_logic; 
    signal oe_octreadcontrol_tmp    :  std_logic;	
    signal second_level_register_tmp	:  std_logic;	

	
BEGIN
   
   WireDelay : block                                             
       begin                                                     
           VitalWireDelay (oe_ipd, oe, tipd_oe);   
		   VitalWireDelay (octreadcontrol_ipd, octreadcontrol, tipd_octreadcontrol); 		   
           VitalWireDelay (clk_ipd, clk, tipd_clk);                         
           VitalWireDelay (ena_ipd, ena, tipd_ena);              
           VitalWireDelay (areset_ipd, areset, tipd_areset);     
           VitalWireDelay (sreset_ipd, sreset, tipd_sreset);     
       end block;
                                                
   nclk <= NOT clk_ipd;
   PROCESS
      BEGIN
            WAIT UNTIL areset_ipd'EVENT OR sreset_ipd'EVENT;                                               
                IF (async_mode = "clear") THEN                                                             
                    ddioreg_aclr <= NOT areset_ipd;                                                        
                    ddioreg_prn <= '1';                                                                  
                ELSIF (async_mode = "preset") THEN                                                        
                    ddioreg_aclr <= '1';                                           
                    ddioreg_prn <= NOT areset_ipd;                                 
                ELSE 
                    ddioreg_aclr <= '1';                                               
                    ddioreg_prn <= '1';                                                
                END IF;   
                                                                                       
                IF (sync_mode = "clear") THEN                                  
                    ddioreg_adatasdata <= '0';                                 
                    ddioreg_sclr <= sreset_ipd;                                                    
                    ddioreg_sload <= '0';                                                          
                ELSIF (sync_mode = "preset") THEN                                                 
                    ddioreg_adatasdata <= '1';                                                 
                    ddioreg_sclr <= '0';                                                       
                    ddioreg_sload <= sreset_ipd;                                                              
                ELSE                                                                                                                
                    ddioreg_adatasdata <= '0';                                                 
                    ddioreg_sclr <= '0';                                                       
                    ddioreg_sload <= '0';                                                                                                                                               
                END IF;                                                                            
    END PROCESS;                                                             
        
       ddioreg_hi : dffeas 
        GENERIC MAP (
                     power_up => power_up
                    )
        PORT MAP (
		  d => oe_octreadcontrol_tmp,	
                  clk => clk_ipd,                  
                  clrn => ddioreg_aclr,        
                  prn => ddioreg_prn,      
                  sclr => ddioreg_sclr,        
                  sload => ddioreg_sload,      
                  asdata => ddioreg_adatasdata,
                  ena => ena_ipd,              
                  q => dffhi_tmp,              
                  devpor => devpor,            
                  devclrn => devclrn           
                );   

    
    --DDIO Low Register
    second_level_register_tmp <= dffhi_tmp when(disable_second_level_register = "false") else '0';     
    ddioreg_lo : dffeas 
        GENERIC MAP (
                     power_up => power_up
                    )
        PORT MAP (
		  d => second_level_register_tmp,	              
                  clk => nclk,             
                  clrn => ddioreg_aclr,        
                  prn => ddioreg_prn,      
                  sclr => ddioreg_sclr,        
                  sload => ddioreg_sload,      
                  asdata => ddioreg_adatasdata,
                  ena => ena_ipd,              
                  q => dfflo_tmp,              
                  devpor => devpor,            
                  devclrn => devclrn           
                );   
    
    --registered output 
    or_gate : cyclonev_mux21
        port map (
                   A => dffhi_tmp,
                   B => dfflo_tmp,
                   S => dfflo_tmp,
                   MO => dataout	   
                  );              

    dfflo <= dfflo_tmp ;
    dffhi <= dffhi_tmp ;
    oe_octreadcontrol_tmp <= '1' when (octreadcontrol_ipd = '1' and oe_ipd = '1') else '0';	
	
    
END arch;
---------------------------------------------------------------------
--
-- Entity Name :  cyclonev_ddio_out
-- 
-- Description :  CycloneV DDIO_OUT VHDL simulation model
--  
--
---------------------------------------------------------------------

LIBRARY IEEE;
LIBRARY altera;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use altera.all;
use work.cyclonev_atom_pack.all;

ENTITY cyclonev_ddio_out IS
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
END cyclonev_ddio_out;

ARCHITECTURE arch OF cyclonev_ddio_out IS

component cyclonev_mux21
    generic(
            TimingChecksOn: Boolean := True;                                      
            MsgOn: Boolean := DefGlitchMsgOn;                                     
            XOn: Boolean := DefGlitchXOn;                                         
            InstancePath: STRING := "*";                                          
            tpd_A_MO                      :   VitalDelayType01 := DefPropDelay01; 
            tpd_B_MO                      :   VitalDelayType01 := DefPropDelay01; 
            tpd_S_MO                      :   VitalDelayType01 := DefPropDelay01; 
            tipd_A                       :    VitalDelayType01 := DefPropDelay01; 
            tipd_B                       :    VitalDelayType01 := DefPropDelay01; 
            tipd_S                       :    VitalDelayType01 := DefPropDelay01
           );
    port (
          A : in std_logic := '0';
          B : in std_logic := '0';
          S : in std_logic := '0';
          MO : out std_logic
         );    
end component;

component dffeas
    generic (
             power_up : string := "DONT_CARE";                                     
             is_wysiwyg : string := "false";                                       
             x_on_violation : string := "on";                                      
             lpm_type : string := "DFFEAS";                                        
             tsetup_d_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;     
             tsetup_asdata_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;
             tsetup_sclr_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;  
             tsetup_sload_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst; 
             tsetup_ena_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;   
             thold_d_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;      
             thold_asdata_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst; 
             thold_sclr_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;   
             thold_sload_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;  
             thold_ena_clk_noedge_posedge : VitalDelayType := DefSetupHoldCnst;    
             tpd_clk_q_posedge : VitalDelayType01 := DefPropDelay01;               
             tpd_clrn_q_negedge : VitalDelayType01 := DefPropDelay01;
             tpd_prn_q_negedge : VitalDelayType01 := DefPropDelay01;              
             tpd_aload_q_posedge : VitalDelayType01 := DefPropDelay01;             
             tpd_asdata_q: VitalDelayType01 := DefPropDelay01;                     
             tipd_clk : VitalDelayType01 := DefPropDelay01;                        
             tipd_d : VitalDelayType01 := DefPropDelay01;                          
             tipd_asdata : VitalDelayType01 := DefPropDelay01;                     
             tipd_sclr : VitalDelayType01 := DefPropDelay01;                       
             tipd_sload : VitalDelayType01 := DefPropDelay01;                      
             tipd_clrn : VitalDelayType01 := DefPropDelay01;                       
             tipd_prn : VitalDelayType01 := DefPropDelay01;                        
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
          ena : in std_logic := '1';    
          clrn : in std_logic := '1';   
          prn : in std_logic := '1';    
          aload : in std_logic := '0';  
          asdata : in std_logic := '1'; 
          sclr : in std_logic := '0';   
          sload : in std_logic := '0';  
          devclrn : in std_logic := '1';
          devpor : in std_logic := '1'; 
          q : out std_logic
         );          
end component;
    --Internal Signals
    SIGNAL datainlo_ipd             : std_logic := '0';  
    SIGNAL datainhi_ipd             : std_logic := '0';             
    SIGNAL clk_ipd                  : std_logic := '0'; 
    SIGNAL clkhi_ipd                : std_logic := '0';
    SIGNAL clklo_ipd                : std_logic := '0';
    SIGNAL muxsel_ipd               : std_logic := '0'; 
	SIGNAL hrbsel_ipd               : std_logic := '0';     	
    SIGNAL ena_ipd                  : std_logic := '0';         
    SIGNAL areset_ipd               : std_logic := '0';         
    SIGNAL sreset_ipd               : std_logic := '0';         
	SIGNAL sel_mux_hi_hr			: std_logic;				
	SIGNAL sel_mux_lo_hr			: std_logic;			
	SIGNAL dataout_hr				: std_logic;				
    SIGNAL ddioreg_aclr             :  std_logic;   
    SIGNAL ddioreg_prn              :  std_logic;   
    SIGNAL ddioreg_adatasdata       :  std_logic;   
    SIGNAL ddioreg_sclr             :  std_logic;   
    SIGNAL ddioreg_sload            :  std_logic;   
    SIGNAL dfflo_tmp                :  std_logic;   
    SIGNAL dffhi_tmp                :  std_logic;  
    SIGNAL dataout_tmp              :  std_logic; 
    Signal mux_sel                  :  std_logic;
    Signal mux_hi                   :  std_logic;
   Signal sel_mux_hi_in             :  std_logic;
   signal nclk                      :  std_logic;     
   signal clk1                      :  std_logic;
   signal clk_hi                    :  std_logic;
   signal clk_lo                    :  std_logic;

    signal muxsel1 : std_logic;
    signal muxsel2: std_logic;
    signal clk2   : std_logic;
    signal muxsel_tmp: std_logic;
    signal sel_mux_lo_in : std_logic;
    signal datainlo_tmp : std_logic;
    signal datainhi_tmp : std_logic;
	signal hrb_sel: std_logic;

BEGIN

WireDelay : block                                            
    begin                                                    
        VitalWireDelay (datainlo_ipd, datainlo, tipd_datainlo);  
        VitalWireDelay (datainhi_ipd, datainhi, tipd_datainhi);             
        VitalWireDelay (clk_ipd, clk, tipd_clk);  
        VitalWireDelay (clkhi_ipd, clkhi, tipd_clkhi); 
        VitalWireDelay (clklo_ipd, clklo, tipd_clklo); 
        VitalWireDelay (muxsel_ipd, muxsel, tipd_muxsel);            
        VitalWireDelay (hrbsel_ipd, hrbypass, tipd_hrbsel); 
		VitalWireDelay (ena_ipd, ena, tipd_ena);             
        VitalWireDelay (areset_ipd, areset, tipd_areset);    
        VitalWireDelay (sreset_ipd, sreset, tipd_sreset);    
    end block;                                               
   nclk <= NOT clk_ipd;                                  
   PROCESS                                                                                                
        BEGIN                                                                                              
            WAIT UNTIL areset_ipd'EVENT OR sreset_ipd'EVENT;                                               
                IF (async_mode = "clear") THEN                                                             
                    ddioreg_aclr <= NOT areset_ipd;                                                        
                    ddioreg_prn <= '1';                                                                  
                ELSIF (async_mode = "preset") THEN                                                        
                    ddioreg_aclr <= '1';                                           
                    ddioreg_prn <= NOT areset_ipd;                                 
                ELSE 
                    ddioreg_aclr <= '1';                                               
                    ddioreg_prn <= '1';                                                
                END IF;   
  
                IF (sync_mode = "clear") THEN                                  
                    ddioreg_adatasdata <= '0';                                 
                    ddioreg_sclr <= sreset_ipd;                                                    
                    ddioreg_sload <= '0';                                                          
                ELSIF (sync_mode = "preset") THEN                                                 
                    ddioreg_adatasdata <= '1';                                                 
                    ddioreg_sclr <= '0';                                                       
                    ddioreg_sload <= sreset_ipd;                                                              
                ELSE                                                                                                                
                    ddioreg_adatasdata <= '0';                                                 
                    ddioreg_sclr <= '0';                                                       
                    ddioreg_sload <= '0';                                                                                                                                               
                END IF;                                                                            
    END PROCESS;                    
    
    process(clk_ipd)
        begin                   
            clk1 <= clk_ipd;
    end process;

   process(muxsel_ipd)
        begin                   
            muxsel1 <= muxsel_ipd;
    end process;
	
	process(hrbsel_ipd)				
        begin                   	
            hrb_sel <= hrbsel_ipd;	
    end process;					
    

    --DDIO HIGH Register 
    clk_hi <=  clkhi_ipd when(use_new_clocking_model = "true") else  clk_ipd;  
    datainhi_tmp <= datainhi;
    ddioreg_hi : dffeas                                      
        GENERIC MAP (                                        
                     power_up => power_up                    
                    )                                        
        PORT MAP (                                           
                  d => datainhi_tmp,                         
                  clk => clk_hi,                             
                  clrn => ddioreg_aclr,                      
                  prn => ddioreg_prn,                        
                  sclr => ddioreg_sclr,                      
                  sload => ddioreg_sload,                    
                  asdata => ddioreg_adatasdata,              
                  ena => ena_ipd,                            
                  q => dffhi_tmp,                            
                  devpor => devpor,                          
                  devclrn => devclrn                         
                );                                           
        
    --DDIO Low Register
    clk_lo <= clklo_ipd when(use_new_clocking_model = "true") else clk_ipd;
    datainlo_tmp <= datainlo;
    ddioreg_lo : dffeas 
        GENERIC MAP (
                      power_up => power_up
                    )
        PORT MAP (
                  d => datainlo_tmp,               
                  clk => clk_lo,                  
                  clrn => ddioreg_aclr,        
                  prn => ddioreg_prn,      
                  sclr => ddioreg_sclr,        
                  sload => ddioreg_sload,      
                  asdata => ddioreg_adatasdata,
                  ena => ena_ipd,                  
                  q => dfflo_tmp,               
                  devpor => devpor,            
                  devclrn => devclrn           
                );                       
  
  muxsel2 <= muxsel1;
  clk2 <= clk1;
  mux_sel <= muxsel2 when(use_new_clocking_model = "true") else clk2;       
  muxsel_tmp <= mux_sel;	
  sel_mux_lo_in <= dfflo_tmp;              
  sel_mux_hi_in <= dffhi_tmp;   
  sel_mux_hi_hr <= datainhi_tmp;	
  sel_mux_lo_hr <= dataout_hr;	
  
  sel_mux : cyclonev_mux21
        port map (
                   A => sel_mux_lo_in,
                   B => sel_mux_hi_in,
                   S => muxsel_tmp,
				   MO => dataout_hr 
                  );              

    dfflo <= dfflo_tmp;
    dffhi <= dffhi_tmp;    

  sel_mux_hr : cyclonev_mux21	
		port map (			
					A => sel_mux_lo_hr,	
					B => sel_mux_hi_hr,	
					S => hrb_sel,		
					MO => dataout		
				);						
END arch;
----------------------------------------------------------------------------
-- Module Name     : cyclonev_io_pad
-- Description     : Simulation model for cyclonev IO pad
----------------------------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

ENTITY cyclonev_io_pad IS
    GENERIC (
        lpm_type                       :  string := "cyclonev_io_pad");    
    PORT (
        --INPUT PORTS

        padin                   : IN std_logic := '0';   -- Input Pad
        --OUTPUT PORTS

        padout                  : OUT std_logic);   -- Output Pad
END cyclonev_io_pad;

ARCHITECTURE arch OF cyclonev_io_pad IS

BEGIN
    padout <= padin;    
END arch;
--------------------------------------------------------------
--
-- Entity Name : cyclonev_bias_logic
--
-- Description : CYCLONEV Bias Block's Logic Block
--               VHDL simulation model
--
--------------------------------------------------------------
LIBRARY IEEE;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use work.cyclonev_atom_pack.all;

ENTITY cyclonev_bias_logic IS
    GENERIC (
            tipd_clk : VitalDelayType01 := DefPropDelay01;
            tipd_shiftnld : VitalDelayType01 := DefPropDelay01;
            tipd_captnupdt : VitalDelayType01 := DefPropDelay01;
            MsgOn: Boolean := DefGlitchMsgOn;
            XOn: Boolean := DefGlitchXOn;
            MsgOnChecks: Boolean := DefMsgOnChecks;
            XOnChecks: Boolean := DefXOnChecks
            );
    PORT (
        clk : in std_logic := '0';
        shiftnld : in std_logic := '0';
        captnupdt : in std_logic := '0';
        mainclk : out std_logic := '0';
        updateclk : out std_logic := '0';
        capture : out std_logic := '0';
        update : out std_logic := '0'
        );

    attribute VITAL_LEVEL0 of cyclonev_bias_logic : ENTITY IS TRUE;
end cyclonev_bias_logic;

ARCHITECTURE vital_bias_logic of cyclonev_bias_logic IS
    attribute VITAL_LEVEL0 of vital_bias_logic : ARCHITECTURE IS TRUE;
    signal clk_ipd : std_logic := '0';
    signal shiftnld_ipd : std_logic := '0';
    signal captnupdt_ipd : std_logic := '0';
begin

    WireDelay : block
    begin
        VitalWireDelay (clk_ipd, clk, tipd_clk);
        VitalWireDelay (shiftnld_ipd, shiftnld, tipd_shiftnld);
        VitalWireDelay (captnupdt_ipd, captnupdt, tipd_captnupdt);
    end block;

    process (clk_ipd, shiftnld_ipd, captnupdt_ipd)
    variable select_tmp : std_logic_vector(1 DOWNTO 0) := (others => '0');
    begin
        select_tmp := captnupdt_ipd & shiftnld_ipd;
        case select_tmp IS
            when "10"|"11" =>
                mainclk <= '0';
                updateclk <= clk_ipd;
                capture <= '1';
                update <= '0';
            when "01" =>
                mainclk <= '0';
                updateclk <= clk_ipd;
                capture <= '0';
                update <= '0';
            when "00" =>
                mainclk <= clk_ipd;
                updateclk <= '0';
                capture <= '0';
                update <= '1';
            when others =>
                mainclk <= '0';
                updateclk <= '0';
                capture <= '0';
                update <= '0';
        end case;
    end process;

end vital_bias_logic;

--------------------------------------------------------------
--
-- Entity Name : cyclonev_bias_generator
--
-- Description : CYCLONEV Bias Generator VHDL simulation model
--
--------------------------------------------------------------
LIBRARY IEEE;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use work.cyclonev_atom_pack.all;

ENTITY cyclonev_bias_generator IS
    GENERIC (
        tipd_din : VitalDelayType01 := DefPropDelay01;
        tipd_mainclk : VitalDelayType01 := DefPropDelay01;
        tipd_updateclk : VitalDelayType01 := DefPropDelay01;
        tipd_update : VitalDelayType01 := DefPropDelay01;
        tipd_capture : VitalDelayType01 := DefPropDelay01;
        MsgOn: Boolean := DefGlitchMsgOn;
        XOn: Boolean := DefGlitchXOn;
        MsgOnChecks: Boolean := DefMsgOnChecks;
        XOnChecks: Boolean := DefXOnChecks
        );
    PORT (
        din : in std_logic := '0';
        mainclk : in std_logic := '0';
        updateclk : in std_logic := '0';
        capture : in std_logic := '0';
        update : in std_logic := '0';
        dout : out std_logic := '0'
        );

    attribute VITAL_LEVEL0 of cyclonev_bias_generator : ENTITY IS TRUE;
end cyclonev_bias_generator;

ARCHITECTURE vital_bias_generator of cyclonev_bias_generator IS
    attribute VITAL_LEVEL0 of vital_bias_generator : ARCHITECTURE IS TRUE;
    CONSTANT TOTAL_REG : integer := 202;
    signal din_ipd : std_logic := '0';
    signal mainclk_ipd : std_logic := '0';
    signal updateclk_ipd : std_logic := '0';
    signal update_ipd : std_logic := '0';
    signal capture_ipd : std_logic := '0';
    signal generator_reg : std_logic_vector((TOTAL_REG - 1) DOWNTO 0) := (others => '0');
    signal update_reg : std_logic_vector((TOTAL_REG - 1) DOWNTO 0) := (others => '0');
    signal dout_tmp : std_logic := '0';
    signal i : integer := 0;
    
begin

    WireDelay : block
    begin
        VitalWireDelay (din_ipd, din, tipd_din);
        VitalWireDelay (mainclk_ipd, mainclk, tipd_mainclk);
        VitalWireDelay (updateclk_ipd, updateclk, tipd_updateclk);
        VitalWireDelay (update_ipd, update, tipd_update);
        VitalWireDelay (capture_ipd, capture, tipd_capture);
    end block;

    process (mainclk_ipd)
    begin
        if (mainclk_ipd'event AND (mainclk_ipd = '1') AND (mainclk_ipd'last_value = '0')) then 
            if ((capture_ipd = '0') AND (update_ipd = '1')) then 
                for i in 0 to (TOTAL_REG - 1)
                loop
                    generator_reg(i) <= update_reg(i);
                end loop;
            end if;
        end if;
    end process;

    process (updateclk_ipd)
    begin
        if (updateclk_ipd'event AND (updateclk_ipd = '1') AND (updateclk_ipd'last_value = '0')) then 
            dout_tmp <= update_reg(TOTAL_REG - 1);
    
            if ((capture_ipd = '0') AND (update_ipd = '0')) then 
                for i in 1 to (TOTAL_REG - 1)
                loop
                    update_reg(i) <= update_reg(i - 1);
                end loop;
                update_reg(0) <= din_ipd;
            elsif ((capture_ipd = '1') AND (update_ipd = '0')) then 
                for i in 1 to (TOTAL_REG - 1)
                loop
                    update_reg(i) <= generator_reg(i);
                end loop;
            end if; 
        end if;
    end process;

    dout <= dout_tmp;

end vital_bias_generator;

--------------------------------------------------------------
--
-- Entity Name : cyclonev_bias_block
--
-- Description : CYCLONEV Bias Block VHDL simulation model
--
--------------------------------------------------------------
LIBRARY IEEE;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use work.cyclonev_atom_pack.all;

ENTITY cyclonev_bias_block IS
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

    attribute VITAL_LEVEL0 of cyclonev_bias_block : ENTITY IS TRUE;
end cyclonev_bias_block;

ARCHITECTURE vital_bias_block of cyclonev_bias_block IS

    COMPONENT cyclonev_bias_logic
        GENERIC (
                tipd_clk : VitalDelayType01 := DefPropDelay01;
                tipd_shiftnld : VitalDelayType01 := DefPropDelay01;
                tipd_captnupdt : VitalDelayType01 := DefPropDelay01;
                MsgOn: Boolean := DefGlitchMsgOn;
                XOn: Boolean := DefGlitchXOn;
                MsgOnChecks: Boolean := DefMsgOnChecks;
                XOnChecks: Boolean := DefXOnChecks
                );
        PORT (
            clk : in std_logic := '0';
            shiftnld : in std_logic := '0';
            captnupdt : in std_logic := '0';
            mainclk : out std_logic := '0';
            updateclk : out std_logic := '0';
            capture : out std_logic := '0';
            update : out std_logic := '0'
            );
    end COMPONENT;
    
    COMPONENT cyclonev_bias_generator
        GENERIC (
            tipd_din : VitalDelayType01 := DefPropDelay01;
            tipd_mainclk : VitalDelayType01 := DefPropDelay01;
            tipd_updateclk : VitalDelayType01 := DefPropDelay01;
            tipd_update : VitalDelayType01 := DefPropDelay01;
            tipd_capture : VitalDelayType01 := DefPropDelay01;
            MsgOn: Boolean := DefGlitchMsgOn;
            XOn: Boolean := DefGlitchXOn;
            MsgOnChecks: Boolean := DefMsgOnChecks;
            XOnChecks: Boolean := DefXOnChecks
            );
        PORT (
            din : in std_logic := '0';
            mainclk : in std_logic := '0';
            updateclk : in std_logic := '0';
            capture : in std_logic := '0';
            update : in std_logic := '0';
            dout : out std_logic := '0'
            );
    end COMPONENT;

    signal mainclk_wire : std_logic := '0';
    signal updateclk_wire : std_logic := '0';
    signal capture_wire : std_logic := '0';
    signal update_wire : std_logic := '0';

begin

    logic_block : cyclonev_bias_logic
                  PORT MAP (
                           clk => clk,
                           shiftnld => shiftnld,
                           captnupdt => captnupdt,
                           mainclk => mainclk_wire,
                           updateclk => updateclk_wire,
                           capture => capture_wire,
                           update => update_wire
                           );

    bias_generator : cyclonev_bias_generator
                  PORT MAP (
                           din => din,
                           mainclk => mainclk_wire,
                           updateclk => updateclk_wire,
                           capture => capture_wire,
                           update => update_wire,
                           dout => dout
                           );
    
end vital_bias_block;
library IEEE;
use IEEE.std_logic_1164.all;


entity cyclonev_clk_phase_select is
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
end cyclonev_clk_phase_select;

architecture behavior of cyclonev_clk_phase_select is

component cyclonev_clk_phase_select_encrypted
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
end component;

begin


inst : cyclonev_clk_phase_select_encrypted
    generic map (
        phase_setting => phase_setting,
        invert_phase => invert_phase,
        use_phasectrlin => use_phasectrlin,
        physical_clock_source => physical_clock_source,
        use_dqs_input => use_dqs_input
    )
    port map (
        clkin => clkin,
        dqsin => dqsin,
        phaseinvertctrl => phaseinvertctrl,
        clkout => clkout,
        phasectrlin => phasectrlin
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_clkena    is
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
end cyclonev_clkena;

architecture behavior of cyclonev_clkena is

component    cyclonev_clkena_encrypted
    generic    (
        clock_type    :    string    :=    "auto";
        ena_register_mode    :    string    :=    "always enabled";
        lpm_type    :    string    :=    "cyclonev_clkena";
        ena_register_power_up    :    string    :=    "high";
        disable_mode    :    string    :=    "low";
        test_syn    :    string    :=    "high"
    );
    port    (
        inclk    :    in    std_logic;
        ena    :    in    std_logic;
        enaout    :    out    std_logic;
        outclk    :    out    std_logic
    );
end component;

begin


inst : cyclonev_clkena_encrypted
    generic  map  (
        clock_type    =>   clock_type,
        ena_register_mode    =>   ena_register_mode,
        lpm_type    =>   lpm_type,
        ena_register_power_up    =>   ena_register_power_up,
        disable_mode    =>   disable_mode,
        test_syn    =>   test_syn
    )
    port  map  (
        inclk    =>    inclk,
        ena    =>    ena,
        enaout    =>    enaout,
        outclk    =>    outclk
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_clkselect    is
    generic    (
        lpm_type    :    string    :=    "cyclonev_clkselect";
        test_cff    :    string    :=    "low"
    );
    port    (
        inclk    :    in    std_logic_vector(3 downto 0)    :=    "0000";
        clkselect    :    in    std_logic_vector(1 downto 0)    :=    "00";
        outclk    :    out    std_logic
    );
end cyclonev_clkselect;

architecture behavior of cyclonev_clkselect is

component    cyclonev_clkselect_encrypted
    generic    (
        lpm_type    :    string    :=    "cyclonev_clkselect";
        test_cff    :    string    :=    "low"
    );
    port    (
        inclk    :    in    std_logic_vector(3 downto 0);
        clkselect    :    in    std_logic_vector(1 downto 0);
        outclk    :    out    std_logic
    );
end component;

begin


inst : cyclonev_clkselect_encrypted
    generic  map  (
        lpm_type    =>   lpm_type,
        test_cff    =>   test_cff
    )
    port  map  (
        inclk    =>    inclk,
        clkselect    =>    clkselect,
        outclk    =>    outclk
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_delay_chain    is
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
end cyclonev_delay_chain;

architecture behavior of cyclonev_delay_chain is

component    cyclonev_delay_chain_encrypted
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
end component;

begin


inst : cyclonev_delay_chain_encrypted
    generic  map  (
        sim_intrinsic_rising_delay    =>   sim_intrinsic_rising_delay,
        sim_intrinsic_falling_delay    =>   sim_intrinsic_falling_delay,
        sim_rising_delay_increment    =>   sim_rising_delay_increment,
        sim_falling_delay_increment    =>   sim_falling_delay_increment,
        lpm_type    =>   lpm_type
    )
    port  map  (
        datain    =>    datain,
        delayctrlin    =>    delayctrlin,
        dataout    =>    dataout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_dll_offset_ctrl    is
    generic    (
        use_offset    :    string    :=    "false";
        static_offset    :    integer    :=    0;
        use_pvt_compensation    :    string    :=    "false"
    );
    port    (
        clk    :    in    std_logic	:= '0';
        offsetdelayctrlin    :    in    std_logic_vector(6 downto 0)	:= (OTHERS => '0');
        offset    :    in    std_logic_vector(6 downto 0)	:= (OTHERS => '0');
        addnsub    :    in    std_logic	:= '0';
        aload    :    in    std_logic	:= '0';
        offsetctrlout    :    out    std_logic_vector(6 downto 0);
        offsettestout    :    out    std_logic_vector(6 downto 0)
    );
end cyclonev_dll_offset_ctrl;

architecture behavior of cyclonev_dll_offset_ctrl is

component    cyclonev_dll_offset_ctrl_encrypted
    generic    (
        use_offset    :    string    :=    "false";
        static_offset    :    integer    :=    0;
        use_pvt_compensation    :    string    :=    "false"
    );
    port    (
        clk    :    in    std_logic	:= '0';
        offsetdelayctrlin    :    in    std_logic_vector(6 downto 0)	:= (OTHERS => '0');
        offset    :    in    std_logic_vector(6 downto 0)	:= (OTHERS => '0');
        addnsub    :    in    std_logic	:= '0';
        aload    :    in    std_logic	:= '0';
        offsetctrlout    :    out    std_logic_vector(6 downto 0);
        offsettestout    :    out    std_logic_vector(6 downto 0)
    );
end component;

begin


inst : cyclonev_dll_offset_ctrl_encrypted
    generic  map  (
        use_offset    =>   use_offset,
        static_offset    =>   static_offset,
        use_pvt_compensation    =>   use_pvt_compensation
    )
    port  map  (
        clk    =>    clk,
        offsetdelayctrlin    =>    offsetdelayctrlin,
        offset    =>    offset,
        addnsub    =>    addnsub,
        aload    =>    aload,
        offsetctrlout    =>    offsetctrlout,
        offsettestout    =>    offsettestout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_dll    is
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
end cyclonev_dll;

architecture behavior of cyclonev_dll is

component    cyclonev_dll_encrypted
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
end component;

begin


inst : cyclonev_dll_encrypted
    generic  map  (
        input_frequency    =>   input_frequency,
        delayctrlout_mode    =>   delayctrlout_mode,
        jitter_reduction    =>   jitter_reduction,
        use_upndnin    =>   use_upndnin,
        use_upndninclkena    =>   use_upndninclkena,
        dual_phase_comparators    =>   dual_phase_comparators,
        sim_valid_lock    =>   sim_valid_lock,
        sim_valid_lockcount    =>   sim_valid_lockcount,
        sim_buffer_intrinsic_delay    =>   sim_buffer_intrinsic_delay,
        sim_buffer_delay_increment    =>   sim_buffer_delay_increment,
        static_delay_ctrl    =>   static_delay_ctrl,
        lpm_type    =>   lpm_type,
        lpm_hint    =>   lpm_hint,
        delay_chain_length    =>   delay_chain_length
    )
    port  map  (
        aload    =>    aload,
        clk    =>    clk,
        upndnin    =>    upndnin,
        upndninclkena    =>    upndninclkena,
        delayctrlout    =>    delayctrlout,
        dqsupdate    =>    dqsupdate,
        offsetdelayctrlout    =>    offsetdelayctrlout,
        offsetdelayctrlclkout    =>    offsetdelayctrlclkout,
        upndnout    =>    upndnout,
        dffin    =>    dffin
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;

entity cyclonev_dqs_config is
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
end cyclonev_dqs_config;

architecture behavior of cyclonev_dqs_config is

component cyclonev_dqs_config_encrypted
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
end component;

begin

inst : cyclonev_dqs_config_encrypted
    generic map (
        lpm_type => lpm_type
    )
    port map (
        datain => datain,
        dqsenablegatingdelaysetting => dqsenablegatingdelaysetting,
        dqshalfratebypass => dqshalfratebypass,
        enadqsenablephasetransferreg => enadqsenablephasetransferreg,
        postamblephaseinvert => postamblephaseinvert,
        dqsenableungatingdelaysetting => dqsenableungatingdelaysetting,
        octdelaysetting => octdelaysetting,
        clk => clk,
        dqsbusoutdelaysetting => dqsbusoutdelaysetting,
        postamblephasesetting => postamblephasesetting,
        ena => ena,
        dataout => dataout,
        update => update
    );

end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_dqs_delay_chain    is
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
end cyclonev_dqs_delay_chain;

architecture behavior of cyclonev_dqs_delay_chain is

component    cyclonev_dqs_delay_chain_encrypted
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
end component;

begin


inst : cyclonev_dqs_delay_chain_encrypted
    generic  map  (
        dqs_input_frequency    =>   dqs_input_frequency,
        dqs_phase_shift    =>   dqs_phase_shift,
        use_phasectrlin    =>   use_phasectrlin,
        phase_setting    =>   phase_setting,
        dqs_offsetctrl_enable    =>   dqs_offsetctrl_enable,
        dqs_ctrl_latches_enable    =>   dqs_ctrl_latches_enable,
        use_alternate_input_for_first_stage_delayctrl    =>   use_alternate_input_for_first_stage_delayctrl,
        use_alternate_input_for_multi_stage_delayctrl    =>   use_alternate_input_for_multi_stage_delayctrl,
        sim_buffer_intrinsic_delay    =>   sim_buffer_intrinsic_delay,
        sim_buffer_delay_increment    =>   sim_buffer_delay_increment,
        test_enable    =>   test_enable
    )
    port  map  (
        dqsin    =>    dqsin,
        dqsenable    =>    dqsenable,
        delayctrlin    =>    delayctrlin,
        offsetctrlin    =>    offsetctrlin,
        dqsupdateen    =>    dqsupdateen,
        phasectrlin    =>    phasectrlin,
        testin    =>    testin,
        dffin    =>    dffin,
        dqsbusout    =>    dqsbusout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_dqs_enable_ctrl    is
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
end cyclonev_dqs_enable_ctrl;

architecture behavior of cyclonev_dqs_enable_ctrl is

component    cyclonev_dqs_enable_ctrl_encrypted
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
end component;

begin


inst : cyclonev_dqs_enable_ctrl_encrypted
    generic  map  (
        delay_dqs_enable_by_half_cycle    =>   delay_dqs_enable_by_half_cycle,
        add_phase_transfer_reg    =>   add_phase_transfer_reg
    )
    port  map  (
        dqsenablein    =>    dqsenablein,
        zerophaseclk    =>    zerophaseclk,
        enaphasetransferreg    =>    enaphasetransferreg,
        levelingclk    =>    levelingclk,
        dffin    =>    dffin,
        dffphasetransfer    =>    dffphasetransfer,
        dffextenddqsenable    =>    dffextenddqsenable,
        dqsenableout    =>    dqsenableout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_duty_cycle_adjustment    is
    generic    (
        dca_config_mode    :    integer    :=    0;
	duty_cycle_delay_mode    :    string    :=    "none";
        lpm_type    :    string    :=    "cyclonev_duty_cycle_adjustment"
    );
    port    (
        clkin    :    in    std_logic	:= '0';
        delaymode    :     in    std_logic_vector(1 downto 0)	:= (OTHERS => '0');
        delayctrlin    :    in    std_logic_vector(3 downto 0)	:= (OTHERS => '0');
        clkout    :    out    std_logic
    );
end cyclonev_duty_cycle_adjustment;

architecture behavior of cyclonev_duty_cycle_adjustment is

component    cyclonev_duty_cycle_adjustment_encrypted
    generic    (
        dca_config_mode    :    integer    :=    0;
	duty_cycle_delay_mode    :    string    :=    "none";
        lpm_type    :    string    :=    "cyclonev_duty_cycle_adjustment"
    );
    port    (
        clkin    :    in    std_logic	:= '0';
        delaymode    :     in    std_logic_vector(1 downto 0)	:= (OTHERS => '0');
        delayctrlin    :    in    std_logic_vector(3 downto 0)	:= (OTHERS => '0');
        clkout    :    out    std_logic
    );
end component;

begin


inst : cyclonev_duty_cycle_adjustment_encrypted
    generic  map  (
        dca_config_mode    => dca_config_mode,
	duty_cycle_delay_mode    =>   duty_cycle_delay_mode,
        lpm_type    =>   lpm_type
    )
    port  map  (
        clkin    =>    clkin,
        delaymode    =>    delaymode,
        delayctrlin    =>    delayctrlin,
        clkout    =>    clkout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_fractional_pll    is
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
end cyclonev_fractional_pll;

architecture behavior of cyclonev_fractional_pll is

component    cyclonev_fractional_pll_encrypted
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
		pll_fractional_division_string    :    string    :=    "1";
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
        lvdsfbin    :    in    std_logic;
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
end component;

begin


inst : cyclonev_fractional_pll_encrypted
    generic  map  (
        output_clock_frequency    =>   output_clock_frequency,
        reference_clock_frequency    =>   reference_clock_frequency,
        mimic_fbclk_type    =>   mimic_fbclk_type,
        dsm_accumulator_reset_value    =>   dsm_accumulator_reset_value,
        forcelock    =>   forcelock,
        nreset_invert    =>   nreset_invert,
        pll_atb    =>   pll_atb,
        pll_bwctrl    =>   pll_bwctrl,
        pll_cmp_buf_dly    =>   pll_cmp_buf_dly,
        pll_cp_comp    =>   pll_cp_comp,
        pll_cp_current    =>   pll_cp_current,
        pll_ctrl_override_setting    =>   pll_ctrl_override_setting,
        pll_dsm_dither    =>   pll_dsm_dither,
        pll_dsm_out_sel    =>   pll_dsm_out_sel,
        pll_dsm_reset    =>   pll_dsm_reset,
        pll_ecn_bypass    =>   pll_ecn_bypass,
        pll_ecn_test_en    =>   pll_ecn_test_en,
        pll_enable    =>   pll_enable,
        pll_fbclk_mux_1    =>   pll_fbclk_mux_1,
        pll_fbclk_mux_2    =>   pll_fbclk_mux_2,
        pll_fractional_carry_out    =>   pll_fractional_carry_out,
        pll_fractional_division    =>   pll_fractional_division,
        pll_fractional_division_string    =>   pll_fractional_division_string,
        pll_fractional_value_ready    =>   pll_fractional_value_ready,
        pll_lf_testen    =>   pll_lf_testen,
        pll_lock_fltr_cfg    =>   pll_lock_fltr_cfg,
        pll_lock_fltr_test    =>   pll_lock_fltr_test,
        pll_m_cnt_bypass_en    =>   pll_m_cnt_bypass_en,
        pll_m_cnt_coarse_dly    =>   pll_m_cnt_coarse_dly,
        pll_m_cnt_fine_dly    =>   pll_m_cnt_fine_dly,
        pll_m_cnt_hi_div    =>   pll_m_cnt_hi_div,
        pll_m_cnt_in_src    =>   pll_m_cnt_in_src,
        pll_m_cnt_lo_div    =>   pll_m_cnt_lo_div,
        pll_m_cnt_odd_div_duty_en    =>   pll_m_cnt_odd_div_duty_en,
        pll_m_cnt_ph_mux_prst    =>   pll_m_cnt_ph_mux_prst,
        pll_m_cnt_prst    =>   pll_m_cnt_prst,
        pll_n_cnt_bypass_en    =>   pll_n_cnt_bypass_en,
        pll_n_cnt_coarse_dly    =>   pll_n_cnt_coarse_dly,
        pll_n_cnt_fine_dly    =>   pll_n_cnt_fine_dly,
        pll_n_cnt_hi_div    =>   pll_n_cnt_hi_div,
        pll_n_cnt_lo_div    =>   pll_n_cnt_lo_div,
        pll_n_cnt_odd_div_duty_en    =>   pll_n_cnt_odd_div_duty_en,
        pll_ref_buf_dly    =>   pll_ref_buf_dly,
        pll_reg_boost    =>   pll_reg_boost,
        pll_regulator_bypass    =>   pll_regulator_bypass,
        pll_ripplecap_ctrl    =>   pll_ripplecap_ctrl,
        pll_slf_rst    =>   pll_slf_rst,
        pll_tclk_mux_en    =>   pll_tclk_mux_en,
        pll_tclk_sel    =>   pll_tclk_sel,
        pll_test_enable    =>   pll_test_enable,
        pll_testdn_enable    =>   pll_testdn_enable,
        pll_testup_enable    =>   pll_testup_enable,
        pll_unlock_fltr_cfg    =>   pll_unlock_fltr_cfg,
        pll_vco_div    =>   pll_vco_div,
        pll_vco_ph0_en    =>   pll_vco_ph0_en,
        pll_vco_ph1_en    =>   pll_vco_ph1_en,
        pll_vco_ph2_en    =>   pll_vco_ph2_en,
        pll_vco_ph3_en    =>   pll_vco_ph3_en,
        pll_vco_ph4_en    =>   pll_vco_ph4_en,
        pll_vco_ph5_en    =>   pll_vco_ph5_en,
        pll_vco_ph6_en    =>   pll_vco_ph6_en,
        pll_vco_ph7_en    =>   pll_vco_ph7_en,
        pll_vctrl_test_voltage    =>   pll_vctrl_test_voltage,
        vccd0g_atb    =>   vccd0g_atb,
        vccd0g_output    =>   vccd0g_output,
        vccd1g_atb    =>   vccd1g_atb,
        vccd1g_output    =>   vccd1g_output,
        vccm1g_tap    =>   vccm1g_tap,
        vccr_pd    =>   vccr_pd,
        vcodiv_override    =>   vcodiv_override,
		fractional_pll_index    =>   fractional_pll_index
    )
    port  map  (
        coreclkfb    =>    coreclkfb,
        ecnc1test    =>    ecnc1test,
        ecnc2test    =>    ecnc2test,
        fbclkfpll    =>    fbclkfpll,
        lvdsfbin    =>    lvdsfbin,
        nresync    =>    nresync,
        pfden    =>    pfden,
        refclkin    =>    refclkin,
        shift    =>    shift,
        shiftdonein    =>    shiftdonein,
        shiften    =>    shiften,
        up    =>    up,
        vsspl    =>    vsspl,
        zdb    =>    zdb,
        cntnen    =>    cntnen,
        fbclk    =>    fbclk,
        fblvdsout    =>    fblvdsout,
        lock    =>    lock,
        mhi    =>    mhi,
        mcntout    =>    mcntout,
        plniotribuf    =>    plniotribuf,
        shiftdoneout    =>    shiftdoneout,
        tclk    =>    tclk,
        vcoph    =>    vcoph
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_half_rate_input    is
    generic    (
        power_up    :    string    :=    "low";
        async_mode    :    string    :=    "no_reset";
        use_dataoutbypass    :    string    :=    "false"
    );
    port    (
        datain    :    in    std_logic_vector(1 downto 0)	:= (OTHERS => '1');
        directin    :    in    std_logic	:= '1';
        clk    :    in    std_logic	:= '0';
        areset    :    in    std_logic	:= '0';
        dataoutbypass    :    in    std_logic	:= '0';
        dataout    :    out    std_logic_vector(3 downto 0);
        dffin    :    out    std_logic_vector(1 downto 0)
    );
end cyclonev_half_rate_input;

architecture behavior of cyclonev_half_rate_input is

component    cyclonev_half_rate_input_encrypted
    generic    (
        power_up    :    string    :=    "low";
        async_mode    :    string    :=    "no_reset";
        use_dataoutbypass    :    string    :=    "false"
    );
    port    (
        datain    :    in    std_logic_vector(1 downto 0)	:= (OTHERS => '1');
        directin    :    in    std_logic	:= '1';
        clk    :    in    std_logic	:= '0';
        areset    :    in    std_logic	:= '0';
        dataoutbypass    :    in    std_logic	:= '0';
        dataout    :    out    std_logic_vector(3 downto 0);
        dffin    :    out    std_logic_vector(1 downto 0)
    );
end component;

begin


inst : cyclonev_half_rate_input_encrypted
    generic  map  (
        power_up    =>   power_up,
        async_mode    =>   async_mode,
        use_dataoutbypass    =>   use_dataoutbypass
    )
    port  map  (
        datain    =>    datain,
        directin    =>    directin,
        clk    =>    clk,
        areset    =>    areset,
        dataoutbypass    =>    dataoutbypass,
        dataout    =>    dataout,
        dffin    =>    dffin
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_input_phase_alignment    is
    generic    (
        power_up    :    string    :=    "low";
        async_mode    :    string    :=    "no_reset";
        add_input_cycle_delay    :    string    :=    "false";
        bypass_output_register    :    string    :=    "false";
        add_phase_transfer_reg    :    string    :=    "false";
        lpm_type    :    string    :=    "cyclonev_input_phase_alignment"
    );
    port    (
        datain    :    in    std_logic	:= '1';
        levelingclk    :    in    std_logic	:= '0';
        zerophaseclk    :    in    std_logic	:= '0';
        areset    :    in    std_logic	:= '0';
        enainputcycledelay    :    in    std_logic	:= '0';
        enaphasetransferreg    :    in    std_logic	:= '0';
        dataout    :    out    std_logic;
        dffin    :    out    std_logic;
        dff1t    :    out    std_logic;
        dffphasetransfer    :    out    std_logic
    );
end cyclonev_input_phase_alignment;

architecture behavior of cyclonev_input_phase_alignment is

component    cyclonev_input_phase_alignment_encrypted
    generic    (
        power_up    :    string    :=    "low";
        async_mode    :    string    :=    "no_reset";
        add_input_cycle_delay    :    string    :=    "false";
        bypass_output_register    :    string    :=    "false";
        add_phase_transfer_reg    :    string    :=    "false";
        lpm_type    :    string    :=    "cyclonev_input_phase_alignment"
    );
    port    (
        datain    :    in    std_logic	:= '1';
        levelingclk    :    in    std_logic	:= '0';
        zerophaseclk    :    in    std_logic	:= '0';
        areset    :    in    std_logic	:= '0';
        enainputcycledelay    :    in    std_logic	:= '0';
        enaphasetransferreg    :    in    std_logic	:= '0';
        dataout    :    out    std_logic;
        dffin    :    out    std_logic;
        dff1t    :    out    std_logic;
        dffphasetransfer    :    out    std_logic
    );
end component;

begin


inst : cyclonev_input_phase_alignment_encrypted
    generic  map  (
        power_up    =>   power_up,
        async_mode    =>   async_mode,
        add_input_cycle_delay    =>   add_input_cycle_delay,
        bypass_output_register    =>   bypass_output_register,
        add_phase_transfer_reg    =>   add_phase_transfer_reg,
        lpm_type    =>   lpm_type
    )
    port  map  (
        datain    =>    datain,
        levelingclk    =>    levelingclk,
        zerophaseclk    =>    zerophaseclk,
        areset    =>    areset,
        enainputcycledelay    =>    enainputcycledelay,
        enaphasetransferreg    =>    enaphasetransferreg,
        dataout    =>    dataout,
        dffin    =>    dffin,
        dff1t    =>    dff1t,
        dffphasetransfer    =>    dffphasetransfer
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_io_clock_divider    is
    generic    (
        power_up    :    string    :=    "low";
        invert_phase    :    string    :=    "false";
        use_masterin    :    string    :=    "false";
        lpm_type    :    string    :=    "cyclonev_io_clock_divider"
    );
    port    (
        clk    :    in    std_logic	:= '0';
        phaseinvertctrl    :    in    std_logic	:= '0';
        masterin    :    in    std_logic	:= '0';
        clkout    :    out    std_logic;
        slaveout    :    out    std_logic
    );
end cyclonev_io_clock_divider;

architecture behavior of cyclonev_io_clock_divider is

component    cyclonev_io_clock_divider_encrypted
    generic    (
        power_up    :    string    :=    "low";
        invert_phase    :    string    :=    "false";
        use_masterin    :    string    :=    "false";
        lpm_type    :    string    :=    "cyclonev_io_clock_divider"
    );
    port    (
        clk    :    in    std_logic	:= '0';
        phaseinvertctrl    :    in    std_logic	:= '0';
        masterin    :    in    std_logic	:= '0';
        clkout    :    out    std_logic;
        slaveout    :    out    std_logic
    );
end component;

begin


inst : cyclonev_io_clock_divider_encrypted
    generic  map  (
        power_up    =>   power_up,
        invert_phase    =>   invert_phase,
        use_masterin    =>   use_masterin,
        lpm_type    =>   lpm_type
    )
    port  map  (
        clk    =>    clk,
        phaseinvertctrl    =>    phaseinvertctrl,
        masterin    =>    masterin,
        clkout    =>    clkout,
        slaveout    =>    slaveout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;

entity cyclonev_io_config is
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
end cyclonev_io_config;

architecture behavior of cyclonev_io_config is

component cyclonev_io_config_encrypted
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
end component;

begin

inst : cyclonev_io_config_encrypted
    generic map (
        lpm_type => lpm_type
    )
    port map (
        outputenabledelaysetting => outputenabledelaysetting,
        outputhalfratebypass => outputhalfratebypass,
        datain => datain,
        readfifomode => readfifomode,
        readfiforeadclockselect => readfiforeadclockselect,
        padtoinputregisterdelaysetting => padtoinputregisterdelaysetting,
        clk => clk,
        ena => ena,
        outputregdelaysetting => outputregdelaysetting,
        dataout => dataout,
        update => update
    );

end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_leveling_delay_chain    is
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
end cyclonev_leveling_delay_chain;

architecture behavior of cyclonev_leveling_delay_chain is

component    cyclonev_leveling_delay_chain_encrypted
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
end component;

begin


inst : cyclonev_leveling_delay_chain_encrypted
    generic  map  (
        physical_clock_source    =>   physical_clock_source,
        sim_buffer_intrinsic_delay    =>   sim_buffer_intrinsic_delay,
        sim_buffer_delay_increment    =>   sim_buffer_delay_increment
    )
    port  map  (
        clkin    =>    clkin,
        delayctrlin    =>    delayctrlin,
        clkout    =>    clkout
    );


end behavior;


library IEEE;
use IEEE.std_logic_1164.all;


entity cyclonev_mem_phy is
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
end cyclonev_mem_phy;

architecture behavior of cyclonev_mem_phy is

component cyclonev_mem_phy_encrypted
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
end component;

begin

inst : cyclonev_mem_phy_encrypted
    generic map (
        hphy_use_hphy => hphy_use_hphy,
        hphy_reset_delay_en => hphy_reset_delay_en,
        hphy_hhp_hps => hphy_hhp_hps,
        hphy_wrap_back_en => hphy_wrap_back_en,
        hphy_datapath_delay => hphy_datapath_delay,
        hphy_datapath_ac_delay => hphy_datapath_ac_delay,
        m_hphy_ac_rom_init_file => m_hphy_ac_rom_init_file,
        hphy_ac_ddr_disable => hphy_ac_ddr_disable,
        hphy_csr_pipelineglobalenable => hphy_csr_pipelineglobalenable,
        m_hphy_inst_rom_init_file => m_hphy_inst_rom_init_file,
        hphy_atpg_en => hphy_atpg_en
    )
    port map (
        iointaddrdout => iointaddrdout,
        iointresetndout => iointresetndout,
        iointckedout => iointckedout,
        afirlat => afirlat,
        iointdqoe => iointdqoe,
        afiaddr => afiaddr,
        cfgtwr => cfgtwr,
        afidm => afidm,
        afiwdatavalid => afiwdatavalid,
        avlread => avlread,
        phyddiockndout => phyddiockndout,
        iointckndout => iointckndout,
        iointbadout => iointbadout,
        cfgdevicewidth => cfgdevicewidth,
        cfgcoladdrwidth => cfgcoladdrwidth,
        iointdqdin => iointdqdin,
        scanen => scanen,
        afiwlat => afiwlat,
        phyddiodqsoe => phyddiodqsoe,
        cfgaddlat => cfgaddlat,
        afirdataen => afirdataen,
        phyddiodqslogicincrdataen => phyddiodqslogicincrdataen,
        phyddiodqslogicoct => phyddiodqslogicoct,
        iointdqsoe => iointdqsoe,
        phyddiodqslogicaclrpstamble => phyddiodqslogicaclrpstamble,
        phyddiodqsboe => phyddiodqsboe,
        phyddiodqdout => phyddiodqdout,
        iointaficalfail => iointaficalfail,
        avlwritedata => avlwritedata,
        iointdqsboe => iointdqsboe,
        phyddiodqslogicreadlatency => phyddiodqslogicreadlatency,
        iointwendout => iointwendout,
        afiodt => afiodt,
        iointcsndout => iointcsndout,
        phyddiorasndout => phyddiorasndout,
        phyddiocsndout => phyddiocsndout,
        iointdqslogicoct => iointdqslogicoct,
        softresetn => softresetn,
        phyddiodqsdout => phyddiodqsdout,
        iointafiwlat => iointafiwlat,
        iointdqslogicdqsena => iointdqslogicdqsena,
        afiba => afiba,
        phyddiodqslogicdqsena => phyddiodqslogicdqsena,
        pllavlclk => pllavlclk,
        aficasn => aficasn,
        cfgbankaddrwidth => cfgbankaddrwidth,
        phyddiowendout => phyddiowendout,
        phyddiockedout => phyddiockedout,
        cfgdramconfig => cfgdramconfig,
        aficsn => aficsn,
        avlwaitrequest => avlwaitrequest,
        phyddioodtdout => phyddioodtdout,
        ddiophydqslogicrdatavalid => ddiophydqslogicrdatavalid,
        avlwrite => avlwrite,
        afirasn => afirasn,
        plladdrcmdclk => plladdrcmdclk,
        phyddioaddrdout => phyddioaddrdout,
        aficalfail => aficalfail,
        afimemclkdisable => afimemclkdisable,
        afiwdata => afiwdata,
        iointdqslogicreadlatency => iointdqslogicreadlatency,
        phyddiodmdout => phyddiodmdout,
        pllaficlk => pllaficlk,
        cfgtrfc => cfgtrfc,
        iointckdout => iointckdout,
        aficke => aficke,
        iointrasndout => iointrasndout,
        phyddioresetndout => phyddioresetndout,
        aficalsuccess => aficalsuccess,
        ddiophydqdin => ddiophydqdin,
        iointcasndout => iointcasndout,
        iointdqsdout => iointdqsdout,
        cfgcsaddrwidth => cfgcsaddrwidth,
        phyddiockdout => phyddiockdout,
        avlreaddata => avlreaddata,
        afirdata => afirdata,
        phyresetn => phyresetn,
        iointdqslogicincrdataen => iointdqslogicincrdataen,
        afiwen => afiwen,
        globalresetn => globalresetn,
        phyddiodqsbdout => phyddiodqsbdout,
        plllocked => plllocked,
        phyddiodqslogicfiforeset => phyddiodqslogicfiforeset,
        iointdqslogicfiforeset => iointdqslogicfiforeset,
        iointodtdout => iointodtdout,
        iointafirlat => iointafirlat,
        iointaficalsuccess => iointaficalsuccess,
        iointdqdout => iointdqdout,
        cfgrowaddrwidth => cfgrowaddrwidth,
        phyddiodqslogicaclrfifoctrl => phyddiodqslogicaclrfifoctrl,
        phyddiobadout => phyddiobadout,
        afirdatavalid => afirdatavalid,
        cfgtrefi => cfgtrefi,
        cfgcaswrlat => cfgcaswrlat,
        afirstn => afirstn,
        avlresetn => avlresetn,
        iointdqsbdout => iointdqsbdout,
        phyddiodqoe => phyddiodqoe,
        iointdqslogicrdatavalid => iointdqslogicrdatavalid,
        avladdress => avladdress,
        afidqsburst => afidqsburst,
        iointdqslogicincwrptr => iointdqslogicincwrptr,
        phyddiodqslogicincwrptr => phyddiodqslogicincwrptr,
        cfgtcl => cfgtcl,
        ctlresetn => ctlresetn,
        cfginterfacewidth => cfginterfacewidth,
        phyddiocasndout => phyddiocasndout,
        afirdataenfull => afirdataenfull,
        cfgtmrd => cfgtmrd,
        iointdmdout => iointdmdout
    );

end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity cyclonev_phy_clkbuf is
    port (
        outclk : out std_logic_vector(3 downto 0);
        inclk : in std_logic_vector(3 downto 0) := (OTHERS => '0')
    );
end cyclonev_phy_clkbuf;

architecture behavior of cyclonev_phy_clkbuf is

component cyclonev_phy_clkbuf_encrypted
    port (
        outclk : out std_logic_vector(3 downto 0);
        inclk : in std_logic_vector(3 downto 0) := (OTHERS => '0')
    );
end component;

begin

inst : cyclonev_phy_clkbuf_encrypted
    port map (
        outclk => outclk,
        inclk => inclk
    );

end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_output_alignment    is
    generic    (
        power_up    :    string    :=    "low";
        async_mode    :    string    :=    "none";
        sync_mode    :    string    :=    "none";
        add_output_cycle_delay    :    string    :=    "false";
        add_2nd_output_cycle_delay    :    string    :=    "false";
        add_phase_transfer_reg    :    string    :=    "false";
        bypass_output_register    :    string    :=    "false"
    );
    port    (
        datain    :    in    std_logic	:= '1';
        clk    :    in    std_logic	:= '0';
        areset    :    in    std_logic	:= '0';
        sreset    :    in    std_logic	:= '0';
        enaoutputcycledelay    :    in    std_logic	:= '0';
        ena2ndoutputcycledelay    :    in    std_logic	:= '0';
        enaphasetransferreg    :    in    std_logic	:= '0';
        dataout    :    out    std_logic;
        dffin    :    out    std_logic;
        dff1t    :    out    std_logic;
        dff2t    :    out    std_logic;
        dffphasetransfer    :    out    std_logic
    );
end cyclonev_output_alignment;

architecture behavior of cyclonev_output_alignment is

component    cyclonev_output_alignment_encrypted
    generic    (
        power_up    :    string    :=    "low";
        async_mode    :    string    :=    "none";
        sync_mode    :    string    :=    "none";
        add_output_cycle_delay    :    string    :=    "false";
        add_2nd_output_cycle_delay    :    string    :=    "false";
        add_phase_transfer_reg    :    string    :=    "false";
        bypass_output_register    :    string    :=    "false"
    );
    port    (
        datain    :    in    std_logic	:= '1';
        clk    :    in    std_logic	:= '0';
        areset    :    in    std_logic	:= '0';
        sreset    :    in    std_logic	:= '0';
        enaoutputcycledelay    :    in    std_logic	:= '0';
        ena2ndoutputcycledelay    :    in    std_logic	:= '0';
        enaphasetransferreg    :    in    std_logic	:= '0';
        dataout    :    out    std_logic;
        dffin    :    out    std_logic;
        dff1t    :    out    std_logic;
        dff2t    :    out    std_logic;
        dffphasetransfer    :    out    std_logic
    );
end component;

begin


inst : cyclonev_output_alignment_encrypted
    generic  map  (
        power_up    =>   power_up,
        async_mode    =>   async_mode,
        sync_mode    =>   sync_mode,
        add_output_cycle_delay    =>   add_output_cycle_delay,
        add_2nd_output_cycle_delay    =>   add_2nd_output_cycle_delay,
        add_phase_transfer_reg    =>   add_phase_transfer_reg,
        bypass_output_register    =>   bypass_output_register
    )
    port  map  (
        datain    =>    datain,
        clk    =>    clk,
        areset    =>    areset,
        sreset    =>    sreset,
        enaoutputcycledelay    =>    enaoutputcycledelay,
        ena2ndoutputcycledelay    =>    ena2ndoutputcycledelay,
        enaphasetransferreg    =>    enaphasetransferreg,
        dataout    =>    dataout,
        dffin    =>    dffin,
        dff1t    =>    dff1t,
        dff2t    =>    dff2t,
        dffphasetransfer    =>    dffphasetransfer
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_pll_dll_output    is
    generic    (
        pll_dll_src    :    string    :=    "vss"
    );
    port    (
        cclk    :    in    std_logic_vector(17 downto 0);
        clkin    :    in    std_logic_vector(3 downto 0) := "0000";
        clkout    :    out    std_logic
    );
end cyclonev_pll_dll_output;

architecture behavior of cyclonev_pll_dll_output is

component    cyclonev_pll_dll_output_encrypted
    generic    (
        pll_dll_src    :    string    :=    "vss"
    );
    port    (
        cclk    :    in    std_logic_vector(17 downto 0);
        clkin    :    in    std_logic_vector(3 downto 0);
        clkout    :    out    std_logic
    );
end component;

begin


inst : cyclonev_pll_dll_output_encrypted
    generic  map  (
        pll_dll_src    =>   pll_dll_src
    )
    port  map  (
        cclk    =>    cclk,
        clkin    =>    clkin,
        clkout    =>    clkout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_pll_dpa_output    is
    generic    (
        output_clock_frequency    :    string    :=    "";
        pll_vcoph_div    :    integer    :=    1
    );
    port    (
        pd    :    in    std_logic;
        phin    :    in    std_logic_vector(7 downto 0);
        phout    :    out    std_logic_vector(7 downto 0)
    );
end cyclonev_pll_dpa_output;

architecture behavior of cyclonev_pll_dpa_output is

component    cyclonev_pll_dpa_output_encrypted
    generic    (
        output_clock_frequency    :    string    :=    "";
        pll_vcoph_div    :    integer    :=    1
    );
    port    (
        pd    :    in    std_logic;
        phin    :    in    std_logic_vector(7 downto 0);
        phout    :    out    std_logic_vector(7 downto 0)
    );
end component;

begin


inst : cyclonev_pll_dpa_output_encrypted
    generic  map  (
    	output_clock_frequency	=>	output_clock_frequency,
        pll_vcoph_div    =>   pll_vcoph_div
    )
    port  map  (
        pd    =>    pd,
        phin    =>    phin,
        phout    =>    phout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_pll_extclk_output    is
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
end cyclonev_pll_extclk_output;

architecture behavior of cyclonev_pll_extclk_output is

component    cyclonev_pll_extclk_output_encrypted
    generic    (
        pll_extclk_cnt_src    :    string    :=    "vss";
        pll_extclk_enable    :    string    :=    "true";
        pll_extclk_invert    :    string    :=    "false"
    );
    port    (
        cclk    :    in    std_logic_vector(17 downto 0);
        clken    :    in    std_logic;
        mcnt0    :    in    std_logic;
        mcnt1    :    in    std_logic;
        extclk    :    out    std_logic
    );
end component;

begin


inst : cyclonev_pll_extclk_output_encrypted
    generic  map  (
        pll_extclk_cnt_src    =>   pll_extclk_cnt_src,
        pll_extclk_enable    =>   pll_extclk_enable,
        pll_extclk_invert    =>   pll_extclk_invert
    )
    port  map  (
        cclk    =>    cclk,
        clken    =>    clken,
        mcnt0    =>    mcnt0,
        mcnt1    =>    mcnt1,
        extclk    =>    extclk
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_pll_lvds_output    is
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
end cyclonev_pll_lvds_output;

architecture behavior of cyclonev_pll_lvds_output is

component    cyclonev_pll_lvds_output_encrypted
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
end component;

begin


inst : cyclonev_pll_lvds_output_encrypted
    generic  map  (
        pll_loaden_coarse_dly    =>   pll_loaden_coarse_dly,
        pll_loaden_fine_dly    =>   pll_loaden_fine_dly,
        pll_lvdsclk_coarse_dly    =>   pll_lvdsclk_coarse_dly,
        pll_lvdsclk_fine_dly    =>   pll_lvdsclk_fine_dly,
        pll_loaden_enable_disable    =>   pll_loaden_enable_disable,
        pll_lvdsclk_enable_disable    =>   pll_lvdsclk_enable_disable
    )
    port  map  (
        ccout    =>    ccout,
        loaden    =>    loaden,
        lvdsclk    =>    lvdsclk
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_pll_output_counter    is
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
end cyclonev_pll_output_counter;

architecture behavior of cyclonev_pll_output_counter is

component    cyclonev_pll_output_counter_encrypted
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
end component;

begin


inst : cyclonev_pll_output_counter_encrypted
    generic  map  (
        duty_cycle    =>   duty_cycle,
        output_clock_frequency    =>   output_clock_frequency,
        phase_shift    =>   phase_shift,
        c_cnt_coarse_dly    =>   c_cnt_coarse_dly,
        c_cnt_fine_dly    =>   c_cnt_fine_dly,
        c_cnt_in_src    =>   c_cnt_in_src,
        c_cnt_ph_mux_prst    =>   c_cnt_ph_mux_prst,
        cnt_fpll_src    =>   cnt_fpll_src,
        c_cnt_prst    =>   c_cnt_prst,
        dprio0_cnt_bypass_en    =>   dprio0_cnt_bypass_en,
        dprio0_cnt_hi_div    =>   dprio0_cnt_hi_div,
        dprio0_cnt_lo_div    =>   dprio0_cnt_lo_div,
        dprio0_cnt_odd_div_even_duty_en    =>   dprio0_cnt_odd_div_even_duty_en,
		fractional_pll_index    =>   fractional_pll_index,
        output_counter_index    =>   output_counter_index
    )
    port  map  (
        cascadein    =>    cascadein,
        nen0    =>    nen0,
        shift0    =>    shift0,
        shiftdone0i    =>    shiftdone0i,
        shiften    =>    shiften,
        tclk0    =>    tclk0,
        up0    =>    up0,
        vco0ph    =>    vco0ph,
        cascadeout    =>    cascadeout,     
        divclk    =>    divclk,
        shiftdone0o    =>    shiftdone0o
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_pll_reconfig    is
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
end cyclonev_pll_reconfig;

architecture behavior of cyclonev_pll_reconfig is

component    cyclonev_pll_reconfig_encrypted
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
end component;

begin


inst : cyclonev_pll_reconfig_encrypted
   generic  map  (
		fractional_pll_index    =>   fractional_pll_index
    )
    port  map  (
        addr    =>    addr,
        atpgmode    =>    atpgmode,
        byteen    =>    byteen,
        clk    =>    clk,
        cntnen    =>    cntnen,
        cntsel    =>    cntsel,
        din    =>    din,
        fpllcsrtest    =>    fpllcsrtest,
        iocsrclkin    =>    iocsrclkin,
        iocsrdatain    =>    iocsrdatain,
        iocsren    =>    iocsren,
        iocsrrstn    =>    iocsrrstn,
        mdiodis    =>    mdiodis,
        mhi    =>    mhi,
        phaseen    =>    phaseen,
        read    =>    read,
        rstn    =>    rstn,
        scanen    =>    scanen,
        sershiftload    =>    sershiftload,
        shiftdonei    =>    shiftdonei,
        updn    =>    updn,
        write    =>    write,
        blockselect    =>    blockselect,
        dout    =>    dout,
        dprioout    =>    dprioout,
        iocsrdataout    =>    iocsrdataout,
        iocsrenbuf    =>    iocsrenbuf,
        iocsrrstnbuf    =>    iocsrrstnbuf,
        phasedone    =>    phasedone,
        shift    =>    shift,
        shiften    =>    shiften,
        shiftenm    =>    shiftenm,
        up    =>    up
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_pll_refclk_select    is
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
end cyclonev_pll_refclk_select;

architecture behavior of cyclonev_pll_refclk_select is

component    cyclonev_pll_refclk_select_encrypted
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
end component;

begin


inst : cyclonev_pll_refclk_select_encrypted
    generic  map  (
        pll_auto_clk_sw_en    =>   pll_auto_clk_sw_en,
        pll_clk_loss_edge    =>   pll_clk_loss_edge,
        pll_clk_loss_sw_en    =>   pll_clk_loss_sw_en,
        pll_clk_sw_dly    =>   pll_clk_sw_dly,
        pll_clkin_0_src    =>   pll_clkin_0_src,
        pll_clkin_1_src    =>   pll_clkin_1_src,
        pll_manu_clk_sw_en    =>   pll_manu_clk_sw_en,
        pll_sw_refclk_src    =>   pll_sw_refclk_src
    )
    port  map  (
    	adjpllin    =>    adjpllin,
    	cclk    =>    cclk,
    	clkin    =>    clkin,
    	coreclkin    =>    coreclkin,
        extswitch    =>    extswitch,
        iqtxrxclkin    =>    iqtxrxclkin,
        plliqclkin    =>    plliqclkin,
        refiqclk    =>    refiqclk,
        rxiqclkin    =>    rxiqclkin,
        pllen    =>    pllen,	
        clk0bad    =>    clk0bad,
        clk1bad    =>    clk1bad,
        clkout    =>    clkout,
        extswitchbuf    =>    extswitchbuf,
        pllclksel    =>    pllclksel
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_termination_logic    is
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
end cyclonev_termination_logic;

architecture behavior of cyclonev_termination_logic is

component    cyclonev_termination_logic_encrypted
    generic    (
        lpm_type    :    string    :=    "cyclonev_termination_logic";
		a_iob_oct_test : string := "a_iob_oct_test_off"
    );
    port    (
        s2pload : in std_logic;
        serdata : in std_logic;
        scanenable : in std_logic;
        scanin : in std_logic;
        scanclk : in std_logic;
        scanout : out std_logic;
        seriesterminationcontrol : out std_logic_vector(15 downto 0);
        parallelterminationcontrol : out std_logic_vector(15 downto 0)
    );
end component;

begin

inst : cyclonev_termination_logic_encrypted
    generic  map  (
        lpm_type => lpm_type,
		a_iob_oct_test => a_iob_oct_test
    )
    port  map  (
        s2pload => s2pload,
        serdata => serdata,
        scanenable => scanenable,
        scanin => scanin,
        scanclk => scanclk,
        scanout => scanout,
        seriesterminationcontrol => seriesterminationcontrol,
        parallelterminationcontrol => parallelterminationcontrol
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_termination    is
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
end cyclonev_termination;

architecture behavior of cyclonev_termination is

component    cyclonev_termination_encrypted
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
        rzqin : in std_logic;
        enserusr : in std_logic;
        nclrusr : in std_logic;
        clkenusr : in std_logic;
        clkusr : in std_logic;
        serdatafromcore : in std_logic;
        scanclk : in std_logic;
        otherenser : in std_logic_vector(8 downto 0);
        serdataout : out std_logic;
        enserout : out std_logic;
        compoutrup : out std_logic;
        compoutrdn : out std_logic;
        serdatatocore : out std_logic;
        scanin  : out std_logic;
        scanout : out std_logic
    );
end component;

begin


inst : cyclonev_termination_encrypted
    generic  map  (
        lpm_type    =>   lpm_type,
        a_oct_nclrusr_inv => a_oct_nclrusr_inv,
        a_oct_pwrdn => a_oct_pwrdn,
        a_oct_clkdiv => a_oct_clkdiv,
        a_oct_intosc => a_oct_intosc,
        a_oct_vref => a_oct_vref,
        a_oct_test_0 => a_oct_test_0,
        a_oct_test_1 => a_oct_test_1,
        a_oct_test_2 => a_oct_test_2,
        a_oct_test_3 => a_oct_test_3,
        a_oct_test_4 => a_oct_test_4,
        a_oct_test_5 => a_oct_test_5,
        a_oct_pllbiasen => a_oct_pllbiasen,
        a_oct_usermode => a_oct_usermode
    )
    port  map  (
        rzqin => rzqin,
        enserusr => enserusr,
        nclrusr => nclrusr,
        clkenusr => clkenusr,
        clkusr => clkusr,
        serdatafromcore => serdatafromcore,
        scanclk => scanclk,
        otherenser => otherenser,
        serdataout => serdataout,
        enserout => enserout,
        compoutrup => compoutrup,
        compoutrdn => compoutrdn,
        serdatatocore => serdatatocore,
        scanin => scanin,
        scanout => scanout
    );

end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_asmiblock    is
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
end cyclonev_asmiblock;

architecture behavior of cyclonev_asmiblock is

component    cyclonev_asmiblock_encrypted
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
end component;

begin


inst : cyclonev_asmiblock_encrypted
    generic  map  (
        lpm_type    =>   lpm_type,
		enable_sim  =>	 enable_sim
    )
    port  map  (
        dclk    	=>    dclk,
        sce    		=>    sce,
        oe    		=>    oe,
        data0out    =>    data0out,
        data1out    =>    data1out,
        data2out    =>    data2out,
        data3out    =>    data3out,
        data0oe    	=>    data0oe,
        data1oe    	=>    data1oe,
        data2oe    	=>    data2oe,
        data3oe    	=>    data3oe,
        data0in    	=>    data0in,
        data1in    	=>    data1in,
        data2in    	=>    data2in,
        data3in    	=>    data3in,
		spidclk    	=>    spidclk,
		spidataout  =>    spidataout,
		spisce    	=>    spisce,
		spidatain   =>    spidatain
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_chipidblock    is
    generic    (
        lpm_type    :    string    :=    "cyclonev_chipidblock";
		ID_VALUE	:	 std_logic_vector(63 downto 0) := (others => '1')
    );
    port    (
        clk    :    in    std_logic;
        shiftnld    :    in    std_logic;
        regout    :    out    std_logic
    );
end cyclonev_chipidblock;

architecture behavior of cyclonev_chipidblock is

component    cyclonev_chipidblock_encrypted
    generic    (
        lpm_type    :    string    :=    "cyclonev_chipidblock";
		ID_VALUE	:	 std_logic_vector(63 downto 0) := (others => '1')
    );
    port    (
        clk    :    in    std_logic;
        shiftnld    :    in    std_logic;
        regout    :    out    std_logic
    );
end component;

begin


inst : cyclonev_chipidblock_encrypted
    generic  map  (
        lpm_type    =>   lpm_type,
		ID_VALUE	=>	 ID_VALUE
    )
    port  map  (
        clk    =>    clk,
        shiftnld    =>    shiftnld,
        regout    =>    regout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_controller    is
    generic    (
        lpm_type    :    string    :=    "cyclonev_controller"
    );
    port    (
        nceout    :    out    std_logic
    );
end cyclonev_controller;

architecture behavior of cyclonev_controller is

component    cyclonev_controller_encrypted
    generic    (
        lpm_type    :    string    :=    "cyclonev_controller"
    );
    port    (
        nceout    :    out    std_logic
    );
end component;

begin


inst : cyclonev_controller_encrypted
    generic  map  (
        lpm_type    =>   lpm_type
    )
    port  map  (
        nceout    =>    nceout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_crcblock    is
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
end cyclonev_crcblock;

architecture behavior of cyclonev_crcblock is

component    cyclonev_crcblock_encrypted
    generic    (
        oscillator_divider    		:    integer    :=    256;
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
end component;

begin

inst : cyclonev_crcblock_encrypted
    generic  map  (
        oscillator_divider  		=>   oscillator_divider,
		error_delay    				=>   error_delay,
		error_dra_dl_bypass 		=>   error_dra_dl_bypass,
		crc_deld_disable    		=>   crc_deld_disable,
		triple_adj_err_correction	=>   triple_adj_err_correction,
		quad_adj_err_correction    	=>   quad_adj_err_correction,
        lpm_type    =>   lpm_type
    )
    port  map  (
        clk    			=>    clk,
        shiftnld   		=>    shiftnld,
        crcerror    	=>    crcerror,
        regout    		=>    regout,
		endofedfullchip	=> endofedfullchip
    );

end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_jtag    is
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
end cyclonev_jtag;

architecture behavior of cyclonev_jtag is

component    cyclonev_jtag_encrypted
    generic    (
        lpm_type    :    string    :=    "cyclonev_jtag"
    );
    port    (
        tms    :    in    std_logic;
        tck    :    in    std_logic;
        tdi    :    in    std_logic;
        ntrst    :    in    std_logic;
        tdoutap    :    in    std_logic;
        tdouser    :    in    std_logic;
        corectl    :    in    std_logic;
        ntdopinena    :    in    std_logic;
        tckcore    :    in    std_logic;
        tdicore    :    in    std_logic;
        tmscore    :    in    std_logic;

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
end component;

begin


inst : cyclonev_jtag_encrypted
    generic  map  (
        lpm_type    =>   lpm_type
    )
    port  map  (
        tms    =>    tms,
        tck    =>    tck,
        tdi    =>    tdi,
        ntrst    =>    ntrst,
        tdoutap    =>    tdoutap,
        tdouser    =>    tdouser,
        corectl    =>    corectl,
        ntdopinena =>    ntdopinena,
        tckcore    =>    tckcore,
        tdicore    =>    tdicore,
        tmscore    =>    tmscore,

        tdocore    =>    tdocore,
        tdo        =>    tdo,
        tmsutap    =>    tmsutap,
        tckutap    =>    tckutap,
        tdiutap    =>    tdiutap,
        shiftuser    =>    shiftuser,
        clkdruser    =>    clkdruser,
        updateuser    =>    updateuser,
        runidleuser    =>    runidleuser,
        usr1user    =>    usr1user
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_prblock    is
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
end cyclonev_prblock;

architecture behavior of cyclonev_prblock is

component    cyclonev_prblock_encrypted
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
end component;

begin


inst : cyclonev_prblock_encrypted
    generic  map  (
        lpm_type    =>   lpm_type
    )
    port  map  (
        clk    =>    clk,
        corectl    =>    corectl,
        prrequest    =>    prrequest,
        data    =>    data,
        externalrequest    =>    externalrequest,
        error    =>    error,
        ready    =>    ready,
        done    =>    done
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_rublock    is
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
end cyclonev_rublock;

architecture behavior of cyclonev_rublock is

component    cyclonev_rublock_encrypted
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
end component;

begin


inst : cyclonev_rublock_encrypted
    generic  map  (
        sim_init_watchdog_value    =>   sim_init_watchdog_value,
        sim_init_status    =>   sim_init_status,
        sim_init_config_is_application    =>   sim_init_config_is_application,
        sim_init_watchdog_enabled    =>   sim_init_watchdog_enabled,
        lpm_type    =>   lpm_type
    )
    port  map  (
        clk    =>    clk,
        shiftnld    =>    shiftnld,
        captnupdt    =>    captnupdt,
        regin    =>    regin,
        rsttimer    =>    rsttimer,
        rconfig    =>    rconfig,
        regout    =>    regout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_tsdblock    is
    generic    (
        clock_divider_enable    :    string    :=    "on";
        clock_divider_value    :    integer    :=    40;
        sim_tsdcalo    :    integer    :=    0;
        lpm_type    :    string    :=    "cyclonev_tsdblock"
    );
    port    (
        clk    :    in    std_logic;
        ce    :    in    std_logic;
        clr    :    in    std_logic;
        tsdcalo    :    out    std_logic_vector(7 downto 0);
        tsdcaldone    :    out    std_logic
    );
end cyclonev_tsdblock;

architecture behavior of cyclonev_tsdblock is

component    cyclonev_tsdblock_encrypted
    generic    (
        clock_divider_enable    :    string    :=    "on";
        clock_divider_value    :    integer    :=    40;
        sim_tsdcalo    :    integer    :=    0;
        lpm_type    :    string    :=    "cyclonev_tsdblock"
    );
    port    (
        clk    :    in    std_logic;
        ce    :    in    std_logic;
        clr    :    in    std_logic;
        tsdcalo    :    out    std_logic_vector(7 downto 0);
        tsdcaldone    :    out    std_logic
    );
end component;

begin


inst : cyclonev_tsdblock_encrypted
    generic  map  (
        clock_divider_enable    =>   clock_divider_enable,
        clock_divider_value    =>   clock_divider_value,
        sim_tsdcalo    =>   sim_tsdcalo,
        lpm_type    =>   lpm_type
    )
    port  map  (
        clk    =>    clk,
        ce    =>    ce,
        clr    =>    clr,
        tsdcalo    =>    tsdcalo,
        tsdcaldone    =>    tsdcaldone
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_read_fifo    is
    generic    (
        use_half_rate_read    :    string    :=    "false"
    );
    port    (
    	datain	:	in std_logic_vector(1 downto 0)	:= (OTHERS => '0');
        wclk	: in std_logic	:= '0';
        we	: in std_logic	:= '0';
        rclk : in std_logic	:= '0';
        re : in std_logic	:= '0';
        areset : in std_logic	:= '0';
        plus2 : in std_logic	:= '0';
        dataout : out std_logic_vector(3 downto 0)
    );
end cyclonev_read_fifo;

architecture behavior of cyclonev_read_fifo is

component    cyclonev_read_fifo_encrypted
    generic    (
        use_half_rate_read    :    string    :=    "false"
    );
    port    (
        datain	:	in std_logic_vector(1 downto 0)	:= (OTHERS => '0');
        wclk	: in std_logic	:= '0';
        we	: in std_logic	:= '0';
        rclk : in std_logic	:= '0';	
        re : in std_logic	:= '0';
        areset : in std_logic	:= '0';
        plus2 : in std_logic	:= '0';
        dataout : out std_logic_vector(3 downto 0)
    );
end component;

begin


inst : cyclonev_read_fifo_encrypted
    generic  map  (
        use_half_rate_read    =>   use_half_rate_read
    )
    port  map  (
    	datain => datain,
    	wclk => wclk,
    	we => we,
    	rclk => rclk,
    	re => re,
    	areset => areset,
    	plus2 => plus2,
    	dataout => dataout
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_read_fifo_read_enable    is
    generic    (
        use_stalled_read_enable    :    string    :=    "false"
    );
    port    (
    	re	:	in std_logic	:= '1';
    	rclk	:	in std_logic	:= '0';
        plus2	:	in std_logic	:= '0';
        areset	:	in std_logic	:= '0';
        reout	: 	out std_logic;
        plus2out	:	out std_logic
    );
end cyclonev_read_fifo_read_enable;

architecture behavior of cyclonev_read_fifo_read_enable is

component    cyclonev_read_fifo_read_enable_encrypted
    generic    (
        use_stalled_read_enable    :    string    :=    "false"
    );
    port    (
    	re	:	in std_logic	:= '1';
    	rclk	:	in std_logic	:= '0';
    	plus2	:	in std_logic	:= '0';
    	areset	:	in std_logic	:= '0';
    	reout	:	out std_logic;
    	plus2out	:	out std_logic	
    );
end component;

begin


inst : cyclonev_read_fifo_read_enable_encrypted
    generic  map  (
        use_stalled_read_enable    =>   use_stalled_read_enable
    )
    port  map  (
    	re => re,
    	rclk => rclk,
    	plus2 => plus2,
    	areset => areset,
    	reout => reout,
    	plus2out => plus2out
    );


end behavior;

library IEEE;
use IEEE.std_logic_1164.all;

entity	cyclonev_mac	is
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
end cyclonev_mac;

architecture behavior of cyclonev_mac is

component    cyclonev_mac_encrypted
    generic    (
        ax_width	:				integer;
        ay_scan_in_width	:    	integer;
        az_width    :    			integer;
        bx_width    :    			integer;
        by_width    :    			integer;
        bz_width    :    			integer;
        scan_out_width    :    		integer;
        result_a_width    :    		integer;
        result_b_width    :   		integer;

        operation_mode    :    		string;
        mode_sub_location    :    	integer;
        operand_source_max    :   	string;
        operand_source_may    :    	string;
        operand_source_mbx    :    	string;
        operand_source_mby    :   	string;
        preadder_subtract_a    :    string;
        preadder_subtract_b    :    string;
        signed_max    :    			string;
        signed_may    :    			string;
        signed_mbx    :    			string;
        signed_mby    :    			string;

        ay_use_scan_in    :    		string;
        by_use_scan_in    :    		string;
        delay_scan_out_ay    :    	string;
        delay_scan_out_by    :    	string;
        use_chainadder    :    		string;
        enable_double_accum    :    string;
        load_const_value    :    	integer;

        coef_a_0    :    integer;
        coef_a_1    :    integer;
        coef_a_2    :    integer;
        coef_a_3    :    integer;
        coef_a_4    :    integer;
        coef_a_5    :    integer;
        coef_a_6    :    integer;
        coef_a_7    :    integer;
        coef_b_0    :    integer;
        coef_b_1    :    integer;
        coef_b_2    :    integer;
        coef_b_3    :    integer;
        coef_b_4    :    integer;
        coef_b_5    :    integer;
        coef_b_6    :    integer;
        coef_b_7    :    integer;

        ax_clock    :    			string;
        ay_scan_in_clock    :    	string;
        az_clock    :    			string;
        bx_clock    :    			string;
        by_clock    :    			string;
        bz_clock    :    			string;
        coef_sel_a_clock    :    	string;
        coef_sel_b_clock    :    	string;
        sub_clock    :    			string;
        negate_clock    :    		string;
        accumulate_clock    :    	string;
        load_const_clock    :    	string;
        output_clock    :    		string
    );
    port    (
        sub    :    in    		std_logic;
        negate    :    in    	std_logic;
        accumulate    :    in   std_logic;
        loadconst    :    in    std_logic;
        ax    :    in    		std_logic_vector(ax_width-1 downto 0);
        ay    :    in    		std_logic_vector(ay_scan_in_width-1 downto 0);
        scanin    :    in    	std_logic_vector(ay_scan_in_width-1 downto 0);
        az    :    in    		std_logic_vector(az_width-1 downto 0);
        bx    :    in    		std_logic_vector(bx_width-1 downto 0);
        by    :    in    		std_logic_vector(by_width-1 downto 0);
        bz    :    in    		std_logic_vector(bz_width-1 downto 0);
        coefsela    :    in    	std_logic_vector(2 downto 0);
        coefselb    :    in    	std_logic_vector(2 downto 0);
        chainin    :    in    	std_logic_vector(63 downto 0);
        clk    :    in    		std_logic_vector(2 downto 0);
        aclr    :    in    		std_logic_vector(1 downto 0);
        ena    :    in    		std_logic_vector(2 downto 0);
        dftout    :    out    	std_logic;
        resulta    :    out    	std_logic_vector(result_a_width-1 downto 0);
        resultb    :    out    	std_logic_vector(result_b_width-1 downto 0);
        scanout    :    out    	std_logic_vector(scan_out_width-1 downto 0);
        chainout    :    out    std_logic_vector(63 downto 0)
    );
end component;

begin

inst : cyclonev_mac_encrypted
    generic map   (
        ax_width    =>   ax_width,
        ay_scan_in_width    =>   ay_scan_in_width,
        az_width    =>   az_width,
        bx_width    =>   bx_width,
        by_width    =>   by_width,
        bz_width    =>   bz_width,
        scan_out_width    =>   scan_out_width,
        result_a_width    =>   result_a_width,
        result_b_width    =>   result_b_width,
		
        operation_mode    =>   operation_mode,
        mode_sub_location    =>   mode_sub_location,
        operand_source_max    =>   operand_source_max,
        operand_source_may    =>   operand_source_may,
        operand_source_mbx    =>   operand_source_mbx,
        operand_source_mby    =>   operand_source_mby,
        preadder_subtract_a    =>   preadder_subtract_a,
        preadder_subtract_b    =>   preadder_subtract_b,
        signed_max    =>   signed_max,
        signed_may    =>   signed_may,
        signed_mbx    =>   signed_mbx,
        signed_mby    =>   signed_mby,

        ay_use_scan_in    =>   ay_use_scan_in,
        by_use_scan_in    =>   by_use_scan_in,
        delay_scan_out_ay    =>   delay_scan_out_ay,
        delay_scan_out_by    =>   delay_scan_out_by,
        use_chainadder    =>   use_chainadder,
        enable_double_accum    =>   enable_double_accum,
        load_const_value    =>   load_const_value,

        coef_a_0    =>   coef_a_0,
        coef_a_1    =>   coef_a_1,
        coef_a_2    =>   coef_a_2,
        coef_a_3    =>   coef_a_3,
        coef_a_4    =>   coef_a_4,
        coef_a_5    =>   coef_a_5,
        coef_a_6    =>   coef_a_6,
        coef_a_7    =>   coef_a_7,
        coef_b_0    =>   coef_b_0,
        coef_b_1    =>   coef_b_1,
        coef_b_2    =>   coef_b_2,
        coef_b_3    =>   coef_b_3,
        coef_b_4    =>   coef_b_4,
        coef_b_5    =>   coef_b_5,
        coef_b_6    =>   coef_b_6,
        coef_b_7    =>   coef_b_7,

        ax_clock    =>   ax_clock,
        ay_scan_in_clock    =>   ay_scan_in_clock,
        az_clock    =>   az_clock,
        bx_clock    =>   bx_clock,
        by_clock    =>   by_clock,
        bz_clock    =>   bz_clock,
        coef_sel_a_clock    =>   coef_sel_a_clock,
        coef_sel_b_clock    =>   coef_sel_b_clock,
        sub_clock    =>   sub_clock,
        negate_clock    =>   negate_clock,
        accumulate_clock    =>   accumulate_clock,
        load_const_clock    =>   load_const_clock,
        output_clock    =>   output_clock
    )
    port map  (
        sub    =>    sub,
        negate    =>    negate,
        accumulate    =>    accumulate,
        loadconst    =>    loadconst,
        ax    =>    ax,
        ay    =>    ay,
        scanin    =>    scanin,
        az    =>    az,
        bx    =>    bx,
        by    =>    by,
        bz    =>    bz,
        coefsela    =>    coefsela,
        coefselb    =>    coefselb,
        chainin    =>    chainin,
        clk    =>    clk,
        aclr    =>    aclr,
        ena    =>    ena,
        dftout    =>    dftout,
        resulta    =>    resulta,
        resultb    =>    resultb,
        scanout    =>    scanout,
        chainout    =>    chainout
   );

end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity cyclonev_ir_fifo_userdes is
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
end cyclonev_ir_fifo_userdes;

architecture behavior of cyclonev_ir_fifo_userdes is

component cyclonev_ir_fifo_userdes_encrypted
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
end component;

begin

inst : cyclonev_ir_fifo_userdes_encrypted
    generic map (
        a_rb_bypass_serializer => a_rb_bypass_serializer,
        a_use_dynamic_fifo_mode => a_use_dynamic_fifo_mode,
        a_rb_fifo_mode => a_rb_fifo_mode,
        a_rb_data_width => a_rb_data_width,
        a_enable_soft_cdr => a_enable_soft_cdr,
        a_rb_tx_outclk => a_rb_tx_outclk,
        a_rb_bslipcfg => a_rb_bslipcfg,
        a_sim_wclk_pre_delay => a_sim_wclk_pre_delay,
        a_sim_readenable_pre_delay => a_sim_readenable_pre_delay
    )
    port map (
        bslipmax => bslipmax,
        dynfifomode => dynfifomode,
        observableout => observableout,
        writeenable => writeenable,
        readclk => readclk,
        txin => txin,
        regscanovrd => regscanovrd,
        rxout => rxout,
        bslipout => bslipout,
        rstn => rstn,
        loaden => loaden,
        lvdsmodeen => lvdsmodeen,
        bslipctl => bslipctl,
        observablefout3 => observablefout3,
        scanin => scanin,
        readenable => readenable,
        scanout => scanout,
        writeclk => writeclk,
        observablefout2 => observablefout2,
        dinfiforx => dinfiforx,
        tstclk => tstclk,
        observablefout4 => observablefout4,
        observablefout1 => observablefout1,
        dout => dout,
        bslipin => bslipin,
        txout => txout,
        regscan => regscan,
        observablewaddrcnt => observablewaddrcnt,
        lvdstxsel => lvdstxsel
    );

end behavior;

library IEEE;
use IEEE.std_logic_1164.all;


entity    cyclonev_oscillator    is
    generic    (
        lpm_type    :    string    :=    "cyclonev_oscillator");
    port    (
        oscena    :    in    std_logic;
        clkout    :    out    std_logic;
        clkout1   :    out    std_logic
    );
end cyclonev_oscillator;

architecture behavior of cyclonev_oscillator is

component    cyclonev_oscillator_encrypted
    generic    (
        lpm_type    :    string    :=    "cyclonev_oscillator");
    port    (
        oscena    :    in    std_logic;
        clkout    :    out    std_logic;
        clkout1   :    out    std_logic
    );
end component;

begin


inst : cyclonev_oscillator_encrypted
    generic  map  (
        lpm_type    =>   lpm_type
    )
    port  map  (
        oscena    =>    oscena,
        clkout    =>    clkout,
        clkout1    =>    clkout1
    );


end behavior;
