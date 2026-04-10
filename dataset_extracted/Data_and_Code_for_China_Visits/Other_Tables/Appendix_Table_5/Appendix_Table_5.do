use ./../china_visits_panel.dta

keep if Africa == 1
keep if president + premier > 0

* row 1, president: 6
count if president> 0 & year >= 2001 & year <= 2005
* row 1, premier: 7
count if premier> 0 & year >= 2001 & year <= 2005

* row 2, president: 15
count if president> 0 & year >= 2006 & year <= 2012
* row 2, premier: 8
count if premier> 0 & year >= 2006 & year <= 2012
clear
