-------------------------------------------------------------------------------
-- Model Title: Voltage Source - Gaussian pulse
-- Entity Name: vsrc_gaussian_pulse
-- Author: Vladimir Kolchuzhin <vladimir.kolchuzhin@ieee.org>
-- Created: 2021/01/07

-- Library: kvl in hAMSter 
-------------------------------------------------------------------------------
-- ID: vsrc_gaussian_pulse.vhd
-- Last update: ver. 1.0 
-- status: tested
-------------------------------------------------------------------------------
-- Description: Ideal Gaussian pulse electrical voltage source
-- 
-- This model is an ideal voltage source, zero (Thevenin) source impedance. 
-- It drives the differential voltage across its terminals (from pos to neg) 
-- to the values specified by the generic parameters:
-- 	pulse_value is the height of the curve's peak, [V]
-- 	start_delay (tau) is the position of the center of the peak, [sec]
-- 	pulse_width is the standard deviation [sec]
-------------------------------------------------------------------------------
library IEEE;
use IEEE.MATH_REAL.all;

-- SystemVision
--use IEEE.electrical_systems.all;
--use IEEE.energy_systems.all;
-- hAMSter
use work.electromagnetic_system.all;
use work.all;


entity vsrc_gaussian_pulse is
  generic (
           pulse_value  : real;           -- pulse_value is the height of the curve's peak, 1 [V] (real==voltage)
           start_delay  : real := 0.0;    -- start_delay (tau) is the position of the center of the peak, 3.0E-09 [sec]
           pulse_width  : real);          -- pulse_width is the standard deviation 0.25E-09 [sec] / Tend = 6ns
  port (terminal pos, neg : electrical);	
end entity vsrc_gaussian_pulse;

  
architecture basic of vsrc_gaussian_pulse is
  quantity v across i through pos to neg;
 
begin

  if domain = quiescent_domain or domain = time_domain use
    v == pulse_value*exp(-((now-start_delay)**2)/(2.0*pulse_width**2)); 
  else
    v == 0.0;
  end use;

end architecture basic;