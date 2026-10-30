# Analytical based model of an micro-electro-mechanical transducer:

![micro-electro-mechanical transducer](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/microelectromechanical_transducer/microelectromechanical_transducer.svg)

## parameters of micro-electomechanical transducers:

| generic parameter,  MKS unit           | set1     | set2              | set3            | set4            |
|:---------------------------------------|:--------:|:-----------------:|:---------------:|:---------------:|
| mass m, kg                             | 4.658e-7 |   1.0e-4          |  1.0            |  2e−16          |
| spring constant c, uN/um               | 270.4    |  200.0            |  1.46           |  2.0e4          |
| damping coefficient d, uNs/um          | 2.245e-3 |  40.0e-3          |  0.0            |  1.0e-8         |
| plate area A, m<sup>2</sup>            |  1.0e-6  |  (1.0e+8)*1.0e-12 | 50.0e-6x50.0e-6 |  1.0e-12        |
| initial gap h, m                       | 10.0e-6  |  150.0e-6         | 3.0e-6          |  1:=e-8         | 
|                                        |          |                   |                 |                 | 
| calculated parameter                   |          |                   |                 |                 | 
| resonance frequency f<sub>0</sub>, kHz |   3.835  |   0.225           |  0.192          |  1592           | 
| initial capacitance, pF                |   0.885  |   5.900           |  0.0074         |                 |
| pull-in voltage, V                     |  95.15   |  475.38           |  22.97          |  28.3           |


  + set#1
  + set#2: [Release 11.0 Documentation for ANSYS: 7.4. Sample Electromechanical-Circuit Analysis]
  + set#3: [Übung: Microsystem design: Analysis of electromechanical system by Prof. M. Naumann]
  + set#4: [Gigahertz MEMS Oscillator, E. G. Kostsov and A. A. Sokolov, OPTOELECTRONICS, INSTRUMENTATION AND DATA PROCESSING Vol. 55 No. 2 2019]

## Simulations
### 1. hAMSter simulator
  * model: [transducer.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/microelectromechanical_transducer/transducer.vhd)
  * testbench 

### 2. TestBench in SystemVision:

| test                        | link     | description |
|:----------------------------|:--------:|:-----------:|
| static pullin analysis      | [static pullin](https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-static-pull) |  |
|  harmonic analysis          | [harmonic analysis](https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-harmonic-analysis) |  |
| transient analysis          | [transient analysis](https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-transient-analysis) |  |
| mechanical excitation       | [mechanical excitation](https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-mechanical-excitation) |  |
| i/v-converter               | [i/v-converter](https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-i/v-converter) |  |
| self-sustained oscillations | [self-sustained oscillations](https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-self-sustained-oscillations) |  |

  https://explore.partquest.com/designs/kostsov-gigahertz-mems-oscillator-harmonic-analysis
