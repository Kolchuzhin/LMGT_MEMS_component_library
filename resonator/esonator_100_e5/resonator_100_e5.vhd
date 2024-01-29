--*****************************************************************************
--*****************************************************************************
-- Model: resonator_100_e5
--
-- VHDL-AMS code generated from ANSYS MAPDL ROM TOOL for clamped clamped beam
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 25.01.2024
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
-- modes: 1. dominant
-- electrodes: 5
-- capacitances: C15, C25, C35, C45
-- master nodes: 2
--                 master node 1 (B_L,0.0,0.0) -
--                 master node 2 (B_L/2,0.0,0.0)
--
--                              Modal ports
--
--                              q1        
--                              o         
--                              |         
--    Lagrangian ports   o------o--------------------------------------o  Nodal ports (master nodes)
--                       |      o---------o 1       2 o---------o      | 
--                p1 o---o      o-------------------------------o      o---o u1
--                       |     /|        resonator_100_e5    5  |\     |
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
--                       ASCII-Schematic of the ROM component 
-------------------------------------------------------------------------------
-- Euler solver: time=50u; step=10n ***
-------------------------------------------------------------------------------
-- ID: resonator_120_e5.vhd
--
-- ver. 0.1 26.01.2024 16:00 hAMSter: Compile OK
-- ver. 0.2 29.01.2024 GitHuB realize
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
entity resonator_100_e5 is
  generic (delay:time);
  port (terminal struc1,struc2:translational;
        terminal lagrange1,lagrange2:translational;
        terminal master1,master2:translational;
        terminal elec1,elec2,elec3,elec4,elec5:electrical);
end entity resonator_100_e5;

architecture ROM of resonator_100_e5 is
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
-- initial / use work.initial.all;

constant mm_1:real:=  0.165849605839E-10;       -- mode1 modal mass
constant fm_1:real:=  195063.0;	                -- mode1 frequency 
constant km_1:real:=  24.882;                   -- k1=mass*((2*PI*f1)**2)
constant qm_1:real:=  10.0;                     -- mode1 quality factor
constant dm_1:real:=  SQRT(mm_1*km_1)/qm_1*1.0; -- damping ratio SQRT(m*k)/q

------------------------------------------------
-- master node 1 in geometrical space (fixed)
constant fi1_1:real:=  0.00000000000     ;  
-- master node 2 in geometrical space: r2==fi2_1*q1+fi2_2*q2-u2;
constant fi2_1:real:=  0.998653524060    ;  

--===========================================================================--
-- s_dat_100
constant s_type100:integer:=1;
constant s_inve100:integer:=1;
signal s_ord100:real_vector(1 to 3):=(2.0, 0.0, 0.0);
signal s_fak100:real_vector(1 to 4):=(1.99809054033, 0.0, 0.0, 3.111921674);
constant s_anz100:integer:= 3;
signal s_data100:real_vector(1 to 3):=
( 0.195740090803E-10, 0.725429817223E-16, 0.999999999948 );
--===========================================================================--
-- ca15_dat_100
constant ca15_type100:integer:=1;
constant ca15_inve100:integer:=2;
signal ca15_ord100:real_vector(1 to 3):=(2.0, 0.0, 0.0);
signal ca15_fak100:real_vector(1 to 4):=(1.99809054033, 0.0, 0.0, 52.8892432036);
constant ca15_anz100:integer:= 3;
signal ca15_data100:real_vector(1 to 3):=
( 0.896784087782, 0.110237368631, -0.723247801823E-02);

-- ca25_dat_100 is
constant ca25_type100:integer:=1;
constant ca25_inve100:integer:=2;
signal ca25_ord100:real_vector(1 to 3):=(2.0, 0.0, 0.0);
signal ca25_fak100:real_vector(1 to 4):=(1.99809054033, 0.0, 0.0, 52.8952706410);
constant ca25_anz100:integer:= 3;
signal ca25_data100:real_vector(1 to 3):=
( 0.896601385295, 0.110482858182, -0.732538171772E-02);

-- ca35_dat_100 is
constant ca35_type100:integer:=1;
constant ca35_inve100:integer:=2;
signal ca35_ord100:real_vector(1 to 3):=(2.0, 0.0, 0.0);
signal ca35_fak100:real_vector(1 to 4):=(1.99809054033, 0.0, 0.0, 52.9169551009);
constant ca35_anz100:integer:= 3;
signal ca35_data100:real_vector(1 to 3):=
( 0.896678693706, -0.110307603691, -0.725727191236E-02);

-- ca45_dat_100 is
constant ca45_type100:integer:=1;
constant ca45_inve100:integer:=2;
signal ca45_ord100:real_vector(1 to 3):=(2.0, 0.0, 0.0);
signal ca45_fak100:real_vector(1 to 4):=(1.99809054033, 0.0, 0.0, 52.8582790368);
constant ca45_anz100:integer:= 3;
signal ca45_data100:real_vector(1 to 3):=
( 0.896652263465, -0.110265711411, -0.711974203845E-02);
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

signal sene_100:ret_type;
signal ca15_100:ret_type;
signal ca25_100:ret_type;
signal ca35_100:ret_type;
signal ca45_100:ret_type;


begin

p1:process
begin
  sene_100<= spoly_calc(q1,0.0,0.0,s_type100,s_inve100,s_ord100,s_fak100,s_data100);
  ca15_100<= spoly_calc(q1,0.0,0.0,ca15_type100,ca15_inve100,ca15_ord100,ca15_fak100,ca15_data100);
  ca25_100<= spoly_calc(q1,0.0,0.0,ca25_type100,ca25_inve100,ca25_ord100,ca25_fak100,ca25_data100);
  ca35_100<= spoly_calc(q1,0.0,0.0,ca35_type100,ca35_inve100,ca35_ord100,ca35_fak100,ca35_data100);
  ca45_100<= spoly_calc(q1,0.0,0.0,ca45_type100,ca45_inve100,ca45_ord100,ca45_fak100,ca45_data100);
  wait for delay;
end process;

break on sene_100(2),sene_100(3),sene_100(4),ca15_100(2),ca15_100(3),ca15_100(4),ca25_100(2),ca25_100(3),ca25_100(4),ca35_100(2),ca35_100(3),ca35_100(4),ca45_100(2),ca45_100(3),ca45_100(4);

fm1==mm_1*q1'dot'dot + dm_1*q1'dot +sene_100(2) -ca15_100(2)*(v1-v5)**2/2.0 -ca25_100(2)*(v2-v5)**2/2.0 -ca35_100(2)*(v3-v5)**2/2.0 -ca45_100(2)*(v4-v5)**2/2.0 +fi1_1*p1 +fi2_1*p2;
r1==fi1_1*q1-u1;
r2==fi2_1*q1-u2;
f1==-p1;
f2==-p2;
i1==+((v1-v5)*(ca15_100(2)*q1'dot)+(v1'dot-v5'dot)*ca15_100(1));
i2==+((v2-v5)*(ca25_100(2)*q1'dot)+(v2'dot-v5'dot)*ca25_100(1));
i3==+((v3-v5)*(ca35_100(2)*q1'dot)+(v3'dot-v5'dot)*ca35_100(1));
i4==+((v4-v5)*(ca45_100(2)*q1'dot)+(v4'dot-v5'dot)*ca45_100(1));
i5==-((v1-v5)*(ca15_100(2)*q1'dot)+(v1'dot-v5'dot)*ca15_100(1))-((v2-v5)*(ca25_100(2)*q1'dot)+(v2'dot-v5'dot)*ca25_100(1))-((v3-v5)*(ca35_100(2)*q1'dot)+(v3'dot-v5'dot)*ca35_100(1))-((v4-v5)*(ca45_100(2)*q1'dot)+(v4'dot-v5'dot)*ca45_100(1));

end architecture ROM;
--===========================================================================--
--===========================================================================--