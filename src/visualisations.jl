using Formatting,CSV,DataFrames,GLM,RegressionTables,Weave,CairoMakie,StatsBase,CategoricalArrays,DDIMeta

include( "constants.jl")

cl = CSV.File("$(DPATH)/clife_combined.tab")|>DataFrame
cl.income = toincome.( clife.zincomhh )
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
    loadone!( p2, cg, :rnssec3_c, dyear.dyear )
    loadone!( p2, cg, :zquals1_c, dyear.dyear )
    loadone!( p2, cg, :livharm1_c, dyear.dyear )
end

gdata = unstack( p2, :label, :val )
rename!( gdata, RENAMES )
rename!( gdata, REN2 )
nam = names(gdata)

m1 = glm( @formula(zinfform ~ sex_c + gor_c + hten1_c + ocorg_c + zquals1_c + livharm1_c ), cl, Binomial())
m2 = glm( @formula(zinfform ~ sex_c + gor_c + hten1_c + ocorg_c + zquals1_c + livharm1_c + log(income) + d2021  ), cl, Binomial())
regtable( m1, m2 )

function drawOneGraph!(
    chart,
    row :: Int,
    col :: Int,
    subtitle :: String,
    data :: AbstractDataFrame,
    targets :: Vector{String} )
    axd = Axis( # = layout[1,1] 
        chart[row,col], 
        title="Volunteering in Last Month",
        subtitle=subtitle,
        xlabel="Year", 
        ylabel="%" )
    ylims!( axd, [0,100.0])
    plots = []
    for t in targets
        l = lines!( 
            axd,
            data.year,
            data[!,Symbol(t)])
        push!( plots, l )
    end
    leg = Legend(
        chart[row,col+1], 
        plots,
        targets );
end


f1 = Figure()
f2 = Figure()
f3 = Figure()
f4 = Figure()
f5 = Figure()
# nam = names(gdata)
drawOneGraph!( f1, 1, 1, "By Gender", gdata, ["Male", "Female"])
drawOneGraph!( f2, 1, 1, "By Region", gdata, nam[4:12])
drawOneGraph!( f3, 1, 1, "By Tenure", gdata, nam[13:18])
drawOneGraph!( f4, 1, 1, "By Occupation", gdata, nam[36:39])
drawOneGraph!( f5, 1, 1, "By Marital Status", gdata, ["Single", "Cohabiting", "Married/civil partner", "Divorced", "Separated", "Widowed"])

save( "by_gender.svg", f1 )
save( "by_region.svg", f2)
save( "by_tenure.svg", f3 )
save( "by_occupation.svg", f4 )
save( "by_marital.svg", f5 )