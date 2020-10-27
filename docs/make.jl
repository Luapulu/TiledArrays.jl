using TiledArrays
using Documenter

makedocs(;
    modules=[TiledArrays],
    authors="Paul Nemec <paul.nemec@tum.de> and contributors",
    repo="https://github.com/Luapulu/TiledArrays.jl/blob/{commit}{path}#L{line}",
    sitename="TiledArrays.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Luapulu.github.io/TiledArrays.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Luapulu/TiledArrays.jl",
)
