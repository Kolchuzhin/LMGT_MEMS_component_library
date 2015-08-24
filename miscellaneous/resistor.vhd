-------------------------------------------------------------------------------
-- Model: resistor
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@ieee.org>
--
-- Date: 21.06.2011

-- Library: kvl in hAMSter
-------------------------------------------------------------------------------
-- ID: resistor.vhd
-- Rev. 1.0 
-------------------------------------------------------------------------------
use work.electromagnetic_system.all;
use work.all;
library ieee;


entity resistor is
  generic (resistance:real);      -- resistance value
  port (terminal p,n:electrical); -- interface ports
end entity resistor;


architecture basic of resistor is
  quantity v across i through p to n;
begin
	i == v/resistance;
end architecture basic;
