module KCSCCL3 #Stress Intensity
#Cylinder, Surface Crack, Circumferential Direction, 360⁰
#Through-Wall Arbitrary Stress Distribution

end #end module KCSCCL3

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
