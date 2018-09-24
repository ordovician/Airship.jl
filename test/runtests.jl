using Airship
using Test

@testset "All Tests" begin

include("temperature_tests.jl")
include("gaslaw_tests.jl")

end
