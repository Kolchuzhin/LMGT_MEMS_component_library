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
ARCHITECTURE basic OF Spiegel IS

  quantity v1 across i1 through elec1;
  quantity v2 across i2 through elec2;
  quantity v3 across i3 through elec3;
  quantity u1 across f1 through struc1;
  quantity u2 across f2 through struc2;

  constant eps:real:=8.85e-12;
  constant m:real:=4.658e-8;
  constant J:real:=3.8832e-15;
  constant Kuz:real:=1.9108e+5;
  constant Krx:real:=2.7945e-5;
  constant d1:real:=0.0094;
  constant d2:real:=3.2942e-11;
  constant aeps:real:=3.54e-18;
  constant egap:real:=90.0e-6;
  constant e_di:real:=200.0e-6;
  constant b:real:=1000.0e-6;

  quantity cap1:real;
  quantity cap2:real;
  quantity dcap12_t:real;
  quantity dcap13_t:real;
  quantity dcap12_r:real;
  quantity dcap13_r:real;

BEGIN

  f1==m*u1'dot'dot + d1*u1'dot + Kuz*u1 - dcap12_t*(v1-v2)**2/2.0 - dcap13_t*(v1-v3)**2/2.0;
  f2==J*u2'dot'dot + d2*u2'dot + Krx*u2 - dcap12_r*(v1-v2)**2/2.0 - dcap13_r*(v1-v3)**2/2.0;

  i1==(+(v1'dot-v2'dot)*cap1 + (dcap12_t*u1'dot+dcap12_r*u2'dot)*(v1-v2)+(v1'dot-v3'dot)*cap2 + (dcap13_t*u1'dot+dcap13_r*u2'dot)*(v1-v3));
  i2==(-(v1'dot-v2'dot)*cap1 - (dcap12_t*u1'dot+dcap12_r*u2'dot)*(v1-v2));
  i3==(-(v1'dot-v3'dot)*cap2 - (dcap13_t*u1'dot+dcap13_r*u2'dot)*(v1-v3));
  -- i3==(-(v1'dot-v3'dot)*cap2 - (cap2'dot)*(v1-v3));

  cap1==+aeps/(egap+u1+(b+e_di)*0.25*u2);
  cap2==+aeps/(egap+u1-(b+e_di)*0.25*u2);

  dcap12_t==-aeps/((egap+u1+(b+e_di)*0.25*u2)**2);
  dcap13_t==-aeps/((egap+u1-(b+e_di)*0.25*u2)**2);
  dcap12_r==-aeps*0.25*b/((egap+u1+(b+e_di)*0.25*u2)**2);
  dcap13_r==+aeps*0.25*b/((egap+u1-(b+e_di)*0.25*u2)**2);

END ARCHITECTURE basic;
