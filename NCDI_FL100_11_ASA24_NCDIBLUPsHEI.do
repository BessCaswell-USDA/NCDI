//	*Zachary Gersten, PhD MPH
//	*Western Human Nutrition Research Center
//	*United States Department of Agriculture, Agricultural Research Service
//	*Description: This program assesses relationships between the NCDI BLUPs and HEI-2015 scores

//	*0. Administration
	//*	Set program specifications
		clear all
		set more off
		set varabbrev off
		set scrollbufsize 2048000
		set maxvar 32000	
		cd "C:\Users\zachary.gersten..."

//	*1. Merge the NCDI and HEI-2015 scores
	//*	Call in the HEI-2015 scores
		use NCDI_FL100_HEIscores
		
		rename UserName username
		rename UserID userid
		
	//*	Merge with the NCDI scores
		merge 1:1 userid using ncdiBLUPs
		
		drop if _merge == 1
		
		drop _merge
		
	//*	Save
		save "ncdibhei.dta", replace

//	*2. Estimate relationships between the scaled NCDI BLUPs and HEI-2015 scores
	//* Call in dataset
		use ncdibhei
		
	//* Scatterplot that displays classification agreement between NCDI and HEI-2015 score quintiles
		twoway ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 1 & hei2015_per_q5 == 1, mcolor(blue)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 2 & hei2015_per_q5 == 2, mcolor(blue)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 3 & hei2015_per_q5 == 3, mcolor(blue)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 4 & hei2015_per_q5 == 4, mcolor(blue)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 5 & hei2015_per_q5 == 5, mcolor(blue)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 1 & hei2015_per_q5 == 2, mcolor(midgreen)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 1 & hei2015_per_q5 == 3, mcolor(red)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 1 & hei2015_per_q5 == 4, mcolor(red)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 1 & hei2015_per_q5 == 5, mcolor(red)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 2 & hei2015_per_q5 == 1, mcolor(midgreen)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 2 & hei2015_per_q5 == 3, mcolor(midgreen)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 2 & hei2015_per_q5 == 4, mcolor(red)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 2 & hei2015_per_q5 == 5, mcolor(red)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 3 & hei2015_per_q5 == 1, mcolor(red)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 3 & hei2015_per_q5 == 2, mcolor(midgreen)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 3 & hei2015_per_q5 == 4, mcolor(midgreen)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 3 & hei2015_per_q5 == 5, mcolor(red)) ///
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 4 & hei2015_per_q5 == 1, mcolor(red)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 4 & hei2015_per_q5 == 2, mcolor(red)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 4 & hei2015_per_q5 == 3, mcolor(midgreen)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 4 & hei2015_per_q5 == 5, mcolor(midgreen)) ///		
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 5 & hei2015_per_q5 == 1, mcolor(red)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 5 & hei2015_per_q5 == 2, mcolor(red)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 5 & hei2015_per_q5 == 3, mcolor(red)) ///	
		(scatter hei2015_per sc_NCDIscore_B if sc_NCDIscore_B_q5 == 5 & hei2015_per_q5 == 4, mcolor(midgreen)), legend(off) ///
		xtitle("NCDI Score, BLUP") ///
		ytitle("HEI-2015 score, by person") ///
		title("Scatter plot of BLUP of NCDI scores and HEI-2015 scores, classification agreement between quintiles", size(medium)) ///
		xsize(8) ysize(8)  // Adjust xsize and ysize to set the dimensions

			
	//*	Scatterplot that displays the best fit line between NCDI and HEI-2015 score with confidence intervals
		graph twoway (lfitci hei2015_per sc_NCDIscore_B) (scatter hei2015_per sc_NCDIscore_B)

	//*	Linear regression of the scaled NCDI BLUP z-scores and the HEI-2015 scores
		egen z_sc_NCDIscore_B = std(sc_NCDIscore_B)
		order z_sc_NCDIscore_B, after(sc_NCDIscore_B_q5)
	
		reg sc_NCDIscore_B hei2015_per
		reg z_sc_NCDIscore_B hei2015_per
		
		reg sc_NCDIscore_B hei2015_per10
		reg z_sc_NCDIscore_B hei2015_per10
		
		
	//*	Linear regression of the scaled NCDI BLUP z-scores and all the individual HEI components
		reg sc_NCDIscore_B c1_per-c13_per
		reg z_sc_NCDIscore_B c1_per-c13_per
		
		
	//* Linear regressions of the scaled NCDI BLUP z-scores and HEI scores minus one HEI component (e.g, Leave-one-out approach)
		foreach var of varlist c1_per-c13_per{
			gen hei2015_per_minus_`var' = hei2015_per - `var'
		}
		
		foreach var of varlist c1_per-c13_per{
			reg sc_NCDIscore_B hei2015_per_minus_`var' `var'
		}

	
//	*3. Generate data visualizations for simple correlations between energy intake and NCDI and HEI-2015 scores
	//*	NCDI scores
		//*	Recall 2
			graph twoway (lfitci kcal_r2 sc_NCDIscore_recall2) (scatter kcal_r2 sc_NCDIscore_recall2)
			
			reg kcal_r2_100 sc_NCDIscore_recall2 
		
		//*	Recall 3
			graph twoway (lfitci kcal_r3 sc_NCDIscore_recall3) (scatter kcal_r3 sc_NCDIscore_recall3)
			
			reg kcal_r3_100 sc_NCDIscore_recall3 	

	
	//*	HEI_2015 scores
		//*	Recall 2
			graph twoway (lfitci kcal_r2 hei2015_r2) (scatter kcal_r2 hei2015_r2)
			
			reg kcal_r2_100 hei2015_r2
		
		//*	Recall 3
			graph twoway (lfitci kcal_r3 hei2015_r3) (scatter kcal_r3 hei2015_r3)
			
			reg kcal_r3_100	hei2015_r3
		
			

//	*4. Analyze classification agreement between NCDI and HEI-2015 quintiles
	//*	Create a table comparing NCDI BLUP and HEI-2015 quintiles
		tab hei2015_per_q5 sc_NCDIscore_B_q5
		
	//*	Mean HEI-2015 per person score by NCDI quintiles
		regress hei2015_per i.sc_NCDIscore_B_q5	/*ANOVA using regress*/
		mat list e(b)
		test 1b.sc_NCDIscore_B_q5=2.sc_NCDIscore_B_q5=3.sc_NCDIscore_B_q5=4.sc_NCDIscore_B_q5=5.sc_NCDIscore_B_q5 /*Wald Test*/
		mean hei2015_per, over(sc_NCDIscore_B_q5)
		estat sd
		
	//*	Mean NCDI score by HEI-2015 per person quintile
		regress sc_NCDIscore_B_q5 i.hei2015_per_q5	/*ANOVA using regress*/
		mat list e(b)
		test 1b.hei2015_per_q5=2.hei2015_per_q5=3.hei2015_per_q5=4.hei2015_per_q5=5.hei2015_per_q5 /*Wald Test*/
		mean sc_NCDIscore_B_q5, over(hei2015_per_q5)
		estat sd
				

//	*5. Assess correlations between NCDI scores and HEI-2015 components
	//*	Call in dataset
		use ncdibhei
	
	//* Average, scaled NCDI score and each HEI-2015 component, per person
		graph twoway (lfitci c1_per  sc_NCDIscore_B) (scatter c1_per  sc_NCDIscore_B)
		graph twoway (lfitci c2_per  sc_NCDIscore_B) (scatter c2_per  sc_NCDIscore_B)
		graph twoway (lfitci c3_per  sc_NCDIscore_B) (scatter c3_per  sc_NCDIscore_B)
		graph twoway (lfitci c4_per  sc_NCDIscore_B) (scatter c4_per  sc_NCDIscore_B)
		graph twoway (lfitci c5_per  sc_NCDIscore_B) (scatter c5_per  sc_NCDIscore_B)
		graph twoway (lfitci c6_per  sc_NCDIscore_B) (scatter c6_per  sc_NCDIscore_B)
		graph twoway (lfitci c7_per  sc_NCDIscore_B) (scatter c7_per  sc_NCDIscore_B)
		graph twoway (lfitci c8_per  sc_NCDIscore_B) (scatter c8_per  sc_NCDIscore_B)
		graph twoway (lfitci c9_per  sc_NCDIscore_B) (scatter c9_per  sc_NCDIscore_B)
		graph twoway (lfitci c10_per sc_NCDIscore_B) (scatter c10_per sc_NCDIscore_B)
		graph twoway (lfitci c11_per sc_NCDIscore_B) (scatter c11_per sc_NCDIscore_B)
		graph twoway (lfitci c12_per sc_NCDIscore_B) (scatter c12_per sc_NCDIscore_B)
		graph twoway (lfitci c13_per sc_NCDIscore_B) (scatter c13_per sc_NCDIscore_B)

		reg sc_NCDIscore_B hei2015_per
				
		foreach var of varlist c1_per-c13_per{
			reg sc_NCDIscore_B hei2015_per `var'
		}
		
	//*	Save
		save "ncdibhei_leaveoneout.dta", replace	
		
		
