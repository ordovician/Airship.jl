# Grams of  weight for one mole of substance
CO2mass = 44.01
O2mass = 32.0
N2mass = 28.02
AirMass = 29.0  # Molecular weight of air. This must be artificial
Helium = 4.02
Methane = 16.043
H2Omass = 18.016

AirDensity = 1.205 # kg/m3
CO2Density = 1.842 # kg/m3

BiglowB330Space = 330.0 # m3, diameter 6.7, Length 13.7. 0.46m hull thickness
BiglowB330Mass = 15000 # kg
# density of air (1.29kg/m3)
# 1290g/m3
# density of CO2 1.98 kg/m3
# 1980g/m3
# density of Steel
# 7800 kg/m3
# density of nylon 1130
# density of polypropylene 900
# density of aluminum 2700
# Ice 970
# Kevlar 1440. tensile strength of 3620 MPa
# Density of water 1000. Relative density is density relative to water.

gas_mass_CO2(P, V, celsius::Celsius) = gas_mass(P, V, celsius, CO2mass)
gas_mass_N2(P, V, celsius::Celsius) = gas_mass(P, V, celsius, N2mass)
gas_mass_O2(P, V, celsius::Celsius) = gas_mass(P, V, celsius, O2mass)

earth_gas_mass(V, molecular_mass) = gas_mass(pascal(1), V, 20, molecular_mass)