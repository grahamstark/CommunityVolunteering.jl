using Formatting,CSV,DataFrames,GLM,RegressionTables,Weave,CairoMakie,StatsBase,CategoricalArrays,DDIMeta

include( "constants.jl")

cl = CSV.File("$(DPATH)/clife_combined.tab")|>DataFrame
clg = groupby(cl,:dyear)

picd = DataFrame( year=2012:2021, labels=fill("",10), any_last_year=zeros(10))
volun = zeros(10)
i = 0
for (dyear,cg) in clg
    global i
    i += 1
    cm = countmap( cg.zinfform_c, cg.weight )
    popn = sum(cg.weight)
    picd.any_last_year[i] = sum( cg[cg.zinfform_c.=="Yes",:weight])/popn
    println("$(picd.year[i]) $dyear map $(cm)")
end

println( picd )

combine( clg, [:zinfform_c,:weight]=>histmap )

p2 = DataFrame( year=fill(0,0), label=fill("",0), val=fill(0.0,0))

function loadone!( outf::DataFrame, inf::AbstractDataFrame, col::Symbol, year::Int  )
    
    for(key,cgg) in pairs(groupby(inf, col))
        println( "key is $key")
        push!(outf.year, year )
        label = ismissing( key[1]) ? "NA:$col" : key[1]
        push!(outf.label, label )
        yt = sum(cgg.weight)
        push!(outf.val, sum( cgg[cgg.zinfform_c.=="Yes",:weight] )/yt)
    end
end

for (dyear,cg) in pairs(groupby(cl,:dyear))
    println( "on year $dyear")
    loadone!( p2, cg, :sex_c, dyear.dyear )
    loadone!( p2, cg, :gor_c, dyear.dyear )
    loadone!( p2, cg, :hten1_c, dyear.dyear )
    loadone!( p2, cg, :rnssec3_c, dyear.dyear )
    loadone!( p2, cg, :zquals1_c, dyear.dyear )
    loadone!( p2, cg, :livharm1_c, dyear.dyear )
end

unstack( p2, :label, :val )


    #=
    yt = sum(cg.weight)

    for(sex,cgg) in groupby(cl, :sex_c)
        push!(p2.year, dyear )
        push!(p2.label,sex )
        push!(p2.val, sum( weight)/yt)
    end
    =#


end