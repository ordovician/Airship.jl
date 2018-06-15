export oblate_spheroid_lift_earth, prolate_spheroid_lift_earth

import Volume

function lift(V, lift_gas_mass, displaced_gas_mas)
    T = Celsius(20)
    P = pascal(1)
    gas_mass(P, V, T, displaced_gas_mas) - gas_mass(P, V, T, lift_gas_mass)
end

"""
Calcuate how many kg an airship with oblate spheroid can lift on earth 
if it has semi-minor axis `a`, semi-major axis `b` with an envelope of given
`thickness` and `density`. Example:

    oblate_spheroid_lift_earth(10/2, 150/2, 0.0015, MylarDensity)

Givens lift of airship with diameter 150 m, height 10 m encased in a mylar envelope
1.5 mm thick.
"""
function oblate_spheroid_lift_earth(a, c, thickness, density, liftgas = HeliumMass)
    V = Volume.ellipsoid_volume(a, a, c)
    A = Volume.oblate_spheroid_area(a, c)
    l = lift(V, liftgas, AirMass)
    l -  A*thickness*density
end

function prolate_spheroid_lift_earth(a, c, thickness, density, liftgas = HydrogenMass)
    V = Volume.ellipsoid_volume(a, a, c)
    A = Volume.prolate_spheroid_area(a, c)
    l = lift(V, liftgas, AirMass)
    l -  A*thickness*density
end