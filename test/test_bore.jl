@testset "Bore" begin

    @test RCSCLE3.P_b_internal(100) == 50
    @test RCSCLE3.P_m(2, 3, 4) == 1.5
    @test isapprox(RCSCLE3.g(0.5, 0.75, 0.00385), 0.9999995, atol = 1e-8)
    @test isapprox(RCSCLE3.α(0.5, 9.5, 0.75), 0.00385, atol = 1e-4)
    @test isapprox(RCSCLE3.λ_a(0.75, 3, 0.5), 1.11329, atol = 1e-4)
    @test isapprox(RCSCLE3.M_t(1.11329), 1.23537, atol = 1e-4)
    @test isapprox(RCSCLE3.M_s(0.05263, 1.23537), 1.010129, atol = 1e-4)
    @test isapprox(RCSCLE3.σ_ref(
        0.9999995, 50, 1.010129, 31.5789, 0.00385), 52.8461, atol = 1e-4)
end