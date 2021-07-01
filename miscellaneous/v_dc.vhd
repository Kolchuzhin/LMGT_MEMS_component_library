-------------------------------------------------------------------------------
-- Model: dc voltage source
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@etit.tu-chemnitz.de>
-- Date: 21.06.2011

-- Library: kvl in hAMSter 
-------------------------------------------------------------------------------
-- ID: v_dc.vhd
-- ver. 1.0 
-- status: OK
-------------------------------------------------------------------------------
library ieee;
use work.electromagnetic_system.all;
use work.all;
use ieee.math_real.all;


entity v_dc is
  generic (dc_value:real);         -- parameters
  port (terminal p,n:electrical);  -- pins
end entity v_dc; 


architecture basic of v_dc is
  quantity v across i through p to n;

begin

	v == - dc_value;

end architecture basic;
-------------------------------------------------------------------------------
