# READ ME 

Bess L. Caswell, November 2025

## Summary
This directory provides the instructions and scripts for calculating the Nutrient Composition Diversity Index (NCDI) from 24-hour recall dietary intake data. The full methodology is described in: 

> Gersten ZP, Wilson SMG, Larke JA, Lemay DG and Caswell BL. (2025) Development of a Nutrient Diversity Metric and Its Convergent Validity With Dietary Quality in a Sample of Healthy US Adults. Current Developments in Nutrition. https://doi.org/10.1016/j.cdnut.2025.107029. 

## Required Software

- StataSE 17 (or newer)
- R 4.4.1 (or newer)
- RStudio '2024.09.0+494' (or newer)
- SAS

## Required Files

USDA Food Composition Databases
- Food and Nutrient Database for Dietary Studies (FNDDS), versions 4.1 and 2011-2012, publicly available at https://www.ars.usda.gov/northeast-area/beltsville-md-bhnrc/beltsville-human-nutrition-research-center/food-surveys-research-group/docs/fndds-download-databases/
- USDA National Nutrient Database for Standard Reference (SR), Release 22 and Release 23, publicly available at https://www.ars.usda.gov/northeast-area/beltsville-md-bhnrc/beltsville-human-nutrition-research-center/methods-and-application-of-food-composition-laboratory/mafcl-site-pages/sr11-sr28/

This sample code was developed to calculate NCDI from 24-hour dietary recall data collected in the 2014 and 2016 releases of the Automated Self-Administered 24-Hour Dietary Assessment Tool (ASA24®️). These versions of ASA24 assign food codes from FNDDS 4.1 and FNDDS 2011-2012, respectively. Use of this sample code with dietary intake data coded to different releases of FNDDS will result in missing linkages and slight variations in nutrient content estimates, as each FNDDS release adds and retires food codes and updates nutrient composition values for some food codes.

## NCDI Calculation Procedures

Below are procedures for calculating the Nutrient Composition Diversity Index (NCDI) using ASA24-2014 and ASA24-2016 data. Similar procedures can be used for other detailed dietary intake data by adapting the sample code.

Files from the USDA FFNDS and SR databases are needed to run the following steps. Please confirm that you have downloaded and extracted the files listed above under [README: USDA Food Composition Databases](/README.md#usda-food-composition-databases) before proceeding. All Stata sample code below assumes these files are already converted to .dta format.

### Step 1: Create Nutrient Trait Matrix
#### Step 1.1: Disaggregate mixed food items in the FNDDS food composition table to their ingredients using SR recipes data
In Step 1.1, the source files for the nutrient trait matrix are reshaped and mixed foods are disaggregated into individual ingredients.\
\
\
**1.1.1:** Transpose the SR22 food composition data file (nut_data) from long to wide.

See sample code NCDI_FL100_1_FNDDS4_IngredientNutrientTable.do

Note that for this sample code, the SR22 nut_data file was renamed srnutval and the output file is named FNDDS4_ingnutrval. The output file should contain one row per food, with columns corresponding to the nutrients reported in the SR food composition data and cells containing the nutrient composition values for each food. At this point, the expression of nutrient composition values on a per 100g of food basis is retained.\
\
\
**1.1.2:** Disaggregate mixed food items in the FNDDS 4.1 foods list (mainfooddesc) using SR recipes data (fnddssrlinks) and merge the nutrient values table from Step 1.1.1 (named FNDDS4_ingnutrval in sample code).

See sample code NCDI_FL100_2_FNDDS4_IngredientDisaggregator.do.

The output file (FNDDS4_ingredientizednutrval.dta in sample code) should contain all FNDDS items broken down to individual foods or ingredients from the SR food composition database, with nutrient composition data for each ingredient. Because some mixed dishes in FNDDS contain sub-recipes, multiple iterations are required to disaggregate the mixed dish recipes down to the level of individual foods. For FNDDS 4.1, four iterations are required. For other versions, more or fewer iterations may be needed.
<br/>
<br/>   
   
### Step 1.2: Repeat for all versions of FNDDS used
Repeat Steps 1.1.1 and 1.1.2 using the SR22 and FNDDS 2011-2012 data files. See sample code NCDI_FL100_3_FNDDS2011-12_IngredientNutrientTable.do and NCDI_FL100_4_FNDDS2011-12_IngredientDisaggregator.do.
<br/>
If additional versions of ASA24 are used, or if there are missing nutrient composition data, repeat Steps 1.1.1 and 1.1.2 for all versions needed to align with the dietary intake data or to provide the missing nutrient composition values.  
<br/>
<br/>

### Step 1.3: Append the disaggregated food composition tables into a single nutrient trait matrix
Append the disaggregated food composition tables into a single nutrient trait matrix and clean the data as follows.  
  - Remove duplicate foods or ingredients from each FNDDS version.
  - Fill in any missing nutrient composition data.
  - Create variables marking the version for each unique food or ingredient. (Note: some foods or ingredients remain unchanged across FNDDS versions, while nutrient composition values for some foods or ingredients are updated. In both of these cases, the record from both versions is retained.)
  - Drop items that occur in the SR tables but not in the FNDDS tables and items that do not have nutritive value (e.g. spices, preservatives, emulsifiers).
  - Delete columns for nutrients that will not be used in the NCDI calculation.
  - Mean-standardize values for all nutrients that will be used in the NCDI calculation.

    
See sample code NCDI_FL100_5_MergeFNDDSNutrientTraitMatrix.do.
<br/>
<br/>

## Step 2: Create Individual Food Intake Matrices
To score NCDI for individual study participants, the dietary intake data need to be disaggregated and processed similarly to the food composition data used to create the nutrient trait matrix. The cleaned, food item-level ASA24 data are disaggregated by merging these data to the corresponding, disaggregated FNDDS food composition table. Binary indicators must then be created to mark which of the foods in the nutrient trait matrix were reported in each recall. The output file should contain one row per recall, with user ID and a binary food consumption indicator for each food in the nutrient trait matrix.

See sample code NCDI_FL100_6_CleanASA24RecallData.do.

<br/>
<br/>

## Step 3: Calculate the Nutrient Composition Diversity Index 
### Step 3.1: Calculate Distance Matrix, Dendrogram and Summed Branch Lengths
The distance matrix, dendrogram and summed branch lengths for the total dendrogram and individual dietary recalls are calculated in R, using the nutrient trait matrix and individual food intake matrices prepared in Steps 1 & 2. The output data file contains the summed branch lengths connecting all foods reported within each recall. The summed branch lengths for the total dendrogram is obtained from the R code to be copied into the subsequent data processing steps. A data file of the dendrogram clustering results and a figure displaying the dendrogram can be output as well.

See sample code NCDI_FL100_7_DendScore.Rmd.
<br/>
<br/>
### Step 3.2: Calculate the Nutrient Composition Diversity Index for each recall
To calculate NCDI, the summed branch length for each recall is expressed as a percent of the summed branch lengths in the total dendrogram.

See sample code NCDI_FL100_8_ASA24_NCDIBLUPs.do. This sample code also shows calculation of best linear unbiased predictors (BLUPs) of usual NCDI.

The additional scripts (NCDI_FL100_9... through NCDI_FL100_14) are intended to be run sequentially to complete the analysis described in the published study.



