** POOLED OLS REGRESSION WITH DUMMIES
regress log_marriages birth_rate fertility_rate n_repro_female f_employment_rate m_employment_rate f_mean_income m_mean_income gdp closing_housing_price mean_age_childbearing demand_for_family percentage_female_work_home percentage_male_work_home consumer_price_harmonized_index senior_position_woman tertiary_ed_f tertiary_ed_m  parliament_female year_dummy2 year_dummy3 year_dummy4 year_dummy5 year_dummy6 year_dummy7 year_dummy8 year_dummy9 year_dummy10 year_dummy11 year_dummy12 year_dummy13 year_dummy14


vif


** F test dummies
testparm year_dummy2 year_dummy3 year_dummy4 year_dummy5 year_dummy6 year_dummy7 year_dummy8 year_dummy9 year_dummy10 year_dummy11 year_dummy12 year_dummy13 year_dummy14


regress log_marriages birth_rate fertility_rate f_employment_rate m_employment_rate f_mean_income closing_housing_price mean_age_childbearing demand_for_family gdp  percentage_female_work_home consumer_price_harmonized_index senior_position_woman tertiary_ed_f tertiary_ed_m parliament_female

vif


** Final POOLED OLS REGRESSION 
regress log_marriages f_employment_rate f_mean_income closing_housing_price mean_age_childbearing gdp tertiary_ed_f tertiary_ed_m parliament_female


** test for heteroskedasticity
estat hettest

estat imtest, white

** calculate residuals
predict residuals, resid

** Check overdispersion
summarize residuals, meanonly

local meanres = r(mean)

histogram residuals, xline(`meanres', lcolor(red)) normal


** Correction of heteroskedasticity
hetregress log_marriages f_employment_rate f_mean_income closing_housing_price gdp tertiary_ed_f tertiary_ed_m parliament_female , het(f_mean_income mean_age_childbearing parliament_female)


** ols vs re
xtreg log_marriages f_employment_rate f_mean_income closing_housing_price gdp tertiary_ed_f tertiary_ed_m parliament_female, re

xttest0


** store fixed effect
xtreg log_marriages f_employment_rate f_mean_income closing_housing_price gdp tertiary_ed_f tertiary_ed_m parliament_female, fe

estimates store fixed


** store random effect
xtreg log_marriages f_employment_rate f_mean_income closing_housing_price gdp tertiary_ed_f tertiary_ed_m parliament_female, re

estimates store random


** hausma test between fixed effect and random effect with correction on matrix of variance-covariance
hausman fixed random ,sigmamore


** improving models
xtreg log_marriages birth_rate n_repro_female gdp m_employment_rate f_employment_rate percentage_female_work_home consumer_price_harmonized_index f_mean_age_marriage year_dummy7 year_dummy8 year_dummy9, fe


xtreg log_marriages birth_rate n_repro_female gdp m_employment_rate f_employment_rate percentage_female_work_home consumer_price_harmonized_index f_mean_age_marriage year_dummy7 year_dummy8 year_dummy9, re


** generate variables for first differencing
gen d_log_marriages =  D.log_marriages
gen d_birth_rate = D.birth_rate
gen d_n_repro_female = D.n_repro_female
gen d_gdp = D.gdp
gen d_m_employment_rate = D.m_employment_rate
gen d_f_employment_rate = D.f_employment_rate
gen d_percentage_female_work_home = D.percentage_female_work_home
gen d_cpriceharmonizedindex = D.consumer_price_harmonized_index
gen d_f_mean_age_marriage = D.f_mean_age_marriage
gen d_year_dummy7 = D.year_dummy7
gen d_year_dummy8 = D.year_dummy8
gen d_year_dummy9 = D.year_dummy9


** first differentiation model
reg d_log_marriages d_birth_rate d_n_repro_female d_gdp d_m_employment_rate d_f_employment_rate d_percentage_female_work_home d_cprice harmonizedindex d_f_mean_age_marriage d_year_dummy7 d_year_dummy8 d_year_dummy9

predict resid_d , resid

summarize resid_d ,detail

** all scatter of resid_d vs independent variables to see that the variance is constant



** Poisson Regression
xtpoisson marriages f_employment_rate f_mean_income closing_housing_price mean_age_childbearing gdp tertiary_ed_f tertiary_ed_m parliament_female, fe

xtpoisson marriages f_employment_rate f_mean_income closing_housing_price mean_age_childbearing gdp tertiary_ed_f tertiary_ed_m parliament_female, re


summarize marriages ,detail

** Negative Binomial Regression
xtnbreg marriages f_employment_rate f_mean_income closing_housing_price mean_age_childbearing gdp tertiary_ed_f tertiary_ed_m parliament_female, fe

xtnbreg marriages f_employment_rate f_mean_income closing_housing_price mean_age_childbearing gdp tertiary_ed_f tertiary_ed_m parliament_female, re

















