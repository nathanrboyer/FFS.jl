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
