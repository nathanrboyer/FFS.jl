module KPTC

end #end module KPTC

module RPTC
"""equation(9C.27) reference stress solution for Plate - Through-Wall Crack"""
σref(Pb, Pm, α) = (Pb + (Pb ^ 2 + 9 * Pm ^ 2) ^ 0.5) / (3 * (1 - α))

end #end module RPTC