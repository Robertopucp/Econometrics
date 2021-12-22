*************************************************** Solucionario del libro Econometría 1 *********************************
*************************************************** Profesor: Luis García Nuñez ********************************************************************
clear all
set more off

******************************************* CAPITULO 3 *****************************************
*******************************************             *****************************************

// Ejercicio 7

import excel "C:\Users\Roberto Carlos\Desktop\Ciclo-2020-2\JP\capitulo_3.xlsx", sheet("Hoja1") firstrow

* a)

gen lngsp_per = lngsp - lnemp

gen lcapital_per = lcapital - lnemp

regress lngsp_per lcapital_per 

// El incremento en 1% del capital percapita incrementa en 0.17% el producto percapita 

*b)

matrix var_b = e(V)
matrix list var_b

scalar linf = 0.1733283 - invt(14,0.95)*var_b[1,1]^(1/2)
scalar lsup = 0.1733283 + invt(14,0.95)*var_b[1,1]^(1/2)
scalar list linf lsup


******************************************* CAPITULO 4 *****************************************
*******************************************             *****************************************

** Ejercicio 3

// a)
matrix Ay = (-0.2\-1.2\2.8\0.8\-2.2)

matrix AX2 = (-1.6,-0.8\1.4,2.2\-0.6,3.2\-1.6,-1.8\2.4,-2.8)

matrix list AX2

matrix b2 = invsym(AX2'*AX2)*AX2'*Ay

matrix list b2



// b)

matrix SCR = Ay'*Ay-b2'*AX2'*AX2*b2
matrix list SCR

matrix SCE = b2'*AX2'*AX2*b2
matrix list SCE

// c)
scalar s2 = SCR[1,1]/2
scalar list s2

matrix var_b2 = s2*invsym(AX2'*AX2)
matrix list var_b2

clear all

** Ejercicio 4

// Incluye intercepto

matrix Y = (7\3\8\3\5\1)
matrix X2 = (6\3\5\2\4\1)
matrix X3 = (8\5\6\4\6\4)
matrix mu = J(6,1,1)

matrix X = (mu,X2,X3)

matrix b = invsym(X'*X)*X'*Y

matrix A = I(6)-mu*mu'/6

matrix SCR1 = (Y-X*b)'*(Y-X*b)
matrix list SCR1
matrix SCT1 = (A*Y)'*A*Y

scalar R2_1 = 1-SCR1[1,1]/SCT1[1,1]
scalar list R2_1
// No incluye intercepto sino el modelo en desviaciones 

matrix X_1 = (X2,X3)
matrix Y1 = A*Y
matrix X1 = A*X_1

matrix b2 = invsym(X1'*X1)*X1'*Y1

matrix SCR2 = Y1'*Y1-b2'*X1'*X1*b2

matrix SCT2 = Y1'*Y1

scalar R2_2 = 1-SCR2[1,1]/SCT2[1,1]
scalar list R2_1 R2_2 
matrix list SCR1 
matrix list SCR2 

clear all
** Ejercicio 5
// a)

scalar C = 8*7-(12+8+9+4+6+7)
scalar list C
scalar B = (7+1+5+8+6+6+9)/7
scalar list B
matrix mu = J(7,1,1)
matrix A = I(7)-mu*mu'/7

 matrix X2 = (12,7\8,1\9,5\10,8\4,6\6,6\7,9)
 matrix X = (mu,X2)

 matrix AX2 = A*X2
 matrix list AX2

 matrix m1 = AX2'*AX2
 matrix list m1
 
 matrix m2 = X'*X
 matrix list m2

scalar H = 12*7-(14+8+7+14+19+9)
scalar list H
matrix Y = (14,8,7,13,14,19,9)'
matrix list Y

// b)

matrix b = invsym(X'*X)*X'*Y
matrix list b

// c)
matrix SCR = (Y-X*b)'*(Y-X*b)
matrix list SCR
matrix SCT = (A*Y)'*A*Y
matrix list SCT
matrix SCE = SCT-SCR
matrix list SCE
// d)

scalar R2 = 1-SCR[1,1]/SCT[1,1]
scalar R2_aj = 1-(SCR[1,1]/SCT[1,1])*(6/4)
scalar list R2
scalar list R2_aj

scalar AIC = ln(SCR[1,1]/7)+2*3/7
scalar BIC = ln(SCR[1,1]/7)+(3/7)*ln(7)
scalar list AIC BIC

// e)

scalar s2 = SCR[1,1]/4
scalar list s2
matrix var_b = s2*invsym(X'*X)
matrix list var_b

clear all
*** Pregunta 6 ****

matrix Y = (7.5,9,12,16,20,25)'
matrix mu = J(6,1,1)
matrix X1 = (2,3,3.5,3,3.25,4\6,9,12,18,24,30)'
matrix X = (mu,X1)
matrix list X
matrix A = I(6)-mu*mu'/6

// a)

matrix m1 = X'*X
matrix list m1

matrix m2 = X'*Y
matrix list m2 


matrix b = invsym(X'*X)*X'*Y
matrix list b
matrix SCR = (Y-X*b)'*(Y-X*b)
scalar s2 = SCR[1,1]/3
scalar list s2
matrix sd = s2*invsym(X'*X)
scalar sd1 = (sd[1,1])^(1/2)
scalar sd2 = (sd[2,2])^(1/2)
scalar sd3 = (sd[3,3])^(1/2)
scalar list sd1 sd2 sd3

scalar tb1 = b[1,1]/sd1
scalar tb2 = b[2,1]/sd2
scalar tb3 = b[3,1]/sd3
scalar list tb1 tb2 tb3

matrix SCT = (A*Y)'*A*Y

scalar R2 = 1-SCR[1,1]/SCT[1,1]
scalar R2_aj = 1-SCR[1,1]/SCT[1,1]*(5/3)

scalar AIC = ln(SCR[1,1]/6)+2*3/6
scalar BIC = ln(SCR[1,1]/6)+(3/6)*ln(6)
scalar list R2 R2_aj AIC BIC

*** Pregunta 10

use auto.dta

scalar AIC = ln(414340116/74)+2*3/74
scalar BIC = ln(414340116/74)+3/74*ln(74)
scalar list AIC BIC

scalar s2_1 = 414340116/71
scalar s2_2 = 407697222/69
scalar list s2_1 s2_2

reg price weight length mpg trunk

************************************************************ CAPITULO 5 *********************************************************************
*********************************************************************************************************************************************
clear all
// Pregunta 1
// dos  restricciones y los gradios de libertad n-k = 7-3=4
matrix X2 = (3,5,2,4,1,1,3)'
matrix X3 = (5,6,4,6,4,2,1)'
matrix Y = (3,8,3,5,1,2,1)'
matrix X = (J(7,1,1),X2,X3)

matrix b1 = invsym(X'*X)*X'*Y
matrix list b1

matrix e_2 = (Y-X*b1)'*(Y-X*b1)
matrix list e_2
* Caso a)
scalar q1 = 2
scalar g = 4

matrix b = (-1.5789474,0.96491228,0.56140351)'
matrix list b
matrix XX_1 = invsym(X'*X)
matrix list XX_1

// Matrix R 
 matrix R1 = (0,1,0\0,0,1)
 matrix list R1
// vector columna r

matrix r1 = (0,0)'

matrix F1 = ((R1*b-r1)'*inv(R1*XX_1*R1')*(R1*b-r1)/q1)/(7.1578947/g)
matrix list F1

** Caso b)
// una restricción 
scalar q2 = 1
matrix R2 = (0,1,0)
matrix r2 = (0)

matrix F2 = ((R2*b-r2)'*inv(R2*XX_1*R2')*(R2*b-r2)/q2)/(7.1578947/g)
matrix list F2

**Caso c)

scalar q3 = 1
matrix R3 = (0,1,1)
matrix r3 = (0)

matrix F3 = ((R3*b-r3)'*inv(R3*XX_1*R3')*(R3*b-r3)/q3)/(7.1578947/g)
matrix list F3

clear all
// Pregunta 2

matrix y = (120,130,150,160,180,200)'
matrix x = (4,25,30,36,40,49)'
matrix X = (J(6,1,1),x)
matrix beta = invsym(X'*X)*X'*y
matrix list beta
matrix s2 = (y-X*beta)'*(y-X*beta)/4 // estimador de la varianza S^2
matrix xf = (1,42)
matrix yf = xf*beta
matrix list yf
scalar t = 2.776445
matrix a = xf*invsym(X'*X)*xf'
scalar y_inf = yf[1,1]-t*(s2[1,1])^(1/2)*(1+a[1,1])^(1/2)
scalar y_sup = yf[1,1]+t*(s2[1,1])^(1/2)*(1+a[1,1])^(1/2)
scalar list y_inf y_sup

clear all
//Pregunta 3

// a)

matrix R1 = (1,1,0)
matrix r1 = (1)
scalar q1 = 1
scalar gl = 2
matrix beta = (-0.548,0.126,0.73)'
matrix XX = (1.851,-0.236,-0.215\-0.236,0.106,-0.018\-0.215,-0.018,0.061)
matrix list XX
matrix F1 = ((R1*beta-r1)'*inv(R1*XX*R1')*(R1*beta-r1)/q1)/(0.1175/gl)
matrix list F1 

// b)

matrix R2 = (0,1,0\0,0,1)
matrix r2 = (0,0)'
scalar q2 = 2
scalar gl = 2
matrix beta = (-0.548,0.126,0.73)'
matrix XX = (1.851,-0.236,-0.215\-0.236,0.106,-0.018\-0.215,-0.018,0.061)
matrix list XX
matrix F2 = ((R2*beta-r2)'*inv(R2*XX*R2')*(R2*beta-r2)/q2)/(0.1175/gl)
matrix list F2

** Pregunta 4 

// a)
matrix XX = (84855.096,4796\4796,280)
matrix XY = (74788.346,4250.90)'

matrix beta = invsym(XX)*XY
matrix list beta

matrix SCR = 66042.269-(beta'*XX*beta)
matrix list SCR

scalar s2 = SCR[1,1]/13
scalar list s2
matrix var_beta = s2*invsym(XX)
* Test de significancia individual
scalar t_b1 = beta[1,1]/var_beta[1,1]^(1/2)
scalar t_b2 = beta[2,1]/var_beta[2,2]^(1/2)
scalar list t_b1 t_b2
* Test de significancia conjunta en función del R2
scalar R2=1-SCR[1,1]/66042.269
scalar F = (R2/2)/((1-R2)/12)
scalar list R2 F
// b)

matrix R = (1,1)
matrix r = (0)

matrix beta_res = beta +invsym(XX)*R'*invsym(R*invsym(XX)*R')*(r-R*beta)
matrix list beta_res

matrix SCR = 66042.269-(beta_res'*XX*beta)
matrix list SCR
scalar s2 = SCR[1,1]/13

matrix var_b2 = s2*(invsym(XX)-invsym(XX)*R'*invsym(R*invsym(XX)*R')*R*invsym(XX))
matrix list var_b2

// Ejercicio 7
clear all
//b)

scalar b1 = 0.8
scalar sd_b1 = 0.003

scalar t_b1 = b1/sd_b1 
scalar list t_b1

// Ejercicio 8

// a) 
scalar q = 2
scalar g = 7
matrix My = (0.1818,-0.5915,0.0531,-0.4612,0.7078,-0.5256,0.1352,0.1236,0.4087,-0.0321)
matrix SCR = My'*My
scalar s2 = SCR[1,1]/7
matrix Var_b = (5.286077,-0.453358,-0.022368\-0.453358,0.039594,0.001672\-0.022368,0.001672,0.000214)
matrix XX = (1/s2)*Var_b
scalar R_2 = 1-SCR[1,1]/1.792244
scalar list R_2
matrix beta = (0.9285379,0.0206822,0.0125)'
matrix F = (R_2/2)/((1-R_2)/7)
matrix list F

// b) 
matrix xf = (1,50,350)
matrix yf = xf*beta
matrix list yf
scalar t_esta = 2.364624
matrix a = xf*XX*xf'
matrix list a
scalar lim_inf = yf[1,1]-t_esta*s2^(1/2)*(1+a[1,1])^(1/2)
scalar lim_sup = yf[1,1]+t_esta*s2^(1/2)*(1+a[1,1])^(1/2)
scalar list lim_inf lim_sup

************************************************************ CAPITULO 6 *********************************************************************
*********************************************************************************************************************************************
clear all

import excel "C:\Users\Roberto Carlos\Desktop\Ciclo-2020-2\JP\base_6.xlsx", sheet("Hoja1") firstrow

tabulate trim, generate(D_)

scatter Y tiempo || scatter X tiempo

gen tiempo = _n

reg Y X

reg Y X D*, nocons

************************************************************ CAPITULO 8 *********************************************************************
*********************************************************************************************************************************************

// PREGUNTA 3 

**** b) 

scalar ee = 143470.703
scalar ee_res = 143733.299
scalar n = 800

* Test de Wald Forma alternativa 
scalar W = (ee_res-ee)/(ee/800)

* Razon de verosimilitud 

scalar RV = n*(ln(ee_res)-ln(ee))

* Multiplicadores de Lagrange

scalar ML = n*(ee_res-ee)/ee_res

* Prueba F

scalar F = ((ee_res-ee)/4)/(ee/790)

scalar list RV ML W F

// PREGUNTA 6
scalar ee = 0.8516340
scalar ee_res = 0.8557415
scalar n = 27

* Test de Wald Forma alternativa 
scalar W = (ee_res-ee)/(ee/800)

* Razon de verosimilitud 

scalar RV = n*(ln(ee_res)-ln(ee))

* Multiplicadores de Lagrange

scalar ML = n*(ee_res-ee)/ee_res


scalar list RV ML W










