-------------------------------------------------------------------------------
-- Model: analytical model of a micro-electro-mechanical transducer 
--        with five electrodes
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 12.12.2023
-------------------------------------------------------------------------------
-- ID: 	transducer_e5.vhd
-- 
-- Revision:
--           Rev. 0.1
--
-- Status: model was compiled with hAMSter simulator
-- Info : Compile  OK  <Tue Dec 12 16:33:06 2023
--
-- Reference: 
-- https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/microelectromechanical_transducer
-- https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/resonator/transducer_e3/transducer_e3.vhd
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- geometric parameters (uMKSV units):
-- clamped clamped beam: 300x30x2 um
-- air gap between the electrodes: 2 um
--
-- resonator model:
-- electrodes: 5
-- capacitances: C15, C25, C35, C45
--
--
--
--
--     o---------------------------------------------o  Nodal ports
--     |      o---------o 1       2 o---------o      | 
--     o      o-------------------------------o      |
--     |     /|          transducer_e5     5  |\     o---o u   -o-
--     o     /o-------------------------------o\     |          |
--     |      o---------o 3       4 o---------o      |          v
--     o------o-------o-------o-------o-------o------o          u
--            |       |       |       |       |
--            o       o       o       o       o
--          v1_ext  v2_ext  v3_ext  v4_ext  v5_ext      Electrical ports  
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
ENTITY transducer_e5 IS

  port (terminal elec1,elec2,elec3,elec4,elec5:electrical;  -- electrical pins
        terminal struc1:translational);                     -- mechanical pins

END ENTITY transducer_e5;
-------------------------------------------------------------------------------
ARCHITECTURE analytical OF transducer_e5 IS

  quantity v1 across i1 through elec1;
  quantity v2 across i2 through elec2;
  quantity v3 across i3 through elec3;
  quantity v4 across i4 through elec4;
  quantity v5 across i5 through elec5;
  
  quantity u  across f  through struc1;

  quantity C15:real;  -- capacitance C15
  quantity C25:real;  -- capacitance C25
  quantity C35:real;  -- capacitance C35
  quantity C45:real;  -- capacitance C45
    
  quantity dC15:real; -- Fel15 ~ dC15/du
  quantity dC25:real; -- Fel25 ~ dC25/du
  quantity dC35:real; -- Fel35 ~ dC35/du
  quantity dC45:real; -- Fel45 ~ dC45/du
  
  constant eps:real:=8.85e-06;    -- permittivity pF/um, uMKS unit
  constant rho:real:=2.329e-15;   -- density kg/um^3

-- input parameters:
  constant L:real:=300.0;                     -- Length, um
  constant H:real:= 30.0;                     -- Height, um
  constant B:real:=  2.0;                     -- thickness, um
  constant g:real:=  2.0;                     -- initial air gap, um
  constant f0:real:=195063.0;                 -- eigenfrequency, Hz
  constant Q:real:=10.0;                      -- Quality factor
--
  constant A:real:=L*H;                       -- beam area, um^2
  constant m:real:=A*B*rho;                   -- mass, kg
  constant c:real:=m*((2.0*3.141593*f0)**2);  -- spring constant: c=m*((2*PI*f0)**2), uN/um 
  constant d:real:=SQRT(m*c)/Q;               -- damping ratio/damping coefficient: SQRT(m*k)/q, uNs/um
  constant Ae:real:=(L-4.0)/2.0*H;            -- electrode area, um^2

BEGIN

   C15==eps*Ae/(g+u);
  dC15==-eps*Ae/((g+u)**2);
   C25==eps*Ae/(g+u);
  dC25==-eps*Ae/((g+u)**2);

   C35==eps*Ae/(g-u);
  dC35==+eps*Ae/((g-u)**2);
   C45==eps*Ae/(g-u);
  dC45==+eps*Ae/((g-u)**2);


  f==m*u'dot'dot + d*u'dot + c*u - dC15*(v1-v5)**2/2.0 - dC25*(v2-v5)**2/2.0 - dC35*(v3-v5)**2/2.0 - dC45*(v4-v5)**2/2.0;

  --i==v'dot*cap + cap'dot*v; 
  i1== +((v1-v5)*(dC15*u'dot) + (v1'dot-v5'dot)*C15);
  i2== +((v2-v5)*(dC25*u'dot) + (v2'dot-v5'dot)*C25);  
  i3== +((v3-v5)*(dC35*u'dot) + (v3'dot-v5'dot)*C35);
  i4== +((v4-v5)*(dC45*u'dot) + (v4'dot-v5'dot)*C45);
  
  i5== -((v1-v5)*(dC15*u'dot)+(v1'dot-v5'dot)*C15) -((v2-v5)*(dC25*u'dot)+(v2'dot-v5'dot)*C25) -((v3-v5)*(dC35*u'dot)+(v3'dot-v5'dot)*C35) -((v4-v5)*(dC45*u'dot)+(v4'dot-v5'dot)*C45);


END ARCHITECTURE analytical;
-------------------------------------------------------------------------------