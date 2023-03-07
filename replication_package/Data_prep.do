*****UK*****
import delimited "U:\How to Save a Democracy\Data\ukmain.tsv", varnames(1) encoding(UTF-16LE) numericcols(15 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85) clear
encode responseid, gen(id)
generate respondentid = id+1
drop if respondentid == .
keep if q4 == "Medium-size or small city" | q4 == "Metropolis"| q4 == "Rural County"
gen country = "UK"
gen resp = respondentid + 10000
drop startdate enddate status progress finished distributionchannel userlanguage fl* responseid id

**Correct reshaping of data into uniquely identifying candidate level (by respondent id x candidate number (1-20)).
*Renaming necessary
rename q17_1 answ_1
rename q17_2 answ_2
rename q18_1 answ_3
rename q18_2 answ_4
rename q19_1 answ_5
rename q19_2 answ_6
rename q20_1 answ_7
rename q20_2 answ_8
rename q21_1 answ_9
rename q21_2 answ_10
rename q22_1 answ_11
rename q22_2 answ_12
rename q23_1 answ_13
rename q23_2 answ_14
rename q24_1 answ_15
rename q24_2 answ_16
rename q25_1 answ_17
rename q25_2 answ_18
rename q26_1 answ_19
rename q26_2 answ_20

*Reshaping
reshape long answ dem age gender background party redi soc eco cor, i(respondentid) j(candidate, string)

*Renaming
rename q3 region
rename q4 urban 
rename q5 genderres
rename q6 ageres
rename q7 edures 
rename q8_1 abortion
rename q8_2 tax
rename q8_3 samesex
rename q8_4 welfare
rename q8_5 unions
rename q8_6 immi
rename q8_7 demfra
rename q9_1 aboprio
rename q9_2 taxprio
rename q9_3 samesexprio
rename q9_4 welprio
rename q9_5 unionprio
rename q9_6 immiprio
rename q10 pid
rename q11_1 conser
rename q11_2 labour
rename q15 mcheck
rename q27 attention
rename q28 device
rename block6_do treat

***Recoding
**Candidate attributes
clonevar canage = age
encode gender, gen(cangender)
encode background, gen(canbackground)
encode party, gen(canparty)
encode redi, gen(canredi)
recode canredi (1 = 0 "Decrease income tax on 10 percent richest") (4 = 1 "Increase income tax on 10 percent richest") (else=.), gen(cantax)
recode canredi (2 = 0 "Decrease power of trade unions") (5 = 1 "Increase power of trade unions") (else=.), gen(canunion)
recode canredi (3 = 0 "Decrease public welfare spending") (6 = 1 "Increase public welfare spending") (else=.), gen(canwel)
encode soc, gen(cansoc)
recode cansoc (1 = 1 "Allow illegal immigrants to apply for citizenship") (2 = 0 "Increase efforts to arrest and eventually deport illegal immigrants") (else=.), gen(canimmi)
recode cansoc (3 = 1 "Make it easier for people of the same sex to marry each other") (5 = 0 "Make it harder for people of the same sex to marry each other") (else=.), gen(canss)
recode cansoc (4 = 1 "Make it easier for women to get an abortion") (6 = 0 "Make it harder for women to get an abortion") (else=.), gen(canabort)
encode dem, gen(candem)
recode candem (1 5 6 7 = 0 "Democratic") (2 3 4 8 = 1 "Undemocratic"), gen(candemmg) //Making one variable where all undemocratic positions are merged
encode eco, gen(canec)
recode canec (1 = 1 "Bad at handling economic matters") (2 = 3 "Good at handling economic matters") (3 = 2 "Neither good nor bad reputation on economic matters"), gen(caneco)
encode cor, gen(canco)
recode canco (1 = 1 "Bad at fighting corruption") (2 = 3 "Good at fighting corruption") (3 = 2 "Neither good nor bad reputation on fighting corruption"), gen(cancor)
gen cancom = (caneco + cancor)-1
label define competence 1 "Very incompetent" 2 "Moderately incompetent" 3 "Neither competent nor incompetent" 4 "Moderately competent" 5 "Very competent"
label values cancom competence

**Respondent attributes
*Background vars
encode region, gen(regionres)
encode urban, gen(urbanres)
recode urbanres (3 = 1 "Rural County") (2 = 3 "Metropolis") (1 = 2 "Medium-size or small city"), gen(urbanr)
drop urbanres
encode genderres, gen(genderr)
encode edures, gen(edur)
recode edur (1 = 2 "High school") (3 = 1 "Less than high school") (2 = 3 "More than high school"), gen(edurr) //approximation
drop edur

**Preference extremity vars
encode abortion, gen(abortionpre)
encode tax, gen(taxpre)
encode samesex, gen(samesexpre)
encode welfare, gen(welfarepre)
encode unions, gen(unionspre)
encode immi, gen(immipre)
encode demfra, gen(demfrapre)
recode abortionpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(abrpre)
recode taxpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(taxrpre)
recode samesexpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(samerpre)
recode welfarepre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(welrpre)
recode unionspre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(uniorpre)
recode immipre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(immirpre)
recode demfrapre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(demfrpre)
drop abortionpre-demfrapre

*"Extremety on candidate-assigned attributes". Matextax is, for example, the respondent's preference on tax IF the candidate was assigned a tax position. Flips abortion, welfare, unions, and immigration so that low values are extreme left and high values are extreme right.
label define extreme 1 "Extreme left" 2 "Moderate Left" 3 "Center" 4 "Moderate Right" 5 "Extreme Right"
recode abrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeab)
recode welrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremewel)
recode immirpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeimmi)
recode uniorpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeunion)
clonevar extremetax = taxrpre
clonevar extremess = samerpre
gen matextax = extremetax if cantax != .
gen matexwel = extremewel if canwel != .
gen matexunion = extremeunion if canunion != .
gen matexredi = .
replace matexredi = matextax if matextax != .
replace matexredi = matexwel if matexwel != .
replace matexredi = matexunion if matexunion != .
gen mateximmi = extremeimmi if canimmi != .
gen matexabo = extremeab if canabort != .
gen matexss = extremess if canss != .
gen matexsoc = .
replace matexsoc = mateximmi if mateximmi != .
replace matexsoc = matexabo if matexabo != .
replace matexsoc = matexss if matexss != .
label values matexsoc mateximmi matexredi matextax matexunion matexwel matexabo matexss extremetax extremess extremeab extremewel extremeunion extremeimmi extreme

**Policy distance between candidate and respondent
*Main measure
recode cantax (0 = 4.5) (1 = 1.5), gen(cantaxm)
recode canunion (0 = 4.5) (1 = 1.5), gen(canunionm)
recode canwel (0 = 4.5) (1 = 1.5), gen(canwelm)
gen canredim = .
replace canredim = cantaxm if cantaxm != .
replace canredim = canunionm if canunionm != .
replace canredim = canwelm if canwelm != .

recode canimmi (0 = 4.5) (1 = 1.5), gen(canimmim)
recode canss (0 = 4.5) (1 = 1.5), gen(canssm)
recode canabort (0 = 4.5) (1 = 1.5), gen(canabortm)
gen cansocm = .
replace cansocm = canimmim if canimmim != .
replace cansocm = canssm if canssm != .
replace cansocm = canabortm if canabortm != .

gen distaxm = matextax-cantaxm
gen disunionm = matexunion-canunionm
gen diswelm = matexwel-canwelm 
gen disredim = matexredi-canredim

gen disimmim = mateximmi-canimmim
gen disssm = matexss-canssm
gen disabom = matexabo-canabortm
gen dissocm = matexsoc-cansocm

gen dissumm = sqrt(disredim^2) + sqrt(dissocm^2)
label define distancem 1 "Completely Aligned Positions" 7 "Completely Diverting Positions"
label values dissumm distancem

*Supplementary measures
recode cantax (0 = 5) (1 = 1), gen(cantaxs1)
recode canunion (0 = 5) (1 = 1), gen(canunions1)
recode canwel (0 = 5) (1 = 1), gen(canwels1)
gen canredis1 = .
replace canredis1 = cantaxs1 if cantaxs1 != .
replace canredis1 = canunions1 if canunions1 != .
replace canredis1 = canwels1 if canwels1 != .

recode canimmi (0 = 5) (1 = 1), gen(canimmis1)
recode canss (0 = 5) (1 = 1), gen(cansss1)
recode canabort (0 = 5) (1 = 1), gen(canaborts1)
gen cansocs1 = .
replace cansocs1 = canimmis1 if canimmis1 != .
replace cansocs1 = cansss1 if cansss1 != .
replace cansocs1 = canaborts1 if canaborts1 != .

gen distaxs1 = matextax-cantaxs1
gen disunions1 = matexunion-canunions1
gen diswels1 = matexwel-canwels1 
gen disredis1 = matexredi-canredis1

gen disimmis1 = mateximmi-canimmis1
gen dissss1 = matexss-cansss1
gen disabos1 = matexabo-canaborts1
gen dissocs1 = matexsoc-cansocs1

gen dissums1 = sqrt(disredis1^2) + sqrt(dissocs1^2)
label define distances1 0 "Completely Aligned Positions" 8 "Completely Diverting Positions"
label values dissums1 distances1

recode cantax (0 = 4) (1 = 2), gen(cantaxs2)
recode canunion (0 = 4) (1 = 2), gen(canunions2)
recode canwel (0 = 4) (1 = 2), gen(canwels2)
gen canredis2 = .
replace canredis2 = cantaxs2 if cantaxs2 != .
replace canredis2 = canunions2 if canunions2 != .
replace canredis2 = canwels2 if canwels2 != .

recode canimmi (0 = 4) (1 = 2), gen(canimmis2)
recode canss (0 = 4) (1 = 2), gen(cansss2)
recode canabort (0 = 4) (1 = 2), gen(canaborts2)
gen cansocs2 = .
replace cansocs2 = canimmis2 if canimmis2 != .
replace cansocs2 = cansss2 if cansss2 != .
replace cansocs2 = canaborts2 if canaborts2 != .

gen distaxs2 = matextax-cantaxs2
gen disunions2 = matexunion-canunions2
gen diswels2 = matexwel-canwels2
gen disredis2 = matexredi-canredis2

gen disarms2 = mateximmi-canimmis2
gen dissss2 = matexss-cansss2
gen disabos2 = matexabo-canaborts2
gen dissocs2 = matexsoc-cansocs2

gen dissums2 = sqrt(disredis2^2) + sqrt(dissocs2^2)
label define distances2 0 "Completely Aligned Positions" 6 "Completely Diverting Positions"
label values dissums2 distances2

**Preference intensity vars (respondent)
encode aboprio, gen(abortionpri)
encode taxprio, gen(taxpri)
encode samesexprio, gen(samesexpri)
encode welprio, gen(welfarepri)
encode unionprio, gen(unionspri)
encode immiprio, gen(immipri)
recode abortionpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(abrpri)
recode taxpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(taxrpri)
recode samesexpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(samerpri)
recode welfarepri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(welrpri)
recode unionspri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(uniorpri)
recode immipri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(immirpri)
drop abortionpri-immipri


*"Intensity on candidate-assigned attributes". Matintax is, for example, the respondent's intensity on tax IF the candidate was assigned a tax position
label define intensity 1 "Very Low Intensity" 2 "Low Intensity" 3 "Moderate Intensity" 4 "High Intensity" 5 "Very High Intensity"
gen matintax = taxrpri if cantax != .
gen matinwel = welrpri if canwel != .
gen matinunion = uniorpri if canunion != .
gen matinredi = .
replace matinredi = matintax if matintax != .
replace matinredi = matinwel if matinwel != .
replace matinredi = matinunion if matinunion != .
gen matinimmi = immirpri if canimmi != .
gen matinabo = abrpri if canabort != .
gen matinss = samerpri if canss != .
gen matinsoc = .
replace matinsoc = matinimmi if matinimmi != .
replace matinsoc = matinabo if matinabo != .
replace matinsoc = matinss if matinss != .
label values matintax matinwel matinunion matinredi matinimmi matinabo matinss matinsoc intensity

*Intensity in favor of or against candidate: used for analysis
gen abodir = . 
replace abodir = -1 if extremeab < 3 & canabort == 0
replace abodir = -1 if extremeab > 3 & canabort == 1
replace abodir = -0.5 if extremeab == 3 & canabort !=.
replace abodir = 1 if extremeab < 3 & canabort == 1
replace abodir = 1 if extremeab > 3 & canabort == 0
gen aboint = abodir*abrpri

gen taxdir = . 
replace taxdir = -1 if extremetax < 3 & cantax == 0
replace taxdir = -1 if extremetax > 3 & cantax == 1
replace taxdir = -0.5 if extremetax == 3 & cantax !=.
replace taxdir = 1 if extremetax < 3 & cantax == 1
replace taxdir = 1 if extremetax > 3 & cantax == 0
gen taxint = taxdir*taxrpri

gen ssdir = . 
replace ssdir = -1 if extremess < 3 & canss == 0
replace ssdir = -1 if extremess > 3 & canss == 1
replace ssdir = -0.5 if extremess == 3 & canss !=.
replace ssdir = 1 if extremess < 3 & canss == 1
replace ssdir = 1 if extremess > 3 & canss == 0
gen ssint = ssdir*samerpri

gen weldir = . 
replace weldir = -1 if extremewel < 3 & canwel == 0
replace weldir = -1 if extremewel > 3 & canwel == 1
replace weldir = -0.5 if extremewel == 3 & canwel !=.
replace weldir = 1 if extremewel < 3 & canwel == 1
replace weldir = 1 if extremewel > 3 & canwel == 0
gen welint = weldir*welrpri

gen uniondir = . 
replace uniondir = -1 if extremeunion < 3 & canunion == 0
replace uniondir = -1 if extremeunion > 3 & canunion == 1
replace uniondir = -0.5 if extremeunion == 3 & canunion !=.
replace uniondir = 1 if extremeunion < 3 & canunion == 1
replace uniondir = 1 if extremeunion > 3 & canunion == 0
gen unionint = uniondir*uniorpri

gen immidir = . 
replace immidir = -1 if extremeimmi < 3 & canimmi == 0
replace immidir = -1 if extremeimmi > 3 & canimmi == 1
replace immidir = -0.5 if extremeimmi == 3 & canimmi !=.
replace immidir = 1 if extremeimmi < 3 & canimmi == 1
replace immidir = 1 if extremeimmi > 3 & canimmi == 0
gen immiint = immidir*immirpri

gen rediint =.
replace rediint = unionint if unionint != .
replace rediint = welint if welint != .
replace rediint = taxint if taxint != .

gen socint =.
replace socint = immiint if immiint != .
replace socint = ssint if ssint != .
replace socint = aboint if aboint != .

label define intensityfa -5 "Intense Opinion Against Candidate" -1 "Mild Opinion Against Candidate" 1 "Mild Opinion in Favor of Candidate" 5 "Intense Opinion in Favor of Candidate"
label values aboint taxint ssint rediint welint unionint immiint socint intensityfa


**Party ID
encode pid, gen(partyid)
recode partyid (2 =.)
drop pid
encode labour, gen(LABOx)
encode conser, gen(CONSx)
recode CONSx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(CONS)
recode LABOx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(LABO)
drop CONSx LABOx
gen partymmain = .
replace partymmain = LABO if canparty == 2
replace partymmain = CONS if canparty == 1
label define conparty 1 "Dislike candidate's party a great deal" 2 "Dislike candidate's party somewhat" 3 "Neither like nor dislike candidate's party" 4 "Like candidate's party somewhat" 5 "Like candidate's party a great deal"
label values partymmain conparty
recode partyid (4 = 0 "No Party ID") (2=.) (1 3 5 6 7 8 = 1 "Any Party ID"), gen(anyparty)
recode partyid (1 6 = 1 "CONS/LABO") (2=.) (3 4 5 7 8 = 0 "Not CONS/LABO"), gen(anyinparty)
gen copartisansplit = .
replace copartisansplit = 0 if anyinparty == 0
replace copartisansplit = 1 if partyid == 1 & canparty == 1
replace copartisansplit = 2 if partyid == 6 & canparty == 2
replace copartisansplit = 3 if partyid == 1 & canparty == 2
replace copartisansplit = 4 if partyid == 6 & canparty == 1
label define copartisansplit 0 "Neither Copartisanship nor Opposing Partisanship" 1 "Copartisanship: CONS" 2 "Copartisanship: LABO" 3 "Voter: CONS, Candidate: LABO" 4 "Voter: LABO, Candidate: CONS"
label values copartisansplit copartisansplit
recode copartisansplit (0 = 0 "Neither Copartisanship nor Opposing Partisanship") (1 2 = 1 "Copartisanship") (3 4 = 2 "Opposing Partisanship"), gen(copartisanmerge)


**Manipulation and attention check
encode mcheck, gen(mcheck1)
recode mcheck1 (1 = 3 "Democracy is neither robust nor vulnerable in the UK") (2 = 4 "Democracy is quite robust in the UK") (3 = 2 "Democracy is quite vulnerable in the UK") (4 = 5 "Democracy is very robust in the UK") (5 = 1 "Democracy is very vulnerable in the UK") (6=.), gen(manipulation)
drop mcheck1
encode attention, gen(atte)
recode atte (1=5 "Don't know") (2 = 4 "I have not been presented for a piece of text about the current state of democracy around the world") (3 = 2 "That many democratic breakdowns will occur during this decade") (4 = 1 "That no or only very few democratic breakdowns will occur during this decade") (5 = 3 "The piece of text did not mention any predictions"), gen(attent) //NB: Numbers may be wrong; check twice when data is in
drop atte

**Outcome
encode answ, gen(answer)
recode answer (1=.) (2 = 3 "Neither likely nor unlikely") (3 = 4 "Somewhat likely") (4 = 2 "Somewhat unlikely") (5 = 5 "Very likely") (6 = 1 "Very unlikely"), gen(support)
drop answer

**Treatment
encode treat, gen(treat1)
recode treat1 (1 = 0 "Robust") (2=1 "Vulnerable"), gen(treatment)
drop treat1
*Did the treatment work (i.e., did it affect perceived democratic vulnerability)? And does it work best with or without providing a democracy definition just before assigning the treatment?
reg manipulation i.treatment, cluster(respondentid) //clustering added
*Were the respondents attentive?
gen correctatte = .
replace correctatte = 0 if attent == 5
replace correctatte = 0 if attent == 4
replace correctatte = 0 if attent == 3
replace correctatte = 0 if attent == 2 & treatment == 0
replace correctatte = 0 if attent == 1 & treatment == 1
replace correctatte = 1 if attent == 1 & treatment == 0
replace correctatte = 1 if attent == 2 & treatment == 1
label define correct 0 "Inattentive" 1 "Attentive"
label values correctatte correct
sum correctatte

*Creating numerical variables identifying task and candidate number
generate task =.
replace task = 1 if candidate == "_1" | candidate == "_2"
replace task = 2 if candidate == "_3" | candidate == "_4"
replace task = 3 if candidate == "_5" | candidate == "_6"
replace task = 4 if candidate == "_7" | candidate == "_8"
replace task = 5 if candidate == "_9" | candidate == "_10"
replace task = 6 if candidate == "_11" | candidate == "_12"
replace task = 7 if candidate == "_13" | candidate == "_14"
replace task = 8 if candidate == "_15" | candidate == "_16"
replace task = 9 if candidate == "_17" | candidate == "_18"
replace task = 10 if candidate == "_19" | candidate == "_20"
generate candid =.
replace candid = 1 if candidate == "_1"
replace candid = 2 if candidate == "_2"
replace candid = 3 if candidate == "_3"
replace candid = 4 if candidate == "_4"
replace candid = 5 if candidate == "_5"
replace candid = 6 if candidate == "_6"
replace candid = 7 if candidate == "_7"
replace candid = 8 if candidate == "_8"
replace candid = 9 if candidate == "_9"
replace candid = 10 if candidate == "_10"
replace candid = 11 if candidate == "_11"
replace candid = 12 if candidate == "_12"
replace candid = 13 if candidate == "_13"
replace candid = 14 if candidate == "_14"
replace candid = 15 if candidate == "_15"
replace candid = 16 if candidate == "_16"
replace candid = 17 if candidate == "_17"
replace candid = 18 if candidate == "_18"
replace candid = 19 if candidate == "_19"
replace candid = 20 if candidate == "_20"

**Drop respondents with missing values on variables used for key tests
reg partymmain dissumm matexredi matexsoc rediint socint support
gen sample1 = e(sample)

*Saving for appending later
save "U:\How to Save a Democracy\Data\ukfinal.dta", replace


*****US*****
import delimited "U:\How to Save a Democracy\Data\usmain.tsv", varnames(1) encoding(UTF-16LE) numericcols(14 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84) clear
encode responseid, gen(id)
generate respondentid = id+1
drop if respondentid == .
keep if q4 == "Medium-size or small city" | q4 == "Metropolis"| q4 == "Rural County"
gen country = "US"
gen resp = respondentid + 20000
drop startdate enddate status progress finished distributionchannel userlanguage fl* responseid id

**Correct reshaping of data into uniquely identifying candidate level (by respondent id x candidate number (1-20)).
*Renaming necessary
rename q17_1 answ_1
rename q17_2 answ_2
rename q18_1 answ_3
rename q18_2 answ_4
rename q19_1 answ_5
rename q19_2 answ_6
rename q20_1 answ_7
rename q20_2 answ_8
rename q21_1 answ_9
rename q21_2 answ_10
rename q22_1 answ_11
rename q22_2 answ_12
rename q23_1 answ_13
rename q23_2 answ_14
rename q24_1 answ_15
rename q24_2 answ_16
rename q25_1 answ_17
rename q25_2 answ_18
rename q26_1 answ_19
rename q26_2 answ_20

*Reshaping
reshape long answ dem age gender background party redi soc eco cor, i(respondentid) j(candidate, string)

*Renaming
rename q3 region
rename q4 urban 
rename q5 genderres
rename q6 ageres
rename q7 edures 
rename q8_1 abortion
rename q8_2 tax
rename q8_3 samesex
rename q8_4 welfare
rename q8_5 unions
rename q8_6 immi
rename q8_7 demfra
rename q9_1 aboprio
rename q9_2 taxprio
rename q9_3 samesexprio
rename q9_4 welprio
rename q9_5 unionprio
rename q9_6 immiprio
rename q10 pid
rename q11_1 demp
rename q11_2 repp
rename q15 mcheck
rename q27 attention
rename q28 device
rename block6_do treat

***Recoding
**Candidate attributes
clonevar canage = age
encode gender, gen(cangender)
encode background, gen(canbackground)
encode party, gen(canparty)
encode redi, gen(canredi)
recode canredi (1 = 0 "Decrease income tax on 10 percent richest") (4 = 1 "Increase income tax on 10 percent richest") (else=.), gen(cantax)
recode canredi (2 = 0 "Decrease power of labor unions") (5 = 1 "Increase power of labor unions") (else=.), gen(canunion)
recode canredi (3 = 0 "Decrease public welfare spending") (6 = 1 "Increase public welfare spending") (else=.), gen(canwel)
encode soc, gen(cansoc)
recode cansoc (1 = 1 "Allow illegal immigrants to apply for citizenship") (2 = 0 "Increase efforts to arrest and eventually deport illegal immigrants") (else=.), gen(canimmi)
recode cansoc (3 = 1 "Make it easier for people of the same sex to marry each other") (5 = 0 "Make it harder for people of the same sex to marry each other") (else=.), gen(canss)
recode cansoc (4 = 1 "Make it easier for women to get an abortion") (6 = 0 "Make it harder for women to get an abortion") (else=.), gen(canabort)
encode dem, gen(candem)
recode candem (1 5 6 7 = 0 "Democratic") (2 3 4 8 = 1 "Undemocratic"), gen(candemmg) //Making one variable where all undemocratic positions are merged
encode eco, gen(canec)
recode canec (1 = 1 "Bad at handling economic matters") (2 = 3 "Good at handling economic matters") (3 = 2 "Neither good nor bad reputation on economic matters"), gen(caneco)
encode cor, gen(canco)
recode canco (1 = 1 "Bad at fighting corruption") (2 = 3 "Good at fighting corruption") (3 = 2 "Neither good nor bad reputation on fighting corruption"), gen(cancor)
gen cancom = (caneco + cancor)-1
label define competence 1 "Very incompetent" 2 "Moderately incompetent" 3 "Neither competent nor incompetent" 4 "Moderately competent" 5 "Very competent"
label values cancom competence

**Respondent attributes
*Background vars
encode region, gen(regionres)
encode urban, gen(urbanres)
recode urbanres (3 = 1 "Rural County") (2 = 3 "Metropolis") (1 = 2 "Medium-size or small city"), gen(urbanr)
drop urbanres
encode genderres, gen(genderr)
encode edures, gen(edur)
recode edur (1 = 2 "High school") (2 = 1 "Less than high school") (3 = 3 "More than high school"), gen(edurr)
drop edur

**Preference extremity vars
encode abortion, gen(abortionpre)
encode tax, gen(taxpre)
encode samesex, gen(samesexpre)
encode welfare, gen(welfarepre)
encode unions, gen(unionspre)
encode immi, gen(immipre)
encode demfra, gen(demfrapre)
recode abortionpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(abrpre)
recode taxpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(taxrpre)
recode samesexpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(samerpre)
recode welfarepre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(welrpre)
recode unionspre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(uniorpre)
recode immipre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(immirpre)
recode demfrapre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(demfrpre)
drop abortionpre-demfrapre

*"Extremety on candidate-assigned attributes". Matextax is, for example, the respondent's preference on tax IF the candidate was assigned a tax position. Flips abortion, welfare, unions, and immigration so that low values are extreme left and high values are extreme right.
label define extreme 1 "Extreme left" 2 "Moderate Left" 3 "Center" 4 "Moderate Right" 5 "Extreme Right"
recode abrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeab)
recode welrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremewel)
recode immirpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeimmi)
recode uniorpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeunion)
clonevar extremetax = taxrpre
clonevar extremess = samerpre
gen matextax = extremetax if cantax != .
gen matexwel = extremewel if canwel != .
gen matexunion = extremeunion if canunion != .
gen matexredi = .
replace matexredi = matextax if matextax != .
replace matexredi = matexwel if matexwel != .
replace matexredi = matexunion if matexunion != .
gen mateximmi = extremeimmi if canimmi != .
gen matexabo = extremeab if canabort != .
gen matexss = extremess if canss != .
gen matexsoc = .
replace matexsoc = mateximmi if mateximmi != .
replace matexsoc = matexabo if matexabo != .
replace matexsoc = matexss if matexss != .
label values matexsoc mateximmi matexredi matextax matexunion matexwel matexabo matexss extremetax extremess extremeab extremewel extremeunion extremeimmi extreme

**Policy distance between candidate and respondent
*Main measure
recode cantax (0 = 4.5) (1 = 1.5), gen(cantaxm)
recode canunion (0 = 4.5) (1 = 1.5), gen(canunionm)
recode canwel (0 = 4.5) (1 = 1.5), gen(canwelm)
gen canredim = .
replace canredim = cantaxm if cantaxm != .
replace canredim = canunionm if canunionm != .
replace canredim = canwelm if canwelm != .

recode canimmi (0 = 4.5) (1 = 1.5), gen(canimmim)
recode canss (0 = 4.5) (1 = 1.5), gen(canssm)
recode canabort (0 = 4.5) (1 = 1.5), gen(canabortm)
gen cansocm = .
replace cansocm = canimmim if canimmim != .
replace cansocm = canssm if canssm != .
replace cansocm = canabortm if canabortm != .

gen distaxm = matextax-cantaxm
gen disunionm = matexunion-canunionm
gen diswelm = matexwel-canwelm 
gen disredim = matexredi-canredim

gen disimmim = mateximmi-canimmim
gen disssm = matexss-canssm
gen disabom = matexabo-canabortm
gen dissocm = matexsoc-cansocm

gen dissumm = sqrt(disredim^2) + sqrt(dissocm^2)
label define distancem 1 "Completely Aligned Positions" 7 "Completely Diverting Positions"
label values dissumm distancem

*Supplementary measures
recode cantax (0 = 5) (1 = 1), gen(cantaxs1)
recode canunion (0 = 5) (1 = 1), gen(canunions1)
recode canwel (0 = 5) (1 = 1), gen(canwels1)
gen canredis1 = .
replace canredis1 = cantaxs1 if cantaxs1 != .
replace canredis1 = canunions1 if canunions1 != .
replace canredis1 = canwels1 if canwels1 != .

recode canimmi (0 = 5) (1 = 1), gen(canimmis1)
recode canss (0 = 5) (1 = 1), gen(cansss1)
recode canabort (0 = 5) (1 = 1), gen(canaborts1)
gen cansocs1 = .
replace cansocs1 = canimmis1 if canimmis1 != .
replace cansocs1 = cansss1 if cansss1 != .
replace cansocs1 = canaborts1 if canaborts1 != .

gen distaxs1 = matextax-cantaxs1
gen disunions1 = matexunion-canunions1
gen diswels1 = matexwel-canwels1 
gen disredis1 = matexredi-canredis1

gen disimmis1 = mateximmi-canimmis1
gen dissss1 = matexss-cansss1
gen disabos1 = matexabo-canaborts1
gen dissocs1 = matexsoc-cansocs1

gen dissums1 = sqrt(disredis1^2) + sqrt(dissocs1^2)
label define distances1 0 "Completely Aligned Positions" 8 "Completely Diverting Positions"
label values dissums1 distances1

recode cantax (0 = 4) (1 = 2), gen(cantaxs2)
recode canunion (0 = 4) (1 = 2), gen(canunions2)
recode canwel (0 = 4) (1 = 2), gen(canwels2)
gen canredis2 = .
replace canredis2 = cantaxs2 if cantaxs2 != .
replace canredis2 = canunions2 if canunions2 != .
replace canredis2 = canwels2 if canwels2 != .

recode canimmi (0 = 4) (1 = 2), gen(canimmis2)
recode canss (0 = 4) (1 = 2), gen(cansss2)
recode canabort (0 = 4) (1 = 2), gen(canaborts2)
gen cansocs2 = .
replace cansocs2 = canimmis2 if canimmis2 != .
replace cansocs2 = cansss2 if cansss2 != .
replace cansocs2 = canaborts2 if canaborts2 != .

gen distaxs2 = matextax-cantaxs2
gen disunions2 = matexunion-canunions2
gen diswels2 = matexwel-canwels2
gen disredis2 = matexredi-canredis2

gen disarms2 = mateximmi-canimmis2
gen dissss2 = matexss-cansss2
gen disabos2 = matexabo-canaborts2
gen dissocs2 = matexsoc-cansocs2

gen dissums2 = sqrt(disredis2^2) + sqrt(dissocs2^2)
label define distances2 0 "Completely Aligned Positions" 6 "Completely Diverting Positions"
label values dissums2 distances2

**Preference intensity vars (respondent)
encode aboprio, gen(abortionpri)
encode taxprio, gen(taxpri)
encode samesexprio, gen(samesexpri)
encode welprio, gen(welfarepri)
encode unionprio, gen(unionspri)
encode immiprio, gen(immipri)
recode abortionpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(abrpri)
recode taxpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(taxrpri)
recode samesexpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(samerpri)
recode welfarepri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(welrpri)
recode unionspri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(uniorpri)
recode immipri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(immirpri)
drop abortionpri-immipri


*"Intensity on candidate-assigned attributes". Matintax is, for example, the respondent's intensity on tax IF the candidate was assigned a tax position
label define intensity 1 "Very Low Intensity" 2 "Low Intensity" 3 "Moderate Intensity" 4 "High Intensity" 5 "Very High Intensity"
gen matintax = taxrpri if cantax != .
gen matinwel = welrpri if canwel != .
gen matinunion = uniorpri if canunion != .
gen matinredi = .
replace matinredi = matintax if matintax != .
replace matinredi = matinwel if matinwel != .
replace matinredi = matinunion if matinunion != .
gen matinimmi = immirpri if canimmi != .
gen matinabo = abrpri if canabort != .
gen matinss = samerpri if canss != .
gen matinsoc = .
replace matinsoc = matinimmi if matinimmi != .
replace matinsoc = matinabo if matinabo != .
replace matinsoc = matinss if matinss != .
label values matintax matinwel matinunion matinredi matinimmi matinabo matinss matinsoc intensity

*Intensity in favor of or against candidate: used for analysis
gen abodir = . 
replace abodir = -1 if extremeab < 3 & canabort == 0
replace abodir = -1 if extremeab > 3 & canabort == 1
replace abodir = -0.5 if extremeab == 3 & canabort !=.
replace abodir = 1 if extremeab < 3 & canabort == 1
replace abodir = 1 if extremeab > 3 & canabort == 0
gen aboint = abodir*abrpri

gen taxdir = . 
replace taxdir = -1 if extremetax < 3 & cantax == 0
replace taxdir = -1 if extremetax > 3 & cantax == 1
replace taxdir = -0.5 if extremetax == 3 & cantax !=.
replace taxdir = 1 if extremetax < 3 & cantax == 1
replace taxdir = 1 if extremetax > 3 & cantax == 0
gen taxint = taxdir*taxrpri

gen ssdir = . 
replace ssdir = -1 if extremess < 3 & canss == 0
replace ssdir = -1 if extremess > 3 & canss == 1
replace ssdir = -0.5 if extremess == 3 & canss !=.
replace ssdir = 1 if extremess < 3 & canss == 1
replace ssdir = 1 if extremess > 3 & canss == 0
gen ssint = ssdir*samerpri

gen weldir = . 
replace weldir = -1 if extremewel < 3 & canwel == 0
replace weldir = -1 if extremewel > 3 & canwel == 1
replace weldir = -0.5 if extremewel == 3 & canwel !=.
replace weldir = 1 if extremewel < 3 & canwel == 1
replace weldir = 1 if extremewel > 3 & canwel == 0
gen welint = weldir*welrpri

gen uniondir = . 
replace uniondir = -1 if extremeunion < 3 & canunion == 0
replace uniondir = -1 if extremeunion > 3 & canunion == 1
replace uniondir = -0.5 if extremeunion == 3 & canunion !=.
replace uniondir = 1 if extremeunion < 3 & canunion == 1
replace uniondir = 1 if extremeunion > 3 & canunion == 0
gen unionint = uniondir*uniorpri

gen immidir = . 
replace immidir = -1 if extremeimmi < 3 & canimmi == 0
replace immidir = -1 if extremeimmi > 3 & canimmi == 1
replace immidir = -0.5 if extremeimmi == 3 & canimmi !=.
replace immidir = 1 if extremeimmi < 3 & canimmi == 1
replace immidir = 1 if extremeimmi > 3 & canimmi == 0
gen immiint = immidir*immirpri

gen rediint =.
replace rediint = unionint if unionint != .
replace rediint = welint if welint != .
replace rediint = taxint if taxint != .

gen socint =.
replace socint = immiint if immiint != .
replace socint = ssint if ssint != .
replace socint = aboint if aboint != .

label define intensityfa -5 "Intense Opinion Against Candidate" -1 "Mild Opinion Against Candidate" 1 "Mild Opinion in Favor of Candidate" 5 "Intense Opinion in Favor of Candidate"
label values aboint taxint ssint rediint welint unionint immiint socint intensityfa


**Party ID
encode pid, gen(partyid)
recode partyid (2 =.)
drop pid
encode repp, gen(REPx)
encode demp, gen(DEMx)
recode REPx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(REP)
recode DEMx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(DEM)
drop REPx-DEMx
gen partymmain = .
replace partymmain = REP if canparty == 2
replace partymmain = DEM if canparty == 1
label define conparty 1 "Dislike candidate's party a great deal" 2 "Dislike candidate's party somewhat" 3 "Neither like nor dislike candidate's party" 4 "Like candidate's party somewhat" 5 "Like candidate's party a great deal"
label values partymmain conparty
recode partyid (3 = 0 "No Party ID") (2=.) (1 4 5 = 1 "Any Party ID"), gen(anyparty)
recode partyid (1 5 = 1 "DEM/REP") (2=.) (3 4 = 0 "Not DEM/REP"), gen(anyinparty)
gen copartisansplit = .
replace copartisansplit = 0 if anyinparty == 0
replace copartisansplit = 1 if partyid == 1 & canparty == 1
replace copartisansplit = 2 if partyid == 5 & canparty == 2
replace copartisansplit = 3 if partyid == 1 & canparty == 2
replace copartisansplit = 4 if partyid == 5 & canparty == 1
label define copartisansplit 0 "Neither Copartisanship nor Opposing Partisanship" 1 "Copartisanship: DEM" 2 "Copartisanship: REP" 3 "Voter: DEM, Candidate: REP" 4 "Voter: REP, Candidate: DEM"
label values copartisansplit copartisansplit
recode copartisansplit (0 = 0 "Neither Copartisanship nor Opposing Partisanship") (1 2 = 1 "Copartisanship") (3 4 = 2 "Opposing Partisanship"), gen(copartisanmerge)


**Manipulation and attention check
encode mcheck, gen(mcheck1)
recode mcheck1 (1 = 3 "Democracy is neither robust nor vulnerable in the United States") (2 = 4 "Democracy is quite robust in the United States") (3 = 2 "Democracy is quite vulnerable in the United States") (4 = 5 "Democracy is very robust in the United States") (5 = 1 "Democracy is very vulnerable in the United States") (6=.), gen(manipulation)
drop mcheck1
encode attention, gen(atte)
recode atte (1=5 "Don't know") (2 = 4 "I have not been presented for a piece of text about the current state of democracy around the world") (3 = 2 "That many democratic breakdowns will occur during this decade") (4 = 1 "That no or only very few democratic breakdowns will occur during this decade") (5 = 3 "The piece of text did not mention any predictions"), gen(attent) //NB: Numbers may be wrong; check twice when data is in
drop atte

**Outcome
encode answ, gen(answer)
recode answer (1=.) (2 = 3 "Neither likely nor unlikely") (3 = 4 "Somewhat likely") (4 = 2 "Somewhat unlikely") (5 = 5 "Very likely") (6 = 1 "Very unlikely"), gen(support)
drop answer

**Treatment
encode treat, gen(treat1)
recode treat1 (1 = 0 "Robust") (2=1 "Vulnerable"), gen(treatment)
drop treat1
*Did the treatment work (i.e., did it affect perceived democratic vulnerability)? And does it work best with or without providing a democracy definition just before assigning the treatment?
reg manipulation i.treatment, cluster(respondentid) //clustering added
*Were the respondents attentive?
gen correctatte = .
replace correctatte = 0 if attent == 5
replace correctatte = 0 if attent == 4
replace correctatte = 0 if attent == 3
replace correctatte = 0 if attent == 2 & treatment == 0
replace correctatte = 0 if attent == 1 & treatment == 1
replace correctatte = 1 if attent == 1 & treatment == 0
replace correctatte = 1 if attent == 2 & treatment == 1
label define correct 0 "Inattentive" 1 "Attentive"
label values correctatte correct
sum correctatte

*Creating numerical variables identifying task and candidate number
generate task =.
replace task = 1 if candidate == "_1" | candidate == "_2"
replace task = 2 if candidate == "_3" | candidate == "_4"
replace task = 3 if candidate == "_5" | candidate == "_6"
replace task = 4 if candidate == "_7" | candidate == "_8"
replace task = 5 if candidate == "_9" | candidate == "_10"
replace task = 6 if candidate == "_11" | candidate == "_12"
replace task = 7 if candidate == "_13" | candidate == "_14"
replace task = 8 if candidate == "_15" | candidate == "_16"
replace task = 9 if candidate == "_17" | candidate == "_18"
replace task = 10 if candidate == "_19" | candidate == "_20"
generate candid =.
replace candid = 1 if candidate == "_1"
replace candid = 2 if candidate == "_2"
replace candid = 3 if candidate == "_3"
replace candid = 4 if candidate == "_4"
replace candid = 5 if candidate == "_5"
replace candid = 6 if candidate == "_6"
replace candid = 7 if candidate == "_7"
replace candid = 8 if candidate == "_8"
replace candid = 9 if candidate == "_9"
replace candid = 10 if candidate == "_10"
replace candid = 11 if candidate == "_11"
replace candid = 12 if candidate == "_12"
replace candid = 13 if candidate == "_13"
replace candid = 14 if candidate == "_14"
replace candid = 15 if candidate == "_15"
replace candid = 16 if candidate == "_16"
replace candid = 17 if candidate == "_17"
replace candid = 18 if candidate == "_18"
replace candid = 19 if candidate == "_19"
replace candid = 20 if candidate == "_20"

**Drop respondents with missing values on variables used for key tests
reg partymmain dissumm matexredi matexsoc rediint socint support
gen sample1 = e(sample)

*Saving for appending later
save "U:\How to Save a Democracy\Data\usfinal.dta", replace



*****MX*****
import delimited "U:\How to Save a Democracy\Data\mxmain.tsv", varnames(1) encoding(UTF-16LE) numericcols(14 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87) clear
encode responseid, gen(id)
generate respondentid = id+1
drop if respondentid == .
keep if q4 == "Ciudad mediana o pequeña" | q4 == "Zona metropolitana"| q4 == "Zona rural"
gen country = "MX"
gen resp = respondentid + 30000
drop startdate enddate status progress finished distributionchannel userlanguage fl* responseid id


**Correct reshaping of data into uniquely identifying candidate level (by respondent id x candidate number (1-20)).
*Renaming necessary
rename q17_1 answ_1
rename q17_2 answ_2
rename q18_1 answ_3
rename q18_2 answ_4
rename q19_1 answ_5
rename q19_2 answ_6
rename q20_1 answ_7
rename q20_2 answ_8
rename q21_1 answ_9
rename q21_2 answ_10
rename q22_1 answ_11
rename q22_2 answ_12
rename q23_1 answ_13
rename q23_2 answ_14
rename q24_1 answ_15
rename q24_2 answ_16
rename q25_1 answ_17
rename q25_2 answ_18
rename q26_1 answ_19
rename q26_2 answ_20

*Reshaping
reshape long answ dem age gender background party redi soc eco cor, i(respondentid) j(candidate, string)

*Renaming
rename q3 region
rename q4 urban 
rename q5 genderres
rename q6 ageres
rename q7 edures 
rename q8_1 abortion
rename q8_2 tax
rename q8_3 samesex
rename q8_4 welfare
rename q8_5 edu
rename q8_6 crime
rename q8_7 demfra
rename q9_1 aboprio
rename q9_2 taxprio
rename q9_3 samesexprio
rename q9_4 welprio
rename q9_5 eduprio
rename q9_6 crimeprio
rename q10 pid
rename q11_1 pri
rename q11_2 prd
rename q11_3 morena
rename q11_4 pan
rename q11_5 ciu
rename q15 mcheck
rename q27 attention
rename q28 device
rename block1_do treat

*Translating variables to English
replace abortion = "Strongly agree" if abortion == "Totalmente de acuerdo"
replace abortion = "Don't know" if abortion == "No sé"
replace abortion = "Somewhat agree" if abortion == "Ligeramente de acuerdo"
replace abortion = "Neither agree nor disagree" if abortion == "Ni de acuerdo ni en desacuerdo"
replace abortion = "Strongly disagree" if abortion == "Totalmente en desacuerdo"
replace abortion = "Somewhat disagree" if abortion == "Ligeramente en desacuerdo"
replace tax = "Strongly agree" if tax == "Totalmente de acuerdo"
replace tax = "Don't know" if tax == "No sé"
replace tax = "Somewhat agree" if tax == "Ligeramente de acuerdo"
replace tax = "Neither agree nor disagree" if tax == "Ni de acuerdo ni en desacuerdo"
replace tax = "Strongly disagree" if tax == "Totalmente en desacuerdo"
replace tax = "Somewhat disagree" if tax == "Ligeramente en desacuerdo"
replace samesex = "Strongly agree" if samesex == "Totalmente de acuerdo"
replace samesex = "Don't know" if samesex == "No sé"
replace samesex = "Somewhat agree" if samesex == "Ligeramente de acuerdo"
replace samesex = "Neither agree nor disagree" if samesex == "Ni de acuerdo ni en desacuerdo"
replace samesex = "Strongly disagree" if samesex == "Totalmente en desacuerdo"
replace samesex = "Somewhat disagree" if samesex == "Ligeramente en desacuerdo"
replace welfare = "Strongly agree" if welfare == "Totalmente de acuerdo"
replace welfare = "Don't know" if welfare == "No sé"
replace welfare = "Somewhat agree" if welfare == "Ligeramente de acuerdo"
replace welfare = "Neither agree nor disagree" if welfare == "Ni de acuerdo ni en desacuerdo"
replace welfare = "Strongly disagree" if welfare == "Totalmente en desacuerdo"
replace welfare = "Somewhat disagree" if welfare == "Ligeramente en desacuerdo"
replace edu = "Strongly agree" if edu == "Totalmente de acuerdo"
replace edu = "Don't know" if edu == "No sé"
replace edu = "Somewhat agree" if edu == "Ligeramente de acuerdo"
replace edu = "Neither agree nor disagree" if edu == "Ni de acuerdo ni en desacuerdo"
replace edu = "Strongly disagree" if edu == "Totalmente en desacuerdo"
replace edu = "Somewhat disagree" if edu == "Ligeramente en desacuerdo"
replace crime = "Strongly agree" if crime == "Totalmente de acuerdo"
replace crime = "Don't know" if crime == "No sé"
replace crime = "Somewhat agree" if crime == "Ligeramente de acuerdo"
replace crime = "Neither agree nor disagree" if crime == "Ni de acuerdo ni en desacuerdo"
replace crime = "Strongly disagree" if crime == "Totalmente en desacuerdo"
replace crime = "Somewhat disagree" if crime == "Ligeramente en desacuerdo"
replace demfra = "Strongly agree" if demfra == "Totalmente de acuerdo"
replace demfra = "Don't know" if demfra == "No sé"
replace demfra = "Somewhat agree" if demfra == "Ligeramente de acuerdo"
replace demfra = "Neither agree nor disagree" if demfra == "Ni de acuerdo ni en desacuerdo"
replace demfra = "Strongly disagree" if demfra == "Totalmente en desacuerdo"
replace demfra = "Somewhat disagree" if demfra == "Ligeramente en desacuerdo"
replace aboprio = "Not at all important" if aboprio == "Nada importante" 
replace aboprio = "Don't know" if aboprio == "No sé"
replace aboprio = "Extremely important" if aboprio == "Sumamente importante"
replace aboprio = "Very important" if aboprio == "Muy importante"
replace aboprio = "Not very important" if aboprio == "No muy importante"
replace aboprio = "Moderately important" if aboprio == "Moderadamente importante"
replace taxprio = "Not at all important" if taxprio == "Nada importante"
replace taxprio = "Don't know" if taxprio == "No sé"
replace taxprio = "Extremely important" if taxprio == "Sumamente importante"
replace taxprio = "Very important" if taxprio == "Muy importante"
replace taxprio = "Not very important" if taxprio == "No muy importante"
replace taxprio = "Moderately important" if taxprio == "Moderadamente importante"
replace samesexprio = "Not at all important" if samesexprio == "Nada importante"
replace samesexprio = "Don't know" if samesexprio == "No sé"
replace samesexprio = "Extremely important" if samesexprio == "Sumamente importante"
replace samesexprio = "Very important" if samesexprio == "Muy importante"
replace samesexprio = "Not very important" if samesexprio == "No muy importante"
replace samesexprio = "Moderately important" if samesexprio == "Moderadamente importante"
replace welprio = "Not at all important" if welprio == "Nada importante"
replace welprio = "Don't know" if welprio == "No sé"
replace welprio = "Extremely important" if welprio == "Sumamente importante"
replace welprio = "Very important" if welprio == "Muy importante"
replace welprio = "Not very important" if welprio == "No muy importante"
replace welprio = "Moderately important" if welprio == "Moderadamente importante"
replace eduprio = "Not at all important" if eduprio == "Nada importante"
replace eduprio = "Don't know" if eduprio == "No sé"
replace eduprio = "Extremely important" if eduprio == "Sumamente importante"
replace eduprio = "Very important" if eduprio == "Muy importante"
replace eduprio = "Not very important" if eduprio == "No muy importante"
replace eduprio = "Moderately important" if eduprio == "Moderadamente importante"
replace crimeprio = "Not at all important" if crimeprio == "Nada importante"
replace crimeprio = "Don't know" if crimeprio == "No sé"
replace crimeprio = "Extremely important" if crimeprio == "Sumamente importante"
replace crimeprio = "Very important" if crimeprio == "Muy importante"
replace crimeprio = "Not very important" if crimeprio == "No muy importante"
replace crimeprio = "Moderately important" if crimeprio == "Moderadamente importante"
replace pid = "I identify with a party not listed here" if pid == "Me identifico con un partido que no está enumerado aquí en la lista"
replace pid = "MORENA" if pid == "MORENA (Movimiento Regeneración Nacional)"
replace pid = "Don't know" if pid == "No sé"
replace pid = "I do not identify with any party" if pid == "No me identifico con ningún partido"
replace pid = "PAN" if pid == "PAN (Partido Acción Nacional)"
replace pid = "PRD" if pid == "PRD (Partido de la Revolución Democrática)"
replace pid = "PRI" if pid == "PRI (Partido Revolucionario Institucional)"
replace pri = "Dislike a great deal" if pri == "Me desagrada mucho"
replace pri = "Like a great deal" if pri == "Me agrada mucho"
replace pri = "Don't know" if pri == "No sé"
replace pri = "Dislike somewhat" if pri == "Me desagrada un poco"
replace pri = "Like somewhat" if pri == "Me agrada un poco"
replace pri = "Neither like nor dislike" if pri == "Ni me agrada ni me desagrada"
replace prd = "Dislike a great deal" if prd == "Me desagrada mucho"
replace prd = "Like a great deal" if prd == "Me agrada mucho"
replace prd = "Don't know" if prd == "No sé"
replace prd = "Dislike somewhat" if prd == "Me desagrada un poco"
replace prd = "Like somewhat" if prd == "Me agrada un poco"
replace prd = "Neither like nor dislike" if prd == "Ni me agrada ni me desagrada"
replace morena = "Dislike a great deal" if morena == "Me desagrada mucho"
replace morena = "Like a great deal" if morena == "Me agrada mucho"
replace morena = "Don't know" if morena == "No sé"
replace morena = "Dislike somewhat" if morena == "Me desagrada un poco"
replace morena = "Like somewhat" if morena == "Me agrada un poco"
replace morena = "Neither like nor dislike" if morena == "Ni me agrada ni me desagrada"
replace pan = "Dislike a great deal" if pan == "Me desagrada mucho"
replace pan = "Like a great deal" if pan == "Me agrada mucho"
replace pan = "Don't know" if pan == "No sé"
replace pan = "Dislike somewhat" if pan == "Me desagrada un poco"
replace pan = "Like somewhat" if pan == "Me agrada un poco"
replace pan = "Neither like nor dislike" if pan == "Ni me agrada ni me desagrada"
replace ciu = "Dislike a great deal" if ciu == "Me desagrada mucho"
replace ciu = "Like a great deal" if ciu == "Me agrada mucho"
replace ciu = "Don't know" if ciu == "No sé"
replace ciu = "Dislike somewhat" if ciu == "Me desagrada un poco"
replace ciu = "Like somewhat" if ciu == "Me agrada un poco"
replace ciu = "Neither like nor dislike" if ciu == "Ni me agrada ni me desagrada"
replace mcheck = "Democracy is neither robust nor vulnerable in Mexico" if mcheck == "La democracia no es ni robusta ni vulnerable en México"
replace mcheck = "Democracy is quite robust in Mexico" if mcheck == "La democracia es bastante robusta en México"
replace mcheck = "Democracy is quite vulnerable in Mexico" if mcheck == "La democracia es bastante vulnerable en México"
replace mcheck = "Democracy is very robust in Mexico" if mcheck == "La democracia es muy robusta en México"
replace mcheck = "Democracy is very vulnerable in Mexico" if mcheck == "La democracia es muy vulnerable en México"
replace mcheck = "Don't know" if mcheck == "No sé"
replace attention = "The piece of text did not mention any predictions" if attention == "El texto mencionó ninguna predicción"
replace attention = "Don't know" if attention == "No sé"
replace attention = "I have not been presented for a piece of text about the current state of democracy around the world" if attention == "No se me mostró un texto acerca del estado actual de la democracia en todo el mundo"
replace attention = "That many democratic breakdowns will occur during this decade" if attention == "Que muchos colapsos democráticos sucederán durante esta década"
replace attention = "That no or only very few democratic breakdowns will occur during this decade" if attention == "Que ninguno o muy pocos colapsos democráticos sucederán durante esta década"
replace device = "Prefer not to answer" if device == "Prefiero no responder"
replace device = "Other" if device == "Otra opción"
replace device = "Smartphone" if device == "Teléfono inteligente"
replace device = "PC or Macbook" if device == "Computadora personal o MacBook"
replace device = "Tablet" if device == "Tableta"
replace answ = "Very unlikely" if answ == "Muy improbable"
replace answ = "Very likely" if answ == "Muy probable"
replace answ = "Don't know" if answ == "No sé"
replace answ = "Somewhat unlikely" if answ == "Ligeramente improbable"
replace answ = "Somewhat likely" if answ == "Ligeramente probable"
replace answ = "Neither likely nor unlikely" if answ == "Ni probable ni improbable"
replace dem = "Said it is unacceptable to harass journalists even though they do not reveal sources" if dem == "Dijo que es inaceptable acosar a los periodistas, incluso si no revelan sus fuentes"
replace dem = "Said it is legitimate to fight political opponents in the streets if one feels provoked" if dem == "Dijo que es legal luchar contra oponentes políticos en las calles si uno(a) se siente provocado(a)"
replace dem = "Said it is unacceptable to fight political opponents in the streets even though one feels provoked" if dem == "Dijo que es inaceptable luchar contra oponentes políticos en las calles si uno(a) se siente provocado(a)"
replace dem = "Said court rulings by judges appointed by opposing parties should be ignored" if dem == "Dijo que deberían ignorarse las sentencias de los jueces nombrados por los partidos de oposición"
replace dem = "Said court rulings by judges appointed by opposing parties should be adhered to" if dem == "Dijo que deberían cumplirse las sentencias de los jueces nombrados por los partidos de oposición"
replace dem = "Supported a proposal to reduce polling stations in areas that support opposing parties" if dem == "Apoyó una propuesta para reducir los centros electorales en áreas que apoyan a los partidos de oposición"
replace dem = "Supported a proposal to preserve existing polling-stations in all areas" if dem == "Apoyó una propuesta para conservar los centros electorales existentes en todas las áreas"
replace dem = "Said it is acceptable to harass journalists that do not reveal sources" if dem == "Dijo que es aceptable acosar a los periodistas que no revelan sus fuentes"
replace gender = "Male" if gender == "Masculino"
replace gender = "Female" if gender == "Femenino"
replace background = "Civil Servant" if background == "Funcionario(a) público(a)"
replace background = "Academic" if background == "Académico(a)"
replace background = "Accountant" if background == "Contador(a)"
replace background = "Journalist" if background == "Periodista"
replace background = "Lawyer" if background == "Abogado(a)"
replace background = "Engineer" if background == "Ingeniero(a)"
replace background = "Self-employed" if background == "Trabajador(a) independiente"
replace background = "Professional Sports" if background == "Deportes profesionales"
replace background = "Business Administration" if background == "Administración de empresas"
replace redi = "Prevent universal access to public colleges" if redi == "Evitar el acceso universal a las universidades públicas"
replace redi = "Provide universal access to public colleges" if redi == "Ofrecer acceso universal a las universidades públicas"
replace redi = "Decrease public welfare spending" if redi == "Disminuir el gasto del bienestar público"
replace redi = "Increase public welfare spending" if redi == "Aumentar el gasto del bienestar público"
replace redi = "Decrease income tax on 10 percent richest" if redi == "Disminuir en un 10 por ciento el impuesto sobre la renta a las personas más acaudaladas"
replace redi = "Increase income tax on 10 percent richest" if redi == "Aumentar en un 10 por ciento el impuesto sobre la renta a las personas más acaudaladas"
replace soc = "Punish all drug-related crime harsher" if soc == "Castigar más estrictamente a los delincuentes que cometan delitos relacionados con las drogas"
replace soc = "Provide amnesty to low-level drug offenders" if soc == "Ofrecer amnistía a los delincuentes que cometan delitos menores relacionados con las drogas"
replace soc = "Make abortion law more strict" if soc == "Endurecer la ley contra el aborto"
replace soc = "Relax abortion law" if soc == "Flexibilizar la ley contra el aborto"
replace soc = "Prohibit same-sex marriage nationally" if soc == "Prohibir el matrimonio entre personas del mismo sexo en todo el país"
replace soc = "Legalize same-sex marriage nationally" if soc == "Legalizar el matrimonio entre personas del mismo sexo en todo el país"
replace eco = "Bad at handling economic matters" if eco == "Gestiona de ineficazmente los asuntos económicos"
replace eco = "Neither good nor bad reputation on economic matters" if eco == "Su reputación en asuntos económicos no es positiva ni negativa"
replace eco = "Good at handling economic matters" if eco == "Gestiona eficazmente los asuntos económicos"
replace cor = "Bad at fighting corruption" if cor == "Es ineficaz en la lucha contra la corrupción"
replace cor = "Neither good nor bad reputation on fighting corruption" if cor == "Su reputación en la lucha contra la corrupción no es positiva ni negativa"
replace cor = "Good at fighting corruption" if cor == "Es eficaz en la lucha contra la corrupción"

***Recoding
**Candidate attributes
clonevar canage = age
encode gender, gen(cangender)
encode background, gen(canbackground)
encode party, gen(canparty)
encode redi, gen(canredi)
recode canredi (1 = 0 "Decrease income tax on 10 percent richest") (3 = 1 "Increase income tax on 10 percent richest") (else=.), gen(cantax)
recode canredi (5 = 0 "Prevent universal access to public colleges") (6 = 1 "Provide universal access to public colleges") (else=.), gen(canedu)
recode canredi (2 = 0 "Decrease public welfare spending") (4 = 1 "Increase public welfare spending") (else=.), gen(canwel)
encode soc, gen(cansoc)
recode cansoc (4 = 1 "Provide amnesty to low-level drug offenders") (5 = 0 "Punish all drug-related crime harsher") (else=.), gen(cancrime)
recode cansoc (1 = 1 "Legalize same-sex marriage nationally") (3 = 0 "Prohibit same-sex marriage nationally") (else=.), gen(canss)
recode cansoc (2 = 0 "Make abortion law more strict") (6 = 1 "Relax abortion law") (else=.), gen(canabort)
encode dem, gen(candem)
recode candem (1 5 6 7 = 0 "Democratic") (2 3 4 8 = 1 "Undemocratic"), gen(candemmg) //Making one variable where all undemocratic positions are merged
encode eco, gen(canec)
recode canec (1 = 1 "Bad at handling economic matters") (2 = 3 "Good at handling economic matters") (3 = 2 "Neither good nor bad reputation on economic matters"), gen(caneco)
encode cor, gen(canco)
recode canco (1 = 1 "Bad at fighting corruption") (2 = 3 "Good at fighting corruption") (3 = 2 "Neither good nor bad reputation on fighting corruption"), gen(cancor)
gen cancom = (caneco + cancor)-1
label define competence 1 "Very incompetent" 2 "Moderately incompetent" 3 "Neither competent nor incompetent" 4 "Moderately competent" 5 "Very competent"
label values cancom competence

**Respondent attributes
*Background vars
encode region, gen(regionres)
encode urban, gen(urbanres)
recode urbanres (3 = 1 "Rural County") (2 = 3 "Metropolis") (1 = 2 "Medium-size or small city"), gen(urbanr)
drop urbanres
encode genderres, gen(genderr)
encode edures, gen(edur)
recode edur (2 3 4 5 6 7 = 1 "Less than high school") (1 = 2 "High school") (8 9 = 3 "More than high school"), gen(edurr) //altered to fit US/UK
drop edur

**Preference extremity vars
encode abortion, gen(abortionpre)
encode tax, gen(taxpre)
encode samesex, gen(samesexpre)
encode welfare, gen(welfarepre)
encode edu, gen(edupre)
encode crime, gen(crimepre)
encode demfra, gen(demfrapre)
recode abortionpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(abrpre)
recode taxpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(taxrpre)
recode samesexpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(samerpre)
recode welfarepre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(welrpre)
recode edupre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(edurpre)
recode crimepre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(crimerpre)
recode demfrapre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(demfrpre)
drop abortionpre-demfrapre

*"Extremety on candidate-assigned attributes". Matextax is, for example, the respondent's preference on tax IF the candidate was assigned a tax position. Flips abortion, welfare, unions, and army so that low values are extreme left and high values are extreme right.
label define extreme 1 "Extreme left" 2 "Moderate Left" 3 "Center" 4 "Moderate Right" 5 "Extreme Right"
recode abrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeab)
recode welrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremewel)
recode edurpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeedu)
recode crimerpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremecrime)
clonevar extremetax = taxrpre
clonevar extremess = samerpre
gen matextax = extremetax if cantax != .
gen matexwel = extremewel if canwel != .
gen matexedu = extremeedu if canedu != .
gen matexredi = .
replace matexredi = matextax if matextax != .
replace matexredi = matexwel if matexwel != .
replace matexredi = matexedu if matexedu != .
gen matexcrime = extremecrime if cancrime != .
gen matexabo = extremeab if canabort != .
gen matexss = extremess if canss != .
gen matexsoc = .
replace matexsoc = matexcrime if matexcrime != .
replace matexsoc = matexabo if matexabo != .
replace matexsoc = matexss if matexss != .
label values matexsoc matexcrime matexredi matextax matexedu matexwel matexabo matexss extremetax extremess extremeab extremewel extremeedu extremecrime extreme

**Policy distance between candidate and respondent
*Main measure
recode cantax (0 = 4.5) (1 = 1.5), gen(cantaxm)
recode canedu (0 = 4.5) (1 = 1.5), gen(canedum)
recode canwel (0 = 4.5) (1 = 1.5), gen(canwelm)
gen canredim = .
replace canredim = cantaxm if cantaxm != .
replace canredim = canedum if canedum != .
replace canredim = canwelm if canwelm != .

recode cancrime (0 = 4.5) (1 = 1.5), gen(cancrimem)
recode canss (0 = 4.5) (1 = 1.5), gen(canssm)
recode canabort (0 = 4.5) (1 = 1.5), gen(canabortm)
gen cansocm = .
replace cansocm = cancrimem if cancrimem != .
replace cansocm = canssm if canssm != .
replace cansocm = canabortm if canabortm != .

gen distaxm = matextax-cantaxm
gen disedum = matexedu-canedum
gen diswelm = matexwel-canwelm 
gen disredim = matexredi-canredim

gen discrimem = matexcrime-cancrimem
gen disssm = matexss-canssm
gen disabom = matexabo-canabortm
gen dissocm = matexsoc-cansocm

gen dissumm = sqrt(disredim^2) + sqrt(dissocm^2)
label define distancem 1 "Completely Aligned Positions" 7 "Completely Diverting Positions"
label values dissumm distancem

*Supplementary measures
recode cantax (0 = 5) (1 = 1), gen(cantaxs1)
recode canedu (0 = 5) (1 = 1), gen(canedus1)
recode canwel (0 = 5) (1 = 1), gen(canwels1)
gen canredis1 = .
replace canredis1 = cantaxs1 if cantaxs1 != .
replace canredis1 = canedus1 if canedus1 != .
replace canredis1 = canwels1 if canwels1 != .

recode cancrime (0 = 5) (1 = 1), gen(cancrimes1)
recode canss (0 = 5) (1 = 1), gen(cansss1)
recode canabort (0 = 5) (1 = 1), gen(canaborts1)
gen cansocs1 = .
replace cansocs1 = cancrimes1 if cancrimes1 != .
replace cansocs1 = cansss1 if cansss1 != .
replace cansocs1 = canaborts1 if canaborts1 != .

gen distaxs1 = matextax-cantaxs1
gen disedus1 = matexedu-canedus1
gen diswels1 = matexwel-canwels1 
gen disredis1 = matexredi-canredis1

gen discrimes1 = matexcrime-cancrimes1
gen dissss1 = matexss-cansss1
gen disabos1 = matexabo-canaborts1
gen dissocs1 = matexsoc-cansocs1

gen dissums1 = sqrt(disredis1^2) + sqrt(dissocs1^2)
label define distances1 0 "Completely Aligned Positions" 8 "Completely Diverting Positions"
label values dissums1 distances1

recode cantax (0 = 4) (1 = 2), gen(cantaxs2)
recode canedu (0 = 4) (1 = 2), gen(canedus2)
recode canwel (0 = 4) (1 = 2), gen(canwels2)
gen canredis2 = .
replace canredis2 = cantaxs2 if cantaxs2 != .
replace canredis2 = canedus2 if canedus2 != .
replace canredis2 = canwels2 if canwels2 != .

recode cancrime (0 = 4) (1 = 2), gen(cancrimes2)
recode canss (0 = 4) (1 = 2), gen(cansss2)
recode canabort (0 = 4) (1 = 2), gen(canaborts2)
gen cansocs2 = .
replace cansocs2 = cancrimes2 if cancrimes2 != .
replace cansocs2 = cansss2 if cansss2 != .
replace cansocs2 = canaborts2 if canaborts2 != .

gen distaxs2 = matextax-cantaxs2
gen disedus2 = matexedu-canedus2
gen diswels2 = matexwel-canwels2
gen disredis2 = matexredi-canredis2

gen discrimes2 = matexcrime-cancrimes2
gen dissss2 = matexss-cansss2
gen disabos2 = matexabo-canaborts2
gen dissocs2 = matexsoc-cansocs2

gen dissums2 = sqrt(disredis2^2) + sqrt(dissocs2^2)
label define distances2 0 "Completely Aligned Positions" 6 "Completely Diverting Positions"
label values dissums2 distances2

**Preference intensity vars
encode aboprio, gen(abortionpri)
encode taxprio, gen(taxpri)
encode samesexprio, gen(samesexpri)
encode welprio, gen(welfarepri)
encode eduprio, gen(edupri)
encode crimeprio, gen(crimepri)
recode abortionpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(abrpri)
recode taxpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(taxrpri)
recode samesexpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(samerpri)
recode welfarepri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(welrpri)
recode edupri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(edurpri)
recode crimepri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(crimerpri)
drop abortionpri-crimepri


*"Intensity on candidate-assigned attributes". Matintax is, for example, the respondent's intensity on tax IF the candidate was assigned a tax position
label define intensity 1 "Very Low Intensity" 2 "Low Intensity" 3 "Moderate Intensity" 4 "High Intensity" 5 "Very High Intensity"
gen matintax = taxrpri if cantax != .
gen matinwel = welrpri if canwel != .
gen matinedu = edurpri if canedu != .
gen matinredi = .
replace matinredi = matintax if matintax != .
replace matinredi = matinwel if matinwel != .
replace matinredi = matinedu if matinedu != .
gen matincrime = crimerpri if cancrime != .
gen matinabo = abrpri if canabort != .
gen matinss = samerpri if canss != .
gen matinsoc = .
replace matinsoc = matincrime if matincrime != .
replace matinsoc = matinabo if matinabo != .
replace matinsoc = matinss if matinss != .
label values matintax matinwel matinedu matinredi matincrime matinabo matinss matinsoc intensity

*Intensity in favor of or against candidate: used for analysis
gen abodir = . 
replace abodir = -1 if extremeab < 3 & canabort == 0
replace abodir = -1 if extremeab > 3 & canabort == 1
replace abodir = -0.5 if extremeab == 3 & canabort !=.
replace abodir = 1 if extremeab < 3 & canabort == 1
replace abodir = 1 if extremeab > 3 & canabort == 0
gen aboint = abodir*abrpri

gen taxdir = . 
replace taxdir = -1 if extremetax < 3 & cantax == 0
replace taxdir = -1 if extremetax > 3 & cantax == 1
replace taxdir = -0.5 if extremetax == 3 & cantax !=.
replace taxdir = 1 if extremetax < 3 & cantax == 1
replace taxdir = 1 if extremetax > 3 & cantax == 0
gen taxint = taxdir*taxrpri

gen ssdir = . 
replace ssdir = -1 if extremess < 3 & canss == 0
replace ssdir = -1 if extremess > 3 & canss == 1
replace ssdir = -0.5 if extremess == 3 & canss !=.
replace ssdir = 1 if extremess < 3 & canss == 1
replace ssdir = 1 if extremess > 3 & canss == 0
gen ssint = ssdir*samerpri

gen weldir = . 
replace weldir = -1 if extremewel < 3 & canwel == 0
replace weldir = -1 if extremewel > 3 & canwel == 1
replace weldir = -0.5 if extremewel == 3 & canwel !=.
replace weldir = 1 if extremewel < 3 & canwel == 1
replace weldir = 1 if extremewel > 3 & canwel == 0
gen welint = weldir*welrpri

gen edudir = . 
replace edudir = -1 if extremeedu < 3 & canedu == 0
replace edudir = -1 if extremeedu > 3 & canedu == 1
replace edudir = -0.5 if extremeedu == 3 & canedu !=.
replace edudir = 1 if extremeedu < 3 & canedu == 1
replace edudir = 1 if extremeedu > 3 & canedu == 0
gen eduint = edudir*edurpri

gen crimedir = . 
replace crimedir = -1 if extremecrime < 3 & cancrime == 0
replace crimedir = -1 if extremecrime > 3 & cancrime == 1
replace crimedir = -0.5 if extremecrime == 3 & cancrime !=.
replace crimedir = 1 if extremecrime < 3 & cancrime == 1
replace crimedir = 1 if extremecrime > 3 & cancrime == 0
gen crimeint = crimedir*crimerpri

gen rediint =.
replace rediint = eduint if eduint != .
replace rediint = welint if welint != .
replace rediint = taxint if taxint != .

gen socint =.
replace socint = crimeint if crimeint != .
replace socint = ssint if ssint != .
replace socint = aboint if aboint != .

label define intensityfa -5 "Intense Opinion Against Candidate" -1 "Mild Opinion Against Candidate" 1 "Mild Opinion in Favor of Candidate" 5 "Intense Opinion in Favor of Candidate"
label values aboint taxint ssint rediint welint eduint crimeint socint intensityfa


**Party ID
encode pid, gen(partyid)
recode partyid (1 =.)
drop pid
encode pri, gen(PRIx)
encode pan, gen(PANx)
encode prd, gen(PRDx)
encode morena, gen(MORENAx)
encode ciu, gen(CIUx)
replace PRIx = . if canparty != 4
replace PANx = . if canparty != 2
replace PRDx = . if canparty != 3
replace MORENAx = . if canparty != 1
recode PRIx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(PRI)
recode PANx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(PAN)
recode PRDx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(PRD)
recode MORENAx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(MORENA)
recode CIUx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(CIU)
drop PRIx-CIUx
gen partymmain = .
replace partymmain = PRI if canparty == 4
replace partymmain = PAN if canparty == 2
replace partymmain = PRD if canparty == 3
replace partymmain = MORENA if canparty == 1
label define conparty 1 "Dislike candidate's party a great deal" 2 "Dislike candidate's party somewhat" 3 "Neither like nor dislike candidate's party" 4 "Like candidate's party somewhat" 5 "Like candidate's party a great deal"
label values partymmain conparty
recode partyid (2 = 0 "No Party ID") (1=.) (3 4 5 6 7 8 = 1 "Any Party ID"), gen(anyparty)
recode partyid (4 6 7 8 = 1 "PRI/PRD/PAN/MORENA") (1=.) (2 3 5 = 0 "Not PRI/PRD/PAN/MORENA"), gen(anyinparty) //maybe makes less sense in Mexico - not polarized in two camps as in SK
gen copartisansplit = .
replace copartisansplit = 0 if anyparty == 0 //note other coding than in SK: baseline category with no voter party ID
replace copartisansplit = 1 if partyid == 4 & canparty == 1
replace copartisansplit = 2 if partyid == 6 & canparty == 2
replace copartisansplit = 3 if partyid == 7 & canparty == 3
replace copartisansplit = 4 if partyid == 8 & canparty == 4
replace copartisansplit = 5 if partyid == 4 & canparty == 2
replace copartisansplit = 6 if partyid == 4 & canparty == 3
replace copartisansplit = 7 if partyid == 4 & canparty == 4
replace copartisansplit = 8 if partyid == 6 & canparty == 1
replace copartisansplit = 9 if partyid == 6 & canparty == 3
replace copartisansplit = 10 if partyid == 6 & canparty == 4
replace copartisansplit = 11 if partyid == 7 & canparty == 1
replace copartisansplit = 12 if partyid == 7 & canparty == 2
replace copartisansplit = 13 if partyid == 7 & canparty == 4
replace copartisansplit = 14 if partyid == 8 & canparty == 1
replace copartisansplit = 15 if partyid == 8 & canparty == 2
replace copartisansplit = 16 if partyid == 8 & canparty == 3
replace copartisansplit = 17 if partyid == 3 & canparty == 1
replace copartisansplit = 17 if partyid == 5 & canparty == 1
replace copartisansplit = 18 if partyid == 3 & canparty == 2
replace copartisansplit = 18 if partyid == 5 & canparty == 2
replace copartisansplit = 19 if partyid == 3 & canparty == 3
replace copartisansplit = 19 if partyid == 5 & canparty == 3
replace copartisansplit = 20 if partyid == 3 & canparty == 4
replace copartisansplit = 20 if partyid == 5 & canparty == 4
label define copartisansplit 0 "No Party ID (Voter)" 1 "Copartisanship: MORENA" 2 "Copartisanship: PAN" 3 "Copartisanship: PRD" 4 "Copartisanship: PRI" 5 "Voter: MORENA, Candidate: PAN" 6 "Voter: MORENA, Candidate: PRD" 7 "Voter: MORENA, Candidate: PRI" 8 "Voter: PAN, Candidate: MORENA" 9 "Voter: PAN, Candidate: PRD" 10 "Voter: PAN, Candidate: PRI" 11 "Voter: PRD, Candidate: MORENA" 12 "Voter: PRD, Candidate: PAN" 13 "Voter: PRD, Candidate: PRI" 14 "Voter: PRI, Candidate: MORENA" 15 "Voter: PRI, Candidate: PAN" 16 "Voter: PRI, Candidate: PRD" 17 "Voter: Other, Candidate: MORENA" 18 "Voter: Other, Candidate: PAN" 19 "Voter: Other, Candidate: PRD" 20 "Voter: Other, Candidate: PRI"
label values copartisansplit copartisansplit
recode copartisansplit (0 = 0 "No Party ID (Voter)") (1 2 3 4 = 1 "Copartisanship") (5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 = 2 "Differing Partisanship"), gen(copartisanmerge)

**Manipulation and attention check
encode mcheck, gen(mcheck1)
recode mcheck1 (1 = 3 "Democracy is neither robust nor vulnerable in Mexico") (2 = 4 "Democracy is quite robust in Mexico") (3 = 2 "Democracy is quite vulnerable in Mexico") (4 = 5 "Democracy is very robust in Mexico") (5 = 1 "Democracy is very vulnerable in Mexico") (6=.), gen(manipulation)
drop mcheck1
encode attention, gen(atte)
recode atte (1=5 "Don't know") (2 = 4 "I have not been presented for a piece of text about the current state of democracy around the world") (3 = 2 "That many democratic breakdowns will occur during this decade") (4 = 1 "That no or only very few democratic breakdowns will occur during this decade") (5 = 3 "The piece of text did not mention any predictions"), gen(attent) //NB: Numbers may be wrong; check twice when data is in
drop atte

**Outcome
encode answ, gen(answer)
recode answer (1=.) (2 = 3 "Neither likely nor unlikely") (3 = 4 "Somewhat likely") (4 = 2 "Somewhat unlikely") (5 = 5 "Very likely") (6 = 1 "Very unlikely"), gen(support)
drop answer

**Treatment
encode treat, gen(treat1)
recode treat1 (1 = 0 "Robust") (2=1 "Vulnerable"), gen(treatment)
drop treat1
*Did the treatment work (i.e., did it affect perceived democratic vulnerability?)
reg manipulation i.treatment, cluster(respondentid) //clustering added
*Were the respondents attentive?
gen correctatte = .
replace correctatte = 0 if attent == 5
replace correctatte = 0 if attent == 4
replace correctatte = 0 if attent == 3
replace correctatte = 0 if attent == 2 & treatment == 0
replace correctatte = 0 if attent == 1 & treatment == 1
replace correctatte = 1 if attent == 1 & treatment == 0
replace correctatte = 1 if attent == 2 & treatment == 1
label define correct 0 "Inattentive" 1 "Attentive"
label values correctatte correct
sum correctatte

*Creating numerical variables identifying task and candidate number
generate task =.
replace task = 1 if candidate == "_1" | candidate == "_2"
replace task = 2 if candidate == "_3" | candidate == "_4"
replace task = 3 if candidate == "_5" | candidate == "_6"
replace task = 4 if candidate == "_7" | candidate == "_8"
replace task = 5 if candidate == "_9" | candidate == "_10"
replace task = 6 if candidate == "_11" | candidate == "_12"
replace task = 7 if candidate == "_13" | candidate == "_14"
replace task = 8 if candidate == "_15" | candidate == "_16"
replace task = 9 if candidate == "_17" | candidate == "_18"
replace task = 10 if candidate == "_19" | candidate == "_20"
generate candid =.
replace candid = 1 if candidate == "_1"
replace candid = 2 if candidate == "_2"
replace candid = 3 if candidate == "_3"
replace candid = 4 if candidate == "_4"
replace candid = 5 if candidate == "_5"
replace candid = 6 if candidate == "_6"
replace candid = 7 if candidate == "_7"
replace candid = 8 if candidate == "_8"
replace candid = 9 if candidate == "_9"
replace candid = 10 if candidate == "_10"
replace candid = 11 if candidate == "_11"
replace candid = 12 if candidate == "_12"
replace candid = 13 if candidate == "_13"
replace candid = 14 if candidate == "_14"
replace candid = 15 if candidate == "_15"
replace candid = 16 if candidate == "_16"
replace candid = 17 if candidate == "_17"
replace candid = 18 if candidate == "_18"
replace candid = 19 if candidate == "_19"
replace candid = 20 if candidate == "_20"

**Drop respondents with missing values on variables used for key tests
reg partymmain dissumm matexredi matexsoc rediint socint support
gen sample1 = e(sample)

*Saving for appending later
save "U:\How to Save a Democracy\Data\mxfinal.dta", replace


*****SK*****
import delimited "U:\How to Save a Democracy\Data\skmain.tsv", varnames(1) encoding(UTF-16LE) numericcols(14 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84) clear 
encode responseid, gen(id)
generate respondentid = id+1
keep if q4 == "대도시" | q4 == "시골" | q4 == "중소도시"
gen country = "SK"
gen resp = respondentid + 40000
drop startdate enddate status progress finished distributionchannel userlanguage fl* responseid id


**Correct reshaping of data into uniquely identifying candidate level (by respondent id x candidate number (1-20)).
*Renaming necessary
rename q17_1 answ_1
rename q17_2 answ_2
rename q18_1 answ_3
rename q18_2 answ_4
rename q19_1 answ_5
rename q19_2 answ_6
rename q20_1 answ_7
rename q20_2 answ_8
rename q21_1 answ_9
rename q21_2 answ_10
rename q22_1 answ_11
rename q22_2 answ_12
rename q23_1 answ_13
rename q23_2 answ_14
rename q24_1 answ_15
rename q24_2 answ_16
rename q25_1 answ_17
rename q25_2 answ_18
rename q26_1 answ_19
rename q26_2 answ_20

*Reshaping
reshape long answ dem age gender background party redi soc eco cor, i(respondentid) j(candidate, string)

*Renaming
rename q3 region
rename q4 urban 
rename q5 genderres
rename q6 ageres
rename q7 edures 
rename q8_1 abortion
rename q8_2 tax
rename q8_3 samesex
rename q8_4 welfare
rename q8_5 unions
rename q8_6 army
rename q8_7 demfra
rename q9_1 aboprio
rename q9_2 taxprio
rename q9_3 samesexprio
rename q9_4 welprio
rename q9_5 unionprio
rename q9_6 armyprio
rename q10 pid
rename q11_1 ufp
rename q11_2 dpk
rename q15 mcheck
rename q27 attention
rename q28 device
rename block1_do treat

*Translating variables to English
replace region = "Gangwon" if region == "강원"
replace region = "Gyeonnggi" if region == "경기"
replace region = "Gyeongnam" if region == "경남"
replace region = "Gyeongbuk" if region == "경북"
replace region = "Gwangju" if region == "광주"
replace region = "Daegu" if region == "대구"
replace region = "Daejeon" if region == "대전"
replace region = "Pusan" if region == "부산"
replace region = "Seoul" if region == "서울"
replace region = "Ulsan" if region == "울산"
replace region = "Incheon" if region == "인천"
replace region = "Jeonnam" if region == "전남"
replace region = "Jeonbuk" if region == "전북"
replace region = "Jeju" if region == "제주"
replace region = "Chungnam" if region == "충남"
replace region = "Chungbuk" if region == "충북"
replace urban = "Metropolis" if urban == "대도시"
replace urban = "Rural County" if urban == "시골"
replace urban = "Medium-size or small city" if urban == "중소도시"
replace genderres = "Other" if genderres == "기타"
replace genderres = "Male" if genderres == "남성"
replace genderres = "Prefer not to answer" if genderres == "답변 거부"
replace genderres = "Female" if genderres == "여성"
replace edures = "High School" if edures == "고졸"
replace edures = "College" if edures == "대졸"
replace edures = "Graduate School or above" if edures == "대학원 이상"
replace edures = "Vocational High School" if edures == "전문대"
replace edures = "Middle School or below" if edures == "중졸 이하"
replace abortion = "Strongly agree" if abortion == "매우 동의함"
replace abortion = "Don't know" if abortion == "모름"
replace abortion = "Somewhat agree" if abortion == "어느 정도 동의함"
replace abortion = "Neither agree nor disagree" if abortion == "이도 저도 아님"
replace abortion = "Strongly disagree" if abortion == "전혀 동의하지 않음"
replace abortion = "Somewhat disagree" if abortion == "별로 동의하지 않음"
replace tax = "Strongly agree" if tax == "매우 동의함"
replace tax = "Don't know" if tax == "모름"
replace tax = "Somewhat agree" if tax == "어느 정도 동의함"
replace tax = "Neither agree nor disagree" if tax == "이도 저도 아님"
replace tax = "Strongly disagree" if tax == "전혀 동의하지 않음"
replace tax = "Somewhat disagree" if tax == "별로 동의하지 않음"
replace samesex = "Strongly agree" if samesex == "매우 동의함"
replace samesex = "Don't know" if samesex == "모름"
replace samesex = "Somewhat agree" if samesex == "어느 정도 동의함"
replace samesex = "Neither agree nor disagree" if samesex == "이도 저도 아님"
replace samesex = "Strongly disagree" if samesex == "전혀 동의하지 않음"
replace samesex = "Somewhat disagree" if samesex == "별로 동의하지 않음"
replace welfare = "Strongly agree" if welfare == "매우 동의함"
replace welfare = "Don't know" if welfare == "모름"
replace welfare = "Somewhat agree" if welfare == "어느 정도 동의함"
replace welfare = "Neither agree nor disagree" if welfare == "이도 저도 아님"
replace welfare = "Strongly disagree" if welfare == "전혀 동의하지 않음"
replace welfare = "Somewhat disagree" if welfare == "별로 동의하지 않음"
replace unions = "Strongly agree" if unions == "매우 동의함"
replace unions = "Don't know" if unions == "모름"
replace unions = "Somewhat agree" if unions == "어느 정도 동의함"
replace unions = "Neither agree nor disagree" if unions == "이도 저도 아님"
replace unions = "Strongly disagree" if unions == "전혀 동의하지 않음"
replace unions = "Somewhat disagree" if unions == "별로 동의하지 않음"
replace army = "Strongly agree" if army == "매우 동의함"
replace army = "Don't know" if army == "모름"
replace army = "Somewhat agree" if army == "어느 정도 동의함"
replace army = "Neither agree nor disagree" if army == "이도 저도 아님"
replace army = "Strongly disagree" if army == "전혀 동의하지 않음"
replace army = "Somewhat disagree" if army == "별로 동의하지 않음"
replace demfra = "Strongly agree" if demfra == "매우 동의함"
replace demfra = "Don't know" if demfra == "모름"
replace demfra = "Somewhat agree" if demfra == "어느 정도 동의함"
replace demfra = "Neither agree nor disagree" if demfra == "이도 저도 아님"
replace demfra = "Strongly disagree" if demfra == "전혀 동의하지 않음"
replace demfra = "Somewhat disagree" if demfra == "별로 동의하지 않음"
replace aboprio = "Not at all important" if aboprio == "전혀 중요하지 않음"
replace aboprio = "Don't know" if aboprio == "모름"
replace aboprio = "Extremely important" if aboprio == "지극히 중요함"
replace aboprio = "Very important" if aboprio == "매우 중요함"
replace aboprio = "Not very important" if aboprio == "별로 중요하지 않음"
replace aboprio = "Moderately important" if aboprio == "어느 정도 중요함"
replace taxprio = "Not at all important" if taxprio == "전혀 중요하지 않음"
replace taxprio = "Don't know" if taxprio == "모름"
replace taxprio = "Extremely important" if taxprio == "지극히 중요함"
replace taxprio = "Very important" if taxprio == "매우 중요함"
replace taxprio = "Not very important" if taxprio == "별로 중요하지 않음"
replace taxprio = "Moderately important" if taxprio == "어느 정도 중요함"
replace samesexprio = "Not at all important" if samesexprio == "전혀 중요하지 않음"
replace samesexprio = "Don't know" if samesexprio == "모름"
replace samesexprio = "Extremely important" if samesexprio == "지극히 중요함"
replace samesexprio = "Very important" if samesexprio == "매우 중요함"
replace samesexprio = "Not very important" if samesexprio == "별로 중요하지 않음"
replace samesexprio = "Moderately important" if samesexprio == "어느 정도 중요함"
replace welprio = "Not at all important" if welprio == "전혀 중요하지 않음"
replace welprio = "Don't know" if welprio == "모름"
replace welprio = "Extremely important" if welprio == "지극히 중요함"
replace welprio = "Very important" if welprio == "매우 중요함"
replace welprio = "Not very important" if welprio == "별로 중요하지 않음"
replace welprio = "Moderately important" if welprio == "어느 정도 중요함"
replace unionprio = "Not at all important" if unionprio == "전혀 중요하지 않음"
replace unionprio = "Don't know" if unionprio == "모름"
replace unionprio = "Extremely important" if unionprio == "지극히 중요함"
replace unionprio = "Very important" if unionprio == "매우 중요함"
replace unionprio = "Not very important" if unionprio == "별로 중요하지 않음"
replace unionprio = "Moderately important" if unionprio == "어느 정도 중요함"
replace armyprio = "Not at all important" if armyprio == "전혀 중요하지 않음"
replace armyprio = "Don't know" if armyprio == "모름"
replace armyprio = "Extremely important" if armyprio == "지극히 중요함"
replace armyprio = "Very important" if armyprio == "매우 중요함"
replace armyprio = "Not very important" if armyprio == "별로 중요하지 않음"
replace armyprio = "Moderately important" if armyprio == "어느 정도 중요함"
replace pid = "I identify with a party not listed here" if pid == "다른 정당을 지지함"
replace pid = "Democratic Party of Korea" if pid == "더불어민주당"
replace pid = "Don't know" if pid == "모름"
replace pid = "United Future Party" if pid == "미래통합당"
replace pid = "I do not identify with any party" if pid == "어떤 정당도 지지하지 않음"
replace ufp = "Dislike a great deal" if ufp == "매우 싫어함"
replace ufp = "Like a great deal" if ufp == "매우 좋아함"
replace ufp = "Don't know" if ufp == "모름"
replace ufp = "Dislike somewhat" if ufp == "약간 싫어함"
replace ufp = "Like somewhat" if ufp == "약간 좋아함"
replace ufp = "Neither like nor dislike" if ufp == "좋아하지도 싫어하지도 않음"
replace dpk = "Dislike a great deal" if dpk == "매우 싫어함"
replace dpk = "Like a great deal" if dpk == "매우 좋아함"
replace dpk = "Don't know" if dpk == "모름"
replace dpk = "Dislike somewhat" if dpk == "약간 싫어함"
replace dpk = "Like somewhat" if dpk == "약간 좋아함"
replace dpk = "Neither like nor dislike" if dpk == "좋아하지도 싫어하지도 않음"
replace mcheck = "Democracy is neither robust nor vulnerable in South Korea" if mcheck == "대한민국의 민주주의는 강건하지도 취약하지도 않음"
replace mcheck = "Democracy is quite robust in South Korea" if mcheck == "대한민국의 민주주의는 꽤 강건함"
replace mcheck = "Democracy is quite vulnerable in South Korea" if mcheck == "대한민국의 민주주의는 꽤 취약함"
replace mcheck = "Democracy is very robust in South Korea" if mcheck == "대한민국의 민주주의는 매우 강건함"
replace mcheck = "Democracy is very vulnerable in South Korea" if mcheck == "대한민국의 민주주의는 매우 취약함"
replace mcheck = "Don't know" if mcheck == "모름"
replace attention = "The piece of text did not mention any predictions" if attention == "글은 그 어떤 예상도 다루지 않았음"
replace attention = "Don't know" if attention == "모름"
replace attention = "I have not been presented for a piece of text about the current state of democracy around the world" if attention == "세계 민주주의 상황에 대한 글을 보지 못했음"
replace attention = "That many democratic breakdowns will occur during this decade" if attention == "향후 10년 이내 붕괴할 민주주의의 수가 많을 것"
replace attention = "That no or only very few democratic breakdowns will occur during this decade" if attention == "향후 10년 이내 붕괴할 민주주의의 수는 전혀 없거나 매우 낮을 것"
replace device = "Prefer not to answer" if device == "답변 거부"
replace device = "Other" if device == "기타"
replace device = "Smartphone" if device == "스마트폰"
replace device = "PC or Macbook" if device == "컴퓨터 또는 맥북"
replace device = "Tablet" if device == "태블릿"
replace answ = "Very unlikely" if answ == "매우 낮음"
replace answ = "Very likely" if answ == "매우 높음"
replace answ = "Don't know" if answ == "모름"
replace answ = "Somewhat unlikely" if answ == "약간 낮음"
replace answ = "Somewhat likely" if answ == "약간 높음"
replace answ = "Neither likely nor unlikely" if answ == "높지도 낮지도 않음"
replace dem = "Said it is unacceptable to harass journalists even though they do not reveal sources" if dem == "기자가 정보 출처를 밝히지 않는다고 하더라도 공격 당해서는 안 된다고 주장함"
replace dem = "Said it is legitimate to fight political opponents in the streets if one feels provoked" if dem == "도발당했다고 느낄 경우 길거리에서 정치적으로 반대 성향인 상대와 몸싸움을 벌이는"
replace dem = "Said it is unacceptable to fight political opponents in the streets even though one feels provoked" if dem == "도발당했다고 느낄 경우라도 길거리에서 정치적으로 반대 성향인 상대와 몸싸움을"
replace dem = "Said court rulings by judges appointed by opposing parties should be ignored" if dem == "반대 정당에서 임명한 판사들이 내린 판결은 무시해야 한다고 주장함"
replace dem = "Said court rulings by judges appointed by opposing parties should be adhered to" if dem == "반대 정당에서 임명한 판사들이 내린 판결이라도 따라야 한다고 주장함"
replace dem = "Supported a proposal to reduce polling stations in areas that support opposing parties" if dem == "반대 정당을 지지하는 지역의 투표소 수를 줄이자는 제안을 지지함"
replace dem = "Supported a proposal to preserve existing polling-stations in all areas" if dem == "전 지역에 현존하는 투표소를 유지하자는 제안을 지지함"
replace dem = "Said it is acceptable to harass journalists that do not reveal sources" if dem == "정보 출처를 밝히지 않는 기자는 공격 당해도 된다고 주장함"
replace gender = "Male" if gender == "남성"
replace gender = "Female" if gender == "여성"
replace background = "Civil Servant" if background == "공무원"
replace background = "Professor" if background == "교수"
replace background = "Army General" if background == "군대 참모"
replace background = "Journalist" if background == "기자"
replace background = "Lawyer" if background == "변호사"
replace background = "Engineer" if background == "엔지니어"
replace background = "Self-employed" if background == "자영업자"
replace background = "Political Career" if background == "정치인"
replace background = "Company Director" if background == "회사 임원"
replace party = "Democratic Party of Korea" if party == "더불어민주당"
replace party = "United Future Party" if party == "미래통합당"
replace redi = "Decrease power of labor unions" if redi == "노동조합의 힘 축소"
replace redi = "Increase power of labor unions" if redi == "노동조합의 힘 확대"
replace redi = "Decrease public welfare spending" if redi == "사회복지 지출 감소"
replace redi = "Increase public welfare spending" if redi == "사회복지 지출 증가"
replace redi = "Decrease income tax on 10 percent richest" if redi == "상위 10% 고소득자의 소득세 감소"
replace redi = "Increase income tax on 10 percent richest" if redi == "상위 10% 고소득자의 소득세 증가"
replace soc = "Decrease funds to the army" if soc == "군대 예산 삭감"
replace soc = "Increase funds to the army" if soc == "군대 예산 증가"
replace soc = "Make abortion law more strict" if soc == "낙태법 강화"
replace soc = "Relax abortion law" if soc == "낙태법 완화"
replace soc = "Prohibit same-sex marriage nationally" if soc == "동성 결혼 금지"
replace soc = "Legalize same-sex marriage nationally" if soc == "동성 결혼 합법화"
replace eco = "Bad at handling economic matters" if eco == "경제 문제를 잘 다루지 못함"
replace eco = "Neither good nor bad reputation on economic matters" if eco == "경제 문제를 잘 다루지도 못 다루지도 않음"
replace eco = "Good at handling economic matters" if eco == "경제 문제를 잘 다룸"
replace cor = "Bad at fighting corruption" if cor == "부정부패에 잘 맞서지 못함"
replace cor = "Neither good nor bad reputation on fighting corruption" if cor == "부정부패에 잘 맞서지도 못 맞서지도 않음"
replace cor = "Good at fighting corruption" if cor == "부정부패에 잘 맞섬"

***Recoding
**Candidate attributes
clonevar canage = age
encode gender, gen(cangender)
encode background, gen(canbackground)
encode party, gen(canparty)
encode redi, gen(canredi)
recode canredi (1 = 0 "Decrease income tax on 10 percent richest") (4 = 1 "Increase income tax on 10 percent richest") (else=.), gen(cantax)
recode canredi (2 = 0 "Decrease power of labor unions") (5 = 1 "Increase power of labor unions") (else=.), gen(canunion)
recode canredi (3 = 0 "Decrease public welfare spending") (6 = 1 "Increase public welfare spending") (else=.), gen(canwel)
encode soc, gen(cansoc)
recode cansoc (1 = 1 "Decrease funds to the army") (2 = 0 "Increase funds to the army") (else=.), gen(canarmy)
recode cansoc (3 = 1 "Legalize same-sex marriage nationally") (5 = 0 "Prohibit same-sex marriage nationally") (else=.), gen(canss)
recode cansoc (4 = 0 "Make abortion law more strict") (6 = 1 "Relax abortion law") (else=.), gen(canabort)
encode dem, gen(candem)
recode candem (1 5 6 7 = 0 "Democratic") (2 3 4 8 = 1 "Undemocratic"), gen(candemmg) //Making one variable where all undemocratic positions are merged
encode eco, gen(canec)
recode canec (1 = 1 "Bad at handling economic matters") (2 = 3 "Good at handling economic matters") (3 = 2 "Neither good nor bad reputation on economic matters"), gen(caneco)
encode cor, gen(canco)
recode canco (1 = 1 "Bad at fighting corruption") (2 = 3 "Good at fighting corruption") (3 = 2 "Neither good nor bad reputation on fighting corruption"), gen(cancor)
gen cancom = (caneco + cancor)-1
label define competence 1 "Very incompetent" 2 "Moderately incompetent" 3 "Neither competent nor incompetent" 4 "Moderately competent" 5 "Very competent"
label values cancom competence

**Respondent attributes
*Background vars
encode region, gen(regionres)
encode urban, gen(urbanres)
recode urbanres (3 = 1 "Rural County") (2 = 3 "Metropolis") (1 = 2 "Medium-size or small city"), gen(urbanr)
drop urbanres
encode genderres, gen(genderr)
encode edures, gen(edur)
recode edur (1 2 = 3 "More than high school") (3 5 = 2 "High School") (4 = 1 "Less than high school"), gen(edurr) //altered to fit UK/US
drop edur

**Preference extremity vars
encode abortion, gen(abortionpre)
encode tax, gen(taxpre)
encode samesex, gen(samesexpre)
encode welfare, gen(welfarepre)
encode unions, gen(unionspre)
encode army, gen(armypre)
encode demfra, gen(demfrapre)
recode abortionpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(abrpre)
recode taxpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(taxrpre)
recode samesexpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(samerpre)
recode welfarepre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(welrpre)
recode unionspre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(uniorpre)
recode armypre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(armrpre)
recode demfrapre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(demfrpre)
drop abortionpre-demfrapre

*"Extremety on candidate-assigned attributes". Matextax is, for example, the respondent's preference on tax IF the candidate was assigned a tax position. Flips abortion, welfare, unions, and army so that low values are extreme left and high values are extreme right.
label define extreme 1 "Extreme left" 2 "Moderate Left" 3 "Center" 4 "Moderate Right" 5 "Extreme Right"
recode abrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeab)
recode welrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremewel)
recode armrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremearm)
recode uniorpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeunion)
clonevar extremetax = taxrpre
clonevar extremess = samerpre
gen matextax = extremetax if cantax != .
gen matexwel = extremewel if canwel != .
gen matexunion = extremeunion if canunion != .
gen matexredi = .
replace matexredi = matextax if matextax != .
replace matexredi = matexwel if matexwel != .
replace matexredi = matexunion if matexunion != .
gen matexarmy = extremearm if canarmy != .
gen matexabo = extremeab if canabort != .
gen matexss = extremess if canss != .
gen matexsoc = .
replace matexsoc = matexarmy if matexarmy != .
replace matexsoc = matexabo if matexabo != .
replace matexsoc = matexss if matexss != .
label values matexsoc matexarmy matexredi matextax matexunion matexwel matexabo matexss extremetax extremess extremeab extremewel extremeunion extremearm extreme

**Policy distance between candidate and respondent
*Main measure
recode cantax (0 = 4.5) (1 = 1.5), gen(cantaxm)
recode canunion (0 = 4.5) (1 = 1.5), gen(canunionm)
recode canwel (0 = 4.5) (1 = 1.5), gen(canwelm)
gen canredim = .
replace canredim = cantaxm if cantaxm != .
replace canredim = canunionm if canunionm != .
replace canredim = canwelm if canwelm != .

recode canarmy (0 = 4.5) (1 = 1.5), gen(canarmym)
recode canss (0 = 4.5) (1 = 1.5), gen(canssm)
recode canabort (0 = 4.5) (1 = 1.5), gen(canabortm)
gen cansocm = .
replace cansocm = canarmym if canarmym != .
replace cansocm = canssm if canssm != .
replace cansocm = canabortm if canabortm != .

gen distaxm = matextax-cantaxm
gen disunionm = matexunion-canunionm
gen diswelm = matexwel-canwelm 
gen disredim = matexredi-canredim

gen disarmm = matexarmy-canarmym
gen disssm = matexss-canssm
gen disabom = matexabo-canabortm
gen dissocm = matexsoc-cansocm

gen dissumm = sqrt(disredim^2) + sqrt(dissocm^2)
label define distancem 1 "Completely Aligned Positions" 7 "Completely Diverting Positions"
label values dissumm distancem

*Supplementary measures
recode cantax (0 = 5) (1 = 1), gen(cantaxs1)
recode canunion (0 = 5) (1 = 1), gen(canunions1)
recode canwel (0 = 5) (1 = 1), gen(canwels1)
gen canredis1 = .
replace canredis1 = cantaxs1 if cantaxs1 != .
replace canredis1 = canunions1 if canunions1 != .
replace canredis1 = canwels1 if canwels1 != .

recode canarmy (0 = 5) (1 = 1), gen(canarmys1)
recode canss (0 = 5) (1 = 1), gen(cansss1)
recode canabort (0 = 5) (1 = 1), gen(canaborts1)
gen cansocs1 = .
replace cansocs1 = canarmys1 if canarmys1 != .
replace cansocs1 = cansss1 if cansss1 != .
replace cansocs1 = canaborts1 if canaborts1 != .

gen distaxs1 = matextax-cantaxs1
gen disunions1 = matexunion-canunions1
gen diswels1 = matexwel-canwels1 
gen disredis1 = matexredi-canredis1

gen disarms1 = matexarmy-canarmys1
gen dissss1 = matexss-cansss1
gen disabos1 = matexabo-canaborts1
gen dissocs1 = matexsoc-cansocs1

gen dissums1 = sqrt(disredis1^2) + sqrt(dissocs1^2)
label define distances1 0 "Completely Aligned Positions" 8 "Completely Diverting Positions"
label values dissums1 distances1

recode cantax (0 = 4) (1 = 2), gen(cantaxs2)
recode canunion (0 = 4) (1 = 2), gen(canunions2)
recode canwel (0 = 4) (1 = 2), gen(canwels2)
gen canredis2 = .
replace canredis2 = cantaxs2 if cantaxs2 != .
replace canredis2 = canunions2 if canunions2 != .
replace canredis2 = canwels2 if canwels2 != .

recode canarmy (0 = 4) (1 = 2), gen(canarmys2)
recode canss (0 = 4) (1 = 2), gen(cansss2)
recode canabort (0 = 4) (1 = 2), gen(canaborts2)
gen cansocs2 = .
replace cansocs2 = canarmys2 if canarmys2 != .
replace cansocs2 = cansss2 if cansss2 != .
replace cansocs2 = canaborts2 if canaborts2 != .

gen distaxs2 = matextax-cantaxs2
gen disunions2 = matexunion-canunions2
gen diswels2 = matexwel-canwels2
gen disredis2 = matexredi-canredis2

gen disarms2 = matexarmy-canarmys2
gen dissss2 = matexss-cansss2
gen disabos2 = matexabo-canaborts2
gen dissocs2 = matexsoc-cansocs2

gen dissums2 = sqrt(disredis2^2) + sqrt(dissocs2^2)
label define distances2 0 "Completely Aligned Positions" 6 "Completely Diverting Positions"
label values dissums2 distances2

**Preference intensity vars (respondent)
encode aboprio, gen(abortionpri)
encode taxprio, gen(taxpri)
encode samesexprio, gen(samesexpri)
encode welprio, gen(welfarepri)
encode unionprio, gen(unionspri)
encode armyprio, gen(armypri)
recode abortionpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(abrpri)
recode taxpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(taxrpri)
recode samesexpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(samerpri)
recode welfarepri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(welrpri)
recode unionspri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(uniorpri)
recode armypri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(armrpri)
drop abortionpri-armypri


*"Intensity on candidate-assigned attributes". Matintax is, for example, the respondent's intensity on tax IF the candidate was assigned a tax position
label define intensity 1 "Very Low Intensity" 2 "Low Intensity" 3 "Moderate Intensity" 4 "High Intensity" 5 "Very High Intensity"
gen matintax = taxrpri if cantax != .
gen matinwel = welrpri if canwel != .
gen matinunion = uniorpri if canunion != .
gen matinredi = .
replace matinredi = matintax if matintax != .
replace matinredi = matinwel if matinwel != .
replace matinredi = matinunion if matinunion != .
gen matinarmy = armrpri if canarmy != .
gen matinabo = abrpri if canabort != .
gen matinss = samerpri if canss != .
gen matinsoc = .
replace matinsoc = matinarmy if matinarmy != .
replace matinsoc = matinabo if matinabo != .
replace matinsoc = matinss if matinss != .
label values matintax matinwel matinunion matinredi matinarmy matinabo matinss matinsoc intensity

*Intensity in favor of or against candidate: used for analysis
gen abodir = . 
replace abodir = -1 if extremeab < 3 & canabort == 0
replace abodir = -1 if extremeab > 3 & canabort == 1
replace abodir = -0.5 if extremeab == 3 & canabort !=.
replace abodir = 1 if extremeab < 3 & canabort == 1
replace abodir = 1 if extremeab > 3 & canabort == 0
gen aboint = abodir*abrpri

gen taxdir = . 
replace taxdir = -1 if extremetax < 3 & cantax == 0
replace taxdir = -1 if extremetax > 3 & cantax == 1
replace taxdir = -0.5 if extremetax == 3 & cantax !=.
replace taxdir = 1 if extremetax < 3 & cantax == 1
replace taxdir = 1 if extremetax > 3 & cantax == 0
gen taxint = taxdir*taxrpri

gen ssdir = . 
replace ssdir = -1 if extremess < 3 & canss == 0
replace ssdir = -1 if extremess > 3 & canss == 1
replace ssdir = -0.5 if extremess == 3 & canss !=.
replace ssdir = 1 if extremess < 3 & canss == 1
replace ssdir = 1 if extremess > 3 & canss == 0
gen ssint = ssdir*samerpri

gen weldir = . 
replace weldir = -1 if extremewel < 3 & canwel == 0
replace weldir = -1 if extremewel > 3 & canwel == 1
replace weldir = -0.5 if extremewel == 3 & canwel !=.
replace weldir = 1 if extremewel < 3 & canwel == 1
replace weldir = 1 if extremewel > 3 & canwel == 0
gen welint = weldir*welrpri

gen uniondir = . 
replace uniondir = -1 if extremeunion < 3 & canunion == 0
replace uniondir = -1 if extremeunion > 3 & canunion == 1
replace uniondir = -0.5 if extremeunion == 3 & canunion !=.
replace uniondir = 1 if extremeunion < 3 & canunion == 1
replace uniondir = 1 if extremeunion > 3 & canunion == 0
gen unionint = uniondir*uniorpri

gen armdir = . 
replace armdir = -1 if extremearm < 3 & canarmy == 0
replace armdir = -1 if extremearm > 3 & canarmy == 1
replace armdir = -0.5 if extremearm == 3 & canarmy !=.
replace armdir = 1 if extremearm < 3 & canarmy == 1
replace armdir = 1 if extremearm > 3 & canarmy == 0
gen armint = armdir*armrpri

gen rediint =.
replace rediint = unionint if unionint != .
replace rediint = welint if welint != .
replace rediint = taxint if taxint != .

gen socint =.
replace socint = armint if armint != .
replace socint = ssint if ssint != .
replace socint = aboint if aboint != .

label define intensityfa -5 "Intense Opinion Against Candidate" -1 "Mild Opinion Against Candidate" 1 "Mild Opinion in Favor of Candidate" 5 "Intense Opinion in Favor of Candidate"
label values aboint taxint ssint rediint welint unionint armint socint intensityfa


**Party ID
encode pid, gen(partyid)
recode partyid (2 =.)
drop pid
encode ufp, gen(UFPx)
encode dpk, gen(DPKx)
replace UFPx = . if canparty != 2
replace DPKx = . if canparty != 1
recode UFPx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(UFP)
recode DPKx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(DPK)
drop UFPx-DPKx
gen partymmain = .
replace partymmain = UFP if canparty == 2
replace partymmain = DPK if canparty == 1
label define conparty 1 "Dislike candidate's party a great deal" 2 "Dislike candidate's party somewhat" 3 "Neither like nor dislike candidate's party" 4 "Like candidate's party somewhat" 5 "Like candidate's party a great deal"
label values partymmain conparty
recode partyid (3 = 0 "No Party ID") (2=.) (1 4 5 = 1 "Any Party ID"), gen(anyparty)
recode partyid (1 5 = 1 "DPK/UFP") (2=.) (3 4 = 0 "Not DPK/UFP"), gen(anyinparty)
gen copartisansplit = .
replace copartisansplit = 0 if anyinparty == 0
replace copartisansplit = 1 if partyid == 1 & canparty == 1
replace copartisansplit = 2 if partyid == 5 & canparty == 2
replace copartisansplit = 3 if partyid == 1 & canparty == 2
replace copartisansplit = 4 if partyid == 5 & canparty == 1
label define copartisansplit 0 "Neither Copartisanship nor Opposing Partisanship" 1 "Copartisanship: DPK" 2 "Copartisanship: UFP" 3 "Voter: DPK, Candidate: UFP" 4 "Voter: UFP, Candidate: DPK"
label values copartisansplit copartisansplit
recode copartisansplit (0 = 0 "Neither Copartisanship nor Opposing Partisanship") (1 2 = 1 "Copartisanship") (3 4 = 2 "Opposing Partisanship"), gen(copartisanmerge)


**Manipulation and attention check
encode mcheck, gen(mcheck1)
recode mcheck1 (1 = 3 "Democracy is neither robust nor vulnerable in South Korea") (2 = 4 "Democracy is quite robust in South Korea") (3 = 2 "Democracy is quite vulnerable in South Korea") (4 = 5 "Democracy is very robust in South Korea") (5 = 1 "Democracy is very vulnerable in South Korea") (6=.), gen(manipulation)
drop mcheck1
encode attention, gen(atte)
recode atte (1=5 "Don't know") (2 = 4 "I have not been presented for a piece of text about the current state of democracy around the world") (3 = 2 "That many democratic breakdowns will occur during this decade") (4 = 1 "That no or only very few democratic breakdowns will occur during this decade") (5 = 3 "The piece of text did not mention any predictions"), gen(attent) //NB: Numbers may be wrong; check twice when data is in
drop atte

**Outcome
encode answ, gen(answer)
recode answer (1=.) (2 = 3 "Neither likely nor unlikely") (3 = 4 "Somewhat likely") (4 = 2 "Somewhat unlikely") (5 = 5 "Very likely") (6 = 1 "Very unlikely"), gen(support)
drop answer

**Treatment
encode treat, gen(treat1)
recode treat1 (1 = 0 "Robust") (2=1 "Vulnerable"), gen(treatment)
drop treat1
*Did the treatment work (i.e., did it affect perceived democratic vulnerability?)
reg manipulation i.treatment, cluster(respondentid) //clustering added
*Were the respondents attentive?
gen correctatte = .
replace correctatte = 0 if attent == 5
replace correctatte = 0 if attent == 4
replace correctatte = 0 if attent == 3
replace correctatte = 0 if attent == 2 & treatment == 0
replace correctatte = 0 if attent == 1 & treatment == 1
replace correctatte = 1 if attent == 1 & treatment == 0
replace correctatte = 1 if attent == 2 & treatment == 1
label define correct 0 "Inattentive" 1 "Attentive"
label values correctatte correct
sum correctatte

*Creating numerical variables identifying task and candidate number
generate task =.
replace task = 1 if candidate == "_1" | candidate == "_2"
replace task = 2 if candidate == "_3" | candidate == "_4"
replace task = 3 if candidate == "_5" | candidate == "_6"
replace task = 4 if candidate == "_7" | candidate == "_8"
replace task = 5 if candidate == "_9" | candidate == "_10"
replace task = 6 if candidate == "_11" | candidate == "_12"
replace task = 7 if candidate == "_13" | candidate == "_14"
replace task = 8 if candidate == "_15" | candidate == "_16"
replace task = 9 if candidate == "_17" | candidate == "_18"
replace task = 10 if candidate == "_19" | candidate == "_20"
generate candid =.
replace candid = 1 if candidate == "_1"
replace candid = 2 if candidate == "_2"
replace candid = 3 if candidate == "_3"
replace candid = 4 if candidate == "_4"
replace candid = 5 if candidate == "_5"
replace candid = 6 if candidate == "_6"
replace candid = 7 if candidate == "_7"
replace candid = 8 if candidate == "_8"
replace candid = 9 if candidate == "_9"
replace candid = 10 if candidate == "_10"
replace candid = 11 if candidate == "_11"
replace candid = 12 if candidate == "_12"
replace candid = 13 if candidate == "_13"
replace candid = 14 if candidate == "_14"
replace candid = 15 if candidate == "_15"
replace candid = 16 if candidate == "_16"
replace candid = 17 if candidate == "_17"
replace candid = 18 if candidate == "_18"
replace candid = 19 if candidate == "_19"
replace candid = 20 if candidate == "_20"

**Drop respondents with missing values on variables used for key tests
reg partymmain dissumm matexredi matexsoc rediint socint support
gen sample1 = e(sample)

*Saving for appending later
save "U:\How to Save a Democracy\Data\skfinal.dta", replace


*****CZ*****
import delimited "U:\How to Save a Democracy\Data\czmain.tsv", varnames(1) encoding(UTF-16LE) numericcols(14 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84) clear 
encode responseid, gen(id)
generate respondentid = id+1
drop if respondentid == .
keep if q4 == "Středně velké nebo malé město" | q4 == "Velkoměsto"| q4 == "Venkov"
gen country = "CZ"
gen resp = respondentid + 50000
drop startdate enddate status progress finished distributionchannel userlanguage fl* responseid id

**Correct reshaping of data into uniquely identifying candidate level (by respondent id x candidate number (1-20)).
*Renaming necessary
rename q17_1 answ_1
rename q17_2 answ_2
rename q18_1 answ_3
rename q18_2 answ_4
rename q19_1 answ_5
rename q19_2 answ_6
rename q20_1 answ_7
rename q20_2 answ_8
rename q21_1 answ_9
rename q21_2 answ_10
rename q22_1 answ_11
rename q22_2 answ_12
rename q23_1 answ_13
rename q23_2 answ_14
rename q24_1 answ_15
rename q24_2 answ_16
rename q25_1 answ_17
rename q25_2 answ_18
rename q26_1 answ_19
rename q26_2 answ_20

*Reshaping
reshape long answ dem age gender background party redi soc eco cor, i(respondentid) j(candidate, string)

*Renaming
rename q3 region
rename q4 urban 
rename q5 genderres
rename q6 ageres
rename q7 edures 
rename q8_1 abortion
rename q8_2 tax
rename q8_3 samesex
rename q8_4 welfare
rename q8_5 unions
rename q8_6 immi
rename q8_7 demfra
rename q9_1 aboprio
rename q9_2 taxprio
rename q9_3 samesexprio
rename q9_4 welprio
rename q9_5 unionprio
rename q9_6 immiprio
rename q10 pid
rename q11_1 Čssd
rename q11_2 Ods
rename q11_3 Ano
rename q15 mcheck
rename q27 attention
rename q28 device
rename block5_do treat

*Translating variables to English
replace urban = "Metropolis" if urban == "Velkoměsto"
replace urban = "Rural County" if urban == "Venkov"
replace urban = "Medium-size or small city" if urban == "Středně velké nebo malé město"
replace genderres = "Other" if genderres == "Jiné"
replace genderres = "Male" if genderres == "Muž"
replace genderres = "Prefer not to answer" if genderres == "Nepřeji si odpovědět"
replace genderres = "Female" if genderres == "Žena"
replace edures = "Elementary school or lower" if edures == "Základní škola nebo nižší vzdělání"
replace edures = "Secondary education (general or vocational)" if edures == "Středoškolské vzdělání (všeobecné nebo odborné)"
replace edures = "University or other tertiary education" if edures == "Univerzitní nebo jiné terciární vzdělání"
replace abortion = "Strongly agree" if abortion == "Rozhodně souhlasím"
replace abortion = "Don't know" if abortion == "Nevím"
replace abortion = "Somewhat agree" if abortion == "Spíše souhlasím"
replace abortion = "Neither agree nor disagree" if abortion == "Mám neutrální názor"
replace abortion = "Strongly disagree" if abortion == "Rozhodně nesouhlasím"
replace abortion = "Somewhat disagree" if abortion == "Spíše nesouhlasím"
replace tax = "Strongly agree" if tax == "Rozhodně souhlasím"
replace tax = "Don't know" if tax == "Nevím"
replace tax = "Somewhat agree" if tax == "Spíše souhlasím"
replace tax = "Neither agree nor disagree" if tax == "Mám neutrální názor"
replace tax = "Strongly disagree" if tax == "Rozhodně nesouhlasím"
replace tax = "Somewhat disagree" if tax == "Spíše nesouhlasím"
replace samesex = "Strongly agree" if samesex == "Rozhodně souhlasím"
replace samesex = "Don't know" if samesex == "Nevím"
replace samesex = "Somewhat agree" if samesex == "Spíše souhlasím"
replace samesex = "Neither agree nor disagree" if samesex == "Mám neutrální názor"
replace samesex = "Strongly disagree" if samesex == "Rozhodně nesouhlasím"
replace samesex = "Somewhat disagree" if samesex == "Spíše nesouhlasím"
replace welfare = "Strongly agree" if welfare == "Rozhodně souhlasím"
replace welfare = "Don't know" if welfare == "Nevím"
replace welfare = "Somewhat agree" if welfare == "Spíše souhlasím"
replace welfare = "Neither agree nor disagree" if welfare == "Mám neutrální názor"
replace welfare = "Strongly disagree" if welfare == "Rozhodně nesouhlasím"
replace welfare = "Somewhat disagree" if welfare == "Spíše nesouhlasím"
replace unions = "Strongly agree" if unions == "Rozhodně souhlasím"
replace unions = "Don't know" if unions == "Nevím"
replace unions = "Somewhat agree" if unions == "Spíše souhlasím"
replace unions = "Neither agree nor disagree" if unions == "Mám neutrální názor"
replace unions = "Strongly disagree" if unions == "Rozhodně nesouhlasím"
replace unions = "Somewhat disagree" if unions == "Spíše nesouhlasím"
replace immi = "Strongly agree" if immi == "Rozhodně souhlasím"
replace immi = "Don't know" if immi == "Nevím"
replace immi = "Somewhat agree" if immi == "Spíše souhlasím"
replace immi = "Neither agree nor disagree" if immi == "Mám neutrální názor"
replace immi = "Strongly disagree" if immi == "Rozhodně nesouhlasím"
replace immi = "Somewhat disagree" if immi == "Spíše nesouhlasím"
replace demfra = "Strongly agree" if demfra == "Rozhodně souhlasím"
replace demfra = "Don't know" if demfra == "Nevím"
replace demfra = "Somewhat agree" if demfra == "Spíše souhlasím"
replace demfra = "Neither agree nor disagree" if demfra == "Mám neutrální názor"
replace demfra = "Strongly disagree" if demfra == "Rozhodně nesouhlasím"
replace demfra = "Somewhat disagree" if demfra == "Spíše nesouhlasím"
replace aboprio = "Not at all important" if aboprio == "Zcela nedůležité"
replace aboprio = "Don't know" if aboprio == "Nevím"
replace aboprio = "Extremely important" if aboprio == "Extrémně důležité"
replace aboprio = "Very important" if aboprio == "Velmi důležité"
replace aboprio = "Not very important" if aboprio == "Nepříliš důležité"
replace aboprio = "Moderately important" if aboprio == "Středně důležité"
replace taxprio = "Not at all important" if taxprio == "Zcela nedůležité"
replace taxprio = "Don't know" if taxprio == "Nevím"
replace taxprio = "Extremely important" if taxprio == "Extrémně důležité"
replace taxprio = "Very important" if taxprio == "Velmi důležité"
replace taxprio = "Not very important" if taxprio == "Nepříliš důležité"
replace taxprio = "Moderately important" if taxprio == "Středně důležité"
replace samesexprio = "Not at all important" if samesexprio == "Zcela nedůležité"
replace samesexprio = "Don't know" if samesexprio == "Nevím"
replace samesexprio = "Extremely important" if samesexprio == "Extrémně důležité"
replace samesexprio = "Very important" if samesexprio == "Velmi důležité"
replace samesexprio = "Not very important" if samesexprio == "Nepříliš důležité"
replace samesexprio = "Moderately important" if samesexprio == "Středně důležité"
replace welprio = "Not at all important" if welprio == "Zcela nedůležité"
replace welprio = "Don't know" if welprio == "Nevím"
replace welprio = "Extremely important" if welprio == "Extrémně důležité"
replace welprio = "Very important" if welprio == "Velmi důležité"
replace welprio = "Not very important" if welprio == "Nepříliš důležité"
replace welprio = "Moderately important" if welprio == "Středně důležité"
replace unionprio = "Not at all important" if unionprio == "Zcela nedůležité"
replace unionprio = "Don't know" if unionprio == "Nevím"
replace unionprio = "Extremely important" if unionprio == "Extrémně důležité"
replace unionprio = "Very important" if unionprio == "Velmi důležité"
replace unionprio = "Not very important" if unionprio == "Nepříliš důležité"
replace unionprio = "Moderately important" if unionprio == "Středně důležité"
replace immiprio = "Not at all important" if immiprio == "Zcela nedůležité"
replace immiprio = "Don't know" if immiprio == "Nevím"
replace immiprio = "Extremely important" if immiprio == "Extrémně důležité"
replace immiprio = "Very important" if immiprio == "Velmi důležité"
replace immiprio = "Not very important" if immiprio == "Nepříliš důležité"
replace immiprio = "Moderately important" if immiprio == "Středně důležité"
replace pid = "I identify with a party not listed here" if pid == "Identifikuji se s politickou stranou, která zde není uvedena" 
replace pid = "Don't know" if pid == "Nevím"
replace pid = "I do not identify with any party" if pid == "Neidentifikuji se s žádnou politickou stranou"
replace Čssd = "Dislike a great deal" if Čssd == "Velmi se mi nelíbí"
replace Čssd = "Like a great deal" if Čssd == "Velmi se mi líbí"
replace Čssd = "Don't know" if Čssd == "Nevím"
replace Čssd = "Dislike somewhat" if Čssd == "Trochu se mi nelíbí"
replace Čssd = "Like somewhat" if Čssd == "Trochu se mi líbí"
replace Čssd = "Neither like nor dislike" if Čssd == "Mám neutrální názor"
replace Ods = "Dislike a great deal" if Ods == "Velmi se mi nelíbí"
replace Ods = "Like a great deal" if Ods == "Velmi se mi líbí"
replace Ods = "Don't know" if Ods == "Nevím"
replace Ods = "Dislike somewhat" if Ods == "Trochu se mi nelíbí"
replace Ods = "Like somewhat" if Ods == "Trochu se mi líbí"
replace Ods = "Neither like nor dislike" if Ods == "Mám neutrální názor"
replace Ano = "Dislike a great deal" if Ano == "Velmi se mi nelíbí"
replace Ano = "Like a great deal" if Ano == "Velmi se mi líbí"
replace Ano = "Don't know" if Ano == "Nevím"
replace Ano = "Dislike somewhat" if Ano == "Trochu se mi nelíbí"
replace Ano = "Like somewhat" if Ano == "Trochu se mi líbí"
replace Ano = "Neither like nor dislike" if Ano == "Mám neutrální názor"
replace mcheck = "Democracy is neither robust nor vulnerable in the Czech Republic" if mcheck == "Demokracie v České republice není stabilní ani zranitelná"
replace mcheck = "Democracy is quite robust in the Czech Republic" if mcheck == "Demokracie v České republice je docela stabilní"
replace mcheck = "Democracy is quite vulnerable in the Czech Republic" if mcheck == "Demokracie v České republice je docela zranitelná"
replace mcheck = "Democracy is very robust in the Czech Republic" if mcheck == "Demokracie v České republice je velmi stabilní"
replace mcheck = "Democracy is very vulnerable in the Czech Republic" if mcheck == "Demokracie v České republice je velmi zranitelná"
replace mcheck = "Don't know" if mcheck == "Nevím"
replace attention = "The piece of text did not mention any predictions" if attention == "Text neobsahoval žádné předpovědi"
replace attention = "Don't know" if attention == "Nevím"
replace attention = "I have not been presented for a piece of text about the current state of democracy around the world" if attention == "Žádný text o současném stavu demokracie ve světě mi nebyl předložen"
replace attention = "That many democratic breakdowns will occur during this decade" if attention == "Že se během tohoto desetiletí zhroutí mnoho demokracií"
replace attention = "That no or only very few democratic breakdowns will occur during this decade" if attention == "Že se během tohoto desetiletí nezhroutí žádná demokracie nebo že se jich zhroutí jen velmi málo"
replace device = "Prefer not to answer" if device == "Nepřeji si odpovědět"
replace device = "Other" if device == "Jiné"
replace device = "PC or Macbook" if device == "PC nebo Macbook"
replace answ = "Very unlikely" if answ == "Velmi nepravděpodobné"
replace answ = "Very likely" if answ == "Velmi pravděpodobné"
replace answ = "Don't know" if answ == "Nevím"
replace answ = "Somewhat unlikely" if answ == "Spíše nepravděpodobné"
replace answ = "Somewhat likely" if answ == "Spíše pravděpodobné"
replace answ = "Neither likely nor unlikely" if answ == "Mám neutrální názor"
replace dem = "Said it is unacceptable to harass journalists even though they do not reveal sources" if dem == "Řekl/a, že je nepřijatelné pronásledovat novináře, i když neprozradí své zdroje"
replace dem = "Said it is legitimate to fight political opponents in the streets if one feels provoked" if dem == "Řekl/a, že je přijatelné bojovat s politickými oponenty v ulicích, pokud je člověk vyprovokován"
replace dem = "Said it is unacceptable to fight political opponents in the streets even though one feels provoked" if dem == "Řekl/a, že je nepřijatelné bojovat s politickými oponenty v ulicích, i pokud je člověk  vyprovokován"
replace dem = "Said court rulings by judges appointed by opposing parties should be ignored" if dem == "Řekl/a, že rozsudky soudců jmenovaných opozičními stranami by měly být ignorovány"
replace dem = "Said court rulings by judges appointed by opposing parties should be adhered to" if dem == "Řekl/a, že rozsudky soudců jmenovaných opozičními stranami by měly být dodržovány"
replace dem = "Supported a proposal to reduce polling stations in areas that support opposing parties" if dem == "Podporoval/a návrh na omezení počtu volebních místností v oblastech, které podporují opoziční strany"
replace dem = "Supported a proposal to preserve existing polling-stations in all areas" if dem == "Podporoval/a návrh na zachování existujících volebních místností ve všech oblastech"
replace dem = "Said it is acceptable to harass journalists that do not reveal sources" if dem == "Řekl/a, že je přijatelné pronásledovat novináře, kteří neprozradí své zdroje"
replace gender = "Male" if gender == "Muž"
replace gender = "Female" if gender == "Žena"
replace background = "Actor/actress" if background == "Herec/herečka"
replace background = "Professor" if background == "Profesor/ka"
replace background = "Journalist" if background == "Novinář/ka"
replace background = "Political Career" if background == "Politická kariéra"
replace redi = "Decrease power of labor unions" if redi == "Snížit moc odborů"
replace redi = "Increase power of labor unions" if redi == "Zvýšit moc odborů"
replace redi = "Decrease public welfare spending" if redi == "Snížit výdaje na sociální zabezpečení"
replace redi = "Increase public welfare spending" if redi == "Zvýšit výdaje na sociální zabezpečení"
replace redi = "Decrease income tax on 10 percent richest" if redi == "Snížit daň z příjmu u 10 procent nejbohatších"
replace redi = "Increase income tax on 10 percent richest" if redi == "Zvýšit daň z příjmu u 10 procent nejbohatších"
replace soc = "Allow illegal immigrants to apply for citizenship" if soc == "Umožnit nelegálním přistěhovalcům žádat o české občanství"
replace soc = "Increase efforts to arrest and eventually deport illegal immigrants" if soc == "Zvýšit snahu zatýkat a nakonec deportovat nelegální přistěhovalce"
replace soc = "Make it harder for women to get an abortion" if soc == "Ztížit ženám jít na potrat"
replace soc = "Make it easier for women to get an abortion" if soc == "Usnadnit ženám jít na potrat"
replace soc = "Make it harder for people of the same sex to marry each other" if soc == "Ztížit sňatek lidem stejného pohlaví"
replace soc = "Make it easier for people of the same sex to marry each other" if soc == "Usnadnit sňatek lidem stejného pohlaví"
replace eco = "Bad at handling economic matters" if eco == "Špatně zvládá ekonomické záležitosti"
replace eco = "Neither good nor bad reputation on economic matters" if eco == "Ohledně ekonomických záležitostí nemá dobrou ani špatnou pověst"
replace eco = "Good at handling economic matters" if eco == "Dobře zvládá ekonomické záležitosti"
replace cor = "Bad at fighting corruption" if cor == "Špatně bojuje s korupcí"
replace cor = "Neither good nor bad reputation on fighting corruption" if cor == "Ohledně boje s korupcí nemá ani dobrou ani špatnou pověst"
replace cor = "Good at fighting corruption" if cor == "Dobře bojuje s korupcí"

***Recoding
**Candidate attributes
clonevar canage = age
encode gender, gen(cangender)
encode background, gen(canbackground)
encode party, gen(canparty)
encode redi, gen(canredi)
recode canredi (1 = 0 "Decrease income tax on 10 percent richest") (4 = 1 "Increase income tax on 10 percent richest") (else=.), gen(cantax)
recode canredi (2 = 0 "Decrease power of labor unions") (5 = 1 "Increase power of labor unions") (else=.), gen(canunion)
recode canredi (3 = 0 "Decrease public welfare spending") (6 = 1 "Increase public welfare spending") (else=.), gen(canwel)
encode soc, gen(cansoc)
recode cansoc (1 = 1 "Allow illegal immigrants to apply for citizenship") (2 = 0 "Increase efforts to arrest and eventually deport illegal immigrants") (else=.), gen(canimmi)
recode cansoc (3 = 1 "Make it easier for people of the same sex to marry each other") (5 = 0 "Make it harder for people of the same sex to marry each other") (else=.), gen(canss)
recode cansoc (4 = 1 "Make it easier for women to get an abortion") (6 = 0 "Make it harder for women to get an abortion") (else=.), gen(canabort)
encode dem, gen(candem)
recode candem (1 5 6 7 = 0 "Democratic") (2 3 4 8 = 1 "Undemocratic"), gen(candemmg) //Making one variable where all undemocratic positions are merged
encode eco, gen(canec)
recode canec (1 = 1 "Bad at handling economic matters") (2 = 3 "Good at handling economic matters") (3 = 2 "Neither good nor bad reputation on economic matters"), gen(caneco)
encode cor, gen(canco)
recode canco (1 = 1 "Bad at fighting corruption") (2 = 3 "Good at fighting corruption") (3 = 2 "Neither good nor bad reputation on fighting corruption"), gen(cancor)
gen cancom = (caneco + cancor)-1
label define competence 1 "Very incompetent" 2 "Moderately incompetent" 3 "Neither competent nor incompetent" 4 "Moderately competent" 5 "Very competent"
label values cancom competence

**Respondent attributes
*Background vars
encode region, gen(regionres)
encode urban, gen(urbanres)
recode urbanres (3 = 1 "Rural County") (2 = 3 "Metropolis") (1 = 2 "Medium-size or small city"), gen(urbanr)
drop urbanres
encode genderres, gen(genderr)
encode edures, gen(edur)
recode edur (2 = 2 "High school") (1 = 1 "Less than high school") (3 = 3 "More than high school"), gen(edurr)
drop edur

**Preference extremity vars
encode abortion, gen(abortionpre)
encode tax, gen(taxpre)
encode samesex, gen(samesexpre)
encode welfare, gen(welfarepre)
encode unions, gen(unionspre)
encode immi, gen(immipre)
encode demfra, gen(demfrapre)
recode abortionpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(abrpre)
recode taxpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(taxrpre)
recode samesexpre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(samerpre)
recode welfarepre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(welrpre)
recode unionspre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(uniorpre)
recode immipre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(immirpre)
recode demfrapre (1=.) (2 = 3 "Neither agree nor disagree") (3 = 4 "Somewhat agree") (4 = 2 "Somewhat disagree") (5 = 5 "Strongly agree") (6 = 1 "Strongly disagree"), gen(demfrpre)
drop abortionpre-demfrapre

*"Extremety on candidate-assigned attributes". Matextax is, for example, the respondent's preference on tax IF the candidate was assigned a tax position. Flips abortion, welfare, unions, and immigration so that low values are extreme left and high values are extreme right.
label define extreme 1 "Extreme left" 2 "Moderate Left" 3 "Center" 4 "Moderate Right" 5 "Extreme Right"
recode abrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeab)
recode welrpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremewel)
recode immirpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeimmi)
recode uniorpre (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(extremeunion)
clonevar extremetax = taxrpre
clonevar extremess = samerpre
gen matextax = extremetax if cantax != .
gen matexwel = extremewel if canwel != .
gen matexunion = extremeunion if canunion != .
gen matexredi = .
replace matexredi = matextax if matextax != .
replace matexredi = matexwel if matexwel != .
replace matexredi = matexunion if matexunion != .
gen mateximmi = extremeimmi if canimmi != .
gen matexabo = extremeab if canabort != .
gen matexss = extremess if canss != .
gen matexsoc = .
replace matexsoc = mateximmi if mateximmi != .
replace matexsoc = matexabo if matexabo != .
replace matexsoc = matexss if matexss != .
label values matexsoc mateximmi matexredi matextax matexunion matexwel matexabo matexss extremetax extremess extremeab extremewel extremeunion extremeimmi extreme

**Policy distance between candidate and respondent
*Main measure
recode cantax (0 = 4.5) (1 = 1.5), gen(cantaxm)
recode canunion (0 = 4.5) (1 = 1.5), gen(canunionm)
recode canwel (0 = 4.5) (1 = 1.5), gen(canwelm)
gen canredim = .
replace canredim = cantaxm if cantaxm != .
replace canredim = canunionm if canunionm != .
replace canredim = canwelm if canwelm != .

recode canimmi (0 = 4.5) (1 = 1.5), gen(canimmim)
recode canss (0 = 4.5) (1 = 1.5), gen(canssm)
recode canabort (0 = 4.5) (1 = 1.5), gen(canabortm)
gen cansocm = .
replace cansocm = canimmim if canimmim != .
replace cansocm = canssm if canssm != .
replace cansocm = canabortm if canabortm != .

gen distaxm = matextax-cantaxm
gen disunionm = matexunion-canunionm
gen diswelm = matexwel-canwelm 
gen disredim = matexredi-canredim

gen disimmim = mateximmi-canimmim
gen disssm = matexss-canssm
gen disabom = matexabo-canabortm
gen dissocm = matexsoc-cansocm

gen dissumm = sqrt(disredim^2) + sqrt(dissocm^2)
label define distancem 1 "Completely Aligned Positions" 7 "Completely Diverting Positions"
label values dissumm distancem

*Supplementary measures
recode cantax (0 = 5) (1 = 1), gen(cantaxs1)
recode canunion (0 = 5) (1 = 1), gen(canunions1)
recode canwel (0 = 5) (1 = 1), gen(canwels1)
gen canredis1 = .
replace canredis1 = cantaxs1 if cantaxs1 != .
replace canredis1 = canunions1 if canunions1 != .
replace canredis1 = canwels1 if canwels1 != .

recode canimmi (0 = 5) (1 = 1), gen(canimmis1)
recode canss (0 = 5) (1 = 1), gen(cansss1)
recode canabort (0 = 5) (1 = 1), gen(canaborts1)
gen cansocs1 = .
replace cansocs1 = canimmis1 if canimmis1 != .
replace cansocs1 = cansss1 if cansss1 != .
replace cansocs1 = canaborts1 if canaborts1 != .

gen distaxs1 = matextax-cantaxs1
gen disunions1 = matexunion-canunions1
gen diswels1 = matexwel-canwels1 
gen disredis1 = matexredi-canredis1

gen disimmis1 = mateximmi-canimmis1
gen dissss1 = matexss-cansss1
gen disabos1 = matexabo-canaborts1
gen dissocs1 = matexsoc-cansocs1

gen dissums1 = sqrt(disredis1^2) + sqrt(dissocs1^2)
label define distances1 0 "Completely Aligned Positions" 8 "Completely Diverting Positions"
label values dissums1 distances1

recode cantax (0 = 4) (1 = 2), gen(cantaxs2)
recode canunion (0 = 4) (1 = 2), gen(canunions2)
recode canwel (0 = 4) (1 = 2), gen(canwels2)
gen canredis2 = .
replace canredis2 = cantaxs2 if cantaxs2 != .
replace canredis2 = canunions2 if canunions2 != .
replace canredis2 = canwels2 if canwels2 != .

recode canimmi (0 = 4) (1 = 2), gen(canimmis2)
recode canss (0 = 4) (1 = 2), gen(cansss2)
recode canabort (0 = 4) (1 = 2), gen(canaborts2)
gen cansocs2 = .
replace cansocs2 = canimmis2 if canimmis2 != .
replace cansocs2 = cansss2 if cansss2 != .
replace cansocs2 = canaborts2 if canaborts2 != .

gen distaxs2 = matextax-cantaxs2
gen disunions2 = matexunion-canunions2
gen diswels2 = matexwel-canwels2
gen disredis2 = matexredi-canredis2

gen disarms2 = mateximmi-canimmis2
gen dissss2 = matexss-cansss2
gen disabos2 = matexabo-canaborts2
gen dissocs2 = matexsoc-cansocs2

gen dissums2 = sqrt(disredis2^2) + sqrt(dissocs2^2)
label define distances2 0 "Completely Aligned Positions" 6 "Completely Diverting Positions"
label values dissums2 distances2

**Preference intensity vars (respondent)
encode aboprio, gen(abortionpri)
encode taxprio, gen(taxpri)
encode samesexprio, gen(samesexpri)
encode welprio, gen(welfarepri)
encode unionprio, gen(unionspri)
encode immiprio, gen(immipri)
recode abortionpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(abrpri)
recode taxpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(taxrpri)
recode samesexpri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(samerpri)
recode welfarepri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(welrpri)
recode unionspri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(uniorpri)
recode immipri (1=.) (2 = 5 "Extremely important") (3 = 3 "Moderately important") (4 = 1 "Not at all important") (5 = 2 "Not very important") (6 = 4 "Very important"), gen(immirpri)
drop abortionpri-immipri


*"Intensity on candidate-assigned attributes". Matintax is, for example, the respondent's intensity on tax IF the candidate was assigned a tax position
label define intensity 1 "Very Low Intensity" 2 "Low Intensity" 3 "Moderate Intensity" 4 "High Intensity" 5 "Very High Intensity"
gen matintax = taxrpri if cantax != .
gen matinwel = welrpri if canwel != .
gen matinunion = uniorpri if canunion != .
gen matinredi = .
replace matinredi = matintax if matintax != .
replace matinredi = matinwel if matinwel != .
replace matinredi = matinunion if matinunion != .
gen matinimmi = immirpri if canimmi != .
gen matinabo = abrpri if canabort != .
gen matinss = samerpri if canss != .
gen matinsoc = .
replace matinsoc = matinimmi if matinimmi != .
replace matinsoc = matinabo if matinabo != .
replace matinsoc = matinss if matinss != .
label values matintax matinwel matinunion matinredi matinimmi matinabo matinss matinsoc intensity

*Intensity in favor of or against candidate: used for analysis
gen abodir = . 
replace abodir = -1 if extremeab < 3 & canabort == 0
replace abodir = -1 if extremeab > 3 & canabort == 1
replace abodir = -0.5 if extremeab == 3 & canabort !=.
replace abodir = 1 if extremeab < 3 & canabort == 1
replace abodir = 1 if extremeab > 3 & canabort == 0
gen aboint = abodir*abrpri

gen taxdir = . 
replace taxdir = -1 if extremetax < 3 & cantax == 0
replace taxdir = -1 if extremetax > 3 & cantax == 1
replace taxdir = -0.5 if extremetax == 3 & cantax !=.
replace taxdir = 1 if extremetax < 3 & cantax == 1
replace taxdir = 1 if extremetax > 3 & cantax == 0
gen taxint = taxdir*taxrpri

gen ssdir = . 
replace ssdir = -1 if extremess < 3 & canss == 0
replace ssdir = -1 if extremess > 3 & canss == 1
replace ssdir = -0.5 if extremess == 3 & canss !=.
replace ssdir = 1 if extremess < 3 & canss == 1
replace ssdir = 1 if extremess > 3 & canss == 0
gen ssint = ssdir*samerpri

gen weldir = . 
replace weldir = -1 if extremewel < 3 & canwel == 0
replace weldir = -1 if extremewel > 3 & canwel == 1
replace weldir = -0.5 if extremewel == 3 & canwel !=.
replace weldir = 1 if extremewel < 3 & canwel == 1
replace weldir = 1 if extremewel > 3 & canwel == 0
gen welint = weldir*welrpri

gen uniondir = . 
replace uniondir = -1 if extremeunion < 3 & canunion == 0
replace uniondir = -1 if extremeunion > 3 & canunion == 1
replace uniondir = -0.5 if extremeunion == 3 & canunion !=.
replace uniondir = 1 if extremeunion < 3 & canunion == 1
replace uniondir = 1 if extremeunion > 3 & canunion == 0
gen unionint = uniondir*uniorpri

gen immidir = . 
replace immidir = -1 if extremeimmi < 3 & canimmi == 0
replace immidir = -1 if extremeimmi > 3 & canimmi == 1
replace immidir = -0.5 if extremeimmi == 3 & canimmi !=.
replace immidir = 1 if extremeimmi < 3 & canimmi == 1
replace immidir = 1 if extremeimmi > 3 & canimmi == 0
gen immiint = immidir*immirpri

gen rediint =.
replace rediint = unionint if unionint != .
replace rediint = welint if welint != .
replace rediint = taxint if taxint != .

gen socint =.
replace socint = immiint if immiint != .
replace socint = ssint if ssint != .
replace socint = aboint if aboint != .

label define intensityfa -5 "Intense Opinion Against Candidate" -1 "Mild Opinion Against Candidate" 1 "Mild Opinion in Favor of Candidate" 5 "Intense Opinion in Favor of Candidate"
label values aboint taxint ssint rediint welint unionint immiint socint intensityfa


**Party ID
encode pid, gen(partyid)
recode partyid (2 =.)
drop pid
encode Čssd, gen(ČSSDx)
encode Ods, gen(ODSx)
encode Ano, gen(ANOx)
recode ČSSDx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(ČSSD)
recode ODSx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(ODS)
recode ANOx (1 = 1 "Dislike a great deal") (2 = 2 "Dislike somewhat") (3=.) (4 = 5 "Like a great deal") (5 = 4 "Like somewhat") (6 = 3 "Neither like nor dislike"), gen(ANO)
drop ČSSDx ODSx ANOx
gen partymmain = .
replace partymmain = ČSSD if canparty == 3
replace partymmain = ODS if canparty == 2
replace partymmain = ANO if canparty == 1
label define conparty 1 "Dislike candidate's party a great deal" 2 "Dislike candidate's party somewhat" 3 "Neither like nor dislike candidate's party" 4 "Like candidate's party somewhat" 5 "Like candidate's party a great deal"
label values partymmain conparty
recode partyid (3 = 0 "No Party ID") (2=.) (1 4 5 6 7 8 9 10 11 = 1 "Any Party ID"), gen(anyparty)
recode partyid (1 7 10 = 1 "ČSSD/ODS/ANO") (2=.) (3 4 5 6 8 9 11 = 0 "Not ČSSD/ODS/ANO"), gen(anyinparty)
gen copartisansplit = .
replace copartisansplit = 0 if anyinparty == 0
replace copartisansplit = 1 if partyid == 1 & canparty == 1
replace copartisansplit = 2 if partyid == 7 & canparty == 2
replace copartisansplit = 3 if partyid == 10 & canparty == 3
replace copartisansplit = 4 if partyid == 1 & canparty == 2
replace copartisansplit = 5 if partyid == 7 & canparty == 1
replace copartisansplit = 6 if partyid == 10 & canparty == 1
replace copartisansplit = 7 if partyid == 10 & canparty == 2
replace copartisansplit = 8 if partyid == 1 & canparty == 3
replace copartisansplit = 9 if partyid == 7 & canparty == 3
label define copartisansplit 0 "Neither Copartisanship nor Opposing Partisanship" 1 "Copartisanship: ANO" 2 "Copartisanship: OSD" 3 "Copartisanship: ČSSD" 4 "Voter: ANO, Candidate: OSD" 5 "Voter: OSD, Candidate: ANO" 6 "Voter: ČSSD, Candidate: ANO" 7 "Voter: ČSSD, Candidate: OSD" 8 "Voter: ANO, Candidate: ČSSD" 9 "Voter: OSD, Candidate: ČSSD"
label values copartisansplit copartisansplit
recode copartisansplit (0 = 0 "Neither Copartisanship nor Opposing Partisanship") (1 2 3 = 1 "Copartisanship") (4 5 6 7 8 9 = 2 "Opposing Partisanship"), gen(copartisanmerge)


**Manipulation and attention check
encode mcheck, gen(mcheck1)
recode mcheck1 (1 = 3 "Democracy is neither robust nor vulnerable in the Czech Republic") (2 = 4 "Democracy is quite robust in the Czech Republic") (3 = 2 "Democracy is quite vulnerable in the Czech Republic") (4 = 5 "Democracy is very robust in the Czech Republic") (5 = 1 "Democracy is very vulnerable in the Czech Republic") (6=.), gen(manipulation)
drop mcheck1
encode attention, gen(atte)
recode atte (1=5 "Don't know") (2 = 4 "I have not been presented for a piece of text about the current state of democracy around the world") (3 = 2 "That many democratic breakdowns will occur during this decade") (4 = 1 "That no or only very few democratic breakdowns will occur during this decade") (5 = 3 "The piece of text did not mention any predictions"), gen(attent) //NB: Numbers may be wrong; check twice when data is in
drop atte

**Outcome
encode answ, gen(answer)
recode answer (1=.) (2 = 3 "Neither likely nor unlikely") (3 = 4 "Somewhat likely") (4 = 2 "Somewhat unlikely") (5 = 5 "Very likely") (6 = 1 "Very unlikely"), gen(support)
drop answer

**Treatment
encode treat, gen(treat1)
recode treat1 (1 = 0 "Robust") (2=1 "Vulnerable"), gen(treatment)
drop treat1
*Did the treatment work (i.e., did it affect perceived democratic vulnerability)? And does it work best with or without providing a democracy definition just before assigning the treatment?
reg manipulation i.treatment, cluster(respondentid) //clustering added
*Were the respondents attentive?
gen correctatte = .
replace correctatte = 0 if attent == 5
replace correctatte = 0 if attent == 4
replace correctatte = 0 if attent == 3
replace correctatte = 0 if attent == 2 & treatment == 0
replace correctatte = 0 if attent == 1 & treatment == 1
replace correctatte = 1 if attent == 1 & treatment == 0
replace correctatte = 1 if attent == 2 & treatment == 1
label define correct 0 "Inattentive" 1 "Attentive"
label values correctatte correct
sum correctatte

*Creating numerical variables identifying task and candidate number
generate task =.
replace task = 1 if candidate == "_1" | candidate == "_2"
replace task = 2 if candidate == "_3" | candidate == "_4"
replace task = 3 if candidate == "_5" | candidate == "_6"
replace task = 4 if candidate == "_7" | candidate == "_8"
replace task = 5 if candidate == "_9" | candidate == "_10"
replace task = 6 if candidate == "_11" | candidate == "_12"
replace task = 7 if candidate == "_13" | candidate == "_14"
replace task = 8 if candidate == "_15" | candidate == "_16"
replace task = 9 if candidate == "_17" | candidate == "_18"
replace task = 10 if candidate == "_19" | candidate == "_20"
generate candid =.
replace candid = 1 if candidate == "_1"
replace candid = 2 if candidate == "_2"
replace candid = 3 if candidate == "_3"
replace candid = 4 if candidate == "_4"
replace candid = 5 if candidate == "_5"
replace candid = 6 if candidate == "_6"
replace candid = 7 if candidate == "_7"
replace candid = 8 if candidate == "_8"
replace candid = 9 if candidate == "_9"
replace candid = 10 if candidate == "_10"
replace candid = 11 if candidate == "_11"
replace candid = 12 if candidate == "_12"
replace candid = 13 if candidate == "_13"
replace candid = 14 if candidate == "_14"
replace candid = 15 if candidate == "_15"
replace candid = 16 if candidate == "_16"
replace candid = 17 if candidate == "_17"
replace candid = 18 if candidate == "_18"
replace candid = 19 if candidate == "_19"
replace candid = 20 if candidate == "_20"

**Drop respondents with missing values on variables used for key tests
reg partymmain dissumm matexredi matexsoc rediint socint support
gen sample1 = e(sample)


*****APPENDING*****
append using "U:\How to Save a Democracy\Data\ukfinal.dta"
append using "U:\How to Save a Democracy\Data\usfinal.dta"
append using "U:\How to Save a Democracy\Data\mxfinal.dta"
append using "U:\How to Save a Democracy\Data\skfinal.dta"
**Tie variables

gen start = .
replace start =candemmg[_n+11] if candidate == "_1"
replace start =candemmg[_n-11] if candidate == "_2"
replace start =candemmg[_n+1] if candidate == "_3"
replace start =candemmg[_n-1] if candidate == "_4"
replace start =candemmg[_n+1] if candidate == "_5"
replace start =candemmg[_n-1] if candidate == "_6"
replace start =candemmg[_n+1] if candidate == "_7"
replace start =candemmg[_n-1] if candidate == "_8"
replace start =candemmg[_n-18] if candidate == "_9"
replace start =candemmg[_n+18] if candidate == "_10"
replace start =candemmg[_n+1] if candidate == "_11"
replace start =candemmg[_n-1] if candidate == "_12"
replace start =candemmg[_n+1] if candidate == "_13"
replace start =candemmg[_n-1] if candidate == "_14"
replace start =candemmg[_n+1] if candidate == "_15"
replace start =candemmg[_n-1] if candidate == "_16"
replace start =candemmg[_n+1] if candidate == "_17"
replace start =candemmg[_n-1] if candidate == "_18"
replace start =candemmg[_n+2] if candidate == "_19"
replace start =candemmg[_n-2] if candidate == "_20"

gen tie = .
replace tie = 0 if start == 0 & candemmg == 0
replace tie = 1 if start == 1 & candemmg == 0
replace tie = 1 if start == 0 & candemmg == 1
replace tie = 2 if start == 1 & candemmg == 1
label define tie 0 "D+ vs. D+" 1 "D- vs. D+" 2 "D- vs. D-"
label values tie tie
save "U:\How to Save a Democracy\Data\appendedfinal.dta", replace