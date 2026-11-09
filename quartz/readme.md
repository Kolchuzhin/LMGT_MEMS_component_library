# Butterworth-Van Dyke (BVD) model

## parameters:

| generic parameter           | set1      | set2              | set3            |  set4           | 
|:----------------------------|:---------:|:-----------------:|:---------------:|:---------------:|
| Lm                          | 3127.11 H |   79.8 nH         |                 |   2.5 H         |
| Rm                          | 17 kOhm   |   2.77 Ohm        |                 |   640 Ohm       |
| Cm                          | 1.35 fF   |   82.5 fF         |                 |   0.01pF        |
| Cp                          | 1.25 pF   |   1.60 pF         |                 |   2.5 pF        |
|                             |           |                   |                 |                 |
| fs                          | 77460.74 Hz | 1.961515 GHz    |                 | 1.0065 MHz      |
| fp                          | 77502.56 Hz | 2.011450 GHz    |                 | 1.0085 MHz      |


  + set1: [Wolfgang Hilberg, Funkuhrtechnik, München 1988] für einen Quarz mit f = 77.5 kHz
  + set2: [Andreas Link, "Unterdrueckung von parasitaeren Moden in FBAR-Resonatoren", Dissertation, Universitaet Erlangen-Nuernberg, 2007] Die gegebenen Bauteilwerte sind typisch fuer das US-PCS-RX-Band mit AFBAR= (180μmxμm):
  + set3: Sakti, Setyawan. (2014). Quartz Crystal Resonator Parameter Calculation Based on Impedance Analyser Measurement Using GRG Nonlinear Solver. Natural A. 1. 82-89.
  + set4: 


## Simulations
### 1. hAMSter simulator
  * model: [quartz.vhd](https://github.com/Kolchuzhin/LMGT_MEMS_component_library/blob/master/quartz/quartz.vhd)
  * testbench 

### 2. TestBench in SystemVision:

| test                        | link     | description |
|:----------------------------|:--------:|:-----------:|
|  harmonic analysis          | [harmonic analysis](https://explore.partquest.com/designs/bvd-resonator) |  |




<!--

                           Lm       Rm        Cm 
                      e1        i1  ____   i2 ||   e2
                   *--o---^^^^--o--|____|--o--||---o--*
                      |                       ||   |
                      |             || Cp          |
                      o-------------||-------------o
                                    ||

            ASCII-Schematic of the Butterworth-Van Dyke (BVD) model             
-->
