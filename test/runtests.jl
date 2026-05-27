using FFS
using Test

@testset "FFS.jl" begin
    include("test_imports.jl")
    include("test_bore.jl")
    include("test_thread.jl")
    include("test_plate.jl")
    include("test_stress.jl")
    include("test_part9.jl")

    # Write your tests here.
end
