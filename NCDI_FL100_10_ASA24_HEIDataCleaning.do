//	*Zachary Gersten, PhD MPH
//	*Western Human Nutrition Research Center
//	*United States Department of Agriculture, Agricultural Research Service
//	*Description: This program creates quintiles of HEI-2015 scores and data visualizations

//	*0. Administration
	//*	Set program specifications
		clear all
		set more off
		set varabbrev off
		set scrollbufsize 2048000
		set maxvar 32000	
		cd "C:\Users\zachary.gersten..."


//	*1. Calculate HEI-2015 scores quintiles
	//*	Call in the HEI-2015 scores
		use NCDI_FL100_HEIscores
		
	//* Calculate quintiles for recalls 2 and 3 and the per person score	
		xtile hei2015_r2_q5 = hei2015_r2, nq(5)
		xtile hei2015_r3_q5 = hei2015_r3, nq(5)
		xtile hei2015_per_q5 = hei2015_per, nq(5)

	//*	Save
		save "NCDI_FL100_HEIscores.dta", replace

//	*2. Generate data visualizations
	//* Scatterplot
		twoway ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 1 & hei2015_r3_q5 == 1, mcolor(blue)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 2 & hei2015_r3_q5 == 2, mcolor(blue)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 3 & hei2015_r3_q5 == 3, mcolor(blue)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 4 & hei2015_r3_q5 == 4, mcolor(blue)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 5 & hei2015_r3_q5 == 5, mcolor(blue)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 1 & hei2015_r3_q5 == 2, mcolor(midgreen)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 1 & hei2015_r3_q5 == 3, mcolor(red)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 1 & hei2015_r3_q5 == 4, mcolor(red)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 1 & hei2015_r3_q5 == 5, mcolor(red)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 2 & hei2015_r3_q5 == 1, mcolor(midgreen)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 2 & hei2015_r3_q5 == 3, mcolor(midgreen)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 2 & hei2015_r3_q5 == 4, mcolor(red)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 2 & hei2015_r3_q5 == 5, mcolor(red)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 3 & hei2015_r3_q5 == 1, mcolor(red)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 3 & hei2015_r3_q5 == 2, mcolor(midgreen)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 3 & hei2015_r3_q5 == 4, mcolor(midgreen)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 3 & hei2015_r3_q5 == 5, mcolor(red)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 4 & hei2015_r3_q5 == 1, mcolor(red)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 4 & hei2015_r3_q5 == 2, mcolor(red)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 4 & hei2015_r3_q5 == 3, mcolor(midgreen)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 4 & hei2015_r3_q5 == 5, mcolor(midgreen)) ///
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 5 & hei2015_r3_q5 == 1, mcolor(red)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 5 & hei2015_r3_q5 == 2, mcolor(red)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 5 & hei2015_r3_q5 == 3, mcolor(red)) ///	
		(scatter hei2015_r3 hei2015_r2 if hei2015_r2_q5 == 5 & hei2015_r3_q5 == 4, mcolor(midgreen)), legend(off) ///
		xtitle("HEI-2015 score, recall 2") ///
		ytitle("HEI-2015 score, recall 3") ///
		title("Scatter plot of HEI-2015 scores for recalls 2 and 3, classification agreement between quintiles", size(medium)) ///
		xsize(8) ysize(8)  // Adjust xsize and ysize to set the dimensions
		
	//*	Histograms
		twoway (hist hei2015_r2, frac lcolor(gs12) fcolor(gs12)) (hist hei2015_r3, frac fcolor(none) lcolor(black)), legend(off) title("Histogram of HEI-2015 scores (grey: recall 2; black: recall 3)")
	
	
	//*	Violin plots
		violinplot hei2015_r2 hei2015_r3 hei2015_per, pdf(ll(0)) fill vertical
	
		graph box hei2015_r2 hei2015_r3 hei2015_per
	
		

	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	