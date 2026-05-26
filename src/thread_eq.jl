module RCSCCE1

"""9C.5.8 equation(9C.87) reference stress"""
σref(Pb, U, Z, Pmeq, α) = (Pb + (Pb ^ 2 + 9 * (U * Z * Pmeq * (1 - α) ^ 2) ^ 2) ^ 0.5) /
(3 * (1 - α) ^ 2)

"""equation(9C.88) longitudinal membrane stress"""
σml(p, Ri, Ro, F, Pm) = (p * Ri ^ 2) / (Ro ^ 2 - Ri ^ 2) + F /
(π * (Ro ^ 2 - Ri ^ 2)) + Pm

"""equation(9C.89) circumferential membrane stress"""
σmc(p, Ri, t) = (p * Ri) / t 

"""equation(9C.90) primary membrane stress component based on equivalent stress"""
Pmeq(σmc, σml) = (((σmc - σml) ^ 2 + σmc ^ 2 + σml ^ 2) / 2) ^ 0.5

"""equation(9C.91) reference stress parameter"""
Z(ψ, x, θ, τ) = ((2 * ψ) / π - (x * θ) / π * ((2 - 2 * τ + x * τ) / (2 - τ))) ^ -1

"""equation(9C.92) reference stress parameter"""
ψ(A, θ) = acos(A * sin(θ))

"""equation(9C.93) reference stress parameter"""
α(a, t, c) = (a / t) / (1 + t / c)

"""equation(9C.94) cross-sectional area of the flaw"""
A(x, τ) = x * (((1 - τ) * (2 - 2 * τ + x * τ) + (1 - τ + x * τ)^ 2) /
(2 * (1 + (2 - τ) * (1 - τ))))

"""equation(9C.95) reference stress parameter"""
τ(t, Ro) = t / Ro

"""equation(9C.96) radial local coordinate originating at the internal 
surface of the component or a reference stress parameter"""
x(a, t) = a / t

"""equation(9C.97) half-angle of the crack, for an internal crack"""
θ_in(c, Ri) = (π * c) / (4 * Ri)

"""equation(9C.98) half-angle of the crack, for an external crack"""
θ_ex(c, Ro) = (π * c) / (4 * Ro)

"""equation(9C.99) reference stress parameter for circumferential cracks
to account for pressure loading"""
U_2_20(a_t, Ri_t) = 1.3068 - 0.495 * a_t + (0.055 * a_t - 0.026) * Ri_t

"""equation(9C.100) reference stress parameter for circumferential cracks
to account for pressure loading"""
U_1(a_t) = 1.601 - 0.55 * a_t

end #end module RCSCCE1


module RCSCCL3  #Reference Stress
#Cylinder, Surface Crack, Circumferential Direction, 360⁰
#Through-Wall Arbitrary Stress Distribution

"""9C.5.8 equation(9C.77) reference stress"""
σref(Pb, U, Σm, α) = (Pb + (Pb ^ 2 + 9 * (U * Σm * (1 - α) ^ 2) ^ 2) ^ 0.5) /
(3 * (1 - α) ^ 2)

"""9C.5.8.2(b) > equation(9C.4)"""
Pm(P0, P1, P2, P3, P4) = P0 + P1 / 2 + P2 / 3 + P3 / 4 + P4 / 5

"""9C.5.8.2(b) > equation(9C.5)"""
Pb(P0, P1, P2, P3, P4) = - P1 / 2 - P2 / 2 - 9 * P3 / 20 - 6 * P4 / 15

"""equation(9C.84) for 2 ≤ Ri/t ≤ 20 , reference stress parameter for circumferential 
cracks to account for pressure loading"""
U(a_t, Ri_t) = 1.3807 - 0.2978 * a_t + (0.003 * a_t - 0.0154) * Ri_t

"""equation(9C.78) membrane stress based on equivalent stress"""
Σm(σmc, Z, Pm) = (((σmc - Z * Pm) ^ 2 + σmc ^ 2 + (Z * Pm) ^ 2) / 2) ^ 0.5

"""equation(9C.79) reference stress parameter"""
Z(α, τ) = (1 - α * ((2 - 2 * τ + α * τ) / (2 - τ))) ^ -1

"""equation(9C.80) reference stress parameter"""
τ(t, Ro) = t / Ro

"""equation(9C.81) reference stress parameter"""
α(a, t) = a / t

"""equation(9C.82) circumferential membrane stress, with internal pressure"""
σmc_in(p, Ri, t) = p * Ri / t

"""equation(9C.83) longitudinal membrane stress, not internal pressure"""
σmc_ex() = 0

"""equation(9C.) """


end #end module RCSCCL3
