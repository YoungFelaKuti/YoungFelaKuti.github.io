cd Figures/R
Rscript advanced_visualization_1998_2020_president.R
Rscript advanced_visualization_1998_2020_premier.R

alias stata='/Applications/Stata/StataBE.app/Contents/MacOS/StataBE'

cd ../Stata
stata -e do Figures.do


cd ../../Regression_Tables
stata -e do Tables.do

cd ../Other_Tables/Main_Table_4/
stata -e do Main_Table_4.do

cd ../Appendix_Table_4
stata -e do Appendix_Table_4.do

cd ../Appendix_Table_5
stata -e do Appendix_Table_5.do

cd ../Appendix_Table_6
stata -e do Appendix_Table_6.do

cd ../..
unalias stata
