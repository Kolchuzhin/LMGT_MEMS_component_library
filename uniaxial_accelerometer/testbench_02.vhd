--*****************************************************************************
--*****************************************************************************
-- Model: testbench for a uniaxial MEMS accelerometer accelZa_02.vhd in hAMSter
--
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 30.09.2021

-- Library dependencies:
--	accelZa_02.vhd - VHDL-AMS generated code from ANSYS for hAMSter
--
-- https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/uniaxial_accelerometer
-------------------------------------------------------------------------------
-- parameters, uMKSV units 
--
-- loading cases
--   0. static mechanical test: az_input
--	10. static mechanical test, constant modal forces
--	11.        mechanical test: ramp/sweep 
--	12.        mechanical test: sin/chirp
--	13.        mechanical test: puls

--	20. static electrical test: dc
--	21.        electrical test: ramp/sweep, pull-in
--	22.        electrical test: chirp
--	23.        electrical test: puls
--
--
--
-- Damping: modal quality factors qm_i in accelZa_02.vhd
--
-------------------------------------------------------------------------------
-- Euler solver: time=5m; step=200n *** 2021-07-27
-------------------------------------------------------------------------------
-- ID: testbench_02.vhd

-- ver. 0.22 02.08.2021 8 master nodes, az_input
-- ver. 0.30 29.09.2021 GitHuB realize
-- ver. 0.31 30.09.2021 more loading cases
--*****************************************************************************
--*****************************************************************************

use work.electromagnetic_system.all;
use work.all;

library ieee;
use ieee.math_real.all;
                
entity testbench is
end;

architecture behav of testbench is
  terminal struc1_ext,struc2_ext: translational; 	  -- modal dof
  terminal lagrange1_ext,lagrange2_ext,lagrange3_ext,lagrange4_ext,lagrange5_ext,lagrange6_ext,lagrange7_ext,lagrange8_ext:translational; --
  terminal master1_ext,master2_ext,master3_ext,master4_ext,master5_ext,master6_ext,master7_ext,master8_ext:translational;     --
  terminal elec1_ext,elec2_ext,elec3_ext: electrical;           --

  -- Modal displacement
  quantity q_ext1 across fm_ext1 through struc1_ext;          -- modal amplitude 1 (mode 1)
  quantity q_ext2 across fm_ext2 through struc2_ext;          -- modal amplitude 2 (mode 5)

  -- Lagrangian multipler                                               
  quantity p_ext1 across r_ext1  through lagrange1_ext;
  quantity p_ext2 across r_ext2  through lagrange2_ext;
  quantity p_ext3 across r_ext3  through lagrange3_ext;
  quantity p_ext4 across r_ext4  through lagrange4_ext;
  quantity p_ext5 across r_ext5  through lagrange5_ext;
  quantity p_ext6 across r_ext6  through lagrange6_ext;
  quantity p_ext7 across r_ext7  through lagrange7_ext;
  quantity p_ext8 across r_ext8  through lagrange8_ext;

  -- Nodal displacement
  quantity u_ext1 across f_ext1  through master1_ext;          -- nodal amplitude 1
  quantity u_ext2 across f_ext2  through master2_ext;          -- nodal amplitude 2
  quantity u_ext3 across f_ext3  through master3_ext;          -- nodal amplitude 3
  quantity u_ext4 across f_ext4  through master4_ext;          -- nodal amplitude 4
  quantity u_ext5 across f_ext5  through master5_ext;          -- nodal amplitude 5
  quantity u_ext6 across f_ext6  through master6_ext;          -- nodal amplitude 6
  quantity u_ext7 across f_ext7  through master7_ext;          -- nodal amplitude 7
  quantity u_ext8 across f_ext8  through master8_ext;          -- nodal amplitude 8

  -- Electrical ports
  quantity v_ext1 across i_ext1  through elec1_ext;           -- conductor 1
  quantity v_ext2 across i_ext2  through elec2_ext;           -- conductor 2
  quantity v_ext3 across i_ext3  through elec3_ext;           -- conductor 3

  quantity az_input: real;

  constant digital_delay:time:=200.0 ns;        -- digital time step size for matrix update == analog time step

--  constant az_input:real:=1.0*10.0;

  constant t_end:real:=5.0E-03;
  constant    dt:real:=2.0E-07; -- time step

  constant ac_value:real:= 1.0;
  constant dc_value:real:= 1.1; -- V23_pullin=1.085V (ANSYS) / gap=1.8

-- puls
  constant   t1:real:= 0.3E-03;
  constant   t2:real:= 1.0E-03; -- 5.0E-06
-- chirp
  constant fm_1:real:=   1205.3;	-- mode1 frequency
  constant fm_2:real:=  15539.0; 	-- mode5 frequency
  constant f_begin:real:=   1205.3*0.1;               -- begin of frequency sweep
  constant f_end:real:=     1205.3*7.0;               --   end of frequency sweep

  constant fm1_test:real:=  0.2716; -- f=k*u => u=f/k
  constant fm2_test:real:=  76.516;

-- loading cases
--	constant   key_load:integer:= 0; -- static mechanical test: az_input

--	constant   key_load:integer:=10; -- static mechanical test: constant modal forces
--	constant   key_load:integer:=11; --        mechanical test: ramp/sweep 
--	constant   key_load:integer:=12; --        mechanical test: sin/chirp
--	constant   key_load:integer:=13; --        mechanical test: puls

--	constant   key_load:integer:=20; -- static electrical test: dc
	constant   key_load:integer:=21; --        electrical test: ramp/sweep, pull-in
--	constant   key_load:integer:=22; --        electrical test: chirp
--	constant   key_load:integer:=23; --        electrical test: puls

begin

-- Loads
if key_load =  0 use -- static mechanical test: az_input
     az_input == 2.0;
	 --az_input == 10.0/t_end*now;
     v_ext1==0.0;
	 v_ext2==0.0;
	fm_ext1==0.0;          -- external modal force 1
	fm_ext2==0.0;          -- external modal force 2

-- ANSYS: az=2.0*g => Uzmax=0.117083um (mn4) Uzmin=-0.162066um (mn2)
--
-- mn3 o---------------o mn4
--     |               |
--     |               |
--     |               |
--     | movable       |
--     | electrode     |
--     |               |
--     |               |
--     | cond3         | 
-- mn1 o---------------o mn2
--(mn5)                 (mn6)

end use;

if key_load = 10 use -- static mechanical test: modal forces
     az_input == 0.0;
     v_ext1==0.0;
	 v_ext2==0.0;
	fm_ext1==fm1_test;          -- external modal force 1: fm_1=km_1 => q_1=1
	fm_ext2==fm2_test;          -- external modal force 2: fm_2=km_2 => q_2=1 
end use;

if key_load = 11 use -- ramp/sweep 
	az_input == 0.0;
    v_ext1==0.0;
	v_ext2==0.0;
	fm_ext1==fm1_test/t_end/1.0*now;
	fm_ext2==fm2_test/t_end/1.0*now;
end use;

if key_load = 12 use -- sin/chirp 
	az_input == 0.0;
    v_ext1==0.0;
	v_ext2==0.0;
	fm_ext1==0.0 + fm1_test*sin(2.0*3.14*(f_begin + (f_end-f_begin)/t_end*now) * now);
	fm_ext2==0.0;          
end use;

if key_load = 13 use -- puls
	az_input == 0.0;
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
	az_input == 0.0;
    v_ext1== 0.5;
	v_ext2== 0.0; -- ground electrode
	fm_ext1==0.0;
	fm_ext2==0.0;
end use;

if key_load = 21 use -- ramp/sweep
	az_input == 0.0;
    v_ext2 == dc_value/t_end*now;
	i_ext1== 0.0;
	fm_ext1==0.0;
	fm_ext2==0.0;
end use;

if key_load = 22 use -- chirp
	az_input == 0.0;
    v_ext1 == dc_value*0.1 + ac_value*sin(2.0*3.14*(f_begin + (f_end-f_begin)/t_end*now) * now);
	v_ext2== 0.0;
	fm_ext1==0.0;
	fm_ext2==0.0;

end use;

if key_load = 23 use -- puls
	az_input == 0.0;
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
--i_ext3==0.0; -- floating movable plate
v_ext3==0.0; -- grounded movable plate

--fm_ext1==0.0;          -- external modal force 1
--fm_ext2==0.0;          -- external modal force 2

-- Lagrangian ports: p/r
r_ext1==0.0;           -- must be zero
r_ext2==0.0;           -- must be zero
r_ext3==0.0;           -- must be zero
r_ext4==0.0;           -- must be zero
r_ext5==0.0;           -- must be zero
r_ext6==0.0;           -- must be zero
r_ext7==0.0;           -- must be zero
r_ext8==0.0;           -- must be zero
-- nodal ports: u/f
f_ext1==0.0;           -- external nodal force on master node 1
f_ext2==0.0;           -- external nodal force on master node 2 
f_ext3==0.0;           -- external nodal force on master node 3 
f_ext4==0.0;           -- external nodal force on master node 4 
f_ext5==0.0;           -- external nodal force on master node 5 
f_ext6==0.0;           -- external nodal force on master node 6 
f_ext7==0.0;           -- external nodal force on master node 7 
f_ext8==0.0;           -- external nodal force on master node 8 
-------------------------------------------------------------------------------
--
--                              Modal ports
--
--                              q1        q2
--                              o         o
--                              |         |
--    Lagrangian ports   o------o---------o------o     Nodal ports: 5 master nodes
--                       |                       | 
--  r_ext1=0 ->>- p1 o---o                       o---o u1 -<<- f_ext1=0
--                       |  element: accelZa_02  |
--                p2 o---o                       o---o u2 -<<- f_ext2=0
--                       |                       |
--                p3 o---o                       o---o u3 -<<- f_ext3=0
--                       |                       |
--                p4 o---o                       o---o u4 -<<- f_ext4=0
--                       |                       |
--                p5 o---o                       o---o u5 -<<- f_ext5=0
--                       |                       |
--                p6 o---o                       o---o u6 -<<- f_ext6=0
--                       |                       |
--                p7 o---o                       o---o u7 -<<- f_ext7=0
--                       |                       |
--                p8 o---o                       o---o u8 -<<- f_ext8=0
--                       |                       |
--                       o------o----o----o------o
--                              |    |    |       \
--                              o    |    o        \
--                            v1_ext |  v2_ext=0    o az_input
--                                   |
--                                   o  v3_ext=0 (plate)
--
--                           Electrical ports  
--
-- ASCII-Schematic of the ROM component for uniaxial MEMS accelerometer: accelZa_02
------------------------------------------------------------------------------- 
ROM_element:      

                entity accelZa_02(ROM)
   	       generic map (digital_delay)
 	          port map (az_input,
                        struc1_ext,struc2_ext,
                        lagrange1_ext,lagrange2_ext,lagrange3_ext,lagrange4_ext,lagrange5_ext,lagrange6_ext,lagrange7_ext,lagrange8_ext,
                        master1_ext,master2_ext,master3_ext,master4_ext,master5_ext,master6_ext,master7_ext,master8_ext,
                        elec1_ext,elec2_ext,elec3_ext);

end;
-------------------------------------------------------------------------------
