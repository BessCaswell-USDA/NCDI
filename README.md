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

## Suggested Order of Scripts

Scripts in each set are intended to be run sequentially.



