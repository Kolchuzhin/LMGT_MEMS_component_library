-------------------------------------------------------------------------------
-- Model: (1D) analytical model of a micro-electro-mechanical H-resonator 
--        with Closed Gap electrodes
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 05.11.2024
-------------------------------------------------------------------------------
-- ID: 	resonator_He9.vhd
-- 
-- Revision:
--           Rev. 0.02a
--
-- Status:
--
-- hAMSter:
-- model was compiled with hAMSter simulator
-- Info  : Compile  OK  Tue Nov 05 14:52:04 2024
--
-- Simplorer:
-- Compiling model DLL using MinGW compiler  (09:45:12 AM  Oct 10, 2025)
-- Compiler::Parsing done. No errors.  (09:45:12 AM  Oct 10, 2025)

-- Reference: 
--
-- https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/resonator/transducer_e5
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- geometric parameters (uMKSV units):
-- air gaps between the electrodes: d1=2 um / d2=5 um
--
-- resonator model:
-- electrodes: 5
-- capacitances: C15, C25, C35, C45
--
--
--          v1_ext  v2_ext  v3_ext  v4_ext              Electrical ports 
--            o       o       o       o       
--            |       |       |       |       
--     o------o-------o-------o-------o--------------o  Nodal ports
--     |      o---------o 1       2 o---------o      | 
--     o      o-------------------------------o      |
--     |     /|          resonator_He9     5  |\     o---o u   -o-
--     o     /o------------o     o------------o\     |          |
--     |      o---------o 3|     |4 o---------o      |          v
--     |      o---------o 7|     |6 o---------o      | 
--     o      o------------o     o------------o      |
--     |     /|                               |\     |
--     o     /o-------------------------------o\     |
--     |      o---------o 9       8 o---------o      |
--     o------o-------o-------o-------o-------o------o          u
--            |       |       |       |       |
--            o       o       o       o       o
--          v6_ext  v7_ext  v8_ext  v9_ext  v5_ext      Electrical ports  
--   
--
--             ASCII-Schematic of the component
-------------------------------------------------------------------------------
-- Euler solver: time=50u; step=10n ***
-------------------------------------------------------------------------------
-- hAMSter:
--library ieee;

--use ieee.math_real.all;
--use work.electromagnetic_system.all;
------------------
-- Simplorer:
LIBRARY ieee;
LIBRARY user;

USE ieee.math_real.all;
USE ieee.electrical_systems.ALL;
USE ieee.mechanical_systems.ALL;
-------------------------------------------------------------------------------
ENTITY resonator_He9 IS

  generic (Q:real; f0:real);                                                        -- quality factor, eigenfrequency
  port (terminal elec1,elec2,elec3,elec4,elec5,elec6,elec7,elec8,elec9:electrical;  -- electrical pins
        terminal struc1:translational);                                             -- mechanical pins

END ENTITY resonator_He9;
-------------------------------------------------------------------------------
ARCHITECTURE analytical OF resonator_He9 IS

  quantity v1 across i1 through elec1;
  quantity v2 across i2 through elec2;
  quantity v3 across i3 through elec3;
  quantity v4 across i4 through elec4;
  quantity v5 across i5 through elec5;
  quantity v6 across i6 through elec6;
  quantity v7 across i7 through elec7;
  quantity v8 across i8 through elec8;
  quantity v9 across i9 through elec9;

  quantity u  across f  through struc1;

  quantity C15:real;  -- capacitance C15
  quantity C25:real;  -- capacitance C25
  quantity C35:real;  -- capacitance C35
  quantity C45:real;  -- capacitance C45
  quantity C65:real;  -- capacitance C65
  quantity C75:real;  -- capacitance C75
  quantity C85:real;  -- capacitance C85
  quantity C95:real;  -- capacitance C95
    
  quantity dC15:real; -- Fel15 ~ dC15/du
  quantity dC25:real; -- Fel25 ~ dC25/du
  quantity dC35:real; -- Fel35 ~ dC35/du
  quantity dC45:real; -- Fel45 ~ dC45/du
  quantity dC65:real; -- Fel65 ~ dC65/du
  quantity dC75:real; -- Fel75 ~ dC75/du
  quantity dC85:real; -- Fel85 ~ dC85/du
  quantity dC95:real; -- Fel95 ~ dC95/du

  
  constant eps:real:=8.85e-06;    -- permittivity pF/um, uMKS unit
  constant rho:real:=2.329e-15;   -- density kg/um^3

-- input parameters:
  constant h:real:= 50.0;                     -- height, um
  constant la_mov_fi:real:= 50.0;             -- length of finger, um
  constant la_ovl:real:= 43.0;                -- finger overlap, um
  constant d1:real:=  2.0;                    -- gap1, um
  constant d2:real:=  5.0;                    -- gap2, um
  constant n1_cell:real:=40.0;                -- number of capac. cell
  constant n2_cell:real:=40.0;                -- number of capac. cell
  constant  n_cell:real:=40.0;                -- number of capac. cell 45+36

--  constant f0:real:=110000.0;               -- eigenfrequency, Hz / generic
--  constant Q:real:=20.0;                    -- Quality factor / generic
--
  constant m:real:=22.0e-9;                   -- mass, kg
  constant c:real:=m*((2.0*3.141593*f0)**2);  -- spring constant: c=m*((2*PI*f0)**2), uN/um 10514.0
  constant d:real:=SQRT(m*c)/Q;               -- damping ratio/damping coefficient: SQRT(m*k)/q, uNs/um

BEGIN

--           capacitance of the cell (closed form solution)
--
--		o-----o-------o----o-------o----o 
--		|\\\\\\\\\\\\\\\\\\|       |////|      ^ y / u
--		o\\\\\o-------o----o d1    o////o      |
--		o\\\\\o       o----o-------o////o      |
--		#\\\\\|  dx<- |/////////////////|      #--->  x
--		o\\\\\o       o----o-------o////o      
--		o\\\\\o-------o----o d2    o////o 
--		|\\\\\\\\\\\\\\\\\\|       |////|
--		o-----o-------o----o-------o----o 

-- Cfront=eps_0*h*b_z/(la_fi-la_ovl);

   C15==n_cell*eps*h*la_ovl*(1.0/(d1-u)    + 1.0/(d2+u));
  dC15==n_cell*eps*h*la_ovl*(1.0/(d1-u)**2 - 1.0/(d2+u)**2);

   C35==n_cell*eps*h*la_ovl*(1.0/(d1-u)    + 1.0/(d2+u));
  dC35==n_cell*eps*h*la_ovl*(1.0/(d1-u)**2 - 1.0/(d2+u)**2);

   C25==n_cell*eps*h*la_ovl*(1.0/(d2-u)    + 1.0/(d1+u));
  dC25==n_cell*eps*h*la_ovl*(1.0/(d2-u)**2 - 1.0/(d1+u)**2);

   C45==n_cell*eps*h*la_ovl*(1.0/(d2-u)    + 1.0/(d1+u));
  dC45==n_cell*eps*h*la_ovl*(1.0/(d2-u)**2 - 1.0/(d1+u)**2);

   C75==n_cell*eps*h*la_ovl*(1.0/(d1-u)    + 1.0/(d2+u));
  dC75==n_cell*eps*h*la_ovl*(1.0/(d1-u)**2 - 1.0/(d2+u)**2);

   C95==n_cell*eps*h*la_ovl*(1.0/(d1-u)    + 1.0/(d2+u));
  dC95==n_cell*eps*h*la_ovl*(1.0/(d1-u)**2 - 1.0/(d2+u)**2);

   C65==n_cell*eps*h*la_ovl*(1.0/(d2-u)    + 1.0/(d1+u));
  dC65==n_cell*eps*h*la_ovl*(1.0/(d2-u)**2 - 1.0/(d1+u)**2);

   C85==n_cell*eps*h*la_ovl*(1.0/(d2-u)    + 1.0/(d1+u));
  dC85==n_cell*eps*h*la_ovl*(1.0/(d2-u)**2 - 1.0/(d1+u)**2);

  f==m*u'dot'dot + d*u'dot + c*u - dC15*(v1-v5)**2/2.0 - dC25*(v2-v5)**2/2.0 - dC35*(v3-v5)**2/2.0 - dC45*(v4-v5)**2/2.0  - dC65*(v6-v5)**2/2.0 - dC75*(v7-v5)**2/2.0 - dC85*(v8-v5)**2/2.0 - dC95*(v9-v5)**2/2.0;

  --i==v'dot*cap + cap'dot*v; 
  i1== +((v1-v5)*(dC15*u'dot) + (v1'dot-v5'dot)*C15);
  i2== +((v2-v5)*(dC25*u'dot) + (v2'dot-v5'dot)*C25);
  i3== +((v3-v5)*(dC35*u'dot) + (v3'dot-v5'dot)*C35);
  i4== +((v4-v5)*(dC45*u'dot) + (v4'dot-v5'dot)*C45);
  i6== +((v6-v5)*(dC65*u'dot) + (v6'dot-v5'dot)*C65);
  i7== +((v7-v5)*(dC75*u'dot) + (v7'dot-v5'dot)*C75);  
  i8== +((v8-v5)*(dC85*u'dot) + (v8'dot-v5'dot)*C85);
  i9== +((v9-v5)*(dC95*u'dot) + (v9'dot-v5'dot)*C95);

  
  i5== -((v1-v5)*(dC15*u'dot)+(v1'dot-v5'dot)*C15) - ((v2-v5)*(dC25*u'dot)+(v2'dot-v5'dot)*C25) - ((v3-v5)*(dC35*u'dot)+(v3'dot-v5'dot)*C35) - ((v4-v5)*(dC45*u'dot)+(v4'dot-v5'dot)*C45)
       -((v6-v5)*(dC65*u'dot)+(v6'dot-v5'dot)*C65) - ((v7-v5)*(dC75*u'dot)+(v7'dot-v5'dot)*C75) - ((v8-v5)*(dC85*u'dot)+(v8'dot-v5'dot)*C85) - ((v9-v5)*(dC95*u'dot)+(v9'dot-v5'dot)*C95);


END ARCHITECTURE analytical;
-------------------------------------------------------------------------------