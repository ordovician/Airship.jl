using Base.Test

# Tests
# R = 10.0
# mass = gas_mass(1.0, 1.0, 1.0, 1.0)
# V = gas_volume(moles(mass, 1), 1.0, 1.0)
# @test V == 1.0

mass = gas_mass(pascal(1), 1, Celsius(20), CO2Mass)
V = gas_volume(moles(mass, CO2Mass), Celsius(20), pascal(1))
@test V == 1.0
