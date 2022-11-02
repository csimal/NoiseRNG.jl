module RandomNoise

"""
    AbstractNoise{T}

Supertype for random noise functions. `T` indicates the return type.
"""
abstract type AbstractNoise{T} end

"""
    noise(n, noise::AbstractNoise)

Compute noise function `noise` at position `n`.

## Examples
```jldoctest
julia> sqn = SquirrelNoise5()
SquirrelNoise5(0x00000000)

julia> noise(5, sqn)
0x933e65af
```
"""
function noise(n::Integer, nf::AbstractNoise{T}) where {T<:Integer}
    noise(n % T, nf)
end

function noise(n, nf::AbstractNoise{T}) where {T}
    noise(_convert(n, T), nf)
end


export AbstractNoise
export noise

include("noise/squirrel5.jl")
include("noise/murmur3.jl")

export SquirrelNoise5, SquirrelNoise5x2, Murmur3Noise

include("utils/pairing_functions.jl")
include("noise_maps.jl")

export NoiseMap

include("utils/convert.jl")
include("noise_rng.jl")

export NoiseRNG

include("utils/transforms.jl")

export NoiseUniform

using Random123

include("noise/random123.jl")
export ThreefryNoise, PhiloxNoise
@static if Random123.R123_USE_AESNI
    export AESNINoise, ARSNoise
end

using Requires

function __init__()
    
    # Optional support for Distributions
    @require Distributions="31c24e10-a181-5473-b8eb-7969acd0382f" include("distributions.jl")
end

end
