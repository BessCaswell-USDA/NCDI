//	*Zachary Gersten, PhD MPH
//	*Western Human Nutrition Research Center
//	*United States Department of Agriculture, Agricultural Research Service
//	*Description: This program transposes the FNNDS 4.1 ingredient nutrient value dataset (SR22) from long to wide; program must run all at once for 'levelsof' command to work properly

//	*0. Administration
		clear all
		set more off
		set varabbrev off

	
//	*1. Call in dataset
		use srnutval
	
	
//	*2. Create temporary working nutrient variables
		{
		gen protein_0 = .
		gen totlipid_0 = .
		gen carbohydratedf_0 = .
		gen ash_0 = .
		gen energykcal_0 = .
		gen starch_0 = .
		gen sucrose_0 = .
		gen glucose_0 = .
		gen fructose_0 = .
		gen lactose_0 = .
		gen maltose_0 = .
		gen alcohol_0 = .
		gen water_0 = .
		gen proteinadj_0 = .
		gen caffeine_0 = .
		gen theobromine_0 = .
		gen energykj_0 = .
		gen totsugar_0 = .
		gen galactose_0 = .
		gen totdietfiber_0 = .
		gen calcium_0 = .
		gen iron_0 = .
		gen magnesium_0 = .
		gen phosphorus_0 = .
		gen potassium_0 = .
		gen sodium_0 = .
		gen zinc_0 = .
		gen copper_0 = .
		gen fluoride_0 = .
		gen manganese_0 = .
		gen selenium_0 = .
		gen vitaiu_0 = .
		gen retinol_0 = .
		gen vitarae_0 = .
		gen betacarotene_0 = .
		gen alphacarotene_0 = .
		gen vite_0 = .
		gen vitd_0 = .
		gen vitd2_0 = .
		gen vitd3_0 = .
		gen vitd2d3_0 = .
		gen betacrypto_0 = .
		gen lycopene_0 = .
		gen lutzea_0 = .
		gen betatoc_0 = .
		gen gammatoc_0 = .
		gen deltatoc_0 = .
		gen vitc_0 = .
		gen thiamin_0 = .
		gen riboflavin_0 = .
		gen niacin_0 = .
		gen pantoacid_0	 = .
		gen vitb6_0 = .
		gen totfolate_0 = .
		gen vitb12_0 = .
		gen totcholine_0 = .
		gen vitk_0 = .
		gen folicacid_0 = .
		gen foodfolate_0 = .
		gen folatedfe_0 = .
		gen betaine_0 = .
		gen tryptophan_0 = .
		gen threonine_0 = .
		gen isoleucine_0 = .
		gen leucine_0 = .
		gen lysine_0 = .
		gen methionine_0 = .
		gen cystine_0 = .
		gen phenylalanine_0 = .
		gen tyrosine_0 = .
		gen valine_0 = .
		gen arginine_0 = .
		gen histidine_0 = .
		gen alanine_0 = .
		gen aspartic_0 = .
		gen glutamic_0 = .
		gen glycine_0 = .
		gen proline_0 = .
		gen serine_0 = .
		gen hydroxyproline_0 = .
		gen viteadded_0 = .
		gen vitb12added_0 = .
		gen cholesterol_0 = .
		gen tottransfat_0 = .
		gen totsatfat_0 = .
		gen satfat4_0_0 = . /*Butyric acid*/
		gen satfat6_0_0 = . /*Caproic acid*/
		gen satfat8_0_0 = . /*Caprylic acid*/
		gen satfat10_0_0 = . /*Capric acid*/
		gen satfat12_0_0 = . /*Lauric acid*/
		gen satfat14_0_0 = . /*Myristic acid*/
		gen satfat16_0_0 = . /*Palmitic acid*/
		gen satfat18_0_0 = . /*Stearic acid*/
		gen satfat20_0_0 = . /*Arachidic acid*/
		gen unsatfat18_1_0 = . /*Oleic acid*/
		gen unsatfat18_2_0 = . /*Linoleic acid*/
		gen unsatfat18_3_0 = . /*a-Linolenic acid*/
		gen unsatfat20_4_0 = . /*Arachidonic acid*/
		gen unsatfat22_6n3_0 = . /*Docosahexaenoic acid*/
		gen satfat22_0_0 = . /*Behenic acid*/
		gen unsatfat14_1_0 = . /*Myristoleic acid*/
		gen unsatfat16_1_0 = . /*Palmitoleic acid*/
		gen unsatfat18_4_0 = . /*Stearidonic acid*/
		gen unsatfat20_1_0 = . /*Eicosenoic acid*/
		gen unsatfat20_5n3_0 = . /*Eicosapentaenoic acid*/
		gen unsatfat22_1_0 = . /*Erucic acid*/
		gen unsatfat22_5n3_0 = . /*Docosapentaenoic acid*/
		gen phytosterols_0 = .
		gen stigmasterol_0 = .
		gen campesterol_0 = .
		gen betasitosterol_0 = .
		gen totmonofat_0 = .
		gen totpolyfat_0 = .
		gen satfat15_0_0 = . /*Pentadecanoic acid*/
		gen satfat17_0_0 = . /*Margaric acid*/
		gen satfat24_0_0 = . /*Lignoceric acid*/
		gen unsatfat16_1t_0 = . /*Trans-palmitoleic acid*/
		gen unsatfat18_1t_0 = . /*Trans-oleic acid*/
		gen unsatfat22_1t_0 = . /*Trans-erucic acid*/
		gen unsatfat18_2t_0 = . /*Trans-linoleic acid, not further defined*/
		gen unsatfat18_2i_0 = . 
		gen unsatfat18_2tt_0 = .
		gen unsatfat18_2cla_0 = .
		gen unsatfat24_1c_0 = .
		gen unsatfat20_2n6_0 = .
		gen unsatfat16_1c_0 = .
		gen unsatfat18_1c_0 = .
		gen unsatfat18_2n6_0 = .
		gen unsatfat22_1c_0 = .
		gen unsatfat18_3n6_0 = .
		gen unsatfat17_1_0 = .
		gen unsatfat20_3_0 = .
		gen tottransmonoenoic_0 = .
		gen tottranspolyenoic_0 = .
		gen satfat13_0_0 = .
		gen unsatfat15_1_0 = .
		gen unsatfat18_3n3_0 = .
		gen unsatfat20_3n3_0 = .
		gen unsatfat20_3n6_0 = .
		gen unsatfat20_4n6_0 = .
		gen unsatfat18_3i_0 = .
		gen unsatfat21_5_0 = .
		gen unsatfat22_4_0 = .
		}
	
		
//	*3. Transpose ingredient nutrient values (program must run all at once for 'levelsof' command to work properly)
		{
		levelsof SR_code, local(ingredientcode)
	
		foreach l of local ingredientcode {
			capture noisily replace protein_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 203		
			capture noisily replace totlipid_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 204		
			capture noisily replace carbohydratedf_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 205
			capture noisily replace ash_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 207
			capture noisily replace energykcal_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 208
			capture noisily replace starch_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 209
			capture noisily replace sucrose_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 210
			capture noisily replace glucose_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 211
			capture noisily replace fructose_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 212
			capture noisily replace lactose_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 213
			capture noisily replace maltose_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 214
			capture noisily replace alcohol_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 221
			capture noisily replace water_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 255
			capture noisily replace proteinadj_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 257
			capture noisily replace caffeine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 262
			capture noisily replace theobromine_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 263
			capture noisily replace energykj_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 268
			capture noisily replace totsugar_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 269
			capture noisily replace galactose_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 287
			capture noisily replace totdietfiber_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 291
			capture noisily replace calcium_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 301
			capture noisily replace iron_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 303
			capture noisily replace magnesium_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 304
			capture noisily replace phosphorus_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 305
			capture noisily replace potassium_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 306
			capture noisily replace sodium_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 307
			capture noisily replace zinc_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 309
			capture noisily replace copper_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 312
			capture noisily replace fluoride_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 313
			capture noisily replace manganese_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 315
			capture noisily replace selenium_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 317
			capture noisily replace vitaiu_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 318
			capture noisily replace retinol_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 319
			capture noisily replace vitarae_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 320
			capture noisily replace betacarotene_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 321
			capture noisily replace alphacarotene_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 322
			capture noisily replace vite_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 323
			capture noisily replace vitd_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 324
			capture noisily replace vitd2_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 325
			capture noisily replace vitd3_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 326
			capture noisily replace vitd2d3_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 328
			capture noisily replace betacrypto_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 334
			capture noisily replace lycopene_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 337
			capture noisily replace lutzea_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 338
			capture noisily replace betatoc_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 341
			capture noisily replace gammatoc_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 342
			capture noisily replace deltatoc_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 343
			capture noisily replace vitc_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 401
			capture noisily replace thiamin_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 404
			capture noisily replace riboflavin_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 405
			capture noisily replace niacin_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 406
			capture noisily replace pantoacid_0	 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 410
			capture noisily replace vitb6_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 415
			capture noisily replace totfolate_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 417
			capture noisily replace vitb12_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 418
			capture noisily replace totcholine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 421
			capture noisily replace vitk_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 430
			capture noisily replace folicacid_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 431
			capture noisily replace foodfolate_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 432
			capture noisily replace folatedfe_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 435
			capture noisily replace betaine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 454
			capture noisily replace tryptophan_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 501
			capture noisily replace threonine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 502
			capture noisily replace isoleucine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 503
			capture noisily replace leucine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 504
			capture noisily replace lysine_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 505
			capture noisily replace methionine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 506
			capture noisily replace cystine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 507
			capture noisily replace phenylalanine_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 508
			capture noisily replace tyrosine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 509
			capture noisily replace valine_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 510
			capture noisily replace arginine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 511
			capture noisily replace histidine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 512
			capture noisily replace alanine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 513
			capture noisily replace aspartic_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 514
			capture noisily replace glutamic_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 515
			capture noisily replace glycine_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 516
			capture noisily replace proline_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 517
			capture noisily replace serine_0 = 				Nutrient_value if SR_code == `l' & Nutrient_code == 518
			capture noisily replace hydroxyproline_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 521
			capture noisily replace viteadded_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 573
			capture noisily replace vitb12added_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 578
			capture noisily replace cholesterol_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 601
			capture noisily replace tottransfat_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 605
			capture noisily replace totsatfat_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 606
			capture noisily replace satfat4_0_0  = 			Nutrient_value if SR_code == `l' & Nutrient_code == 607
			capture noisily replace satfat6_0_0  = 			Nutrient_value if SR_code == `l' & Nutrient_code == 608
			capture noisily replace satfat8_0_0  = 			Nutrient_value if SR_code == `l' & Nutrient_code == 609
			capture noisily replace satfat10_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 610
			capture noisily replace satfat12_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 611
			capture noisily replace satfat14_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 612
			capture noisily replace satfat16_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 613
			capture noisily replace satfat18_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 614
			capture noisily replace satfat20_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 615 
			capture noisily replace unsatfat18_1_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 617
			capture noisily replace unsatfat18_2_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 618
			capture noisily replace unsatfat18_3_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 619 
			capture noisily replace unsatfat20_4_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 620 
			capture noisily replace unsatfat22_6n3_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 621
			capture noisily replace satfat22_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 624
			capture noisily replace unsatfat14_1_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 625
			capture noisily replace unsatfat16_1_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 626
			capture noisily replace unsatfat18_4_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 627
			capture noisily replace unsatfat20_1_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 628
			capture noisily replace unsatfat20_5n3_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 629
			capture noisily replace unsatfat22_1_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 630
			capture noisily replace unsatfat22_5n3_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 631
			capture noisily replace phytosterols_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 636
			capture noisily replace stigmasterol_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 638
			capture noisily replace campesterol_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 639
			capture noisily replace betasitosterol_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 641
			capture noisily replace totmonofat_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 645
			capture noisily replace totpolyfat_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 646
			capture noisily replace satfat15_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 652
			capture noisily replace satfat17_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 653
			capture noisily replace satfat24_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 654
			capture noisily replace unsatfat16_1t_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 662
			capture noisily replace unsatfat18_1t_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 663
			capture noisily replace unsatfat22_1t_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 664
			capture noisily replace unsatfat18_2t_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 665
			capture noisily replace unsatfat18_2i_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 666 
			capture noisily replace unsatfat18_2tt_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 669
			capture noisily replace unsatfat18_2cla_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 670
			capture noisily replace unsatfat24_1c_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 671
			capture noisily replace unsatfat20_2n6_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 672
			capture noisily replace unsatfat16_1c_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 673
			capture noisily replace unsatfat18_1c_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 674
			capture noisily replace unsatfat18_2n6_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 675
			capture noisily replace unsatfat22_1c_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 676
			capture noisily replace unsatfat18_3n6_0 =		Nutrient_value if SR_code == `l' & Nutrient_code == 685
			capture noisily replace unsatfat17_1_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 687
			capture noisily replace unsatfat20_3_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 689
			capture noisily replace tottransmonoenoic_0 = 	Nutrient_value if SR_code == `l' & Nutrient_code == 693
			capture noisily replace tottranspolyenoic_0 = 	Nutrient_value if SR_code == `l' & Nutrient_code == 695
			capture noisily replace satfat13_0_0 = 			Nutrient_value if SR_code == `l' & Nutrient_code == 696
			capture noisily replace unsatfat15_1_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 697
			capture noisily replace unsatfat18_3n3_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 851
			capture noisily replace unsatfat20_3n3_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 852
			capture noisily replace unsatfat20_3n6_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 853
			capture noisily replace unsatfat20_4n6_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 855
			capture noisily replace unsatfat18_3i_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 856
			capture noisily replace unsatfat21_5_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 857	
			capture noisily replace unsatfat22_4_0 = 		Nutrient_value if SR_code == `l' & Nutrient_code == 858
		}
		}
	
	
//	*4. Populate nutrient variables and drop temporary working nutrient variables
		{
		bysort SR_code: egen protein = 				mean(protein_0)				
		bysort SR_code: egen totlipid = 			mean(totlipid_0)		
		bysort SR_code: egen carbohydratedf =		mean(carbohydratedf_0)
		bysort SR_code: egen ash = 					mean(ash_0)			
		bysort SR_code: egen energykcal = 			mean(energykcal_0)		
		bysort SR_code: egen starch = 				mean(starch_0)			
		bysort SR_code: egen sucrose = 				mean(sucrose_0)			
		bysort SR_code: egen glucose = 				mean(glucose_0)			
		bysort SR_code: egen fructose = 			mean(fructose_0)			
		bysort SR_code: egen lactose = 				mean(lactose_0)		
		bysort SR_code: egen maltose = 				mean(maltose_0)			
		bysort SR_code: egen alcohol = 				mean(alcohol_0)
		bysort SR_code: egen water = 				mean(water_0)
		bysort SR_code: egen proteinadj = 			mean(proteinadj_0)		
		bysort SR_code: egen caffeine = 			mean(caffeine_0)
		bysort SR_code: egen theobromine = 			mean(theobromine_0)
		bysort SR_code: egen energykj = 			mean(energykj_0)
		bysort SR_code: egen totsugar = 			mean(totsugar_0)	
		bysort SR_code: egen galactose = 			mean(galactose_0)
		bysort SR_code: egen totdietfiber = 		mean(totdietfiber_0)
		bysort SR_code: egen calcium = 				mean(calcium_0)
		bysort SR_code: egen iron = 				mean(iron_0)
		bysort SR_code: egen magnesium = 			mean(magnesium_0)
		bysort SR_code: egen phosphorus = 			mean(phosphorus_0)	
		bysort SR_code: egen potassium = 			mean(potassium_0)
		bysort SR_code: egen sodium = 				mean(sodium_0)
		bysort SR_code: egen zinc = 				mean(zinc_0)
		bysort SR_code: egen copper = 				mean(copper_0)
		bysort SR_code: egen fluoride = 			mean(fluoride_0)
		bysort SR_code: egen manganese = 			mean(manganese_0)
		bysort SR_code: egen selenium = 			mean(selenium_0)
		bysort SR_code: egen vitaiu = 				mean(vitaiu_0)
		bysort SR_code: egen retinol = 				mean(retinol_0)
		bysort SR_code: egen vitarae = 				mean(vitarae_0)
		bysort SR_code: egen betacarotene = 		mean(betacarotene_0)
		bysort SR_code: egen alphacarotene =		mean(alphacarotene_0)
		bysort SR_code: egen vite = 				mean(vite_0)
		bysort SR_code: egen vitd = 				mean(vitd_0)
		bysort SR_code: egen vitd2 = 				mean(vitd2_0)
		bysort SR_code: egen vitd3 = 				mean(vitd3_0)
		bysort SR_code: egen vitd2d3 = 				mean(vitd2d3_0)
		bysort SR_code: egen betacrypto = 			mean(betacrypto_0)
		bysort SR_code: egen lycopene = 			mean(lycopene_0)
		bysort SR_code: egen lutzea = 				mean(lutzea_0)
		bysort SR_code: egen betatoc = 				mean(betatoc_0)
		bysort SR_code: egen gammatoc = 			mean(gammatoc_0)
		bysort SR_code: egen deltatoc = 			mean(deltatoc_0)
		bysort SR_code: egen vitc = 				mean(vitc_0)
		bysort SR_code: egen thiamin = 				mean(thiamin_0)
		bysort SR_code: egen riboflavin = 			mean(riboflavin_0)
		bysort SR_code: egen niacin = 				mean(niacin_0)
		bysort SR_code: egen pantoacid = 			mean(pantoacid_0)
		bysort SR_code: egen vitb6 = 				mean(vitb6_0)
		bysort SR_code: egen totfolate = 			mean(totfolate_0)
		bysort SR_code: egen vitb12 = 				mean(vitb12_0)
		bysort SR_code: egen totcholine = 			mean(totcholine_0)
		bysort SR_code: egen vitk = 				mean(vitk_0)
		bysort SR_code: egen folicacid = 			mean(folicacid_0)
		bysort SR_code: egen foodfolate = 			mean(foodfolate_0)
		bysort SR_code: egen folatedfe = 			mean(folatedfe_0)
		bysort SR_code: egen betaine = 				mean(betaine_0)
		bysort SR_code: egen tryptophan = 			mean(tryptophan_0)
		bysort SR_code: egen threonine = 			mean(threonine_0)
		bysort SR_code: egen isoleucine = 			mean(isoleucine_0)
		bysort SR_code: egen leucine = 				mean(leucine_0)
		bysort SR_code: egen lysine = 				mean(lysine_0)
		bysort SR_code: egen methionine = 			mean(methionine_0)
		bysort SR_code: egen cystine = 				mean(cystine_0)
		bysort SR_code: egen phenylalanine =		mean(phenylalanine_0)
		bysort SR_code: egen tyrosine = 			mean(tyrosine_0)
		bysort SR_code: egen valine = 				mean(valine_0)
		bysort SR_code: egen arginine = 			mean(arginine_0)
		bysort SR_code: egen histidine = 			mean(histidine_0)
		bysort SR_code: egen alanine = 				mean(alanine_0)
		bysort SR_code: egen aspartic = 			mean(aspartic_0)
		bysort SR_code: egen glutamic = 			mean(glutamic_0)
		bysort SR_code: egen glycine = 				mean(glycine_0)
		bysort SR_code: egen proline = 				mean(proline_0)
		bysort SR_code: egen serine = 				mean(serine_0)
		bysort SR_code: egen hydroxyproline =		mean(hydroxyproline_0)
		bysort SR_code: egen viteadded = 			mean(viteadded_0)
		bysort SR_code: egen vitb12added = 			mean(vitb12added_0)
		bysort SR_code: egen cholesterol = 			mean(cholesterol_0)
		bysort SR_code: egen tottransfat = 			mean(tottransfat_0)
		bysort SR_code: egen totsatfat = 			mean(totsatfat_0)
		bysort SR_code: egen satfat4_0  = 			mean(satfat4_0_0)
		bysort SR_code: egen satfat6_0  = 			mean(satfat6_0_0)
		bysort SR_code: egen satfat8_0  = 			mean(satfat8_0_0)
		bysort SR_code: egen satfat10_0 = 			mean(satfat10_0_0)
		bysort SR_code: egen satfat12_0 = 			mean(satfat12_0_0)
		bysort SR_code: egen satfat14_0 = 			mean(satfat14_0_0)
		bysort SR_code: egen satfat16_0 = 			mean(satfat16_0_0)
		bysort SR_code: egen satfat18_0 = 			mean(satfat18_0_0)
		bysort SR_code: egen satfat20_0 = 			mean(satfat20_0_0)
		bysort SR_code: egen unsatfat18_1 = 		mean(unsatfat18_1_0)
		bysort SR_code: egen unsatfat18_2 = 		mean(unsatfat18_2_0)
		bysort SR_code: egen unsatfat18_3 = 		mean(unsatfat18_3_0)
		bysort SR_code: egen unsatfat20_4 = 		mean(unsatfat20_4_0)
		bysort SR_code: egen unsatfat22_6n3 = 		mean(unsatfat22_6n3_0)
		bysort SR_code: egen satfat22_0 = 			mean(satfat22_0_0)
		bysort SR_code: egen unsatfat14_1 =			mean(unsatfat14_1_0)
		bysort SR_code: egen unsatfat16_1 =			mean(unsatfat16_1_0)
		bysort SR_code: egen unsatfat18_4 =			mean(unsatfat18_4_0)
		bysort SR_code: egen unsatfat20_1 =			mean(unsatfat20_1_0)
		bysort SR_code: egen unsatfat20_5n3 =		mean(unsatfat20_5n3_0)
		bysort SR_code: egen unsatfat22_1 = 		mean(unsatfat22_1_0)
		bysort SR_code: egen unsatfat22_5n3 =  		mean(unsatfat22_5n3_0)
		bysort SR_code: egen phytosterols = 		mean(phytosterols_0)
		bysort SR_code: egen stigmasterol = 		mean(stigmasterol_0)
		bysort SR_code: egen campesterol = 			mean(campesterol_0)
		bysort SR_code: egen betasitosterol = 		mean(betasitosterol_0) 		
		bysort SR_code: egen totmonofat = 			mean(totmonofat_0)
		bysort SR_code: egen totpolyfat = 			mean(totpolyfat_0)
		bysort SR_code: egen satfat15_0 = 			mean(satfat15_0_0)
		bysort SR_code: egen satfat17_0 = 			mean(satfat17_0_0)
		bysort SR_code: egen satfat24_0 = 			mean(satfat24_0_0)
		bysort SR_code: egen unsatfat16_1t =		mean(unsatfat16_1t_0)
		bysort SR_code: egen unsatfat18_1t =		mean(unsatfat18_1t_0)
		bysort SR_code: egen unsatfat22_1t =		mean(unsatfat22_1t_0)
		bysort SR_code: egen unsatfat18_2t =		mean(unsatfat18_2t_0)
		bysort SR_code: egen unsatfat18_2i =		mean(unsatfat18_2i_0)
		bysort SR_code: egen unsatfat18_2tt = 		mean(unsatfat18_2tt_0) 		
		bysort SR_code: egen unsatfat18_2cla =		mean(unsatfat18_2cla_0)		
		bysort SR_code: egen unsatfat24_1c =		mean(unsatfat24_1c_0)
		bysort SR_code: egen unsatfat20_2n6 = 		mean(unsatfat20_2n6_0) 		
		bysort SR_code: egen unsatfat16_1c =		mean(unsatfat16_1c_0)
		bysort SR_code: egen unsatfat18_1c =		mean(unsatfat18_1c_0)
		bysort SR_code: egen unsatfat18_2n6 = 		mean(unsatfat18_2n6_0) 		
		bysort SR_code: egen unsatfat22_1c =		mean(unsatfat22_1c_0)
		bysort SR_code: egen unsatfat18_3n6 = 		mean(unsatfat18_3n6_0) 		
		bysort SR_code: egen unsatfat17_1 = 		mean(unsatfat17_1_0)
		bysort SR_code: egen unsatfat20_3 = 		mean(unsatfat20_3_0)
		bysort SR_code: egen tottransmonoenoic =	mean(tottransmonoenoic_0)
		bysort SR_code: egen tottranspolyenoic =	mean(tottranspolyenoic_0)
		bysort SR_code: egen satfat13_0 = 			mean(satfat13_0_0)
		bysort SR_code: egen unsatfat15_1 = 		mean(unsatfat15_1_0)
		bysort SR_code: egen unsatfat18_3n3 = 		mean(unsatfat18_3n3_0)
		bysort SR_code: egen unsatfat20_3n3 = 		mean(unsatfat20_3n3_0)
		bysort SR_code: egen unsatfat20_3n6 = 		mean(unsatfat20_3n6_0)
		bysort SR_code: egen unsatfat20_4n6 = 		mean(unsatfat20_4n6_0)
		bysort SR_code: egen unsatfat18_3i = 		mean(unsatfat18_3i_0)
		bysort SR_code: egen unsatfat21_5 = 		mean(unsatfat21_5_0)
		bysort SR_code: egen unsatfat22_4 = 		mean(unsatfat22_4_0)	
		}
	
//	*5. Keep ingredient rows
		rename SR_code ingredientcode
		bysort ingredientcode: gen line_n = _n
		keep if line_n == 1
		drop line_n
	
		drop Nutrient_code Nutrient_value Num_Data_Pts Std_Error Src_Cd Deriv_Cd Ref_NDB_No Add_Nutr_Mark Num_Studies Min Max DF Low_EB Up_EB Stat_Cmt protein_0 totlipid_0 carbohydratedf_0 ash_0 energykcal_0 starch_0 sucrose_0 glucose_0 fructose_0 lactose_0 maltose_0 alcohol_0 water_0 proteinadj_0 caffeine_0 theobromine_0 energykj_0 totsugar_0 galactose_0 totdietfiber_0 calcium_0 iron_0 magnesium_0 phosphorus_0 potassium_0 sodium_0 zinc_0 copper_0 fluoride_0 manganese_0 selenium_0 vitaiu_0 retinol_0 vitarae_0 betacarotene_0 alphacarotene_0 vite_0 vitd_0 vitd2_0 vitd3_0 vitd2d3_0 betacrypto_0 lycopene_0 lutzea_0 betatoc_0 gammatoc_0 deltatoc_0 vitc_0 thiamin_0 riboflavin_0 niacin_0 pantoacid_0 vitb6_0 totfolate_0 vitb12_0 totcholine_0 vitk_0 folicacid_0 foodfolate_0 folatedfe_0 betaine_0 tryptophan_0 threonine_0 isoleucine_0 leucine_0 lysine_0 methionine_0 cystine_0 phenylalanine_0 tyrosine_0 valine_0 arginine_0 histidine_0 alanine_0 aspartic_0 glutamic_0 glycine_0 proline_0 serine_0 hydroxyproline_0 viteadded_0 vitb12added_0 cholesterol_0 tottransfat_0 totsatfat_0 satfat4_0_0 satfat6_0_0 satfat8_0_0 satfat10_0_0 satfat12_0_0 satfat14_0_0 satfat16_0_0 satfat18_0_0 satfat20_0_0 unsatfat18_1_0 unsatfat18_2_0 unsatfat18_3_0 unsatfat20_4_0 unsatfat22_6n3_0 satfat22_0_0 unsatfat14_1_0 unsatfat16_1_0 unsatfat18_4_0 unsatfat20_1_0 unsatfat20_5n3_0 unsatfat22_1_0 unsatfat22_5n3_0 phytosterols_0 stigmasterol_0 campesterol_0 betasitosterol_0 totmonofat_0 totpolyfat_0 satfat15_0_0 satfat17_0_0 satfat24_0_0 unsatfat16_1t_0 unsatfat18_1t_0 unsatfat22_1t_0 unsatfat18_2t_0 unsatfat18_2i_0 unsatfat18_2tt_0 unsatfat18_2cla_0 unsatfat24_1c_0 unsatfat20_2n6_0 unsatfat16_1c_0 unsatfat18_1c_0 unsatfat18_2n6_0 unsatfat22_1c_0 unsatfat18_3n6_0 unsatfat17_1_0 unsatfat20_3_0 tottransmonoenoic_0 tottranspolyenoic_0 satfat13_0_0 unsatfat15_1_0 unsatfat18_3n3_0 unsatfat20_3n3_0 unsatfat20_3n6_0 unsatfat20_4n6_0 unsatfat18_3i_0 unsatfat21_5_0 unsatfat22_4_0
	
//	*6. Save file
		save "FNDDS4_ingnutrval.dta", replace
			
		export delimited using FNDDS4_ingnutrval, replace	
	
	
	
	
	
	
	
	
	
	
	
	

	
	