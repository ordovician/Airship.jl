import Airship: °C, °F, K

@testset "Temperature tests" begin
    @testset "Zero tests" begin
        @test 0K + 0K == 0K
        @test 0°C + 0°C == 0°C
        @test 0°F + 0°F == 0°F
        @test Kelvin(Celsius(0)) == Kelvin(273.15)
        @test Celsius(Kelvin(0)) == Celsius(-273.15)
        @test Celsius(Fahrenheit(32)) == Celsius(0)
        @test 0K + 0°C == 273.15K
        @test 32°F + 0°C == 0°C
    end
    
    @testset "Hundred tests" begin
        @test 100°F + 0°C ≈ 37.77777777777778°C
        @test Fahrenheit(Celsius(100)) == Fahrenheit(212.0)
    end
    
end