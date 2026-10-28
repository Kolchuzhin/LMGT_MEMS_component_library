# Analytical based model of an micro-electro-mechanical transducer:

![micro-electro-mechanical transducer](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/microelectromechanical_transducer/microelectromechanical_transducer.svg)

## parameters of micro-electomechanical transducers:

| parameter,  MKS unit                   | set1     | set2              | set3            |
|:---------------------------------------|:--------:|:-----------------:|:---------------:|
| mass m, kg                             | 4.658e-7 |   1.0e-4          |                 |
| spring constant c, uN/um               | 2.245e-3 |  40.0e-3          |                 |
| damping coefficient d, uNs/um          | 270.4    |  200.0            |  1.46           |
| plate area A, m^2                      |  1.0e-6  |  (1.0e+8)*1.0e-12 | 50.0e-6*50.0e-6 |
| initial gap h, m                       | 10.0e-6  |  150.0e-6         | 3.0e-6          |

  + set#1
  + set#2: [Release 11.0 Documentation for ANSYS: 7.4. Sample Electromechanical-Circuit Analysis]
  + set#3: [Übung: Microsystem design: Analysis of electromechanical system by Prof. M. Naumann]

## Simulations
### 1. hAMSter simulator
### 2. TestBench in SystemVision:
  
  * https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-static-pull
  * https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-harmonic-analysis
  * https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-transient-analysis
  * https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-mechanical-excitation
  * https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-i/v-converter  
  * https://www.systemvision.com/groups/vladimirs-workspace/designs/mems-transducer-self-sustained-oscillations



