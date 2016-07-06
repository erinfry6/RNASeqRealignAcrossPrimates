#################################################################################

export pathResults=../../data/ensembl_ortho

echo "homology members"

mysql -h ensembldb.ensembl.org -u anonymous -P 5306 ensembl_compara_84 --execute="select gene_member.stable_id, homology_member.homology_id from gene_member, homology_member, homology where homology_member.gene_member_id=gene_member.gene_member_id and homology.homology_id=homology_member.homology_id and homology.description=\"ortholog_one2one\";" > ${pathResults}/homology_members_one2one_ensembl84.txt

echo "homology ids"

mysql -h ensembldb.ensembl.org -u anonymous -P 5306 ensembl_compara_84 --execute="select homology_id from homology where description=\"ortholog_one2one\"" > ${pathResults}/homology_id_one2one_ensembl84.txt

#################################################################################
