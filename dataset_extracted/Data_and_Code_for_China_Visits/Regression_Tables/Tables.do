est clear
clear
use "determinants.dta"

drop if taiwan == 1

* Appendix: Table 8
estpost sum president premier log_population log_gdp_per_capita gdp_growth resources logdist major_power japan polity2 pctagreechina DL sco asean
esttab using Appendix_Table_8.tex, label replace cells("mean(fmt(2)) min(fmt(2)) max(fmt(2)) sd(fmt(2)) count(fmt(0))")

* Appendix: Table 9
estpost corr president premier log_population log_gdp_per_capita gdp_growth resources logdist major_power japan polity2 pctagreechina DL sco asean, matrix listwise
esttab using Appendix_Table_9.tex, label replace unstack not noobs compres nostar b(%3.2f)

* Main: Table 6 
est clear
eststo: probit president log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina DL i.year, robust cluster (ccode)
eststo: probit president log_population log_gdp_per_capita gdp_growth  resources logdist sco asean i.year, robust cluster (ccode)
eststo: probit president log_population log_gdp_per_capita gdp_growth  resources logdist president_l1 premier_l1 i.year, robust cluster (ccode)
eststo: probit president log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina DL sco asean president_l1 premier_l1 i.year, robust cluster (ccode)

eststo: probit premier log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina DL i.year, robust cluster (ccode)
eststo: probit premier log_population log_gdp_per_capita gdp_growth  resources logdist sco asean i.year, robust cluster (ccode)
eststo: probit premier log_population log_gdp_per_capita gdp_growth  resources logdist president_l1 premier_l1 i.year, robust cluster (ccode)
eststo: probit premier log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina DL sco asean president_l1 premier_l1 i.year, robust cluster (ccode)

esttab, star(* 0.10 ** 0.05 *** 0.01) label se pr2 replace
esttab using Main_Table_6.tex,  star(* 0.10 ** 0.05 *** 0.01) label se pr2 replace title(Determinants of Chinese Leader Visits) mtitle("Pols" "IOs" "Visits" "All" "Pols" "IOs" "Visits" "All") nogap b(%4.2f)

* Main: Section 4.3
* Substantive Interpretations
* reference: https://stats.oarc.ucla.edu/stata/dae/using-margins-for-predicted-probabilities/
local run_probit "probit president log_population log_gdp_per_capita gdp_growth  resources logdist i.major_power i.japan polity2 pctagreechina i.sco asean president_l1 premier_l1 i.year, robust cluster (ccode)"

** [population]
* log_population: mean 15.72579  std 1.985766  sum 17.711556
`run_probit'
sum log_population  
margins, at(log_population=(15.72579 17.711556)) atmeans vsquish post

** [GDP per capita]
`run_probit'
* log_gdp_per_capita: mean 8.348719  std 1.640426  sum 9.989145
sum log_gdp_per_capita
margins, at(log_gdp_per_capita=(8.348719 9.989145)) atmeans vsquish post

** [major power]
`run_probit'
margins major_power, atmeans

** [Japan]
margins japan, atmeans
margins i.japan#i.major_power, atmeans

** [UNGA voting]
margins, dydx(pctagreechina) atmeans vsquish post
`run_probit'
margins, at(pctagreechina=(0.5 0.8)) atmeans vsquish post

** [Dalai Lama]
probit premier log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina i.DL sco i.asean president_l1 premier_l1 i.year, robust cluster (ccode)
margins DL, atmeans

** [SCO]
`run_probit'
margins sco, atmeans

** [ASEAN]
probit premier log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina i.DL sco i.asean president_l1 premier_l1 i.year, robust cluster (ccode)
margins asean, atmeans


* Appendix: Table 10
est clear
eststo: reg president log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina DL sco asean president_l1 premier_l1 i.year, robust cluster (ccode)
eststo: reg premier log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina DL sco asean president_l1 premier_l1 i.year, robust cluster (ccode)

eststo: biprobit president premier log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina DL sco asean president_l1 premier_l1 i.year
eststo: biprobit premier president log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan polity2 pctagreechina DL sco asean president_l1 premier_l1 i.year
esttab, star(* 0.10 ** 0.05 *** 0.01) label se r2 replace
esttab using Appendix_Table_10.tex,  star(* 0.10 ** 0.05 *** 0.01) label se r2 replace title(Determinants of Chinese Leader Visits) mtitle("President" "Premier" "President" "Premier") nogap b(%4.2f)


* Appendix: Table 11
est clear
eststo: probit president log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan pctagreechina DL sco asean president_l1 premier_l1 i.year, robust cluster (ccode)
eststo: probit premier log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan pctagreechina DL sco asean president_l1 premier_l1 i.year, robust cluster (ccode)
eststo: reg president log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan pctagreechina DL sco asean president_l1 premier_l1 i.year, robust cluster (ccode)
eststo: reg premier log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan pctagreechina DL sco asean president_l1 premier_l1 i.year, robust cluster (ccode)

eststo: biprobit president premier log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan pctagreechina DL sco asean president_l1 premier_l1 i.year
eststo: biprobit premier president log_population log_gdp_per_capita gdp_growth  resources logdist major_power japan pctagreechina DL sco asean president_l1 premier_l1 i.year
esttab, star(* 0.10 ** 0.05 *** 0.01) label se pr2 replace
esttab using Appendix_Table_11.tex,  star(* 0.10 ** 0.05 *** 0.01) label se pr2 replace title(Determinants of Chinese Leader Visits) mtitle("Probit:President" "Probit:Premier" "OLS:President" "OLS:Premier" "Biprobit:President" "Biprobit:Premier") nogap b(%4.2f)

* Appendix: Table 12
est clear
eststo: clogit president log_population log_gdp_per_capita gdp_growth  resources polity2 pctagreechina DL president_l1 premier_l1 i.year,  group(icode) robust cluster (ccode)
eststo: clogit premier log_population log_gdp_per_capita gdp_growth  resources polity2 pctagreechina DL president_l1 premier_l1 i.year,  group(icode) robust cluster (ccode)

eststo: reg president log_population log_gdp_per_capita gdp_growth  resources polity2 pctagreechina DL president_l1 premier_l1 i.year i.icode, robust cluster (ccode)
eststo: reg premier log_population log_gdp_per_capita gdp_growth resources polity2 pctagreechina DL president_l1 premier_l1 i.year i.icode, robust cluster (ccode)

esttab using Appendix_Table_12.tex,  star(* 0.10 ** 0.05 *** 0.01) label se pr2 replace title(Dalai Lama Visit: Country Fixed Effects) mtitle("Clogit:President" "Clogit:Premier" "OLS:President" "OLS:Premier") nogap b(%4.2f)
est clear
clear
