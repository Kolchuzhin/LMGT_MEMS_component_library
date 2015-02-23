-------------------------------------------------------------------------------
-- Model: micro-electro-mechanical transducer
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@etit.tu-chemnitz.de>
-- Date: 21.10.2008

-- Library: kvl in hAMSter 
-------------------------------------------------------------------------------
-- ID: 		tranducer.vhd
-- ver. 	1.0 
-- status: 	OK
-------------------------------------------------------------------------------
LIBRARY ieee;
LIBRARY user;

USE ieee.math_real.all;
USE	ieee.electrical_systems.ALL;
USE	ieee.mechanical_systems.ALL;

ENTITY transducer IS

-- tranducer parameters:
--  constant m:real:=4.658e-7;	-- mass
--  constant d:real:=2.245e-3;	-- damping coefficient
--  constant c:real:=270.4;		-- spring constant
--  constant A:real:=1.0e-6;	-- plate area
--  constant h:real:=10.0e-6;	-- initial gap

  --generic (m,d,c,A,h:real);           -- generic tranducer parameters

  port (terminal n0,n1:electrical;		-- pins
        terminal m0,m1:translational);

END ENTITY transducer;
-------------------------------------------------------------------------------
