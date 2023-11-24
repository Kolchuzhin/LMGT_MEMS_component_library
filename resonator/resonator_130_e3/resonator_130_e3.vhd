--*****************************************************************************
--*****************************************************************************
-- Model: resonator_130_e3
--
-- VHDL-AMS code generated from ANSYS MAPDL ROM TOOL for clamped clamped beam
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 24.11.2023
-------------------------------------------------------------------------------
--
-- Reference: 
-- 
--
-------------------------------------------------------------------------------
-- resonator geometric parameters (uMKSV units):
--
--    clamped clamped beam: 200x20x2 um;
--    air gap between the electrodes: 4 um;

-- resonator ROM model:
-- modes: 2 dominant (1 and 3)
-- electrodes: 3
-- capacitances: C12, C13, C23
-- master nodes: 2
--                 master node 1 (B_L/4,0.0,0.0) -
--                 master node 2 (B_L/2,0.0,0.0)
--
--                              Modal ports
--
--                              q1        q2
--                              o         o
--                              |         |
--    Lagrangian ports   o------o---------o----------------------------o  Nodal ports (master nodes)
--                       |      o-------------------------------o  3   | 
--                p1 o---o      o-------------------------------o      o---o u1
--                       |     /|        resonator_130_e3       |\ 2   |
--                p2 o---o     /o-------------------------------o\     o---o u2
--                       |      o-------------------------------o  1   |
--                       o------o---------------o---------------o------o
--                              |               |               |
--                              o               o               o
--                            v1_ext          v2_ext          v3_ext
--                                   
--                             Electrical ports  
--
--                             ASCII-Schematic of the ROM component 
-------------------------------------------------------------------------------
-- Euler solver: time=50u; step=10n ***
-------------------------------------------------------------------------------
-- ID: resonator_130_e3.vhd
--
-- ver. 0.1 24.11.2023 hAMSter: Compile OK
-- ver. 0.2 24.11.2023 GitHuB realize
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
entity resonator_130_e3 is
  generic (delay:time; el_load1, el_load2:real);
  port (terminal struc1,struc2:translational;
        terminal lagrange1,lagrange2:translational;
        terminal master1,master2:translational;
        terminal elec1,elec2,elec3:electrical);
end;

architecture ROM of resonator_130_e3 is
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

--===========================================================================--
-- initial

constant mm_1:real:=  0.736387120106E-11;  -- mode1 modal mass
constant mm_2:real:=  0.812342278684E-11;  -- mode2 moda2 mass

constant fm_1:real:= 0.43949E+06;	-- mode1 frequency 
constant fm_2:real:= 0.23950E+07;	-- mode2 frequency

 constant km_1:real:=   56.152; 	-- k1=mass*((2*PI*f1)**2)
 constant km_2:real:= 1839.543;     -- k2=mass*((2*PI*f2)**2)

constant qm_1:real:=     10.0;      --  mode1 quality factor
constant qm_2:real:=     10.0;      --  mode2 quality factor

constant dm_1:real:=  SQRT(mm_1*km_1)/qm_1*1.0; -- damping ratio SQRT(m*k)/q
constant dm_2:real:=  SQRT(mm_2*km_2)/qm_2*1.0; -- damping ratio SQRT(m*k)/q

------------------------------------------------
-- master node 1 in geometrical space (fixed)
constant fi1_1:real:=  0.541864758005;
constant fi1_2:real:=  0.906040223737;
-- master node 2 in geometrical space: r2==fi2_1*q1+fi2_2*q2-u2;
constant fi2_1:real:=  0.998641130934;
constant fi2_2:real:= -0.927369782758;
-- element load 1: acceleration in Z-direction 9.81e6 m/s**2 ==> uz=1.2um
constant el1_1:real:=  -115.304806714;
constant el1_2:real:=  -581.598572344;
-- element load 2: uniform pressure 200 kPa ==> uz=3.67um
constant el2_1:real:=   38.6216029906;
constant el2_2:real:=   21.2778923288;

--===========================================================================--
-- s_dat_130
constant s_type130:integer:=1;
constant s_inve130:integer:=1;
signal s_ord130:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal s_fak130:real_vector(1 to 4):=(0.34, 17.00, 0.00, 447.9226694);
constant s_anz130:integer:=25;
signal s_data130:real_vector(1 to 25):=(
  0.209849693505E-05,
 -0.649829585728E-14,
  0.542223324629    ,
  0.885788062311E-14,
  0.419368100669    ,
 -0.153286176519E-14,
  0.150903376247E-05,
  0.997282710823E-14,
 -0.277485148013E-01,
 -0.897352089877E-14,
  0.710501608840E-02,
  0.537927752025E-13,
  0.344634623102E-02,
 -0.752251057326E-13,
  0.297470829423E-05,
  0.170098275316E-14,
 -0.986759760050E-04,
 -0.111922312064E-13,
 -0.170706592075E-06,
  0.101202014810E-13,
  0.529735145400E-05,
 -0.483123011859E-13,
  0.136942022284E-07,
  0.677585313843E-13,
 -0.112825436564E-08);
--===========================================================================--
-- ca12_dat_130
constant ca12_type130:integer:=1;
constant ca12_inve130:integer:=2;
signal ca12_ord130:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal ca12_fak130:real_vector(1 to 4):=(0.34, 17.00, 0.00, 126.40674724);
constant ca12_anz130:integer:=25;
signal ca12_data130:real_vector(1 to 25):=(
  0.770140196853    ,
  0.262268332560    ,
 -0.493462177229E-01,
  0.306222442310E-01,
 -0.173533564654E-01,
  0.242265567975E-02,
  0.142199119789E-02,
 -0.861762572042E-03,
  0.177429806530E-02,
 -0.145095827459E-02,
 -0.443310444888E-04,
  0.201768255311E-04,
 -0.214218622286E-03,
  0.145235115030E-03,
  0.163122977930E-03,
  0.461943721883E-05,
  0.125273373312E-04,
 -0.531904442872E-04,
 -0.694895284168E-05,
  0.519144185050E-04,
 -0.135428102942E-04,
 -0.399750910128E-04,
  0.233947730901E-03,
 -0.299051760764E-05,
 -0.237366934446E-03);
 
 -- ca13_dat_130
constant ca13_type130:integer:=1;
constant ca13_inve130:integer:=2;
signal ca13_ord130:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal ca13_fak130:real_vector(1 to 4):=(0.34, 17.00, 0.00, 7674.73383881);
constant ca13_anz130:integer:=25;
signal ca13_data130:real_vector(1 to 25):=(
  0.906055984309    ,
 -0.763256627582E-02,
  0.275295345304E-01,
  0.135227308028E-01,
  0.601625946076E-01,
 -0.529155546783E-03,
 -0.272056369329E-02,
  0.616509790128E-02,
  0.462037202550E-02,
 -0.556174503409E-02,
  0.608986576889E-04,
  0.178162385380E-02,
  0.195143889781E-02,
  0.367017797020E-03,
 -0.993119538729E-02,
  0.545093647226E-03,
  0.223509975927E-02,
 -0.734397328733E-02,
 -0.300432627326E-02,
  0.758936494451E-02,
 -0.291247785585E-03,
 -0.152300265322E-02,
  0.208090984007E-02,
 -0.120020898659E-02,
  0.391620839635E-02);
  
-- ca23_dat_130
constant ca23_type130:integer:=1;
constant ca23_inve130:integer:=2;
signal ca23_ord130:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal ca23_fak130:real_vector(1 to 4):=(0.34, 17.00, 0.00, 126.601620003);
constant ca23_anz130:integer:=25;
signal ca23_data130:real_vector(1 to 25):=(
  0.769972181634    ,
 -0.264647171423    ,
 -0.529021172630E-01,
 -0.218102882100E-01,
 -0.692882459564E-02,
 -0.239366616260E-02,
  0.159513588480E-02,
  0.678491772383E-03,
  0.882329636684E-03,
  0.879611871583E-03,
 -0.135440991983E-03,
  0.290046441191E-03,
  0.993195168895E-03,
 -0.737253432443E-03,
 -0.121999942178E-02,
 -0.416840628206E-04,
  0.218797119593E-03,
  0.662844601242E-03,
 -0.624290709098E-03,
 -0.108736388327E-02,
  0.904975024917E-04,
 -0.429260670236E-03,
 -0.125724182103E-02,
  0.984258733515E-03,
  0.164390583121E-02);
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

signal sene_130:ret_type;
signal ca12_130:ret_type;
signal ca13_130:ret_type;
signal ca23_130:ret_type;


begin

p1:process
begin
  sene_130<= spoly_calc(q1,q2,0.0,s_type130,s_inve130,s_ord130,s_fak130,s_data130);
  ca12_130<= spoly_calc(q1,q2,0.0,ca12_type130,ca12_inve130,ca12_ord130,ca12_fak130,ca12_data130);
  ca13_130<= spoly_calc(q1,q2,0.0,ca13_type130,ca13_inve130,ca13_ord130,ca13_fak130,ca13_data130);
  ca23_130<= spoly_calc(q1,q2,0.0,ca23_type130,ca23_inve130,ca23_ord130,ca23_fak130,ca23_data130);
  wait for delay;
end process;

break on sene_130(2),sene_130(3),sene_130(4),ca12_130(2),ca12_130(3),ca12_130(4),ca13_130(2),ca13_130(3),ca13_130(4),ca23_130(2),ca23_130(3),ca23_130(4);

-- linear mechanical model 
--fm1==mm_1*q1'dot'dot + dm_1*q1'dot + km_1*q1;
--fm2==mm_2*q2'dot'dot + dm_2*q2'dot + km_2*q2;

fm1==mm_1*q1'dot'dot + dm_1*q1'dot +sene_130(2) -ca12_130(2)*(v1-v2)**2/2.0 -ca13_130(2)*(v1-v3)**2/2.0 -ca23_130(2)*(v2-v3)**2/2.0 +fi1_1*p1 +fi2_1*p2 -el1_1*el_load1 -el2_1*el_load2;
fm2==mm_2*q2'dot'dot + dm_2*q2'dot +sene_130(3) -ca12_130(3)*(v1-v2)**2/2.0 -ca13_130(3)*(v1-v3)**2/2.0 -ca23_130(3)*(v2-v3)**2/2.0 +fi1_2*p1 +fi2_2*p2 -el1_2*el_load1 -el2_2*el_load2;

r1==fi1_1*q1+fi1_2*q2-u1;
r2==fi2_1*q1+fi2_2*q2-u2;

f1==-p1;
f2==-p2;

i1==+((v1-v2)*(ca12_130(2)*q1'dot+ca12_130(3)*q2'dot)+(v1'dot-v2'dot)*ca12_130(1))+((v1-v3)*(ca13_130(2)*q1'dot+ca13_130(3)*q2'dot)+(v1'dot-v3'dot)*ca13_130(1));
i2==-((v1-v2)*(ca12_130(2)*q1'dot+ca12_130(3)*q2'dot)+(v1'dot-v2'dot)*ca12_130(1))+((v2-v3)*(ca23_130(2)*q1'dot+ca23_130(3)*q2'dot)+(v2'dot-v3'dot)*ca23_130(1));
i3==-((v1-v3)*(ca13_130(2)*q1'dot+ca13_130(3)*q2'dot)+(v1'dot-v3'dot)*ca13_130(1))-((v2-v3)*(ca23_130(2)*q1'dot+ca23_130(3)*q2'dot)+(v2'dot-v3'dot)*ca23_130(1));

end;

--===========================================================================--
--===========================================================================--