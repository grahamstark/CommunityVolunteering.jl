using CSV,DataFrames,GLM,RegressionTables,Weave,CairoMakie,StatsBase,CategoricalArrays,DDIMeta

const DPATH="/mnt/data/CommunityLifeSurvey/"
const user="postgres"
const server="localhost"
const db="vw"
const constr = "postgresql://$(user)@$(server)/$(db)"
const TARGETS = [
    ("2012_13/tab/community_life_survey_2012-13_data_set_v2.tab", 2012 ),
    ("2013_14/web_postal/tab/community_life_2013-14_web_postal_data.tab", 2013),
    ("2013_14/tab/community_life_face_to_face_2013_public_dataset.tab", 2013 ),
    ("2014_15/tab/community_life_201415_web_postal_public_dataset.tab", 2014 ),
    ("2014_15/tab/community_life_201415_face_to_face_public_dataset.tab", 2014 ),
    ("2015_16/tab/community_life_2015-16_public_dataset.tab", 2015 ),
    ("2015_16/f-t-f/tab/community_life_2015-16_face_to_face_public_data_set.tab", 2015),
    ("2016_17/tab/community_life_2016-17_eul.tab", 2016),
    ("2017_18/tab/community_life_2017-18_eul_v2.tab", 2017),
    ("2018_19/tab/community_life_2018-19_end_user_licence_dataset.tab", 2018),
    ("2019_20/tab/community_life_2019-20_public_access_dataset_v2.tab", 2019),
    ("2020_21/tab/community_life_2020-21_public_access_dataset_v1.tab", 2020 ),
    ("2021_22/tab/community_life_survey_2021_22_archive_data_v1.tab", 2021 )
]

function loadone( filename::String, dyear :: Int )::DataFrame
    df = CSV.File( "$(DPATH)/$(filename)")|>DataFrame    
    lcn = lowercase.(names(df))
    rename!(df, lcn )
    # adhoc renamings
    if dyear == 2012
        rename!( df, Dict( :rcaliwt =>"respondentcalibrationweight" ))
    elseif dyear == 2021
        # rename Occup map using 2010 definitions
        rename!( df, Dict( :rnssec82010=>"rnssec8", :rnssec32010=>"rnssec3", :rnssec52010=>"rnssec5"))
        rename!( df, Dict( :rimweightcls=>"respondentcalibrationweight" ))
    elseif dyear in [2018,2019,2020]
        rename!( df, Dict( :sexg=>"sex" ))
    end
    df.dyear .= dyear    
    return df
end

function loadall()
    clife = loadone( TARGETS[1][1], targets[1][2] )
    n = size(TARGETS)[1]
    for i in 2:n
        global clife
        c = loadone( targets[i][1], targets[i][2] )
        clife = vcat( clife, c ;cols=:union )    
    end
    clife
end

# clife = CSV.File("$(DPATH)/clife_combined.tab")|>DataFrame

loadall()


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

vars12 = load_variable_list( str, "comlife", "main", 2012 )
vars21 = load_variable_list( str, "comlife", "main", 2021 )

function tocat( data, varname )
    v = vars21[varname]
    println( "v=$v")
    a = []
    for (k,e) in v.enums
        println( "e=$e")
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

CSV.write( "$(DPATH)/clife_combined.tab", clife )


# clife.zincomhh = tocat( clife, :ZIncomhh )