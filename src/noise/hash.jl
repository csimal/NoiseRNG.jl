
"""
    HashNoise

A noise function using `Base.hash`.

## Fields
`seed:UInt` seed of the noise function. Note that the constructor uses the hash of its argument to get the seed.
"""
struct HashNoise <: AbstractNoise{UInt}
    seed::UInt
    HashNoise(seed) = new(hash(seed))
end

Base.:(==)(hn1::HashNoise, hn2::HashNoise) = hn1.seed == hn2.seed

HashNoise() = HashNoise(UInt(0))

function noise(n::UInt, h::HashNoise)
    Base.hash(n, h.seed)
end