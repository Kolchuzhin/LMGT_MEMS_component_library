-------------------------------------------------------------------------------
-- Model: capacitor
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@ieee.org>
--
-- Date: 21.06.2011

-- Library: kvl in hAMSter
-------------------------------------------------------------------------------
-- ID: capacitor.vhd
-- Rev. 1.0
-------------------------------------------------------------------------------
use work.electromagnetic_system.all;
use work.all;
library ieee;


entity capacitor is
  generic (capacitance:real);       -- capacitance value
  port (terminal p,n:electrical); -- interface ports
end entity capacitor;


architecture basic of capacitor is
  quantity v across i through p to n;
begin
        i == capacitance*v'dot;
end architecture basic;
