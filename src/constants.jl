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

RENAMES = Dict([
    "year" => "year",
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
    # "Rents it (includes those who are on Housing Benefit or Local Housing Allowance)" => "Rents",
    "Own it outright" => "Owns outright",
    "Buying it with the help of a mortgage/loan" => "Mortgaged",
    # "Live here rent-free (including " ⋯ 35 bytes ⋯ "operty but excluding squatters)" => "Rent-free",
    "Part own and part rent (shared ownership)" => "Shared ownership",
    "Squatting" => "Squatting",
    "NA:hten1_c" => "NA:Tenure",
    "NA:rnssec3_c" => "NA:Occup",
    "No qualifications" => "No qualifications",
    "Degree or equivalent" => "Degree or equivalent",
    "GCSE grades D-E or equivalent" => "GCSE D-E equivalent",
    "A level or equivalent" => "A level equivalent",
    "Foreign and other qualifications" => "Foreign or other",
    "GCSE grades A-C or equivalent" => "GCSE A-C equivalent",
    "Higher Education below degree level" => "HE below degree",
    "NA:zquals1_c" => "NA:Quals",
    "Single" => "Single",
    "Cohabiting" => "Cohabiting",
    "Married/civil partnered" => "Married/civil partner",
    "Divorced/Legally dissolved partnership" => "Divorced",
    "Separated" => "Separated",
    "NA:livharm1_c" => "NA:Marr",
    "Widowed" => "Widowed",
    "Routine and manual occupations" => "Routine/manual",
    "Never worked and long-term unemployed" => "Never worked",
    "Higher managerial, administrative and professional occupations" => "Managerial Professional",
    "Intermediate occupations" => "Intermediate",
    "NA:sex_c" => "NA:Sex" ])

REN2 = [13=>"Rents", 16=>"Rent Free"]
