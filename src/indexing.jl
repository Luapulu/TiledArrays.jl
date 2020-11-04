# reroute through IndexStyle
# This allows converting indices based on IndexStyle, independent of the type tree
# May be this rerouting can be added to julia base someday
@inline to_indices(A::AbstractTiledArray, I::Tuple) = to_indices(IndexStyle(A), A, I)

# route to base definitions by default
@inline to_indices(::IndexStyle, A, I::Tuple) = to_indices(A, axes(A), I)
@inline to_indices(::IndexStyle, A, I::Tuple{Any}) =
    to_indices(A, (eachindex(IndexLinear(), A),), I)

"""
    IndexTiled <: IndexStyle

Signals that an array is best indexed into tile by tile.
"""
struct IndexTiled <: IndexStyle end

IndexStyle(::Type{<:AbstractTiledArray}) = IndexTiled()

"""
    TilingStyle

Defines how an array is tiled.
"""
abstract type TilingStyle end
TilingStyle(T::Type) = throw(MethodError("No TilingStyle defined for $T"))
TilingStyle(x) = TilingStyle(typeof(x))

@inline to_indices(::IndexTiled, A, I) = to_indices(TilingStyle(A), A, I)

"""
    Tile{T}(I::T)

an index or key used to retrieve a tile from an array.
"""
struct Tile{T}
    I::T
end

Tile(I::T) where {T} = Tile{T}(I)

getindex(A, t::Tile, i1, i...) = A[t][i1, i...]
setindex!(A, x, t::Tile, i1, i...) = (view(A, t)[i1, i...] = x)

"""
    GridTiles <: TilingStyle

A `TilingStyle`, where tiles make a grid with no offset.

If the grid size does not divide the size of the array, the last tiles along any given axis
are truncated.
"""
struct GridTiles <: TilingStyle end

@inline function to_indices(gt::GridTiles{N}, A, I::NTuple{N, Integer}) where {N}

end
