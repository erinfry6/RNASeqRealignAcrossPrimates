##!/bin/bash

## written by EF in April 2017
## Download the RNA seq raw data from NCBI Geo : http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE30352, find the file and copy the link address
## the following samples are all primate samples, bar the generic brain samples

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/ReconAncNeoTranscriptomes/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw
export pathScripts=${path}/scripts/map_RNA_seq_data


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### MML CEREBELLUM


##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081924/SRR306779/SRR306779.sra

##mv  SRR306779.sra  ${pathRNAseq}/mml_br_M_2/RNAseq.sra

##########################################################################################

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081925/SRR306780/SRR306780.sra
#mkdir ${pathRNAseq}/mml_cb_F_1
#mv  SRR306780.sra  ${pathRNAseq}/mml_cb_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081926/SRR306781/SRR306781.sra
#mkdir ${pathRNAseq}/mml_cb_M_1
#mv  SRR306781.sra  ${pathRNAseq}/mml_cb_M_1/RNAseq.sra

##########################################################################################

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081927/SRR306782/SRR306782.sra
#mkdir ${pathRNAseq}/mml_ht_F_1
#mv SRR306782.sra  ${pathRNAseq}/mml_ht_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081928/SRR306783/SRR306783.sra
#mkdir ${pathRNAseq}/mml_ht_M_1
#mv  SRR306783.sra  ${pathRNAseq}/mml_ht_M_1/RNAseq.sra

##########################################################################################

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081929/SRR306784/SRR306784.sra
#mkdir ${pathRNAseq}/mml_kd_F_1
#mv  SRR306784.sra  ${pathRNAseq}/mml_kd_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081930/SRR306785/SRR306785.sra
#mkdir ${pathRNAseq}/mml_kd_M_1
#mv  SRR306785.sra  ${pathRNAseq}/mml_kd_M_1/RNAseq.sra

########################################################################################## liver

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081931/SRR306786/SRR306786.sra
#mkdir ${pathRNAseq}/mml_lv_F_1
#mv  SRR306786.sra  ${pathRNAseq}/mml_lv_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081932/SRR306788/SRR306788.sra
#mkdir ${pathRNAseq}/mml_lv_M_1
#mv  SRR306788.sra  ${pathRNAseq}/mml_lv_M_1/RNAseq.sra

##########################################################################################TESTIS

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081933/SRR306789/SRR306789.sra
#mkdir ${pathRNAseq}/mml_ts_M_1
#mv  SRR306789.sra  ${pathRNAseq}/mml_ts_M_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081934/SRR306790/SRR306790.sra
#mkdir ${pathRNAseq}/mml_ts_M_2
#mv  SRR306790.sra  ${pathRNAseq}/mml_ts_M_2/RNAseq.sra

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### PPY

##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081935/SRR306791/SRR306791.sra

##mv  SRR306791.sra  ${pathRNAseq}/ppy_br_F_1/RNAseq.sra

##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081936/SRR306792/SRR306792.sra

##mv  SRR306792.sra  ${pathRNAseq}/ppy_br_M_1/RNAseq.sra

##########################################################################################CEREBELLUM

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081937/SRR306793/SRR306793.sra
#mkdir ${pathRNAseq}/ppy_cb_F_1
#mv SRR306793.sra  ${pathRNAseq}/ppy_cb_F_1/RNAseq.sra

##########################################################################################HEART

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081938/SRR306794/SRR306794.sra
#mkdir ${pathRNAseq}/ppy_ht_F_1
#mv  SRR306794.sra  ${pathRNAseq}/ppy_ht_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081939/SRR306795/SRR306795.sra
#mkdir ${pathRNAseq}/ppy_ht_M_1
#mv  SRR306795.sra  ${pathRNAseq}/ppy_ht_F_1/RNAseq.sra

##########################################################################################KIDNEY

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081940/SRR306796/SRR306796.sra
#mkdir ${pathRNAseq}/ppy_kd_F_1
#mv  SRR306796.sra  ${pathRNAseq}/ppy_kd_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081941/SRR306797/SRR306797.sra
#mkdir ${pathRNAseq}/ppy_kd_M_1
#mv  SRR306797.sra  ${pathRNAseq}/ppy_kd_M_1/RNAseq.sra

##########################################################################################LIVER

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081942/SRR306798/SRR306798.sra
#mkdir ${pathRNAseq}/ppy_lv_F_1
#mv  SRR306798.sra  ${pathRNAseq}/ppy_lv_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081943/SRR306799/SRR306799.sra
#mkdir ${pathRNAseq}/ppy_lv_M_1
#mv  SRR306799.sra  ${pathRNAseq}/ppy_lv_M_1/RNAseq.sra

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### GGO  CORTEX
##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081944/SRR306800/SRR306800.sra

##mv  SRR306800.sra  ${pathRNAseq}/ggo_br_F_1/RNAseq.sra


##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081945/SRR306801/SRR306801.sra

##mv  SRR306801.sra ${pathRNAseq}/ggo_br_M_1/RNAseq.sra

#########################################################################################CEREBELLUM

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081946/SRR306802/SRR306802.sra
#mkdir ${pathRNAseq}/ggo_cb_F_1
#mv  SRR306802.sra  ${pathRNAseq}/ggo_cb_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081947/SRR306803/SRR306803.sra
#mkdir ${pathRNAseq}/ggo_cb_M_1
#mv  SRR306803.sra  ${pathRNAseq}/ggo_cb_M_1/RNAseq.sra


##########################################################################################HEART


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081948/SRR306804/SRR306804.sra
#mkdir ${pathRNAseq}/ggo_ht_F_1
#mv SRR306804.sra  ${pathRNAseq}/ggo_ht_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081949/SRR306805/SRR306805.sra
#mkdir ${pathRNAseq}/ggo_ht_M_1
#mv  SRR306805.sra  ${pathRNAseq}/ggo_ht_M_1/RNAseq.sra




##########################################################################################KIDNEY

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081950/SRR306806/SRR306806.sra
#mkdir ${pathRNAseq}/ggo_kd_F_1
#mv  SRR306806.sra  ${pathRNAseq}/ggo_kd_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081951/SRR306807/SRR306807.sra
#mkdir ${pathRNAseq}/ggo_kd_M_1
#mv SRR306807.sra  ${pathRNAseq}/ggo_kd_M_1/RNAseq.sra



##########################################################################################LIVER

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081952/SRR306808/SRR306808.sra
#mkdir ${pathRNAseq}/ggo_lv_F_1
#mv  SRR306808.sra  ${pathRNAseq}/ggo_lv_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081953/SRR306809/SRR306809.sra
#mkdir ${pathRNAseq}/ggo_lv_M_1
#mv  SRR306809.sra  ${pathRNAseq}/ggo_lv_M_1/RNAseq.sra

#########################################################################################TESTIS

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081954/SRR306810/SRR306810.sra
#mkdir ${pathRNAseq}/ggo_ts_M_1/
#mv  SRR306810.sra  ${pathRNAseq}/ggo_ts_M_1/RNAseq.sra


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### PTR CORTEX

##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081955/SRR306811/SRR306811.sra

##mv  SRR306811.sra  ${pathRNAseq}/ptr_br_F_1/RNAseq.sra


##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081956/SRR306812/SRR306812.sra

##mv  SRR306812.sra  ${pathRNAseq}/ptr_br_M_1/RNAseq.sra


##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081957/SRR306813/SRR306813.sra

##mv  SRR306813.sra  ${pathRNAseq}/ptr_br_M_2/RNAseq.sra


##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081958/SRR306814/SRR306814.sra

##mv  SRR306814.sra  ${pathRNAseq}/ptr_br_M_3/RNAseq.sra


##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081959/SRR306815/SRR306815.sra

##mv  SRR306815.sra  ${pathRNAseq}/ptr_br_M_4/RNAseq.sra


##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081960/SRR306816/SRR306816.sra

##mv  SRR306816.sra  ${pathRNAseq}/ptr_br_M_5/RNAseq.sra

#########################################################################################CEREBELLUM

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081961/SRR306817/SRR306817.sra
#mkdir ${pathRNAseq}/ptr_cb_F_1
#mv  SRR306817.sra  ${pathRNAseq}/ptr_cb_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081962/SRR306818/SRR306818.sra
#mkdir ${pathRNAseq}/ptr_cb_M_1
#mv  SRR306818.sra  ${pathRNAseq}/ptr_cb_M_1/RNAseq.sra

##########################################################################################HEART
#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081963/SRR306819/SRR306819.sra
#mkdir ${pathRNAseq}/ptr_ht_F_1
#mv  SRR306819.sra  ${pathRNAseq}/ptr_ht_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081964/SRR306820/SRR306820.sra
#mkdir ${pathRNAseq}/ptr_ht_M_1
#mv  SRR306820.sra  ${pathRNAseq}/ptr_ht_M_1/RNAseq.sra

##########################################################################################KIDNEY

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081965/SRR306821/SRR306821.sra
#mkdir ${pathRNAseq}/ptr_kd_F_1
#mv  SRR306821.sra  ${pathRNAseq}/ptr_kd_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081966/SRR306822/SRR306822.sra
#mkdir ${pathRNAseq}/ptr_kd_M_1
#mv  SRR306822.sra  ${pathRNAseq}/ptr_kd_M_1/RNAseq.sra


##########################################################################################LIVER
#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081967/SRR306823/SRR306823.sra
#mkdir ${pathRNAseq}/ptr_lv_F_1
#mv  SRR306823.sra  ${pathRNAseq}/ptr_lv_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081968/SRR306824/SRR306824.sra
#mkdir ${pathRNAseq}/ptr_lv_M_1
#mv  SRR306824.sra  ${pathRNAseq}/ptr_lv_M_1/RNAseq.sra


##########################################################################################TESTIS
#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081969/SRR306825/SRR306825.sra
#mkdir ${pathRNAseq}/ptr_ts_M_1
#mv  SRR306825.sra  ${pathRNAseq}/ptr_ts_M_1/RNAseq.sra

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### PPA CORTEX

##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081970/SRR306826/SRR306826.sra

##mv  SRR306826.sra  ${pathRNAseq}/ppa_br_F_1/RNAseq.sra


##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081971/SRR306827/SRR306827.sra

##mv  SRR306827.sra  ${pathRNAseq}/ppa_br_F_2/RNAseq.sra


##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081972/SRR306828/SRR306828.sra

##mv  SRR306828.sra  ${pathRNAseq}/ppa_br_M_1/RNAseq.sra


#########################################################################################CEREBELLUM

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081973/SRR306829/SRR306829.sra
#mkdir ${pathRNAseq}/ppa_cb_F_1
#mv  SRR306829.sra  ${pathRNAseq}/ppa_cb_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081974/SRR306830/SRR306830.sra
#mkdir ${pathRNAseq}/ppa_cb_M_1
#mv  SRR306830.sra  ${pathRNAseq}/ppa_cb_M_1/RNAseq.sra

##########################################################################################HEART
#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081975/SRR306831/SRR306831.sra
#mkdir ${pathRNAseq}/ppa_ht_F_1
#mv  SRR306831.sra  ${pathRNAseq}/ppa_ht_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081976/SRR306832/SRR306832.sra
#mkdir ${pathRNAseq}/ppa_ht_M_1
#mv  SRR306832.sra  ${pathRNAseq}/ppa_ht_M_1/RNAseq.sra

##########################################################################################KIDNEY

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081977/SRR306833/SRR306833.sra
#mkdir ${pathRNAseq}/ppa_kd_F_1
#mv  SRR306833.sra  ${pathRNAseq}/ppa_kd_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081978/SRR306834/SRR306834.sra
#mkdir ${pathRNAseq}/ppa_kd_M_1
#mv  SRR306834.sra  ${pathRNAseq}/ppa_kd_M_1/RNAseq.sra


##########################################################################################LIVER
#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081979/SRR306835/SRR306835.sra
#mkdir ${pathRNAseq}/ppa_lv_F_1
#mv  SRR306835.sra  ${pathRNAseq}/ppa_lv_F_1/RNAseq.sra


#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081980/SRR306836/SRR306836.sra
#mkdir ${pathRNAseq}/ppa_lv_M_1
#mv  SRR306836.sra  ${pathRNAseq}/ppa_lv_M_1/RNAseq.sra


##########################################################################################TESTIS

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081981/SRR306837/SRR306837.sra
#mkdir ${pathRNAseq}/ppa_ts_M_1
#mv  SRR306837.sra  ${pathRNAseq}/ppa_ts_M_1/RNAseq.sra


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### HSA CORTEX

##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081982/SRR306838/SRR306838.sra

##mv  SRR306838.sra  ${pathRNAseq}/hsa_br_F_1/RNAseq.sra



##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081983/SRR306839/SRR306839.sra

##mv  SRR306839.sra  ${pathRNAseq}/hsa_br_M_3/RNAseq.sra



##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081984/SRR306840/SRR306840.sra

##mv  SRR306840.sra  ${pathRNAseq}/hsa_br_M_1/RNAseq.sra



##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081985/SRR306841/SRR306841.sra

##mv  SRR306841.sra  ${pathRNAseq}/hsa_br_M_2/RNAseq.sra



##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081986/SRR306842/SRR306842.sra

##mv  SRR306842.sra  ${pathRNAseq}/hsa_br_M_4/RNAseq.sra



##wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081987/SRR306843/SRR306843.sra

##mv  SRR306843.sra  ${pathRNAseq}/hsa_br_M_5/RNAseq.sra

#########################################################################################CEREBELLUM

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081988/SRR306844/SRR306844.sra
#mkdir ${pathRNAseq}/hsa_cb_F_1
#mv  SRR306844.sra  ${pathRNAseq}/hsa_cb_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081989/SRR306845/SRR306845.sra
#mkdir ${pathRNAseq}/hsa_cb_M_1
#mv  SRR306845.sra  ${pathRNAseq}/hsa_cb_M_1/RNAseq.sra

##########################################################################################HEART

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081990/SRR306847/SRR306847.sra
#mkdir ${pathRNAseq}/hsa_ht_F_1
#mv  SRR306847.sra  ${pathRNAseq}/hsa_ht_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081991/SRR306849/SRR306849.sra
#mkdir ${pathRNAseq}/hsa_ht_M_1
#mv  SRR306849.sra  ${pathRNAseq}/hsa_ht_M_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081992/SRR306850/SRR306850.sra
#mkdir ${pathRNAseq}/hsa_ht_M_2
#mv  SRR306850.sra  ${pathRNAseq}/hsa_ht_M_2/RNAseq.sra

##########################################################################################KIDNEY

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081993/SRR306851/SRR306851.sra
#mkdir ${pathRNAseq}/hsa_kd_F_1
#mv  SRR306851.sra  ${pathRNAseq}/hsa_kd_F_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081994/SRR306852/SRR306852.sra
#mkdir ${pathRNAseq}/hsa_kd_M_1
#mv  SRR306852.sra  ${pathRNAseq}/hsa_kd_M_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081995/SRR306853/SRR306853.sra
#mkdir ${pathRNAseq}/hsa_kd_M_2
#mv  SRR306853.sra  ${pathRNAseq}/hsa_kd_M_2/RNAseq.sra

##########################################################################################LIVER

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081996/SRR306855/SRR306855.sra
#mkdir ${pathRNAseq}/hsa_lv_M_1
#mv  SRR306855.sra  ${pathRNAseq}/hsa_lv_M_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081997/SRR306856/SRR306856.sra
#mkdir ${pathRNAseq}/hsa_lv_M_2
#mv  SRR306856.sra  ${pathRNAseq}/hsa_lv_M_2/RNAseq.sra

##########################################################################################TESTIS

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081998/SRR306857/SRR306857.sra
#mkdir ${pathRNAseq}/hsa_ts_M_1
#mv  SRR306857.sra  ${pathRNAseq}/hsa_ts_M_1/RNAseq.sra

#wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081999/SRR306858/SRR306858.sra
#mkdir ${pathRNAseq}/hsa_ts_M_2
#mv  SRR306858.sra  ${pathRNAseq}/hsa_ts_M_2/RNAseq.sra