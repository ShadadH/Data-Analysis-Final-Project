* Name: Adreeta Raya, Anoosh Jamshed, Abdur Rahman, Shadad Hossain                           
* Date: December 12, 2022                                                           
* Project Data Final Analysis


*clearing all previous data, setting the working directory and starting a log file
clear all
log using RayaJamshedHossainRahman_Project.log, append 
cd "C:\Users\Touhid\OneDrive\Desktop\Data Analysis\Project"

*using this dataset
use finaldata


*creating dummy categorical variable for recession years:  1981, 1982,1992, 2001, 2007, 2008, 2009, 2020

gen recession=0 
replace recession= 1 if year==1980 
replace recession= 1 if year==1981
replace recession= 1 if year==1982
replace recession= 1 if year ==1990
replace recession= 1 if year ==1991 
replace recession= 1 if year==1992
replace recession= 1 if year==2001
replace recession= 1 if year==2007
replace recession= 1 if year==2008
replace recession= 1 if year==2009
replace recession= 1 if year==2020

**https://www.cnbc.com/2020/04/09/what-happened-in-every-us-recession-since-the-great-depression.html

tsset year, yearly

 
describe
summarize
outreg2 using results, word replace sum(log)

*to run the estimated regression
regress RGDP UNRATE consumption UnemploymentbenefitsUSDbillio MinWageperhour laborcompensationshareinGDP i.recession 
*adding recession makes minwage per hour, recession, and constant insignificant. Before it was only min-wage and constant 
outreg2 using myreg.doc, replace ctitle (realGDP)

*heteroskedacity REJECTED at 5 percent significance level 
asdoc estat imtest, white
* p-value greater than 0.05, we fail to reject the null hypothesis (homoskedacity) in data 
outreg2 using results1, word 

predict yhat, xb
predict ehat, residual
rvfplot, yline(0)
rvfplot, addplot(qfit ehat yhat)
drop ehat yhat 

*endogenity > simultaneous causality discussion. not omitted variable bias 
*** curve in the plot. Indication of non-linearity in the variables.

asdoc estat vif 
*multi-collinearity with consumption and minimum wage 
pwcorr RGDP UNRATE consumption UnemploymentbenefitsUSDbillio MinWageperhour laborcompensationshareinGDP  





************************* Approach 1: log rgdp ******************
gen logrgdp= log(RGDP)

regress logrgdp consumption MinWageperhour UNRATE UnemploymentbenefitsUSDbillio laborcompensationshareinGDP i.recession 
outreg2 using results, word
rvfplot, yline(0)
predict yhat, xb
predict ehat, residual
rvfplot, addplot(qfit ehat yhat)
* curve still present 

drop ehat yhat 
asdoc estat imtest, white 
asdoc estat vif
*again no heteroskedacity at 5 percent significance level. but hetereoskedacity at 10% significance level


****************(SEEMS TO WORK) Aproach 2: change rgdp and change Unemployment rate******************

gen change_rgdp= RGDP[_n] - RGDP[_n-1] 
gen change_UNRATE= UNRATE[_n] - UNRATE[_n-1] 

regress change_rgdp change_UNRATE consumption UnemploymentbenefitsUSDbillio MinWageperhour laborcompensationshareinGDP i.recession
rvfplot, yline(0)

predict yhat, xb
predict ehat, residual
rvfplot, addplot(qfit ehat yhat)
*residuals seem scattered enough 

drop ehat yhat 
estat imtest, white 
*homoskedacity p-value greater than 0.05 and 0.10
estat vif
****why might be results be insignificant? adjusted r-squared lower than r-squared

*******************Cause 1: high range in measurement units of the model 
summarize change_rgdp change_UNRATE consumption UnemploymentbenefitsUSDbillio MinWageperhour laborcompensationshareinGDP recession

*consumption range too big 

**Variable transformations tried: 
gen change_consumption= consumption[_n] - consumption[_n-1]

regress change_rgdp change_UNRATE change_consumption UnemploymentbenefitsUSDbillio MinWageperhour laborcompensationshareinGDP i.recession
*note consumption is now significant. maybe change measurent if there is still high range in values?
*adjusted r-squared better but lower than r-squared. 
* BEST MODEL UP UNTIL NOW
rvfplot, yline(0) 
estat imtest, white 

*no hetereoskedacity but probems with distrubution of the residuals. One reason could be the frequency/number of observations. with macro data we can not resample. 
 
estat vif 
*no multi-collinearity
summarize change_rgdp change_UNRATE UnemploymentbenefitsUSDbillio change_consumption MinWageperhour laborcompensationshareinGDP recession 

gen change_UNB= UnemploymentbenefitsUSDbillio[_n] - UnemploymentbenefitsUSDbillio[_n-1] 

regress change_rgdp change_UNRATE change_consumption change_UNB MinWageperhour laborcompensationshareinGDP i.recession
rvfplot
*recession is significant and Unemployment benefits is significant too  
*the constant, UnemploymentbenefitsUSDbillio, MinWageperhour not significant 
*adjusted r-squared slightly better 83% 
rvfplot, yline(0)
*no curve but seems to be concentrated in one region (indication of a problem of less observations. Maybe if quarterly data)

estat imtest, white 
*no hetereoskedacity 

estat vif
*no multi-collinearity. mean vif is around 2.0 


**** concluding remarks: change in variables have fixed hetereoskedacity issues and also given significant results which alligns with the literature
*******



*********** REPORT UPDATED CODE: *********** 
twoway (tsline change_rgdp) (tsline change_UNRATE, yaxis(2)) 
*more years. Actual empirical Okun's law relationship between change so better to use change variable.

twoway (tsline change_UNRATE) (tsline change_UNB, yaxis(2)) 

log close