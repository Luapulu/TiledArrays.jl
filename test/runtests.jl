using TiledArrays
using Test

@testset "TiledArrays.jl" begin

@testset "BufferedArrays" begin
    using TiledArrays.BufferedArrays

    data = reshape(1:240, 4, 10, 6)
    arr = BufferedArray(data, (2, 5, 3))

    @test size(arr) == (4, 10, 6)
    @inferred size(arr)

    @test IndexStyle(typeof(arr)) === IndexTiled()

    @test arr[2, 2, 1] == 6

    I = rand.(axes(data))
    @test arr[I...] = data[I...]

    @test arr[92] == 92

    i = rand(eachindex(data))
    @test arr[i] == data[i]
end

end
