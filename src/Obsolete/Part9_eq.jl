module Part9 #General equations for Part 9 - Assessment of crack like flaws

"""equation(2E.9) flow stress"""
σf(σys, σuts) = (σys + σuts) / 2 

"""figure 9.19 Note 2(e); load ratio limit"""
max_lpr(σf, σys) = σf / σys

"""equation(9.22) Toughness limit for FAD"""
max_kr(Lpr) = (1 - 0.14 * Lpr ^ 2) * (0.3 + 0.7 * exp(-0.65 * Lpr ^ 6))

"""equation (9C.25), Load ratio for crack across a/t values"""
lpr(σref, σys) = σref / σys

"""equation (9F.89) J1mm 5% lower bound to calculate fracture toughness (in-lbs/in2)"""
J1mm(CVN) = 4.482 * CVN ^ 1.28

"""equation (9F.90) Fracture Toughness (ksi√in) for upper shelf Charpy"""
Kmat(Jcrit, Et, ν) = ((Jcrit * (Et * 1e6)) / (1 - ν ^ 2)) ^ 0.5 / 1000

"""equation (9.12) plasticity interaction factor"""
Φ0(aeff, a) = (aeff / a) ^ 0.5

"""equation (9.14) effective crack depth due to plasticity, in plane stress conditions"""
aeff(a, Ksri, σys) = a + (1 / (2 * pi)) * (Ksri / σys) ^ 2

"""equation (9.15) residual stresses corrected for plasticity effects"""
Ksrj(Φ0, Ksri) = Φ0 * Ksri

"""equation (9.16) effective crack depth due to plasticity, in plane stress conditions"""
X(Ksrj, Lpr, Kpi) = Ksrj * (Lpr / Kpi)


end #end module Part9