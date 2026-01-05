use "C:\Users\abhik\OneDrive\Desktop\Year 3\EC348\Assignment 1\Data_Covid_Paper_assignment.dta" 
save OGData, replace
*I have included the "save OGData" command for convenience later on in the do file, especially when running the random forest model, to be able to revert to the original dataset 

/* 
================================================================================
Using a random forest model
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
