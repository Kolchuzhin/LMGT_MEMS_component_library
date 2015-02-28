-- Model: tensoresistor
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@etit.tu-chemnitz.de>
--
-- Date: 07.06.2011
-- Library: kvl in hAMSter 
-------------------------------------------------------------------------------
-- ID: tensoresistor.vhd
-- Modification History (rev, date, author):
--
-- Revision 1.0 25.04.2012 official release for ForGr1713, www.zfm.tu-chemnitz.de/for1713
--              28.02.2015 GitHub
-- Status: Compile OK, model was compiled with hAMSter simulator
-------------------------------------------------------------------------------
library ieee;

use ieee.math_real.all;
--use ieee.electrical_systems.all;
--use ieee.mechanical_systems.all;
--use ieee.fundamental_constants.all;

use work.electromagnetic_system.all;
use work.all;
-------------------------------------------------------------------------------
entity tensoresistor is

 -- input parameters:
  -- strain  == axial strain = (L-L0)/L0 = f/c1/L0; (L-L0=u; f=c1*u)
  -- Gf == gauge factor
  -- Rc == initial undeformed resistance in Ohm

 generic(Rc,Gf:real); -- given as a generic parameter

 port(terminal input1,input2:translational;
      terminal node1,node2:electrical);	-- electrical ports 

end entity tensoresistor;
-------------------------------------------------------------------------------
architecture basic of tensoresistor is

  quantity strain across input1 to input2;
  quantity v1 across i1 through node1;
  quantity v2 across i2 through node2;
  
begin

    i1 == (v1-v2)/(Rc*(1.0 + Gf*strain)); -- metal-film tensoresistor
    i2 == -i1;

end architecture basic;
-------------------------------------------------------------------------------
