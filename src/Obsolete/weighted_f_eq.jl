module WFMFSC #Stress Intensity - Weighted Function Method For Surface Cracks
#Through-Wall Arbitrary Stress Distribution
#valid for cylindrical ellipitical(mid bore), and circumfrential 360°(thread root)

"""equation(9B.15) for a/c≤1, equation(9B.16) for a/c>1,
parameter for stress intensity factor"""
function Q(a_c)
    if a_c ≤ 1
        return 1 + 1.464 * a_c ^ 1.65
    else
        return 1 + 1.464 * (1 / a_c) ^ 1.65
    end
end

"""equation (9B.267), weight function coefficient at φ=π/2"""
M1(Q, G0, G1) = (2 * π / (2 * Q) ^ 0.5) * (3 * G1 - G0) - 24 / 5

"""equation (9B.268), weight function coefficient at φ=π/2"""
M2() = 3

"""equation (9B.269), weight function coefficient at φ=π/2"""
M3(Q, G0, G1) = (6  * π  / (2 * Q) ^ 0.5) * (G0 - 2 * G1) + 8 / 5

"""equation (9B.270), weight function coefficient at φ=0"""
N1(Q, G0, G1) = (3 * π / Q ^ 0.5) * (2 * G0 - 5 * G1) - 8

"""equation (9B.271), weight function coefficient at φ=0"""
N2(Q, G0, G1) = (15 * π / Q ^ 0.5) * (3 * G1 - G0) + 15

"""equation (9B.272), weight function coefficient at φ=0"""
N3(Q, G0, G1) = (3 * π / Q ^ 0.5) * (3 * G0 - 10 * G1) - 8

"""equation (9B.262), weight equation at φ=π/2 or infinitely long crack"""
h90(x, a, M1, M2, M3) = (
    (2 / (2 * π * (a - x)) ^ 0.5) *
    (1 + M1 * (1 - x / a) ^ 0.5 + M2 * (1 - x / a) + M3 * (1 - x / a) ^ 1.5)
)

"""equation (9B.263), weight equation at φ=0, surface point of crack"""
h0(x, a, N1, N2, N3) = (
    (2 / (π * x) ^ 0.5) *
    (1 + N1 * (x / a) ^ 0.5 + N2 * (x / a) + N3 * (x / a) ^ 1.5)
)


end #end module ArbitraryStress