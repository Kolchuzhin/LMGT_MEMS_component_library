-------------------------------------------------------------------------------
-- Model: inductor
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz 
-- <vladimir.kolchuzhin@ieee.org> 
-- 
-- Date: 21.06.2011 

-- Library: kvl in hAMSter
-------------------------------------------------------------------------------
-- ID: inductor.vhd
-- Rev. 1.0  
------------------------------------------------------------------------------- 
use work.electromagnetic_system.all; 
use work.all; 
library ieee;


entity inductor is
  generic (inductance:real);      -- inductance value   
  port (terminal p,n:electrical); -- interface ports 
end entity inductor; 


architecture basic of inductor is
  quantity v across i through p to n;
begin
        v == inductance*i'dot;
end architecture basic;
