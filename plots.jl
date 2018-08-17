include("Airship.jl")

using Airship
using Volume

# using Gadfly

const colors = ["red", "orange", "yellow", "green", "cyan", "blue", "purple"]
const materials = [MylarDensity, CarbonfibreCompositeDensity, AluminiumDensity, SteelDensity]

# Get some sense of size
# Boing 747 is
#  length: 70.66 m
#  wingpsan width: 64.44 m
#  body width: 11.0 m

# Bendy Semi Truck. Longest and heaviest ones.
# length: 25 m
# weight: 60 ton

# Hindenburg
#  length: 245m
#  diameter: 41.2 m

# Goodyear Wingfoot One
# length: 75.1m
# width: 14.16 m

# Falon 9
# Length (w/ Interstage)	47.7 m
#  Diameter	3.7 m
#  Empty Mass	25,600 kg
#  Propellant Mass	395,700 kg

# Saturn 5
#   length: 110.6 m
#   diameter: 10.1 m

"Will copy matrix `M` to clipboard in a format which can be pasted into Apple Numbers"
function export_table(M)
    io = IOBuffer()
    writecsv(io, M)
    s = String(take!(io))
    clipboard(s)
end

function generate_airship_calculation_for_numbers()
    len = linspace(100, 400, 10)  # Lengths of airship where
    height = len/3               # Make it disc shaped by having the height 1/3

    envelope_thickness = 0.0015  # in meters

    M = copy(len)

    for (i, m) in enumerate(materials)
        lifts = oblate_spheroid_lift.(height/2, len/2, envelope_thickness, m)
        M = hcat(M, lifts/1000)
    end
    export_table(M)
end

function earth_vs_venus_lifts()
    len = linspace(200, 800, 10)  # Lengths of airship where
    height = len/3               # Make it disc shaped by having the height 1/3

    envelope_thickness = 0.0015  # in meters

    a = height/2
    c = len/2

    function lift(liftgas, atmosphere)
        oblate_spheroid_lift.(a, c,
                              envelope_thickness,
                              MylarDensity,
                              liftgas,
                              atmosphere) / 1e6
    end

    earth_lift = lift(H2Mass, AirMass)
    methane    = lift(MethaneMass, CO2Mass)
    ammonia    = lift(AmmoniaMass, CO2Mass)
    oxygen     = lift(O2Mass, CO2Mass)
    nitrogen   = lift(N2Mass, CO2Mass)
    air        = lift(AirMass, CO2Mass)
    silane     = lift(SilaneMass, CO2Mass)
    
    M = hcat(len, earth_lift, methane, ammonia, oxygen, nitrogen)
    export_table(M)

    export_table(hcat(len, earth_lift, methane, ammonia))
    export_table(hcat(len, earth_lift, oxygen, nitrogen))
    export_table(hcat(len, earth_lift, ammonia, nitrogen))

    export_table(hcat(len, earth_lift, air))
    export_table(hcat(len, earth_lift, methane))
    export_table(hcat(len, earth_lift, ammonia))
    export_table(hcat(len, earth_lift, nitrogen))
    export_table(hcat(len, earth_lift, oxygen))

    export_table(hcat(len, earth_lift, methane, oxygen))
    
    export_table(hcat(len, earth_lift, nitrogen, ammonia))
    
    export_table(hcat(len, earth_lift, methane, silane))
end

function earth_vs_venus_sphere_lifts()
    diameter = linspace(600, 1400, 10)  # Lengths of airship where

    envelope_thickness = 0.0015  # in meters

    radius = diameter/2

    earth_lift = sphere_lift.(radius, envelope_thickness, MylarDensity, H2Mass, AirMass) / 1e3
    venus_lift = sphere_lift.(radius, envelope_thickness, MylarDensity, AirMass, CO2Mass) / 1e3

    M = hcat(diameter, earth_lift, venus_lift)

    export_table(M)
end

function compare_area_volume_growth()
    len = linspace(100, 400, 10)  # Lengths of airship where
    height = len/3               # Make it disc shaped by having the height 1/3

    c = len/2
    a = height/2

    V = ellipsoid_volume.(a, a, c)
    A = oblate_spheroid_area.(a, c)
    M = hcat(len, V, A)
    export_table(M)
end

function compare_proportional_enveloped_thickness_growth()
    thickness = 1:12
    len = thickness*15
    height = thickness*5

    c = len/2
    a = height/2

    V  = ellipsoid_volume.(a, a, c)
    A  = oblate_spheroid_area.(a, c)
    Ve = A .* thickness

    M = hcat(thickness, V, Ve)
    export_table(M)
end

#generate_airship_calculation_for_numbers()
#
# for (i, m) in enumerate(materials)
#     lifts = oblate_spheroid_lift.(height, len, 0.0015, m)
#
#     push!(layers, layer(x = len*2, y = lifts/1000, Geom.line, Theme(default_color = colors[i])))
# end
#
# layers = Array{Layer}[]
#
# for (i, m) in enumerate(materials)
#     lifts = oblate_spheroid_lift.(height, len, 0.0015, m)
#     push!(layers, layer(x = len*2, y = lifts/1000, Geom.line, Theme(default_color = colors[i])))
# end
#
# plot(layers...,
#      Scale.y_log,
#      Guide.xlabel("Length (m)"),
#      Guide.ylabel("Lift (tons)"),
#      Guide.title("Airship Lift at Different Sizes"))
