//	*Zachary Gersten, PhD MPH
//	*Western Human Nutrition Research Center
//	*United States Department of Agriculture, Agricultural Research Service
//	*Description: This program creates a pseudo-dataset for estimating the probability of nutrient adequacy against BLUPs of usual nutrient intake

//	*0. Administration
	//*	Set program specifications
		clear all
		set more off
		set varabbrev off
		set scrollbufsize 2048000
		set maxvar 32000	
		cd "C:\Users\zachary.gersten..."

//	*1. Set scalars as parameters for generating the pseudo-dataset
	//*	Specify the scalars for EARs
		{
		//* Scalars for the EARs of adult females
			{
		/*	scalar ear_kcal_adfem	= NA	*/	 	
		/*	scalar ear_prot_adfem	= NA	*/ 	 		
		/*	scalar ear_tfat_adfem	= NA	*/		
		/*	scalar ear_carb_adfem	= NA	*/ 	 		
		/*	scalar ear_fibe_adfem	= AI	*/ 	 		
			scalar ear_calc_adfem	= 800		
			scalar ear_iron_adfem 	= 8.1	
			scalar ear_magn_adfem 	= 265	/*255 for 19-30, 265 for 31-50*/	
			scalar ear_phos_adfem 	= 580		
		/*	scalar ear_pota_adfem 	= AI	*/		
		/*	scalar ear_sodi_adfem 	= AI	*/	
			scalar ear_zinc_adfem 	= 6.8		
			scalar ear_copp_adfem 	= 0.7	
			scalar ear_sele_adfem	= 45		
			scalar ear_vara_adfem 	= 500	
		/*	scalar ear_bcar_adfem 	= 		*/
		/*	scalar ear_acar_adfem	=		*/
			scalar ear_atoc_adfem 	= 12		
			scalar ear_vitd_adfem	= 10	
			scalar ear_vc_adfem 	= 60	 		
			scalar ear_vb1_adfem	= 0.9	 		
			scalar ear_vb2_adfem 	= 0.9		
			scalar ear_niac_adfem 	= 11		
			scalar ear_vb6_adfem 	= 1.1		
			scalar ear_fola_adfem 	= 320		
			scalar ear_vb12_adfem 	= 2		
		/*	scalar ear_chole_adfem 	= AI 	*/		
		/*	scalar ear_p182_adfem 	= AI 	*/		
		/*	scalar ear_p183_adfem	= AI 	*/
			}
			
		//*	Scalars for the EARs of adult males
			{
		/*	scalar ear_kcal_admal	= NA	*/	
		/*	scalar ear_prot_admal	= NA	*/	
		/*	scalar ear_tfat_admal	= NA	*/	
		/*	scalar ear_carb_admal	= NA	*/	
		/*	scalar ear_fibe_admal	= AI	*/	
			scalar ear_calc_admal	= 800			
			scalar ear_iron_admal 	= 6		
			scalar ear_magn_admal 	= 350			
			scalar ear_phos_admal 	= 580			
		/*	scalar ear_pota_admal 	= AI	*/	
		/*	scalar ear_sodi_admal 	= AI	*/	
			scalar ear_zinc_admal 	= 9.4			
			scalar ear_copp_admal 	= 0.7		
			scalar ear_sele_admal	= 45			
			scalar ear_vara_admal 	= 625		
		/*	scalar ear_bcar_admal 	= 		*/	
		/*	scalar ear_acar_admal	=		*/	
			scalar ear_atoc_admal 	= 12			
			scalar ear_vitd_admal	= 10	
			scalar ear_vc_admal 	= 75	 	
			scalar ear_vb1_admal	= 1	 	
			scalar ear_vb2_admal 	= 1.1			
			scalar ear_niac_admal 	= 12			
			scalar ear_vb6_admal 	= 1.1			
			scalar ear_fola_admal 	= 320			
			scalar ear_vb12_admal 	= 2			
		/*	scalar ear_chole_admal 	= AI 	*/	
		/*	scalar ear_p182_admal 	= AI 	*/	
		/*	scalar ear_p183_admal	= AI 	*/	
			}
			
		//* Scalars for the EARS of older adult females
			{
		/*	scalar ear_kcal_oadfem	= NA	*/	
		/*	scalar ear_prot_oadfem	= NA	*/	
		/*	scalar ear_tfat_oadfem	= NA	*/	
		/*	scalar ear_carb_oadfem	= NA	*/	
		/*	scalar ear_fibe_oadfem	= AI	*/	
			scalar ear_calc_oadfem	= 1000			
			scalar ear_iron_oadfem 	= 8.1		
			scalar ear_magn_oadfem 	= 265			
			scalar ear_phos_oadfem 	= 580			
		/*	scalar ear_pota_oadfem 	= AI	*/	
		/*	scalar ear_sodi_oadfem 	= AI	*/	
			scalar ear_zinc_oadfem 	= 6.8			
			scalar ear_copp_oadfem 	= 0.7		
			scalar ear_sele_oadfem	= 45			
			scalar ear_vara_oadfem 	= 500		
		/*	scalar ear_bcar_oadfem 	= 		*/	
		/*	scalar ear_acar_oadfem	=		*/	
			scalar ear_atoc_oadfem 	= 12			
			scalar ear_vitd_oadfem	= 10	
			scalar ear_vc_oadfem 	= 60	 	
			scalar ear_vb1_oadfem	= 0.9	 	
			scalar ear_vb2_oadfem 	= 0.9			
			scalar ear_niac_oadfem 	= 11			
			scalar ear_vb6_oadfem 	= 1.3			
			scalar ear_fola_oadfem 	= 320			
			scalar ear_vb12_oadfem 	= 2			
		/*	scalar ear_chole_oadfem = AI 	*/	
		/*	scalar ear_p182_oadfem 	= AI 	*/	
		/*	scalar ear_p183_oadfem	= AI 	*/	
			}
		
		//* Scalars for the EARS of older adult males
			{
		/*	scalar ear_kcal_oadmal	= NA	*/	
		/*	scalar ear_prot_oadmal	= NA	*/	
		/*	scalar ear_tfat_oadmal	= NA	*/	
		/*	scalar ear_carb_oadmal	= NA	*/	
		/*	scalar ear_fibe_oadmal	= AI	*/	
			scalar ear_calc_oadmal	= 800			
			scalar ear_iron_oadmal 	= 6		
			scalar ear_magn_oadmal 	= 350			
			scalar ear_phos_oadmal 	= 580			
		/*	scalar ear_pota_oadmal 	= AI	*/	
		/*	scalar ear_sodi_oadmal 	= AI	*/	
			scalar ear_zinc_oadmal 	= 9.4			
			scalar ear_copp_oadmal 	= 0.7		
			scalar ear_sele_oadmal	= 45			
			scalar ear_vara_oadmal 	= 625		
		/*	scalar ear_bcar_oadmal 	= 		*/	
		/*	scalar ear_acar_oadmal	=		*/	
			scalar ear_atoc_oadmal 	= 12			
			scalar ear_vitd_oadmal	= 10		
			scalar ear_vc_oadmal 	= 75	 	
			scalar ear_vb1_oadmal	= 1	 	
			scalar ear_vb2_oadmal 	= 1.1			
			scalar ear_niac_oadmal 	= 12			
			scalar ear_vb6_oadmal 	= 1.4			
			scalar ear_fola_oadmal 	= 320			
			scalar ear_vb12_oadmal 	= 2			
		/*	scalar ear_chole_oadmal = AI 	*/	
		/*	scalar ear_p182_oadmal 	= AI 	*/	
		/*	scalar ear_p183_oadmal	= AI 	*/
			}
		}
			
	//*	Specify the scalars for SDs of requirement
		{
		//*	Scalars for the SDs of requirement of adult females
			{
		/*	scalar sdreq_kcal_adfem		= NA	*/	 	
		/*	scalar sdreq_prot_adfem		= NA	*/ 	 		
		/*	scalar sdreq_tfat_adfem		= NA	*/		
		/*	scalar sdreq_carb_adfem		= NA	*/ 	 		
		/*	scalar sdreq_fibe_adfem		= AI	*/ 	 		
			scalar sdreq_calc_adfem		= 100		
			scalar sdreq_iron_adfem 	= .		/*Non-normally distributed, use IOM tables*/	
			scalar sdreq_magn_adfem 	= 27.5		
			scalar sdreq_phos_adfem 	= 60		
		/*	scalar sdreq_pota_adfem 	= AI	*/		
		/*	scalar sdreq_sodi_adfem 	= AI	*/	
			scalar sdreq_zinc_adfem 	= 0.6		
			scalar sdreq_copp_adfem 	= 0.1	
			scalar sdreq_sele_adfem		= 5		
			scalar sdreq_vara_adfem 	= 100	
		/*	scalar sdreq_bcar_adfem 	= 		*/
		/*	scalar sdreq_acar_adfem		=		*/
			scalar sdreq_atoc_adfem 	= 1.5		
			scalar sdreq_vitd_adfem		= 2.5	
			scalar sdreq_vc_adfem 		= 7.5	 		
			scalar sdreq_vb1_adfem		= 0.1	 		
			scalar sdreq_vb2_adfem 		= 0.1		
			scalar sdreq_niac_adfem 	= 1.5
			scalar sdreq_vb6_adfem 		= 0.1	
			scalar sdreq_fola_adfem 	= 40		
			scalar sdreq_vb12_adfem 	= 0.2		
		/*	scalar sdreq_chole_adfem	= AI 	*/		
		/*	scalar sdreq_p182_adfem 	= AI 	*/		
		/*	scalar sdreq_p183_adfem		= AI 	*/
			}
			
		//*	Scalars for the SDs of requirement of adult males
			{
		/*	scalar sdreq_kcal_admal		= NA	*/	
		/*	scalar sdreq_prot_admal		= NA	*/	
		/*	scalar sdreq_tfat_admal		= NA	*/	
		/*	scalar sdreq_carb_admal		= NA	*/	
		/*	scalar sdreq_fibe_admal		= AI	*/	
			scalar sdreq_calc_admal		= 100			
			scalar sdreq_iron_admal 	= 1		
			scalar sdreq_magn_admal 	= 35			
			scalar sdreq_phos_admal 	= 60			
		/*	scalar sdreq_pota_admal 	= AI	*/	
		/*	scalar sdreq_sodi_admal 	= AI	*/	
			scalar sdreq_zinc_admal 	= 0.8			
			scalar sdreq_copp_admal 	= 0.1		
			scalar sdreq_sele_admal		= 5			
			scalar sdreq_vara_admal 	= 137.5		
		/*	scalar sdreq_bcar_admal 	= 		*/	
		/*	scalar sdreq_acar_admal		=		*/	
			scalar sdreq_atoc_admal 	= 1.5			
			scalar sdreq_vitd_admal		= 2.5	
			scalar sdreq_vc_admal 		= 7.5	 	
			scalar sdreq_vb1_admal		= 0.1	 	
			scalar sdreq_vb2_admal 		= 0.1			
			scalar sdreq_niac_admal 	= 2			
			scalar sdreq_vb6_admal 		= 0.1
			scalar sdreq_fola_admal 	= 40			
			scalar sdreq_vb12_admal 	= 0.2			
		/*	scalar sdreq_chole_admal 	= AI 	*/	
		/*	scalar sdreq_p182_admal 	= AI 	*/	
		/*	scalar sdreq_p183_admal		= AI 	*/	
			}
	
		//*	Scalars for the SDs of requirement of older adult females
			{
		/*	scalar sdreq_kcal_oadfem	= NA	*/	
		/*	scalar sdreq_prot_oadfem	= NA	*/	
		/*	scalar sdreq_tfat_oadfem	= NA	*/	
		/*	scalar sdreq_carb_oadfem	= NA	*/	
		/*	scalar sdreq_fibe_oadfem	= AI	*/	
			scalar sdreq_calc_oadfem	= 100			
			scalar sdreq_iron_oadfem 	= 1.5		
			scalar sdreq_magn_oadfem 	= 27.5			
			scalar sdreq_phos_oadfem 	= 60			
		/*	scalar sdreq_pota_oadfem 	= AI	*/	
		/*	scalar sdreq_sodi_oadfem 	= AI	*/	
			scalar sdreq_zinc_oadfem 	= 0.6			
			scalar sdreq_copp_oadfem 	= 0.1		
			scalar sdreq_sele_oadfem	= 5			
			scalar sdreq_vara_oadfem 	= 100		
		/*	scalar sdreq_bcar_oadfem 	= 		*/	
		/*	scalar sdreq_acar_oadfem	=		*/	
			scalar sdreq_atoc_oadfem 	= 1.5			
			scalar sdreq_vitd_oadfem	= 2.5	
			scalar sdreq_vc_oadfem 		= 7.5	 	
			scalar sdreq_vb1_oadfem		= 0.1	 	
			scalar sdreq_vb2_oadfem 	= 0.1			
			scalar sdreq_niac_oadfem 	= 1.5			
			scalar sdreq_vb6_oadfem 	= 0.1			
			scalar sdreq_fola_oadfem 	= 40			
			scalar sdreq_vb12_oadfem 	= 0.2			
		/*	scalar sdreq_chole_oadfem 	= AI 	*/	
		/*	scalar sdreq_p182_oadfem 	= AI 	*/	
		/*	scalar sdreq_p183_oadfem	= AI 	*/	
			}
			
		//*	Scalars for the SDs of requirement of older adult males
			{
		/*	scalar sdreq_kcal_oadmal	= NA	*/	
		/*	scalar sdreq_prot_oadmal	= NA	*/	
		/*	scalar sdreq_tfat_oadmal	= NA	*/	
		/*	scalar sdreq_carb_oadmal	= NA	*/	
		/*	scalar sdreq_fibe_oadmal	= AI	*/	
			scalar sdreq_calc_oadmal	= 100			
			scalar sdreq_iron_oadmal 	= 1		
			scalar sdreq_magn_oadmal 	= 35			
			scalar sdreq_phos_oadmal 	= 60			
		/*	scalar sdreq_pota_oadmal 	= AI	*/	
		/*	scalar sdreq_sodi_oadmal 	= AI	*/	
			scalar sdreq_zinc_oadmal 	= 0.8
			scalar sdreq_copp_oadmal 	= 0.1				
			scalar sdreq_sele_oadmal	= 5			
			scalar sdreq_vara_oadmal 	= 137.5		
		/*	scalar sdreq_bcar_oadmal 	= 		*/	
		/*	scalar sdreq_acar_oadmal	=		*/	
			scalar sdreq_atoc_oadmal 	= 1.5			
			scalar sdreq_vitd_oadmal	= 2.5
			scalar sdreq_vc_oadmal 		= 7.5	 	
			scalar sdreq_vb1_oadmal		= 0.1	 	
			scalar sdreq_vb2_oadmal 	= 0.1			
			scalar sdreq_niac_oadmal 	= 2			
			scalar sdreq_vb6_oadmal 	= 0.15		
			scalar sdreq_fola_oadmal 	= 40			
			scalar sdreq_vb12_oadmal 	= 0.2			
		/*	scalar sdreq_chole_oadmal 	= AI 	*/	
		/*	scalar sdreq_p182_oadmal 	= AI 	*/	
		/*	scalar sdreq_p183_oadmal	= AI 	*/
			}
		}		
					
		
//	*2. Generate the pseudo-data for nutrient intake
	//*	Set the number of observations
		set obs 4000
		
	//*	Generate identifier variable
		gen ident = _n
		
	//*	Generate the pseudo-data using the EARs and SDs of requirement
		{
		gen ps_calc_adfem  = abs(rnormal(ear_calc_adfem, sdreq_calc_adfem))
		gen ps_calc_admal  = abs(rnormal(ear_calc_admal,  sdreq_calc_admal))
		gen ps_calc_oadfem = abs(rnormal(ear_calc_oadfem, sdreq_calc_oadfem))
		gen ps_calc_oadmal = abs(rnormal(ear_calc_oadmal, sdreq_calc_oadmal))
 
		gen ps_iron_adfem  = .
		gen ps_iron_admal  = abs(rnormal(ear_iron_admal,  sdreq_iron_admal))
		gen ps_iron_oadfem = abs(rnormal(ear_iron_oadfem, sdreq_iron_oadfem))
		gen ps_iron_oadmal = abs(rnormal(ear_iron_oadmal, sdreq_iron_oadmal))
		
		gen ps_magn_adfem  = abs(rnormal(ear_magn_adfem,  sdreq_magn_adfem))
		gen ps_magn_admal  = abs(rnormal(ear_magn_admal,  sdreq_magn_admal))
		gen ps_magn_oadfem = abs(rnormal(ear_magn_oadfem, sdreq_magn_oadfem))
		gen ps_magn_oadmal = abs(rnormal(ear_magn_oadmal, sdreq_magn_oadmal))
 
		gen ps_phos_adfem  = abs(rnormal(ear_phos_adfem,  sdreq_phos_adfem))
		gen ps_phos_admal  = abs(rnormal(ear_phos_admal,  sdreq_phos_admal))
		gen ps_phos_oadfem = abs(rnormal(ear_phos_oadfem, sdreq_phos_oadfem))
		gen ps_phos_oadmal = abs(rnormal(ear_phos_oadmal, sdreq_phos_oadmal))
			
		gen ps_copp_adfem  = abs(rnormal(ear_copp_adfem,  sdreq_copp_adfem))
		gen ps_copp_admal  = abs(rnormal(ear_copp_admal,  sdreq_copp_admal))
		gen ps_copp_oadfem = abs(rnormal(ear_copp_oadfem, sdreq_copp_oadfem))
		gen ps_copp_oadmal = abs(rnormal(ear_copp_oadmal, sdreq_copp_oadmal))
		
		gen ps_zinc_adfem  = abs(rnormal(ear_zinc_adfem,  sdreq_zinc_adfem))
		gen ps_zinc_admal  = abs(rnormal(ear_zinc_admal,  sdreq_zinc_admal))
		gen ps_zinc_oadfem = abs(rnormal(ear_zinc_oadfem, sdreq_zinc_oadfem))
		gen ps_zinc_oadmal = abs(rnormal(ear_zinc_oadmal, sdreq_zinc_oadmal))
		
		gen ps_sele_adfem  = abs(rnormal(ear_sele_adfem,  sdreq_sele_adfem))
		gen ps_sele_admal  = abs(rnormal(ear_sele_admal,  sdreq_sele_admal))
		gen ps_sele_oadfem = abs(rnormal(ear_sele_oadfem, sdreq_sele_oadfem))
		gen ps_sele_oadmal = abs(rnormal(ear_sele_oadmal, sdreq_sele_oadmal))
		
		gen ps_vara_adfem  = abs(rnormal(ear_vara_adfem,  sdreq_vara_adfem))
		gen ps_vara_admal  = abs(rnormal(ear_vara_admal,  sdreq_vara_admal))
		gen ps_vara_oadfem = abs(rnormal(ear_vara_oadfem, sdreq_vara_oadfem))
		gen ps_vara_oadmal = abs(rnormal(ear_vara_oadmal, sdreq_vara_oadmal))		
		
		gen ps_vb1_adfem  = abs(rnormal(ear_vb1_adfem,  sdreq_vb1_adfem))
		gen ps_vb1_admal  = abs(rnormal(ear_vb1_admal,  sdreq_vb1_admal))
		gen ps_vb1_oadfem = abs(rnormal(ear_vb1_oadfem, sdreq_vb1_oadfem))
		gen ps_vb1_oadmal = abs(rnormal(ear_vb1_oadmal, sdreq_vb1_oadmal))
 
		gen ps_vb2_adfem  = abs(rnormal(ear_vb2_adfem,  sdreq_vb2_adfem))
		gen ps_vb2_admal  = abs(rnormal(ear_vb2_admal,  sdreq_vb2_admal))
		gen ps_vb2_oadfem = abs(rnormal(ear_vb2_oadfem, sdreq_vb2_oadfem))
		gen ps_vb2_oadmal = abs(rnormal(ear_vb2_oadmal, sdreq_vb2_oadmal))			
			
		gen ps_niac_adfem  = abs(rnormal(ear_niac_adfem,  sdreq_niac_adfem))
		gen ps_niac_admal  = abs(rnormal(ear_niac_admal,  sdreq_niac_admal))
		gen ps_niac_oadfem = abs(rnormal(ear_niac_oadfem, sdreq_niac_oadfem))
		gen ps_niac_oadmal = abs(rnormal(ear_niac_oadmal, sdreq_niac_oadmal))
 
		gen ps_vb6_adfem  = abs(rnormal(ear_vb6_adfem,  sdreq_vb6_adfem))
		gen ps_vb6_admal  = abs(rnormal(ear_vb6_admal,  sdreq_vb6_admal))
		gen ps_vb6_oadfem = abs(rnormal(ear_vb6_oadfem, sdreq_vb6_oadfem))
		gen ps_vb6_oadmal = abs(rnormal(ear_vb6_oadmal, sdreq_vb6_oadmal))
		
		gen ps_fola_adfem  = abs(rnormal(ear_fola_adfem,  sdreq_fola_adfem))
		gen ps_fola_admal  = abs(rnormal(ear_fola_admal,  sdreq_fola_admal))
		gen ps_fola_oadfem = abs(rnormal(ear_fola_oadfem, sdreq_fola_oadfem))
		gen ps_fola_oadmal = abs(rnormal(ear_fola_oadmal, sdreq_fola_oadmal))
 
		gen ps_vc_adfem  = abs(rnormal(ear_vc_adfem,  sdreq_vc_adfem))
		gen ps_vc_admal  = abs(rnormal(ear_vc_admal,  sdreq_vc_admal))
		gen ps_vc_oadfem = abs(rnormal(ear_vc_oadfem, sdreq_vc_oadfem))
		gen ps_vc_oadmal = abs(rnormal(ear_vc_oadmal, sdreq_vc_oadmal))
			
		gen ps_vitd_adfem  = abs(rnormal(ear_vitd_adfem,  sdreq_vitd_adfem))
		gen ps_vitd_admal  = abs(rnormal(ear_vitd_admal,  sdreq_vitd_admal))
		gen ps_vitd_oadfem = abs(rnormal(ear_vitd_oadfem, sdreq_vitd_oadfem))
		gen ps_vitd_oadmal = abs(rnormal(ear_vitd_oadmal, sdreq_vitd_oadmal))
 
		gen ps_atoc_adfem  = abs(rnormal(ear_atoc_adfem,  sdreq_atoc_adfem))
		gen ps_atoc_admal  = abs(rnormal(ear_atoc_admal,  sdreq_atoc_admal))
		gen ps_atoc_oadfem = abs(rnormal(ear_atoc_oadfem, sdreq_atoc_oadfem))
		gen ps_atoc_oadmal = abs(rnormal(ear_atoc_oadmal, sdreq_atoc_oadmal))
		
		gen ps_vb12_adfem  = abs(rnormal(ear_vb12_adfem,  sdreq_vb12_adfem))
		gen ps_vb12_admal  = abs(rnormal(ear_vb12_admal,  sdreq_vb12_admal))
		gen ps_vb12_oadfem = abs(rnormal(ear_vb12_oadfem, sdreq_vb12_oadfem))
		gen ps_vb12_oadmal = abs(rnormal(ear_vb12_oadmal, sdreq_vb12_oadmal))
		}
		
		foreach var of varlist ps_calc_adfem-ps_vb12_oadmal {
			sum `var', detail
		}
		
		foreach var of varlist ps_calc_adfem-ps_vb12_oadmal {
		swilk `var'
		scalar `var'_p = r(p)
		}
			
		foreach var of varlist ps_calc_adfem-ps_vb12_oadmal {
		list ident `var' if `var' <= 0
		}
		
		scalar list
			
	//* Save
		save "pseudodata.dta", replace
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
		
			