-------------------------------------------------------------------------------
-- Model: analytical model of a micro-electro-mechanical transducer 
--        with three electrodes
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 07.12.2023

-- Library: kvl in hAMSter
-------------------------------------------------------------------------------
-- ID: 	transducer_e3.vhd
-- 
-- Revision:
--           Rev. 0.2
--
--   Status: model was compiled with hAMSter simulator
--           Info : Compile  OK  Mon Dec 04 15:25:34 2023
--
-- Reference: https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/microelectromechanical_transducer
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- geometric parameters (uMKSV units):
-- clamped clamped beam: 200x20x2 um
-- air gap between the electrodes: 4 um
--
-- resonator model:
-- electrodes: 3
-- capacitances: C12, C13, C23
--
--
--
--     o---------------------------------------------o  Nodal ports
--     |      o-------------------------------o  3   |
--     |      o-------------------------------o      |
--     |     /|         transducer_e3         |\ 2   o---o u   -o-
--     |     /o-------------------------------o\     |          |
--     |      o-------------------------------o  1   |          v
--     o------o---------------o---------------o------o          u
--            |               |               |       
--            o               o               o
--          v1_ext          v2_ext          v3_ext      Electrical ports
--
--
--             ASCII-Schematic of the component
-------------------------------------------------------------------------------
-- Euler solver: time=50u; step=10n ***
-------------------------------------------------------------------------------
LIBRARY ieee;
--LIBRARY user; -- Simplorer

USE ieee.math_real.all;
use work.electromagnetic_system.all; -- hAMSter
--USE ieee.electrical_systems.ALL; -- Simplorer
--USE ieee.mechanical_systems.ALL; -- Simplorer
-------------------------------------------------------------------------------
ENTITY transducer_e3 IS

  port (terminal elec1,elec2,elec3:electrical;  -- electrical pins
        terminal struc1:translational);         -- mechanical pins

END ENTITY transducer_e3;
-------------------------------------------------------------------------------
ARCHITECTURE analytical OF transducer_e3 IS

  quantity v1 across i1 through elec1;
  quantity v2 across i2 through elec2;
  quantity v3 across i3 through elec3; 

  quantity u  across f  through struc1;

  quantity C12:real;  -- capacitance C12
  quantity C13:real;  -- capacitance C13
  quantity C23:real;  -- capacitance C23
  quantity dC12:real; -- Fel12 ~ dC12/du
  quantity dC13:real; -- Fel13 ~ dC13/du
  quantity dC23:real; -- Fel23 ~ dC23/du

  constant eps:real:=8.85e-06;    -- permittivity pF/um, uMKS unit
  constant rho:real:=2.329e-15;   -- density kg/um^3

-- input parameters:
  constant L:real:=200.0;                     -- Length, um
  constant H:real:= 20.0;                     -- Height, um
  constant B:real:=  2.0;                     -- thickness, um
  constant g:real:=  4.0;                     -- initial air gap, um
  constant f0:real:=0.43949E+06;              -- eigenfrequency, Hz
  constant Q:real:=10.0;                      -- Quality factor
--
  constant A:real:=L*H;                       -- plate area, um^2
  constant m:real:=A*B*rho;                   -- mass, kg
  constant c:real:=m*((2.0*3.141593*f0)**2);  -- spring constant: c=m*((2*PI*f0)**2), uN/um 
  constant d:real:=SQRT(m*c)/Q;               -- damping ratio/damping coefficient: SQRT(m*k)/q, uNs/um

BEGIN

  C12==eps*A/(g-u);
  dC12==+eps*A/((g-u)**2);
  C23==eps*A/(g+u);
  dC23==-eps*A/((g+u)**2);
  C13==eps*A/g/2.0;
  dC13==0.0;

  f==m*u'dot'dot + d*u'dot + c*u - dC12*(v1-v2)**2/2.0  - dC23*(v2-v3)**2/2.0;

  --i==v'dot*cap + cap'dot*v;
  i1== +((v1-v2)*dC12*u'dot + (v1'dot-v2'dot)*C12) +((v1-v3)*(dC13*u'dot) + (v1'dot-v3'dot)*C13);
  i2== -((v1-v2)*dC12*u'dot + (v1'dot-v2'dot)*C12) +((v2-v3)*(dC23*u'dot) + (v2'dot-v3'dot)*C23);
  i3== -((v1-v3)*dC13*u'dot + (v1'dot-v3'dot)*C13) -((v2-v3)*(dC23*u'dot) + (v2'dot-v3'dot)*C23);

END ARCHITECTURE analytical;
-------------------------------------------------------------------------------