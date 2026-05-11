"""
    Package FFS v$(pkgversion(FFS))

A collection of equations from The American Society of Mechanical Engineers (ASME) Fitness for Service standard FFS-1.
This package is intended to be used as a dependency of other data processing packages.
Equations are organized into modules named by their source location in FFS-1.
"""
module FFS
using Interpolations

include("table_import.jl")
include("Part9_eq.jl")
include("bore_eq.jl")
include("thread_eq.jl")
include("plate_eq.jl")

import .Part9, .KCSCLE3, .RCSCLE3,
 .RCSCCE1, .KCSCCL3, .RCSCCL3, .KPTC, .RPTC

end
