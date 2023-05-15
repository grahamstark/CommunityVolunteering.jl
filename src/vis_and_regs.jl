using CSV,DataFrames,GLM,RegressionTables,Weave,StatsBase,CategoricalArrays,DDIMeta

include( "src/constants.jl")

function loadone( filename::String, dyear :: Int )::DataFrame
    df = CSV.File( "$(DPATH)/$(filename)")|>DataFrame    
    lcn = lowercase.(names(df))
    rename!(df, lcn )
    # adhoc renamings
    println( "on year $dyear filename $filename")
    println( "filesize $(size(df))")
    if dyear in [2012]
        rename!( df, Dict( :srcaliwt =>"respondentcalibrationweight" ))
    elseif dyear in [2014,2015] # filename == "2013_14/web_postal/tab/community_life_2013-14_web_postal_data.tab" )
        # df.respondentcalibrationweight = df.respondentdesignweight #rcaliw # respondentdesignweight                                            
    elseif dyear == 2021
        # rename Occup map using 2010 definitions
        rename!( df, Dict( :rnssec82010=>"rnssec8", :rnssec32010=>"rnssec3", :rnssec52010=>"rnssec5"))
        rename!( df, Dict( :rimweightcls=>"respondentcalibrationweight" ))
    elseif dyear in [2018,2019,2020]
        rename!( df, Dict( :sexg=>"sex" ))
        if dyear == 2019
            df.sex = tryparse.( Int, df.sex )
        end
    end
    df.dyear .= dyear    
    return df
end

function loadall()
    clife = loadone( TARGETS[1][1], TARGETS[1][2] )
    n = size(TARGETS)[1]
    for i in 2:n
        c = loadone( TARGETS[i][1], TARGETS[i][2] )
        clife = vcat( clife, c ;cols=:union )    
    end
    clife
end

# clife = CSV.File("$(DPATH)/clife_combined.tab")|>DataFrame

clife = loadall()


function lrecode( a :: AbstractVector, pairs... )::CategoricalVector
    n = length(a)
    v = Vector{Union{String,Missing}}(undef,n)
    fill!(v,missing)
    for i in 1:n
        for p in pairs
            if ismissing(a[i])            
                v[i] = missing
            else
                if a[i] in p[1]
                    v[i] = p[2]
                end
            end
        end
    end
    println( "got v as $v")
    return categorical( v )
end

vars12 = load_variable_list( CON_STR, "comlife", "main", 2012 )
vars21 = load_variable_list( CON_STR, "comlife", "main", 2021 )
# note renaming in 2021 rnssec3; this seems simplest hack
vars21[:rnssec3] = deepcopy(vars21[:rnssec32010])
vars21[:rnssec5] = deepcopy(vars21[:rnssec52010])
vars21[:rnssec8] = deepcopy(vars21[:rnssec82010])


function tocat( data, varname )
    v = vars21[varname]
    # println( "v=$v")
    a = []
    for (k,e) in v.enums
        # println( "e=$e")
        if e.value >= 0
            push!(a, (e.value,e.label))
        else
            push!(a, (e.value,missing))
        end
    end
    lv = Symbol(lowercase(String(varname)))
    lrecode( data[:,lv], a... )
end



clife.sex_c = tocat(clife,:Sex )

clife.hten1_c = tocat( clife, :HTen1 )

clife.gor_c = tocat( clife, :GOR )

clife.rnssec3_c = tocat( clife, :rnssec3 ) 

clife.ocorg_c = tocat( clife, :OcOrg )

clife.zquals1_c = tocat( clife, :Zquals)

clife.livharm1_c = tocat( clife, :Livharm1 )

clife.zinffor_c = tocat( clife, :Zinffor )
clife.zinfform_c = tocat( clife, :Zinfform )
clife.zengfv1_c = tocat( clife, :ZEngFv1)
clife.weight = fweights( clife.respondentcalibrationweight)
# 

CSV.write( "$(DPATH)/clife_combined.tab", clife )

clife_y = groupby( clife, :dyear )
for cy in clife_y
    y = cy.dyear[1]
    pop = sum( cy.weight )
    c = size(cy)[1]
    println( "year $y n=$c pop=$pop")
end

# clife.zincomhh = tocat( clife, :ZIncomhh )

