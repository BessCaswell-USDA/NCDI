//	*Zachary Gersten, PhD MPH
//	*Western Human Nutrition Research Center
//	*United States Department of Agriculture, Agricultural Research Service
//	*Description: This program merges the Best Linear Unbiased Predictors (BLUPs) of usual nutrient intakes, probability of adequacy and mean probability of adequacy estimates, and sociodemographic data into one dataset, and conducts the main analysis of fitting regression models of NCDI with the dietary variables.

//	*0. Administration
	//*	Set program specifications
		clear all
		set more off
		set varabbrev off
		set scrollbufsize 2048000
		set maxvar 32000	
		cd "C:\Users\zachary.gersten..."

//	*1. Merge NCDI, HEI-2015, MPA, and sociodemographic data together
	//*	Call in first dataset
		use ncdibhei
		
	//*	Merge with BLUPs and MPA data (A)
		merge 1:1 username using nutrBLUPsmpa
		
		rename _merge mergeA
		
	//*	Merge with sociodemographic data (B)
		merge 1:1 username using sociodemographic	
		
		rename _merge mergeB
	
	//*	Merge with usual nutrient intake data (C)
		merge 1:1 username using nutrients
		
		rename _merge mergeC
		
	//* Reorder variables
		order username userid subject_id year nrecall qcpass adfem admal oadfem oadmal race_ethnicity___1 race_ethnicity___2 race_ethnicity___3 race_ethnicity___4 race_ethnicity___5 race_ethnicity___6 race_ethnicity___7 race_ethnicity___8 race_ethnicity___9 race_ethnicity___10 race_ethnicity___11 race_ethnicity___12 other_ethnicity edu_level employment employment_other hhincome age sex bmi waistavg_cm waist_hip bin_number sleepavg_h actical_d pa_ee_total pa_ee_light pa_ee_moderate pa_ee_vigorous time_sed time_light time_mod time_vig measured_tee workactivitya activity_job workactivityc workactivityd workactivitye leisureactivityf leisureactivityg leisureactivityh leisureactivityi leisureactivityj pa_comments recall_kcalok_2 recall_kcalok_3 kcal_r2 c1_r2 c2_r2 c3_r2 c4_r2 c5_r2 c6_r2 c7_r2 c8_r2 c9_r2 c10_r2 c11_r2 c12_r2 c13_r2 hei2015_r2 kcal_r3 c1_r3 c2_r3 c3_r3 c4_r3 c5_r3 c6_r3 c7_r3 c8_r3 c9_r3 c10_r3 c11_r3 c12_r3 c13_r3 hei2015_r3 kcal c1_per c2_per c3_per c4_per c5_per c6_per c7_per c8_per c9_per c10_per c11_per c12_per c13_per hei2015_per hei2015_r2_q5 hei2015_r3_q5 hei2015_per_q5 hei2015_per10 rawNCDIscore sc_NCDIscore sc_NCDIscore_bari sc_NCDIscore_sdi sig_sc_NCDIscorei sc_NCDIscore_B rawNCDIscore_recall2 rawNCDIscore_recall3 sc_NCDIscore_recall2 sc_NCDIscore_recall3 sc_NCDIscore_recall2_q5 sc_NCDIscore_recall3_q5 sc_NCDIscore_B_q5 z_sc_NCDIscore_B calc iron magn phos zinc copp sele vara vb1 vb2 niac vb6 fola vb12 vc vitd atoc vk calc_sdi iron_sdi magn_sdi phos_sdi zinc_sdi copp_sdi sele_sdi vara_sdi vb1_sdi vb2_sdi niac_sdi vb6_sdi fola_sdi vb12_sdi vc_sdi vitd_sdi atoc_sdi vk_sdi bc_kcal_B bc_prot_B bc_tfat_B bc_carb_B bc_fibe_B bc_chole_B bc_p182_B bc_p183_B bc_calc_B bc_iron_B bc_magn_B bc_phos_B bc_zinc_B bc_copp_B bc_sele_B bc_pota_B bc_sodi_B bc_vara_B bc_bcar_B bc_acar_B bc_vb1_B bc_vb2_B bc_niac_B bc_vb6_B bc_fola_B bc_vb12_B bc_vc_B bc_vitd_B bc_atoc_B bc_vk_B pa_calc pa_iron pa_magn pa_phos pa_zinc pa_copp pa_sele pa_vara pa_vb1 pa_vb2 pa_niac pa_vb6 pa_fola pa_vb12 pa_vc pa_vitd pa_atoc mpa mpa50 mpa60 mpa70 mpa80 mpa90 mergeA mergeB mergeC
		
		drop line_n recallno ps_calc_adfem ps_calc_admal ps_calc_oadfem ps_calc_oadmal ps_iron_adfem ps_iron_admal ps_iron_oadfem ps_iron_oadmal ps_magn_adfem ps_magn_admal ps_magn_oadfem ps_magn_oadmal ps_phos_adfem ps_phos_admal ps_phos_oadfem ps_phos_oadmal ps_zinc_adfem ps_zinc_admal ps_zinc_oadfem ps_zinc_oadmal ps_copp_adfem ps_copp_admal ps_copp_oadfem ps_copp_oadmal ps_sele_adfem ps_sele_admal ps_sele_oadfem ps_sele_oadmal ps_vara_adfem ps_vara_admal ps_vara_oadfem ps_vara_oadmal ps_vb1_adfem ps_vb1_admal ps_vb1_oadfem ps_vb1_oadmal ps_vb2_adfem ps_vb2_admal ps_vb2_oadfem ps_vb2_oadmal ps_niac_adfem ps_niac_admal ps_niac_oadfem ps_niac_oadmal ps_vb6_adfem ps_vb6_admal ps_vb6_oadfem ps_vb6_oadmal ps_fola_adfem ps_fola_admal ps_fola_oadfem ps_fola_oadmal ps_vb12_adfem ps_vb12_admal ps_vb12_oadfem ps_vb12_oadmal ps_vc_adfem ps_vc_admal ps_vc_oadfem ps_vc_oadmal ps_vitd_adfem ps_vitd_admal ps_vitd_oadfem ps_vitd_oadmal ps_atoc_adfem ps_atoc_admal ps_atoc_oadfem ps_atoc_oadmal pa_iron_adfem ident
		
	//*	Save
		save "ncdibheimpasd.dta", replace


//	*2. Analyze usual nutrient intake
	//*	Box plots of usual nutrient intake
		histogram bc_kcal_B , normal
		histogram bc_prot_B , normal 
		histogram bc_tfat_B , normal
		histogram bc_carb_B , normal
		histogram bc_fibe_B , normal
		histogram bc_calc_B , normal
		histogram bc_iron_B , normal
		histogram bc_magn_B , normal
		histogram bc_phos_B , normal
		histogram bc_pota_B , normal
		histogram bc_sodi_B , normal
		histogram bc_zinc_B , normal
		histogram bc_copp_B , normal
		histogram bc_sele_B , normal
		histogram bc_vara_B , normal
		histogram bc_bcar_B , normal
		histogram bc_acar_B , normal
		histogram bc_vb1_B  , normal
		histogram bc_vb2_B  , normal
		histogram bc_niac_B , normal
		histogram bc_vb6_B  , normal
		histogram bc_fola_B , normal
		histogram bc_vb12_B , normal
		histogram bc_vc_B   , normal
		histogram bc_vitd_B , normal
		histogram bc_atoc_B , normal
		histogram bc_vk_B, normal
		histogram bc_chole_B, normal
		histogram bc_p182_B , normal
		histogram bc_p183_B , normal
		
	//* Scatterplots of usual nutrient intake and averaged NCDI scores
		graph twoway (lfitci bc_kcal_B  sc_NCDIscore_B) (scatter bc_kcal_B  sc_NCDIscore_B) /*Energy */
		graph twoway (lfitci bc_prot_B  sc_NCDIscore_B) (scatter bc_prot_B  sc_NCDIscore_B) /*Protein */
		graph twoway (lfitci bc_tfat_B  sc_NCDIscore_B) (scatter bc_tfat_B  sc_NCDIscore_B) /*Total fat*/
		graph twoway (lfitci bc_carb_B  sc_NCDIscore_B) (scatter bc_carb_B  sc_NCDIscore_B) /*Carbohydrates*/
		graph twoway (lfitci bc_fibe_B  sc_NCDIscore_B) (scatter bc_fibe_B  sc_NCDIscore_B) /*Dietary fiber*/
		graph twoway (lfitci bc_calc_B  sc_NCDIscore_B) (scatter bc_calc_B  sc_NCDIscore_B) /*Calcium*/
		graph twoway (lfitci bc_iron_B  sc_NCDIscore_B) (scatter bc_iron_B  sc_NCDIscore_B) /*Iron*/
		graph twoway (lfitci bc_magn_B  sc_NCDIscore_B) (scatter bc_magn_B  sc_NCDIscore_B) /*Magnesium*/
		graph twoway (lfitci bc_phos_B  sc_NCDIscore_B) (scatter bc_phos_B  sc_NCDIscore_B) /*Phosphorus*/
		graph twoway (lfitci bc_pota_B  sc_NCDIscore_B) (scatter bc_pota_B  sc_NCDIscore_B) /*Potassium*/
		graph twoway (lfitci bc_sodi_B  sc_NCDIscore_B) (scatter bc_sodi_B  sc_NCDIscore_B) /*Sodium*/
		graph twoway (lfitci bc_zinc_B  sc_NCDIscore_B) (scatter bc_zinc_B  sc_NCDIscore_B) /*Zinc*/
		graph twoway (lfitci bc_copp_B  sc_NCDIscore_B) (scatter bc_copp_B  sc_NCDIscore_B) /*Copper*/
		graph twoway (lfitci bc_sele_B  sc_NCDIscore_B) (scatter bc_sele_B  sc_NCDIscore_B) /*Vitamin A RAE*/
		graph twoway (lfitci bc_vara_B  sc_NCDIscore_B) (scatter bc_vara_B  sc_NCDIscore_B) /*Beta-carotene*/
		graph twoway (lfitci bc_bcar_B  sc_NCDIscore_B) (scatter bc_bcar_B  sc_NCDIscore_B) /*Alpha-carotene*/
		graph twoway (lfitci bc_acar_B  sc_NCDIscore_B) (scatter bc_acar_B  sc_NCDIscore_B) /*Vitamin E*/
		graph twoway (lfitci bc_vb1_B   sc_NCDIscore_B) (scatter bc_vb1_B   sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_vb2_B   sc_NCDIscore_B) (scatter bc_vb2_B   sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_niac_B  sc_NCDIscore_B) (scatter bc_niac_B  sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_vb6_B   sc_NCDIscore_B) (scatter bc_vb6_B   sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_fola_B  sc_NCDIscore_B) (scatter bc_fola_B  sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_vb12_B  sc_NCDIscore_B) (scatter bc_vb12_B  sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_vc_B    sc_NCDIscore_B) (scatter bc_vc_B    sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_vitd_B  sc_NCDIscore_B) (scatter bc_vitd_B  sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_atoc_B  sc_NCDIscore_B) (scatter bc_atoc_B  sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_vk_B  	sc_NCDIscore_B) (scatter bc_vk_B    sc_NCDIscore_B) /*Vitamin D*/		
		graph twoway (lfitci bc_chole_B sc_NCDIscore_B) (scatter bc_chole_B sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_p182_B  sc_NCDIscore_B) (scatter bc_p182_B  sc_NCDIscore_B) /*Vitamin D*/
		graph twoway (lfitci bc_p183_B  sc_NCDIscore_B) (scatter bc_p183_B  sc_NCDIscore_B) /*Vitamin D*/
		

//	*3. Adjust the scaled NCDI score BLUPs for energy intake		
	//* Correlations models of NCDI score BLUPs and Box-Cox transformed usual nutrient intake	
		foreach var of varlist bc_kcal_B-bc_vk_B {
			pwcorr `var' sc_NCDIscore_B, obs sig
		}
		
	
//	*4. Calculate the prevalence of nutrient adequacy
	//*	Full probability approach using usual nutrient intakes
		for var pa_calc pa_iron pa_magn pa_phos pa_zinc pa_copp pa_sele pa_vara pa_vb1 pa_vb2 pa_niac pa_vb6 pa_fola pa_vb12 pa_vc pa_vitd pa_atoc: sum X
		
	//*	Generate binary variables for whether a participant's intake was at or above the nutrient EAR	
		foreach var of varlist pa_calc-pa_atoc {
			gen `var'50 = .
			replace `var'50 = 1 if `var' >= 0.50
			replace `var'50 = 0 if `var' < 0.50
		}
		
	//*	Assess the prevalence of adequate nutrient intake, and the mean probability of of nutrient intake of 50 or 70 pct	
		foreach var of varlist pa_calc50-pa_atoc50 {
			tab `var'
		}
		
		sum mpa 

		tab mpa50
		tab mpa70
	
	//*	Draw a scatterplot of MPA and NCDI BLUPs
		graph twoway (lfitci mpa sc_NCDIscore_B) (scatter mpa sc_NCDIscore_B)
		
	//*	Calculate the Spearman correlation between MPA and the NCDI BLUP
		spearman mpa sc_NCDIscore_B
	
	//*	Box-Cox transform the MPA variable for a normal distribution
		bcskew0 bc_mpa = mpa
		
	//*	Calculate the Pearson correlation between Box-Cox transformed MPA and the NCDI BLUP
		pwcorr bc_mpa sc_NCDIscore_B, obs sig
	
	//*	Fit regression models of PA of usual nutrient intakes and NCDI BLUPs
		foreach var of varlist pa_calc pa_iron pa_magn pa_phos pa_zinc pa_copp pa_sele pa_vara pa_vb1 pa_vb2 pa_niac pa_vb6 pa_fola pa_vb12 pa_vc pa_vitd pa_atoc {
			reg `var' sc_NCDIscore_B
		}
	
	//*	Fit a regression model of the Box-Cox transformed MPA and NCDI BLUPs
		reg bc_mpa sc_NCDIscore_B
		reg bc_mpa z_sc_NCDIscore_B

	//*	Fit a regression model of the Box-Cox transformed MPA and NCDI BLUPs with usual energy intake as a covariate
		reg bc_mpa sc_NCDIscore_B bc_kcal_B
		reg bc_mpa z_sc_NCDIscore_B bc_kcal_B
		
	
//	*5. Generate PA and MPA cutoffs
	//* Logistic regression models of NCDI score and 0.50 and 0.70 MPA cut-offs
		logistic mpa50 sc_NCDIscore_B
		
		logistic mpa70 sc_NCDIscore_B
	
		
	//*	Save
		save "NCDIbheimpasd.dta", replace
		
		
//	*6. Assess the sociodemographic characteristics of the FL100 sample
	//*	Generate sociodemographic bins
		//* BMI categories
			gen bmi_under = .
			gen bmi_norm = .
			gen bmi_over = .
			gen bmi_obese = .
			gen bmi_plus = .
			
			replace bmi_under = 1 if bmi < 18.5
			replace bmi_under = 0 if bmi >= 18.5
			
			replace bmi_norm = 1 if bmi >= 18.5 & bmi < 25
			replace bmi_norm = 0 if bmi < 18.5 | bmi >= 25
	
			replace bmi_over = 1 if bmi >= 25 & bmi < 30
			replace bmi_over = 0 if bmi < 25 | bmi >= 30		
	
			replace bmi_obese = 1 if bmi >= 30 & bmi < 40
			replace bmi_obese = 0 if bmi < 30 | bmi >= 40		
			
			replace bmi_plus = 1 if bmi > 40
			replace bmi_plus = 0 if bmi <= 40
			
			gen bmi_cat = .
			
			replace bmi_cat = 1 if bmi_under == 1 | bmi_norm == 1
			replace bmi_cat = 2 if bmi_over == 1
			replace bmi_cat = 3 if bmi_obese == 1 | bmi_plus == 1
			
			
		//*	Age categories		
			gen age_low = .
			gen age_mid = .
			gen age_high = .
			gen age_plus = .
		
			replace age_low = 1 if age >= 18 & age < 34
			replace age_low = 0 if age < 18 | age >= 34
	
			replace age_mid = 1 if age >= 34 & age < 50
			replace age_mid = 0 if age < 34 | age >= 50		
	
			replace age_high = 1 if age >= 50 & age <= 65
			replace age_high = 0 if age < 50 | age > 65		
			
			replace age_plus = 1 if age > 65
			replace age_plus = 0 if age <= 65
		
			gen age_cat = .
		
			replace age_cat = 1 if age_low == 1
			replace age_cat = 2 if age_mid == 1
			replace age_cat = 3 if age_high == 1 | age_plus == 1
			
	//* Calculate proportions for the sample's sociodemographic variables, assess NCDI score BLUPs, HEI-2015 scores, and PA and MPA
		//* BMI categories
			tab bmi_cat
			
			regress sc_NCDIscore_B i.bmi_cat	/*ANOVA using regress*/
			mat list e(b)
			test 1b.bmi_cat=2.bmi_cat=3.bmi_cat /*Wald Test*/
			mean sc_NCDIscore_B, over(bmi_cat)
			estat sd
			
			regress hei2015_per i.bmi_cat	/*ANOVA using regress*/
			mat list e(b)
			test 1b.bmi_cat=2.bmi_cat=3.bmi_cat /*Wald Test*/
			mean hei2015_per, over(bmi_cat)
			estat sd
			
			regress mpa i.bmi_cat	/*ANOVA using regress*/
			mat list e(b)
			test 1b.bmi_cat=2.bmi_cat=3.bmi_cat /*Wald Test*/
			mean mpa, over(bmi_cat)
			estat sd
			
		//*	Participant sex
			tab sex
			
			regress sc_NCDIscore_B i.sex	/*ANOVA using regress*/
			mat list e(b)
			test 1b.sex=2.sex /*Wald Test*/
			mean sc_NCDIscore_B, over(sex)
			estat sd
			
			regress hei2015_per i.sex	/*ANOVA using regress*/
			mat list e(b)
			test 1b.sex=2.sex /*Wald Test*/
			mean hei2015_per, over(sex)
			estat sd
			
			regress mpa i.sex	/*ANOVA using regress*/
			mat list e(b)
			test 1b.sex=2.sex /*Wald Test*/
			mean mpa, over(sex)
			estat sd			
				
		//*	Age categories
			tab age_cat
			
			regress sc_NCDIscore_B i.age_cat	/*ANOVA using regress*/
			mat list e(b)
			test 1b.age_cat=2.age_cat=3.age_cat /*Wald Test*/
			mean sc_NCDIscore_B, over(age_cat)
			estat sd
			
			regress hei2015_per i.age_cat	/*ANOVA using regress*/
			mat list e(b)
			test 1b.age_cat=2.age_cat=3.age_cat /*Wald Test*/
			mean hei2015_per, over(age_cat)
			estat sd
			
			regress mpa i.age_cat	/*ANOVA using regress*/
			mat list e(b)
			test 1b.age_cat=2.age_cat=3.age_cat /*Wald Test*/
			mean mpa, over(age_cat)
			estat sd	


			
				twoway ///
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 1 & sc_NCDIscore_recall3_q5 == 1, mcolor(blue)) ///
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 2 & sc_NCDIscore_recall3_q5 == 2, mcolor(blue)) ///
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 3 & sc_NCDIscore_recall3_q5 == 3, mcolor(blue)) ///
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 4 & sc_NCDIscore_recall3_q5 == 4, mcolor(blue)) ///
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 5 & sc_NCDIscore_recall3_q5 == 5, mcolor(blue)) ///		
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 1 & sc_NCDIscore_recall3_q5 == 2, mcolor(midgreen)) ///
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 1 & sc_NCDIscore_recall3_q5 == 3, mcolor(red)) ///
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 1 & sc_NCDIscore_recall3_q5 == 4, mcolor(red)) ///
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 1 & sc_NCDIscore_recall3_q5 == 5, mcolor(red)) ///				
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 2 & sc_NCDIscore_recall3_q5 == 1, mcolor(midgreen)) ///
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 2 & sc_NCDIscore_recall3_q5 == 3, mcolor(midgreen)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 2 & sc_NCDIscore_recall3_q5 == 4, mcolor(red)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 2 & sc_NCDIscore_recall3_q5 == 5, mcolor(red)) ///				
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 3 & sc_NCDIscore_recall3_q5 == 1, mcolor(red)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 3 & sc_NCDIscore_recall3_q5 == 2, mcolor(midgreen)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 3 & sc_NCDIscore_recall3_q5 == 4, mcolor(midgreen)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 3 & sc_NCDIscore_recall3_q5 == 5, mcolor(red)) ///		
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 4 & sc_NCDIscore_recall3_q5 == 1, mcolor(red)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 4 & sc_NCDIscore_recall3_q5 == 2, mcolor(red)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 4 & sc_NCDIscore_recall3_q5 == 3, mcolor(midgreen)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 4 & sc_NCDIscore_recall3_q5 == 5, mcolor(midgreen)) ///				
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 5 & sc_NCDIscore_recall3_q5 == 1, mcolor(red)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 5 & sc_NCDIscore_recall3_q5 == 2, mcolor(red)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 5 & sc_NCDIscore_recall3_q5 == 3, mcolor(red)) ///	
		(scatter sc_NCDIscore_recall3 sc_NCDIscore_recall2 if sc_NCDIscore_recall2_q5 == 5 & sc_NCDIscore_recall3_q5 == 4, mcolor(midgreen)), legend(off) ///
		xtitle("NCDI score, recall 2") ///
		ytitle("NCDI score, recall 3") ///
		title("Scatter plot of NCDI scores for recalls 2 and 3, classification agreement between quintiles", size(medium)) ///
		xsize(8) ysize(8)  // Adjust xsize and ysize to set the dimensions

















	