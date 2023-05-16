

using Formatting,CSV,DataFrames,GLM,RegressionTables,Weave,CairoMakie,StatsBase,CategoricalArrays,DDIMeta

include( "constants.jl")
include( "mappings.jl")

if ! @isdefined cl
    cl = CSV.File("$(DPATH)/clife_combined.tab")|>DataFrame
end

cl.income = toincome.( cl.zincomhh )
cl.age = toage.( cl.r3age6 )
cl.d2021 = cl.dyear .== 2021

function loadone!( outf::DataFrame, inf::AbstractDataFrame, col::Symbol, year::Int  )
    
    for(key,cgg) in pairs(groupby(inf, col))
        println( "key is $key")
        push!(outf.year, year )
        label = ismissing( key[1]) ? "NA:$col" : key[1]
        push!(outf.label, label )
        yt = sum(cgg.weight)
        push!(outf.val, 100.0*sum( cgg[cgg.zinfform_c.=="Yes",:weight] )/yt)
    end
end

p2 = DataFrame( year=fill(0,0), label=fill("",0), val=fill(0.0,0 ))

for (dyear,cg) in pairs(groupby(cl,:dyear))
    println( "on year $dyear")
    loadone!( p2, cg, :sex_c, dyear.dyear )
    loadone!( p2, cg, :gor_c, dyear.dyear )
    loadone!( p2, cg, :hten1_c, dyear.dyear )
    loadone!( p2, cg, :ocorg_c, dyear.dyear )
    loadone!( p2, cg, :zquals1_c, dyear.dyear )
    loadone!( p2, cg, :livharm1_c, dyear.dyear )
end

global gdata = unstack( p2, :label, :val )
rename!( gdata, RENAMES )
nam = names(gdata)

m1 = glm( @formula(zinfform ~ sex_c + gor_c + hten1_c + ocorg_c + zquals1_c + livharm1_c ), cl, Binomial())
m2 = glm( @formula(zinfform ~ sex_c + gor_c + hten1_c + ocorg_c + zquals1_c + livharm1_c + log(income) + d2021  ), cl, Binomial())
m3 = glm( @formula(zinfform ~ sex_c + gor_c + hten1_c + ocorg_c + zquals1_c + livharm1_c + log(income) + d2021 + age + (age^2)/1000.0 ), cl, Binomial())

f1 = Figure()
f2 = Figure()
f3 = Figure()
f4 = Figure()
f5 = Figure()
f6 = Figure()

jdict = (
    f1 = f1,
    f2 = f2,
    f3 = f3,
    f4 = f4,
    f5 = f5,
    f6 = f6,
    gdata = gdata,
    m1 = m1,
    m2 = m2,
    m3 = m3 )


Weave.weave( "src/visualisations.jmd"; args=jdict, out_path="report/" )
Weave.weave( "src/visualisations.jmd"; args=jdict, out_path="report/", doctype = "md2pdf")