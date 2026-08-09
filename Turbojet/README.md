# Turbojet Engine Cycle Analysis

# Problem Statement:

A turbojet engine operating at a compressor pressure ratio of 11 and a turbine inlet temperature of 1400 K is analysed across a range of flight Mach numbers from 0.1 to 1.2. The mass flow rate is fixed at 80 kg/s, and the nozzle exit area at 0.214 m². The objective is to determine how thrust, TSFC, specific thrust, and the propulsive, thermal, and overall efficiencies of the engine vary with flight speed.

# Methodology:

The engine is modelled station by station, following the standard turbojet layout: diffuser, compressor, combustor, turbine, and nozzle. Each component is written as a separate function, and the main script calls them in sequence, passing the output of one stage as the input to the next.

1. **Diffuser (∞ to 02):** Ram compression is calculated from the freestream Mach number using isentropic relations, giving the stagnation temperature and pressure entering the compressor.

2. **Compressor (02 to 03):** The pressure ratio is fixed at 11. The compressor is not treated as fully isentropic; a polytropic efficiency (pe_c = 0.9) is used to work out an effective isentropic efficiency, which then gives the actual exit temperature.

3. **Combustor (03 to 04):** The fuel-air ratio is found from an energy balance between the compressor exit and the fixed turbine inlet temperature of 1400 K, using a fuel calorific value of 43150 kJ/kg.

4. **Turbine (04 to 05):** The turbine is sized to supply exactly the work the compressor needs (single-shaft assumption), accounting for a mechanical efficiency of 0.97 between the two. A turbine isentropic efficiency of 0.9 is used to find the actual exit conditions from the ideal ones.

5. **Nozzle (05 to 06):** The nozzle is checked at every Mach number to see if it is choked, by comparing the pressure ratio across it to the critical pressure ratio (with a 5% margin). Depending on whether the flow is choked or not, the exit velocity is calculated differently.

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
| Freestream Mach number | 0.1 to 1.2 (swept, 100 points) |
| Compressor pressure ratio | 11 |
| Turbine inlet temperature | 1400 K |
| Mass flow rate | 80 kg/s |
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

<img width="1667" height="797" alt="image" src="https://github.com/user-attachments/assets/b07fb097-898c-44c4-b668-8dc6c18cfd03" />
