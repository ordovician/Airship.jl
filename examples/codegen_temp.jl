import Base: +, -, *, convert, promote_rule, show

abstract type Temperature end
abstract type DeltaTemperature end

types = [:Celsius, :Kelvin, :Fahrenheit]
for T in types
    ΔT = Symbol(:Delta, T)
    
    @eval begin
        struct $T <: Temperature
            value::Float64
        end

        struct $ΔT <: DeltaTemperature
            value::Float64
        end

        +(x::$ΔT, y::$ΔT) = $ΔT(x.value + y.value)
        +(x::$T, y::$ΔT)  = $T(x.value + y.value)
        +(x::$ΔT, y::$T)  = y + x 
        -(x::$ΔT, y::$ΔT) = $ΔT(x.value - y.value)
        -(x::$T, y::$ΔT)  = $T(x.value - y.value)
        -(x::$T, y::$T)   = $ΔT(x.value - y.value)    
        *(x::Number, y::$ΔT) = $ΔT(x*y.value)
        *(x::Number, y::$T)  = $T(x*y.value)
    
        delta_typeof(t::$T) = $ΔT
    end
end

for T in types, S in types
    if S != T
       @eval $T(temp::$S) = convert($T, temp) 
    end
end

const °C = Celsius(1)
const °F = Fahrenheit(1)
const K = Kelvin(1)

const Δ°C = DeltaCelsius(1)
const Δ°F = DeltaFahrenheit(1)
const ΔK = DeltaKelvin(1)

# Handle converson and promotion of temperature 
convert(::Type{Kelvin},  celsius::Celsius)        = Kelvin(celsius.value + 273.15)
convert(::Type{Kelvin},  fahrenheit::Fahrenheit)  = Kelvin((fahrenheit.value + 459.67) * 5/9)
convert(::Type{Celsius}, kelvin::Kelvin)          = Celsius(kelvin.value - 273.15)
convert(::Type{Fahrenheit}, kelvin::Kelvin)       = Fahrenheit(kelvin.value * 9/5 - 459.67)
convert(::Type{T}, temp::Temperature) where T <: Temperature = convert(T, convert(Kelvin, temp))

convert(::Type{DeltaKelvin},  celsius::DeltaCelsius)        = DeltaKelvin(celsius.value)
convert(::Type{DeltaKelvin},  fahrenheit::DeltaFahrenheit)  = DeltaKelvin(fahrenheit.value * 5/9)
convert(::Type{DeltaCelsius}, kelvin::DeltaKelvin)          = DeltaCelsius(kelvin.value)
convert(::Type{DeltaFahrenheit}, kelvin::DeltaKelvin)       = DeltaFahrenheit(kelvin.value * 9/5)
convert(::Type{ΔT}, Δtemp::DeltaTemperature) where ΔT <: DeltaTemperature = convert(ΔT, convert(DeltaKelvin, Δtemp))

promote_rule(::Type{Kelvin}, ::Type{Celsius})     = Kelvin
promote_rule(::Type{Fahrenheit}, ::Type{Celsius}) = Celsius
promote_rule(::Type{Fahrenheit}, ::Type{Kelvin})  = Kelvin

promote_rule(::Type{DeltaKelvin}, ::Type{DeltaCelsius})  = DeltaKelvin
promote_rule(::Type{DeltaFahrenheit}, ::Type{DeltaCelsius}) = DeltaCelsius
promote_rule(::Type{DeltaFahrenheit}, ::Type{DeltaKelvin})  = DeltaKelvin

+(x::Temperature, y::DeltaTemperature) = x + convert(delta_typeof(x), y)
+(x::DeltaTemperature, y::DeltaTemperature) = +(promote(x,y)...)
+(x::DeltaTemperature, y::Temperature) = y + x

-(x::Temperature, y::Temperature) = -(promote(x,y)...)
-(x::Temperature, y::DeltaTemperature) = x - convert(delta_typeof(x), y)
-(x::DeltaTemperature, y::DeltaTemperature) = -(promote(x,y)...)

show(io::IO, t::Celsius)    = print(io, t.value, "°C")
show(io::IO, t::Fahrenheit) = print(io, t.value, "°F")
show(io::IO, t::Kelvin)     = print(io, t.value, "K")
    
show(io::IO, t::DeltaCelsius)    = print(io, t.value, "Δ°C")
show(io::IO, t::DeltaFahrenheit) = print(io, t.value, "Δ°F")
show(io::IO, t::DeltaKelvin)     = print(io, t.value, "ΔK")