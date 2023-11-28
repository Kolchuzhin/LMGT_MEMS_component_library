-- =============================================================================
-- Model: testbench for an electrostatically actuated silicon membrane
--
-- Author: Vladimir Kolchuzhin, Chemnitz
-- <vladimir.kolchuzhin@ieee.org>
-- Date: 21.10.2015
--
-- =============================================================================
-- VHDL-AMS generated code from ANSYS ROM Tool for hAMSter:
--
--				initial_160.vhd
--				s_ams_160.vhd
--				ca12_ams_160.vhd
--				ememb_160.vhd
--
-- units: uMKSV
---------------
--
-- Geometrical parameters of membrane:
--------------------------------------
-- memb_a=4000.0		! length
-- memb_b=4000.0		! width
-- memb_h=   5.0		! thickness
-- fafl_l= 300.0		! fringing field distance in plane direction
-- fafl_h= 200.0		! fringing field distance above membrane
-- el_gap=	30.0		! electrode gap
--
-- 
-- Solver parameters:
---------------------
-- Euler solver: time= 5ms; step=5.0 us
--
--
-- Load options:
----------------
-- use_pass=0 => external modal forces, uN; fm1_ext=km_1*q1_ext, => q1_ext=1.0 (mechanical test)
-- use_pass=1 => calculation of voltage displacement functions up to pull-in: voltage sweep
-- use_pass=4 => harmonic analysis -> chirp for harmonic response; + DFT (postprocessing)
--------------------------------------------------------------------------------
-- use_pass=1:
-- membrane is driven by a voltage: electrical excitation - > mechanical response
-- electrostatic softening vs stress stiffening:
--
-- The computed pull-in voltage is 90.0 volts in LIN case w/o stress stiffening;
-- The computed pull-in voltage is 258.0 volts in NL case.
--
--------------------------------------------------------------------------------
-- ID: testbench.vhd
--
-- Rev. 1.00 22.10.2015
--
-- =============================================================================
library ieee;

use work.electromagnetic_system.all;
use work.all;

use ieee.math_real.all; 

                
entity testbench is
end;

architecture behav of testbench is
  terminal struc1_ext,struc2_ext: translational; 	  --
  terminal lagrange1_ext,lagrange2_ext:translational; --
  terminal master1_ext,master2_ext:translational;	  --
  terminal elec1_ext,elec2_ext: electrical;			  --

  -- Modal displacement
  quantity q1_ext across fm1_ext through struc1_ext;          -- modal amplitude 1
  quantity q2_ext across fm2_ext through struc2_ext;          -- modal amplitude 2
  -- Lagrangian multipler                                               
  quantity p1_ext across r1_ext  through lagrange1_ext;
  quantity p2_ext across r2_ext  through lagrange2_ext;
  -- Nodal displacement
  quantity u1_ext across f1_ext  through master1_ext;
  quantity u2_ext across f2_ext  through master2_ext;
  -- Electrical ports
  quantity v1_ext across i1_ext  through elec1_ext;            -- conductor  1
  quantity v2_ext across i2_ext  through elec2_ext;            -- conductor  2


  constant f_1:real:=421.761e+03;
  constant T_1:real:=1.0/f_1;

  constant t_end:real:=5.0e-03;
  constant    dt:real:=5.0e-06;
  -- convert real -> time
  constant digital_delay:time:=5.0 us;          -- time step size for matrix update:  digital_delay=dt!

  constant Vmax_value:real:= 258.0; -- Vmax for voltage ramp:
	-- 1) LIN:	 90.0 V
	-- 2) NL:	258.0 V

-- sweep/chirp parameters
  constant f_begin:real:=0.1e+03;
  constant f_end:real:= 40.0e+03;
  constant Vdc_value:real:= 70.0; -- Vdc
  constant Vac_value:real:=  2.0; -- Vac


  constant use_pass:integer:=1; -- *** 0/1/4 ***

-- use_pass=0 => external modal forces, uN; fmi_ext=km_i*qi_ext, => qi_ext=1.0 (mechanical test)
-- use_pass=1 => calculation of voltage displacement functions up to pull-in: voltage sweep
-- use_pass=4 => harmonic analysis -> chirp for harmonic response; + DFT (postprocessing)

begin

-- Loads:

if  DOMAIN = quiescent_domain use
		v1_ext ==  0.0;
		v2_ext ==  0.0;

		fm1_ext == 0.0;      -- external modal force 1
		fm2_ext == 0.0;      -- external modal force 2
else


if use_pass = 0 use -- step 0->1 at t=0.0
		v1_ext == 0.0;
		v2_ext == 0.0;

		fm1_ext ==  23.6778051194;      -- external modal force 1
		fm2_ext == 212.6896178680;      -- external modal force 2
end use;  

if use_pass = 1 use -- ramp/sweep
		v1_ext == Vmax_value/t_end*now;
		v2_ext == 0.0;

		fm1_ext == 0.0;      -- external modal force 1
		fm2_ext == 0.0;      -- external modal force 2
end use;  

if use_pass = 4 use -- chirp
		v1_ext == Vdc_value + Vac_value*sin(2.0*3.14*(f_begin + (f_end-f_begin)/t_end*now) * now);
		v2_ext ==  0.0;

		fm1_ext == 0.0;      -- external modal force 1
		fm2_ext == 0.0;      -- external modal force 2
end use;

end use;
----------------------------------
r1_ext==0.0;       -- must be zero
r2_ext==0.0;       -- must be zero

f1_ext==0.0;       -- external nodal force on master node 1
f2_ext==0.0;       -- external nodal force on master node 2
-------------------------------------------------------------------------------
--
--                              Lagrangian ports
--
--                               p1        p2
--                 r_ext1=0 ->>- o         o -<<- r_ext2=0
--                               |         |
--         modal ports   o-------o---------o-------o     nodal ports
--                       |                         | 
-- fm_ext1=0 ->>- q1 o---o                         o---o u1 -<<- f_ext1=0
--                       |                         |
-- fm_ext2=0 ->>- q2 o---o component_1: ememb_160  o---o u2 -<<- f_ext2=0
--                       |                         |  
--                       |                         |  
--                       |                         |
--                       o-------o---------o-------o
--                               |         |
--                        v1_ext o         o v2_ext=0
--                        input              ground
--                              
--                             electrical ports
--
-- ASCII-Schematic of the elsta-membrane-component 

component_1:	entity ememb_160(behav)
 	       generic map (digital_delay)
	          port map (struc1_ext,struc2_ext,
                        lagrange1_ext,lagrange2_ext,
                        master1_ext,master2_ext,
                        elec1_ext,elec2_ext); 
end;
-- =============================================================================
