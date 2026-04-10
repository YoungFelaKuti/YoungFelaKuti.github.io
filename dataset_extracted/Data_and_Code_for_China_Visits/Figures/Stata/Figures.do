use ../../Raw_Data/china_visits.v1.dta

* Data processing
generate start_date = date(start, "MDY")
generate end_date = date(end, "MDY")
gen duration = end_date - start_date + 1
gen month = month(start_date)

* Main: Figure 4
label define leaders 1 "Jiang" 2 "Hu" 3 "Xi"
label values leader_id leaders
twoway histogram month if office == "President", color(none) lcolor(black) frequency discrete by(leader_id, cols(3) note("")) xlabel(1(1)12)   ylabel(1(3)20, nogrid) xtitle("") xsize(9) ysize(3) width(1) name(president_month_dist)
label drop leaders


label define leaders 1 "Zhu" 2 "Wen" 3 "Li"
label values leader_id leaders
twoway histogram month if office == "Premier" & leader != "Li Peng", color(none) lcolor(black) frequency discrete by(leader_id, cols(3) note("")) xlabel(1(1)12) ylabel(1(3)16, nogrid) xtitle("") xsize(9) ysize(4) width(1) name(premier_month_dist)


graph combine president_month_dist premier_month_dist, iscale(1) xsize(9) ysize(6) cols(1)
graph export "Main_Figure_4.pdf", replace
graph drop president_month_dist premier_month_dist
window manage close graph

* Main: Figure 5
twoway scatter duration year if leader_id == 1 & office == "President", jitter(5) ylabel(0(1)8,nogrid) xlabel(1998(2)2020) mcolor(green) legend(cols(4)) xtitle("") xsize(9) ysize(6) || scatter duration year if leader_id == 2 & office == "President", jitter(5) ylabel(0(1)8,nogrid) xlabel(1998(2)2020) mcolor(blue) || scatter duration year if leader_id == 3 & office == "President", jitter(5) ylabel(0(1)8,nogrid) xlabel(1998(2)2020) mcolor(purple) || lfit duration year, name(president_duration) legend(order(1 "Jiang" 2 "Hu" 3 "Xi" 4 "Linear Fitted Values"))  xlabel(1998(3)2020)

twoway scatter duration year if leader_id == 1 & office == "Premier", jitter(5) ylabel(0(1)8,nogrid) xlabel(1998(2)2020) mcolor(green) legend(cols(4)) xtitle("") xsize(9) ysize(6) || scatter duration year if leader_id == 2& office == "Premier", jitter(5) ylabel(0(1)8,nogrid) xlabel(1998(2)2020) mcolor(blue) || scatter duration year if leader_id == 3 & office == "Premier", jitter(5) ylabel(0(1)9,nogrid) xlabel(1998(2)2020) mcolor(purple) || qfit duration year, name(premier_duration) legend(order(1 "Zhu" 2 "Wen" 3 "Li" 4 "Quadratic Fitted values"))  xlabel(1998(3)2020)

graph combine president_duration premier_duration, iscale(1) xsize(20) ysize(8) cols(2)
graph export "Main_Figure_5.pdf", replace

graph drop president_duration premier_duration
window manage close graph

* Appendix: Figure 1
collapse (sum) duration, by (month year leader_id office)
twoway scatter duration year if leader_id == 1 & office == "President", jitter(5) ylabel(1(3)23,nogrid) xlabel(1998(2)2020) mcolor(green) legend(cols(4)) xtitle("") xsize(9) ysize(6) || scatter duration year if leader_id == 2 & office == "President", jitter(5) ylabel(1(3)23,nogrid) xlabel(1998(2)2020) mcolor(blue) || scatter duration year if leader_id == 3 & office == "President", jitter(5) ylabel(1(3)23,nogrid) xlabel(1998(2)2020) mcolor(purple) || lfit duration year, name(president_month_cumu)  legend(order(1 "Jiang" 2 "Hu" 3 "Xi" 4 "Fitted Values"))


twoway scatter duration year if leader_id == 1 & office == "Premier", jitter(5) ylabel(1(3)20,nogrid) xlabel(1998(2)2020) mcolor(green) legend(cols(4)) xtitle("") xsize(9) ysize(6) || scatter duration year if leader_id == 2 & office == "Premier", jitter(5) ylabel(1(3)20,nogrid) xlabel(1998(2)2020) mcolor(blue) || scatter duration year if leader_id == 3 & office == "Premier", jitter(5) ylabel(1(3)20,nogrid) xlabel(1998(2)2020) mcolor(purple) || lfit duration year, name(premier_month_cumu) legend(order(1 "Zhu" 2 "Wen" 3 "Li" 4 "Fitted Values"))


graph combine president_month_cumu premier_month_cumu, iscale(1) xsize(22) ysize(8) cols(2)
graph export "Appendix_Figure_1.pdf", replace

graph drop president_month_cumu premier_month_cumu
window manage close graph
clear
