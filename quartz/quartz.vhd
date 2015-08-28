--=============================================================================
-- Model: macromodel of the quartz based on an equivalent RLC circuit
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@etit.tu-chemnitz.de>
-- Date: 30.11.2011
-------------------------------------------------------------------------------
-- Library: kvl in hAMSter
--
-- ID: quartz.vhd
--
-- Rev. 1.00 24.08.2015 GitHub
-------------------------------------------------------------------------------
-- [Hrsg. Wolfgang Hilberg, Funkuhrtechnik, München 1988]
-- für einen Quarz mit f = 77.5 kHz gelten etwa folgende Werte:
-- Lm = 3127.11 H
-- Rm = 17 kOhm
-- Cm = 1.35 fF
-- C  = 1.25 pF
-------------------------------------------------------------------------------
--
--                           Lm       Rm        Cm 
--                      e1        i1  ____   i2 ||   e2
--                   <--o---^^^^--o--|____|--o--||---o-->
--                      |                       ||   |
--                      |             || Cp          |
--			o-------------||-------------o
--                                    ||
--
-- ASCII-Schematic of the quartz  
--=============================================================================
use work.electromagnetic_system.all;
use work.all;

library ieee;
-------------------------------------------------------------------------------
entity quartz is
	generic (
		Rm_val:real;         		-- resistance value
		Lm_val:real;         		-- inductance value
		Cm_val:real;			-- capacitance value
		Cp_val:real);      		-- capacitance value 
	port (terminal e1,e2:electrical);	-- interface terminals
end entity quartz;
-------------------------------------------------------------------------------
architecture behav_subcircuit of quartz is	-- subcircuit
	terminal i1,i2: electrical;		-- internal terminals
begin

Lm: 
	entity inductor(basic)
	generic map(Lm_val)
	port map(e1,i1);
Rm: 
	entity resistor(basic)
	generic map(Rm_val)
	port map(i1,i2);
Cm: 
	entity capacitor(basic)
	generic map(Cm_val)
	port map(i2,e2);
Cp: 
	entity capacitor(basic)
	generic map(Cp_val)
	port map(e1,e2);

end architecture behav_subcircuit;
-------------------------------------------------------------------------------
architecture behav_ode of quartz is		-- series RLC by 2nd ODE

	quantity v across i through e1 to e2;

begin

	v == i'dot'dot + Rm_val/Lm_val*i'dot + 1.0/Lm_val/Cm_val*i;

end architecture behav_ode;
-------------------------------------------------------------------------------
architecture behav_Hs of quartz is		-- series RLC by H(s)

	quantity v across i through e1 to e2;

	constant   numerator: real_vector(1 to 3):=(0.0, 1.0, 0.0);		-- a0 a1 a2
	constant denomerator: real_vector(1 to 3):=(1.0/Cm_val,Rm_val,Lm_val);	-- b0 b1 b2

begin

	i == v'LTF(numerator,denomerator);

end architecture behav_Hs;
--=============================================================================
--=============================================================================
