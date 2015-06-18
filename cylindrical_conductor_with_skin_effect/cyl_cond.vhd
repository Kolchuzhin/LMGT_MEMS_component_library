-------------------------------------------------------------------------------
-- Model: SOLID CYLINDER for TIME-DOMAIN ANALYSIS
--
-- Author: Vladimir Kolchuzhin, MMT, TU Chemnitz
-- <vladimir.kolchuzhin@etit.tu-chemnitz.de>
-- Date: 01.12.2014

-- Library: 
-- kvl in hAMSter
-------------------------------------------------------------------------------
-- IEEE TRANSACTIONS ON MAGNETICS, VOL. 32, NO. I , JANUARY 1996
-- Lawrence J. Giacoletto
-- FREQUENCY AND TIME-DOMAIN ANALYSIS OF SKIN EFFECTS

-- for the cylinder conductor as a series element
-- for the cylinder conductor as a shunt element

-------------------------------------------------------------------------------
-- ID: cyl_cond.vhd
-- Rev. 1.0 
-------------------------------------------------------------------------------
LIBRARY ieee;
LIBRARY user;
USE ieee.math_real.all;
USE	ieee.electrical_systems.ALL;

entity wire is

  generic (dc_value,ac_value,freq,phase:real); -- parameters:
  port (terminal p,n:electrical);  			   -- pins

end entity wire;
-------------------------------------------------------------------------------
-- for the cylinder conductor as a series element
architecture series_element of cyl_cond is

  quantity v across i through p to n;

  -- material properties
  constant sigma:real:=37.0e-06;			-- conductivity CuZr, S/m
  constant mu:real:=1.0e-07*4.0*3.14;	-- permeability: 4*pi*1e-7 H/m
  -- geometry
  constant    R2:real:=10.0e-03;			-- outside radius R2
  constant     L:real:=1.0;           -- length of conductor, m

  constant Rdc:real:=L/sigma/(3.14*R2*R2);      -- dc resistance of conductor
  constant omega_c:real:= 1.0/(sigma*mu*R2*R2); -- characteristic radian frequency

  constant c0:real:= 1.0;
  constant c1:real:= 0.125/omega_c;
  constant c2:real:=-5.208333e-03/(omega_c**2);
  constant c3:real:= 3.255208e-04/(omega_c**3);
  constant c4:real:=-2.170139e-05/(omega_c**4);
  constant c5:real:= 1.469365e-06/(omega_c**5);
  constant c6:real:=-9.990874e-08/(omega_c**6);
  constant c7:real:= 6.801447e-09/(omega_c**7);
  constant c8:real:=-4.631829e-10/(omega_c**8);
  constant c9:real:= 3.154634e-11/(omega_c**9);

begin

	v == Rdc*(c0*i + c1*i'dot + c2*i'dot'dot + c3*i'dot'dot'dot + c4*i'dot'dot'dot'dot + c5*i'dot'dot'dot'dot'dot +
		     c6*i'dot'dot'dot'dot'dot'dot + c7*i'dot'dot'dot'dot'dot'dot'dot + c8*i'dot'dot'dot'dot'dot'dot'dot'dot +
			 c9*i'dot'dot'dot'dot'dot'dot'dot'dot'dot);

end architecture series_element;
-------------------------------------------------------------------------------
-- for the cylinder conductor as a shunt element
architecture shunt_element of cyl_cond is

  quantity v across i through p to n;

  -- material properties
  constant sigma:real:=37.0e-06;			-- conductivity CuZr, S/m
  constant mu:real:=1.0e-07*4.0*3.14;	-- permeability: 4*pi*1e-7 H/m
  -- geometry
  constant    R2:real:=10.0e-03;			-- outside radius R2
  constant     L:real:=1.0;           -- length of conductor, m

  constant Rdc:real:=L/sigma/(3.14*R2*R2);      -- dc resistance of conductor
  constant omega_c:real:= 1.0/(sigma*mu*R2*R2); -- characteristic radian frequency

  constant d0:real:= 1.0;
  constant d1:real:=-0.125/omega_c;
  constant d2:real:= 2.083333e-02/(omega_c**2);
  constant d3:real:=-3.580734e-03/(omega_c**3);
  constant d4:real:= 6.184882e-04/(omega_c**4);
  constant d5:real:=-1.069248e-04/(omega_c**5);
  constant d6:real:= 1.848816e-05/(omega_c**6);
  constant d7:real:=-3.196859e-06/(omega_c**7);
  constant d8:real:= 5.527843e-07/(omega_c**8);
  constant d9:real:=-9.558471e-08/(omega_c**9);

begin

	i == (d0*v + d1*v'dot + d2*v'dot'dot + d3*v'dot'dot'dot + d4*v'dot'dot'dot'dot + d5*v'dot'dot'dot'dot'dot +
		  d6*v'dot'dot'dot'dot'dot'dot + d7*v'dot'dot'dot'dot'dot'dot'dot + d8*v'dot'dot'dot'dot'dot'dot'dot'dot +
		  d9*v'dot'dot'dot'dot'dot'dot'dot'dot'dot)/Rdc;

end architecture shunt_element;
-------------------------------------------------------------------------------
