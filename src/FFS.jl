"""
    Package FFS v$(pkgversion(FFS))

A collection of equations from The American Society of Mechanical Engineers (ASME)
Fitness for Service standard FFS-1.
This package is intended to be used as a dependency of other data processing packages.
Equations are organized into modules named by their source location in FFS-1.
"""
module FFS
export Part9, RCSCLE3, RCSCCE1, RCSCCL3, WFMFSC, KPTC, RPTC
export RPSCE, RPSCL, KPSCE3

using Interpolations, XLSX, DataFrames, CSV

include("table_import.jl")

#General Fracture Modules
module Part9
    include("Part9_eq.plutojl")
end
module WFMFSC 
    include("weighted_f_eq.plutojl")
end

#Bore Modules
module RCSCLE3
    include("bore_eq.plutojl")
end

#Plate Modules
module KPTC
    include("plate_thru_wall_k.plutojl")
end
module RPTC
    include("plate_thru_wall_r.plutojl")
end
module KPSCE3
    include("plate_elliptical_k.plutojl")
end
module RPSCE
    include("plate_elliptical_r.plutojl")
end
module RPSCL
    include("plate_infinite_r.plutojl")
end

#Thread Modules
module RCSCCE1
    include("thread_elliptical_r.plutojl")
end
module RCSCCL3
    include("thread_annular_r.plutojl")
end

# include("Part9_eq.jl")
# include("bore_eq.jl")
# include("thread_eq.jl")
# include("plate_eq.jl")
# include("weighted_f_eq.jl")

end
