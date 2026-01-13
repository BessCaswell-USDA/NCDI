//	*Zachary Gersten, PhD MPH
//	*Western Human Nutrition Research Center
//	*United States Department of Agriculture, Agricultural Research Service
//	*Description: This program imports the raw NDI scores generated using the R script and vegan package, and merges the raw NDI scores into one dataset, then calculates the Best Linear Unbiased Predictor to represent usual NDI scores

//	*0. Administration
	//*	Set program specifications
		clear all
		set more off
		set varabbrev off
		set scrollbufsize 2048000
		set maxvar 32000	
		cd "C:\Users\zachary.gersten..."
		
		
//	*1. Clean NDI scores for recalls 2 and 3		
	//*	Save recalls 2 and 3 as Stata files
		import delimited "C:\Users\zachary.gersten...rawNDIscorerecall2.csv"

		rename v1 userid
		rename x rawNDIscore_recall2
	
		save "FL100_rawNDIscore_recall2.dta", replace
		
		clear all
		set more off
		set varabbrev off
		set scrollbufsize 2048000
		set maxvar 32000
		
		import delimited "C:\Users\zachary.gersten...rawNDIscorerecall3.csv"
		
		rename v1 userid
		rename x rawNDIscore_recall3
		
		save "FL100_rawNDIscore_recall3.dta", replace
			
	//*Join the raw NDI scores for recalls 2 and 3
		clear all
		set more off
		set varabbrev off
		set scrollbufsize 2048000
		set maxvar 32000	
		
		use FL100_rawNDIscore_recall2
		
		append using FL100_rawNDIscore_recall3
		
		gen recallno = 2 if rawNDIscore_recall2 != .
		replace recallno = 3 if rawNDIscore_recall3 != .
		
		gen rawNDIscore = rawNDIscore_recall2 if recallno == 2
		replace rawNDIscore = rawNDIscore_recall3 if recallno == 3
		
		drop rawNDIscore_recall2 rawNDIscore_recall3
		
		order userid recallno rawNDIscore
		
	//*	Drop individuals who did not pass the quality check
		gen qcpass = 0
		
		replace qcpass = 1 if userid == ...

		drop if qcpass == 0


//	*2. Calculate scaled NDI scores
	//* Set scalar for total NDI score
		scalar totalNDIscore = XXX.XX /*Replace with total NDI score generated from R script vegan package*/
		
	//* Calculate scaled NDI scores
		gen sc_NDIscore = (rawNDIscore / totalNDIscore) * 100
		
	//*	Save
		save "ndi_clean.dta", replace
		

//	*3. Prepare NDI scores for usual intake analysis
	//* Check for missing values and drop observations
		gen missing = .
		
		replace missing = 1 if sc_NDIscore == .	
		
		drop if missing == 1
		
		drop missing
		
	//*	Check for missing values
		for var sc_NDIscore: assert X != .
			
		
//	*4. Calculate mean of scaled NDI score	
	//* Calculate the intra-individual mean of NDI scores
		bysort userid: egen sc_NDIscore_bari = mean(sc_NDIscore)
		
	//*	Calculate the grand mean of scaled NDI scores
		sum sc_NDIscore_bari if recallno == 2, meanonly
		scalar sc_NDIscore_bar = r(mean)
			

//	*5. Calculate standard deviations of scaled NDI scores
	//* Calculate the intra-individual SDs of the scaled NDI scores
		bysort userid: egen sc_NDIscore_sdi = sd(sc_NDIscore)
		
	//*	Calculate the square of the intra-individual SDs
		gen sig_sc_NDIscorei = sc_NDIscore_sdi^2
		
	//*	Calculate the mean of squared intra-individual SDs for participants with two recalls only by saving the square intra-individual SDs (squared is the variance)
		sum sig_sc_NDIscorei, meanonly
		scalar sig_sc_NDIscorew = r(mean)
	
	
//	*6. Calculate inter-individual variances of scaled NDI scores
	//*	Calculate the inter-indvidual variance of scaled NDI scores	
		sum sc_NDIscore_bari if recallno == 2
		scalar sig_sc_NDIscorey = r(Var)
	

	//* Calculate the number of recalls for each participant
		bysort userid: egen nrecall = count(recallno)
		

//	*7. Compute BLUPs for scaled NDI scores
	//* Use scalars to calculate the BLUPs
		gen sc_NDIscore_B = scalar(sc_NDIscore_bar) + sqrt(sig_sc_NDIscorey / (sig_sc_NDIscorey + (sig_sc_NDIscorew / nrecall)))* (sc_NDIscore_bari - scalar(sc_NDIscore_bar))
		
	//*	Drop duplicate observations
		bysort userid: gen line_n = _n
		
		drop if line_n == 2
		
		drop line_n qcpass
		
		order userid recallno nrecall rawNDIscore sc_NDIscore sc_NDIscore_bari sc_NDIscore_sdi sig_sc_NDIscorei sc_NDIscore_B
	
	//*	Save
		save "ndiBLUPs.dta", replace


//	*8. Created merged dataset for NDI scores for recalls 2 and 3
	//*	Call in dataset
		clear all
		set more off
		set varabbrev off
		set scrollbufsize 2048000
		set maxvar 32000	
		
		use FL100_rawNDIscore_recall2
		
	//*	Merge with the NDI scores for recall 3
		merge 1:1 userid using FL100_rawNDIscore_recall3
		
		drop _merge
		
	//* Set scalar for total NDI score
		scalar totalNDIscore = 5093.098
		
	//* Calculate scaled NDI scores
		gen sc_NDIscore_recall2 = (rawNDIscore_recall2 / totalNDIscore) * 100
		gen sc_NDIscore_recall3 = (rawNDIscore_recall3 / totalNDIscore) * 100
	
	//*	Save
		save "FL100_rawNDIscore_recalls.dta", replace
	
		
//	*8. Calculate scaled NDI score quintiles
	//*	Call in cleaned dataset
		use ndiBLUPs
		
	//*	Merge NDI scores for recalls 2 and 3
		merge 1:1 userid using FL100_rawNDIscore_recalls
		
		drop if _merge == 2
		
		drop _merge
		
	//* Calculate quintiles for recalls 2 and 3 and the average	
		xtile sc_NDIscore_recall2_q5 = sc_NDIscore_recall2, nq(5)
		xtile sc_NDIscore_recall3_q5 = sc_NDIscore_recall3, nq(5)
		xtile sc_NDIscore_B_q5 = sc_NDIscore_B, nq(5)
		
	//*	Save
		save "ndiBLUPs.dta", replace
		

//	*3. Generate data visualizations
	//* Scatterplot, classification agreement in NDI score quintiles
		twoway ///
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 1 & sc_NDIscore_recall3_q5 == 1, mcolor(blue)) ///
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 2 & sc_NDIscore_recall3_q5 == 2, mcolor(blue)) ///
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 3 & sc_NDIscore_recall3_q5 == 3, mcolor(blue)) ///
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 4 & sc_NDIscore_recall3_q5 == 4, mcolor(blue)) ///
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 5 & sc_NDIscore_recall3_q5 == 5, mcolor(blue)) ///		
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 1 & sc_NDIscore_recall3_q5 == 2, mcolor(midgreen)) ///
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 1 & sc_NDIscore_recall3_q5 == 3, mcolor(red)) ///
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 1 & sc_NDIscore_recall3_q5 == 4, mcolor(red)) ///
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 1 & sc_NDIscore_recall3_q5 == 5, mcolor(red)) ///				
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 2 & sc_NDIscore_recall3_q5 == 1, mcolor(midgreen)) ///
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 2 & sc_NDIscore_recall3_q5 == 3, mcolor(midgreen)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 2 & sc_NDIscore_recall3_q5 == 4, mcolor(red)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 2 & sc_NDIscore_recall3_q5 == 5, mcolor(red)) ///				
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 3 & sc_NDIscore_recall3_q5 == 1, mcolor(red)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 3 & sc_NDIscore_recall3_q5 == 2, mcolor(midgreen)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 3 & sc_NDIscore_recall3_q5 == 4, mcolor(midgreen)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 3 & sc_NDIscore_recall3_q5 == 5, mcolor(red)) ///		
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 4 & sc_NDIscore_recall3_q5 == 1, mcolor(red)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 4 & sc_NDIscore_recall3_q5 == 2, mcolor(red)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 4 & sc_NDIscore_recall3_q5 == 3, mcolor(midgreen)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 4 & sc_NDIscore_recall3_q5 == 5, mcolor(midgreen)) ///				
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 5 & sc_NDIscore_recall3_q5 == 1, mcolor(red)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 5 & sc_NDIscore_recall3_q5 == 2, mcolor(red)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 5 & sc_NDIscore_recall3_q5 == 3, mcolor(red)) ///	
		(scatter sc_NDIscore_recall3 sc_NDIscore_recall2 if sc_NDIscore_recall2_q5 == 5 & sc_NDIscore_recall3_q5 == 4, mcolor(midgreen)), legend(off) ///
		xtitle("NDI score, recall 2") ///
		ytitle("NDI score, recall 3") ///
		title("Scatter plot of NDI scores for recalls 2 and 3, classification agreement between quintiles", size(medium)) ///
		xsize(8) ysize(8)  // Adjust xsize and ysize to set the dimensions
		
	//*	Side-by-side histograms of scaled NDI scores by recalls
		twoway (hist sc_NDIscore_recall2, frac lcolor(gs12) fcolor(gs12)) (hist sc_NDIscore_recall3, frac fcolor(none) lcolor(black)), legend(off) title("Histogram of NDI scores (grey: recall 2; black: recall 3)")
	
	
	//*	Violin plots of scaled NDI scores by recalls
		violinplot sc_NDIscore_recall2 sc_NDIscore_recall3 sc_NDIscore_B, pdf(ll(0)) fill vertical
		
		graph box sc_NDIscore_recall2 sc_NDIscore_recall3 sc_NDIscore_B

	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	