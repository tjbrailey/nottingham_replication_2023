use "U:\How to Save a Democracy\Data\appendedfinal.dta", clear

**Figure 1
reg support i.candemmg##ib3.cancom, cluster(resp)
eststo point
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) title("") legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero)) plotopts(msymbol(O))
graph save vcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save vmm, replace
graph combine vmm.gph vcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save vpo, replace

reg support i.candemmg##ib3.cancom if country == "CZ", cluster(resp)
eststo czint
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save vczcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save vczmm, replace
graph combine vczmm.gph vczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save vcz, replace

reg support i.candemmg##ib3.cancom if country == "MX", cluster(resp)
eststo mxint
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save vmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save vmxmm, replace
graph combine vmxmm.gph vmxcamce.gph, commonscheme title("Mexico") xcommon cols(1) 
graph save vmx, replace

reg support i.candemmg##ib3.cancom if country == "SK", cluster(resp)
eststo skint
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save vskcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save vskmm, replace
graph combine vskmm.gph vskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save vsk, replace

reg support i.candemmg##ib3.cancom if country == "UK", cluster(resp)
eststo ukint
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save vukcamce, replace 
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save vukmm, replace
graph combine vukmm.gph vukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1) 
graph save vuk, replace

reg support i.candemmg##ib3.cancom if country == "US", cluster(resp)
eststo usint
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save vuscamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save vusmm, replace
graph combine vusmm.gph vuscamce.gph, commonscheme title("United States") xcommon cols(1) 
graph save vus, replace

graph combine vpo.gph vcz.gph vmx.gph vsk.gph vuk.gph vus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\vcompRR.pdf", replace

***Appendix A: Table A1-A2 and Documentation of Ordering of Preferences
**Tables
reg support i.candemmg ib3.cancom, cluster(resp)
eststo poavg

reg support i.candemmg ib3.cancom if country == "CZ", cluster(resp)
eststo czavg

reg support i.candemmg ib3.cancom if country == "MX", cluster(resp)
eststo mxavg

reg support i.candemmg ib3.cancom if country == "SK", cluster(resp)
eststo skavg

reg support i.candemmg ib3.cancom if country == "UK", cluster(resp)
eststo ukavg

reg support i.candemmg ib3.cancom if country == "US", cluster(resp)
eststo usavg

esttab poavg czavg mxavg skavg ukavg usavg using "U:\How to Save a Democracy\Competence\Revisions\Results\TableA1.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table A1: Average effects of undemocratic behavior and competence in the Czech Republic, Mexico, South Korea, the United Kingdom, and the United States. Candidate support is the dependent variable in all models.") varlabels(1.candemmg "Undemocratic behavior" 1.cancom "Very incompetent" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US" ) replace b(%7.2f) se(%7.2f)

esttab point czint mxint skint ukint usint using "U:\How to Save a Democracy\Competence\Revisions\Results\TableA2.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table A2: Effects of undemocratic behavior interacted by candidate competence in the Czech Republic, Mexico, South Korea, the United Kingdom, and the United States. Candidate support is the dependent variable in all models.") varlabels(1.candemmg "Undemocratic behavior" 1.candemmg#2.cancom "Undemocratic x Incompetent" 1.candemmg#1.cancom "Undemocratic x Very incompetent" 1.candemmg#4.cancom "Undemocratic x Competent" 1.candemmg#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 1.candemmg#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)

**OOP
*Generate 10-category variable with all possible subgroups across undemocratic behavior and competence 
generate comundem = .
replace comundem = 1 if candemmg == 0 & cancom == 1
replace comundem = 2 if candemmg == 0 & cancom == 2
replace comundem = 3 if candemmg == 0 & cancom == 3
replace comundem = 4 if candemmg == 0 & cancom == 4
replace comundem = 5 if candemmg == 0 & cancom == 5
replace comundem = 6 if candemmg == 1 & cancom == 1
replace comundem = 7 if candemmg == 1 & cancom == 2
replace comundem = 8 if candemmg == 1 & cancom == 3
replace comundem = 9 if candemmg == 1 & cancom == 4
replace comundem = 10 if candemmg == 1 & cancom == 5
label define comundem 1 "Democratic and very incompetent" 2 "Democratic and incompetent" 9 "Undemocratic and competent" 10 "Undemocratic and very competent"
label variable comundem comundem

*Run tests
reg support i.comundem, cluster(resp)
eststo comundempo
margins comundem if comundem == 1 | comundem == 2 | comundem == 9 | comundem == 10, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0) ylabel(1 "D#C2 vs D#C1" 2 "UD#C4 vs D#C1" 3 "UD#C5 vs D#C1" 4 "UD#C4 vs D#C2" 5 "UD#C5 vs D#C2" 6 "UD#C5 vs UD#C4", labsize(small)) xtitle("") ytitle("") title("Pooled") fxsize(41)
graph save bpo, replace
margins comundem
marginsplot, recast(scatter) xtitle("") xlabel(1 "D#C1" 2 "#C2" 3 "#C3" 4 "#C4" 5 "#C5" 6 "UD#C1" 7 "#C2" 8 "#C3" 9 "#C4" 10 "#C5", labsize(tiny) alternate) xline(5.5)  ylabel(2(0.5)3.5) ytitle("") title("Pooled") fxsize(32)
graph save b2po, replace

reg support i.comundem if country == "CZ", cluster(resp)
eststo comundemcz
margins comundem if comundem == 1 | comundem == 2 | comundem == 9 | comundem == 10, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0)  xtitle("") ytitle("") title("Czech Republic") yscale(off)
graph save bcz, replace
margins comundem
marginsplot, recast(scatter) xtitle("") xlabel(1 "D#C1" 2 "#C2" 3 "#C3" 4 "#C4" 5 "#C5" 6 "UD#C1" 7 "#C2" 8 "#C3" 9 "#C4" 10 "#C5", labsize(tiny) alternate) xline(5.5)  ylabel(2(0.5)3.5) ytitle("") title("Czech Republic") yscale(off)
graph save b2cz, replace

reg support i.comundem if country == "MX", cluster(resp)
eststo comundemmx
margins comundem if comundem == 1 | comundem == 2 | comundem == 9 | comundem == 10, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0)  xtitle("") ytitle("") title("Mexico") yscale(off)
graph save bmx, replace
margins comundem
marginsplot, recast(scatter) xtitle("") xlabel(1 "D#C1" 2 "#C2" 3 "#C3" 4 "#C4" 5 "#C5" 6 "UD#C1" 7 "#C2" 8 "#C3" 9 "#C4" 10 "#C5", labsize(tiny) alternate) xline(5.5)  ylabel(2(0.5)3.5) ytitle("") title("Mexico")  yscale(off)
graph save b2mx, replace

reg support i.comundem if country == "SK", cluster(resp)
eststo comundemsk
margins comundem if comundem == 1 | comundem == 2 | comundem == 9 | comundem == 10, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0) ylabel(1 "D#C2 vs D#C1" 2 "UD#C4 vs D#C1" 3 "UD#C5 vs D#C1" 4 "UD#C4 vs D#C2" 5 "UD#C5 vs D#C2" 6 "UD#C5 vs UD#C4", labsize(small))  xtitle("") ytitle("") title("South Korea") fxsize(41)
graph save bsk, replace
margins comundem
marginsplot, recast(scatter) xtitle("") xlabel(1 "D#C1" 2 "#C2" 3 "#C3" 4 "#C4" 5 "#C5" 6 "UD#C1" 7 "#C2" 8 "#C3" 9 "#C4" 10 "#C5", labsize(tiny) alternate) xline(5.5)  ylabel(2(0.5)3.5) ytitle("") title("South Korea") fxsize(32)
graph save b2sk, replace

reg support i.comundem if country == "UK", cluster(resp)
eststo comundemuk
margins comundem if comundem == 1 | comundem == 2 | comundem == 9 | comundem == 10, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0)  xtitle("") ytitle("") title("United Kingdom") yscale(off)
graph save buk, replace
margins comundem
marginsplot, recast(scatter) xtitle("") xlabel(1 "D#C1" 2 "#C2" 3 "#C3" 4 "#C4" 5 "#C5" 6 "UD#C1" 7 "#C2" 8 "#C3" 9 "#C4" 10 "#C5", labsize(tiny) alternate) xline(5.5)  ylabel(2(0.5)3.5) ytitle("") title("United Kingdom") yscale(off)
graph save b2uk, replace

reg support i.comundem if country == "US", cluster(resp)
eststo comundemus
margins comundem if comundem == 1 | comundem == 2 | comundem == 9 | comundem == 10, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0)  xtitle("") ytitle("") title("United States")yscale(off)
graph save bus, replace
margins comundem
marginsplot, recast(scatter) xtitle("") xlabel(1 "D#C1" 2 "#C2" 3 "#C3" 4 "#C4" 5 "#C5" 6 "UD#C1" 7 "#C2" 8 "#C3" 9 "#C4" 10 "#C5", labsize(tiny) alternate) xline(5.5)  ylabel(2(0.5)3.5) ytitle("") title("United States") yscale(off)
graph save b2us, replace

graph combine bpo.gph bcz.gph bmx.gph bsk.gph buk.gph bus.gph, cols(3) xcommon graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\BcompRR.pdf", replace
graph combine b2po.gph b2cz.gph b2mx.gph b2sk.gph b2uk.gph b2us.gph, cols(3) xcommon graphregion(margin(0 0 0 0)) b1title("Democratic (Very incompetent to very competent) | Undemocratic (Very incompetent to very competent)", size(vsmall))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\B2compRR.pdf", replace

esttab comundempo comundemcz comundemmx comundemsk comundemuk comundemus using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.A1-A2.tex", obslast gaps ar2 nonumbers nonotes se drop() addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.A1: Supporting table for Figure A1 showing differences in marginal means between undemocratic but competent and democratic but incompetent candidates.") varlabels(1.comundem "D\#C1 (Reference category)" 2.comundem "D\#C2" 3.comundem "D\#C3" 4.comundem "D\#C4" 5.comundem "D\#C5" 6.comundem "UD\#C1" 7.comundem "UD\#C2" 8.comundem "UD\#C3" 9.comundem "UD\#C4" 10.comundem "UD\#C5" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)

*Generate tie-variables to restrict dataset to scenarios where undemocratic competent candidates faced democratic incompetent candidates and run more tests
gen otcandcomundem = .
replace otcandcomundem =comundem[_n+11] if candidate == "_1"
replace otcandcomundem =comundem[_n-11] if candidate == "_2"
replace otcandcomundem =comundem[_n+1] if candidate == "_3"
replace otcandcomundem =comundem[_n-1] if candidate == "_4"
replace otcandcomundem =comundem[_n+1] if candidate == "_5"
replace otcandcomundem =comundem[_n-1] if candidate == "_6"
replace otcandcomundem =comundem[_n+1] if candidate == "_7"
replace otcandcomundem =comundem[_n-1] if candidate == "_8"
replace otcandcomundem =comundem[_n-18] if candidate == "_9"
replace otcandcomundem =comundem[_n+18] if candidate == "_10"
replace otcandcomundem =comundem[_n+1] if candidate == "_11"
replace otcandcomundem =comundem[_n-1] if candidate == "_12"
replace otcandcomundem =comundem[_n+1] if candidate == "_13"
replace otcandcomundem =comundem[_n-1] if candidate == "_14"
replace otcandcomundem =comundem[_n+1] if candidate == "_15"
replace otcandcomundem =comundem[_n-1] if candidate == "_16"
replace otcandcomundem =comundem[_n+1] if candidate == "_17"
replace otcandcomundem =comundem[_n-1] if candidate == "_18"
replace otcandcomundem =comundem[_n+2] if candidate == "_19"
replace otcandcomundem =comundem[_n-2] if candidate == "_20"
gen dyad = 0
replace dyad = 1 if otcandcomundem > 8 & comundem < 3 | otcandcomundem < 3 & comundem > 8 
label define dyad 1 "Democratic and incompent vs. Undemocratic and competent"
label values dyad dyad

reg support i.comundem if dyad == 1, cluster(resp)
eststo A3po
margins comundem, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0) ylabel(1 "D#C2 vs D#C1" 2 "UD#C4 vs D#C1" 3 "UD#C5 vs D#C1" 4 "UD#C4 vs D#C2" 5 "UD#C5 vs D#C2" 6 "UD#C5 vs UD#C4", labsize(small)) xtitle("") ytitle("") title("Pooled") fxsize(41)
graph save b3po, replace

reg support i.comundem if dyad == 1 & country == "CZ", cluster(resp)
eststo A3cz
margins comundem, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0)  xtitle("") ytitle("") title("Czech Republic") yscale(off)
graph save b3cz, replace

reg support i.comundem if dyad == 1 & country == "MX", cluster(resp)
eststo A3mx
margins comundem, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0)  xtitle("") ytitle("") title("Mexico") yscale(off)
graph save b3mx, replace

reg support i.comundem if dyad == 1 & country == "SK", cluster(resp)
eststo A3sk
margins comundem, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0) ylabel(1 "D#C2 vs D#C1" 2 "UD#C4 vs D#C1" 3 "UD#C5 vs D#C1" 4 "UD#C4 vs D#C2" 5 "UD#C5 vs D#C2" 6 "UD#C5 vs UD#C4", labsize(small))  xtitle("") ytitle("") title("South Korea") fxsize(41)
graph save b3sk, replace

reg support i.comundem if dyad == 1 & country == "UK", cluster(resp)
eststo A3uk
margins comundem, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0)  xtitle("") ytitle("") title("United Kingdom") yscale(off)
graph save b3uk, replace

reg support i.comundem if dyad == 1 & country == "US", cluster(resp)
eststo A3us
margins comundem, pwcompare(effects)
marginsplot, horizontal unique recast(scatter) yscale(reverse) xline(0)  xtitle("") ytitle("") title("United States")yscale(off)
graph save b3us, replace

graph combine b3po.gph b3cz.gph b3mx.gph b3sk.gph b3uk.gph b3us.gph, cols(3) xcommon graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\B3compRR.pdf", replace

esttab A3po A3cz A3mx A3sk A3uk A3us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.A3.tex", obslast gaps ar2 nonumbers nonotes se drop() addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.A3: Supporting table for Figure A3 showing differences in marginal means between undemocratic but competent and democratic but incompetent candidates for restricted sample.") varlabels(1.comundem "D\#C1 (Reference category)" 2.comundem "D\#C2" 3.comundem "D\#C3" 4.comundem "D\#C4" 5.comundem "D\#C5" 6.comundem "UD\#C1" 7.comundem "UD\#C2" 8.comundem "UD\#C3" 9.comundem "UD\#C4" 10.comundem "UD\#C5" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)

***Appendix B: Competence and Undemocratic Behavior Split
**Competence
*Fighting corruption
reg support i.candemmg##ib2.cancor, cluster(resp)
eststo b2po
margins candemmg#ib2.cancor, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.8 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) legend(on order(2 "Effects compared to #Average") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero)) plotopts(msymbol(O))
graph save CCvpocamce, replace
quietly margins, over(candemmg) at(cancor=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) xscale(off) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save CCvpomm, replace
graph combine CCvpomm.gph CCvpocamce.gph, commonscheme title("Pooled") xcommon cols(1) fxsize(33)
graph save CCvpo, replace

reg support i.candemmg##ib2.cancor if country == "CZ", cluster(resp)
eststo b2cz
margins candemmg#ib2.cancor, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCvczcamce, replace
quietly margins, over(candemmg) at(cancor=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off) 
graph save CCvczmm, replace
graph combine CCvczmm.gph CCvczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save CCvcz, replace

reg support i.candemmg##ib2.cancor if country == "MX", cluster(resp)
eststo b2mx
margins candemmg#ib2.cancor, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCvmxcamce, replace
quietly margins, over(candemmg) at(cancor=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off) 
graph save CCvmxmm, replace
graph combine CCvmxmm.gph CCvmxcamce.gph, commonscheme title("Mexico") xcommon cols(1)
graph save CCvmx, replace

reg support i.candemmg##ib2.cancor if country == "SK", cluster(resp)
eststo b2sk
margins candemmg#ib2.cancor, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.8 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save CCvskcamce, replace
quietly margins, over(candemmg) at(cancor=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save CCvskmm, replace
graph combine CCvskmm.gph CCvskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save CCvsk, replace

reg support i.candemmg##ib2.cancor if country == "UK", cluster(resp)
eststo b2uk
margins candemmg#ib2.cancor, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCvukcamce, replace
quietly margins, over(candemmg) at(cancor=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off) 
graph save CCvukmm, replace
graph combine CCvukmm.gph CCvukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1)
graph save CCvuk, replace

reg support i.candemmg##ib2.cancor if country == "US", cluster(resp)
eststo b2us
margins candemmg#ib2.cancor, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCvuscamce, replace
quietly margins, over(candemmg) at(cancor=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off) 
graph save CCvusmm, replace
graph combine CCvusmm.gph CCvuscamce.gph, commonscheme title("United States") xcommon cols(1)
graph save CCvus, replace


graph combine CCvpo.gph CCvcz.gph CCvmx.gph CCvsk.gph CCvuk.gph CCvus.gph, cols(3) ycommon b1title("Corruption competence", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\CCvcompRR.pdf", replace

esttab b2po b2cz b2mx b2sk b2uk b2us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.B2.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.B2: Supporting table for Figure B2 showing the results when only competence in fighting corruption is included.") varlabels(1.candemmg "Undemocratic behavior" 1.cancor "Low competence" 2.cancor "Average competence (Reference category)" 3.cancor "High competence" 1.candemmg#1.cancor "Undemocratic x Low competence" 1.candemmg#2.cancor "Undemocratic x Average competence"  1.candemmg#3.cancor "Undemocratic x High competence" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)

*Handling economic matters
reg support i.candemmg##ib2.caneco, cluster(resp)
eststo b1po
margins candemmg#ib2.caneco, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.8 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) legend(on order(2 "Effects compared to #Average") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero)) plotopts(msymbol(O))
graph save ECvpocamce, replace
quietly margins, over(candemmg) at(caneco=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) xscale(off) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save ECvpomm, replace
graph combine ECvpomm.gph ECvpocamce.gph, commonscheme title("Pooled") xcommon cols(1) fxsize(33)
graph save ECvpo, replace

reg support i.candemmg##ib2.caneco if country == "CZ", cluster(resp)
eststo b1cz
margins candemmg#ib2.caneco, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save ECvczcamce, replace
quietly margins, over(candemmg) at(caneco=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off) 
graph save ECvczmm, replace
graph combine ECvczmm.gph ECvczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save ECvcz, replace

reg support i.candemmg##ib2.caneco if country == "MX", cluster(resp)
eststo b1mx
margins candemmg#ib2.caneco, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save ECvmxcamce, replace
quietly margins, over(candemmg) at(caneco=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off) 
graph save ECvmxmm, replace
graph combine ECvmxmm.gph ECvmxcamce.gph, commonscheme title("Mexico") xcommon cols(1)
graph save ECvmx, replace

reg support i.candemmg##ib2.caneco if country == "SK", cluster(resp)
eststo b1sk
margins candemmg#ib2.caneco, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.8 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save ECvskcamce, replace
quietly margins, over(candemmg) at(caneco=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save ECvskmm, replace
graph combine ECvskmm.gph ECvskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save ECvsk, replace

reg support i.candemmg##ib2.caneco if country == "UK", cluster(resp)
eststo b1uk
margins candemmg#ib2.caneco, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save ECvukcamce, replace
quietly margins, over(candemmg) at(caneco=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off) 
graph save ECvukmm, replace
graph combine ECvukmm.gph ECvukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1)
graph save ECvuk, replace

reg support i.candemmg##ib2.caneco if country == "US", cluster(resp)
eststo b1us
margins candemmg#ib2.caneco, contrast(effects)
marginsplot, xlabel(1 "Low" 2 "Average" 3 "High", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save ECvuscamce, replace
quietly margins, over(candemmg) at(caneco=(1(1)3))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off) 
graph save ECvusmm, replace
graph combine ECvusmm.gph ECvuscamce.gph, commonscheme title("United States") xcommon cols(1)
graph save ECvus, replace


graph combine ECvpo.gph ECvcz.gph ECvmx.gph ECvsk.gph ECvuk.gph ECvus.gph, cols(3) ycommon b1title("Economic competence", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\ECvcompRR.pdf", replace

esttab b1po b1cz b1mx b1sk b1uk b1us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.B1.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.B1: Supporting table for Figure B1 showing the results when only competence in handling economic matters is included.") varlabels(1.candemmg "Undemocratic behavior" 1.caneco "Low competence" 2.caneco "Average competence (Reference category)" 3.caneco "High competence" 1.candemmg#1.caneco "Undemocratic x Low competence" 1.candemmg#2.caneco "Undemocratic x Average competence"  1.candemmg#3.caneco "Undemocratic x High competence" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)


**Undemocratic Behavior Split
*RoL
reg support i.candem##ib3.cancom if candem == 1 & country == "CZ" | candem == 2 & country == "CZ", cluster(resp)
eststo b4cz
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CROLvczcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CROLvczmm, replace
graph combine CROLvczmm.gph CROLvczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save CROLvcz, replace

reg support i.candem##ib3.cancom if candem == 1 & country == "MX" | candem == 2 & country == "MX", cluster(resp)
eststo b4mx
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") yscale(off) graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save CROLvmxcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CROLvmxmm, replace
graph combine CROLvmxmm.gph CROLvmxcamce.gph, commonscheme title("Mexico") xcommon cols(1)
graph save CROLvmx, replace

reg support i.candem##ib3.cancom if candem == 1 & country == "SK" | candem == 2 & country == "SK", cluster(resp)
eststo b4sk
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save CROLvskcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save CROLvskmm, replace
graph combine CROLvskmm.gph CROLvskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save CROLvsk, replace

reg support i.candem##ib3.cancom if candem == 1 & country == "UK" | candem == 2 & country == "UK", cluster(resp)
eststo b4uk
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CROLvukcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CROLvukmm, replace
graph combine CROLvukmm.gph CROLvukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1)
graph save CROLvuk, replace

reg support i.candem##ib3.cancom if candem == 1 & country == "US" | candem == 2 & country == "US", cluster(resp)
eststo b4us
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CROLvuscamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CROLvusmm, replace
graph combine CROLvusmm.gph CROLvuscamce.gph, commonscheme title("United States") xcommon cols(1)
graph save CROLvus, replace

reg support i.candem##ib3.cancom if candem == 1 | candem == 2, cluster(resp)
eststo b4po
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save CROLvcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, legend(ring (0) position(10) order(3 "Adhere to judges (MMs)" 4 "Ignore judges (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small))   title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0))  xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save CROLvmm, replace
graph combine CROLvmm.gph CROLvcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save CROLvpo, replace


graph combine CROLvpo.gph CROLvcz.gph CROLvmx.gph CROLvsk.gph CROLvuk.gph CROLvus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\CROLvcompRR.pdf", replace

esttab b4po b4cz b4mx b4sk b4uk b4us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.B4.tex", obslast gaps ar2 nonumbers nonotes se drop(1.candem*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.B4: Supporting table for Figure B4 showing the results when the only type of undemocratic behavior included is ignoring opposing judges.") varlabels(2.candem "Undemocratic (Ignore judges)" 2.candem#2.cancom "Undemocratic x Incompetent" 2.candem#1.cancom "Undemocratic x Very incompetent" 2.candem#4.cancom "Undemocratic x Competent" 2.candem#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 2.candem#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)


*CL (Journalist harassment)
gen cljh = .
replace cljh = 1 if candem == 3
replace cljh = 0 if candem == 6
reg support i.cljh##ib3.cancom if country == "CZ", cluster(resp)
eststo b6cz
margins cljh#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCLJHvczcamce, replace
quietly margins, over(cljh) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CCLJHvczmm, replace
graph combine CCLJHvczmm.gph CCLJHvczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save CCLJHvcz, replace

reg support i.cljh##ib3.cancom if country == "MX", cluster(resp)
eststo b6mx
margins cljh#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O)) yscale(off)
graph save CCLJHvmxcamce, replace
quietly margins, over(cljh) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CCLJHvmxmm, replace
graph combine CCLJHvmxmm.gph CCLJHvmxcamce.gph, commonscheme title("Mexico") xcommon cols(1)
graph save CCLJHvmx, replace

reg support i.cljh##ib3.cancom if country == "SK", cluster(resp)
eststo b6sk
margins cljh#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save CCLJHvskcamce, replace
quietly margins, over(cljh) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save CCLJHvskmm, replace
graph combine CCLJHvskmm.gph CCLJHvskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save CCLJHvsk, replace

reg support i.cljh##ib3.cancom if country == "UK", cluster(resp)
eststo b6uk
margins cljh#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCLJHvukcamce, replace
quietly margins, over(cljh) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CCLJHvukmm, replace
graph combine CCLJHvukmm.gph CCLJHvukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1)
graph save CCLJHvuk, replace

reg support i.cljh##ib3.cancom if country == "US", cluster(resp)
eststo b6us
margins cljh#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCLJHvuscamce, replace
quietly margins, over(cljh) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CCLJHvusmm, replace
graph combine CCLJHvusmm.gph CCLJHvuscamce.gph, commonscheme title("United States") xcommon cols(1)
graph save CCLJHvus, replace

reg support i.cljh##ib3.cancom, cluster(resp)
eststo b6po
margins cljh#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save CCLJHvcamce, replace
quietly margins, over(cljh) at(cancom=(1(1)5))
marginsplot, legend(ring (0) position(10) order(3 "Harassment unacceptable (MMs)" 4 "Harassment acceptable (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small))   title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0))  xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save CCLJHvmm, replace
graph combine CCLJHvmm.gph CCLJHvcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save CCLJHvpo, replace


graph combine CCLJHvpo.gph CCLJHvcz.gph CCLJHvmx.gph CCLJHvsk.gph CCLJHvuk.gph CCLJHvus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\CCLJHvcompRR.pdf", replace

esttab b6po b6cz b6mx b6sk b6uk b6us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.B6.tex", obslast gaps ar2 nonumbers nonotes se drop(0.cljh*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.B6: Supporting table for Figure B6 showing the results when the only type of undemocratic behavior included is journalist harassment.") varlabels(1.cljh "Undemocratic (Ignore judges)" 1.cljh#2.cancom "Undemocratic x Incompetent" 1.cljh#1.cancom "Undemocratic x Very incompetent" 1.cljh#4.cancom "Undemocratic x Competent" 1.cljh#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 1.cljh#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)

*CL (Encourage violence)
gen clev = .
replace clev = 1 if candem == 4
replace clev = 0 if candem == 5
reg support i.clev##ib3.cancom if country == "CZ", cluster(resp)
eststo b5cz
margins clev#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCLEVvczcamce, replace
quietly margins, over(clev) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CCLEVvczmm, replace
graph combine CCLEVvczmm.gph CCLEVvczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save CCLEVvcz, replace

reg support i.clev##ib3.cancom if country == "MX", cluster(resp)
eststo b5mx
margins clev#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O)) yscale(off)
graph save CCLEVvmxcamce, replace
quietly margins, over(clev) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CCLEVvmxmm, replace
graph combine CCLEVvmxmm.gph CCLEVvmxcamce.gph, commonscheme title("Mexico") xcommon cols(1)
graph save CCLEVvmx, replace

reg support i.clev##ib3.cancom if country == "SK", cluster(resp)
eststo b5sk
margins clev#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save CCLEVvskcamce, replace
quietly margins, over(clev) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save CCLEVvskmm, replace
graph combine CCLEVvskmm.gph CCLEVvskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save CCLEVvsk, replace

reg support i.clev##ib3.cancom if country == "UK", cluster(resp)
eststo b5uk
margins clev#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCLEVvukcamce, replace
quietly margins, over(clev) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CCLEVvukmm, replace
graph combine CCLEVvukmm.gph CCLEVvukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1)
graph save CCLEVvuk, replace

reg support i.clev##ib3.cancom if country == "US", cluster(resp)
eststo b5us
margins clev#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CCLEVvuscamce, replace
quietly margins, over(clev) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CCLEVvusmm, replace
graph combine CCLEVvusmm.gph CCLEVvuscamce.gph, commonscheme title("United States") xcommon cols(1)
graph save CCLEVvus, replace

reg support i.clev##ib3.cancom, cluster(resp)
eststo b5po
margins clev#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save CCLEVvcamce, replace
quietly margins, over(clev) at(cancom=(1(1)5))
marginsplot, legend(ring (0) position(10) order(3 "Discourage violence (MMs)" 4 "Encourage violence (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small))   title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0))  xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save CCLEVvmm, replace
graph combine CCLEVvmm.gph CCLEVvcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save CCLEVvpo, replace


graph combine CCLEVvpo.gph CCLEVvcz.gph CCLEVvmx.gph CCLEVvsk.gph CCLEVvuk.gph CCLEVvus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\CCLEVvcompRR.pdf", replace

esttab b5po b5cz b5mx b5sk b5uk b5us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.B5.tex", obslast gaps ar2 nonumbers nonotes se drop(0.clev*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.B5: Supporting table for Figure B5 showing the results when the only type of undemocratic behavior included is encouraging violence.") varlabels(1.clev "Undemocratic (Encourage violence)" 1.clev#2.cancom "Undemocratic x Incompetent" 1.clev#1.cancom "Undemocratic x Very incompetent" 1.clev#4.cancom "Undemocratic x Competent" 1.clev#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 1.clev#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)


*EF
reg support i.candem##ib3.cancom if candem == 7 & country == "CZ" | candem == 8 & country == "CZ", cluster(resp)
eststo b3cz
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CEFvczcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CEFvczmm, replace
graph combine CEFvczmm.gph CEFvczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save CEFvcz, replace

reg support i.candem##ib3.cancom if candem == 7 & country == "MX" | candem == 8 & country == "MX", cluster(resp)
eststo b3mx
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O)) yscale(off)
graph save CEFvmxcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CEFvmxmm, replace
graph combine CEFvmxmm.gph CEFvmxcamce.gph, commonscheme title("Mexico") xcommon cols(1)
graph save CEFvmx, replace

reg support i.candem##ib3.cancom if candem == 7 & country == "SK" | candem == 8 & country == "SK", cluster(resp)
eststo b3sk
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save CEFvskcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save CEFvskmm, replace
graph combine CEFvskmm.gph CEFvskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save CEFvsk, replace

reg support i.candem##ib3.cancom if candem == 7 & country == "UK" | candem == 8 & country == "UK", cluster(resp)
eststo b3uk
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CEFvukcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CEFvukmm, replace
graph combine CEFvukmm.gph CEFvukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1)
graph save CEFvuk, replace

reg support i.candem##ib3.cancom if candem == 7 & country == "US" | candem == 8 & country == "US", cluster(resp)
eststo b3us
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save CEFvuscamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save CEFvusmm, replace
graph combine CEFvusmm.gph CEFvuscamce.gph, commonscheme title("United States") xcommon cols(1)
graph save CEFvus, replace

reg support i.candem##ib3.cancom if candem == 7 | candem == 8, cluster(resp)
eststo b3po
margins candem#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save CEFvcamce, replace
quietly margins, over(candem) at(cancom=(1(1)5))
marginsplot, legend(ring (0) position(10) order(3 "Against manipulation (MMs)" 4 "Support manipulation (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small))   title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0))  xscale(off) ylabel(1.5(0.5)3.5, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save CEFvmm, replace
graph combine CEFvmm.gph CEFvcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save CEFvpo, replace


graph combine CEFvpo.gph CEFvcz.gph CEFvmx.gph CEFvsk.gph CEFvuk.gph CEFvus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\CEFvcompRR.pdf", replace

esttab b3po b3cz b3mx b3sk b3uk b3us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.B3.tex", obslast gaps ar2 nonumbers nonotes se drop(7.candem*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.B3: Supporting table for Figure B3 showing the results when the only type of undemocratic behavior included is supporting electoral manipulation.") varlabels(8.candem "Undemocratic (Support manipulation)" 8.candem#2.cancom "Undemocratic x Incompetent" 8.candem#1.cancom "Undemocratic x Very incompetent" 8.candem#4.cancom "Undemocratic x Competent" 8.candem#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 8.candem#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)

*Testing whether the effects of the different undemocratic behaviors are different from each other
reg support candem if candem == 1 | candem == 2
eststo rol
reg support clev
eststo clev
reg support cljh
eststo cljh
reg support candem if candem == 7 | candem == 8
eststo ef 
suest rol ef clev cljh, cluster(respondentid)
test [rol_mean]candem-[clev_mean]clev = 0
test [rol_mean]candem-[cljh_mean]cljh = 0
test [rol_mean]candem-[ef_mean]candem = 0
test [ef_mean]candem-[clev_mean]clev = 0
test [ef_mean]candem-[cljh_mean]cljh = 0
test [cljh_mean]cljh-[clev_mean]clev = 0

*Figure showing average effects of each attribute
recode candem (7 = 0) (8 = 1) (else=.), gen(ef)
recode candem (1 = 0) (2 = 1) (else=.), gen(rol)

reg support ef, cluster(resp)
eststo efpo
reg support ef if country == "CZ", cluster(resp)
eststo efcz
reg support ef if country == "MX", cluster(resp)
eststo efmx
reg support ef if country == "SK", cluster(resp)
eststo efsk
reg support ef if country == "UK", cluster(resp)
eststo efuk
reg support ef if country == "US", cluster(resp)
eststo efus

reg support rol, cluster(resp)
eststo rolpo
reg support rol if country == "CZ", cluster(resp)
eststo rolcz
reg support rol if country == "MX", cluster(resp)
eststo rolmx
reg support rol if country == "SK", cluster(resp)
eststo rolsk
reg support rol if country == "UK", cluster(resp)
eststo roluk
reg support rol if country == "US", cluster(resp)
eststo rolus

reg support clev, cluster(resp)
eststo clevpo
reg support clev if country == "CZ", cluster(resp)
eststo clevcz
reg support clev if country == "MX", cluster(resp)
eststo clevmx
reg support clev if country == "SK", cluster(resp)
eststo clevsk
reg support clev if country == "UK", cluster(resp)
eststo clevuk
reg support clev if country == "US", cluster(resp)
eststo clevus

reg support cljh, cluster(resp)
eststo cljhpo
reg support cljh if country == "CZ", cluster(resp)
eststo cljhcz
reg support cljh if country == "MX", cluster(resp)
eststo cljhmx
reg support cljh if country == "SK", cluster(resp)
eststo cljhsk
reg support cljh if country == "UK", cluster(resp)
eststo cljhuk
reg support cljh if country == "US", cluster(resp)
eststo cljhus

coefplot (efpo, label(Electoral manipulation)) (rolpo, label(Ignore opposing judges)) (clevpo, label(Encouraging violence)) (cljhpo, label(Journalist harassment)), drop(_cons) title("Pooled") yscale(off) legend(ring(0) position(2) row(2) size(vsmall)) xline(0)
graph save C7po, replace
coefplot (efcz, label(Electoral manipulation)) (rolcz, label(Ignore opposing judges)) (clevcz, label(Encouraging violence)) (cljhcz, label(Journalist harassment)), drop(_cons) title("Czech Republic") yscale(off) legend(off) xline(0)
graph save C7cz, replace
coefplot (efmx, label(Electoral manipulation)) (rolmx, label(Ignore opposing judges)) (clevmx, label(Encouraging violence)) (cljhmx, label(Journalist harassment)), drop(_cons) title("Mexico") yscale(off) legend(off) xline(0)
graph save C7mx, replace
coefplot (efsk, label(Electoral manipulation)) (rolsk, label(Ignore opposing judges)) (clevsk, label(Encouraging violence)) (cljhsk, label(Journalist harassment)), drop(_cons) title("South Korea") yscale(off) legend(off) xline(0)
graph save C7sk, replace
coefplot (efuk, label(Electoral manipulation)) (roluk, label(Ignore opposing judges)) (clevuk, label(Encouraging violence)) (cljhuk, label(Journalist harassment)), drop(_cons) title("United Kingdom") yscale(off) legend(off) xline(0)
graph save C7uk, replace
coefplot (efus, label(Electoral manipulation)) (rolus, label(Ignore opposing judges)) (clevus, label(Encouraging violence)) (cljhus, label(Journalist harassment)), drop(_cons) title("United States") yscale(off) legend(off) xline(0)
graph save C7us, replace

grc1leg C7po.gph C7cz.gph C7mx.gph C7sk.gph C7uk.gph C7us.gph, xcommon cols(2)
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\C7vcompRR.pdf", replace

***Appendix C: Including other attributes
reg support i.candemmg##ib3.cancom i.dissumm i.partymmain i.canage i.cangender i.canbackground if country == "CZ", cluster(resp)
eststo c1cz
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save Dvczcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save Dvczmm, replace
graph combine Dvczmm.gph Dvczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save Dvcz, replace

reg support i.candemmg##ib3.cancom i.dissumm i.partymmain i.canage i.cangender i.canbackground if country == "MX", cluster(resp)
eststo c1mx
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save Dvmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save Dvmxmm, replace
graph combine Dvmxmm.gph Dvmxcamce.gph, commonscheme title("Mexico") xcommon cols(1) 
graph save Dvmx, replace

reg support i.candemmg##ib3.cancom i.dissumm i.partymmain i.canage i.cangender i.canbackground if country == "SK", cluster(resp)
eststo c1sk
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save Dvskcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save Dvskmm, replace
graph combine Dvskmm.gph Dvskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save Dvsk, replace

reg support i.candemmg##ib3.cancom i.dissumm i.partymmain i.canage i.cangender i.canbackground if country == "UK", cluster(resp)
eststo c1uk
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save Dvukcamce, replace 
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save Dvukmm, replace
graph combine Dvukmm.gph Dvukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1) 
graph save Dvuk, replace

reg support i.candemmg##ib3.cancom i.dissumm i.partymmain i.canage i.cangender i.canbackground if country == "US", cluster(resp)
eststo c1us
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save Dvuscamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save Dvusmm, replace
graph combine Dvusmm.gph Dvuscamce.gph, commonscheme title("United States") xcommon cols(1) 
graph save Dvus, replace

reg support i.candemmg##ib3.cancom i.dissumm i.partymmain i.canage i.cangender i.canbackground, cluster(resp)
eststo c1po
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save Dvcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save Dvmm, replace
graph combine Dvmm.gph Dvcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save Dvpo, replace


graph combine Dvpo.gph Dvcz.gph Dvmx.gph Dvsk.gph Dvuk.gph Dvus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\DvcompRR.pdf", replace

esttab c1po c1cz c1mx c1sk c1uk c1us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableC1.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg* *dissumm *partymmain *canage *cangender *canbackground) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.C1: Supporting table for Figure C1 showing the results when other candidate attributes (policy distance to the respondent, co-partisanship with the respondent, candidate age, candidate gender, and candidate profession) are included as covariates.") varlabels(1.candemmg "Undemocratic behavior" 1.candemmg#2.cancom "Undemocratic x Incompetent" 1.candemmg#1.cancom "Undemocratic x Very incompetent" 1.candemmg#4.cancom "Undemocratic x Competent" 1.candemmg#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 1.candemmg#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)


***Appendix D: Full MM-plots and Benchmarking AMCE-plot
***MM
**CZ
mean support if country == "CZ", over(cangender) cluster(resp)
eststo gencz
mean support if country == "CZ", over(canbackground) cluster(resp)
eststo profcz
mean support if country == "CZ", over(canparty) cluster(resp)
eststo partcz
mean support if country == "CZ", over(canredi) cluster(resp)
eststo redicz
mean support if country == "CZ", over(cansoc) cluster(resp)
eststo soccz
mean support if country == "CZ", over(candem) cluster(resp)
eststo demcz
mean support if country == "CZ", over(caneco) cluster(resp)
eststo ecocz
mean support if country == "CZ", over(cancor) cluster(resp)
eststo corcz
coefplot (gencz, label(Gender)) (profcz, label(Profession)) (partcz, label(Party)) (redicz, label(Redistribution)) (soccz, label(Morality issues)) (demcz, label(Dem/Undem)) (ecocz, label(Economic competence)) (corcz, label(Corruption competence)), ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) legend(pos(6) size(vsmall) cols(2)) coeflabels(c.support@1.cangender = "Female" c.support@2.cangender = "Male" c.support@1.canbackground = "Actor/actress" c.support@2.canbackground = "Journalist" c.support@4.canbackground = "Professor" c.support@3.canbackground = "Political career"  c.support@1.canparty = "ANO 2011" c.support@2.canparty = "ODS" c.support@3.canparty = "ČSSD" c.support@1.canredi = "Decrease tax" c.support@2.canredi = "Decrease power of unions" c.support@3.canredi = "Decrease welfare spending" c.support@4.canredi = "Increase tax" c.support@5.canredi = "Increase power of unions" c.support@6.canredi = "Increase welfare spending" c.support@1.cansoc = "Illegal immigrants apply for citizenship" c.support@2.cansoc = "Arrest and deport illegal immigrants" c.support@3.cansoc = "Make same sex marriage easier" c.support@4.cansoc = "Make it easier to get an abortion" c.support@5.cansoc = "Make same sex marriage harder" c.support@6.cansoc = "Make it harder to get an abortion" c.support@1.candem = "Adhere to opposing judges" c.support@2.candem = "Ignore opposing judges" c.support@3.candem = "Journalist harassment acceptable" c.support@4.candem = "Encourage violence" c.support@5.candem = "Discourage violence" c.support@6.candem = "Journalist harassment unacceptable" c.support@7.candem = "Against electoral manipulation" c.support@8.candem = "Support electoral manipulation" c.support@1.caneco = "Handling economic matters: Bad" c.support@2.caneco = "Handling economic matters: Neutral" c.support@3.caneco = "Handling economic matters: Good" c.support@1.cancor = "Fighting corruption: Bad" c.support@2.cancor = "Fighting corruption: Neutral" c.support@3.cancor = "Fighting corruption: Good") mcolor(black) ciopts(color(black)) msize(medium)
graph display, ysize(9) xsize(7.5)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\czfullamce.pdf", replace
reg support i.cangender i.canbackground i.canparty i.canredi i.cansoc i.candem i.caneco i.cancor if country == "CZ", cluster(resp)
eststo D1cz
esttab D1cz using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.D1.tex", obslast gaps ar2 nonumbers nonotes wide se drop() addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.D1: Supporting table for Figure D1 showing marginal means for all attributes in the Czech Republic.") varlabels(1.cangender "Female (Reference category)" 2.cangender "Male" 1.canbackground "Actor/actress (Reference category)" 2.canbackground "Journalist" 3.canbackground "Political career" 4.canbackground "Professor" 1.canparty "ANO 2011 (Reference category)" 2.canparty "ODS" 3.canparty "ČSSD" 1.canredi "Decrease tax (Reference category)" 2.canredi "Decrease power of unions" 3.canredi "Decrease welfare spending"  4.canredi "Increase tax" 5.canredi "Increase power of unions" 6.canredi "Increase welfare spending" 1.cansoc "Illegal immigrants apply for citizenship (Reference category)" 2.cansoc "Arrest and deport illegal immigrants" 3.cansoc "Make same sex marriage easier" 4.cansoc "Make it easier to get an abortion" 5.cansoc "Make same sex marriage harder" 6.cansoc "Make it harder to get an abortion" 1.candem "Adhere to opposing judges (Reference category)" 2.candem "Ignore opposing judges" 3.candem "Journalist harassment acceptable" 4.candem "Encourage violence" 5.candem "Discourage violence" 6.candem "Journalist harassment unacceptable" 7.candem "Against electoral manipulation" 8.candem "Support electoral manipulation" 1.caneco "Handling economic matters: Bad (Reference category)" 2.caneco "Handling economic matters: Neutral" 3.caneco "Handling economic matters: Bad" 1.cancor "Fighting corruption: Bad (Reference category)" 2.cancor "Fighting corruption: Neutral" 3.cancor "Fighting corruption: Good" _cons Constant) replace b(%7.2f) se(%7.2f)

**US
mean support if country == "US", over(cangender) cluster(resp)
eststo genus
mean support if country == "US", over(canbackground) cluster(resp)
eststo profus
mean support if country == "US", over(canparty) cluster(resp)
eststo partus
mean support if country == "US", over(canredi) cluster(resp)
eststo redius
mean support if country == "US", over(cansoc) cluster(resp)
eststo socus
mean support if country == "US", over(candem) cluster(resp)
eststo demus
mean support if country == "US", over(caneco) cluster(resp)
eststo ecous
mean support if country == "US", over(cancor) cluster(resp)
eststo corus
coefplot (genus, label(Gender)) (profus, label(Profession)) (partus, label(Party)) (redius, label(Redistribution)) (socus, label(Morality issues)) (demus, label(Dem/Undem)) (ecous, label(Economic competence)) (corus, label(Corruption competence)), ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) legend(pos(6) size(vsmall) cols(2)) coeflabels(c.support@1.cangender = "Female" c.support@2.cangender = "Male" c.support@2.canbackground = "Company founder/director" c.support@1.canbackground = "Self-employed" c.support@5.canbackground = "Journalist" c.support@3.canbackground = "Lawyer" c.support@4.canbackground = "Political career" c.support@1.canparty = "Democrat" c.support@2.canparty = "Republican" c.support@1.canredi = "Decrease tax" c.support@2.canredi = "Decrease power of unions" c.support@3.canredi = "Decrease welfare spending" c.support@4.canredi = "Increase tax" c.support@5.canredi = "Increase power of unions" c.support@6.canredi = "Increase welfare spending" c.support@1.cansoc = "Illegal immigrants apply for citizenship" c.support@2.cansoc = "Arrest and deport illegal immigrants" c.support@3.cansoc = "Make same sex marriage easier" c.support@4.cansoc = "Make it easier to get an abortion" c.support@5.cansoc = "Make same sex marriage harder" c.support@6.cansoc = "Make it harder to get an abortion" c.support@1.candem = "Adhere to opposing judges" c.support@2.candem = "Ignore opposing judges" c.support@3.candem = "Journalist harassment acceptable" c.support@4.candem = "Encourage violence" c.support@5.candem = "Discourage violence" c.support@6.candem = "Journalist harassment unacceptable" c.support@7.candem = "Against electoral manipulation" c.support@8.candem = "Support electoral manipulation" c.support@1.caneco = "Handling economic matters: Bad" c.support@2.caneco = "Handling economic matters: Neutral" c.support@3.caneco = "Handling economic matters: Good" c.support@1.cancor = "Fighting corruption: Bad" c.support@2.cancor = "Fighting corruption: Neutral" c.support@3.cancor = "Fighting corruption: Good") mcolor(black) ciopts(color(black)) msize(medium)
graph display, ysize(9) xsize(7.5)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\usfullamce.pdf", replace
reg support i.cangender i.canbackground i.canparty i.canredi i.cansoc i.candem i.caneco i.cancor if country == "US", cluster(resp)
eststo D5us
esttab D5us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.D5.tex", obslast gaps ar2 nonumbers nonotes wide se drop() addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.D5: Supporting table for Figure D5 showing marginal means for all attributes in the United States.") varlabels(1.cangender "Female (Reference category)" 2.cangender "Male" 1.canbackground "Self-employed (Reference category)" 2.canbackground "Company founder/director" 3.canbackground "Lawyer" 4.canbackground "Political career" 5.canbackground "Journalist" 1.canparty "Democrat (Reference category)" 2.canparty "Republican" 1.canredi "Decrease tax (Reference category)" 2.canredi "Decrease power of unions" 3.canredi "Decrease welfare spending"  4.canredi "Increase tax" 5.canredi "Increase power of unions" 6.canredi "Increase welfare spending" 1.cansoc "Illegal immigrants apply for citizenship (Reference category)" 2.cansoc "Arrest and deport illegal immigrants" 3.cansoc "Make same sex marriage easier" 4.cansoc "Make it easier to get an abortion" 5.cansoc "Make same sex marriage harder" 6.cansoc "Make it harder to get an abortion" 1.candem "Adhere to opposing judges (Reference category)" 2.candem "Ignore opposing judges" 3.candem "Journalist harassment acceptable" 4.candem "Encourage violence" 5.candem "Discourage violence" 6.candem "Journalist harassment unacceptable" 7.candem "Against electoral manipulation" 8.candem "Support electoral manipulation" 1.caneco "Handling economic matters: Bad (Reference category)" 2.caneco "Handling economic matters: Neutral" 3.caneco "Handling economic matters: Bad" 1.cancor "Fighting corruption: Bad (Reference category)" 2.cancor "Fighting corruption: Neutral" 3.cancor "Fighting corruption: Good" _cons Constant) replace b(%7.2f) se(%7.2f)


**UK
mean support if country == "UK", over(cangender) cluster(resp)
eststo genuk
mean support if country == "UK", over(canbackground) cluster(resp)
eststo profuk
mean support if country == "UK", over(canparty) cluster(resp)
eststo partuk
mean support if country == "UK", over(canredi) cluster(resp)
eststo rediuk
mean support if country == "UK", over(cansoc) cluster(resp)
eststo socuk
mean support if country == "UK", over(candem) cluster(resp)
eststo demuk
mean support if country == "UK", over(caneco) cluster(resp)
eststo ecouk
mean support if country == "UK", over(cancor) cluster(resp)
eststo coruk
coefplot (genuk, label(Gender)) (profuk, label(Profession)) (partuk, label(Party)) (rediuk, label(Redistribution)) (socuk, label(Morality issues)) (demuk, label(Dem/Undem)) (ecouk, label(Economic competence)) (coruk, label(Corruption competence)), ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) legend(pos(6) size(vsmall) cols(2)) coeflabels(c.support@1.cangender = "Female" c.support@2.cangender = "Male" c.support@1.canbackground = "Banker" c.support@2.canbackground = "Civil servant" c.support@3.canbackground = "Journalist" c.support@4.canbackground = "Lawyer" c.support@5.canbackground = "Political career" c.support@1.canparty = "Conservatives" c.support@2.canparty = "Labour" c.support@1.canredi = "Decrease tax" c.support@2.canredi = "Decrease power of unions" c.support@3.canredi = "Decrease welfare spending" c.support@4.canredi = "Increase tax" c.support@5.canredi = "Increase power of unions" c.support@6.canredi = "Increase welfare spending" c.support@1.cansoc = "Illegal immigrants apply for citizenship" c.support@2.cansoc = "Arrest and deport illegal immigrants" c.support@3.cansoc = "Make same sex marriage easier" c.support@4.cansoc = "Make it easier to get an abortion" c.support@5.cansoc = "Make same sex marriage harder" c.support@6.cansoc = "Make it harder to get an abortion" c.support@1.candem = "Adhere to opposing judges" c.support@2.candem = "Ignore opposing judges" c.support@3.candem = "Journalist harassment acceptable" c.support@4.candem = "Encourage violence" c.support@5.candem = "Discourage violence" c.support@6.candem = "Journalist harassment unacceptable" c.support@7.candem = "Against electoral manipulation" c.support@8.candem = "Support electoral manipulation" c.support@1.caneco = "Handling economic matters: Bad" c.support@2.caneco = "Handling economic matters: Neutral" c.support@3.caneco = "Handling economic matters: Good" c.support@1.cancor = "Fighting corruption: Bad" c.support@2.cancor = "Fighting corruption: Neutral" c.support@3.cancor = "Fighting corruption: Good") mcolor(black) ciopts(color(black)) msize(medium)
graph display, ysize(9) xsize(7.5)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\ukfullamce.pdf", replace
reg support i.cangender i.canbackground i.canparty i.canredi i.cansoc i.candem i.caneco i.cancor if country == "UK", cluster(resp)
eststo D4uk
esttab D4uk using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.D4.tex", obslast gaps ar2 nonumbers nonotes wide se drop() addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.D4: Supporting table for Figure D4 showing marginal means for all attributes in the United Kingdom.") varlabels(1.cangender "Female (Reference category)" 2.cangender "Male" 1.canbackground "Banker (Reference category)" 2.canbackground "Civil servant" 3.canbackground "Journalist" 4.canbackground "Lawyer" 5.canbackground "Political career" 1.canparty "Conservatives (Reference category)" 2.canparty "Labour" 1.canredi "Decrease tax (Reference category)" 2.canredi "Decrease power of unions" 3.canredi "Decrease welfare spending"  4.canredi "Increase tax" 5.canredi "Increase power of unions" 6.canredi "Increase welfare spending" 1.cansoc "Illegal immigrants apply for citizenship (Reference category)" 2.cansoc "Arrest and deport illegal immigrants" 3.cansoc "Make same sex marriage easier" 4.cansoc "Make it easier to get an abortion" 5.cansoc "Make same sex marriage harder" 6.cansoc "Make it harder to get an abortion" 1.candem "Adhere to opposing judges (Reference category)" 2.candem "Ignore opposing judges" 3.candem "Journalist harassment acceptable" 4.candem "Encourage violence" 5.candem "Discourage violence" 6.candem "Journalist harassment unacceptable" 7.candem "Against electoral manipulation" 8.candem "Support electoral manipulation" 1.caneco "Handling economic matters: Bad (Reference category)" 2.caneco "Handling economic matters: Neutral" 3.caneco "Handling economic matters: Bad" 1.cancor "Fighting corruption: Bad (Reference category)" 2.cancor "Fighting corruption: Neutral" 3.cancor "Fighting corruption: Good" _cons Constant) replace b(%7.2f) se(%7.2f)

**MX
mean support if country == "MX", over(cangender) cluster(resp)
eststo genmx
mean support if country == "MX", over(canbackground) cluster(resp)
eststo profmx
mean support if country == "MX", over(canparty) cluster(resp)
eststo partmx
mean support if country == "MX", over(canredi) cluster(resp)
eststo redimx
mean support if country == "MX", over(cansoc) cluster(resp)
eststo socmx
mean support if country == "MX", over(candem) cluster(resp)
eststo demmx
mean support if country == "MX", over(caneco) cluster(resp)
eststo ecomx
mean support if country == "MX", over(cancor) cluster(resp)
eststo cormx
coefplot (genmx, label(Gender)) (profmx, label(Profession)) (partmx, label(Party)) (redimx, label(Redistribution)) (socmx, label(Morality issues)) (demmx, label(Dem/Undem)) (ecomx, label(Economic competence)) (cormx, label(Corruption competence)), ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) legend(pos(6) size(vsmall) cols(2)) coeflabels(c.support@1.cangender = "Female" c.support@2.cangender = "Male" c.support@1.canbackground = "Academic" c.support@4.canbackground = "Civil servant" c.support@6.canbackground = "Journalist" c.support@7.canbackground = "Lawyer" c.support@5.canbackground = "Engineer" c.support@2.canbackground = "Accountant" c.support@3.canbackground = "Business administration" c.support@8.canbackground = "Professional sports" c.support@9.canbackground = "Self-employed" c.support@1.canparty = "MORENA" c.support@2.canparty = "PAN" c.support@3.canparty = "PRD" c.support@4.canparty = "PRI" c.support@1.canredi = "Decrease tax" c.support@6.canredi = "Provide universal access to colleges" c.support@2.canredi = "Decrease welfare spending" c.support@3.canredi = "Increase tax" c.support@5.canredi = "Prevent universal access to colleges" c.support@4.canredi = "Increase welfare spending" c.support@1.cansoc = "Legalize same-sex marriage" c.support@2.cansoc = "Make abortion law more strict" c.support@3.cansoc = "Prohibit same-sex marriage" c.support@4.cansoc = "Provide amnesty to low-level drug offenders" c.support@5.cansoc = "Punish all drug-related crime harsher" c.support@6.cansoc = "Relax abortion law" c.support@1.candem = "Adhere to opposing judges" c.support@2.candem = "Ignore opposing judges" c.support@3.candem = "Journalist harassment acceptable" c.support@4.candem = "Encourage violence" c.support@5.candem = "Discourage violence" c.support@6.candem = "Journalist harassment unacceptable" c.support@7.candem = "Against electoral manipulation" c.support@8.candem = "Support electoral manipulation" c.support@1.caneco = "Handling economic matters: Bad" c.support@2.caneco = "Handling economic matters: Neutral" c.support@3.caneco = "Handling economic matters: Good" c.support@1.cancor = "Fighting corruption: Bad" c.support@2.cancor = "Fighting corruption: Neutral" c.support@3.cancor = "Fighting corruption: Good") mcolor(black) ciopts(color(black)) msize(medium)
graph display, ysize(9) xsize(7.5)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\mxfullamce.pdf", replace
reg support i.cangender i.canbackground i.canparty i.canredi i.cansoc i.candem i.caneco i.cancor if country == "MX", cluster(resp)
eststo D2mx
esttab D2mx using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.D2.tex", obslast gaps ar2 nonumbers nonotes wide se drop() addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.D2: Supporting table for Figure D2 showing marginal means for all attributes in the Mexico.") varlabels(1.cangender "Female (Reference category)" 2.cangender "Male" 1.canbackground "Academic (Reference category)" 2.canbackground "Accountant" 3.canbackground "Business administration" 4.canbackground "Civil servant" 5.canbackground "Engineer" 6.canbackground "Journalist" 7.canbackground "Lawyer" 8.canbackground "Professional sports" 9.canbackground "Self-employed" 1.canparty "MORENA (Reference category)" 2.canparty "PAN" 3.canparty "PRD" 4.canparty "PRI" 1.canredi "Decrease tax (Reference category)" 2.canredi "Decrease welfare spending"  3.canredi "Increase tax" 4.canredi "Increase welfare spending" 5.canredi "Prevent universal access to colleges" 6.canredi "Provide universal access to colleges" 1.cansoc "Legalize same-sex marriage (Reference category)" 2.cansoc "Make abortion law more strict" 3.cansoc "Prohibit same-sex marriage" 4.cansoc "Provide amnesty to low-level drug offenders" 5.cansoc "Punish all drug-related crime harsher" 6.cansoc "Relax abortion law" 1.candem "Adhere to opposing judges (Reference category)" 2.candem "Ignore opposing judges" 3.candem "Journalist harassment acceptable" 4.candem "Encourage violence" 5.candem "Discourage violence" 6.candem "Journalist harassment unacceptable" 7.candem "Against electoral manipulation" 8.candem "Support electoral manipulation" 1.caneco "Handling economic matters: Bad (Reference category)" 2.caneco "Handling economic matters: Neutral" 3.caneco "Handling economic matters: Bad" 1.cancor "Fighting corruption: Bad (Reference category)" 2.cancor "Fighting corruption: Neutral" 3.cancor "Fighting corruption: Good" _cons Constant) replace b(%7.2f) se(%7.2f)

**SK
mean support if country == "SK", over(cangender) cluster(resp)
eststo gensk
mean support if country == "SK", over(canbackground) cluster(resp)
eststo profsk
mean support if country == "SK", over(canparty) cluster(resp)
eststo partsk
mean support if country == "SK", over(canredi) cluster(resp)
eststo redisk
mean support if country == "SK", over(cansoc) cluster(resp)
eststo socsk
mean support if country == "SK", over(candem) cluster(resp)
eststo demsk
mean support if country == "SK", over(caneco) cluster(resp)
eststo ecosk
mean support if country == "SK", over(cancor) cluster(resp)
eststo corsk
coefplot (gensk, label(Gender)) (profsk, label(Profession)) (partsk, label(Party)) (redisk, label(Redistribution)) (socsk, label(Morality issues)) (demsk, label(Dem/Undem)) (ecosk, label(Economic competence)) (corsk, label(Corruption competence)), ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) legend(pos(6) size(vsmall) cols(2)) coeflabels(c.support@1.cangender = "Female" c.support@2.cangender = "Male" c.support@1.canbackground = "Army general" c.support@2.canbackground = "Civil servant" c.support@3.canbackground = "Company director" c.support@4.canbackground = "Engineer" c.support@5.canbackground = "Journalist" c.support@6.canbackground = "Lawyer" c.support@7.canbackground = "Political career" c.support@8.canbackground = "Professor" c.support@9.canbackground = "Self-employed" c.support@1.canparty = "Democratic Party" c.support@2.canparty = "United Future Party" c.support@1.canredi = "Decrease tax" c.support@2.canredi = "Decrease power of unions" c.support@3.canredi = "Decrease welfare spending" c.support@4.canredi = "Increase tax" c.support@5.canredi = "Increase power of unions" c.support@6.canredi = "Increase welfare spending" c.support@1.cansoc = "Decrease funds to the army" c.support@2.cansoc = "Increase funds to the army" c.support@3.cansoc = "Legalize same-sex marriage" c.support@4.cansoc = "Make abortion law more strict" c.support@5.cansoc = "Prohibit same-sex marriage" c.support@6.cansoc = "Relax abortion law" c.support@1.candem = "Adhere to opposing judges" c.support@2.candem = "Ignore opposing judges" c.support@3.candem = "Journalist harassment acceptable" c.support@4.candem = "Encourage violence" c.support@5.candem = "Discourage violence" c.support@6.candem = "Journalist harassment unacceptable" c.support@7.candem = "Against electoral manipulation" c.support@8.candem = "Support electoral manipulation" c.support@1.caneco = "Handling economic matters: Bad" c.support@2.caneco = "Handling economic matters: Neutral" c.support@3.caneco = "Handling economic matters: Good" c.support@1.cancor = "Fighting corruption: Bad" c.support@2.cancor = "Fighting corruption: Neutral" c.support@3.cancor = "Fighting corruption: Good") mcolor(black) ciopts(color(black)) msize(medium)
graph display, ysize(9) xsize(7.5)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\skfullamce.pdf", replace
reg support i.cangender i.canbackground i.canparty i.canredi i.cansoc i.candem i.caneco i.cancor if country == "SK", cluster(resp)
eststo D3sk
esttab D3sk using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.D3.tex", obslast gaps ar2 nonumbers nonotes wide se drop() addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.D3: Supporting table for Figure D3 showing marginal means for all attributes in the South Korea.") varlabels(1.cangender "Female (Reference category)" 2.cangender "Male" 1.canbackground "Army general (Reference category)" 2.canbackground "Civil servant" 3.canbackground "Company director" 4.canbackground "Engineer" 5.canbackground "Journalist" 6.canbackground "Lawyer" 7.canbackground "Political career" 8.canbackground "Professor" 9.canbackground "Self-employed" 1.canparty "Democratic Party (Reference category)" 2.canparty "United Future Party" 1.canredi "Decrease tax (Reference category)" 2.canredi "Decrease power of unions" 3.canredi "Decrease welfare spending"  4.canredi "Increase tax" 5.canredi "Increase power of unions" 6.canredi "Increase welfare spending" 1.cansoc "Decrease funds to the army (Reference category)" 2.cansoc "Increase funds to the army" 3.cansoc "Legalize same-sex marriage" 4.cansoc "Make abortion law more strict" 5.cansoc "Prohibit same-sex marriage" 6.cansoc "Relax abortion law" 1.candem "Adhere to opposing judges (Reference category)" 2.candem "Ignore opposing judges" 3.candem "Journalist harassment acceptable" 4.candem "Encourage violence" 5.candem "Discourage violence" 6.candem "Journalist harassment unacceptable" 7.candem "Against electoral manipulation" 8.candem "Support electoral manipulation" 1.caneco "Handling economic matters: Bad (Reference category)" 2.caneco "Handling economic matters: Neutral" 3.caneco "Handling economic matters: Bad" 1.cancor "Fighting corruption: Bad (Reference category)" 2.cancor "Fighting corruption: Neutral" 3.cancor "Fighting corruption: Good" _cons Constant) replace b(%7.2f) se(%7.2f)

***AMCE
gen canagedecade = canage/10 //rescaling for more sense
generate distance = (dissumm-1)/(7-1)*(5-1)+1 //align distance with other continious measures
reg support candemmg cancom distance partymmain canagedecade cangender if country == "CZ", cluster(resp)
coefplot, drop(_cons) coeflabels(candemmg = "Undemocratic" distance = "Policy distance (1-5)" canagedecade = "Age (10 years)" partymmain = "Co-partisanship (1-5)" cangender = "Male" cancom = "Competence (1-5)") xline(0) title("Czech Republic")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\amcecz", replace

reg support candemmg cancom distance partymmain canagedecade cangender if country == "MX", cluster(resp)
coefplot, drop(_cons) coeflabels(candemmg = "Undemocratic" distance = "Policy distance (1-5)" canagedecade = "Age (10 years)" partymmain = "Co-partisanship (1-5)" cangender = "Male" cancom = "Competence (1-5)") xline(0) title("Mexico")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\amcemx", replace

reg support candemmg cancom distance partymmain canagedecade cangender if country == "SK", cluster(resp)
coefplot, drop(_cons) coeflabels(candemmg = "Undemocratic" distance = "Policy distance (1-5)" canagedecade = "Age (10 years)" partymmain = "Co-partisanship (1-5)" cangender = "Male" cancom = "Competence (1-5)") xline(0) title("South Korea")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\amcesk", replace

reg support candemmg cancom distance partymmain canagedecade cangender if country == "UK", cluster(resp)
coefplot, drop(_cons) coeflabels(candemmg = "Undemocratic" distance = "Policy distance (1-5)" canagedecade = "Age (10 years)" partymmain = "Co-partisanship (1-5)" cangender = "Male" cancom = "Competence (1-5)") xline(0) title("United Kingdom")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\amceuk", replace

reg support candemmg cancom distance partymmain canagedecade cangender if country == "US", cluster(resp)
coefplot, drop(_cons) coeflabels(candemmg = "Undemocratic" distance = "Policy distance (1-5)" canagedecade = "Age (10 years)" partymmain = "Co-partisanship (1-5)" cangender = "Male" cancom = "Competence (1-5)") xline(0) title("United States")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\amceus", replace

reg support candemmg cancom distance partymmain canagedecade cangender, cluster(resp)
coefplot, drop(_cons) coeflabels(candemmg = "Undemocratic" distance = "Policy distance (1-5)" canagedecade = "Age (10 years)" partymmain = "Co-partisanship (1-5)" cangender = "Male" cancom = "Competence (1-5)") xline(0) title("Pooled")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\amcepo", replace

graph combine "U:\How to Save a Democracy\Competence\Revisions\Results\amcepo" "U:\How to Save a Democracy\Competence\Revisions\Results\amcecz" "U:\How to Save a Democracy\Competence\Revisions\Results\amcemx" "U:\How to Save a Democracy\Competence\Revisions\Results\amcesk" "U:\How to Save a Democracy\Competence\Revisions\Results\amceuk" "U:\How to Save a Democracy\Competence\Revisions\Results\amceus", xcommon cols(2) b1title("", size(small)) l1title("", size(small)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\compamce.pdf", replace

***Appendix E: Using Competence in its Squared Form
reg support i.candemmg##c.cancom##c.cancom if country == "CZ", cluster(resp)
eststo E1cz
margins, dydx(candemmg) at(cancom=(1(1)5))
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.3 0 0.1, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save Fvczcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save Fvczmm, replace
graph combine Fvczmm.gph Fvczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save Fvcz, replace

reg support i.candemmg##c.cancom##c.cancom if country == "MX", cluster(resp)
eststo E1mx
margins, dydx(candemmg) at(cancom=(1(1)5))
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.3 0 0.1, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save Fvmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save Fvmxmm, replace
graph combine Fvmxmm.gph Fvmxcamce.gph, commonscheme title("Mexico") xcommon cols(1) 
graph save Fvmx, replace

reg support i.candemmg##c.cancom##c.cancom if country == "SK", cluster(resp)
eststo E1sk
margins, dydx(candemmg) at(cancom=(1(1)5))
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.3 0 0.1, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save Fvskcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save Fvskmm, replace
graph combine Fvskmm.gph Fvskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save Fvsk, replace

reg support i.candemmg##c.cancom##c.cancom if country == "UK", cluster(resp)
eststo E1uk
margins, dydx(candemmg) at(cancom=(1(1)5))
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.3 0 0.1, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save Fvukcamce, replace 
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save Fvukmm, replace
graph combine Fvukmm.gph Fvukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1) 
graph save Fvuk, replace

reg support i.candemmg##c.cancom##c.cancom if country == "US", cluster(resp)
eststo E1us
margins, dydx(candemmg) at(cancom=(1(1)5))
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.3 0 0.1, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save Fvuscamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save Fvusmm, replace
graph combine Fvusmm.gph Fvuscamce.gph, commonscheme title("United States") xcommon cols(1) 
graph save Fvus, replace

reg support i.candemmg##c.cancom##c.cancom, cluster(resp)
eststo E1po
margins, dydx(candemmg) at(cancom=(1(1)5))
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.3 0 0.1, gmax labsize(medsmall)) fysize(15) title("") legend(on order(2 "Effects of UB") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero)) plotopts(msymbol(O))
graph save Fvcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save Fvmm, replace
graph combine Fvmm.gph Fvcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save Fvpo, replace

graph combine Fvpo.gph Fvcz.gph Fvmx.gph Fvsk.gph Fvuk.gph Fvus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\FvcompRR.pdf", replace

esttab E1po E1cz E1mx E1sk E1uk E1us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.E1.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.E1: Supporting table for Figure E1 showing the results when employing candidate competence in its squared form.") varlabels(1.candemmg "Undemocratic behavior" cancom "Competence" 1.candemmg#c.cancom "Undemocratic x Competence" c.cancom#c.cancom "Competence^2" 1.candemmg#c.cancom#c.cancom "Undemocratic x Competence^2" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)

***Appendix F: Robustness of Results Across Partisanship
reg support i.candemmg##ib3.cancom if partymmain < 3 & country == "CZ", cluster(resp)
eststo F3cz
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G1vczcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G1vczmm, replace
graph combine G1vczmm.gph G1vczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save G1vcz, replace

reg support i.candemmg##ib3.cancom if partymmain < 3 & country == "MX", cluster(resp)
eststo F3mx
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G1vmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G1vmxmm, replace
graph combine G1vmxmm.gph G1vmxcamce.gph, commonscheme title("Mexico") xcommon cols(1) 
graph save G1vmx, replace

reg support i.candemmg##ib3.cancom if partymmain < 3 & country == "SK", cluster(resp)
eststo F3sk
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save G1vskcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save G1vskmm, replace
graph combine G1vskmm.gph G1vskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save G1vsk, replace

reg support i.candemmg##ib3.cancom if partymmain < 3 & country == "UK", cluster(resp)
eststo F3uk
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G1vukcamce, replace 
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G1vukmm, replace
graph combine G1vukmm.gph G1vukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1) 
graph save G1vuk, replace

reg support i.candemmg##ib3.cancom if partymmain < 3 & country == "US", cluster(resp)
eststo F3us
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G1vuscamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G1vusmm, replace
graph combine G1vusmm.gph G1vuscamce.gph, commonscheme title("United States") xcommon cols(1) 
graph save G1vus, replace

reg support i.candemmg##ib3.cancom if partymmain < 3, cluster(resp)
eststo F3po
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save G1vcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save G1vmm, replace
graph combine G1vmm.gph G1vcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save G1vpo, replace


graph combine G1vpo.gph G1vcz.gph G1vmx.gph G1vsk.gph G1vuk.gph G1vus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0)) title("Out-partisans")
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\G1vcompRR.pdf", replace

esttab F3po F3cz F3mx F3sk F3uk F3us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.F3.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.F3: Supporting table for Figure F3 showing the results when only observations where the respondent is an out-partisan to the candidate are included.") varlabels(1.candemmg "Undemocratic behavior" 1.candemmg#2.cancom "Undemocratic x Incompetent" 1.candemmg#1.cancom "Undemocratic x Very incompetent" 1.candemmg#4.cancom "Undemocratic x Competent" 1.candemmg#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 1.candemmg#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)


reg support i.candemmg##ib3.cancom if partymmain == 3 & country == "CZ", cluster(resp)
eststo F2cz
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G2vczcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G2vczmm, replace
graph combine G2vczmm.gph G2vczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save G2vcz, replace

reg support i.candemmg##ib3.cancom if partymmain == 3 & country == "MX", cluster(resp)
eststo F2mx
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G2vmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G2vmxmm, replace
graph combine G2vmxmm.gph G2vmxcamce.gph, commonscheme title("Mexico") xcommon cols(1) 
graph save G2vmx, replace

reg support i.candemmg##ib3.cancom if partymmain == 3 & country == "SK", cluster(resp)
eststo F2sk
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save G2vskcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save G2vskmm, replace
graph combine G2vskmm.gph G2vskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save G2vsk, replace

reg support i.candemmg##ib3.cancom if partymmain == 3 & country == "UK", cluster(resp)
eststo F2uk
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G2vukcamce, replace 
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G2vukmm, replace
graph combine G2vukmm.gph G2vukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1) 
graph save G2vuk, replace

reg support i.candemmg##ib3.cancom if partymmain == 3 & country == "US", cluster(resp)
eststo F2us
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G2vuscamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G2vusmm, replace
graph combine G2vusmm.gph G2vuscamce.gph, commonscheme title("United States") xcommon cols(1) 
graph save G2vus, replace

reg support i.candemmg##ib3.cancom if partymmain == 3, cluster(resp)
eststo F2po
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save G2vcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save G2vmm, replace
graph combine G2vmm.gph G2vcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save G2vpo, replace


graph combine G2vpo.gph G2vcz.gph G2vmx.gph G2vsk.gph G2vuk.gph G2vus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0)) title("Neutrals")
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\G2vcompRR.pdf", replace

esttab F2po F2cz F2mx F2sk F2uk F2us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.F2.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.F2: Supporting table for Figure F2 showing the results when only observations where the respondent holds neutral feelings toward the candidate's party are included.") varlabels(1.candemmg "Undemocratic behavior" 1.candemmg#2.cancom "Undemocratic x Incompetent" 1.candemmg#1.cancom "Undemocratic x Very incompetent" 1.candemmg#4.cancom "Undemocratic x Competent" 1.candemmg#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 1.candemmg#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)


reg support i.candemmg##ib3.cancom if partymmain > 3 & partymmain != . & country == "CZ", cluster(resp)
eststo F1cz
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G3vczcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G3vczmm, replace
graph combine G3vczmm.gph G3vczcamce.gph, commonscheme title("Czech Republic") xcommon cols(1)
graph save G3vcz, replace

reg support i.candemmg##ib3.cancom if partymmain > 3 & partymmain != . & country == "MX", cluster(resp)
eststo F1mx
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G3vmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G3vmxmm, replace
graph combine G3vmxmm.gph G3vmxcamce.gph, commonscheme title("Mexico") xcommon cols(1) 
graph save G3vmx, replace

reg support i.candemmg##ib3.cancom if partymmain > 3 & partymmain != . & country == "SK", cluster(resp)
eststo F1sk
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) plotopts(msymbol(O))
graph save G3vskcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save G3vskmm, replace
graph combine G3vskmm.gph G3vskcamce.gph, commonscheme title("South Korea") xcommon cols(1) fxsize(33)
graph save G3vsk, replace

reg support i.candemmg##ib3.cancom if partymmain > 3 & partymmain != . & country == "UK", cluster(resp)
eststo F1uk
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G3vukcamce, replace 
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G3vukmm, replace
graph combine G3vukmm.gph G3vukcamce.gph, commonscheme title("United Kingdom") xcommon cols(1) 
graph save G3vuk, replace

reg support i.candemmg##ib3.cancom if partymmain > 3 & partymmain != . & country == "US", cluster(resp)
eststo F1us
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save G3vuscamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid)) yscale(off)
graph save G3vusmm, replace
graph combine G3vusmm.gph G3vuscamce.gph, commonscheme title("United States") xcommon cols(1) 
graph save G3vus, replace

reg support i.candemmg##ib3.cancom if partymmain > 3 & partymmain != ., cluster(resp)
eststo F1po
quietly margins candemmg#ib3.cancom, contrast(effects)
quietly marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.4 0 0.4, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save G3vcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
quietly marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) xscale(off) ylabel(1.5(0.5)4, gmax labsize(medsmall)) yline(1.5, lpattern(solid))
graph save G3vmm, replace
graph combine G3vmm.gph G3vcamce.gph, title("Pooled") cols(1) xcommon fxsize(33)
graph save G3vpo, replace

graph combine G3vpo.gph G3vcz.gph G3vmx.gph G3vsk.gph G3vuk.gph G3vus.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0)) title("In-partisans")
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\G3vcompRR.pdf", replace

esttab F1po F1cz F1mx F1sk F1uk F1us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.F1.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.F1: Supporting table for Figure F1 showing the results when only observations where the respondent is an in-partisan to the candidate are included.") varlabels(1.candemmg "Undemocratic behavior" 1.candemmg#2.cancom "Undemocratic x Incompetent" 1.candemmg#1.cancom "Undemocratic x Very incompetent" 1.candemmg#4.cancom "Undemocratic x Competent" 1.candemmg#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 1.candemmg#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "CZ" "MX" "SK" "UK" "US") replace b(%7.2f) se(%7.2f)


***Appendix G: Believability of Competence Reputations Across Parties
**Criteria-test plots (Figure G1)
*CZ
mean support if country == "CZ", over(caneco canparty) cluster(resp)
eststo ecopartycz
mean support if country == "CZ", over(cancor canparty) cluster(resp)
eststo corpartycz
coefplot (ecopartycz, label(Economic competence)) (corpartycz, label(Corruption competence)), ylabel(,labsize(small)) plotregion(margin(zero)) title("CZ", size(small)) legend(pos(1) ring(0) size(vsmall) cols(1)) nolabels coeflabels(c.support@1.caneco#1.canparty = "ANO: Low" c.support@1.caneco#2.canparty = "ODS: Low"  c.support@1.caneco#3.canparty = "ČSSD: Low" c.support@2.caneco#1.canparty = "ANO: Avg." c.support@2.caneco#2.canparty = "ODS: Avg."  c.support@2.caneco#3.canparty = "ČSSD: Avg." c.support@3.caneco#1.canparty = "ANO: High" c.support@3.caneco#2.canparty = "ODS: High"  c.support@3.caneco#3.canparty = "ČSSD: High" c.support@1.cancor#1.canparty = "ANO: Low" c.support@1.cancor#2.canparty = "ODS: Low"  c.support@1.cancor#3.canparty = "ČSSD: Low" c.support@2.cancor#1.canparty = "ANO: Avg." c.support@2.cancor#2.canparty = "ODS: Avg."  c.support@2.cancor#3.canparty = "ČSSD: Avg." c.support@3.cancor#1.canparty = "ANO: High" c.support@3.cancor#2.canparty = "ODS: High"  c.support@3.cancor#3.canparty = "ČSSD: High")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\czcompparty", replace

*MX
mean support if country == "MX", over(caneco canparty) cluster(resp)
eststo ecopartymx
mean support if country == "MX", over(cancor canparty) cluster(resp)
eststo corpartymx
coefplot (ecopartymx, label(Economic competence)) (corpartymx, label(Corruption competence)), ylabel(,labsize(small)) plotregion(margin(zero)) title("MX", size(small)) legend(off) nolabels coeflabels(c.support@1.caneco#1.canparty = "MOR: Low" c.support@1.caneco#2.canparty = "PAN: Low"  c.support@1.caneco#3.canparty = "PRD: Low" c.support@2.caneco#1.canparty = "MOR: Avg." c.support@2.caneco#2.canparty = "PAN: Avg."  c.support@2.caneco#3.canparty = "PRD: Avg." c.support@3.caneco#1.canparty = "MOR: High" c.support@3.caneco#2.canparty = "PAN: High"  c.support@3.caneco#3.canparty = "PRD: High" c.support@1.cancor#1.canparty = "MOR: Low" c.support@1.cancor#2.canparty = "PAN: Low"  c.support@1.cancor#3.canparty = "PRD: Low" c.support@2.cancor#1.canparty = "MOR: Avg." c.support@2.cancor#2.canparty = "PAN: Avg."  c.support@2.cancor#3.canparty = "PRD: Avg." c.support@3.cancor#1.canparty = "MOR: High" c.support@3.cancor#2.canparty = "PAN: High"  c.support@3.cancor#3.canparty = "PRD: High" c.support@1.caneco#4.canparty = "PRI: Low" c.support@2.caneco#4.canparty = "PRI: Avg." c.support@3.caneco#4.canparty = "PRI: High" c.support@1.cancor#4.canparty = "PRI: Low" c.support@2.cancor#4.canparty = "PRI: Avg." c.support@3.cancor#4.canparty = "PRI: High")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\mxcompparty", replace

*SK
mean support if country == "SK", over(caneco canparty) cluster(resp)
eststo ecopartysk
mean support if country == "SK", over(cancor canparty) cluster(resp)
eststo corpartysk
coefplot (ecopartysk, label(Economic competence)) (corpartysk, label(Corruption competence)), ylabel(,labsize(small)) plotregion(margin(zero)) title("SK", size(small)) legend(off) nolabels coeflabels(c.support@1.caneco#1.canparty = "DPK: Low" c.support@1.caneco#2.canparty = "UFP: Low"  c.support@2.caneco#1.canparty = "DPK: Avg." c.support@2.caneco#2.canparty = "UFP: Avg."  c.support@3.caneco#1.canparty = "DPK: High" c.support@3.caneco#2.canparty = "UFP: High" c.support@1.cancor#1.canparty = "DPK: Low" c.support@1.cancor#2.canparty = "UFP: Low"  c.support@2.cancor#1.canparty = "DPK: Avg." c.support@2.cancor#2.canparty = "UFP: Avg."  c.support@3.cancor#1.canparty = "DPK: High" c.support@3.cancor#2.canparty = "UFP: High")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\skcompparty", replace

*UK
mean support if country == "UK", over(caneco canparty) cluster(resp)
eststo ecopartyuk
mean support if country == "UK", over(cancor canparty) cluster(resp)
eststo corpartyuk
coefplot (ecopartyuk, label(Economic competence)) (corpartyuk, label(Corruption competence)), ylabel(,labsize(small)) plotregion(margin(zero)) title("UK", size(small)) legend(off) nolabels coeflabels(c.support@1.caneco#1.canparty = "CON: Low" c.support@1.caneco#2.canparty = "LAB: Low"  c.support@2.caneco#1.canparty = "CON: Avg." c.support@2.caneco#2.canparty = "LAB: Avg."  c.support@3.caneco#1.canparty = "CON: High" c.support@3.caneco#2.canparty = "LAB: High" c.support@1.cancor#1.canparty = "CON: Low" c.support@1.cancor#2.canparty = "LAB: Low"  c.support@2.cancor#1.canparty = "CON: Avg." c.support@2.cancor#2.canparty = "LAB: Avg."  c.support@3.cancor#1.canparty = "CON: High" c.support@3.cancor#2.canparty = "LAB: High")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\ukcompparty", replace

*US
mean support if country == "US", over(caneco canparty) cluster(resp)
eststo ecopartyus
mean support if country == "US", over(cancor canparty) cluster(resp)
eststo corpartyus
coefplot (ecopartyus, label(Economic competence)) (corpartyus, label(Corruption competence)), ylabel(,labsize(small)) plotregion(margin(zero)) title("US", size(small)) legend(off) nolabels coeflabels(c.support@1.caneco#1.canparty = "DEM: Low" c.support@1.caneco#2.canparty = "REP: Low"  c.support@2.caneco#1.canparty = "DEM: Avg." c.support@2.caneco#2.canparty = "REP: Avg."  c.support@3.caneco#1.canparty = "DEM: High" c.support@3.caneco#2.canparty = "REP: High" c.support@1.cancor#1.canparty = "DEM: Low" c.support@1.cancor#2.canparty = "REP: Low"  c.support@2.cancor#1.canparty = "DEM: Avg." c.support@2.cancor#2.canparty = "REP: Avg."  c.support@3.cancor#1.canparty = "DEM: High" c.support@3.cancor#2.canparty = "REP: High")
graph save "U:\How to Save a Democracy\Competence\Revisions\Results\uscompparty", replace

*Combine
graph combine "U:\How to Save a Democracy\Competence\Revisions\Results\czcompparty.gph" "U:\How to Save a Democracy\Competence\Revisions\Results\mxcompparty.gph" "U:\How to Save a Democracy\Competence\Revisions\Results\skcompparty.gph" "U:\How to Save a Democracy\Competence\Revisions\Results\ukcompparty.gph" "U:\How to Save a Democracy\Competence\Revisions\Results\uscompparty.gph", cols(2) xcommon imargin(zero)
graph display, ysize(9.1) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\Hcompparty.pdf", replace

*Supporting tables
reg support i.caneco##i.canparty i.cancor##i.canparty if country == "CZ", cluster(resp)
eststo G1cz
reg support i.caneco##i.canparty i.cancor##i.canparty if country == "MX", cluster(resp)
eststo G1mx
reg support i.caneco##i.canparty i.cancor##i.canparty if country == "SK", cluster(resp)
eststo G1sk
reg support i.caneco##i.canparty i.cancor##i.canparty if country == "UK", cluster(resp)
eststo G1uk
reg support i.caneco##i.canparty i.cancor##i.canparty if country == "US", cluster(resp)
eststo G1us

esttab G1cz using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.G1cz.tex", obslast gaps ar2 nonumbers nonotes wide se drop(1.caneco#* 1.cancor#* *#1.canparty) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.G1A: Supporting table for the cell in Figure G1 showing marginal means for competence reputations — in handling economic matters and in fighting corruption — across parties in the Czech Republic.") varlabels(1.caneco "Low economic competence (Reference category)" 2.caneco "Average economic competence" 3.caneco "High economic competence" 1.cancor "Low corruption competence (Reference category)" 2.cancor "Average corruption competence" 3.cancor "High corruption competence" 1.canparty "ANO 2011 (Reference category)" 2.canparty "ODS" 3.canparty "ČSSD" 2.caneco#2.canparty "Average economic competence x ODS" 2.caneco#3.canparty "Average economic competence x ČSSD" 3.caneco#2.canparty "High economic competence x ODS" 3.caneco#3.canparty "High economic competence x ČSSD"  2.cancor#2.canparty "Average corruption competence x ODS" 2.cancor#3.canparty "Average corruption competence x ČSSD" 3.cancor#2.canparty "High corruption competence x ODS" 3.cancor#3.canparty "High corruption competence x ČSSD"  _cons Constant) mti("CZ") replace b(%7.2f) se(%7.2f)

esttab G1mx using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.G1mx.tex", obslast gaps ar2 nonumbers nonotes wide se drop(1.caneco#* 1.cancor#* *#1.canparty) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.G1B: Supporting table for the cell in Figure G1 showing marginal means for competence reputations — in handling economic matters and in fighting corruption — across parties in Mexico.") varlabels(1.caneco "Low economic competence (Reference category)" 2.caneco "Average economic competence" 3.caneco "High economic competence" 1.cancor "Low corruption competence (Reference category)" 2.cancor "Average corruption competence" 3.cancor "High corruption competence" 1.canparty "MORENA (Reference category)" 2.canparty "PAN" 3.canparty "PRD" 4.canparty "PRI" 2.caneco#2.canparty "Average economic competence x PAN" 2.caneco#3.canparty "Average economic competence x PRD" 2.caneco#4.canparty "Average economic competence x PRI" 3.caneco#2.canparty "High economic competence x PAN" 3.caneco#3.canparty "High economic competence x PRD" 3.caneco#4.canparty "High economic competence x PRI"  2.cancor#2.canparty "Average corruption competence x PAN" 2.cancor#3.canparty "Average corruption competence x PRD" 2.cancor#4.canparty "Average corruption competence x PRI" 3.cancor#2.canparty "High corruption competence x PAN" 3.cancor#3.canparty "High corruption competence x PRD" 3.cancor#4.canparty "High corruption competence x PRI"  _cons Constant) mti("MX") replace b(%7.2f) se(%7.2f)

esttab G1sk using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.G1sk.tex", obslast gaps ar2 nonumbers nonotes wide se drop(1.caneco#* 1.cancor#* *#1.canparty) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.G1C: Supporting table for the cell in Figure G1 showing marginal means for competence reputations — in handling economic matters and in fighting corruption — across parties in South Korea.") varlabels(1.caneco "Low economic competence (Reference category)" 2.caneco "Average economic competence" 3.caneco "High economic competence" 1.cancor "Low corruption competence (Reference category)" 2.cancor "Average corruption competence" 3.cancor "High corruption competence" 1.canparty "Democratic Party (Reference category)" 2.canparty "United Future Party" 2.caneco#2.canparty "Average economic competence x United Future Party" 3.caneco#2.canparty "High economic competence x United Future Party"  2.cancor#2.canparty "Average corruption competence x United Future Party" 3.cancor#2.canparty "High corruption competence x United Future Party"  _cons Constant) mti("SK") replace b(%7.2f) se(%7.2f)

esttab G1uk using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.G1uk.tex", obslast gaps ar2 nonumbers nonotes wide se drop(1.caneco#* 1.cancor#* *#1.canparty) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.G1D: Supporting table for the cell in Figure G1 showing marginal means for competence reputations — in handling economic matters and in fighting corruption — across parties in the United Kingdom.") varlabels(1.caneco "Low economic competence (Reference category)" 2.caneco "Average economic competence" 3.caneco "High economic competence" 1.cancor "Low corruption competence (Reference category)" 2.cancor "Average corruption competence" 3.cancor "High corruption competence" 1.canparty "Conservatives (Reference category)" 2.canparty "Labour" 2.caneco#2.canparty "Average economic competence x Labour" 3.caneco#2.canparty "High economic competence x Labour"  2.cancor#2.canparty "Average corruption competence x Labour" 3.cancor#2.canparty "High corruption competence x Labour"  _cons Constant) mti("UK") replace b(%7.2f) se(%7.2f)

esttab G1us using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.G1us.tex", obslast gaps ar2 nonumbers nonotes wide se drop(1.caneco#* 1.cancor#* *#1.canparty) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.G1E: Supporting table for the cell in Figure G1 showing marginal means for competence reputations — in handling economic matters and in fighting corruption — across parties in the United States.") varlabels(1.caneco "Low economic competence (Reference category)" 2.caneco "Average economic competence" 3.caneco "High economic competence" 1.cancor "Low corruption competence (Reference category)" 2.cancor "Average corruption competence" 3.cancor "High corruption competence" 1.canparty "Democrat (Reference category)" 2.canparty "Republican" 2.caneco#2.canparty "Average economic competence x Republican" 3.caneco#2.canparty "High economic competence x Republican"  2.cancor#2.canparty "Average corruption competence x Republican" 3.cancor#2.canparty "High corruption competence x Republican"  _cons Constant) mti("US") replace b(%7.2f) se(%7.2f)



**Sensitivity analysis excluding UFP, PRI, and PRD (Figure G2)
gen hsample = .
replace hsample = 1
replace hsample = 0 if country == "MX" & canparty > 2
replace hsample = 0 if country == "SK" & canparty == 2

reg support i.candemmg##ib3.cancom if country == "MX" & hsample == 1, cluster(resp)
eststo G2mx
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save HMX1vmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save HMX1vmxmm, replace
graph combine HMX1vmxmm.gph HMX1vmxcamce.gph, commonscheme title("Mexico without PRI and PRD", size(small)) xcommon cols(1) 
graph save HMX1vmx, replace

reg support i.candemmg##ib3.cancom if country == "SK" & hsample == 1, cluster(resp)
eststo G2sk
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save HSK1vmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save HSK1vmxmm, replace
graph combine HSK1vmxmm.gph HSK1vmxcamce.gph, commonscheme title("South Korea without UFP", size(small)) xcommon cols(1) 
graph save HSK1vmx, replace

reg support i.candemmg##ib3.cancom if hsample == 1, cluster(resp)
eststo G2po1
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(10) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save HPO1vcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save HPO1vmm, replace
graph combine HPO1vmm.gph HPO1vcamce.gph, title("Pooled without PRI, PRD, and UFP", size(small)) cols(1) xcommon fxsize(33)
graph save HPO1vpo, replace

reg support i.candemmg##ib3.cancom, cluster(resp)
eststo G2po2
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) title("") legend(off) plotopts(msymbol(O))
graph save HPO2vcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save HPO2vmm, replace
graph combine HPO2vmm.gph HPO2vcamce.gph, title("Pooled full sample", size(small)) cols(1) xcommon fxsize(33)
graph save HPO2vpo, replace

reg support i.candemmg##ib3.cancom if country == "MX", cluster(resp)
eststo G2mx2
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save HMX2vmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save HMX2vmxmm, replace
graph combine HMX2vmxmm.gph HMX2vmxcamce.gph, commonscheme title("Mexico full sample", size(small)) xcommon cols(1) 
graph save HMX2vmx, replace

reg support i.candemmg##ib3.cancom if country == "SK", cluster(resp)
eststo G2sk2
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save HSK2vmxcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save HSK2vmxmm, replace
graph combine HSK2vmxmm.gph HSK2vmxcamce.gph, commonscheme title("South Korea full sample", size(small)) xcommon cols(1) 
graph save HSK2vmx, replace

graph combine HPO1vpo.gph HMX1vmx.gph HSK1vmx.gph HPO2vpo.gph HMX2vmx.gph HSK2vmx.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\H2vcompRR.pdf", replace

esttab G2po1 G2mx G2sk using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.G2.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.G2: Supporting table for Figure G2 showing the results when PRI, PRD, and UFP are excluded. The original estimates for Mexico, South Korea, and the pooled sample, which are also part of Figure G2, are included in Table A2.") varlabels(1.candemmg "Undemocratic behavior" 1.candemmg#2.cancom "Undemocratic x Incompetent" 1.candemmg#1.cancom "Undemocratic x Very incompetent" 1.candemmg#4.cancom "Undemocratic x Competent" 1.candemmg#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 1.candemmg#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Pooled" "MX" "SK") replace b(%7.2f) se(%7.2f)

***Appendix H: Description of Lucid Samples
**Summary statistics producing Table H1 (manually written)
bys country: tab genderr
bys country: sum ageres if ageres > 18 & ageres < 120
bys country: tab urbanr
bys country: tab edurr

*Testing whether possible lack of representativeness matters
reg support i.candemmg##ib3.cancom if edurr == 1, cluster(resp)
eststo H1low
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) title("") plotopts(msymbol(O)) legend(on order(2 "Effects compared to #3") ring (0) position(12) size(small) margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) rowgap(zero))
graph save I1vcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(ring (0) position(10) order(3 "Democratic (MMs)" 4 "Undemocratic (MMs)") margin(zero) symxsize(vsmall) symysize(vsmall) keygap(third_tiny) size(small)) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save I1vmm, replace
graph combine I1vmm.gph I1vcamce.gph, title("Pooled: Low education") cols(1) xcommon fxsize(33)
graph save I1vpo, replace

reg support i.candemmg##ib3.cancom if edurr == 2, cluster(resp)
eststo H1mid
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save I2vpocamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save I2vpomm, replace
graph combine I2vpomm.gph I2vpocamce.gph, commonscheme title("Pooled: Medium education") xcommon cols(1)
graph save I2vpo, replace

reg support i.candemmg##ib3.cancom if edurr == 3, cluster(resp)
eststo H1high
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save I3vpocamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save I3vpomm, replace
graph combine I3vpomm.gph I3vpocamce.gph, commonscheme title("Pooled: High education") xcommon cols(1)
graph save I3vpo, replace

reg support i.candemmg##ib3.cancom if urbanr == 1, cluster(resp)
eststo H1urban
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") graphregion(margin(0.65 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) fysize(15) title("") legend(off) plotopts(msymbol(O))
graph save I4vcamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid))
graph save I4vmm, replace
graph combine I4vmm.gph I4vcamce.gph, title("Pooled: Rural") cols(1) xcommon fxsize(33)
graph save I4vpo, replace

reg support i.candemmg##ib3.cancom if urbanr == 2, cluster(resp)
eststo H1small
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save I5vpocamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save I5vpomm, replace
graph combine I5vpomm.gph I5vpocamce.gph, commonscheme title("Pooled: Small city") xcommon cols(1)
graph save I5vpo, replace

reg support i.candemmg##ib3.cancom if urbanr == 3, cluster(resp)
eststo H1metro
margins candemmg#ib3.cancom, contrast(effects)
marginsplot, xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5", labsize(medsmall)) xtitle("") ytitle("") title("") graphregion(margin(0 0 1 0)) recast(scatter) yline(0) ylabel(-0.2 0 0.2, gmax labsize(medsmall)) yscale(off) fysize(15) plotopts(msymbol(O))
graph save I6vpocamce, replace
quietly margins, over(candemmg) at(cancom=(1(1)5))
marginsplot, title("") ytitle("") xtitle("") graphregion(margin(0 0 2 0)) legend(off) xscale(off) ylabel(2(0.5)3.5, gmax labsize(medsmall)) yline(2, lpattern(solid)) yscale(off)
graph save I6vpomm, replace
graph combine I6vpomm.gph I6vpocamce.gph, commonscheme title("Pooled: Metropolitan") xcommon cols(1)
graph save I6vpo, replace

graph combine I1vpo.gph I2vpo.gph I3vpo.gph I4vpo.gph I5vpo.gph I6vpo.gph, cols(3) ycommon b1title("1 Very incompetent, 2 Incompetent, 3 Average competence, 4 Competent, 5 Very competent", size(vsmall)) graphregion(margin(0 0 0 0))
graph display, ysize(8.3) xsize(7)
graph export "U:\How to Save a Democracy\Competence\Revisions\Results\IvcompRR.pdf", replace

esttab H1low H1mid H1high H1urban H1small H1metro using "U:\How to Save a Democracy\Competence\Revisions\Results\TableI.H1.tex", obslast gaps ar2 nonumbers nonotes se drop(0.candemmg*) addnotes("Unstandardized regression coefficients." "Respondent clustered standard errors in parentheses." "\sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\).") title("Table I.H1: Supporting table for Figure H1 showing the pooled results across educational (low, medium, and high) and residence (urban, small city, and metropolitan) categories.") varlabels(1.candemmg "Undemocratic behavior" 1.candemmg#2.cancom "Undemocratic x Incompetent" 1.candemmg#1.cancom "Undemocratic x Very incompetent" 1.candemmg#4.cancom "Undemocratic x Competent" 1.candemmg#5.cancom "Undemocratic x Very competent" 1.cancom "Very incompetent" 1.candemmg#3.cancom "Undemocratic x Average competence" 2.cancom "Incompetent" 4.cancom "Competent" 5.cancom "Very competent" 3.cancom "Average competence (Reference category)" _cons Constant) mti("Low" "Medium" "High" "Urban" "Small city" "Metro.") replace b(%7.2f) se(%7.2f)


**Balance test
recode partymmain (1 2 = 0 "Out") (3 = 1 "Neutrals") (4 5 = 2 "In"), gen(inoutneu)
bys candemmg: tab genderr if country == "CZ"
bys candemmg: sum ageres if ageres > 18 & ageres < 120 & country == "CZ"
bys candemmg: tab urbanr if country == "CZ"
bys candemmg: tab edurr if country == "CZ"
bys candemmg: tab genderr if country == "MX"
bys candemmg: sum ageres if ageres > 18 & ageres < 120 & country == "MX"
bys candemmg: tab urbanr if country == "MX"
bys candemmg: tab edurr if country == "MX"
bys candemmg: tab genderr if country == "SK"
bys candemmg: sum ageres if ageres > 18 & ageres < 120 & country == "SK"
bys candemmg: tab urbanr if country == "SK"
bys candemmg: tab edurr if country == "SK"
bys candemmg: tab genderr if country == "UK"
bys candemmg: sum ageres if ageres > 18 & ageres < 120 & country == "UK"
bys candemmg: tab urbanr if country == "UK"
bys candemmg: tab edurr if country == "UK"
bys candemmg: tab genderr if country == "US"
bys candemmg: sum ageres if ageres > 18 & ageres < 120 & country == "US"
bys candemmg: tab urbanr if country == "US"
bys candemmg: tab edurr if country == "US"

tab genderr if country == "CZ" & cancom == 1
tab genderr if country == "CZ" & cancom == 5
sum ageres if ageres > 18 & ageres < 120 & country == "CZ" & cancom == 1
sum ageres if ageres > 18 & ageres < 120 & country == "CZ" & cancom == 5
tab urbanr if country == "CZ" & cancom == 1
tab urbanr if country == "CZ" & cancom == 5
tab edurr if country == "CZ" & cancom == 1
tab edurr if country == "CZ" & cancom == 5
tab genderr if country == "MX" & cancom == 1
tab genderr if country == "MX" & cancom == 5
sum ageres if ageres > 18 & ageres < 120 & country == "MX" & cancom == 1
sum ageres if ageres > 18 & ageres < 120 & country == "MX" & cancom == 5
tab urbanr if country == "MX" & cancom == 1
tab urbanr if country == "MX" & cancom == 5
tab edurr if country == "MX" & cancom == 1
tab edurr if country == "MX" & cancom == 5
tab genderr if country == "SK" & cancom == 1
tab genderr if country == "SK" & cancom == 5
sum ageres if ageres > 18 & ageres < 120 & country == "SK" & cancom == 1
sum ageres if ageres > 18 & ageres < 120 & country == "SK" & cancom == 5
tab urbanr if country == "SK" & cancom == 1
tab urbanr if country == "SK" & cancom == 5
tab edurr if country == "SK" & cancom == 1
tab edurr if country == "SK" & cancom == 5
tab genderr if country == "UK" & cancom == 1
tab genderr if country == "UK" & cancom == 5
sum ageres if ageres > 18 & ageres < 120 & country == "UK" & cancom == 1
sum ageres if ageres > 18 & ageres < 120 & country == "UK" & cancom == 5
tab urbanr if country == "UK" & cancom == 1
tab urbanr if country == "UK" & cancom == 5
tab edurr if country == "UK" & cancom == 1
tab edurr if country == "UK" & cancom == 5
tab genderr if country == "US" & cancom == 1
tab genderr if country == "US" & cancom == 5
sum ageres if ageres > 18 & ageres < 120 & country == "US" & cancom == 1
sum ageres if ageres > 18 & ageres < 120 & country == "US" & cancom == 5
tab urbanr if country == "US" & cancom == 1
tab urbanr if country == "US" & cancom == 5
tab edurr if country == "US" & cancom == 1
tab edurr if country == "US" & cancom == 5

*Statistical tests
recode genderr (1 = 1) (2 3 4 = 0), gen(dfemale)
recode urbanr (1 = 1) (2 3 = 0), gen(drural)
recode urbanr (2 = 1) (1 3 = 0), gen(dscity)
recode urbanr (3 = 1) (1 2 = 0), gen(dmetro)
recode edurr (1 = 1) (2 3 = 0), gen(dlow)
recode edurr (2 = 1) (1 3 = 0), gen(dmed)
recode edurr (3 = 1) (1 2 = 0), gen(dhigh)

reg candemmg dfemale if country == "CZ", cluster(resp) //p = 0.032
reg candemmg ageres if country == "CZ" & ageres > 18 & ageres < 120, cluster(resp)
reg candemmg drural if country == "CZ", cluster(resp)
reg candemmg dscity if country == "CZ", cluster(resp)
reg candemmg dmetro if country == "CZ", cluster(resp)
reg candemmg dlow if country == "CZ", cluster(resp)
reg candemmg dmed if country == "CZ", cluster(resp)
reg candemmg dhigh if country == "CZ", cluster(resp)
reg cancom dfemale if country == "CZ" & cancom == 1 | country == "CZ" & cancom == 5, cluster(resp) //p < 0.001
reg cancom ageres if country == "CZ" & cancom == 1 & ageres > 18 & ageres < 120 | country == "CZ" & cancom == 5 & ageres > 18 & ageres < 120, cluster(resp)
reg cancom drural if country == "CZ" & cancom == 1 | country == "CZ" & cancom == 5, cluster(resp) 
reg cancom dscity if country == "CZ" & cancom == 1 | country == "CZ" & cancom == 5, cluster(resp) 
reg cancom dmetro if country == "CZ" & cancom == 1 | country == "CZ" & cancom == 5, cluster(resp)
reg cancom dlow if country == "CZ" & cancom == 1 | country == "CZ" & cancom == 5, cluster(resp) 
reg cancom dmed if country == "CZ" & cancom == 1 | country == "CZ" & cancom == 5, cluster(resp) 
reg cancom dhigh if country == "CZ" & cancom == 1 | country == "CZ" & cancom == 5, cluster(resp)

reg candemmg dfemale if country == "MX", cluster(resp)
reg candemmg ageres if country == "MX" & ageres > 18 & ageres < 120, cluster(resp)
reg candemmg drural if country == "MX", cluster(resp) 
reg candemmg dscity if country == "MX", cluster(resp) 
reg candemmg dmetro if country == "MX", cluster(resp) 
reg candemmg dlow if country == "MX", cluster(resp)
reg candemmg dmed if country == "MX", cluster(resp)
reg candemmg dhigh if country == "MX", cluster(resp)
reg cancom dfemale if country == "MX" & cancom == 1 | country == "MX" & cancom == 5, cluster(resp) 
reg cancom ageres if country == "MX" & cancom == 1 & ageres > 18 & ageres < 120 | country == "MX" & cancom == 5 & ageres > 18 & ageres < 120, cluster(resp)
reg cancom drural if country == "MX" & cancom == 1 | country == "MX" & cancom == 5, cluster(resp) 
reg cancom dscity if country == "MX" & cancom == 1 | country == "MX" & cancom == 5, cluster(resp)
reg cancom dmetro if country == "MX" & cancom == 1 | country == "MX" & cancom == 5, cluster(resp) 
reg cancom dlow if country == "MX" & cancom == 1 | country == "MX" & cancom == 5, cluster(resp) 
reg cancom dmed if country == "MX" & cancom == 1 | country == "MX" & cancom == 5, cluster(resp) 
reg cancom dhigh if country == "MX" & cancom == 1 | country == "MX" & cancom == 5, cluster(resp)

reg candemmg dfemale if country == "SK", cluster(resp)
reg candemmg ageres if country == "SK" & ageres > 18 & ageres < 120, cluster(resp)
reg candemmg drural if country == "SK", cluster(resp) 
reg candemmg dscity if country == "SK", cluster(resp) 
reg candemmg dmetro if country == "SK", cluster(resp) 
reg candemmg dlow if country == "SK", cluster(resp)
reg candemmg dmed if country == "SK", cluster(resp)
reg candemmg dhigh if country == "SK", cluster(resp)
reg cancom dfemale if country == "SK" & cancom == 1 | country == "SK" & cancom == 5, cluster(resp) 
reg cancom ageres if country == "SK" & cancom == 1 & ageres > 18 & ageres < 120 | country == "SK" & cancom == 5 & ageres > 18 & ageres < 120, cluster(resp)
reg cancom drural if country == "SK" & cancom == 1 | country == "SK" & cancom == 5, cluster(resp) 
reg cancom dscity if country == "SK" & cancom == 1 | country == "SK" & cancom == 5, cluster(resp)
reg cancom dmetro if country == "SK" & cancom == 1 | country == "SK" & cancom == 5, cluster(resp) 
reg cancom dlow if country == "SK" & cancom == 1 | country == "SK" & cancom == 5, cluster(resp) 
reg cancom dmed if country == "SK" & cancom == 1 | country == "SK" & cancom == 5, cluster(resp) 
reg cancom dhigh if country == "SK" & cancom == 1 | country == "SK" & cancom == 5, cluster(resp)

reg candemmg dfemale if country == "UK", cluster(resp)
reg candemmg ageres if country == "UK" & ageres > 18 & ageres < 120, cluster(resp)
reg candemmg drural if country == "UK", cluster(resp)
reg candemmg dscity if country == "UK", cluster(resp)
reg candemmg dmetro if country == "UK", cluster(resp)
reg candemmg dlow if country == "UK", cluster(resp)
reg candemmg dmed if country == "UK", cluster(resp)
reg candemmg dhigh if country == "UK", cluster(resp) //p = 0.047
reg cancom dfemale if country == "UK" & cancom == 1 | country == "UK" & cancom == 5, cluster(resp) 
reg cancom ageres if country == "UK" & cancom == 1 & ageres > 18 & ageres < 120 | country == "UK" & cancom == 5 & ageres > 18 & ageres < 120, cluster(resp)
reg cancom drural if country == "UK" & cancom == 1 | country == "UK" & cancom == 5, cluster(resp) 
reg cancom dscity if country == "UK" & cancom == 1 | country == "UK" & cancom == 5, cluster(resp)
reg cancom dmetro if country == "UK" & cancom == 1 | country == "UK" & cancom == 5, cluster(resp) 
reg cancom dlow if country == "UK" & cancom == 1 | country == "UK" & cancom == 5, cluster(resp) 
reg cancom dmed if country == "UK" & cancom == 1 | country == "UK" & cancom == 5, cluster(resp) 
reg cancom dhigh if country == "UK" & cancom == 1 | country == "UK" & cancom == 5, cluster(resp)


reg candemmg dfemale if country == "US", cluster(resp)
reg candemmg ageres if country == "US" & ageres > 18 & ageres < 120, cluster(resp)
reg candemmg drural if country == "US", cluster(resp)
reg candemmg dscity if country == "US", cluster(resp)
reg candemmg dmetro if country == "US", cluster(resp)
reg candemmg dlow if country == "US", cluster(resp)
reg candemmg dmed if country == "US", cluster(resp)
reg candemmg dhigh if country == "US", cluster(resp)
reg cancom dfemale if country == "US" & cancom == 1 | country == "US" & cancom == 5, cluster(resp) 
reg cancom ageres if country == "US" & cancom == 1 & ageres > 18 & ageres < 120 | country == "US" & cancom == 5 & ageres > 18 & ageres < 120, cluster(resp)
reg cancom drural if country == "US" & cancom == 1 | country == "US" & cancom == 5, cluster(resp) 
reg cancom dscity if country == "US" & cancom == 1 | country == "US" & cancom == 5, cluster(resp)
reg cancom dmetro if country == "US" & cancom == 1 | country == "US" & cancom == 5, cluster(resp)
reg cancom dlow if country == "US" & cancom == 1 | country == "US" & cancom == 5, cluster(resp) 
reg cancom dmed if country == "US" & cancom == 1 | country == "US" & cancom == 5, cluster(resp) 
reg cancom dhigh if country == "US" & cancom == 1 | country == "US" & cancom == 5, cluster(resp)