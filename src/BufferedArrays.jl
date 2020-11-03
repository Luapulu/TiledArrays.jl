module BufferedArrays

import Base: size, IndexStyle, getindex, setindex

using ..TiledArrays

export BufferedArray

struct BufferedArray{T, N, A} <: AbstractTiledArray{T, N}
    parent::A
    buffer::Array{T, N}
    tile::Ref{Tile{NTuple{N, Int}}}
    function BufferedArray{T, N, A}(parent, buffer, tile) where {T, N, A}
        new{T, N, A}(parent, buffer, Ref(tile))
end

BufferedArray{T, N, A}(parent, dims::NTuple{N, Integer}) where {T, N, A} =
    BufferedArray{T, N, A}(parent, Array{T, N}(undef, dims))

BufferedArray(parent::AbstractArray{T, N}, args...) where {T, N} =
    BufferedArray{T, N, typeof(A)}(parent, args...)

size(B::BufferedArray) = size(B.parent)

# Indexing

tile(B::BufferedArray) = B.tile[]

function getindex(B::BufferedArray, t::Tile)
    if t != tile(B)
        writeblock!(B, t)
    end
    B.buffer
end

end # module
