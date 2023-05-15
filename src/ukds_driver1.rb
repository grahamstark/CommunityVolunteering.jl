#!/usr/bin/ruby
#
require 'ukds_schema_utils'

DIR = "/mnt/data/CommunityLifeSurvey/textdics/"

dataset = 'comlife'
year= 2012
filename = "#{DIR}/community_life_survey_2012-13_data_set_v2_ukda_data_dictionary.txt"
tablename= "main"

TARGETS = [
# ['comlife', 2012, 'community_life_survey_2012-13_data_set_v2_ukda_data_dictionary.txt', 'main'],
    ['comlife', 2013, 'community_life_face_to_face_2013_public_dataset_ukda_data_dictionary.txt', 'main'],
    ['comlife', 2014, 'community_life_201415_face_to_face_public_dataset_ukda_data_dictionary.txt', 'main'],
    ['comlife', 2014, 'community_life_2014-15_web_postal_data_ukda_data_dictionary.txt', 'f2f'],
    ['comlife', 2014, 'community_life_201415_web_postal_public_dataset_ukda_data_dictionary.txt', 'postal'],
    ['comlife', 2015, 'community_life_2015-16_face_to_face_public_data_set_ukda_data_dictionary.txt', 'f2f'],
    ['comlife', 2015, 'community_life_2015-16_public_dataset_ukda_data_dictionary.txt', 'main'],
    ['comlife', 2016, 'community_life_2016-17_eul_ukda_data_dictionary.txt', 'main'],
    ['comlife', 2017, 'community_life_2017-18_eul_v2_ukda_data_dictionary.txt', 'main'],
    ['comlife', 2018, 'community_life_2018-19_end_user_licence_dataset_ukda_data_dictionary.txt', 'main'],
    ['comlife', 2019, 'community_life_2019-20_public_access_dataset_v2_ukda_data_dictionary.txt', 'main'],
    ['comlife', 2020, 'community_life_2020-21_public_access_dataset_v1_ukda_data_dictionary.txt', 'main'],
    ['comlife', 2021, 'community_life_survey_2021_22_archive_data_v1_ukda_data_dictionary.txt', 'main']
]

TARGETS.each{
    |t|
    readOneRTF( t[0], t[1], t[2], t[3] )
}



# 
# dataset = 'ncds'
# year = 1958 # start; arbitrary really
# filename =  '/mnt/data/teaching/./ncds_teaching/UKDA-5805-stata8/mrdoc/allissue/ncds_keyvariables_UKDA_Data_Dictionary.txt'
# readOneRTF( dataset, year, filename )
# 
# dataset = 'fes'
# year = 2005
# filename = '/mnt/data/teaching/./expenditure_and_food_survey/mrdoc/allissue/efsteaching0506_UKDA_Data_Dictionary.txt'
# readOneRTF( dataset, year, filename )
# 
# dataset = 'ehs'
# year = 2008
# filename = '/mnt/data/teaching/./english_house_conditions_survey/mrdoc/allissue/ehs08_teach_spss_version_ukda_data_dictionary.txt'
# readOneRTF( dataset, year, filename )
# 
# dataset = 'bhps' 
# year=1991
# filename='/mnt/data/teaching/./bhps/mrdoc/allissue/bhps_sampler3_ukda_data_dictionary.txt'
# readOneRTF( dataset, year, filename )
# 
# dataset='ghs'
# year=2005
# filename='/mnt/data/teaching/./general_household_survey_social_capital/mrdoc/allissue/soccaptchdata_UKDA_Data_Dictionary.txt'
# readOneRTF( dataset, year, filename )
# 

