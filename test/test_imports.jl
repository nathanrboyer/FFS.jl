@testset "Imports" begin
    ffs_tables = load_ffs_tables()

    @test ffs_tables.Fref[:Fref_internal](1, 0.6) == 1.442
    @test ffs_tables.Fref[:Fref_internal](2.5, 0.2) == 0.759
    @test isapprox(ffs_tables.Fref[:Fref_internal](1.1, 0.2), 1.1112, atol = 1e-4)
    @test ffs_tables.Fref[:Fref_external](1, 0.6) == 1.796
    @test ffs_tables.Fref[:Fref_external](2.5, 0.2) == 0.941
    @test isapprox(ffs_tables.Fref[:Fref_external](1.1, 0.2), 1.343, atol = 1e-4)
    @test ffs_tables.Fref[:Fref_internal](4, 0.9) == 2.103 #clamp value
    @test typeof(ffs_tables.Fref[:Fref_internal](1, 0.6)) == Float64
    
    @test interp_3d_coeffs(ffs_tables.G12, 0.1,1, 0.2)[:G0_A0] == 1.2047909
    @test interp_3d_coeffs(ffs_tables.G12, 2.5, 0.25, 0.6)[:G1_A2] == 2.436167
    @test isapprox(interp_3d_coeffs(ffs_tables.G12, 0.5, 1, 0.4)[:G0_A3], -11.8988, atol = 1e-4)
    @test interp_3d_coeffs(ffs_tables.G12, 0.2, 0.5, 0.9)[:G0_A2] == 4.415758
    @test typeof(interp_3d_coeffs(ffs_tables.G12, 0.15, 1.1, 0.24)[:G0_A0]) == Float64

    @test interp_3d_coeffs(ffs_tables.G13, 0, 0.5, 0.8)[:G0_A4] == -2.54032

    @test ffs_tables.G2_F2[:G1].C2 == -0.71895

    @test ffs_tables.G11[:G0_in](0.025, 0.4) == 1.800221
    @test isapprox(ffs_tables.G11[:G4_out](0.6666, 0.1), 0.38527, atol = 1e-4) #double interp

    @test ffs_tables.ξ(1.1, 0.2) == 0.93
    @test isapprox(ffs_tables.ξ(1.25, 1.5), 0.5595, atol = 1e-4)
end