@testset "Stress Intensity" begin

    a_c = [0.5, 1.2]
    @test WFMFSC.Q.(a_c) == KPSCE3.Q.(a_c)
    Q = 1.74975
    G0 = 0.5
    G1 = 0.7
    @test isapprox(WFMFSC.M_1(Q, G0, G1), 0.573990, atol = 1e-4)
    @test WFMFSC.M_2() == 3
    @test isapprox(WFMFSC.M_3(Q, G0, G1), -7.468608, atol = 1e-4)
    @test isapprox(WFMFSC.N_1(Q, G0, G1), -25.81242, atol = 1e-4)
    @test isapprox(WFMFSC.N_2(Q, G0, G1), 71.999771, atol = 1e-4)
    @test isapprox(WFMFSC.N_3(Q, G0, G1), -47.1873427, atol = 1e-4)
    x = 0.2
    a = 0.4
    @test isapprox(WFMFSC.h_90(
        x, a, 0.573990, 3, -7.468608), 0.4733647, atol = 1e-4)
    @test isapprox(WFMFSC.h_0(
        x, a, -25.81242, 71.99977, -47.18734), 5.2090165, atol = 1e-4)

end