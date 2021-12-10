# Analytical based model of an micro-electro-mechanical transducer

## 1) hAMSter simulator

* transducer.vhd
* testbench.vhd

## 2) TestBench in SystemVision:
  
    https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-static-pull
    https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-harmonic-analysis
    https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-transient-analysis
    https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-mechanical-excitation
    https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-i/v-converter  
    https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-self-sustained-oscillations

## 3) microelectomechanical transducer parameters:
### set1
  * constant m:real:=4.658e-7;	-- mass, kg
  * constant d:real:=2.245e-3;	-- damping coefficient, , Ns/m
  * constant c:real:=270.4;		  -- spring constant, N/m
  * constant A:real:=1.0e-6;	  -- plate area, m^2
  * constant h:real:=10.0e-6;	  -- initial gap, m
### set2
[Release 11.0 Documentation for ANSYS: 7.4. Sample Electromechanical-Circuit Analysis, MKS unit]
  * constant m:real:=1.0e-4;            -- mass, kg
  * constant d:real:=40.0e-3;				    -- damping coefficient, uNs/um
  * constant c:real:=200.0;				      -- spring constant, uN/um
  * constant A:real:=(1.0e+8)*1.0e-12;	-- plate area, m^2
  * constant h:real:=150.0e-6;			    -- initial gap, m
### set3
[Training Course on Microsystem design: Analysis of electromechanical system by Prof. M. Naumann, MKS unit]
  * constant m:real:=1.0 ?;	    		  -- mass, kg
  * constant d:real:=0.0;				      -- damping coefficient, Ns/m
  * constant c:real:=1.46;				    -- spring constant, N/m
  * constant A:real:=50.0e-6*50.0e-6;	-- plate area, m*m
  * constant h:real:=3.0e-6;			    -- initial gap, m
