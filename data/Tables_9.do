*
use "Tables_9.dta", clear
*
foreach x in C Income Size {
g l`x'=log(`x')
}
*
quietly {
g ILLIQUIDI2010=0
replace ILLIQUIDI2010=1 if INDEXLIQ==1 & Year==2010
replace ILLIQUIDI2010=1 if f2.INDEXLIQ==1 & Year==2008
label var ILLIQUIDI2010 "ILLIQUID-DEBT"
*
g C1=ABRUZZO*ILLIQUIDI2010
label var C1 "ILLIQUID-DEBT * ABRUZZO"
*
local controlli s2.lIncome s2.lSize s2.Earners Head Age i.Education i.Sectornew i.Occupation1 i.Pop
est clear
eststo: reg s2.lC ABRUZZO C1 ILLIQUIDI2010 `controlli' if OO==1 & Year==2010, r
eststo: reg s2.lC ABRUZZO C1 ILLIQUIDI2010 `controlli' l2.s2.lC if OO==1 & Year==2010, r
eststo: reg s2.lC ABRUZZO `controlli' l2.s2.lC if OO==1 & INDEXLIQ==1, r
eststo: reg s2.lC ABRUZZO `controlli' l2.s2.lC if OO==1 & INDEXLIQ==0, r
}
esttab , b(2) label ar2(2) se star(* 0.10 ** 0.05 *** 0.01) ///
keep(ABRUZZO C1 ILLIQUIDI2010) order(ABRUZZO ILLIQUIDI2010 C1) nodepvar mtitle("ALL" "ALL" "ILLIQ=0" "ILLIQ=1") ///
title(Consumption and In-kind Reconstruction Funds)
