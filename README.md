# Spatial Modulation with Euclidean Distance-Based Selection Combining  

This project presents a performance analysis of Spatial Modulation (SM) with Euclidean Distance-based Selection Combining (ED-SC). The study involves theoretical derivation and simulation of BER for MIMO systems using MATLAB and Mathematica.

---

## Project Summary

This work focuses on evaluating the Bit Error Rate (BER) of Spatial Modulation (SM) systems using a novel Selection Combining (SC) approach based on Euclidean Distance (ED-SC). It includes analytical modeling, MATLAB simulation, and symbolic computation using Mathematica for validation.

---

## Key Features

- **Spatial Modulation (SM) in MATLAB**  
  Developed a flexible SM system supporting configurable transmit (Nt) and receive (Nr) antennas, and modulation schemes like BPSK and QPSK.

- **Selection Combining (SC) with 1 Active Antenna**  
  Implemented SC strategy where a single receive antenna is selected based on the minimum Euclidean distance metric.

- **Euclidean Distance-Based SC (ED-SC) in Mathematica**  
  Derived and implemented ED-SC technique symbolically for the case of \( N_t = 2 \), \( N_r = 2 \). Includes analytical BER expressions and numerical evaluation.

- **Simulation and Theoretical Validation**  
  BER plots from MATLAB simulations closely match theoretical curves derived in Mathematica.

---



## Important Notes

- The MATLAB file `spatialmodulation.m` includes the base SM simulation setup and SNR sweep.
- The MATLAB code for SM with **Selection Combining** and the extended **ED-SC simulation** is **not included** in this repository.
- The **Mathematica notebook** `2x2_theoretical.nb` contains symbolic derivations and analytical BER for ED-SC with \( N_t = 2 \), \( N_r = 2 \).

If you're interested in accessing the full SC/ED-SC MATLAB code or in collaboration, please contact the author directly.

---

## How to Run

1. Open `spatialmodulation.m` in MATLAB.
2. Adjust system parameters (Nt, Nr, modulation order, SNR range) if needed.
3. Run the simulation to generate BER plots for SM.
4. Open `2x2_theoretical.nb` in Mathematica to view symbolic derivation and theoretical BER results.

---

## Tools Used

- **MATLAB** – For simulation of SM and BER analysis
- **Mathematica** – For symbolic derivation and evaluation of ED-SC performance

---

## Contact

To request access to full simulation code for SM-EDSC :

Email: laahiriadusumilli157@gmail.com 

---

## Acknowledgments

This project was completed as part of the Honors Program at Indian Institute of Information Technology Kottayam, under the guidance of Dr. Ananth A. Special thanks for support in mathematical derivation and simulation design.


