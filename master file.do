*===============================
*========Team 10 do-files=======
*===============================

*-------------------
*Directory Settings
*-------------------

*IMPORTANT: Uncomment your file path when running this do-files

*cd "C:\Users\yehua\OneDrive - Business\Desktop\econ 490 quizs"
*recommended
*global file_path "C:\Users\yehua\OneDrive - Business\" // ye
global file_path "C:\Users\syifa\OneDrive - UBC\" // syifani
*global file_path "/Users/samanthaburton/Library/CloudStorage/OneDrive-UBC" // samantha

*Project Identifier
global proj_name "ECON_V 490 006 2025W2 Seminar in Applied Economics - Team 10"
global proj_main "${file_path}\${proj_name}\Main folder"

*Folder path
global data "${proj_main}\1. data" 
global dofi "${proj_main}\2. do-files"
global logfi "${proj_main}\3. log_files"
global tables "${proj_main}\4. tables"
global figures "${proj_main}\5. figures"

*directory path
cd "${proj_main}"

*Saving Log-File
capture log close 
log using "${logfi}\team10.log", text replace

*Open data from Penn World Table 
use "${data}\pwt110.dta", clear

*generate solow variables global
global solow_variables "cgdpe pop csh_i hc"
keep year countrycode ${solow_variables}

*generate log variables
gen lnsave=ln(csh_i)
gen lnschool=ln(hc)
save "${data}\solowsubset", replace

*our chosen variable: Incidence of tuberculosis
wbopendata, indicator(SH.TBS.INCD) clear long
merge 1:1 countrycode year using "${data}\solowsubset"
drop if _merge!=3
drop _merge
rename sh_tbs_incd tb
gen lntb = ln(tb)

*numeric variable
encode countrycode, gen(ccode)

*declare panel structure
tsset ccode year


*One more important warning: if any country-year has tb<=0, then ln(tb) will fail.
sum tb, detail
count if tb<=0
*there are 37 zeros
gen lag_lntb = L1.lntb
gen lntb1 = ln(lntb + 1)
gen lag_lntb1 = L1.lntb1
*the natural log of the growth rate of real GDP
gen lngdp=ln(cgdpe/pop)
gen dlngdp=ln(ln(cgdpe/pop)-ln(L1.lngdp/L1.pop))
*the natural log of the growth rate the population
gen lnpop=ln(ln(pop) - ln(L1.pop))

*Run the long run growth accounting analysis using panel data regression with both time and region fixed effects. 
*regression with lntb
xtreg dlngdp L1.lngdp lnsave lnschool lnpop lntb i.year i.ccode, fe
testparm i.year
*regression with lag_lntb
xtreg dlngdp L1.lngdp lnsave lnschool lnpop lag_lntb i.year i.ccode, fe
testparm i.year
*regression with lntb1
xtreg dlngdp L1.lngdp lnsave lnschool lnpop lntb1 i.year i.ccode, fe
testparm i.year
*regression with lag_lntb1
xtreg dlngdp L1.lngdp lnsave lnschool lnpop lag_lntb1 i.year i.ccode, fe
testparm i.year
*heteroskedastic
xttest3
*serial correlation
xtserial lngdp lnsave lnschool lnpop lntb
*regression to correct for all of these errors
xtpcse dlngdp L1.lngdp lnsave lnschool lnpop lntb i.year i.ccode, het corr(ar1)
*regression interaction
xtpcse dlngdp L1.lngdp lnsave lnschool lnpop c.lntb##c.lntb i.year i.ccode, het corr(ar1)
tab region, gen(regdummy)
global regiondummies "regdummy1 regdummy2 regdummy3 regdummy4 regdummy5 regdummy6 regdummy7"
reg gdp ${x_variables} i.year ${regiondummies



