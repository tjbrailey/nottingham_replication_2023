library(cjpowR)
##Power
#Avg. effects of undemocratic behavior (CZ)
cjpowr_amce(amce=0.013, n = 47221, levels = 2, alpha=0.05)
#Avg. effects of competence (CZ)
cjpowr_amce(amce=0.021, n = 47221, levels = 5, alpha=0.05)
#Interaction (CZ)
cjpowr_amcie(delta1 = 0, delta2 = 0, delta3 = 0.041, levels1=2, levels2=5, n = 47221)

#Avg. effects of undemocratic behavior (Pooled)
cjpowr_amce(amce=0.006, n = 267795, levels = 2, alpha=0.05)
#Avg. effects of competence (Pooled)
cjpowr_amce(amce=0.009, n = 267795, levels = 5, alpha=0.05)
#Interaction (Pooled)
cjpowr_amcie(delta1 = 0, delta2 = 0, delta3 = 0.018, levels1=2, levels2=5, n = 267795)
cjpowr_amcie(delta1 = 0, delta2 = 0, delta3 = 0.028, levels1=2, levels2=5, n = 267795)


##Error and exaggeration rates
#Avg. effects of undemocratic behavior (CZ)
cjpowr_amce(amce=0.04, n = 47221, levels = 2, alpha=0.05)
#Avg. effects of competence (CZ)
cjpowr_amce(amce=0.035, n = 47221, levels = 5, alpha=0.05)
#Interaction (CZ)
cjpowr_amcie(delta1 = 0, delta2 = 0, delta3 = 0.0325, levels1=2, levels2=5, n = 47221)