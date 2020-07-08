------------------------------------------------------------------------------------------------------------------------
-- Model Title: Hall sensor
-- Entity Name: hall_sensor
-- Author: <vladimir.kolchuzhin@ieee.org>
-- Created: 
-- Last update: 2020/07/08 Schaeftlarn
-- 
------------------------------------------------------------------------------------------------------------------------
-- Description: small signal model of Hall sensor: Vh == Binput*Rh*Ic/d
-- simulated with systemvision.com
--
-- SMD HS-420 Datasheet:
-- Magnetic sensitivity: VH=100…330 mV/kG at Ic=5mA  => -(2...6.6) mV/T/mA
-- input resistance: Rin=240...550 Ohm
-- output resistance: Rout=240...550 Ohm
-- control current: Ic max=20 mA / Ic nom=5 mA
-- operating temperature range: -40...110 degC
-- meaning of temperature coefficient of resistance (0...40 degC): -1.8
-- meaning of temperature coefficient of VH (0...40 degC): -1.8
--
-- Indium Antimonide:
-- Rh= -7.2e-4 m3/C; d=0.4 mm => Magnetic sensitivity: VH=Rh*Ic/d= -1.8 mV/T/mA
--
------------------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.electrical_systems.all;
use IEEE.energy_systems.all;

entity hall_sensor is
  
  generic (key : real := 1.0); -- key  [no units]
  
  port (quantity Binput: in  real;
        terminal e_ic1, e_ic2: electrical;
        terminal e_vh1, e_vh2: electrical);

end entity hall_sensor;

architecture basic of hall_sensor is

  quantity vc across ic through e_ic1 to e_ic2;
  quantity vh across ih through e_vh1 to e_vh2;
  -------
-- model parameters
constant Rin:real:=  400.0;	-- input resistance: Rin, Ohm
constant Rh:real:=  -7.2e-4; -- Indium Antimonide Rh
constant d:real:=  0.4e-3;	-- thickness, d
 
begin		
  vc == Rin*ic;
  vh == Binput*Rh*ic/d;
  
  --- for information only
  --VH == Rh*ic/d; -- magnetic sensitivity

end architecture basic;
