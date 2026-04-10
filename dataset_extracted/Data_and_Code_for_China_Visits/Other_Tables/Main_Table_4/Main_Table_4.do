use ./../china_visits_panel.dta
encode ccode, gen(icode)

* For simplicity, the panel is generated with the current 192 UN member countries, excluding China.
* Modifying the panel structure so as to accommodate the special cases of South Sudan, Montenegro and Serbia will not significantly change the results.
xtset icode  year

sum president 

* 217
count if president  == 1

* 216
count if l.president == 1

* 4
count if president == 1 & l.president == 1

*  .01851852
display 4/216

sum premier

* 188
count if premier == 1

* 188
count if l.premier == 1

* 7
count if premier == 1 & l.premier == 1

* .03723404
display 7/188

clear
