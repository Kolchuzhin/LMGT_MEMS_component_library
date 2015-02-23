-------------------------------------------------------------------------------
-- Model: Spiegel (analytical model of micromirror)
--
-- Author: Jan E. Mehner, LMGT, ET/IT, TU Chemnitz
-- www.tu-chemnitz.de/etit/microsys/
-- Date: 

-- Library: kvl in hAMSter 
-------------------------------------------------------------------------------
-- ID: 		spiegel.vhd
-- Revision:
-- Revision 1.0 - porting a code to Simplorer by Vladimir Kolchuzhin
-- 23.02.2015 GitHub

-- Status: 	OK
-------------------------------------------------------------------------------
LIBRARY ieee;
LIBRARY user; -- hAMSter

USE ieee.math_real.all;
--use work.electromechanical_system.all; -- hAMSter
USE	ieee.electrical_systems.ALL; -- Simplorer
USE	ieee.mechanical_systems.ALL; -- Simplorer


ENTITY Spiegel IS

  port (terminal elec1,elec2,elec3:electrical;                               
--      terminal struc1,struc2:translational);  -- mechanical->translational
        terminal struc1:translational;
        terminal struc2:rotational);

END ENTITY Spiegel;
-------------------------------------------------------------------------------
