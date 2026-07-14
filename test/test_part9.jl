@testset "Part 9" begin

    @test Part9.σ_f(10, 20) == 15
    @test Part9.Lpr_max(1, 2) == 0.5
    @test Part9.Kr_max(0) == 1
    @test isapprox(Part9.Kr_max(0.8), 0.8105591, atol = 1e-4)
    @test Part9.L_r(1, 2) == 0.5
    cvn = 30
    @test isapprox(Part9.J_1mm(cvn), 348.48738, atol = 1e-4)
    jcrit = 243.94116
    @test isapprox(Part9.K_mat(jcrit, 27.8, 0.3), 86.32652, atol = 1e-4)
    @test isapprox(Part9.Φ_0(1, 2), 0.7071067, atol = 1e-4)
    @test Part9.K_srj(2, 3) == 6
    @test Part9.X(2, 3, 4) == 1.5

end