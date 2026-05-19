module KPTC

end #end module KPTC, through wall crack

module RPTC
"""equation(9C.27) reference stress solution for Plate - Through-Wall Crack"""
σref(Pb, Pm, α) = (Pb + (Pb ^ 2 + 9 * Pm ^ 2) ^ 0.5) / (3 * (1 - α))

end #end module RPTC

module KPSCE3


end #end module KPSCE3

module RPSCE
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

"""9C.3.4.2(b) > equation(9C.4)"""
Pm(P0, P1, P2, P3, P4) = P0 + P1 / 2 + P2 / 3 + P3 / 4 + P4 / 5

"""9C.3.4.2(b) > equation(9C.5)"""
Pb(P1, P2, P3, P4) = - P1 / 2 - P2 / 2 - 9 * P3 / 20 - 6 * P4 / 15

end #end module RPSCE

#elliptical: KPSCE3, RPSCE
#infinite: KPSCL2, RPSCL2