export CO2Mass, O2Mass, N2Mass, AirMass, HeliumMass, MethaneMass, H2OMass,
       AirDensity, CO2Density, SteelDensity, NylonDensity, PolypropyleneDensity,
       AluminiumDensity, IceDensity, KevlarDensity, CarbonfibreCompositeDensity,
       MylarDensity, WaterDensity

# mass in kg of 1 mole of substance
const CO2Mass = 0.04401  # kg/mole
const O2Mass = 0.0320
const N2Mass = 0.02802
const AirMass = 0.0290  # Molecular weight of air. This must be artificial
const HeliumMass = 0.00402
const HydrogenMass = 0.00202
const MethaneMass = 0.016043
const H2OMass = 0.018016

const AirDensity = 1.205 # kg/m3
const CO2Density = 1.842 # kg/m3

const BiglowB330Space = 330.0 # m3, diameter 6.7, Length 13.7. 0.46m hull thickness
const BiglowB330Mass = 15000 # kg

const SteelDensity = 7800 # kg/m3
const NylonDensity = 1130
const PolypropyleneDensity = 900
const AluminiumDensity = 2700
const IceDensity = 970
const KevlarDensity = 1440
const CarbonfibreCompositeDensity = 1600 # Not sure if this is right. Check it
const MylarDensity = 1390                # Polyester film. Mylar is the DuPont trade name
const WaterDensity = 1000

# 1 micron is 1/1e6 meter. Micron is often used to describe thickness of polymer films
# used as envelope for airships

gas_mass_CO2(P, V, celsius::Celsius) = gas_mass(P, V, celsius, CO2mass)
gas_mass_N2(P, V, celsius::Celsius) = gas_mass(P, V, celsius, N2mass)
gas_mass_O2(P, V, celsius::Celsius) = gas_mass(P, V, celsius, O2mass)

earth_gas_mass(V, molecular_mass) = gas_mass(pascal(1), V, 20, molecular_mass)