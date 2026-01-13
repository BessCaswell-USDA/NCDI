//	*Zachary Gersten, PhD MPH
//	*Western Human Nutrition Research Center
//	*United States Department of Agriculture, Agricultural Research Service
//	*Description: This program estimates the Best Linear Unbiased Predictors of usual nutrient intakes from the transformed dietary data, assesses the probability of adequate intakes and the mean probability of adequacy, and merges those data with the NCDI and HEI-2015 scores

//	*0. Administration
	//*	Set program specifications
		clear all
		set more off
		set varabbrev off
		set scrollbufsize 2048000
		set maxvar 32000	
		cd "C:\Users\zachary.gersten..."

//	*1. Prepare nutrient intake data for analysis
	//*	Call in dataset
		use nutrients2014
		
		append using nutrients2016, force
		
		drop recallattempt recallstatus intakestartdatetime intakeenddatetime reportingdate lang numfoods numcodes amtusual salttype saltfreq saltused mois alc caff theo sugr fa ff fdfe ret cryp lyco lz sfat s040 s060 s080 s100 s120 s140 s160 s180 mfat m161 m181 m201 m221 pfat p184 p204 p205 p225 p226 choln vite_add b12_add f_citmlb f_other f_juice f_total v_drkgr v_redor_tomato v_redor_other v_redor_total v_starchy_potato v_starchy_other v_starchy_total v_other v_total v_legumes g_whole g_refined g_total pf_meat pf_curedmeat pf_organ pf_poult pf_seafd_hi pf_seafd_low pf_mps_total pf_eggs pf_soy pf_nutsds pf_legumes pf_total d_milk d_yogurt d_cheese d_total oils solid_fats add_sugars a_drinks datacomp modified
		
	//* Check for missing values and drop observations
		gen missing = .
		
		foreach var of varlist recallno-vitd {
			replace missing = 1 if `var' == .
		}
		
		drop if missing == 1
		
		drop missing
		
	//*	
		gen qcpass = 0
		
		replace qcpass = 1 if userid == "..."
		
		drop if qcpass == 0
		
	//*	Check for missing values
		for var recallno kcal prot tfat carb fibe calc iron magn phos pota sodi zinc copp sele vc vb1 vb2 niac vb6 fola vb12 vara bcar acar atoc vk chole p182 p183 vitd: assert X != .
		
	//*	Add incremental value to nutrient intakes for Box-Cox transformation, which requires all positive data
		foreach var of varlist kcal-vitd {
			replace `var' = `var' + 0.00001
		}
		

//*	2. Box-Cox transformations of nutrient intakes to a normal distribution
	//*	Box-Cox transformations
		foreach var of varlist kcal-vitd	{
			
			/*Generates new variable with Box-Cox transformation*/
			bcskew0 bc_`var' = `var'
			
			/*Shows names used by Stata for scalars*/
			return list
			
			/*Saves the value of Lambda in memory as a scalar*/
			scalar lbc_`var' = r(lambda)
		}
	
	//*	List transformation parameters Lambda
		foreach var of varlist kcal-vitd	{
			scalar list lbc_`var'
		}


//*	3. Calculate means of transformed nutrient intake variables
	//*	Calculate the intra-individual means of Box-Cox transformed nutrient intake
		foreach var of varlist kcal-vitd	{
			bysort userid: egen bc_`var'_bari = mean(bc_`var')
		}		
		
	//*	Calculate the grand mean of transformed nutrient intake variables
		foreach var of varlist kcal-vitd	{
			sum bc_`var'_bari if recallno == 2, meanonly
			scalar bc_`var'_bar = r(mean)
		}		 
		

//*	4. Calculate standard deviations of the nutrient intake variables
	//*	Calculate intra-individual SDs of the original, untransformed variables
		foreach var of varlist kcal-vitd {
			bysort userid: egen `var'_sdi = sd(`var')
		}
		
	//*	Calculate SDs and intra-individual variances of transformed variables
		foreach var of varlist kcal-vitd {
			
			/*Intra-individual variance of nutrient intake*/
			bysort userid: egen tmp0 = sd(bc_`var')
			
			/*Generate intra-individual standard deviations (SDs), as a temporary variable for participants with only one observation (Round 1), the SD cannot be calculated and the temporary variable has missing values*/
			gen sig_bc_`var'i = tmp0^2
			
			/*Generate the square of the intra-individual SDs*/
			sum sig_bc_`var'i, meanonly
			
			/*Calculate the mean of squared intra-individual SDs for participants with two recalls only by saving the mean of squared intra-individual SDs (squared is the variance)*/
			scalar sig_bc_`var'w = r(mean)
			
			/*Drop the temporary variable*/
			drop tmp0
		}
		

//*	5. Calculate inter-individual variances of transformed variables
	//*	Calculate the inter-individual variance of nutrient intake
		foreach var of varlist kcal-vitd	{
			sum bc_`var'_bari if recallno == 2
			scalar sig_bc_`var'y = r(Var)
		}
		
		
//*	6. Count the number of recalls for each individual participant
	//* Calculate the number of recalls
		bysort userid: egen nrecall = count(recallno)
		

//*	7. Compute BLUPs for nutrient intakes
	//*	Use scalars to calculate the BLUPs
		foreach var of varlist kcal-vitd	{
			gen bc_`var'_B = scalar(bc_`var'_bar) + sqrt(sig_bc_`var'y / (sig_bc_`var'y + (sig_bc_`var'w / nrecall)))* (bc_`var'_bari - scalar(bc_`var'_bar))
		}			
		
	//* Save
		save "nutrBLUPs.dta", replace
		
//*	8. Merge nutrient intake and socidodemographic data
	//* Merge using username
		joinby username using sociodemographic
	
	//*	Create age and sex identifiers
		gen adfem = .
		replace adfem = 1 if age <= 50 & sex == 2
		replace adfem = 0 if age > 50 | sex == 1
		
		gen admal = .
		replace admal = 1 if age <= 50 & sex == 1
		replace admal = 0 if age > 50 | sex == 2	
		
		gen oadfem = .
		replace oadfem = 1 if age > 50 & sex == 2
		replace oadfem = 0 if age <= 50 | sex == 1	
		
		gen oadmal = .
		replace oadmal = 1 if age > 50 & sex == 1
		replace oadmal = 0 if age <= 50 | sex == 2
		
		gen agesexcat = 1 if adfem == 1 | admal == 1 | oadfem == 1 | oadmal == 1
		
	//*	Save
		save "nutrBLUPs.dta", replace
		
		
//*	9. Compute probability of iron intake adequacy for adult women
	//*	Generate placeholder variables for probability of adequacy
		foreach var of varlist calc iron magn phos zinc copp sele vara vb1 vb2 niac vb6 fola vb12 vc vitd atoc {
			gen pa_`var' = .
		}
		
	//* Use requirement distribution tables for iron for adult women, Box-Cox transform cutoffs
		gen pa_iron_adfem = .

		replace pa_iron_adfem = 0.00 if bc_iron_B < (((4.88001^lbc_iron) - 1) / lbc_iron) & adfem == 1		
		
		replace pa_iron_adfem = 0.05 if bc_iron_B >= (((4.88001^lbc_iron) - 1) / lbc_iron) & bc_iron_B < (((5.45001^lbc_iron) - 1) / lbc_iron) & adfem == 1
		
		replace pa_iron_adfem = 0.10 if bc_iron_B >= (((5.45001^lbc_iron) - 1) / lbc_iron) & bc_iron_B < (((6.55001^lbc_iron) - 1) / lbc_iron) & adfem == 1
		
		replace pa_iron_adfem = 0.25 if bc_iron_B >= (((6.55001^lbc_iron) - 1) / lbc_iron) & bc_iron_B < (((8.06001^lbc_iron) - 1) / lbc_iron) & adfem == 1
		
		replace pa_iron_adfem = 0.50 if bc_iron_B >= (((8.06001^lbc_iron) - 1) / lbc_iron) & bc_iron_B < (((10.17001^lbc_iron) - 1) / lbc_iron) & adfem == 1
		
		replace pa_iron_adfem = 0.75 if bc_iron_B >= (((10.17001^lbc_iron) - 1) / lbc_iron) & bc_iron_B < (((13.05001^lbc_iron) - 1) / lbc_iron) & adfem == 1
		
		replace pa_iron_adfem = 0.90 if bc_iron_B >= (((13.05001^lbc_iron) - 1) / lbc_iron) & bc_iron_B < (((14.83001^lbc_iron) - 1) / lbc_iron) & adfem == 1
		
		replace pa_iron_adfem = 0.95 if bc_iron_B >= (((14.83001^lbc_iron) - 1) / lbc_iron) & bc_iron_B < (((17.5001^lbc_iron) - 1) / lbc_iron) & adfem == 1

		replace pa_iron_adfem = 1.00 if bc_iron_B > (((17.50001^lbc_iron) - 1) / lbc_iron) & adfem == 1

		
//*	10. Merge in randomly generated values of requirement distributions that are based on the EAR and SD of requirement
	//*	Set matrix size
		set matsize 800
		
	//*	Keep the BLUPs and other variables needed for generating PAs and SDs, reorder
		keep username userid recallno kcal-vitd *sdi *B adfem-oadmal pa*
		
		drop kcal prot tfat carb fibe pota sodi bcar acar chole p182 p183 kcal_sdi prot_sdi tfat_sdi carb_sdi fibe_sdi pota_sdi sodi_sdi bcar_sdi acar_sdi chole_sdi p182_sdi p183_sdi bc_kcal_B bc_prot_B bc_tfat_B bc_carb_B bc_fibe_B bc_pota_B bc_sodi_B bc_bcar_B bc_acar_B bc_chole_B bc_p182_B bc_p183_B pa_ee_total pa_ee_light pa_ee_moderate pa_ee_vigorous pa_comments
		
		order username userid recallno adfem admal oadfem oadmal calc iron magn phos zinc copp sele vara vb1 vb2 niac vb6 fola vb12 vc vitd atoc calc_sdi iron_sdi magn_sdi phos_sdi zinc_sdi copp_sdi sele_sdi vara_sdi vb1_sdi vb2_sdi niac_sdi vb6_sdi fola_sdi vb12_sdi vc_sdi vitd_sdi atoc_sdi bc_calc_B bc_iron_B bc_magn_B bc_phos_B bc_zinc_B bc_copp_B bc_sele_B bc_vara_B bc_vb1_B bc_vb2_B bc_niac_B bc_vb6_B bc_fola_B bc_vb12_B bc_vc_B bc_vitd_B bc_atoc_B pa_calc pa_iron pa_magn pa_phos pa_zinc pa_copp pa_sele pa_vara pa_vb1 pa_vb2 pa_niac pa_vb6 pa_fola pa_vb12 pa_vc pa_vitd pa_atoc
		
	//*	Generate identifier and merge in random values
		gen ident = _n
		
		sort ident
		
	//*	Merge random values
		merge 1:m ident using pseudodata
		
	//*	Drop identifier and merge
		drop _merge
		
	//* Reorder variables
		order username userid recallno adfem admal oadfem oadmal calc iron magn phos zinc copp sele vara vb1 vb2 niac vb6 fola vb12 vc vitd atoc calc_sdi iron_sdi magn_sdi phos_sdi zinc_sdi copp_sdi sele_sdi vara_sdi vb1_sdi vb2_sdi niac_sdi vb6_sdi fola_sdi vb12_sdi vc_sdi vitd_sdi atoc_sdi bc_calc_B bc_iron_B bc_magn_B bc_phos_B bc_zinc_B bc_copp_B bc_sele_B bc_vara_B bc_vb1_B bc_vb2_B bc_niac_B bc_vb6_B bc_fola_B bc_vb12_B bc_vc_B bc_vitd_B bc_atoc_B pa_calc pa_iron pa_magn pa_phos pa_zinc pa_copp pa_sele pa_vara pa_vb1 pa_vb2 pa_niac pa_vb6 pa_fola pa_vb12 pa_vc pa_vitd pa_atoc ps_calc_adfem ps_calc_admal ps_calc_oadfem ps_calc_oadmal ps_iron_adfem ps_iron_admal ps_iron_oadfem ps_iron_oadmal ps_magn_adfem ps_magn_admal ps_magn_oadfem ps_magn_oadmal ps_phos_adfem ps_phos_admal ps_phos_oadfem ps_phos_oadmal ps_zinc_adfem ps_zinc_admal ps_zinc_oadfem ps_zinc_oadmal ps_copp_adfem ps_copp_admal ps_copp_oadfem ps_copp_oadmal ps_sele_adfem ps_sele_admal ps_sele_oadfem ps_sele_oadmal ps_vara_adfem ps_vara_admal ps_vara_oadfem ps_vara_oadmal ps_vb1_adfem ps_vb1_admal ps_vb1_oadfem ps_vb1_oadmal ps_vb2_adfem ps_vb2_admal ps_vb2_oadfem ps_vb2_oadmal ps_niac_adfem ps_niac_admal ps_niac_oadfem ps_niac_oadmal ps_vb6_adfem ps_vb6_admal ps_vb6_oadfem ps_vb6_oadmal ps_fola_adfem ps_fola_admal ps_fola_oadfem ps_fola_oadmal ps_vb12_adfem ps_vb12_admal ps_vb12_oadfem ps_vb12_oadmal ps_vc_adfem ps_vc_admal ps_vc_oadfem ps_vc_oadmal ps_vitd_adfem ps_vitd_admal ps_vitd_oadfem ps_vitd_oadmal ps_atoc_adfem ps_atoc_admal ps_atoc_oadfem ps_atoc_oadmal 
		
	
//*	11. Box-Cox transform the pseudodata of requirement distributions
	//*	Add incremental value to pseudodata
		foreach var of varlist ps_calc_adfem-ps_atoc_oadmal {
			replace `var' = `var' + 0.00001
		}
		
	//* Box-Cox transform the pseuodata of requirement distributions
		foreach var of varlist calc iron magn phos zinc copp sele vara vb1 vb2 niac vb6 fola vb12 vc vitd atoc {
			gen bc_ps_`var'_adfem = ((ps_`var'_adfem^lbc_`var') - 1)/lbc_`var' 
			gen bc_ps_`var'_admal = ((ps_`var'_admal^lbc_`var') - 1)/lbc_`var' 
			gen bc_ps_`var'_oadfem = ((ps_`var'_oadfem^lbc_`var') - 1)/lbc_`var' 
			gen bc_ps_`var'_oadmal = ((ps_`var'_oadmal^lbc_`var') - 1)/lbc_`var' 
		}
	

//*	12. Create matrices with transformed pseudodata of requirement distributions
	//*	Create matrix to store the adult female pseudodata
		mkmat bc_ps_calc_adfem bc_ps_iron_adfem bc_ps_magn_adfem bc_ps_phos_adfem bc_ps_zinc_adfem bc_ps_copp_adfem bc_ps_sele_adfem bc_ps_vara_adfem bc_ps_vb1_adfem bc_ps_vb2_adfem bc_ps_niac_adfem bc_ps_vb6_adfem bc_ps_fola_adfem bc_ps_vb12_adfem bc_ps_vc_adfem bc_ps_vitd_adfem bc_ps_atoc_adfem, matrix(bc_ps_adfem)
	
	//*	Create matrix to store the adult male pseudodata
		mkmat bc_ps_calc_admal bc_ps_iron_admal bc_ps_magn_admal bc_ps_phos_admal bc_ps_zinc_admal bc_ps_copp_admal bc_ps_sele_admal bc_ps_vara_admal bc_ps_vb1_admal bc_ps_vb2_admal bc_ps_niac_admal bc_ps_vb6_admal bc_ps_fola_admal bc_ps_vb12_admal bc_ps_vc_admal bc_ps_vitd_admal bc_ps_atoc_admal, matrix(bc_ps_admal)
		
	//*	Create matrix to store the older adult female pseudodata
		mkmat bc_ps_calc_oadfem bc_ps_iron_oadfem bc_ps_magn_oadfem bc_ps_phos_oadfem bc_ps_zinc_oadfem bc_ps_copp_oadfem bc_ps_sele_oadfem bc_ps_vara_oadfem bc_ps_vb1_oadfem bc_ps_vb2_oadfem bc_ps_niac_oadfem bc_ps_vb6_oadfem bc_ps_fola_oadfem bc_ps_vb12_oadfem bc_ps_vc_oadfem bc_ps_vitd_oadfem bc_ps_atoc_oadfem, matrix(bc_ps_oadfem)		
	
	//*	Create matrix to store the older adult male pseudodata
		mkmat bc_ps_calc_oadmal bc_ps_iron_oadmal bc_ps_magn_oadmal bc_ps_phos_oadmal bc_ps_zinc_oadmal bc_ps_copp_oadmal bc_ps_sele_oadmal bc_ps_vara_oadmal bc_ps_vb1_oadmal bc_ps_vb2_oadmal bc_ps_niac_oadmal bc_ps_vb6_oadmal bc_ps_fola_oadmal bc_ps_vb12_oadmal bc_ps_vc_oadmal bc_ps_vitd_oadmal bc_ps_atoc_oadmal, matrix(bc_ps_oadmal)
		
	//*	Drop the transformed pseudodata of requirement distributions
		drop bc_ps_calc_adfem-bc_ps_atoc_oadmal
		
	//*	Drop extraneous observations
		drop if username == ""
		
		keep if recallno == 2
		
	//*	Save number of observations in local macro
		count
		local nobs = r(N)
		

//* 13.	Create matrices with BLUPs and probability of adequacy variables to be filled
	//*	Create matrix for BLUPs
		mkmat bc_calc_B-bc_atoc_B, matrix(blup)
		
	//*	Create matrix for probability of adequacy variables
		mkmat pa_calc-pa_atoc, matrix(pa)
		
	//*	Drop probability of adequacy variables, since they will be extracted later
		drop pa_calc pa_iron pa_magn pa_phos pa_zinc pa_copp pa_sele pa_vara pa_vb1 pa_vb2 pa_niac pa_vb6 pa_fola pa_vb12 pa_vc pa_vitd pa_atoc
		
//* 14. Calculate the probability of adequacy using random values
	//*	Nested loops to calculate PAs for 17 micronutrients
		capture noisily forval j = 1/17 {
			
		//*Create loop for number of observations in the dataset, counter is "i"
			capture noisily forval i = 1/`nobs' {
				
			//* Create matrix "ind" with 10000 rows and 1 column, missing values*/
				capture noisily matrix ind = J(4000, 1, .)
				
			//* Create loop for 10000 random values, counter is "k"
				capture noisily forval k = 1/4000 {
				
				//*	Fill matrix ind for each nutrient and participant
					//* For adult females
						if adfem[`i'] == 1 {
							
						//* If the BLUP of nutrient j in observation i is GREATER THAN OR EQUAL TO the pseuodata value k for nutrient j...
							if blup[`i',`j'] >= bc_ps_adfem[`k',`j'] {
								* if BLUP of nutrient "j" in observation "i"
								* >= random value "k" for nutrient "j":
								matrix ind[`k',1] = 1 
							}
							
						//* If the BLUP of nutrient j in observation i is LESS THAN the pseuodata value k for nutrient j...
							if (blup[`i',`j'] < bc_ps_adfem[`k',`j']) {
								
								//* Then, the value of matrix "ind" in row  is set to 0
									matrix ind[`k', 1] = 0
							}	
						}
						
					//* For adult males
						if admal[`i'] == 1 {
							
						//* If the BLUP of nutrient j in observation i is GREATER THAN OR EQUAL TO the pseuodata value k for nutrient j...
							if blup[`i',`j'] >= bc_ps_admal[`k',`j'] {
								* if BLUP of nutrient "j" in observation "i"
								* >= random value "k" for nutrient "j":
								matrix ind[`k',1] = 1 
							}
							
						//* If the BLUP of nutrient j in observation i is LESS THAN the pseuodata value k for nutrient j...
							if (blup[`i',`j'] < bc_ps_admal[`k',`j']) {
								
								//* Then, the value of matrix "ind" in row  is set to 0
									matrix ind[`k', 1] = 0
							}	
						}
						
					//* For older adult females
						if oadfem[`i'] == 1 {
							
						//* If the BLUP of nutrient j in observation i is GREATER THAN OR EQUAL TO the pseuodata value k for nutrient j...
							if blup[`i',`j'] >= bc_ps_oadfem[`k',`j'] {
								* if BLUP of nutrient "j" in observation "i"
								* >= random value "k" for nutrient "j":
								matrix ind[`k',1] = 1 
							}
							
						//* If the BLUP of nutrient j in observation i is LESS THAN the pseuodata value k for nutrient j...
							if (blup[`i',`j'] < bc_ps_oadfem[`k',`j']) {
								
								//* Then, the value of matrix "ind" in row  is set to 0
									matrix ind[`k', 1] = 0
							}	
						}
						
					//* For older adult males
						if oadmal[`i'] == 1 {
							
						//* If the BLUP of nutrient j in observation i is GREATER THAN OR EQUAL TO the pseuodata value k for nutrient j...
							if blup[`i',`j'] >= bc_ps_oadmal[`k',`j'] {
								* if BLUP of nutrient "j" in observation "i"
								* >= random value "k" for nutrient "j":
								matrix ind[`k',1] = 1 
							}
							
						//* If the BLUP of nutrient j in observation i is LESS THAN the pseuodata value k for nutrient j...
							if (blup[`i',`j'] < bc_ps_oadmal[`k',`j']) {
								
								//* Then, the value of matrix "ind" in row  is set to 0
									matrix ind[`k', 1] = 0
							}	
						}						
				}
				
			//*	Calculate PA for each nutrient and each participant
				//* Convert matrix "ind" to a variable in the dataset
					svmat ind
				
				//*	For the participant in observation i and the nutrient j, the mean of the variable ind1 is the probability of adequacy, i.e., the proportion of random values in the requirement distribution that are less than or equal to the participant's usual intake
					sum ind1, meanonly
					
			//*	Fill in the PA results matrix
				matrix pa[`i', `j'] = r(mean)
				
				drop ind1
			}
		}
						
						
//* 15.	Obtain the probabilities of adequacy as variables
	//*	Convert the matrix columnst to variables
		svmat pa, name(col)
		
		drop if userid == ""
		
	//*	Replace missing values for the PA of iron for adult women
		replace pa_iron = pa_iron_adfem if adfem == 1
		

//*	16. Calculate the mean probability of adequacy and binary MPA variables
	//*	Calculate the mean probability of adequacy
		gen mpa = (pa_calc + pa_iron + pa_magn + pa_phos + pa_zinc + pa_copp + pa_sele + pa_vara + pa_vb1 + pa_vb2 + pa_niac + pa_vb6 + pa_fola + pa_vb12 + pa_vc + pa_vitd + pa_atoc) / 17
	
	//* Calculate binary MPA variables
		gen mpa50 = (mpa >= 0.50) if mpa != .
		gen mpa60 = (mpa >= 0.60) if mpa != .
		gen mpa70 = (mpa >= 0.70) if mpa != .
		gen mpa80 = (mpa >= 0.80) if mpa != .
		gen mpa90 = (mpa >= 0.90) if mpa != .
		
	//* Save
		save "nutrBLUPsmpa.dta", replace		
		