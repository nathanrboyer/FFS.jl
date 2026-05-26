@testset "Thread" begin

    @test RCSCCL3.Pm(1, 2, 3, 4, 5) == 5
    @test RCSCCL3.Pb(123123, 2, 2, 20/9, 15/6) == -4
    @test isapprox(RCSCCL3.U(0.25, 2.5), 1.269625, atol = 1e-4)
    @test isapprox(RCSCCL3.Σm(0, 0.48708932, 8.2995), 4.042598, atol = 1e-4)
    @test isapprox(RCSCCL3.Z(0.25, 1.74841), 0.48708932, atol = 1e-4)

    @test isapprox(RCSCCE1.U_1(0.25), 1.4635, atol = 1e-4)
    @test isapprox(RCSCCE1.U_2_20(0.25, 0.57195), 1.17604, atol = 1e-4)
    @test isapprox(RCSCCE1.A(0.25, 0.636153), 0.049795, atol = 1e-4)
    @test isapprox(RCSCCE1.α(1.57925, 6.317, 11.35024), 0.160613, atol = 1e-4)
    @test isapprox(RCSCCE1.ψ(0.049795, pi ^ 2 / 4), 1.539705, atol = 1e-4)
    @test isapprox(RCSCCE1.Z(
        1.539705, 0.25, pi ^ 2 / 4, 0.636153), 1.172956, atol = 1e-4)
    @test isapprox(RCSCCE1.σmc(60, 3.613, 6.317), 34.3169226, atol = 1e-4)
    @test isapprox(RCSCCE1.σml(
        0, 3.613, 9.93, 1698.157, 8.2995), 14.61783, atol = 1e-4)
    @test isapprox(RCSCCE1.Pmeq(34.3169226, 14.61783), 29.827725, atol = 1e-4)
    @test isapprox(RCSCCE1.σref(
        12.7777, 1.4635, 1.172956, 29.827725, 0.160613), 57.60369, atol = 1e-4)
        
end