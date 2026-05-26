using FFS
using Test

@testset "FFS.jl" begin
    include("test_imports.jl")
    include("test_bore.jl")
    include("test_thread.jl")
    include("test_plate.jl")


    # Write your tests here.
end
