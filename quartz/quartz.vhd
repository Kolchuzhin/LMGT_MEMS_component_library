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
--                      |             || C           |
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
		C_val:real);      		-- capacitance value 
	port (terminal e1,e2:electrical);	-- interface terminals
end entity quartz;
-------------------------------------------------------------------------------
architecture behav of quartz is
	terminal i1,i2: electrical;			-- internal terminals
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
C: 
	entity capacitor(basic)
	generic map(C_val)
	port map(e1,e2);

end architecture behav;
--=============================================================================
