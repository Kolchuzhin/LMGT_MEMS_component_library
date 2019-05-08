--*****************************************************************************
--*****************************************************************************
-- Model: testbench for cbeam.vhd in hAMSter
--
-- clamped /one side fixed/ beam 
--           is driven by a voltage (see key_load): 
--					20. constant load
--					21. ramp/sweep computing the pull-in voltage 
--					22. sin/chirp
--					23. puls
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 19.10.2011

-- Library dependencies:
--	VHDL-AMS generated code from ANSYS for hAMSter: cbeam.vhd
--  uMKSV units 
-------------------------------------------------------------------------------
-- Beam parameters, um
-- B_L=100  Beam length
-- B_W=20   Beam width
-- B_T=2    Beam thickness
-- E_G=4    Electrode gap
--
-- Material properties <110> Si
-- EX=169e3 MPa, Young's modulus
-- NUXY=0.066, Poisson's ratio
-- DENS=2.329e-15 kg/um/um/um. density
-- ALPX=1e-6
--
-- Calculation of voltage displacement functions up to pull-in:
--   Linear analysis: 157 volts (stress stiffening is OFF)
--   Nonlinear analysis: 160 volts (stress stiffening is ON)
--               
-- There are two element loads: acceleration and a uniform pressure load:
-- acel,,,9.81e12                ! acceleration in Z-direction 9.81e6 m/s**2
-- sf,all,pres,0.1               ! uniform 100 kPa pressure load
--
-- Damping: modal quality factors in cbeam.vhd
--
-------------------------------------------------------------------------------
-- Euler solver:
-- time=50u; step=10n
-------------------------------------------------------------------------------
-- ID: testbench.vhd
-- ver. 0.20 19.11.2011
-- ver. 0.30 02.05.2019 updated
--*****************************************************************************
--*****************************************************************************
use work.electromagnetic_system.all;
use work.all;

library ieee;
use ieee.math_real.all;
                
entity testbench is
end;

architecture behav of testbench is
  terminal struc1_ext,struc2_ext: translational; 	  --
  terminal lagrange1_ext,lagrange2_ext:translational; --
  terminal master1_ext,master2_ext:translational;	  --
  terminal elec1_ext,elec2_ext: electrical;           --

  -- Modal displacement
  quantity q_ext1 across fm_ext1 through struc1_ext;          -- Modal amplitude 1
  quantity q_ext2 across fm_ext2 through struc2_ext;          -- Modal amplitude 2
  -- Lagrangian multipler                                               
  quantity p_ext1 across r_ext1  through lagrange1_ext;
  quantity p_ext2 across r_ext2  through lagrange2_ext;
  -- Nodal displacement
  quantity u_ext1 across f_ext1  through master1_ext;          -- Nodal amplitude 1
  quantity u_ext2 across f_ext2  through master1_ext;          -- Nodal amplitude 2
  -- Electrical ports
  quantity v_ext1 across i_ext1  through elec1_ext;           -- Conductor 1
  quantity v_ext2 across i_ext2  through elec2_ext;           -- Conductor 2

  constant digital_delay:time:=10.0 ns;        -- digital time step size for matrix update == analog time step

  constant el_load1:real:=0.0;
  constant el_load2:real:=0.0;
  
  constant t_end:real:=50.0e-06;
  constant    dt:real:=10.0E-09; -- time step
  constant ac_value:real:= 10.0;
  constant dc_value:real:=160.0;

-- puls
  constant   t1:real:= 1.0E-06;
  constant   t2:real:=10.0E-06; -- 5.0E-06
-- chirp
  constant f_begin:real:=  0.27544E+06*0.1;               -- begin of frequency sweep
  constant f_end:real:=    0.27544E+06*3.0;               --   end of frequency sweep

  constant fm1_test:real:=  0.232818464746E-11*(2.0*3.14*0.27544E+06)**2;
  constant fm2_test:real:=  0.231854244007E-11*(2.0*3.14*0.17337E+07)**2;


                                   -- 10/11/12/13 == const/ramp/chirp/puls mechanical load/test
  constant   key_load:integer:=21; -- 20/21/22/23 == const/ramp/chirp/puls electromechanical test w/electrical load 

begin

-- Loads

if key_load = 10 use -- static mechanical modal
    v_ext1==0.0;
	v_ext2==0.0;
	fm_ext1==fm1_test;          -- external modal force 1 f=k*u
	fm_ext2==fm2_test;          -- external modal force 2 f=k*u
end use;

if key_load = 11 use -- ramp/sweep
    v_ext1==0.0;
	v_ext2==0.0;
	fm_ext1==fm1_test/t_end/1.0*now;
	fm_ext2==fm2_test/t_end/1.0*now;
end use;

if key_load = 12 use -- sin/chirp
    v_ext1==0.0;
	v_ext2==0.0;
	fm_ext1==0.0 + fm1_test*sin(2.0*3.14*(f_begin + (f_end-f_begin)/t_end*now) * now);
	fm_ext2==0.0;          
end use;

if key_load = 13 use -- puls
    v_ext1==0.0;
	v_ext2==0.0;
	fm_ext2==0.0;
 if now <= t1-dt use         
	fm_ext1 == 0.0;
  end use;
  if now > t1-dt and now <= t1 use
	fm_ext1 == 0.0;
  end use;        
  if now > t1 and now <= t2 use
	fm_ext1 == fm1_test*0.2;
  end use;
  if now > t2 and now <= t2+dt use
	fm_ext1 == 0.0;
  end use;
  if now > t2+dt use
	fm_ext1 == 0.0;
 end use;
end use;


if key_load = 20 use -- static electrical
    v_ext1==10.0;
	v_ext2== 0.0; -- ground electrode
	fm_ext1==0.0;
	fm_ext2==0.0;
end use;

if key_load = 21 use -- ramp/sweep
    v_ext1 == dc_value/t_end*now;
	v_ext2== 0.0;
	fm_ext1==0.0;
	fm_ext2==0.0;
end use;

if key_load = 22 use -- chirp
    v_ext1 == dc_value*0.0 + ac_value*sin(2.0*3.14*(f_begin + (f_end-f_begin)/t_end*now) * now);
	v_ext2== 0.0;
	fm_ext1==0.0;
	fm_ext2==0.0;

end use;

if key_load = 23 use -- puls
 if now <= t1-dt use         
	v_ext1 == 0.0;
  end use;
  if now > t1-dt and now <= t1 use
	v_ext1 == 0.0;
  end use;        
  if now > t1 and now <= t2 use
	v_ext1 == dc_value*0.1;
  end use;
  if now > t2 and now <= t2+dt use
	v_ext1 == 0.0;
  end use;
  if now > t2+dt use
	v_ext1 == 0.0;
 end use;
	v_ext2== 0.0;
	fm_ext1==0.0;
	fm_ext2==0.0;
end use;

-- BCs:
--i_ext1==0.0;
--v_ext2==0.0;

--fm_ext1==0.0;          -- external modal force 1
--fm_ext2==0.0;          -- external modal force 2

-- Lagrangian ports: p/r
r_ext1==0.0;           -- must be zero
r_ext2==0.0;           -- must be zero
-- nodal ports: u/f
f_ext1==0.0;           -- external nodal force on master node 1
f_ext2==0.0;           -- external nodal force on master node 2 

-------------------------------------------------------------------------------
--
--                           Lagrangian ports
--
--                              p1        p2
--                r_ext1=0 ->>- o         o -<<- r_ext2=0
--                              |         |
--         modal ports   o------o---------o------o     nodal ports
--                       |                       | 
-- fm_ext1=0 ->>- q1 o---o                       o---o u1 -<<- f_ext1=0
--                       |   element1:  cbeam    |
-- fm_ext2=0 ->>- q2 o---o                       o---o u2 -<<- f_ext2=0
--                       |                       |
--                       o------o---------o------o
--                              |         |
--                              o         o
--                     input: v1_ext    v2_ext=0 (ground)
--                             
--                           electrical ports  
--
-- ASCII-Schematic of the MEMS-component: cbeam
------------------------------------------------------------------------------- 
element1:      
 			    entity cbeam(behav)
   	       generic map (digital_delay,el_load1,el_load2)
 	          port map (struc1_ext,struc2_ext,
                        lagrange1_ext,lagrange2_ext,
                        master1_ext,master2_ext,
                        elec1_ext,elec2_ext);
end;
-------------------------------------------------------------------------------
