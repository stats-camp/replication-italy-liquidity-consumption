* Table 1 AEJ_Macroeconomics
clear all
use "Tables_1.dta"

eststo clear
estpost tabstat PopCamRel, columns(statistics) statistics(mean) by(Year) nototal
eststo
estpost tabstat PopBasRel, columns(statistics) statistics(mean) by(Year) nototal
eststo
esttab _all, label noobs nonumber mtitle(Campania Basilicata) ///
cells(mean(fmt(%10.2fc))) ///
title(Evolution of Population) ///
postfoot(\hline\hline\multicolumn{3}{p{12cm}} ///
{\footnotesize Note: The table reports the evolution of population in the earthquake area around the year of the earthquake.} ///
Values are expressed as percentage points of Italian population. Source is ISTAT. ///
\end{tabular}\end{table})
*
