## analytical model of a micro-electro-mechanical transducer/fixed-fixed beam resonator with five electrodes

### VHDL-AMS code

[transducer_e5.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/resonator/transducer_e5/transducer_e5.vhd)

### Parameters

*  constant L:real:=300.0;                     -- Length, um
*  constant H:real:= 30.0;                     -- Height, um
*  constant B:real:=  2.0;                     -- thickness, um
*  constant g:real:=  2.0;                     -- initial air gap, um
*  constant f0:real:=195063.0;                 -- eigenfrequency, Hz
*  constant Q:real:=10.0;                      -- Quality factor
*  constant A:real:=L*H;                       -- beam area, um^2
*  constant m:real:=A*B*rho;                   -- mass, kg
*  constant c:real:=m*((2.0*3.141593*f0)**2);  -- spring constant: c=m*((2*PI*f0)**2), uN/um 
*  constant d:real:=SQRT(m*c)/Q;               -- damping ratio/damping coefficient: SQRT(m*k)/q, uNs/um
*  constant Ae:real:=(L-4.0)/2.0*H;            -- electrode area, um^2
  
### TestBench in partquest

https://explore.partquest.com/groups/vladimirs-workspace/designs/transducer-e5-model-static-pull
