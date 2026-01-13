//	*Zachary Gersten, PhD MPH
//	*Western Human Nutrition Research Center
//	*United States Department of Agriculture, Agricultural Research Service
//	*Description: Disaggregates the FNDDS 2011-2012 food list over multiple iterations

//	*0. Administration
		clear all
		set more off
		set varabbrev off
	
	
//	*1. Match food codes to ingredients
		{
		//*	Iteration 1
			//* Call in the FNDDS food list (2011-2012). This dataset was initially imported as an SAS dataset and converted to Stata.
				use mainfooddesc
		
			//*	Drop all fingredient metadata the WWEIA information and nutrient values. Nutrient values will be connected later after ingredentizing.
				drop Start_date End_date
		
			//*	Generate a iteration code for the first round of ingredient matching in order to keep track of foods that were disaggregated to ingredients: a food successfully split into its ingredients will have repeating iteration codes for each of the matched ingredients.
				gen it1 = _n
		
			//*	Merge the FNDDS food composition table (2011-2012) with the FNDDS ingredient list, which was also initially imported as an Excel file with the first row used as variable names. We used 1:m merging as there each food code is unique, but there are many ingredients that could be linked to a single food code.
				merge 1:m Food_code using fnddssrlinks
		
			//* Merging adds the ingredients below all the existing rows, so sorting by the food code and ingredient sequence number brings them all back together in order.
				sort Food_code Seq_num
		
			//*	This step creates a new variable that describes the proportion of the ingredient in the original food. First, it sums the ingredient weights in grams. Then, it divides the the ingredient weight in grams by the total to calculate the ingredient food proportion.
				bysort Food_code: egen Ingredientweight_tot = sum(Weight)
				gen Ingredientprop = Weight / Ingredientweight_tot
		
			//*	These steps mark the food and ingredient information as part of the first matching iteration. Then, a new variable is created for ingredients that are matched with foods that could be further matched with ingredients. We used the clonevar command to preserve the data type.
				rename Food_code Foodcode1
				clonevar Food_code = SR_code if SR_code > 9999999
				rename Seq_num Seqnum1
				rename SR_code SR_code1
				rename SR_description SR_description1
				rename Weight Weight1
				rename Retention_code Retention_code1
				rename Ingredientweight_tot Ingredientweight_tot1
				rename Ingredientprop Ingredientprop1
		
			//*	Drop the WWEAI information*/
				drop Start_date End_date Amount Measure Portion_code Flag

			//*	Save the first iteration of matching.
				save "ingredients1.dta", replace
		
		//*	Iteration 2
			//*	Generate a iteration code for the second round of ingredient matching.
				gen it2 = _n
		
			//*	Join the ingredients leftover from the first iteration of matching that could be further ingredientized. We used the joinby command since the ingredient codes were not unique identifiers, as needed to use the merge command.*/
				joinby Food_code using fnddssrlinks, unmatched(master) _merge(newv2)

			//*	Joining adds the ingredients below all the existing rows, so sorting by the food code and ingredient sequence number brings them all back together in order.		
				sort it2 Seq_num

			//*	Creates a new variable that describes the proportion of the ingredient from the food or ingredient from the first iteration of ingredient matching.
				bysort it2: egen Ingredientweight_tot = sum(Weight) if Food_code != .		
				gen Ingredientprop_temp = Weight / Ingredientweight_tot
				gen Ingredientprop2 = Ingredientprop_temp * Ingredientprop1

			//*	These steps mark the food and ingredient information as part of the second matching iteration. Then, a new variable is created for ingredients that are matched with foods that could be further matched with ingredients.
				rename Food_code Foodcode2
				clonevar Food_code = SR_code if SR_code > 9999999
				rename Seq_num Seqnum2
				rename SR_code SR_code2
				rename SR_description SR_description2
				rename Weight Weight2
				rename Retention_code Retention_code2
				rename Ingredientweight_tot Ingredientweight_tot2

			//*	Drop the WWEAI information
				drop Start_date End_date Amount Measure Portion_code Flag Ingredientprop_temp

			//*	Save the first iteration of matching.
				save "ingredients2.dta", replace
		
		//*	Iteration 3 (steps for Iterations 3-6 serve identical purposes to the steps for Iteration 2)
			gen it3 = _n
			
			joinby Food_code using fnddssrlinks, unmatched(master) _merge(newv3)
		
			sort it3 Seq_num
		
			bysort it3: egen Ingredientweight_tot = sum(Weight) if Food_code != .		
			gen Ingredientprop_temp = Weight / Ingredientweight_tot
			gen Ingredientprop3 = Ingredientprop_temp * Ingredientprop2
		
			rename Food_code Foodcode3
			clonevar Food_code = SR_code if SR_code > 9999999
			rename Seq_num Seqnum3
			rename SR_code SR_code3
			rename SR_description SR_description3
			rename Weight Weight3
			rename Retention_code Retention_code3
			rename Ingredientweight_tot Ingredientweight_tot3
		
			drop Start_date End_date Amount Measure Portion_code Flag Ingredientprop_temp
		
			save "ingredients3.dta", replace
		
		//*	Iteration 4
			gen it4 = _n
			
			joinby Food_code using fnddssrlinks, unmatched(master) _merge(newv4)
	
			sort it4 Seq_num
	
			bysort it4: egen Ingredientweight_tot = sum(Weight) if Food_code != .		
			gen Ingredientprop_temp = Weight / Ingredientweight_tot
			gen Ingredientprop4 = Ingredientprop_temp * Ingredientprop3
	
			rename Food_code Foodcode4
			clonevar Food_code = SR_code if SR_code > 9999999
			rename Seq_num Seqnum4
			rename SR_code SR_code4
			rename SR_description SR_description4
			rename Weight Weight4
			rename Retention_code Retention_code4
			rename Ingredientweight_tot Ingredientweight_tot4
	
			drop Start_date End_date Amount Measure Portion_code Flag Ingredientprop_temp
	
			save "ingredients4.dta", replace
			
		
		//*	Transfer the merged FNDDS ingredient information into single column
			//*	Keep the original food code and other information as a unique identifier
				clonevar parentfoodcode = Foodcode1
				clonevar parentfooddesc = Main_food_description
		
			//*	Generate a new ingredient sequence variable by foods
				bysort parentfoodcode: gen ingredientseq = _n
		
			//*	Keep ingredient information by succeeding iteration
				clonevar ingredientcode = SR_code1
				clonevar ingredientdesc = SR_description1
				clonevar ingredientretentioncode = Retention_code1
				clonevar ingredientfoodprop = Ingredientprop1
				
				replace ingredientcode = SR_code2 if SR_code2 != .
				replace ingredientdesc = SR_description2 if SR_description2 != ""
				replace ingredientretentioncode = Retention_code2 if Retention_code2 != .
				replace ingredientfoodprop = Ingredientprop2 if Ingredientprop2 != . 
				
				replace ingredientcode = SR_code3 if SR_code3 != .
				replace ingredientdesc = SR_description3 if SR_description3 != ""
				replace ingredientretentioncode = Retention_code3 if Retention_code3 != .
				replace ingredientfoodprop = Ingredientprop3 if Ingredientprop3 != . 
			
				replace ingredientcode = SR_code4 if SR_code4 != .
				replace ingredientdesc = SR_description4 if SR_description4 != ""
				replace ingredientretentioncode = Retention_code4 if Retention_code4 != .
				replace ingredientfoodprop = Ingredientprop4 if Ingredientprop4 != . 
	
			//*	Check that all the proportions of ingredients add up to 1.00 for a single food. (Note that the summed proportions approach 1.00 for some foods)
				bysort parentfoodcode: egen ingredientpropcheck = sum(ingredientfoodprop)
		
				list parentfoodcode ingredientcode if ingredientpropcheck < 0.99
		
			//*	Drop all the variables used for the ingredient disaggregating iterations
				drop Foodcode1 Main_food_description it1 Seqnum1 SR_code1 SR_description1 Retention_code1 Weight1 _merge Ingredientweight_tot1 Ingredientprop1 Foodcode2 it2 newv2 Seqnum2 SR_code2 SR_description2 Retention_code2 Weight2 Ingredientweight_tot2 Ingredientprop2 Foodcode3 it3 newv3 Seqnum3 SR_code3 SR_description3 Retention_code3 Weight3 Ingredientweight_tot3 Ingredientprop3 Foodcode4 it4 newv4 Seqnum4 SR_code4 SR_description4 Retention_code4 Weight4 Ingredientweight_tot4 Ingredientprop4 Food_code ingredientpropcheck Fortification_identifier Change_type_to_SR_Code Change_type_to_weight Change_type_to_retn_code
		
			//*	Save the ingredientized dataset
				save "FNDDS2012_ingredientized.dta", replace
		}
		

//	*2. Merge the ingredient disaggregated database to the ingredient nutrient values
		{
		//*Merge ingredients using the joinby command
			joinby ingredientcode using FNDDS2012_ingnutrval, unmatched(master) _merge(newv)
	
		//*Rename newv
			rename newv ingnutrmerge	
	
		//*Create variable to designate FNDDS version
			gen fnddsversion = 2012
		
			order fnddsversion, before(parentfoodcode)
		
		//*Save
			save "FNDDS2012_ingredientizednutrval.dta", replace
		}
		