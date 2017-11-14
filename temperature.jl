import Base: +, -, *, convert, promote_rule
export Temperature, Kelvin, Fahrenheit, Celsius

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

# Handle converson and promotion of temperature 
convert(::Type{Kelvin},  celsius::Celsius)        = Kelvin(celsius.value + 273.15)
convert(::Type{Kelvin},  fahrenheit::Fahrenheit)  = Kelvin(Celsius(fahrenheit))
convert(::Type{Celsius}, kelvin::Kelvin)          = Celsius(kelvin.value - 273.15)
convert(::Type{Celsius}, fahrenheit::Fahrenheit)  = Celsius((fahrenheit.value - 32)*5/9)
convert(::Type{Fahrenheit}, celsius::Celsius)     = Fahrenheit(celsius.value*9/5 + 32)
convert(::Type{Fahrenheit}, kelvin::Kelvin)       = Fahrenheit(Celius(kelvin))

promote_rule(::Type{Kelvin}, ::Type{Celsius})     = Kelvin
promote_rule(::Type{Fahrenheit}, ::Type{Celsius}) = Celsius
promote_rule(::Type{Fahrenheit}, ::Type{Kelvin})  = Kelvin

Kelvin(celsius::Celsius) = convert(Kelvin, celsius)
Celsius(kelvin::Kelvin)  = convert(Celsius, kelvin)
Celsius(fahrenheit::Fahrenheit)  = convert(Celsius, fahrenheit)
Fahrenheit(celsius::Celsius) = convert(Fahrenheit, celsius) 

+(x::Temperature, y::Temperature) = +(promote(x,y)...)
-(x::Temperature, y::Temperature) = -(promote(x,y)...)

+(x::Celsius, y::Celsius) = Celsius(x.value + y.value)
-(x::Celsius, y::Celsius) = Celsius(x.value - y.value)

+(x::Kelvin, y::Kelvin) = Kelvin(x.value + y.value)
-(x::Kelvin, y::Kelvin) = Kelvin(x.value - y.value)

+(x::Fahrenheit, y::Fahrenheit) = Fahrenheit(x.value + y.value)
-(x::Fahrenheit, y::Fahrenheit) = Fahrenheit(x.value - y.value)