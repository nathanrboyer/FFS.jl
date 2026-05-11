#= using XLSX
using DataFrames
using Interpolations =#

"""Load FFS-1 2021 tables for fracture calculations"""
function load_ffs_tables()
        
    xi_9_3 = load_table_9_3() #plasticity table
    #interp_xi_9_3(xi9_3, 0.2, 3)

    #coefficents for high t/Ri ratio for circumferential-radial cracks at threads
    Fref_9C_3 = load_table_2d(
        raw"P:\Users\Maxwell\Fracture_Calc development\FFS-1_2021_Tables.xlsx",
        sheet = "Table 9C.3 Fref",
        x1=:t_Ri,
        x2=:a_t,
        values=[:Fref_internal, :Fref_external]
    )
    #interp_Fref = interp_2d(Fref_9C_3[:Fref_external], 2, 0.7)

    #Influence Coefficients for a Circumferential 360° Surface Crack in a Cylindrical Shell
    G_9B_11 = load_table_2d(
        raw"P:\Users\Maxwell\Fracture_Calc development\FFS-1_2021_Tables.xlsx",
        sheet = "Table 9B.11",
        x1=:t_Ri,
        x2=:a_t,
        values=[
         :G0_in, :G1_in, :G2_in, :G3_in, :G4_in,
         :G0_out, :G1_out, :G2_out, :G3_out, :G4_out,
         ]
    )
    #interp_G_thread = interp_2d(gTable_9B_11[:G4_out], 3, 0.7)

    #Influence Coefficients for a Longitudinal Semi-Elliptical Surface Crack in a Cylinder
    #Inside Surface
    G_9B_12 = load_table_3d_coeffs(
        raw"P:\Users\Maxwell\Fracture_Calc development\FFS-1_2021_Tables.xlsx",
        sheet = "Table 9B.12",
        x = :t_Ri,
        y = :a_c,
        z = :a_t,
        values = [
        :G0_A0, :G0_A1, :G0_A2, :G0_A3, :G0_A4, :G0_A5, :G0_A6,
        :G1_A0, :G1_A1, :G1_A2, :G1_A3, :G1_A4, :G1_A5, :G1_A6,
        ]
    )
    #interp_G_thread = gTable_9B_12[:G1_A6](0, 0.375, 0)

    #Influence Coefficients for a Longitudinal Semi-Elliptical Surface Crack in a Cylinder
    #Outside Surface
    G_9B_13 = load_table_3d_coeffs(
        raw"P:\Users\Maxwell\Fracture_Calc development\FFS-1_2021_Tables.xlsx",
        sheet = "Table 9B.13",
        x = :t_Ri,
        y = :a_c,
        z = :a_t,
        values = [
        :G0_A0, :G0_A1, :G0_A2, :G0_A3, :G0_A4, :G0_A5, :G0_A6,
        :G1_A0, :G1_A1, :G1_A2, :G1_A3, :G1_A4, :G1_A5, :G1_A6,
        ]
    )
    #interp_G_thread2 = gTable_9B_13[:G1_A6](0.2, 1, 0)

    return (
        ξ = xi_9_3,
        Fref = Fref_9C_3,
        G11 = G_9B_11, 
        G12 = G_9B_12,
        G13 = G_9B_13
    )
end
export load_ffs_tables

#TODO borrowed, can be merged
function extractunits(s::AbstractString; keep_parentheses::Bool=false)::String
    if occursin("(", s) && occursin(")", s)
        units = match(r"\(.*\)", s).match
    else
        units = "()"
    end
    if !(keep_parentheses)
        units = strip(units, ['(',')'])
    end
    return units
end
export extractunits

"""
    convert_fea_to_ksi(σ_fea, σ_units) -> (σ_fea, σ_units)

Converts FEA stress values from psi to ksi, or ensures already in ksi.
"""
function convert_fea_to_ksi(σ_fea, σ_units) #TODO borrowed, can be merged
    if σ_units == "psi"
        σ_fea = σ_fea ./ 1000
        σ_units = "ksi"
    elseif σ_units == "ksi"
    else
        throw(ArgumentError("Only psi and ksi stress units are supported for verification data."))
    end
    return σ_fea, σ_units
end
export convert_fea_to_ksi

function read_fracture_stress(file_location) #TODO borrowed, can be merged
    df = DataFrame(CSV.File(file_location))
    s_column_name = only(names(df, r"S "))
    σ_column_name = only(names(df, r"Stress "))
    s = df[:, s_column_name]
    σ = df[:, σ_column_name]
    s_units = extractunits(s_column_name)
    σ_units = extractunits(σ_column_name)
    return (s, σ, s_units, σ_units)
end
export read_fracture_stress



# ------------------------------------------------------------
# Utility: clamp extrapolation to table bounds
# ------------------------------------------------------------
const CLAMP = Flat()

# ------------------------------------------------------------
# Load 2D plasticity table (LPr vs X)
# Excel format:
#   First column = LPr
#   Header row   = X values
# ------------------------------------------------------------
function load_table_9_3()
    filename = raw"P:\Users\Maxwell\Fracture_Calc development\FFS-1_2021_Tables.xlsx"
    sheetname = "Table 9.3 Plasticity"
    
    xf = XLSX.readxlsx(filename)
    sheet = xf[sheetname]

    data = XLSX.getdata(sheet)

    # X-axis from row 2, columns 2:end
    X = parse.(Float64, strip.(string.(data[2, 2:end])))

    # Body starts at row 3
    body = data[3:end, :]

    # LPr axis = column 1
    LPr = Float64.(body[:, 1])

    # Table values = columns 2:end
    values = Float64.(body[:, 2:end])

    # Build interpolator (clamped)
    itp = interpolate((LPr, X), values, Gridded(Linear()))
    ext = extrapolate(itp, Flat())
    return ext
end
export load_table_9_3

# ------------------------------------------------------------
# Interpolate plasticity factor
# ------------------------------------------------------------
interp_xi_9_3(itp, LPr, X) = itp(LPr, X)
export interp_xi_9_3

# ------------------------------------------------------------
# Load generic 2D table (e.g. t/Ri × a/t → value(s))
# Excel format:
#   col1 = x1, col2 = x2, other columns = values
# ------------------------------------------------------------
function load_table_2d(
    filename::String;
    sheet::Union{String,Int}=1,
    x1::Symbol,
    x2::Symbol,
    values::Vector{Symbol}
)
    df = DataFrame(XLSX.readtable(filename, sheet))

    x1v = sort(unique(df[:, x1]))
    x2v = sort(unique(df[:, x2]))

    result = Dict{Symbol,Any}()

    for val in values
        grid = Array{Float64}(undef, length(x1v), length(x2v))

        for (i, a) in enumerate(x1v), (j, b) in enumerate(x2v)
            grid[i, j] = df[(df[:, x1].==a) .& (df[:, x2].==b), val][1]
        end

        itp = interpolate((x1v, x2v), grid, Gridded(Linear()))
        result[val] = extrapolate(itp, CLAMP)
    end

    return result
end
export load_table_2d

interp_2d(itp, x1, x2) = itp(x1, x2)
export interp_2d

# ------------------------------------------------------------
# Load 3D coefficient tables
# (t/Ri, a/c, a/t → A0…A6)
# ------------------------------------------------------------
function load_table_3d_coeffs(
    filename::String;
    sheet::Union{String,Int}=1,
    x::Symbol = :t_Ri,
    y::Symbol = :a_c,
    z::Symbol = :a_t,
    values::Vector{Symbol} = Symbol.("A0":"A6")
)
    df = DataFrame(XLSX.readtable(filename, sheet))

    xv = sort(unique(df[:, x]))
    yv = sort(unique(df[:, y]))
    zv = sort(unique(df[:, z]))

    interpolators = Dict{Symbol, Any}()

    for c in values
        grid = Array{Float64}(undef, length(xv), length(yv), length(zv))

        for (i, xi) in enumerate(xv),
            (j, yi) in enumerate(yv),
            (k, zi) in enumerate(zv)

            grid[i, j, k] =
                df[(df[:, x].==xi) .& (df[:, y].==yi) .& (df[:, z].==zi), c][1]
        end

        itp = interpolate((xv, yv, zv), grid, Gridded(Linear()))
        interpolators[c] = extrapolate(itp, CLAMP)
    end

    return interpolators
end
export load_table_3d_coeffs

# ------------------------------------------------------------
# Evaluate all coefficients at once
# ------------------------------------------------------------
function interp_3d_coeffs(itps::Dict, x, y, z)
    return Dict(k => itps[k](x, y, z) for k in keys(itps))
end
export interp_3d_coeffs