--*****************************************************************************
--*****************************************************************************
-- Model: clamped /one side fixed/ beam
--
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Date: 19.10.2011
--
-- VHDL-AMS generated code from ANSYS for hAMSter, uMKSV units 
-------------------------------------------------------------------------------
--
--                            Lagrangian ports
--
--                               p1        p2
--                   r_ext1 ->>- o         o -<<- r_ext2
--                               |         |
--         modal ports   o-------o---------o-------o     nodal ports
--                       |                         |
--                       |   o------------------o  | 
--  fm_ext1  ->>- q1 o---o  /|      cbeam       |  o---o u1 -<<- f_ext1
--                       |  /o------------------o  |
--  fm_ext2  ->>- q2 o---o                         o---o u2 -<<- f_ext2
--                       |   o------------------o  |
--                       |  ////////////////////   |
--                       o-------o---------o-------o
--                               |         |
--                               o         o
--                      input: v1_ext    v2_ext=0 (ground)
--                             
--                           electrical ports  
--
--               ASCII-Schematic of the MEMS-component: cbeam
------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------
-- Reference: Release 11.0 Documentation for ANSYS 
-- 8.5. Sample Miniature Clamped-Clamped Beam Analysis => Clamped Beam
--
-- Beam parameters
-- B_L=100  Beam length
-- B_W=20   Beam width
-- B_T=2    Beam thickness
-- E_G=4    Electrode gap
--
-- Material properties <110> Si
-- EX=169e3 MPa, Young's modulus
-- NUXY=0.066, Poisson's ratio
-- DENS=2.329e-15 kg/um/um/um, density
-- ALPX=1e-6

-- number of basis functions = 2; 2 modes: i=1 (Dominant mode), j=0(Dominant mode), k=2(Relevant mode)  
-- 2 conductors => 1 capacitance C12
-- 2 master nodes
--
-- Damping: modal quality factors, see below
--
-- Calculation of voltage displacement functions up to pull-in:
--   Linear analysis: 157 volts (stress stiffening is OFF)
--   Nonlinear analysis: 160 volts (stress stiffening is ON)
--
--
-- There are two element loads: acceleration and a uniform pressure load:
-- acel,,,9.81e12                ! acceleration in Z-direction 9.81e6 m/s**2
-- sf,all,pres,0.1               ! uniform 100 kPa pressure load
--
-- 
-- Modal analysis data and mode specifications:
--     # FREQUENCY   RELEVANCY	BOUND DISPL. SCALE   CONTRIBUTION,%
--     1 0.27544E+06 Dominant   3.3517       0.29836 95.271
--     2 0.17337E+07 Relevant   0.84607E-01 11.819   2.4049
--     3 0.26843E+07
--     4 0.30116E+07 Unused
--     5 0.48994E+07
--     6 0.92066E+07
--     7 0.97424E+07
--     8 0.14856E+08
--     9 0.15914E+08
-------------------------------------------------------------------------------
-- Euler solver:
-- time=50u; step=10n
-------------------------------------------------------------------------------
-- ID: cbeam.vhd
-- ver. 1.00 29.04.2019 cbeam.vhd
--*****************************************************************************
--*****************************************************************************
package Electromagnetic_system IS

    nature electrical is real across real through electrical_ground reference;
    nature translational is real across real through mechanical_ground reference;

end package Electromagnetic_system;

library ieee;
use ieee.math_real.all;
use work.electromagnetic_system.all;


entity cbeam is
  generic (delay:time; el_load1, el_load2:real);
  port (terminal struc1,struc2:translational;
        terminal lagrange1,lagrange2:translational;
        terminal master1,master2:translational;
        terminal elec1,elec2:electrical);
end;


architecture behav of cbeam is
  type ret_type is array(1 to 4) of real;

quantity q1 across fm1 through struc1;
quantity q2 across fm2 through struc2;
quantity p1 across r1 through lagrange1;
quantity p2 across r2 through lagrange2;
quantity u1 across f1 through master1;
quantity u2 across f2 through master2;
quantity v1 across i1 through elec1;
quantity v2 across i2 through elec2;
-------------------------------------------------------------------------------
-- model parameters from FE-simulations
constant mm_1:real:=  0.232818464746E-11;  -- modal mass for mode 1  []--o
constant mm_2:real:=  0.231854244007E-11;  -- modal mass for mode 2  []--o

constant f_1:real:=  0.27544E+06        ;  -- frequency mode 1  ***
constant f_2:real:=  0.17337E+07        ;  -- frequency mode 2  ***
-- eigenvector at master node 1
constant fi1_1:real:=  0.999999988058    ; -- eigenvector mode 1 at master node 1
constant fi1_2:real:=  0.999999776074    ; -- eigenvector mode 2 at master node 1
-- eigenvector at master node 2                       
constant fi2_1:real:=  0.339254165955    ; -- eigenvector mode 2 at master node 1
constant fi2_2:real:= -0.712900181001    ; -- eigenvector mode 2 at master node 2

-- acceleration in z-direction 9.8e6 m/s**2
constant el1_1:real:=  -35.7003234220    ;  -- element load 1 mode 1
constant el1_2:real:=   19.8834674929    ;  -- element load 1 mode 2
-- uniform 1 MPa pressure load 
constant el2_1:real:=   77.7939081502    ;  -- element load 2 mode 1
constant el2_2:real:=  -45.6034402711    ;  -- element load 2 mode 2
-------
constant Qm_1:real:=   10.0; -- quality factor for mode 1, user defined
constant Qm_2:real:=   10.0; -- quality factor for mode 2, user defined

constant km_1:real:=   mm_1*(2.0*3.14*f_1)**2; -- modal stiffness mode 1  o--^^^--o
constant km_2:real:=   mm_2*(2.0*3.14*f_2)**2; -- modal stiffness mode 2  o--^^^--o

constant dm_1:real:=SQRT(mm_1*km_1)/Qm_1*1.0; -- modal damping constant for mode 1 o--[|--o
constant dm_2:real:=SQRT(mm_2*km_2)/Qm_2*1.0; -- modal damping constant for mode 2 o--[|--o
-------------------------------------------------------------------------------
-- the strain energy function
constant s_type102:integer:=1;							-- type of fit function: Lagrange polynomial
constant s_inve102:integer:=1;							-- not inverted
signal s_ord102:real_vector(1 to 3):=(4.0, 4.0, 0.0);	-- order of polynomial
signal s_fak102:real_vector(1 to 4):=(0.298355752783,11.819,0.0,40.19036861); -- scaling factors
constant s_anz102:integer:=       25;    -- total number of coefficients
signal s_data102:real_vector(1 to 25):=  -- polynomial coefficients
(
  0.226452885625E-07, -- const
  0.502194834436E-14, -- Mode1
  0.974597248387    , -- Mode1^2
 -0.584354937591E-14, -- Mode1^3
  0.674835073746E-03, -- Mode1^4
  0.112014816202E-14, -- Mode2
 -0.132493195796E-06, -- Mode1   *Mode2
 -0.101086003850E-13, -- Mode1^2 *Mode2
  0.172646020973E-03, -- Mode1^3 *Mode2
  0.986580043093E-14, -- Mode1^4 *Mode2
  0.245012468704E-01, -- Mode2^2
 -0.381910747387E-13, -- Mode1   *Mode2^2
  0.530076496003E-04, -- Mode1^2 *Mode2^2 
  0.437150863736E-13, -- Mode1^3 *Mode2^2 
  0.118922308547E-06, -- Mode1^4 *Mode2^2 
 -0.122397026431E-14, -- Mode2^3
  0.235696025724E-05, -- Mode1   *Mode2^3
  0.109962124175E-13, -- Mode1^2 *Mode2^3
  0.307100846248E-08, -- Mode1^3 *Mode2^3
 -0.106950600932E-13, -- Mode1^4 *Mode2^3
  0.842283549353E-07, -- Mode2^4
  0.339296643681E-13, -- Mode1   *Mode2^4
  0.196771612043E-08, -- Mode1^2 *Mode2^4
 -0.388931868309E-13, -- Mode1^3 *Mode2^4
  0.956200475259E-08  -- Mode1^4 *Mode2^4
);
-------------------------------------------------------------------------------
--  the capacitance between conductor 1 and 2
constant ca12_type102:integer:=1;
constant ca12_inve102:integer:=2; -- inverted
signal ca12_ord102:real_vector(1 to 3):=(4.0, 4.0, 0.0);
signal ca12_fak102:real_vector(1 to 4):=(0.298355752783,11.819,0.0,221.195116364);
constant ca12_anz102:integer:=       25;
signal ca12_data102:real_vector(1 to 25):=
(
  0.786977915624    ,
  0.237757590542    ,
 -0.420162902857E-01,
  0.404716034822E-01,
 -0.284440944423E-01,
 -0.333290459426E-02,
 -0.102992669984E-02,
 -0.944894840532E-04,
 -0.458951893598E-02,
  0.460316501145E-02,
 -0.413549361113E-04,
 -0.167284022813E-05,
 -0.253538631204E-03,
  0.473015846241E-03,
 -0.158699467701E-03,
 -0.213429653791E-04,
 -0.203875298546E-03,
  0.391792780289E-03,
  0.575196252076E-03,
 -0.781830603931E-03,
 -0.291343226820E-04,
 -0.363789188765E-04,
  0.319432802011E-03,
 -0.110700000779E-03,
 -0.185819256550E-03
);
-------------------------------------------------------------------------------
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

     if s_type=1 then	 -- type Lagrange polynomial
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
-------------------------------------------------------------------------------

signal sene_102:ret_type;
signal ca12_102:ret_type;


begin

p1:process
begin
  sene_102<= spoly_calc(q1,q2,0.0,s_type102,s_inve102,s_ord102,s_fak102,s_data102);
  ca12_102<= spoly_calc(q1,q2,0.0,ca12_type102,ca12_inve102,ca12_ord102,ca12_fak102,ca12_data102);
  wait for delay;
end process;

break on sene_102(2),sene_102(3),sene_102(4),ca12_102(2),ca12_102(3),ca12_102(4);

-- linear mechanical model:  km_i=const
--fm1==mm_1*q1'dot'dot + dm_1*q1'dot + km_1*q1 -ca12_102(2)*(v1-v2)**2/2.0 +fi1_1*p1 +fi2_1*p2 -el1_1*el_load1 -el2_1*el_load2;
--fm2==mm_2*q2'dot'dot + dm_2*q2'dot + km_2*q2 -ca12_102(3)*(v1-v2)**2/2.0 +fi1_2*p1 +fi2_2*p2 -el1_2*el_load1 -el2_2*el_load2;
-- non-linear mechanical model:
fm1==mm_1*q1'dot'dot + dm_1*q1'dot + sene_102(2) -ca12_102(2)*(v1-v2)**2/2.0 +fi1_1*p1 +fi2_1*p2 -el1_1*el_load1 -el2_1*el_load2;
fm2==mm_2*q2'dot'dot + dm_2*q2'dot + sene_102(3) -ca12_102(3)*(v1-v2)**2/2.0 +fi1_2*p1 +fi2_2*p2 -el1_2*el_load1 -el2_2*el_load2;
r1==fi1_1*q1+fi1_2*q2-u1;
r2==fi2_1*q1+fi2_2*q2-u2;
f1==-p1;
f2==-p2;
i1==+((v1-v2)*(ca12_102(2)*q1'dot+ca12_102(3)*q2'dot)+(v1'dot-v2'dot)*ca12_102(1));
i2==-((v1-v2)*(ca12_102(2)*q1'dot+ca12_102(3)*q2'dot)+(v1'dot-v2'dot)*ca12_102(1));

end;
-------------------------------------------------------------------------------
