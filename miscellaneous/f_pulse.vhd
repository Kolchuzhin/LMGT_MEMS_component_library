-------------------------------------------------------------------------------
-- Model: pulse force source
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@etit.tu-chemnitz.de>
-- Date: 06.01.2012

-- Library: kvl in hAMSter
-------------------------------------------------------------------------------
-- ID: f_pulse.vhd
-- ver. 1.0 
-- status: 1T triangular pulse OK
-------------------------------------------------------------------------------
-- pulse parameters:
-- VL low
-- VH high
-- TD delay time
-- TR rise time
-- TF fall time
-- TW pulse width
-- PER period
--
-------------------------------------------------------------------------------
library ieee;
use work.electromagnetic_system.all;
use work.all;
use ieee.math_real.all;


entity f_pulse is
  generic (dc_value,ac_value,period:real); -- generic parameters
  port (terminal p,n:translational);	   -- interface ports
end entity f_pulse;


architecture basic of f_pulse is
  quantity u across f through p to n;

begin

 if now <= period/2.0 use         
	f == dc_value - ac_value + ( (ac_value*2.0)/(period/2.0) ) * now;
  end use;
  if now > period/2.0 and now <= period use
	f == dc_value + ac_value*1.0 - ( (ac_value*2.0)/(period/2.0) ) * (now - period/2.0);
  end use;
  if now > period use
	f == 0.0;
 end use;

end architecture basic;
-------------------------------------------------------------------------------
