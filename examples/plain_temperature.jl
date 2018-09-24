import Base: +, -, *, convert, promote_rule
export Temperature, Kelvin, Fahrenheit, Celsius

# Use this to use units more naturally: 
# import Airship: °C, °F, K

abstract type Temperature end

struct Celsius <: Temperature
    value::Float64
end

struct Kelvin <: Temperature
   value::Float64 
end

struct Fahrenheit <: Temperature
    value::Float64
end

const °C = Celsius(1)
const °F = Fahrenheit(1)
const  K = Kelvin(1)

# Handle converson and promotion of temperature 
promote_rule(::Type{Kelvin}, ::Type{Celsius})     = Kelvin
promote_rule(::Type{Fahrenheit}, ::Type{Celsius}) = Celsius
promote_rule(::Type{Fahrenheit}, ::Type{Kelvin})  = Kelvin

Kelvin(celsius::Celsius)        = Kelvin(celsius.value + 273.15)
Kelvin(fahrenheit::Fahrenheit)  = Kelvin(Celsius(fahrenheit))
Celsius(kelvin::Kelvin)         = Celsius(kelvin.value - 273.15)
Celsius(fahrenheit::Fahrenheit) = Celsius((fahrenheit.value - 32)*5/9)
Fahrenheit(celsius::Celsius)    = Fahrenheit(celsius.value*9/5 + 32) 
Fahrenheit(kelvin::Kelvin)      = Fahrenheit(Celius(kelvin))

+(x::Temperature, y::Temperature) = +(promote(x,y)...)
-(x::Temperature, y::Temperature) = -(promote(x,y)...)

+(x::Celsius, y::Celsius) = Celsius(x.value + y.value)
-(x::Celsius, y::Celsius) = Celsius(x.value - y.value)

+(x::Kelvin, y::Kelvin) = Kelvin(x.value + y.value)
-(x::Kelvin, y::Kelvin) = Kelvin(x.value - y.value)

+(x::Fahrenheit, y::Fahrenheit) = Fahrenheit(x.value + y.value)
-(x::Fahrenheit, y::Fahrenheit) = Fahrenheit(x.value - y.value)