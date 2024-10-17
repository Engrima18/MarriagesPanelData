*Encode nation into numeric id
encode(nation) , gen(numeric_Nation)

* set the panel data
xtset numeric_Nation year


 Exploratory Data Analysis
gen ProportionNewMarriages = marriages/population
gen ProportionNewDivorces = divorces/population


* Proportion of new marriages 
twoway (line  ProportionNewMarriages year, sort), by(numeric_Nation, col(5) note(""))

* Proportion of new divorces 
twoway (line  ProportionNewDivorces year, sort), by(numeric_Nation, col(5) note(""))



* Scatterplot marriages vs independent variables
twoway scatter marriages birth_rate, name(scatter1, replace)
twoway scatter marriages fertility_rate, name(scatter2, replace)
twoway scatter marriages m_employment_rate, name(scatter3, replace)
twoway scatter marriages f_employment_rate, name(scatter4, replace)
twoway scatter marriages f_mean_income, name(scatter5, replace)
twoway scatter marriages m_mean_income, name(scatter6, replace)
twoway scatter marriages n_repro_female, name(scatter7, replace)
twoway scatter marriages gdp, name(scatter8, replace)
twoway scatter marriages employment_gender_gap, name(scatter9, replace)
twoway scatter marriages closing_housing_price, name(scatter10, replace)
twoway scatter marriages mean_age_childbearing, name(scatter11, replace)
twoway scatter marriages demand_for_family, name(scatter12, replace)


graph combine scatter1 scatter2 scatter3 scatter4 scatter5 scatter6 scatter7 scatter8 scatter9 scatter10 scatter11 scatter12///
    title("Marriages and Independent Variables") col(4)
	
	
	
* Scatterplot divorces vs independent variables
twoway scatter divorces birth_rate, name(scatter1, replace)
twoway scatter divorces fertility_rate, name(scatter2, replace)
twoway scatter divorces m_employment_rate, name(scatter3, replace)
twoway scatter divorces f_employment_rate, name(scatter4, replace)
twoway scatter divorces f_mean_income, name(scatter5, replace)
twoway scatter divorces m_mean_income, name(scatter6, replace)
twoway scatter divorces n_repro_female, name(scatter7, replace)
twoway scatter divorces gdp, name(scatter8, replace)
twoway scatter divorces employment_gender_gap, name(scatter9, replace)
twoway scatter divorces closing_housing_price, name(scatter10, replace)
twoway scatter divorces mean_age_childbearing, name(scatter11, replace)
twoway scatter divorces demand_for_family, name(scatter12, replace)



graph combine scatter1 scatter2 scatter3 scatter4 scatter5 scatter6 scatter7 scatter8 scatter9 scatter10 scatter11 scatter12, col(4)



* Generate dummy variables of year for OLS and/or FIRST DIFFERENTIETING MODEL
tabulate year, generate(year_dummy)

	
* feature engeneering

gen log_marriages = log(marriages)
gen sq_f_mean_income = f_mean_income^2
gen sq_m_mean_income = m_mean_income^2
gen log_f_mean_income = log(f_mean_income)
gen log_gdp = log(gdp)
gen log_n_repro = log(n_repro_female)
gen log_housing_price = log(closing_housing_price)
gen log_demand = log(demand_for_family)
gen log_cph = log(consumer_price_harmonized_index)
gen log_m_employ = log(m_employment_rate)
gen log_f_employ = log(f_employment_rate)
gen gdp_by_pop = gdp/population
gen income_gap = m_mean_income - f_mean_income

	
	
	
	