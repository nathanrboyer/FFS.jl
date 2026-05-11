module KCSCLE3 #Stress Intensity
#Cylinder, Surface Crack, Longitudinal Direction, Semi-Elliptical Shape
#Through-Wall Arbitrary Stress Distribution

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


end #end module KCSCLE3

module RCSCLE3 #Reference Stress
#Cylinder, Surface Crack, Longitudinal Direction, Semi-Elliptical Shape
#Through-Wall Arbitrary Stress Distribution

"""9C.5.10.2(b) - equation(9C.49), Bending Stress, for internal crack in bore"""
Pb_internal(p) = p / 2

"""9C.5.10.2(b) - equation(9C.50), Bending Stress, for external crack in bore"""
Pb_external(p) = -p / 2

"""9C.5.10.2(b) - equation(9C.48), Membrane Stress, for internal and external cracks in bores with
internal pressure, uses support OD"""
Pm(p, Ri, t) = p * Ri / t 

"""equation(9c.86) crack depth parameter, unique to inner shell with support"""
α(a, t, c) =  (a / t) / (1 + t / c)

"""equation(9C.32), reference stress parameter, 9C.5.10.1 eq(9C.85) requires α be defined in
eq(9C.86)"""
g(a, c, α) = 1 - (20 * (a / (2 * c)) ^0.75) * α ^3

"""equation(9C.19) shell parameter"""
λa(c, Ri, a) = 1.818 * c / ((Ri * a) ^ 0.5)

"""equation(9C.8) correction factor, 9C.2.3.3 λa substitution"""
Mt(λa) = ((1.02 + 0.4411 * λa ^ 2 + 0.006124 * λa ^ 4) /
    (1.0 + 0.02642 * λa ^ 2.0 + 1.533 * 10 ^ -6 * λa ^ 4)) ^ 0.5

"""equation(9C.18) surface correction factor"""
Ms(a_t, Mt) = 1.0 / (1 - a_t + a_t / Mt)

"""equation(9C.85) Reference Stress"""
σref(g, Pb, Ms, Pm, α) = (g * Pb + ( (g * Pb) ^ 2 +
9 *(Ms * Pm * (1 - α) ^ 2) ^ 2) ^ 0.5 ) / (3 * (1 - α) ^ 2)

end #end module RCSCLE3
