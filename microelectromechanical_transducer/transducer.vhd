-------------------------------------------------------------------------------
-- Model: micro-electro-mechanical transducer (analytical model)
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@etit.tu-chemnitz.de>
-- Date: 21.10.2008

-- Library: kvl in hAMSter 
-------------------------------------------------------------------------------
-- ID: 		tranducer.vhd
-- 
-- Revision:
-- Revision 1.0 - 23.02.2015 GitHub
-- 
-- Status: Compile OK, model was compiled with hAMSter simulator
-------------------------------------------------------------------------------
LIBRARY ieee;
--LIBRARY user; -- Simplorer

USE ieee.math_real.all;
use work.electromagnetic_system.all; -- hAMSter
--USE ieee.electrical_systems.ALL; -- Simplorer
--USE ieee.mechanical_systems.ALL; -- Simplorer

ENTITY transducer IS

-- abstract microelectomechanical tranducer parameters:
--  constant m:real:=4.658e-7;	-- mass
--  constant d:real:=2.245e-3;	-- damping coefficient
--  constant c:real:=270.4;		-- spring constant
--  constant A:real:=1.0e-6;	-- plate area
--  constant h:real:=10.0e-6;	-- initial gap

  --generic (m,d,c,A,h:real);           -- generic tranducer parameters

  port (terminal n0,n1:electrical;		    -- electrical pins
        terminal m0,m1:translational);		-- mechanical pins

END ENTITY transducer;
-------------------------------------------------------------------------------
ARCHITECTURE basic OF transducer IS

  quantity v across i through n1 to n0;
  quantity u across f through m1 to m0;

  quantity cap:real;  -- capacitance
  quantity dcdu:real; -- Fel ~ dC/du

-- MKS unit
  constant eps:real:=8.85e-12;	-- permittivity F/m, MKS unit


-- input parameters:

-- set#1
--  constant m:real:=4.658e-7;	-- mass
--  constant d:real:=2.245e-3;	-- damping coefficient
--  constant c:real:=270.4;		-- spring constant
--  constant A:real:=1.0e-6;	-- plate area
--  constant h:real:=10.0e-6;	-- initial gap

-- set#2
-- [Release 11.0 Documentation for ANSYS: 7.4. Sample Electromechanical-Circuit Analysis, MKS unit]:
  constant m:real:=1.0e-4;				-- mass, kg
  constant d:real:=40.0e-3;				-- damping coefficient, uNs/um
  constant c:real:=200.0;				-- spring constant, uN/um
  constant A:real:=(1.0e+8)*1.0e-12;	-- plate area, m^2
  constant h:real:=150.0e-6;			-- initial gap, m

-- set#3
-- Übung: Microsystem design: Analysis of electromechanical system by M. Naumann
--  constant m:real:=1.0;	    		-- mass, kg
--  constant d:real:=0.0;				-- damping coefficient, Ns/m
--  constant c:real:=1.46;				-- spring constant, N/m
--  constant A:real:=50.0e-6*50.0e-6;	-- plate area, m*m
--  constant h:real:=3.0e-6;			-- initial gap, m

BEGIN

  cap==eps*A/(h-u);
  dcdu==eps*A/((h-u)**2);
  
  f==m*u'dot'dot + d*u'dot + c*u - dcdu*v**2/2.0;
  i==v'dot*cap + cap'dot*v;

END ARCHITECTURE basic;
-------------------------------------------------------------------------------
