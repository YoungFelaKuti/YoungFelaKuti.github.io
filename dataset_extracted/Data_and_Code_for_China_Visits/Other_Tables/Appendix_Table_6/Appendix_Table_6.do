use ./../china_visits_panel.dta
keep if year <= 2006
drop if country == "United States" | country == "Russian Federation"

* preprocessing of MID Initiation Data - JOP Final Version.dta from https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/WM0XNF

// keep if vis_chi_b1 == 1
// duplicates drop year ccodeb, force
// keep ccodeb year
// rename ccodeb cow
// replace year = year - 1
// keep if year >= 1998 & year <= 2006
// sort cow year

sort cow year 
merge cow year using "MID Initiation Data - JOP Final Version.dta"
sort year country
* print out the six visits that we missed
list country year if _merge == 3 & president == 0
* print out the five visits that McManus (2018) missed
list country year if _merge == 1 & president == 1
