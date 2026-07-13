@testset "Plate" begin
    x = 0.2
    a = 0.4 # x/a = 0.5
    a_c = 0.6666
    c = 0.6
    t = 8 # a/t = 0.05

    @test isapprox(KPSCE3.A_0(a, c), 0.35931, atol = 1e-4)
    @test isapprox(KPSCE3.A_1(a, c), 0.38601, atol = 1e-4)
    @test isapprox(KPSCE3.A_2(a, c), -0.41703, atol = 1e-4)
    @test isapprox(KPSCE3.B_0(a, c), 1.06929, atol = 1e-4)
    @test isapprox(KPSCE3.B_1(a, c), 0.480883, atol = 1e-4)
    @test isapprox(KPSCE3.B_2(a, c), -0.34824, atol = 1e-4)
    @test isapprox(KPSCE3.Y_0(
        1.06929, 0.480883, -0.34824, a, t), 1.07049, atol = 1e-4)
    @test isapprox(KPSCE3.Y_1(
        0.35931, 0.38601, -0.41703, a, t), 0.360272, atol = 1e-4)

    @test isapprox(KPSCE3.Q(a_c), 1.74975, atol = 1e-4)
    @test isapprox(KPSCE3.M_1(1.74975, 1.07049, 0.360272), -1.23918, atol = 1e-4)
    @test KPSCE3.M_2() == 3
    @test isapprox(KPSCE3.M_3(1.74975, 1.07049, -1.23918), -1.926138, atol = 1e-4)
    
     @test isapprox(KPSCE3.h_90(x, a, -1.23918, 3, -1.926138), 1.682027, atol = 1e-4)
            
end