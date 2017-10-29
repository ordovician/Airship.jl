import Base: +, -, *, convert, promote_rule

abstract type Temperature end

types = [:Celsius, :Kelvin, :Fahrenheit]
for T in types
  @eval begin
    immutable $T <: Temperature
        value::Float64
    end

    +(x::$T, y::$T) = $T(x.value + y.value)
    -(x::$T, y::$T) = $T(x.value - y.value)
    *(x::Number, y::$T) = $T(x*y.value)
  end
end

for T in types, S in types
    if S != T
       @eval $T(temp::$S) = convert($T, temp) 
    end
end

const °C = Celsius(1)
const °F = Fahrenheit(1)
const °K = Kelvin(1)

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

+(x::Temperature, y::Temperature) = +(promote(x,y)...)
-(x::Temperature, y::Temperature) = -(promote(x,y)...)