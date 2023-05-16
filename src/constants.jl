const DPATH="/mnt/data/CommunityLifeSurvey/"
const user="postgres"
const server="localhost"
const db="vw"
const CON_STR = "postgresql://$(user)@$(server)/$(db)"
TARGETS = [
    ("2012_13/tab/community_life_survey_2012-13_data_set_v2.tab", 2012 ),
    # ("2013_14/web_postal/tab/community_life_2013-14_web_postal_data.tab", 2013),
    ("2013_14/tab/community_life_face_to_face_2013_public_dataset.tab", 2013 ),
    # ("2014_15/tab/community_life_201415_face_to_face_public_dataset.tab", 2014 ),
    ("2014_15/tab/community_life_201415_web_postal_public_dataset.tab", 2014 ),
    # ("2015_16/tab/community_life_2015-16_public_dataset.tab", 2015 ),
    ("2015_16/f-t-f/tab/community_life_2015-16_face_to_face_public_data_set.tab", 2015),
    ("2016_17/tab/community_life_2016-17_eul.tab", 2016),
    ("2017_18/tab/community_life_2017-18_eul_v2.tab", 2017),
    ("2018_19/tab/community_life_2018-19_end_user_licence_dataset.tab", 2018),
    ("2019_20/tab/community_life_2019-20_public_access_dataset_v2.tab", 2019),
    ("2020_21/tab/community_life_2020-21_public_access_dataset_v1.tab", 2020 ),
    ("2021_22/tab/community_life_survey_2021_22_archive_data_v1.tab", 2021 )
]

RENAMES = Dict(
    ["year" => "year",
    "Male" => "Male",
    "Female" => "Female",
    "North East" => "North East",
    "North West" => "North West",
    "Yorkshire and Humberside" => "Yorkshire and Humberside",
    "East Midlands" => "East Midlands",
    "West Midlands" => "West Midlands",
    "East of England" => "East of England",
    "London" => "London",
    "South East" => "South East",
    "South West" => "South West",
    "Rent it (includes those who are on Housing Benefit or Local Housing Allowance)" => "Rents",
    "Own it outright" => "Owns outright",
    "Buying it with the help of a mortgage/loan" => "Mortgaged",
    "Live here rent-free (including rent-free in relative's/friend's property but excluding squatters)" => "Rent-Free",
    "Part own and part rent (shared ownership)" => "Shared ownership",
    "Squatting" => "Squatting",
    "NA:hten1_c" => "NA:hten1_c",
    "Private sector firm or company, including for example limited companies and PLCs" => "Private sector",
    "Other public sector employer, including for example Central Government/Civil Service/Government Agencies/Local Authority" => "Other public sector",
    "NA:ocorg_c" => "NA:ocorg_c",
    "Nationalised industry or public corporation, including for example the Post Office and the BBC" => "Nationalised industry",
    "Charity/ Voluntary sector, including for example charitable companies, churches, trade unions" => "Charity/ Voluntary",
    "Other (specify)" => "Other Employment",
    "Self-employed" => "Self-employed",
    "No qualifications" => "No qualifications",
    "Degree or equivalent" => "Degree or equivalent",
    "GCSE grades D-E or equivalent" => "GCSE D-E equiv",
    "A level or equivalent" => "A level equiv",
    "Foreign and other qualifications" => "Foreign/Other",
    "GCSE grades A-C or equivalent" => "GCSE A-C",
    "Higher Education below degree level" => "Other Higher Ed",
    "NA:zquals1_c" => "NA:zquals1_c",
    "Single" => "Single",
    "Cohabiting" => "Cohabiting",
    "Married/civil partnered" => "Married/civil partnered",
    "Divorced/Legally dissolved partnership" => "Divorced",
    "Separated" => "Separated",
    "NA:livharm1_c" => "NA:livharm1_c",
    "Widowed" => "Widowed",
    "NA:sex_c" => "NA:sex_c"])
