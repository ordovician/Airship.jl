import Base.+, Base.-, Base.*, Base.convert
export R, gas_volume, moles, gas_moles, gas_mass, pascal, bar

struct GasConstant
    value::Float64
end

*(t::Kelvin, c::GasConstant) = t.value * c.value
*(c::GasConstant, t::Kelvin) = t.value * c.value
*(c::GasConstant, v::Real) = GasConstant(c.value * v)
*(v::Real, c::GasConstant) = GasConstant(c.value * v)

# Ideal gas law: PV = nRT
const avogadro = 6.022140857e23

# Gas Constant. Botlzman times Avogadro
const R = GasConstant(8.3144598)

"Find volume of gas given `n` moles of substance at temperature `T` kelvin at pressure `P`"
gas_volume(n::Real, T::Kelvin, P::Real) = n*R*T/P
gas_volume(n, T::Temperature, P::Real) = gas_volume(n, convert(Kelvin, T), P)

moles(totalmass::Real, molecular::Real) = totalmass/molecular

"Find number of moles of a gas with pressure `P`, Volume `V` and `T` kelvin in temperature."
gas_moles(P::Real, V::Real, T::Kelvin) = (P*V)/(R*T)
gas_moles(P, V, T::Temperature) = gas_moles(P, V, convert(Kelvin, T))

"""
Mass in grams of a gass of volume `V` temperature `celsius`, pressure `P` and mass
of each molecule of gass is `molecular_mass`
"""
gas_mass(P::Real, V::Real, T::Kelvin, molecular_mass::Real) = gas_moles(P, V, T) * molecular_mass
gas_mass(P::Real, V::Real, T::Temperature, molecular_mass::Real) = gas_mass(P, V, convert(Kelvin, T), molecular_mass)

pascal(bar::Real) = bar*1e5
bar(pascal::Real) = pascal/1e5
