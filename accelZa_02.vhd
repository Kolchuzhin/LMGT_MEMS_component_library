--*****************************************************************************
--*****************************************************************************
-- Model: accelZa_02
-- uniaxial polysilicon MEMS accelerometer
--
-- VHDL-AMS generated code from ANSYS MAPDL ROM TOOL for hAMSter:
-- 	rompass1_accelZa.mac
--  rompass2_accelZ.mac
--
-- uMKSV units 
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 02.08.2021
-------------------------------------------------------------------------------
-- model geometric parameters, um
-- gc=15.8		! the gap between plate corners and cap surface
-- heght=15	! the thickness of the moving plate (baseline: 15um)
-- gd=1.8		! the gap between plate corners and die surface
--
-- Reference: 
-- http://dx.doi.org/10.3390/s121013985
-------------------------------------------------------------------------------
-- modes: 2 dominant (1 and 5)
-- electrodes: 3 (2 capacitances: C13 and C23)
-- element load: the linear acceleration of the structure az=1g x az_input
-- master nodes: 8
--
--
--
--
--                              Modal ports
--
--                              q1        q2
--                              o         o
--                              |         |
--    Lagrangian ports   o------o---------o------o     Nodal ports:
--                       |                       | 
--                p1 o---o                       o---o u1
--                       | ROM element: accelZa  |
--                p2 o---o                       o---o u2
--                       |                       |
--                p3 o---o                       o---o u3
--                       |                       |
--                p4 o---o                       o---o u4
--                       |                       |
--                p5 o---o                       o---o u5
--                       |                       |
--                p6 o---o                       o---o u6
--                       |                       |
--                p7 o---o                       o---o u7
--                       |                       |
--                p8 o---o                       o---o u8
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
-- ASCII-Schematic of the ROM component for uniaxial MEMS accelerometer: accelZa
-------------------------------------------------------------------------------
-- Euler solver: time=5m; step=500n ***
-------------------------------------------------------------------------------
-- ID: accelZa_02.vhd
--
-- ver. 1.02 05.08.2021 GitHuB realize: 
-- https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/uniaxial_accelerometer
--
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
entity accelZa_02 is
  generic (delay:time);
  port (quantity az_input: in real;
        terminal struc1,struc2:translational;
        terminal lagrange1,lagrange2,lagrange3,lagrange4,lagrange5,lagrange6,lagrange7,lagrange8:translational;
        terminal master1,master2,master3,master4,master5,master6,master7,master8:translational;
        terminal elec1,elec2,elec3:electrical);
end;


architecture ROM of accelZa_02 is
  type ret_type is array(1 to 4) of real;

quantity q1 across fm1 through struc1;
quantity q2 across fm2 through struc2;
quantity p1 across r1 through lagrange1;
quantity p2 across r2 through lagrange2;
quantity p3 across r3 through lagrange3;
quantity p4 across r4 through lagrange4;
quantity p5 across r5 through lagrange5;
quantity p6 across r6 through lagrange6;
quantity p7 across r7 through lagrange7;
quantity p8 across r8 through lagrange8;
quantity u1 across f1 through master1;
quantity u2 across f2 through master2;
quantity u3 across f3 through master3;
quantity u4 across f4 through master4;
quantity u5 across f5 through master5;
quantity u6 across f6 through master6;
quantity u7 across f7 through master7;
quantity u8 across f8 through master8;
quantity v1 across i1 through elec1;
quantity v2 across i2 through elec2;
quantity v3 across i3 through elec3;
--===========================================================================--
constant mm_1:real:=  0.473364651010E-08;	-- mode1 modal mass
constant mm_2:real:=  0.803474901717E-08;	-- mode5 modal mass

constant fm_1:real:=   1205.3;	-- mode1 frequency
constant fm_2:real:=  15539.0; 	-- mode5 frequency

constant km_1:real:=  0.2716;	-- k1=mass*((2*PI*f1)**2)
constant km_2:real:=  76.516;   -- k2=mass*((2*PI*f2)**2)

constant qm_1:real:=  1.0;      --  mode1 quality factor
constant qm_2:real:=  1.0;      --  mode5 quality factor

constant dm_1:real:=  SQRT(mm_1*km_1)/qm_1; -- damping ratio SQRT(m*k)/q
constant dm_2:real:=  SQRT(mm_2*km_2)/qm_2; -- damping ratio SQRT(m*k)/q

constant fi1_1:real:=  0.999835485909; -- master node 1
constant fi1_2:real:=  0.403769743614;
constant fi2_1:real:=  0.999835586749;
constant fi2_2:real:=  0.403769489490;
constant fi3_1:real:= -0.745314753376;
constant fi3_2:real:=  0.999974954447;
constant fi4_1:real:= -0.745314653634;
constant fi4_2:real:=  0.999974699952;
constant fi5_1:real:=  0.999835485910;
constant fi5_2:real:=  0.403769744306;
constant fi6_1:real:=  0.999835586751;
constant fi6_2:real:=  0.403769490182;
constant fi7_1:real:= -0.745314753375;
constant fi7_2:real:=  0.999974955317;
constant fi8_1:real:= -0.745314653633;
constant fi8_2:real:=  0.999974700821; -- master node 8

constant el1_1:real:= -0.218433078934E-01;
constant el1_2:real:= -0.109604826007    ;
constant el2_1:real:= -0.436866157865E-01;
constant el2_2:real:= -0.219209652036    ;
--===========================================================================--
constant s_type150:integer:=1;
constant s_inve150:integer:=1;
signal s_ord150:real_vector(1 to 3):=(4.0, 2.0, 0.0);
signal s_fak150:real_vector(1 to 4):=(1.02, 51.0, 0.0, 0.1452005335);
constant s_anz150:integer:=15;
signal s_data150:real_vector(1 to 15):=(
  0.153046214864E-10,
 -0.115346424932E-10,
  0.898594050430    ,
  0.131856183100E-10,
  0.451168146307E-09,
 -0.192639596352E-11,
 -0.180817757915E-06,
 -0.100841662878E-12,
  0.819408921286E-10,
  0.250892538141E-11,
  0.101405768487    ,
  0.961373531525E-11,
  0.295710869676E-09,
 -0.109899447351E-10,
 -0.478033992492E-09);
--===========================================================================--
constant ca13_type150:integer:=1;
constant ca13_inve150:integer:=2;
signal ca13_ord150:real_vector(1 to 3):=(4.0, 2.0, 0.0);
signal ca13_fak150:real_vector(1 to 4):=(1.02, 51.0, 0.00, 1.24878218153);
constant ca13_anz150:integer:=15;
signal ca13_data150:real_vector(1 to 15):=(
  0.821596533919    ,
 -0.180241554630    ,
 -0.127562294156E-01,
  0.818686861972E-03,
  0.432945579544E-02,
  0.759644315386E-02,
  0.534049229957E-03,
  0.997510446329E-03,
 -0.908056944362E-03,
 -0.143119042257E-02,
  0.250236472124E-05,
 -0.180877516419E-04,
 -0.633278731250E-04,
  0.297334467098E-04,
  0.728567968866E-04);
--===========================================================================--
constant ca23_type150:integer:=1;
constant ca23_inve150:integer:=2;
signal ca23_ord150:real_vector(1 to 3):=(4.0, 2.0, 0.0);
signal ca23_fak150:real_vector(1 to 4):=(1.02, 51.0, 0.0, 0.958512583853);
constant ca23_anz150:integer:= 15;
signal ca23_data150:real_vector(1 to 15):=(
  0.783998489543    ,
  0.232937982634    ,
 -0.305701885773E-01,
 -0.170807820768E-01,
  0.268079240498E-01,
  0.461037567958E-02,
 -0.188754982379E-04,
  0.360563171587E-04,
  0.963438020727E-03,
 -0.790519579176E-03,
 -0.272090902872E-04,
 -0.572697741434E-04,
  0.311851954139E-03,
 -0.304790455820E-04,
 -0.216006518183E-03);
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

signal sene_150:ret_type;
signal ca13_150:ret_type;
signal ca23_150:ret_type;


begin

p1:process
begin
  sene_150<= spoly_calc(q1,q2,0.0,s_type150,s_inve150,s_ord150,s_fak150,s_data150);
  ca13_150<= spoly_calc(q1,q2,0.0,ca13_type150,ca13_inve150,ca13_ord150,ca13_fak150,ca13_data150);
  ca23_150<= spoly_calc(q1,q2,0.0,ca23_type150,ca23_inve150,ca23_ord150,ca23_fak150,ca23_data150);
  wait for delay;
end process;

break on sene_150(2),sene_150(3),sene_150(4),ca13_150(2),ca13_150(3),ca13_150(4),ca23_150(2),ca23_150(3),ca23_150(4);

fm1==mm_1*q1'dot'dot + dm_1*q1'dot +sene_150(2) -ca13_150(2)*(v1-v3)**2/2.0 -ca23_150(2)*(v2-v3)**2/2.0 +fi1_1*p1 +fi2_1*p2 +fi3_1*p3 +fi4_1*p4 +fi5_1*p5 +fi6_1*p6 +fi7_1*p7 +fi8_1*p8 -el1_1*az_input;
fm2==mm_2*q2'dot'dot + dm_2*q2'dot +sene_150(3) -ca13_150(3)*(v1-v3)**2/2.0 -ca23_150(3)*(v2-v3)**2/2.0 +fi1_2*p1 +fi2_2*p2 +fi3_2*p3 +fi4_2*p4 +fi5_2*p5 +fi6_2*p6 +fi7_2*p7 +fi8_2*p8 -el1_2*az_input;
--
r1==fi1_1*q1+fi1_2*q2-u1;
r2==fi2_1*q1+fi2_2*q2-u2;
r3==fi3_1*q1+fi3_2*q2-u3;
r4==fi4_1*q1+fi4_2*q2-u4;
r5==fi5_1*q1+fi5_2*q2-u5;
r6==fi6_1*q1+fi6_2*q2-u6;
r7==fi7_1*q1+fi7_2*q2-u7;
r8==fi8_1*q1+fi8_2*q2-u8;
--
f1==-p1;
f2==-p2;
f3==-p3;
f4==-p4;
f5==-p5;
f6==-p6;
f7==-p7;
f8==-p8;

i1==+((v1-v3)*(ca13_150(2)*q1'dot+ca13_150(3)*q2'dot)+(v1'dot-v3'dot)*ca13_150(1));
i2==+((v2-v3)*(ca23_150(2)*q1'dot+ca23_150(3)*q2'dot)+(v2'dot-v3'dot)*ca23_150(1));
i3==-((v1-v3)*(ca13_150(2)*q1'dot+ca13_150(3)*q2'dot)+(v1'dot-v3'dot)*ca13_150(1))-((v2-v3)*(ca23_150(2)*q1'dot+ca23_150(3)*q2'dot)+(v2'dot-v3'dot)*ca23_150(1));

end;
--===========================================================================--
--===========================================================================--