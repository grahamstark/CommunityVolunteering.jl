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
