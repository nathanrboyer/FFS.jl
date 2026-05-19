module KPTC

end #end module KPTC, through wall crack

module RPTC
"""equation(9C.27) reference stress solution for Plate - Through-Wall Crack"""
σref(Pb, Pm, α) = (Pb + (Pb ^ 2 + 9 * Pm ^ 2) ^ 0.5) / (3 * (1 - α))

end #end module RPTC

module KPSCE3

"""equation (9B.49), weight equation at φ=π/2 or infinitely long crack"""
h90(x, a, M1, M2, M3) = (
    (2 / (2 * π * (a - x)) ^ 0.5) *
    (1 + M1 * (1 - x / a) ^ 0.5 + M2 * (1 - x / a) + M3 * (1 - x / a) ^ 1.5)
)

"""equation(9B.15) for a/c≤1, equation(9B.16) for a/c>1,
parameter for stress intensity factor"""
function Q(a_c)
    if a_c ≤ 1
        return 1 + 1.464 * a_c ^ 1.65
    else
        return 1 + 1.464 * (1 / a_c) ^ 1.65
    end
end

"""equation (9B.50), weight function coefficient at φ=π/2"""
M1(Q, Y0, Y1) = (π / (2 * Q) ^ 0.5) * (4 * Y0 - 6 * Y1) - 24 / 5

"""equation (9B.51), weight function coefficient at φ=π/2"""
M2() = 3

"""equation (9B.52), weight function coefficient at φ=π/2"""
M3(Q, Y0, M1) = 2 * ((π / (2 * Q) ^ 0.5) * Y0 - M1 - 4)

"""equation (9B.53), factor for stress intensity"""
Y0(B0, B1, B2, a, t) = B0 + B1 * (a / t) ^ 2 + B2 * (a / t) ^ 4

"""equation (9B.54), factor for stress intensity"""
B0(a, c) = 1.10190 - 0.019863 * (a / c) - 0.43588 * (a / c) ^ 2

"""equation (9B.55), factor for stress intensity"""
B1(a, c) = 4.32489 - 14.9372 * (a / c) + 19.4389 * (a / c) ^ 2 - 8.52318 * (a / c) ^ 3

"""equation (9B.56), factor for stress intensity"""
B2(a, c) = -3.03329 + 9.96083 * (a / c) - 12.582 * (a / c) ^ 2 + 5.52318 * (a / c) ^ 3

"""equation (9B.57), factor for stress intensity"""
Y1(A0, A1, A2, a, t) = A0 + A1 * (a / t) ^ 2 + A2 * (a / t) ^ 4

"""equation (9B.58), factor for stress intensity"""
A0(a, c) = 0.456128 - 0.114206 * (a / c) - 0.046523 * (a / c) ^ 2

"""equation (9B.59), factor for stress intensity"""
A1(a, c) = 3.022 - 10.8679 * (a / c) + 14.94 * (a / c) ^ 2 - 6.8537 * (a / c) ^ 3

"""equation (9B.60), factor for stress intensity"""
A2(a, c) = -2.28655 + 7.88771 * (a / c) - 11.0675 * (a / c) ^ 2 + 5.16354 * (a / c) ^ 3

"""equation (9B.61), weight equation at φ=0, surface point of crack"""
h0(x, a, N1, N2, N3) = (
    (2 / (π * x) ^ 0.5) *
    (1 + N1 * (x / a) ^ 0.5 + N2 * (x / a) + N3 * (x / a) ^ 1.5)
)

"""equation (9B.62), weight function coefficient at φ=0""" 
N1(Q, F0, F1) = (π / (4 * Q) ^ 0.5) * (30 * F1 - 18 * F0) - 8

"""equation (9B.63), weight function coefficient at φ=0"""
N2(Q, F0, F1) = (π / (4 * Q) ^ 0.5) * (60 * F0 - 90 * F1) + 15

"""equation (9B.64), weight function coefficient at φ=0"""
N3(N1, N2) = -(1 + N1 + N2)

"""equation (9B.65), weight function coefficient at φ=0"""
F0(α, a, c, β) = α * (a / c) ^ β

"""equation (9B.66), weight function coefficient at φ=0"""
α(a, t) = 1.14326 + 0.0175996 * (a / t) + 0.501001 * (a / t) ^ 2

"""equation (9B.67), weight function coefficient at φ=0"""
β(a, t) = 0.458320 - 0.102985 * (a / t) - 0.398175 * (a / t) ^2

"""equation (9B.68), weight function coefficient at φ=0"""
F1(γ, a, c, δ) = γ * (a / c) ^ δ

"""equation (9B.69), weight function coefficient at φ=0"""
γ(a, t) = 0.976770 - 0.131975 * (a / t) - 0.484875 * (a / t) ^ 2

"""equation (9B.70), weight function coefficient at φ=0"""
δ(a, t) = 0.448863 -0.173295 * (a / t) -0.267775 * (a / t) ^ 2

end #end module KPSCE3

module RPSCE #Elliptical
"""equation(9C.31) reference stress solution for Plate - Semi-Ellipitical - Pin Jointed"""
σref(Pb, Pm, α) = (Pb + 3 * Pm * α + ((Pb + 3 * Pm * α) ^ 2 + 9 * Pm ^ 2 * (1 - α) ^ 2) ^ 0.5) /
(3 * (1 - α) ^ 2)

"""equation(9C.33)/(9C.34) reference stress parameter"""
function α(W, a, t, c) 
    if W ≥ (c + t)
        return (a / t) / (1 + t / c)
    else
        return (a / t) * (c / W)
    end
end

"""9C.3.4.2(b) > equation(9C.4) membrane stress"""
Pm(P0, P1, P2, P3, P4) = P0 + P1 / 2 + P2 / 3 + P3 / 4 + P4 / 5

"""9C.3.4.2(b) > equation(9C.5) bending stress"""
Pb(P0, P1, P2, P3, P4) = - P1 / 2 - P2 / 2 - 9 * P3 / 20 - 6 * P4 / 15

end #end module RPSCE

module RPSCL #Infinite
"""9C.3.3 > equation(9C.29) reference stress parameter"""
α(a, t) = a / t

"""equation(9C.31) reference stress solution for Plate - Pin Jointed - repurposed as infinite"""
σref(Pb, Pm, α) = (Pb + 3 * Pm * α + ((Pb + 3 * Pm * α) ^ 2 + 9 * Pm ^ 2 * (1 - α) ^ 2) ^ 0.5) /
(3 * (1 - α) ^ 2)

"""9C.3.2.2(b) > equation(9C.4) membrane stress"""
Pm(P0, P1, P2, P3, P4) = P0 + P1 / 2 + P2 / 3 + P3 / 4 + P4 / 5

"""9C.3.2.2(b) > equation(9C.5) bending stress"""
Pb(P0, P1, P2, P3, P4) = - P1 / 2 - P2 / 2 - 9 * P3 / 20 - 6 * P4 / 15

end #end module RPSCL

#elliptical: KPSCE3, RPSCE
#infinite: KPSCL2, RPSCL2