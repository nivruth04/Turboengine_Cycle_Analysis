# Turbojet Engine Cycle Analysis

# Problem Statement:

To model a single spool turbojet engine cycle analysis using MATLAB and to produce the values of thrust, TSFC and various efficiencies. 

# Methodology:

The engine is modelled station by station, following the standard turbojet layout: diffuser, compressor, combustor, turbine, and nozzle. Each component is written as a separate function, and the main script calls them in sequence, passing the output of one stage as the input to the next.
The design point parameter values are matched to J85-GE-21's design values, and the output from the model is validated using the published values of the same. 

1. **Diffuser (∞ to 02):** Ram compression is calculated from the freestream Mach number using isentropic relations, giving the stagnation temperature and pressure entering the compressor.

2. **Compressor (02 to 03):** The pressure ratio is fixed at 8.3. The compressor is not treated as fully isentropic; a polytropic efficiency (pe_c = 0.9) is used to work out an effective isentropic efficiency, which then gives the actual exit temperature.

3. **Combustor (03 to 04):** The fuel-air ratio is found from an energy balance between the compressor exit and the fixed turbine inlet temperature of 1253 K, using a fuel calorific value of 43150 kJ/kg.

4. **Turbine (04 to 05):** The turbine is sized to supply exactly the work the compressor needs (single-shaft assumption), accounting for a mechanical efficiency of 0.97 between the two. A turbine isentropic efficiency of 0.9 is used to find the actual exit conditions from the ideal ones.

5. **Nozzle (05 to 06):** The nozzle is checked at every Mach number to see if it is choked, by comparing the pressure ratio across it to the critical pressure ratio. Depending on whether the flow is choked or not, the exit velocity is calculated differently.

6. **Performance:** Once the exit velocity and fuel-air ratio are known, thrust, TSFC, specific thrust, and the three efficiencies (propulsive, thermal, overall) are calculated for every Mach number in the sweep.

# Files:

* `diffuser.m`: Calculates T02, P02 from freestream conditions and Mach number.
* `compressor.m`: Calculates T03, P03 using the pressure ratio and polytropic efficiency.
* `combustor.m`: Calculates the fuel-air ratio f and fuel mass flow rate m_f from an energy balance.
* `turbine.m`: Calculates T05, P05, and turbine work, matched to the compressor's power requirement.
* `nozzle.m`: Checks for choked/unchoked flow and calculates exit velocity V_e, T06, P06.
* `performance.m`: Calculates thrust, TSFC, specific thrust, and the three efficiencies.
* `turbojet_main.m`: Sets all constants and operating conditions, calls the functions in order, and plots the results.

# Assumptions:

* Calorically perfect gas, with separate specific heats for the cold section (cp_a = 1.005 kJ/kgK, γ = 1.4) and hot section (cp_h = 1.156 kJ/kgK, γ_h = 1.33).
* Compressor and turbine efficiencies are polytropic, not simple isentropic efficiencies (pe_c = 0.9, pe_t = 0.87).
* Turbine isentropic efficiency is fixed separately at 0.9 inside `turbine.m`.
* Mechanical efficiency between the compressor and turbine shaft is 0.97.
* Single-spool turbojet, so all turbine work goes into driving the compressor and nothing else.
* Fuel calorific value fixed at 43150 kJ/kg.

# Operating Conditions Used:

| Parameter | Value |
|---|---|
| Freestream Mach number | 0 to 1.2 |
| Compressor pressure ratio(CPR) | 8.3 |
| Turbine entry temperature(TET) | 1253 K |
| Mass flow rate | 24 kg/s |
| Nozzle exit area | 0.214 m² |
| Ambient temperature | 300 K |
| Ambient pressure | 101.325 kPa |

# Results and Observations:

Running `turbojet_main.m` produces a figure with six subplots against Mach number:

1. Thrust (N)
2. TSFC (g/N/s)
3. Specific thrust (N/kg/s)
4. Propulsive efficiency (%)
5. Thermal efficiency (%)
6. Overall efficiency (%)

The dry thrust(in kN) and the TSFC(in g/N/s) calculated from the model turned out to be 14.227 and $3.4715 \times 10^{-5}$ respectively. 
The values were validated against the design point values of the J85-GE-21 turbojet engine at static condition ($Ma_{\infty}$), and the deviations of the model values were 16% and 6% for dry thrust and TSFC, respectively. 
The deviations are due to the idealized behaviour of the model, which neglects practical effects like air bleed for compressor cooling. 
<img width="1636" height="777" alt="image" src="https://github.com/user-attachments/assets/a6dd9c58-2297-4c76-8f26-14b367a1cc45" />
<img width="515" height="252" alt="Screenshot 2026-08-11 124716" src="https://github.com/user-attachments/assets/4d5edaac-8f3b-4b3f-9a20-58542b5907fe" />
