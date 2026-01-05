use "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\Data_Covid_Paper_assignment.dta" 
save OGData, replace
*I have included the "save OGData" command for convenience later on in the do file, especially when running the random forest model, to be able to revert to the original dataset 


/*
================================================================================
 Replicating Table 2:
================================================================================
*/

eststo clear
 
// Column 1: 

eststo: reg Salaried_Prelockdown Training_complete
// This regresses the effect of training on salary after the baseline survey (i.e. Panel A)
sum Salaried_Prelockdown if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Jun_Jul2020 Training_complete
// This regresses the effect of training on salary after the first follow-up survey (i.e. Panel B)
sum Salaried_Jun_Jul2020 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Mar_Apr2021 Training_complete
// This regresses the effect of training on salary after the second follow-up survey (i.e. Panel C)
sum Salaried_Mar_Apr2021 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Nov_Dec2021 Training_complete
// This regresses the effect of training on salary after the third follow-up survey (i.e. Panel D)
sum Salaried_Nov_Dec2021 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

esttab using "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\T2c1.csv", replace ///
noomitted nogap star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) label ///
keep (Training_complete) scalars (dropout_mean)

// Column 2: 

eststo clear 

eststo: reg Salaried_Prelockdown Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10
// This regresses the effect of training on salary (with the sector controls) after the baseline survey (i.e. Panel A)
sum Salaried_Prelockdown if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Jun_Jul2020 Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10
// This regresses the effect of training on salary (with the sector controls) after the first follow-up survey (i.e. Panel B)
sum Salaried_Jun_Jul2020 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Mar_Apr2021 Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10
// This regresses the effect of training on salary (with the sector controls) after the second follow-up survey (i.e. Panel C)
sum Salaried_Mar_Apr2021 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Nov_Dec2021 Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10  
// This regresses the effect of training on salary (with the sector controls) after the third follow-up survey (i.e. Panel D)
sum Salaried_Nov_Dec2021 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

esttab using "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\T2c2.csv", replace ///
noomitted nogap star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) label ///
keep (Training_complete) scalars (dropout_mean)


// Column 3: 
eststo clear 

eststo: reg Salaried_Prelockdown Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate
// This regresses the effect of training on salary (with the sector and individual controls) after the baseline survey (i.e. Panel A)
sum Salaried_Prelockdown if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Jun_Jul2020 Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate
// This regresses the effect of training on salary (with the sector and individual controls) after the firtst follow-up survey (i.e. Panel B)
sum Salaried_Jun_Jul2020 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Mar_Apr2021 Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate
// This regresses the effect of training on salary (with the sector and individual controls) after the second follow-up survey (i.e. Panel C)
sum Salaried_Mar_Apr2021 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Nov_Dec2021 Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate
// This regresses the effect of training on salary (with the sector and individual controls) after the third follow-up survey (i.e. Panel D) 
sum Salaried_Nov_Dec2021 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

esttab using "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\T2c3.csv", replace ///
noomitted nogap star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) label ///
keep (Training_complete) scalars (dropout_mean)

// Column 4: 

eststo clear 

eststo: reg Salaried_Prelockdown Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family
sum Salaried_Prelockdown if Training_complete == 0
estadd scalar dropout_mean = r(mean) 


eststo: reg Salaried_Jun_Jul2020 Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family
// This regresses the effect of training on salary (with the sector, individual, and household controls) after the first follow-up survey (i.e. Panel B)
sum Salaried_Jun_Jul2020 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 


eststo: reg Salaried_Mar_Apr2021 Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family
// This regresses the effect of training on salary (with the sector, individual, and household controls) after the second follow-up survey (i.e. Panel C)
sum Salaried_Mar_Apr2021 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

eststo: reg Salaried_Nov_Dec2021 Training_complete sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family
// This regresses the effect of training on salary (with the sector, individual, and household controls) after the third follow-up survey (i.e. Panel D) 
sum Salaried_Nov_Dec2021 if Training_complete == 0
estadd scalar dropout_mean = r(mean) 

esttab using "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\T2c4.csv", replace ///
noomitted nogap star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) label ///
keep (Training_complete) scalars (dropout_mean)



/*
================================================================================================
Extension for Table 2: Interacting the gender variable with treatment (including all controls): 
================================================================================================
*/
clear 
use OGData
eststo clear 

eststo: reg Salaried_Prelockdown Training_complete Training_complete##c_gender sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family
// This regresses the effect of training on employment status (with the sector, individual, and household controls) after the first survey (i.e. Panel A)


eststo: reg Salaried_Jun_Jul2020 Training_complete Training_complete##c_gender sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family
// This regresses the effect of training on employment status (with the sector, individual, and household controls) after the first follow-up survey (i.e. Panel B)

eststo: reg Salaried_Mar_Apr2021 Training_complete Training_complete##c_gender sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family
// This regresses the effect of training on employment status (with the sector, individual, and household controls) after the second follow-up survey (i.e. Panel C)

eststo: reg Salaried_Nov_Dec2021 Training_complete Training_complete##c_gender sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family
// This regresses the effect of training on employment status (with the sector, individual, and household controls) after the third follow-up survey (i.e. Panel D) 

esttab using "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\SuppTable1.csv", replace ///
noomitted nogap star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) label ///
scalars (pvalue)

// We find that there is no significant additional effect of being treated when you are a female compared to when you are a male. This was to be expected, given the strong prevalence of social norms in India, especially in rural India, that relegate women to domestic work and expect men to provide for the family. 


/*
================================================================================
Replicating Panel B of Table 4: 
================================================================================
*/
egen strata = group(state sector c_gender c_treatment)
xi i.strata 

* Here, I am generating a group to control for the stratified effects of participants' states, sectors, gender, and their treatment group. I will add these strata to the balance table regressions for each panel. 

global depvar = " Main_outcome_1_Job_applied Main_outcome_2_Job_applications Main_outcome_3_Job_applications "

eststo clear
quietly{
	
// The following code uses the rlasso command to select the control variables that are most relevant to the right-hand-side variables. The rlasso command is run to identify which variables are related to the different outcomes in the depvar group, and then is run to identify which variables are related to the independent control variables. As we have used the rlasso command twice, we have used the double lasso method. 
	
rlasso treatment c_*, partial(_cons)

global treatment_controls = e(selected) 
if "$treatment_controls"=="." global treatment_controls=""
nois display "Controls selected for treatment: `treatment_controls'"

local counter=0
		foreach depvar of varlist $depvar  {
local ++counter
	nois display "Now doing `depvar'"
	rlasso `depvar' c_*, partial(_cons)
	global depvar_controls = e(selected)
	if "$depvar_controls"=="." global depvar_controls=""
	nois display " Controls selected for `depvar': `depvar_controls'"
	
	eststo results_`counter': reg `depvar' $depvar_controls ///
	$treatment_controls treatment, vce(robust)
	reg `depvar' $depvar_controls $treatment_controls treatment i.strata, vce(robust)
	test treatment
	local pvalue=`r(p)'
	
	
	if `counter'==1 mat pvalues=`pvalue'
	else mat pvalues=pvalues\\`pvalue'

	est restore results_`counter'
	estadd scalar pvalue=`pvalue'

	eststo results_`counter': su `depvar' if treatment==0
	estadd scalar control_mean=r(mean)
	*estadd local StrataFE 	  "Yes" 
	
}
}

esttab using "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\Table4PanelB.csv", replace ///
noomitted nogap  nostar b(3) se(3) ///
keep(treatment) scalars(pvalue control_mean treatment_mean)

// We see that the double lasso selection method resulted in no controls being chosen for the regression - this indicates that the control variables have no association with both the treatment and the outcome variable, meaning that the data is randomised 




/*
================================================================================
Extension for Table 4: Experimenting with control variable selection: 
================================================================================
*/

// No controls 

reg Main_outcome_1_Job_applied treatment, vce(robust)
reg Main_outcome_2_Job_applications treatment, vce(robust)
reg Main_outcome_3_Job_applications treatment, vce(robust)

* The regression with no variabes gives us the same coefficients as lasso selection - this indicates that randomisation has truly worked 


eststo clear 
eststo: reg Main_outcome_1_Job_applied treatment sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family, vce(robust)
reg Main_outcome_2_Job_applications treatment, vce(robust)
reg Main_outcome_3_Job_applications treatment, vce(robust)

eststo: reg Main_outcome_2_Job_applications treatment sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family, vce(robust)
reg Main_outcome_2_Job_applications treatment, vce(robust)
reg Main_outcome_3_Job_applications treatment, vce(robust)

eststo: reg Main_outcome_3_Job_applications treatment sector1 sector2 sector3 sector4 sector5 sector6 sector7 sector8 sector9 sector10 c_gender c_caste c_age_above_20 c_respondent_maritalstatus2 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Inter_exam c_respondent_migrate c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_SHG_member c_MNREGA c_internet_use c_relatives_migrate c_difficulty_immediate_famil c_difficulty_future_family, vce(robust)
reg Main_outcome_2_Job_applications treatment, vce(robust)
reg Main_outcome_3_Job_applications treatment, vce(robust)


esttab using "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\SuppTable3.csv", replace ///
noomitted nogap star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) ///
keep(treatment) 

* The coefficients do not meaningfully change even after bluntly adding control variables, indicating that the treatment is indeed orthogonal to the control variables 


/* 
================================================================================
Extension for Table 4: Using random forest: 
================================================================================
*/

/*
Random forest performs better than linear regression models for prediction tasks as linear regression imposes a linear model on the data - whilst this assumption makes the model easy to interpret, it is not flexible enough for prediction. On the other hand, decision trees are able to adapt to nonlinear functions in the data, allowing them to produce better predictions than linear regression models  
*/

vl create controlvars= (c_age_above_20 c_respondent_maritalstatus2 c_respondent_caste2 c_respondent_caste3 c_respondent_caste4 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Matric_percentage2 c_Inter_exam c_Inter_percentage1 c_Score_BIG5Extraversion c_Score_BIG5Agreeableness c_Score_BIG5Conscientiousness c_Score_BIG5Neuroticism c_Score_BIG5Openness c_Score_Grit c_Score_ASE c_Score_Lifegoals c_duration1 c_householdhead_relationship17 c_householdhead_relationship3 c_difficulty_immediate_famil c_difficulty_future_family c_earning_members2 c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_MNREGA c_SHG_member c_house_type2 c_house_type3 c_house_type4 c_house_ownership c_internet_use c_household_type1 c_number_of_family_members1 c_number_of_family_members3 c_number_of_relatives_migrate2 c_number_of_relatives_migrate3 c_relatives_migrate c_respondent_migrate c_previous_earning c_hypothetical1_earning c_hypothetical2_earning c_expected_earning c_preference_earning c_respondent_awareness_perce c_training_usefulness c_satisfaction c_percentage_training_comple c_job_offer_post_training c_minimum_salary c_maximum_salary c_average_salary c_job_outside_state c_job_acceptance_outside_sta c_job_acceptance_in_state c_job_retention_in_state c_job_retention_outside_stat internet_use)


// Using random forest model to investigate most important variables that predict Main_outcome_1_Job_applied: 

set seed 72  
* I have used the "set seed" command to ensure that my results are reproducibleso that when the code is run again, the same randomisation process is followed by the software.
clear matrix 
drop if missing(Main_outcome_1_Job_applied)
generate u = runiform()
sort u, stable
generate out_of_bag_error = .
generate validation_error = .
generate iter= .
local j = 0 
forvalues i = 10(5)500{
	local j = `j' + 1
		quietly{
		rforest Main_outcome_1_Job_applied $controlvars in 1/1000, type(reg) iter(`i') numvars(1) seed(72)
		quietly replace iter = `i' in `j'
		quietly replace out_of_bag_error = `e(OOB_Error)' in `j'
		* The "OOB_Error" is the out of bag error, which measures the prediction error of the random forest and is therefore a measure of the performance of the model. A smaller OOB error indicates a better model. 
		predict pred_outcome1a in 1001/1955
		quietly replace validation_error = `e(RMSE)' in `j'
		* The "RMSE" is the root mean squared error, which is simply the square root of the MSE (mean squared error). As seen in linear regressions, a smaller RMSE indicates a better model.
		drop pred_outcome1a
}	
}

scatter out_of_bag_error iter, mcolor(blue) msize(tiny) || scatter validation_error iter, mcolor(red) msize(tiny)
*The purpose of the above code is to see how many iterations it takes to minimise both the OOB error and the RMSE
*We see that both the OOB error and validation error start to converge to a fixed value at roughly 150 iterations, which is also where we get the lowest value for both 
*We can now tune the hyperparameter numvars() to see which one gives the lowest validation RMSE 

set seed 72
generate out_of_bag_error1 = .
generate nvars = .
generate validation_error1 = .
local j = 0 
forvalues i = 1(1)40 {
	local j = `j' + 1 
	rforest Main_outcome_1_Job_applied $controlvars in 1/1000, type(reg) iter(200) numvars(`i')
	quietly replace nvars = `i' in `j'
	quietly replace out_of_bag_error1 = `e(OOB_Error)' in `j'
	predict pred_outcome1b in 1000/1955
	quietly replace validation_error1 = `e(RMSE)' in `j'
	drop pred_outcome1b
}

* In the above code, I split the complete dataset into a "training" portion and a "testing" portion - the model is trained on the first 1000 observations, and tests its predictive ability on the final 955 observations 

scatter out_of_bag_error1 nvars, mcolor(blue) msize(tiny) || scatter validation_error1 nvars, mcolor(red) msize(tiny)
* This is a scatter graph visualising the RMSE and the corresponding number of variables at which it is achieved - the graph indicates that we get the lowest error when the random forest model is randomly investigating 2 variables  

capture frame
frame put validation_error1 nvars, into(trialdata)
frame trialdata {
	sort validation_error1, stable
	local min_val_err = validation_error[1]
	local min_nvars = nvars[1]
}

display "Minimum Error: `min_val_err'; Corresponding number of variables `min_nvars'"
frame drop trialdata
* This code provides us with the specific figures to confirm what we saw on the scatter graph. We get the lowest RMSE at 0.3248, which is achieved with 2 variables

// Final model for Main_outcome_1_Job_applied: 
set seed 72
rforest Main_outcome_1_Job_applied c_* in 1/1000, type(reg) iterations(200) numvars(2)

ereturn list OOB_Error
* The OOB_Error is 0.2042
predict pred_outcome1c in 1001/1955 
ereturn list RMSE
* The RMSE is 0.3263

// variable importance plot: 

matrix importance2 = e(importance)
svmat importance2
generate importid2 = ""
local mynames: rownames importance2
local k: word count `mynames'

if `k' > _N {
	set obs `k' 
}
 
forvalues i = 1(1)`k' {
	local aword: word `i' of `mynames' 
	local alabel: variable label `aword'
	if ("`alabel'"!="") qui replace importid2 = "`alabel'" in `i' 
	else qui replace importid2 = "`aword'" in `i' 
	
} 

graph hbar (mean) importance2 if importance2>.8, over (importid2, sort(1) label(labsize(2)))
generate 
* This graph shows us that the 5 most important factors are one's test scores for Neuroticism, Extraversion, Openness, Agreeableness, and having an own house 


// Random forest to examine the relative importance of variables for Main outcome 2: 

clear 
use OGData

vl create controlvars= (c_age_above_20 c_respondent_maritalstatus2 c_respondent_caste2 c_respondent_caste3 c_respondent_caste4 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Matric_percentage2 c_Inter_exam c_Inter_percentage1 c_Score_BIG5Extraversion c_Score_BIG5Agreeableness c_Score_BIG5Conscientiousness c_Score_BIG5Neuroticism c_Score_BIG5Openness c_Score_Grit c_Score_ASE c_Score_Lifegoals c_duration1 c_householdhead_relationship17 c_householdhead_relationship3 c_difficulty_immediate_famil c_difficulty_future_family c_earning_members2 c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_MNREGA c_SHG_member c_house_type2 c_house_type3 c_house_type4 c_house_ownership c_internet_use c_household_type1 c_number_of_family_members1 c_number_of_family_members3 c_number_of_relatives_migrate2 c_number_of_relatives_migrate3 c_relatives_migrate c_respondent_migrate c_previous_earning c_hypothetical1_earning c_hypothetical2_earning c_expected_earning c_preference_earning c_respondent_awareness_perce c_training_usefulness c_satisfaction c_percentage_training_comple c_job_offer_post_training c_minimum_salary c_maximum_salary c_average_salary c_job_outside_state c_job_acceptance_outside_sta c_job_acceptance_in_state c_job_retention_in_state c_job_retention_outside_stat internet_use)

set seed 72  
clear matrix 
drop if missing(Main_outcome_2_Job_applications)
generate u = runiform()
sort u, stable
generate out_of_bag_error = .
generate validation_error = .
generate iter= .
local j = 0 
forvalues i = 10(5)500{
	local j = `j' + 1
		quietly{
		rforest Main_outcome_2_Job_applications $controlvars in 1/1000, type(reg) iter(`i') numvars(1) seed(72)
		quietly replace iter = `i' in `j'
		quietly replace out_of_bag_error = `e(OOB_Error)' in `j'
		predict pred_outcome1a in 1001/1955
		quietly replace validation_error = `e(RMSE)' in `j'
		drop pred_outcome1a
}	
}

scatter out_of_bag_error iter, mcolor(blue) msize(tiny) || scatter validation_error iter, mcolor(red) msize(tiny)
*We see that both the OOB error and validation error start to converge to a fixed value at roughly 200 iterations, which is also where we get the lowest value for both 
*We can now tune the hyperparameter numvars() to see which one gives the lowest validation RMSE 

set seed 72
generate out_of_bag_error1 = .
generate nvars = .
generate validation_error1 = .
local j = 0 
forvalues i = 1(1)40 {
	local j = `j' + 1 
	rforest Main_outcome_2_Job_applications $controlvars in 1/1000, type(reg) iter(200) numvars(`i')
	quietly replace nvars = `i' in `j'
	quietly replace out_of_bag_error1 = `e(OOB_Error)' in `j'
	predict pred_outcome1b in 1000/1955
	quietly replace validation_error1 = `e(RMSE)' in `j'
	drop pred_outcome1b
}

scatter out_of_bag_error1 nvars, mcolor(blue) msize(tiny) || scatter validation_error1 nvars, mcolor(red) msize(tiny)
* This is a scatter graph visualising the RMSE and the corresponding number of variables at which it is achieved - the graph indicates that we get the lowest error when the random forest model is randomly investigating 3 variables  

capture frame
frame put validation_error1 nvars, into(trialdata)
frame trialdata {
	sort validation_error1, stable
	local min_val_err = validation_error[1]
	local min_nvars = nvars[1]
}

display "Minimum Error: `min_val_err'; Corresponding number of variables `min_nvars'"
frame drop trialdata
* This code provides us with the specific figures to confirm what we saw on the scatter graph. We get the lowest RMSE at 0.2891, which is achieved with 3 variables

// Final model for Main_outcome_2_Job_applications: 
set seed 72
rforest Main_outcome_2_Job_applications c_* in 1/1000, type(reg) iterations(200) numvars(2)

ereturn list OOB_Error
* The OOB_Error is 0.1647
predict pred_outcome1c in 1001/1955 
ereturn list RMSE
* The RMSE is 0.2913

// variable importance plot: 

matrix importance2 = e(importance)
svmat importance2
generate importid2 = ""
local mynames: rownames importance2
local k: word count `mynames'

if `k' > _N {
	set obs `k' 
}
 
forvalues i = 1(1)`k' {
	local aword: word `i' of `mynames' 
	local alabel: variable label `aword'
	if ("`alabel'"!="") qui replace importid2 = "`alabel'" in `i' 
	else qui replace importid2 = "`aword'" in `i' 
	
} 

graph hbar (mean) importance2 if importance2>.8, over (importid2, sort(1) label(labsize(2))) 
generate 
* This graph shows us that the 5 most important factors are one's test scores for Neuroticism, Extraversion, Openness, Agreeableness, and having an one's scores on the ASE Test 





// Random forest model for Main outcome 3: 

clear 
use OGData

vl create controlvars= (c_age_above_20 c_respondent_maritalstatus2 c_respondent_caste2 c_respondent_caste3 c_respondent_caste4 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Matric_percentage2 c_Inter_exam c_Inter_percentage1 c_Score_BIG5Extraversion c_Score_BIG5Agreeableness c_Score_BIG5Conscientiousness c_Score_BIG5Neuroticism c_Score_BIG5Openness c_Score_Grit c_Score_ASE c_Score_Lifegoals c_duration1 c_householdhead_relationship17 c_householdhead_relationship3 c_difficulty_immediate_famil c_difficulty_future_family c_earning_members2 c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_MNREGA c_SHG_member c_house_type2 c_house_type3 c_house_type4 c_house_ownership c_internet_use c_household_type1 c_number_of_family_members1 c_number_of_family_members3 c_number_of_relatives_migrate2 c_number_of_relatives_migrate3 c_relatives_migrate c_respondent_migrate c_previous_earning c_hypothetical1_earning c_hypothetical2_earning c_expected_earning c_preference_earning c_respondent_awareness_perce c_training_usefulness c_satisfaction c_percentage_training_comple c_job_offer_post_training c_minimum_salary c_maximum_salary c_average_salary c_job_outside_state c_job_acceptance_outside_sta c_job_acceptance_in_state c_job_retention_in_state c_job_retention_outside_stat internet_use)

set seed 72  
clear matrix 
drop if missing(Main_outcome_3_Job_applications)
generate u = runiform()
sort u, stable
generate out_of_bag_error = .
generate validation_error = .
generate iter= .
local j = 0 
forvalues i = 10(5)500{
	local j = `j' + 1
		quietly{
		rforest Main_outcome_3_Job_applications $controlvars in 1/1000, type(reg) iter(`i') numvars(1) seed(72)
		quietly replace iter = `i' in `j'
		quietly replace out_of_bag_error = `e(OOB_Error)' in `j'
		predict pred_outcome1a in 1001/1955
		quietly replace validation_error = `e(RMSE)' in `j'
		drop pred_outcome1a
}	
}

scatter out_of_bag_error iter, mcolor(blue) msize(tiny) || scatter validation_error iter, mcolor(red) msize(tiny)
*We see that both the OOB error and validation error start to converge to a fixed value at roughly 100 iterations, which is also where we get the lowest value for both 
*We can now tune the hyperparameter numvars() to see which one gives the lowest validation RMSE 

set seed 72
generate out_of_bag_error1 = .
generate nvars = .
generate validation_error1 = .
local j = 0 
forvalues i = 1(1)40 {
	local j = `j' + 1 
	rforest Main_outcome_3_Job_applications $controlvars in 1/1000, type(reg) iter(100) numvars(`i')
	quietly replace nvars = `i' in `j'
	quietly replace out_of_bag_error1 = `e(OOB_Error)' in `j'
	predict pred_outcome1b in 1000/1955
	quietly replace validation_error1 = `e(RMSE)' in `j'
	drop pred_outcome1b
}

scatter out_of_bag_error1 nvars, mcolor(blue) msize(tiny) || scatter validation_error1 nvars, mcolor(red) msize(tiny)
* This is a scatter graph visualising the RMSE and the corresponding number of variables at which it is achieved - the graph indicates that we get the lowest error when the random forest model is randomly investigating 1 variable

capture frame
frame put validation_error1 nvars, into(trialdata)
frame trialdata {
	sort validation_error1, stable
	local min_val_err = validation_error[1]
	local min_nvars = nvars[1]
}

display "Minimum Error: `min_val_err'; Corresponding number of variables `min_nvars'"
frame drop trialdata
* This code provides us with the specific figures to confirm what we saw on the scatter graph. We get the lowest RMSE at 0.1575, which is achieved with 1 variable

// Final model for Main_outcome_3_Job_applications: 
set seed 72
rforest Main_outcome_3_Job_applications c_* in 1/1000, type(reg) iterations(100) numvars(1)

ereturn list OOB_Error
* The OOB_Error is 0.1627
predict pred_outcome1c in 1001/1955 
ereturn list RMSE
* The RMSE is 0.2907

// variable importance plot: 

matrix importance2 = e(importance)
svmat importance2
generate importid2 = ""
local mynames: rownames importance2
local k: word count `mynames'

if `k' > _N {
	set obs `k' 
}
 
forvalues i = 1(1)`k' {
	local aword: word `i' of `mynames' 
	local alabel: variable label `aword'
	if ("`alabel'"!="") qui replace importid2 = "`alabel'" in `i' 
	else qui replace importid2 = "`aword'" in `i' 
	
} 

graph hbar (mean) importance2 if importance2>.8, over (importid2, sort(1) label(labsize(2)))
generate 
* This graph shows us that the 5 most important factors are one's test scores for Neuroticism, Extraversion, Openness, Conscientousness, and one's scores on the ASE Test 




/*
================================================================================
Replicating Table A9:
================================================================================
*/

egen strata = group(state sector c_gender c_treatment)
xi i.strata 
* Here, I am generating a stratus to control for fixed effects of participants' states, sectors, gender, and their treatment group. I will add these strata to the balance table regressions for each panel. 

local counter = 0 
foreach var of varlist c_age_above_20 c_respondent_maritalstatus2 c_respondent_caste2 c_respondent_caste3 c_respondent_caste4 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Matric_percentage2 c_Inter_exam c_Inter_percentage1 c_Score_BIG5Extraversion c_Score_BIG5Agreeableness c_Score_BIG5Conscientiousness c_Score_BIG5Neuroticism c_Score_BIG5Openness c_Score_Grit c_Score_ASE c_Score_Lifegoals c_duration1 c_householdhead_relationship17 c_householdhead_relationship3 c_difficulty_immediate_famil c_difficulty_future_family c_earning_members2 c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_MNREGA c_SHG_member c_house_type2 c_house_type3 c_house_type4 c_house_ownership c_internet_use c_household_type1 c_number_of_family_members1 c_number_of_family_members3 c_number_of_relatives_migrate2 c_number_of_relatives_migrate3 c_relatives_migrate c_respondent_migrate c_previous_earning c_hypothetical1_earning c_hypothetical2_earning c_expected_earning c_preference_earning c_respondent_awareness_perce c_training_usefulness c_satisfaction c_percentage_training_comple c_job_offer_post_training c_minimum_salary c_maximum_salary c_average_salary c_job_outside_state c_job_acceptance_outside_sta c_job_acceptance_in_state c_job_retention_in_state c_job_retention_outside_stat internet_use{
	local ++counter 
}
display `counter'

global depvar = "c_age_above_20 c_respondent_maritalstatus2 c_respondent_caste2 c_respondent_caste3 c_respondent_caste4 c_respondent_religion2 c_respondent_religion3 c_respondent_education1 c_respondent_education2 c_respondent_education4 c_Matric_exam c_Matric_percentage2 c_Inter_exam c_Inter_percentage1 c_Score_BIG5Extraversion c_Score_BIG5Agreeableness c_Score_BIG5Conscientiousness c_Score_BIG5Neuroticism c_Score_BIG5Openness c_Score_Grit c_Score_ASE c_Score_Lifegoals c_duration1 c_householdhead_relationship17 c_householdhead_relationship3 c_difficulty_immediate_famil c_difficulty_future_family c_earning_members2 c_household_earning1 c_household_earning2 c_household_earning3 c_agriculture_land c_BPL_card c_RSBY_Card c_MNREGA c_SHG_member c_house_type2 c_house_type3 c_house_type4 c_house_ownership c_internet_use c_household_type1 c_number_of_family_members1 c_number_of_family_members3 c_number_of_relatives_migrate2 c_number_of_relatives_migrate3 c_relatives_migrate c_respondent_migrate c_previous_earning c_hypothetical1_earning c_hypothetical2_earning c_expected_earning c_preference_earning c_respondent_awareness_perce c_training_usefulness c_satisfaction c_percentage_training_comple c_job_offer_post_training c_minimum_salary c_maximum_salary c_average_salary c_job_outside_state c_job_acceptance_outside_sta c_job_acceptance_in_state c_job_retention_in_state c_job_retention_outside_stat internet_use"


eststo clear
local counter=0
quietly{
	
 foreach depvar of varlist  $depvar  {  
local ++counter
	nois display "Now doing `depvar'"
	
	
	eststo results_`counter': reg `depvar' treatment i.strata
	reg `depvar' treatment i.strata
	test treatment
	local pvalue=`r(p)'
	est restore results_`counter'
	estadd scalar pvalue=`pvalue'
	eststo results_`counter': su `depvar' if treatment==0
	estadd scalar control_mean=r(mean)
	eststo results_`counter': su `depvar' if treatment==1
	estadd scalar treatment_mean=r(mean)
	
}
}

esttab using "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\TableA9.csv", replace ///
star(* 0.1 ** 0.05 *** 0.01) b(3) se(3) ///
keep(treatment) scalars(pvalue control_mean treatment_mean)


/*
========================================================================================================
Extension for Table A9: Cohen's d test for practical significance between control and treatment groups: 
========================================================================================================
*/ 

// Here, I am using Cohen's d test to see if the differnces between the control and treatment groups for the 5 variables that had statistically significant differences at the 5% and 10% levlels are "practically significant" 

// Proportion of individuals who got more than 50% in the Matric exam: 
su c_Matric_percentage2 if treatment == 0
scalar mean_1 = r(mean)
scalar sd_1 = r(sd)
su c_Matric_percentage2 if treatment == 1
scalar mean_2 = r(mean)
scalar dtest = (mean_1 - mean_2)/sd_1 
display dtest 
* The d test for Matric_percentage2 is 0.08767

// Proportion of individuals with 3 or more family members earning a living: 

su c_earning_members2 if treatment == 0
scalar mean_1 = r(mean) 
scalar sd_1 = r(sd)
su c_earning_members2 if treatment == 1
scalar mean_2 = r(mean)
scalar dtest = (mean_1 - mean_2)/sd_1 
display dtest 
* The d test for earning_members2 is -0.0870

// Proportion of individuals with joint households: 

su c_household_type1 if treatment == 0
scalar mean_1 = r(mean) 
scalar sd_1 = r(sd)
su c_household_type1 if treatment == 1
scalar mean_2 = r(mean)
scalar dtest = (mean_1 - mean_2)/sd_1 
display dtest 
* The d test for household_type1 is -0.0833

// Proportion of individuals with 3 or more relatives who migrated:
su c_number_of_relatives_migrate2 if treatment == 0
scalar mean_1 = r(mean) 
scalar sd_1 = r(sd)
su c_number_of_relatives_migrate2 if treatment == 1
scalar mean_2 = r(mean)
scalar dtest = (mean_1 - mean_2)/sd_1 
display dtest 
* The d test for c_number_of_relatives_migrate2 is -0.0929

// Proportion of individuals who prefer earnings to be above the median wage 
su c_preference_earning if treatment == 0
scalar mean_1 = r(mean) 
scalar sd_1 = r(sd)
su c_preference_earning if treatment == 1
scalar mean_2 = r(mean)
scalar dtest = (mean_1 - mean_2)/sd_1 
display dtest 
* The d test for c_preference_earning is 0.0893

// Cohen's d for all 5 variables have a magnitude that is less than 0.1, indicating that they have a very small effect size and that the control and treatment groups are balanced well 

