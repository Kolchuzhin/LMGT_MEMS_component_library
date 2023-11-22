--*****************************************************************************
--*****************************************************************************
-- Model: resonator_120_e5
--
-- VHDL-AMS code generated from ANSYS MAPDL ROM TOOL for clamped clamped beam
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 19.10.2023
-------------------------------------------------------------------------------
--
-- Reference: 
-- https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/resonator/resonator_120_e5
--
-------------------------------------------------------------------------------
-- resonator geometric parameters (uMKSV units):
--
--    clamped clamped beam: 300x30x2 um;
--    air gap between the electrodes: 2 um;

-- resonator ROM model:
-- modes: 2 dominant (1 and 2)
-- electrodes: 5
-- capacitances: C15, C25, C35, C45
-- master nodes: 2
--                 master node 1 (B_L,0.0,0.0) -
--                 master node 2 (B_L/2,0.0,0.0)
--
--                              Modal ports
--
--                              q1        q2
--                              o         o
--                              |         |
--    Lagrangian ports   o------o---------o----------------------------o  Nodal ports (master nodes)
--                       |      o---------o 1       2 o---------o      | 
--                p1 o---o      o-------------------------------o      o---o u1
--                       |     /|        resonator_120_l5    5  |\     |
--                p2 o---o     /o-------------------------------o\     o---o u2
--                       |      o---------o 3       4 o---------o      |
--                       o------o-------o-------o-------o-------o------o
--                              |       |       |       |       |
--                              o       o       o       o       o
--                            v1_ext  v2_ext  v3_ext  v4_ext  v5_ext
--                                   
--
--                             Electrical ports  
--
--                             ASCII-Schematic of the ROM component 
-------------------------------------------------------------------------------
-- Euler solver: time=50u; step=10n ***
-------------------------------------------------------------------------------
-- ID: resonator_120_e5.vhd
--
-- ver. 0.1 19.10.2023 16:51 hAMSter: Compile OK
-- ver. 0.2 22.11.2023 GitHuB realize
--*****************************************************************************
--*****************************************************************************

--===========================================================================--
--===========================================================================--
package Electromagnetic_system IS

    nature electrical is real across real through electrical_ground reference;
    nature translational is real across real through mechanical_ground reference;

end package Electromagnetic_system;
-------------------------------------------------------------------------------
use work.electromagnetic_system.all;

library ieee;
use ieee.math_real.all;
--===========================================================================--
--===========================================================================--
entity resonator_120_e5 is
  generic (delay:time);
  port (terminal struc1,struc2:translational;
        terminal lagrange1,lagrange2:translational;
        terminal master1,master2:translational;
        terminal elec1,elec2,elec3,elec4,elec5:electrical);
end;

architecture ROM of resonator_120_e5 is
  type ret_type is array(1 to 4) of real;

quantity q1 across fm1 through struc1;
quantity q2 across fm2 through struc2;
quantity p1 across r1 through lagrange1;
quantity p2 across r2 through lagrange2;
quantity u1 across f1 through master1;
quantity u2 across f2 through master2;
quantity v1 across i1 through elec1;
quantity v2 across i2 through elec2;
quantity v3 across i3 through elec3;
quantity v4 across i4 through elec4;
quantity v5 across i5 through elec5;

--===========================================================================--
-- initial

constant mm_1:real:=  0.165640753109E-10;  -- mode2 modal mass
constant mm_2:real:=  0.182489887060E-10;  -- mode2 moda2 mass

constant fm_1:real:=  195063.0;	-- mode1 frequency 
constant fm_2:real:=  539262.0;	-- mode2 frequency

constant km_1:real:=   24.882;	-- k1=mass*((2*PI*f1)**2)
constant km_2:real:=  209.507;  -- k2=mass*((2*PI*f2)**2)

constant qm_1:real:=  10.0;      --  mode1 quality factor
constant qm_2:real:=  10.0;      --  mode2 quality factor

constant dm_1:real:=  SQRT(mm_1*km_1)/qm_1*1.0; -- damping ratio SQRT(m*k)/q
constant dm_2:real:=  SQRT(mm_2*km_2)/qm_2*1.0; -- damping ratio SQRT(m*k)/q

------------------------------------------------
-- master node 1 in geometrical space (fixed)
constant fi1_1:real:=  0.00000000000     ;  
constant fi1_2:real:=  0.00000000000     ;
-- master node 2 in geometrical space: r2==fi2_1*q1+fi2_2*q2-u2;
constant fi2_1:real:=  0.998658841194    ;  
constant fi2_2:real:= -0.100921948566E-01;

--===========================================================================--
-- s_dat_120
constant s_type120:integer:=1;
constant s_inve120:integer:=1;
signal s_ord120:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal s_fak120:real_vector(1 to 4):=(2.25952556205, 17.2690583739, 0.0, 2.837033938);
constant s_anz120:integer:= 25;
signal s_data120:real_vector(1 to 25):=
( 0.729138470506E-09,
 -0.938777711283E-15,
  0.858907609952    ,
  0.974257085384E-15,
  0.150676467300E-01,
  0.920237467060E-15,
 -0.238022650681E-09,
 -0.659142421588E-14,
  0.303547921733E-09,
  0.593583062314E-14,
  0.123813117195    ,
  0.100030279897E-13,
  0.213597715824E-02,
 -0.118123870018E-13,
  0.144475547813E-07,
 -0.102520065941E-14,
  0.296152988919E-09,
  0.733906789164E-14,
 -0.508955938352E-09,
 -0.659540827620E-14,
  0.756317659113E-04,
 -0.100524374502E-13,
  0.256946459672E-08,
  0.120602237063E-13,
 -0.993275851236E-09);
--===========================================================================--
-- ca15_dat_120
constant ca15_type120:integer:=1;
constant ca15_inve120:integer:=2;
signal ca15_ord120:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal ca15_fak120:real_vector(1 to 4):=(2.25952556205, 17.2690583739, 0.0, 52.9949021225);
constant ca15_anz120:integer:= 25;
signal ca15_data120:real_vector(1 to 25):=
( 0.895001479790    ,
  0.968164882866E-01,
 -0.554491613897E-02,
  0.471933856008E-03,
 -0.950531939297E-04,
 -0.140650817534E-01,
  0.701204439205E-03,
 -0.170668645087E-04,
  0.149012704447E-04,
 -0.639158981564E-04,
 -0.146559178895E-04,
  0.135882476960E-03,
 -0.144049064772E-03,
 -0.426910300368E-04,
  0.606782732873E-04,
  0.636144278759E-06,
  0.438860949916E-04,
 -0.353418266068E-06,
 -0.993215866276E-05,
  0.253910058546E-04,
 -0.636227182530E-04,
 -0.155824877468E-03,
  0.811969303649E-04,
  0.109332300230E-03,
 -0.114124281912E-04);

-- ca25_dat_120 is
constant ca25_type120:integer:=1;
constant ca25_inve120:integer:=2;
signal ca25_ord120:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal ca25_fak120:real_vector(1 to 4):=(2.25952556205, 17.2690583739, 0.0, 53.0017865795);
constant ca25_anz120:integer:= 25;
signal ca25_data120:real_vector(1 to 25):=
( 0.894764768020    ,
  0.969206213747E-01,
 -0.555492332364E-02,
  0.618616166758E-03,
 -0.112582440416E-03,
  0.140865282896E-01,
 -0.714668934592E-03,
  0.285827457860E-04,
 -0.651885702098E-05,
  0.166625862434E-04,
 -0.388561236831E-04,
  0.276161641055E-04,
 -0.168376508610E-03,
 -0.336149670883E-04,
  0.223798929366E-03,
 -0.153709364583E-04,
 -0.508197533466E-05,
  0.154285078736E-04,
 -0.459243755390E-05,
  0.961495747960E-05,
 -0.489312919434E-04,
  0.175246238811E-05,
  0.163921992962E-03,
  0.300445357082E-04,
 -0.212932639895E-03);

-- ca35_dat_120 is
constant ca35_type120:integer:=1;
constant ca35_inve120:integer:=2;
signal ca35_ord120:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal ca35_fak120:real_vector(1 to 4):=(2.25952556205, 17.2690583739, 0.0, 53.0259774884);
constant ca35_anz120:integer:= 25;
signal ca35_data120:real_vector(1 to 25):=
( 0.894894819622    ,
 -0.967733893992E-01,
 -0.611835502446E-02,
 -0.652031754389E-03,
  0.479280210322E-03,
  0.140653624963E-01,
  0.631376605515E-03,
  0.711632451385E-04,
  0.749779568643E-04,
 -0.210398426095E-04,
 -0.242337399530E-03,
 -0.543955286836E-03,
  0.164263723208E-02,
  0.771948597050E-03,
 -0.183770881385E-02,
  0.108199928275E-04,
  0.988216898323E-04,
  0.159622048173E-04,
 -0.699324523091E-04,
 -0.742599817933E-05,
  0.866678232936E-04,
  0.487756399160E-03,
 -0.126569273933E-02,
 -0.738244768290E-03,
  0.150101643188E-02);

-- ca45_dat_120 is
constant ca45_type120:integer:=1;
constant ca45_inve120:integer:=2;
signal ca45_ord120:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal ca45_fak120:real_vector(1 to 4):=(2.25952556205, 17.2690583739, 0.0, 52.9662343069);
constant ca45_anz120:integer:= 25;
signal ca45_data120:real_vector(1 to 25):=
( 0.894810825028    ,
 -0.968361701927E-01,
 -0.530284096080E-02,
 -0.480776641213E-03,
 -0.204681915820E-03,
 -0.140532538976E-01,
 -0.578983273412E-03,
 -0.143444541035E-03,
 -0.196784703515E-03,
  0.108521552092E-03,
  0.633957278095E-04,
  0.789844745530E-03,
 -0.701506989130E-03,
 -0.106781936195E-02,
  0.564741080308E-03,
 -0.220455031436E-05,
 -0.185030053275E-03,
  0.543613113918E-04,
  0.242622374295E-03,
 -0.731837359465E-04,
 -0.147711605516E-03,
 -0.733177220808E-03,
  0.709107303435E-03,
  0.934335029956E-03,
 -0.575066547742E-03);
--===========================================================================--
function spoly_calc(qx, qy, qz : in real:=0.0; s_type,s_inve : integer :=0;
                    s_ord, s_fak, s_data:real_vector) return ret_type is

    constant Sx:integer:=integer(s_ord(1))+1;
    constant Sy:integer:=integer(s_ord(2))+1;
    constant Sz:integer:=integer(s_ord(3))+1;
    variable fwx:real_vector(1 to Sx):=(others=>0.0);
    variable fwy:real_vector(1 to Sy):=(others=>0.0);
    variable fwz:real_vector(1 to 1):=(others=>0.0);
    variable dfwx:real_vector(1 to Sx):=(others=>0.0);
    variable dfwy:real_vector(1 to Sy):=(others=>0.0);
    variable dfwz:real_vector(1 to 1):=(others=>0.0);
    variable res_val:ret_type:=(others=>0.0);
    variable fwv,dfwvx,dfwvy,dfwvz,fak2:real:=0.0;
    variable Px_s,Py_s,Px,Py,Lx,Ly,Lz,ii:integer:=0;

  begin 
     Lx:=integer(s_ord(1));
     Ly:=integer(s_ord(2));
     Lz:=integer(s_ord(3));
     for i in 1 to Lx+1 loop
       fwx(i):=qx**(i-1)*s_fak(1)**(i-1);
       if i=2 then
         dfwx(i):=s_fak(1)**(i-1);
       end if;
       if i>2 then
         dfwx(i):=real(i-1)*qx**(i-2)*s_fak(1)**(i-1);
       end if;
     end loop;
     for i in 1 to Ly+1 loop
       fwy(i):=qy**(i-1)*s_fak(2)**(i-1);
      if i=2 then
         dfwy(i):=s_fak(2)**(i-1);
       end if;
       if i>2 then
         dfwy(i):=real(i-1)*qy**(i-2)*s_fak(2)**(i-1);
       end if;
     end loop;
     for i in 1 to Lz+1 loop
       fwz(i):=qz**(i-1)*s_fak(3)**(i-1);
      if i=2 then
         dfwz(i):=s_fak(3)**(i-1);
       end if;
       if i>2 then
         dfwz(i):=real(i-1)*qz**(i-2)*s_fak(3)**(i-1);
       end if;
     end loop;
     if s_type=1 then
       ii:=1;
       for zi in 0 to Lz loop
         for yi in 0 to Ly loop
           for xi in 0 to Lx loop
             fwv:=fwv+s_data(ii)*fwx(xi+1)*fwy(yi+1)*fwz(zi+1);
             dfwvx:=dfwvx+s_data(ii)*dfwx(xi+1)*fwy(yi+1)*fwz(zi+1);
             dfwvy:=dfwvy+s_data(ii)*fwx(xi+1)*dfwy(yi+1)*fwz(zi+1);
             dfwvz:=dfwvz+s_data(ii)*fwx(xi+1)*fwy(yi+1)*dfwz(zi+1);
             ii:=ii+1;
           end loop;
         end loop;
       end loop;
     end if;
     
     if s_inve=1 then
       fwv:=fwv*s_fak(4);
       dfwvx:=dfwvx*s_fak(4);
       dfwvy:=dfwvy*s_fak(4);
       dfwvz:=dfwvz*s_fak(4);
     else
       fak2:=1.0/s_fak(4);
       dfwvx:=-dfwvx/(fwv**2);
       dfwvy:=-dfwvy/(fwv**2);
       dfwvz:=-dfwvz/(fwv**2);
       fwv:=1.0/fwv;
       fwv:=fwv*fak2;
       dfwvx:=dfwvx*fak2;
       dfwvy:=dfwvy*fak2;
       dfwvz:=dfwvz*fak2;
     end if;
     res_val:=(fwv, dfwvx, dfwvy, dfwvz);
     return res_val;
  end spoly_calc;
--===========================================================================--

signal sene_120:ret_type;
signal ca15_120:ret_type;
signal ca25_120:ret_type;
signal ca35_120:ret_type;
signal ca45_120:ret_type;


begin

p1:process
begin
  sene_120<= spoly_calc(q1,q2,0.0,s_type120,s_inve120,s_ord120,s_fak120,s_data120);
  ca15_120<= spoly_calc(q1,q2,0.0,ca15_type120,ca15_inve120,ca15_ord120,ca15_fak120,ca15_data120);
  ca25_120<= spoly_calc(q1,q2,0.0,ca25_type120,ca25_inve120,ca25_ord120,ca25_fak120,ca25_data120);
  ca35_120<= spoly_calc(q1,q2,0.0,ca35_type120,ca35_inve120,ca35_ord120,ca35_fak120,ca35_data120);
  ca45_120<= spoly_calc(q1,q2,0.0,ca45_type120,ca45_inve120,ca45_ord120,ca45_fak120,ca45_data120);
  wait for delay;
end process;

break on sene_120(2),sene_120(3),sene_120(4),ca15_120(2),ca15_120(3),ca15_120(4),ca25_120(2),ca25_120(3),ca25_120(4),ca35_120(2),ca35_120(3),ca35_120(4),ca45_120(2),ca45_120(3),ca45_120(4);

-- linear mechanical model 
--fm1==mm_1*q1'dot'dot + dm_1*q1'dot + km_1*q1;
--fm2==mm_2*q2'dot'dot + dm_2*q2'dot + km_2*q2;

fm1==mm_1*q1'dot'dot + dm_1*q1'dot +sene_120(2) -ca15_120(2)*(v1-v5)**2/2.0 -ca25_120(2)*(v2-v5)**2/2.0 -ca35_120(2)*(v3-v5)**2/2.0 -ca45_120(2)*(v4-v5)**2/2.0 +fi1_1*p1 +fi2_1*p2;
fm2==mm_2*q2'dot'dot + dm_2*q2'dot +sene_120(3) -ca15_120(3)*(v1-v5)**2/2.0 -ca25_120(3)*(v2-v5)**2/2.0 -ca35_120(3)*(v3-v5)**2/2.0 -ca45_120(3)*(v4-v5)**2/2.0 +fi1_2*p1 +fi2_2*p2;

r1==fi1_1*q1+fi1_2*q2-u1;
r2==fi2_1*q1+fi2_2*q2-u2; 

f1==-p1;
f2==-p2;

i1==+((v1-v5)*(ca15_120(2)*q1'dot+ca15_120(3)*q2'dot)+(v1'dot-v5'dot)*ca15_120(1));
i2==+((v2-v5)*(ca25_120(2)*q1'dot+ca25_120(3)*q2'dot)+(v2'dot-v5'dot)*ca25_120(1));
i3==+((v3-v5)*(ca35_120(2)*q1'dot+ca35_120(3)*q2'dot)+(v3'dot-v5'dot)*ca35_120(1));
i4==+((v4-v5)*(ca45_120(2)*q1'dot+ca45_120(3)*q2'dot)+(v4'dot-v5'dot)*ca45_120(1));
i5==-((v1-v5)*(ca15_120(2)*q1'dot+ca15_120(3)*q2'dot)+(v1'dot-v5'dot)*ca15_120(1))-((v2-v5)*(ca25_120(2)*q1'dot+ca25_120(3)*q2'dot)+(v2'dot-v5'dot)*ca25_120(1))-((v3-v5)*(ca35_120(2)*q1'dot+ca35_120(3)*q2'dot)+(v3'dot-v5'dot)*ca35_120(1))-((v4-v5)*(ca45_120(2)*q1'dot+ca45_120(3)*q2'dot)+(v4'dot-v5'dot)*ca45_120(1));

end;

--===========================================================================--
--===========================================================================--