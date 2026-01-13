/*Zachary Gersten
WHRNC, USDA
Calculating HEI-2015 using ASA24 2016 per person*/

%let home=C:\Users\zachary.gersten\Box\USDA\2_USDA-ARS\Indicator Development\FL100 NDI\Data Analysis\6. Calculate NDI with complete FNDDS data\4. Calculate HEI scores\Per Person\ASA242016;

filename Totals "&home\Totals\Totals.csv";

filename res "&home\res";

%include "&home\hei2015.score.macro.sas";

title 'ASA24-2016 HEI-2015 scores, by person using all days';

/*Step 2.
Calculates total food group and nutrient intake over all possible days reported per individual.
*/

proc sort data=Totals;
  by UserName UserID;
run;

*get sum per person of variables of interest;
proc means data=Totals noprint;
  by UserName UserID;
  var KCAL VTOTALLEG VDRKGRLEG F_TOTAL FWHOLEFRT G_WHOLE D_TOTAL 
      PFALLPROTLEG PFSEAPLANTLEG MONOPOLY SFAT SODI G_REFINED ADD_SUGARS;
  output out=idtot sum=;
run;


/*Step 3. 
 Runs the HEI2015 scoring macro which calculates intake density amounts and HEI scores.
*/

%HEI2015 (indat=idtot,
          kcal= KCAL,
	  vtotalleg= VTOTALLEG,
	  vdrkgrleg= VDRKGRLEG,
	  f_total= F_TOTAL,
	  fwholefrt=FWHOLEFRT,
	  g_whole= G_WHOLE,
	  d_total= D_TOTAL,
          pfallprotleg= PFALLPROTLEG,
	  pfseaplantleg= PFSEAPLANTLEG,
	  monopoly=MONOPOLY,
	  satfat=SFAT,
	  sodium=SODI,
	  g_refined=G_REFINED,
	  add_sugars=ADD_SUGARS,
	  outdat=hei2015);
 

/*Step 4. 
 Displays and saves the results.
*/ 



Data hei2015r (keep=UserName UserID kcal HEI2015C1_TOTALVEG HEI2015C2_GREEN_AND_BEAN HEI2015C3_TOTALFRUIT
      HEI2015C4_WHOLEFRUIT HEI2015C5_WHOLEGRAIN HEI2015C6_TOTALDAIRY HEI2015C7_TOTPROT HEI2015C8_SEAPLANT_PROT 
      HEI2015C9_FATTYACID HEI2015C10_SODIUM HEI2015C11_REFINEDGRAIN HEI2015C12_SFAT HEI2015C13_ADDSUG HEI2015_TOTAL_SCORE);
  Set hei2015;
  Run;

proc means n nmiss min max mean data=hei2015r;
run;

proc export data= hei2015r
  file=res
  dbms=csv
  replace;
run;





