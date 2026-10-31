clear all
use "Tables_2_3_4_A1_A2_A3.dta"
set more off
*
gen lC =log(C)
gen lIncome=log(Income)
gen lSize=log(Size)
*
*TABLE 2
preserve
quietly {
est clear

keep if Year==1980 | Year==1981
keep if Region==15 | Region==17
g YEAR=(Year==1981)
g DD=OO*YEAR
label var DD "Diff-in-Diff 1980-81"
label var OO "Diff 1980"
est clear
foreach x in Size Age Education Employed Employee Wealth Income {
eststo: regress `x' DD OO YEAR
}
}
esttab _all, keep(DD OO) order(OO DD) b(1) ar2(2) label compress
restore

*TABLE 3
preserve
quietly {
est clear
label var OO "HS (Housing Status)"
gen ParkerYear = ((Region==15 & Year==1981)|(Region==17 & Year==1982))
label var ParkerYear "RF (Reconstruction Funds Region)"
gen OOcumTRANSFER= OO*ParkerYear
label var OOcumTRANSFER "HS*RF"

gen Year82=(Year==1982)
gen Campania=(Region==15)

keep if Year>=1981 & Year<=1982
keep if Region==15 | Region==17

local dumpanel Year82 Campania 
local controlli Income Size ///
Earners Head Age Rent i.Education i.Sector i.Occupation1 i.Occupation2 i.Irr i.Pop
eststo: xi: reg C OOcumTRANSFER `dumpanel', r
eststo: xi: reg C OOcumTRANSFER OO ParkerYear `controlli' `dumpanel', r
eststo: xi: reg C OOcumTRANSFER `controlli' `dumpanel' if OO==1, r
*
local dumpanel Year82 Campania
local controlli lIncome lSize ///
Earners Head Age Rent i.Education i.Sector i.Occupation1 i.Occupation2 i.Irr i.Pop
eststo: xi: reg lC OOcumTRANSFER `dumpanel', r
eststo: xi: reg lC OOcumTRANSFER OO ParkerYear `controlli' `dumpanel', r
eststo: xi: reg lC OOcumTRANSFER `controlli' `dumpanel' if OO==1, r
}
*
esttab , ar2(2) title(Consumption and Early Access to Reconstruction Funds) se star(* 0.10 ** 0.05 *** 0.01) ///
keep(OOcumTRANSFER ParkerYear OO) order(OOcumTRANSFER ParkerYear OO) b(2) label nomtitle nodepvar
restore

*TABLE 4
quietly {
est clear
gen Quake_Area=(Region==15 | Region==17)

local controlli i.Year ///
Earners Head Age Rent i.Education i.Sector i.Occupation1 i.Occupation2 i.Irr i.Pop
local residui r
fvset base 1979 Year
*
preserve
g QUAKE=(Quake_Area==1 & Year>=1981)
eststo: reg C QUAKE Quake_Area Income Size `controlli' if OO==1 & (Year>=1980 & Year<=1984), r
restore
*
preserve
g QUAKE=(Quake_Area==1 & Year>=1981)
eststo: reg C QUAKE Quake_Area Income Size `controlli' if OO==1 & (Year>=1980 & Year<=1982), r
restore
*
preserve
g QUAKE=(Quake_Area==1 & Year>=1983)
eststo: reg C QUAKE Quake_Area Income Size `controlli' if OO==1 & (Year>=1981 & Year<=1984), r
restore
*
preserve
g QUAKE=(Quake_Area==1 & Year>=1981)
eststo: reg lC QUAKE Quake_Area lIncome lSize `controlli' if OO==1 & (Year>=1980 & Year<=1984), r
restore
*
preserve
g QUAKE=(Quake_Area==1 & Year>=1981)
eststo: reg lC QUAKE Quake_Area lIncome lSize `controlli' if OO==1 & (Year>=1980 & Year<=1982), r
restore
*
preserve
g QUAKE=(Quake_Area==1 & Year>=1983)
eststo: reg lC QUAKE Quake_Area lIncome lSize `controlli' if OO==1 & (Year>=1981 & Year<=1984), r
restore
}
esttab , title(The Medium-run Evolution of Consumption after the Earthquake) star(* 0.10 ** 0.05 *** 0.01) ///
keep(QUAKE) order(QUAKE) b(2) ar2(2) se label nomtitle nodepvar

*TABLE A1
preserve
quietly {
keep if Year==1980 | Year==1981 | Year==1982
keep if Region==15 | Region==17

by OO Year Region, sort: gen Observations = _N 

eststo clear
estpost tabstat Size Age Education Employed Employee Wealth Income Observations if OO==1 & Year==1980, columns(statistics) statistics(mean) by(Region) nototal
eststo
estpost tabstat Size Age Education Employed Employee Wealth Income Observations if OO==0 & Year==1980, columns(statistics) statistics(mean) by(Region) nototal
eststo
estpost tabstat Size Age Education Employed Employee Wealth Income Observations if OO==1 & Year==1981, columns(statistics) statistics(mean) by(Region) nototal
eststo
estpost tabstat Size Age Education Employed Employee Wealth Income Observations if OO==0 & Year==1981, columns(statistics) statistics(mean) by(Region) nototal
eststo
}
*
esttab _all, label noobs nonumber mtitle(1980 1980 1981 1981) ///
cells(mean(fmt(%10.1fc %10.1fc %10.1fc %10.1fc %10.1fc %10.0fc %10.0fc %10.0fc ///
               %10.1fc %10.1fc %10.1fc %10.1fc %10.1fc %10.0fc %10.0fc %10.0fc))) ///
title(Households Characteristics) ///
postfoot(\hline\hline\multicolumn{5}{p{10cm}} ///
{\footnotesize Note: The table reports the mean of the characteristics of the households living in the area affected by the 1980 earthquake listed n the first column. Panel A refers to residents in Campania, Panel B to resident in Basilicta. Results are reported by home ownership (homeowners and non-homeowners) and year (1980 and 1981). Size is the number of households components; Age is the householder age; Education is an index of educational qualification (1 = none, 2 = elementary school, 3 = middle school, 4 = high school, 5 = bachelor’s degree, 6 = post-graduate qualification); Employed is the percentage of employed householders; Employee is the percentage of employee among householders; Wealth is the value of total assets; Income is net disposable income excluding income from financial assets. MonAgery values are expressed as thousands of Italian Lira.} ///
\end{tabular}\end{table})
restore
*

*TABLE A2
quietly {
est clear

foreach regione in 15 17 {
foreach year in 1981 1982 {
g Post=(Year==`year')
g HS_Year=OO*Post

local controlli Income Size ///
Earners Head Age Rent i.Education i.Sector i.Occupation1 i.Occupation2 i.Irr i.Pop
eststo: xi: reg C HS_Year OO Post `controlli' if (Year==`year'-1 | Year==`year') & Region==`regione', r
drop Post HS_Year
}
}
}
esttab est*, compress ar2(2) se star(* 0.10 ** 0.05 *** 0.01) ///
keep(HS_Year) mtitle(80-81 81-82 80-81 81-82) b(1) label nodepvar ///
title(Consumption and Early Access to Reconstruction Funds, Further Evidence)
*
quietly {
est clear
foreach regione in 15 17 {
foreach year in 1981 1982 {
g Post=(Year==`year')
g HS_Year=OO*Post

local controlli lIncome lSize ///
Earners Head Age Rent i.Education i.Sector i.Occupation1 i.Occupation2 i.Irr i.Pop
eststo: xi: reg lC HS_Year OO Post `controlli' if (Year==`year'-1 | Year==`year') & Region==`regione', r
drop Post HS_Year
}
}
}
esttab est*, compress b(2) ar2(2) se star(* 0.10 ** 0.05 *** 0.01) ///
keep(HS_Year) mtitle(80-81 81-82 80-81 81-82) label nodepvar ///
title(Consumption and Early Access to Reconstruction Funds, Further Evidence)
*

*Table A3
quietly {

est clear
g Post=(Year==1981)
drop if Value==.
sum Value,d
local medianValue r(p50)
g Above_Value=(Value>`medianValue')
g ValueYear=Above_Value*Post

local controlli Income Size ///
Earners Head Age Rent i.Education i.Sector i.Occupation1 i.Occupation2 i.Irr i.Pop
eststo: xi: reg C ValueYear Above_Value Post `controlli' if OO==1 & Region==15 & (Year>=1980 & Year<=1981), r

local controlli lIncome lSize ///
Earners Head Age Rent i.Education i.Sector i.Occupation1 i.Occupation2 i.Irr i.Pop
eststo: xi: reg lC ValueYear Above_Value Post `controlli' if OO==1 & Region==15 & (Year>=1980 & Year<=1981), r

label var Post "YEAR"
label var Above_Value "ABOVE"
label var ValueYear "ABOVE*YEAR"
}
esttab est*, compress b(2) ar2(2) se star(* 0.10 ** 0.05 *** 0.01) ///
keep(ValueYear Above_Value Post) nomtitle label nodepvar ///
title(Consumption and the Value of the House)
