use "Tables_5_6_7_8.dta", clear

foreach x in C CF CO Income Size {
g l`x'=log(`x')
}
*
local controlli s2.lIncome s2.lSize s2.Earners Head Age i.Education i.Sectornew i.Occupation1 i.Pop

*TABLE 5
quietly {
g ILLIQUIDI2012=0
replace ILLIQUIDI2012=1 if INDEXLIQ==1 & Year==2012
replace ILLIQUIDI2012=1 if f2.INDEXLIQ==1 & Year==2010
label var ILLIQUIDI2012 "ILLIQUID-DEBT"

g C1=EMILIA*ILLIQUIDI2012
label var C1 "ILLIQUID-DEBT*EMILIA"

est clear
eststo: reg s2.lC EMILIA C1 ILLIQUIDI2012 `controlli' if OO==1 & Year==2012, r
eststo: reg s2.lC EMILIA C1 ILLIQUIDI2012 `controlli' l2.s2.lC if OO==1 & Year==2012, r
eststo: reg s2.lC EMILIA `controlli' l2.s2.lC if OO==1 & INDEXLIQ==1, r
eststo: reg s2.lC EMILIA `controlli' l2.s2.lC if OO==1 & INDEXLIQ==0, r
}
esttab , b(2) label ar2(2) se star(* 0.10 ** 0.05 *** 0.01) ///
keep(EMILIA C1 ILLIQUIDI2012) order(EMILIA ILLIQUIDI2012 C1) nodepvar mtitle("ALL" "ALL" "ILLIQ=0" "ILLIQ=1") ///
title(Consumption, Liquidity, and Reconstruction Funds)

*TABLE 6
quietly {
est clear
eststo: reg s2.lCF EMILIA `controlli' l2.s2.lCF if OO==1 & INDEXLIQ==1, r
eststo: reg s2.lCF EMILIA `controlli' l2.s2.lCF if OO==1 & INDEXLIQ==0, r
eststo: reg s2.lCO EMILIA `controlli' l2.s2.lCO if OO==1 & INDEXLIQ==1, r
eststo: reg s2.lCO EMILIA `controlli' l2.s2.lCO if OO==1 & INDEXLIQ==0, r
}
esttab , b(2) label ar2(2) se star(* 0.10 ** 0.05 *** 0.01) ///
keep(EMILIA) nodepvar mtitle("Food" "Food" "Others" "others") ///
title(Food and other Nondurables)

*TABLE 7
quietly {
est clear
eststo: reg s2.lC EMILIA `controlli' l2.s2.lC if OO==1 & INDEXLIQ04==1, r
eststo: reg s2.lC EMILIA `controlli' l2.s2.lC if OO==1 & INDEXLIQ03==1, r
eststo: reg s2.lC EMILIA `controlli' l2.s2.lC if OO==1 & INDEXLIQ02==1, r
}
esttab , b(2) compress label ar2(2) se star(* 0.10 ** 0.05 *** 0.01) ///
keep(EMILIA) nodepvar mtitle("0.4" "0.3" "0.2") ///
title(Further Results for Consumption and Liquidity)

*TABLE 8
quietly {
keep if OO==1
keep if Estate>0

g ID_DEBT=(Debt>0 & Debt<.)
g DEBT_INCOME=(Debt/Income)*100
by ID_DEBT Year AREA , sort: gen Observations = _N
label var Observations "Number of Households"
label var DEBT_INCOME "Debt to Income"
*
est clear
eststo clear
estpost tabstat Observations Debt DEBT_INCOME if ID_DEBT==1 & Year==2008, columns(statistics) statistics(mean) by(AREA) nototal
eststo
estpost tabstat Observations Debt DEBT_INCOME if ID_DEBT==1 & Year==2010, columns(statistics) statistics(mean) by(AREA) nototal
eststo
estpost tabstat Observations Debt DEBT_INCOME if ID_DEBT==1 & Year==2012, columns(statistics) statistics(mean) by(AREA) nototal
eststo
}
*
esttab _all, cells(mean(fmt(%10.1fc ))) nodepvar label mtitle(2008 2010 2012) ///
title(Evolution of Debt around the Earthquake Year)
