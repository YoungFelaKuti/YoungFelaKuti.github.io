use ./../china_visits_panel.dta
* omit visits by Premier Li Peng, so as to be consistent with Kastner and Saunders (2012)
replace premier = 0 if (country == "Russian Federation" | country == "Netherlands" | country == "Luxembourg") & year == 1998

gen visits = president + premier
keep if year>=1998 & year<=2002
collapse (sum)visits, by(ccode country)
label var visits "China Visits"
gsort -visits
rename ccode countryisocode
sort countryisocode
* JiangZhuReplication1.dta is processed with the following command:
* * keep if totalPresPremvisits > 0 | totalPresPremNonConf > 0
merge 1:1 countryisocode using "Kastner_Saunders_2012/JiangZhuReplication1.dta", keepusing(totalPresPremvisits totalPresPremNonConf)

replace visits = 0 if visits == .
replace totalPresPremvisits = 0 if totalPresPremvisits == .
replace totalPresPremNonConf = 0 if totalPresPremNonConf == .

gsort -totalPresPremvisits -totalPresPremNonConf country
drop countryisocode _merge
order country totalPresPremvisits visits totalPresPremNonConf
keep if totalPresPremvisits < visits | visits < totalPresPremNonConf
* this generates the top 11 rows in Appendix_Table_4
export delimited using "Appendix_Table_4_Top_11_Rows.csv", delimiter(tab) replace
clear




use ./../china_visits_panel.dta
gen visits = president + premier
keep if year>=2003 & year<=2008
collapse (sum)visits, by(ccode country)
label var visits "China Visits"
gsort -visits
rename ccode countryisocode
sort countryisocode
* HuWenReplication.dta is processed with the following command:
* * keep if totalPresPremvisits > 0 | totalPresPremNonConf > 0
merge 1:1 countryisocode using "Kastner_Saunders_2012/HuWenReplication.dta", keepusing(totalPresPremvisits totalPresPremNonConf)

replace visits = 0 if visits == .
replace totalPresPremvisits = 0 if totalPresPremvisits == .
replace totalPresPremNonConf = 0 if totalPresPremNonConf == .

gsort -totalPresPremvisits -totalPresPremNonConf country
drop countryisocode _merge
order country totalPresPremvisits visits totalPresPremNonConf
keep if totalPresPremvisits < visits | visits < totalPresPremNonConf
* this generates the bottom 6 rows in Appendix_Table_4
export delimited using "Appendix_Table_4_Bottom_6_Rows.csv", delimiter(tab) replace
clear



