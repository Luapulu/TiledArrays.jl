module TiledArrays

import Base: to_indices, size, getindex, setindex!

export AbstractTiledArray


"""
    AbstractTiledArray{T, N} <: AbstractArray{T, N}

Supertype for all arrays that are best indexed into in tile by tile.
"""
abstract type AbstractTiledArray{T, N} <: AbstractArray{T, N} end

include("indexing.jl")

"""
    TiledArray{T, N, A<:AbstractArray{T, N}, TS<:TilingStyle}(parent::A)

Wrapper around `parent` array, making it into an [`AbstractTiledArray`](@ref) with
[`TilingStyle`](@ref) `TS`
"""
struct TiledArray{T, N, A<:AbstractArray{T, N}, TS<:TilingStyle} <: AbstractTiledArray{T, N}
    parent::A
end

size(A::TiledArray) = size(A.parent)

TilingStyle(::Type{<:TiledArray{<:Any, <:Any, <:Any, TS}}) where {TS} = TS

# to_indices will take care of converting the Tile to the
# correct indices for the parent's index type.
view(A::TiledArray, t::Tile) = view(A.parent, t::Tile)

getindex(A::TiledArray, t::Tile) = getindex(A.parent, t)


include("BufferedArrays.jl")

end # module
