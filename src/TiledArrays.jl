module TiledArrays

import Base: to_indices, to_index

export AbstractTiledArray

abstract type AbstractTiledArray{T, N} <: AbstractArray{T, N} end

# reroute through IndexStyle
# This allows converting indices based on IndexStyle, independent of the type tree
to_indices(A::AbstractTiledArray, I::Tuple) = to_indices(IndexStyle(A), A, I)

# route to base definitions by default
to_indices(::IndexStyle, A, I)
to_indices(A, I::Tuple) = (@inline; to_indices(A, axes(A), I))
to_indices(A, I::Tuple{Any}) = (@inline; to_indices(A, (eachindex(IndexLinear(), A),), I))

struct IndexTiled <: IndexStyle end

IndexStyle(::Type{<:AbstractTiledArray}) = IndexTiled

struct Tile{T}
    I::T
end

Tile(I::T) where {T} = Tile{T}(I)

abstract type TilingStyle end

struct GridTiles{N} <: TilingStyle
    grid::NTuple{N, Int}
end

include("BufferedArrays.jl")

end # module
