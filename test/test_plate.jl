@testset "Plate" begin
    x = 0.2
    a = 0.4 # x/a = 0.5
    a_c = 0.6666
    c = 0.6
    t = 8 # a/t = 0.05

    @test isapprox(KPSCE3.A0(a, c), 0.35931, atol = 1e-4)
    @test isapprox(KPSCE3.A1(a, c), 0.38601, atol = 1e-4)
    @test isapprox(KPSCE3.A2(a, c), -0.41703, atol = 1e-4)
    @test isapprox(KPSCE3.B0(a, c), 1.06929, atol = 1e-4)
    @test isapprox(KPSCE3.B1(a, c), 0.480883, atol = 1e-4)
    @test isapprox(KPSCE3.B2(a, c), -0.34824, atol = 1e-4)
    @test isapprox(KPSCE3.Y0(
        1.06929, 0.480883, -0.34824, a, t), 1.07049, atol = 1e-4)
    @test isapprox(KPSCE3.Y1(
        0.35931, 0.38601, -0.41703, a, t), 0.360272, atol = 1e-4)

    @test isapprox(KPSCE3.Q(a_c), 1.74975, atol = 1e-4)
    @test isapprox(KPSCE3.M1(1.74975, 1.07049, 0.360272), -1.23918, atol = 1e-4)
    @test KPSCE3.M2() == 3
    @test isapprox(KPSCE3.M3(1.74975, 1.07049, -1.23918), -1.926138, atol = 1e-4)
    
#=     @test KPSCE3.h90(x, a, M1, M2, M3) == 1

    @test isapprox(1, 1, atol = 1e-4) =#

        
end