#!/bin/bash
#PBS -N oe_gemma_mv_lmm
#PBS -l select=1:ncpus=1:mem=5gb,walltime=2:00:00
#PBS -j oe

echo "START ------------------------------"

src=/panicle/ssapkot/git_repo/StarchProtein


#/panicle/bin/gemma -bfile $src/SAP_v3 -bslmm 1 -w 5000000 -s 20000000 -wpace 500000 -n 1 -o "SAP_HM_GrainColor.$chain"
#/panicle/bin/gemma -bfile $src/SAP_v3 -bslmm 1 -w 5000000 -s 20000000 -wpace 500000 -n 2 -o "SAP_HM_DON2014.$chain"
#/panicle/bin/gemma -bfile $src/SAP_v3 -bslmm 1 -w 5000000 -s 20000000 -wpace 500000 -n 3 -o "SAP_HM_headMold14.$chain"
#/panicle/bin/gemma -bfile $src/SAP_v3 -bslmm 1 -w 5000000 -s 20000000 -wpace 500000 -n 4 -o "SAP_HM_headMold15.$chain"
#/panicle/bin/gemma -bfile $src/SAP_v3 -bslmm 1 -w 5000000 -s 20000000 -wpace 500000 -n 5 -o "SAP_HM_headMold16.$chain"
/panicle/bin/gemma -bfile $src/data/SAP_GS_SNPs -d $src/data/SAP_EigenValues.txt -u $src/data/SAP_EigenVectors.txt -c $src/data/SAP_TGW.txt -maf 0.05 -lmm 4 -n 1 2 -o "/SAP_GS_maf0.05_MV-SP_covTGW"

echo "FINISH ----------------------------"

