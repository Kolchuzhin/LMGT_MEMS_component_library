# LMGT_MEMS_component_library

![LMGT_MEMS_component_library](https://user-images.githubusercontent.com/5137813/171360740-111e0039-da23-4a5b-8a7e-c48c1bcd65e2.jpg)

## [LMGT/MMT](https://www.tu-chemnitz.de/etit/microsys/index.php) MEMS/NEMS component library in VHDL-AMS

| component                              | VHDL-AMS / hAMSter | Simulink |  TestBench   |                   description               |
|:---------------------------------------|:------------------:|:--------:|:------------:|:--------------------------------------------|
| Amperes_force_actuator                 |                    |          |              | _in progress_                               |
| [BAW_resonator](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/BAW_resonator) | - | | | [s2p file](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/BAW_resonator/BAW_resonator_1872.s2p) |
| [Spiegel](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/Spiegel) | [spiegel.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/Spiegel/spiegel.vhd) | | | analytical model of micromirror |
| afm_tip                                |                    |          |              | _in progress_                               |
| [clamped_beam](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/clamped_beam) | [cbeam.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/clamped_beam/hAMSter_model/cbeam.vhd) | | [hAMSter](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/clamped_beam/hAMSter_model/testbench.vhd) | generated by ANSYS ROM Tool |
| cylindrical_conductor_with_skin_effect | cyl_cond.vhd       |          |              | _in progress_                               |
| [electrostatically_actuated_membrane](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/electrostatically_actuated_membrane) | [ememb_160.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/electrostatically_actuated_membrane/ememb_160.vhd) | | [hAMSter](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/electrostatically_actuated_membrane/testbench.vhd) | generated by ANSYS ROM Tool |
| magnetometer                           |                    |          |              | _in progress_                               |
| [microelectromechanical_transducer](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/microelectromechanical_transducer) | [transducer.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/microelectromechanical_transducer/transducer.vhd) | |[SystemVision](https://explore.partquest.com/groups/vladimirs-workspace/designs/mems-transducer-static-pull) | analytical model |
| [miscellaneous*](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/miscellaneous) | | | | resistor, inductor, capacitor |
| [miscellaneous*](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/miscellaneous) | [Hall_sensor.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/miscellaneous/Hall_sensor.vhd) | | [SystemVision](https://explore.partquest.com/groups/vladimirs-workspace/designs/hall-sensor-testbench) | analytical model: HS-420 Hall sensor |
| [quartz](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/quartz) | [quartz.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/quartz/quartz.vhd) | | [SystemVision](https://explore.partquest.com/groups/vladimirs-workspace/designs/bvd-resonator) | equivalent RLC circuit (BDV), 2nd ODE, H(s) |
| resonator                              |                    |          |              | _in progress_                               |
| stopper                                |                    |          |              | _in progress_                               |
| [tensoresistor](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/tensoresistor) | [tensoresitor.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/tensoresistor/tensoresitor.vhd)   |          |              | analytical model of Me-tensoresistor        |
| [uniaxial_accelerometer](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/uniaxial_accelerometer) | [accelZa_02.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/tree/master/uniaxial_accelerometer) |  | [hAMSter](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/uniaxial_accelerometer/testbench_02.vhd) [SystemVision](https://explore.partquest.com/node/546488)| generated by ANSYS ROM Tool                 |
| tpu_accelerometer                      |                    |          |              | _in progress_                               |
| vibration_gyroscope                    |                    |          |              | _in progress_                               |
| vibration_sensor                       |                    |          |              | _in progress_                               |

## miscellaneous*

* resistor.vhd
* inductor.vhd
* capacitor.vhd
* v_dc.vhd
* vsrc_gaussian_pulse.vhd
* f_pulse.vhd


Originally the VHDL-AMS models were compiled with hAMSter simulator. The models generated by ANSYS ROM Tool are not compatible with SystemVision.

* [piezoresistance of SWCNT in VHDL-AMS](https://github.com/Kolchuzhin/piezoresistance_of_SWCNT_in_VHDL-AMS_part_I)

## ANSYS ROM Tool
* [micromirror_cell_in_VHDL-AMS](https://github.com/Kolchuzhin/micromirror_cell_in_VHDL-AMS)
* [clamped-clamped_beam_in_VHDL-AMS](https://github.com/Kolchuzhin/clamped-clamped_beam_in_VHDL-AMS)

![General layout of the ROM models for MEMS](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/MEMS_ROMs.svg)

## Reference
+ Guidelines for the Development of a VHDL-AMS Model Library. Version 2.0 
