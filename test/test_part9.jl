@testset "Part 9" begin

    @test Part9.σf(10, 20) == 15
    @test Part9.max_lpr(1, 2) == 0.5
    @test Part9.max_kr(0) == 1
    @test isapprox(Part9.max_kr(0.8), 0.8105591, atol = 1e-4)
    @test Part9.lpr(1, 2) == 0.5
    cvn = 30
    @test isapprox(Part9.J1mm(cvn), 348.48738, atol = 1e-4)
    jcrit = 243.94116
    @test isapprox(Part9.Kmat(jcrit, 27.8, 0.3), 86.32652, atol = 1e-4)
    @test isapprox(Part9.Φ0(1, 2), 0.7071067, atol = 1e-4)
    @test Part9.Ksrj(2, 3) == 6
    @test Part9.X(2, 3, 4) == 1.5

end