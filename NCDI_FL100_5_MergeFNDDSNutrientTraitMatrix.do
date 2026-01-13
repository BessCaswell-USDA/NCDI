//	*Zachary Gersten, PhD MPH
//	*Western Human Nutrition Research Center
//	*United States Department of Agriculture, Agricultural Research Service
//	*Description: Merge ingredient disaggregated datasets for FNDDS 4.1 and FNDDS 2011-2012, replace missing nutrient information with FNDDS 2013-2014, standardize nutrient data, and extract the nutrient trait matrix

//	*0. Administration
		clear all
		set more off
		set varabbrev off

//	*1. Create data frames
		frame create FNDDS_merged_missing /*Missing frame is for foods and ingredients with missing nutrient data*/
		frame create FNDDS_merged_complete
		frame create FNDDS_4
	
		frame FNDDS_merged_missing {
			cd "C:\Users\zachary.gersten..."
		}
		
		frame FNDDS_merged_complete {
			cd "C:\Users\zachary.gersten..."
		}		
		
		frame FNDDS_2014 {
			cd "C:\Users\zachary.gersten..."
		}	
	
	
//	*2. Prepare ingredient disaggregated FNDDS 2011-2012 and merge with the ingredient disaggregated FNDDS 4.1
		//*	Change to FNDDS_merged_missing
		frame FNDDS_merged_missing {
			
			//* Call in the dataset
				use FNDDS2012_ingredientizednutrval
				
			//* Drop nutrients that do not match with the FNDDS4.1 ingredientized food composition table
				drop menaquinone4 dhphylquinone unsatfat18_1n7
				
			//* Append the FNDDS4.1 food composition table
				append using FNDDS4_ingredientizednutrval
				
			//* Mark unique ingredients across FNDDS versions and drop the repeating ingredients
				bysort ingredientcode fnddsversion: gen line_n = _n
				order line_n, before(fnddsversion)		
				keep if line_n == 1
				drop line_n
				
			//* Drop nutrients that will not be used for the NCDI food-nutrient matrix
				drop ash starch sucrose glucose fructose lactose maltose alcohol water proteinadj caffeine theobromine energykj totsugar galactose fluoride manganese vitaiu retinol vitd2 vitd3 vitd2d3 betacrypto lycopene lutzea betatoc gammatoc deltatoc pantoacid totcholine folicacid foodfolate folatedfe betaine tryptophan threonine isoleucine leucine lysine methionine cystine phenylalanine tyrosine valine arginine histidine alanine aspartic glutamic glycine proline serine hydroxyproline viteadded vitb12added tottransfat totsatfat satfat4_0 satfat6_0 satfat8_0 satfat10_0 satfat12_0 satfat14_0 satfat16_0 satfat18_0 satfat20_0 unsatfat18_1 unsatfat20_4 unsatfat22_6n3 satfat22_0 unsatfat14_1 unsatfat16_1 unsatfat18_4 unsatfat20_1 unsatfat20_5n3 unsatfat22_1 unsatfat22_5n3 phytosterols stigmasterol campesterol betasitosterol totmonofat totpolyfat satfat15_0 satfat17_0 satfat24_0 unsatfat16_1t unsatfat18_1t unsatfat22_1t unsatfat18_2t unsatfat18_2i unsatfat18_2tt unsatfat18_2cla unsatfat24_1c unsatfat20_2n6 unsatfat16_1c unsatfat18_1c unsatfat18_2n6 unsatfat22_1c unsatfat18_3n6 unsatfat17_1 unsatfat20_3 tottransmonoenoic tottranspolyenoic satfat13_0 unsatfat15_1 unsatfat18_3n3 unsatfat20_3n3 unsatfat20_3n6 unsatfat20_4n6 unsatfat18_3i unsatfat21_5 unsatfat22_4
			
			//*	Identify ingredients that have missing nutrient information
				gen missingnutrient = 0
			
				foreach var of varlist protein-unsatfat18_3 {
					replace missingnutrient = 1 if `var' == .
				}
				
				order missingnutrient, before(fnddsversion)
			
			//*	Keep only ingredients with missing nutrients
				keep if missingnutrient == 1
				
				drop missingnutrient
				
			//*	Sort FNDDS_merged by identifier
				sort ingredientcode
			
			//*We identified these ingredients as missing nutrient information. We replaced FNDDS 4.1 and FNDDS 2011-2012 ingredient codes with missing nutrients with the nutrient information from comparable foods from FNDDS 2013-14. 
				replace ingredientcode = 14041 if ingredientcode == 14039 /*Beverages, CYTOSPORT, Muscle Milk light,  Ready-To-Drink*/
				replace ingredientcode = 14636 if ingredientcode == 14042 /*Beverages, fortified low calorie fruit juice beverage*/
				replace ingredientcode = 14041 if ingredientcode == 14043 /*Beverages, NESTLE, CARNATION BREAKFAST ESSENTIALS , nutritional drink, ready-to-drink, Rich milk chocolate flavor, no sugar added*/
				replace ingredientcode = 14636 if ingredientcode == 14652 /*Fruit-flavored drink, dry powder, low calorie, with high vitamin C*/
				replace ingredientcode = 21138 if ingredientcode == 21136 /*Fast foods, potato, french fried, in beef tallow*/
				replace ingredientcode = 23327 if ingredientcode == 23324 /*Beef, round, top round steak, boneless, separable lean and fat, trimmed to 0" fat, all grades, raw*/
				replace ingredientcode = 23360 if ingredientcode == 23351 /*Beef, round, eye of round steak, boneless, separable lean and fat, trimmed to 0" fat, all grades, cooked, grilled*/
				replace ingredientcode = 23360 if ingredientcode == 23381 /*Beef, round, eye of round steak, boneless, separable lean only, trimmed to 0" fat, all grades, cooked, grilled*/
				replace ingredientcode = 19026 if ingredientcode == 25042 /*Formulated bar, GENERAL MILLS FIBERONE FULFILL, chocolate peanut butter*/
				replace ingredientcode = 19015 if ingredientcode == 25044 /*Formulated bar, fortified, specific glycemic index formulation**/
				replace ingredientcode = 19026 if ingredientcode == 25047 /*Formulated bar, meal replacement, minimally fortified, chocolate peanut butter*/
				replace ingredientcode = 25055 if ingredientcode == 25049 /*Formulated bar, high protein, minimally fortified, cranberry almond*/
				replace ingredientcode = 25051 if ingredientcode == 42102 /*Meal replacement bar*/
				replace ingredientcode = 14654 if ingredientcode == 42156 /*Meal replacement, protein type, milk- and soy-based, powdered, not reconstituted*/
				replace ingredientcode = 14654 if ingredientcode == 42191 /*Nutrient supplement, milk-based, chocolate, high protein, powdered, not reconstituted*/
				replace ingredientcode = 14654 if ingredientcode == 42223 /*Meal replacement, high protein, milk based, fruit juice mixable formula, powder, not reconstituted*/
				replace ingredientcode = 14654 if ingredientcode == 43115 /*Protein powder*/
				replace ingredientcode = 14654 if ingredientcode == 43116 /*Protein supplement*/
				replace ingredientcode = 14654 if ingredientcode == 43118 /*Protein powder, diet with soy and casein*/
				replace ingredientcode = 14654 if ingredientcode == 43120 /*Protein supplement, high protein bar, candy-like, soy and milkbase*/
				replace ingredientcode = 14654 if ingredientcode == 43121 /*Meal replacement or supplement, liquid high protein*/
				replace ingredientcode = 14041 if ingredientcode == 43207 /*Meal replacement, protein type, milk base, powdered*/
				replace ingredientcode = 14143 if ingredientcode == 43262 /*Beverage, chocolate, diet, liquid, canned*/
				replace ingredientcode = 14148 if ingredientcode == 43264 /*Beverage, high calorie, reconstituted or canned*/
				replace ingredientcode = 14654 if ingredientcode == 43265 /*Nutrient supplement, milk base, high protein, liquid*/
				replace ingredientcode = 14654 if ingredientcode == 43266 /*Protein supplement, milk base, powdered*/
				replace ingredientcode = 14654 if ingredientcode == 43291 /*Nutrient supplement, milk base, powder*/
				replace ingredientcode = 14654 if ingredientcode == 43399 /*Meal replacement, liquid, soy-based*/
				replace ingredientcode = 1164  if ingredientcode == 99994 /*Cheese sauce used for commercial food products*/
			
			//* Save
				save FNDDS_merged_missing, replace
			}
		

//	*2. Replace ingredients with missing nutrient information with data from the 2013-2014 FNDDS
		//*	Change to FNDDS_2014
			frame FNDDS_2014 {
		
			//*	Call in the dataset
				use FNDDS2014_ingredientizednutrval_missing
				
			//* Sort by identifier
				sort ingredientcode
			}
		
		//*	Change to FNDDS_merged
			frame FNDDS_merged_missing {
			
			//* Mark unique ingredients across FNDDS versions and drop the repeating ingredients
				bysort ingredientcode: gen line_n = _n
				order line_n, before(fnddsversion)		
				keep if line_n == 1
				drop line_n
				
				drop ingredientdesc protein totlipid carbohydratedf energykcal totdietfiber calcium iron magnesium phosphorus potassium sodium zinc copper selenium vitarae betacarotene alphacarotene vite vitd vitc thiamin riboflavin niacin vitb6 totfolate vitb12 vitk cholesterol unsatfat18_2 unsatfat18_3
				
			//*	Replace missing nutrient data found in the 2013-2014 ingredientized FNDDS
				joinby ingredientcode using FNDDS2014_ingredientizednutrval_missing, unmatched(master) _merge(newv)
	
				drop fnddsversion
				rename newv fnddsversion
				replace fnddsversion = 2014 if fnddsversion == 3
				replace fnddsversion = 0 if fnddsversion == 1
				
				order fnddsversion, before(parentfoodcode)
				
			//*	Change back ingredient codes
				replace ingredientcode = 14039 if ingredientcode == 14041
				replace ingredientcode = 14042 if ingredientcode == 14636
				replace ingredientcode = 14043 if ingredientcode == 14041
				replace ingredientcode = 14652 if ingredientcode == 14636
				replace ingredientcode = 21136 if ingredientcode == 21138
				replace ingredientcode = 23324 if ingredientcode == 23327
				replace ingredientcode = 23351 if ingredientcode == 23360
				replace ingredientcode = 23381 if ingredientcode == 23360
				replace ingredientcode = 25042 if ingredientcode == 19026
				replace ingredientcode = 25044 if ingredientcode == 19015
				replace ingredientcode = 25047 if ingredientcode == 19026
				replace ingredientcode = 25049 if ingredientcode == 25055
				replace ingredientcode = 42102 if ingredientcode == 25051
				replace ingredientcode = 42156 if ingredientcode == 14654
				replace ingredientcode = 42191 if ingredientcode == 14654
				replace ingredientcode = 42223 if ingredientcode == 14654
				replace ingredientcode = 43115 if ingredientcode == 14654
				replace ingredientcode = 43116 if ingredientcode == 14654
				replace ingredientcode = 43118 if ingredientcode == 14654
				replace ingredientcode = 43120 if ingredientcode == 14654
				replace ingredientcode = 43121 if ingredientcode == 14654
				replace ingredientcode = 43207 if ingredientcode == 14041
				replace ingredientcode = 43262 if ingredientcode == 14143
				replace ingredientcode = 43264 if ingredientcode == 14148
				replace ingredientcode = 43265 if ingredientcode == 14654
				replace ingredientcode = 43266 if ingredientcode == 14654
				replace ingredientcode = 43291 if ingredientcode == 14654
				replace ingredientcode = 43399 if ingredientcode == 14654
				replace ingredientcode = 99994 if ingredientcode == 1164 		
		
			//* Save
				save FNDDS_merged_missing, replace
			}


//	*3. Fill in replacement ingredients 
		//*	Change to FNDDS_merged_complete
			frame FNDDS_merged_complete {
			
			//* Call in the dataset
				use FNDDS2012_ingredientizednutrval
				
			//* Drop nutrients that do not match with the FNDDS4.1 ingredientized food composition table
				drop menaquinone4 dhphylquinone unsatfat18_1n7
				
			//* Append the FNDDS4.1 food composition table
				append using FNDDS4_ingredientizednutrval
				
			//* Mark unique ingredients across FNDDS versions and drop the repeating ingredients
				bysort ingredientcode fnddsversion: gen line_n = _n
				order line_n, before(fnddsversion)		
				keep if line_n == 1
				drop line_n
				
			//* Drop nutrients that will not be used for the NCDI food-nutrient matrix
				drop ash starch sucrose glucose fructose lactose maltose alcohol water proteinadj caffeine theobromine energykj totsugar galactose fluoride manganese vitaiu retinol vitd2 vitd3 vitd2d3 betacrypto lycopene lutzea betatoc gammatoc deltatoc pantoacid totcholine folicacid foodfolate folatedfe betaine tryptophan threonine isoleucine leucine lysine methionine cystine phenylalanine tyrosine valine arginine histidine alanine aspartic glutamic glycine proline serine hydroxyproline viteadded vitb12added tottransfat totsatfat satfat4_0 satfat6_0 satfat8_0 satfat10_0 satfat12_0 satfat14_0 satfat16_0 satfat18_0 satfat20_0 unsatfat18_1 unsatfat20_4 unsatfat22_6n3 satfat22_0 unsatfat14_1 unsatfat16_1 unsatfat18_4 unsatfat20_1 unsatfat20_5n3 unsatfat22_1 unsatfat22_5n3 phytosterols stigmasterol campesterol betasitosterol totmonofat totpolyfat satfat15_0 satfat17_0 satfat24_0 unsatfat16_1t unsatfat18_1t unsatfat22_1t unsatfat18_2t unsatfat18_2i unsatfat18_2tt unsatfat18_2cla unsatfat24_1c unsatfat20_2n6 unsatfat16_1c unsatfat18_1c unsatfat18_2n6 unsatfat22_1c unsatfat18_3n6 unsatfat17_1 unsatfat20_3 tottransmonoenoic tottranspolyenoic satfat13_0 unsatfat15_1 unsatfat18_3n3 unsatfat20_3n3 unsatfat20_3n6 unsatfat20_4n6 unsatfat18_3i unsatfat21_5 unsatfat22_4
				
			//*	Identify ingredients that have missing nutrient information
				gen missingnutrient = 0
				
				foreach var of varlist protein-unsatfat18_3 {
					replace missingnutrient = 1 if `var' == .
				}
				
				order missingnutrient, before(fnddsversion)
				
			//*	Keep only ingredients with missing nutrients
				drop if missingnutrient == 1
				drop missingnutrient
				
			//* Append using the FNDDS_merged_missing dataset
				append using FNDDS_merged_missing
				
			//*	Create new variable that concatenates the ingredient code and FNDDS version
				gen ing = "ing"
				gen version = "v"
				egen ingredientcode_fndds = concat(ing ingredientcode version fnddsversion)
				order ingredientcode_fndds, before(fnddsversion)
			
			//*	Create new variable that concatenates the ingredient description and FNDDS version
				egen ingredientdesc_fndds = concat(ingredientdesc version fnddsversion)
				order ingredientdesc_fndds, before(fnddsversion)
	
			//* Save
				save "FNDDS_merged_complete.dta", replace
			}
		
		
//	*4. Create the nutrient trait matrix
		//*	Change to FNDDS_merged_complete
			frame FNDDS_merged_complete {	
			
			//* Drop if missing ingredient
				drop if fnddsversion == 0
			
			//* Drop extraneous variables
				drop fnddsversion parentfoodcode parentfooddesc ingredientseq ingredientcode ingredientdesc ingredientretentioncode ingredientfoodprop ingnutrmerge ing version
				
			//*	Standardize nutrients (mean = 0, SD = 1) with loop for standardizing nutrients
				foreach var of varlist protein-unsatfat18_3 {
					egen `var'_z = std(`var')
					drop `var'
				}
	
			//*	Save
				save "FNDDS_nutrienttraitmatrix.dta", replace
			
				export delimited using FNDDS_nutrienttraitmatrix, replace
