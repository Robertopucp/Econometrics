clear all
set more off

cd "C:\Users\Roberto Carlos\Desktop\Ciclo-2020-2\JP"

use phillips 

tsset year

* Graficas inflación vs desempleo

scatter inf unem
scatter cinf cunem
line inf unem year, title("Phillips Evidence") subtitle("USA, 1954-2003") note("Source: Stata")


* a) Estimación del modelo inicial 

reg inf unem
reg inf unem, robust

* b) graficos

predict residuo, resid

scatter residuo year

// Los residuos muestran un patrón a través del tiempo 

* c) correlagrama del residuo 

ac residuo // posible evidencia de ar(2)

*d)

quietly reg inf unem
estat dwatson // el estadístico cae en la zona de autocorrelación positiva 

*e)

forval j = 1/3 {
	
gen residuo_`j' = L`j'.residuo 

}

*gen residuo_1 = L.residuo 
*gen residuo_2 = L2.residuo 
*gen residuo_3 = L3.residuo

// Regresión auxiliar 
// Chi(1) = 3.84, Chi(2) = 5.99, Chi(3) = 7.81

quietly reg residuo residuo_1 unem 
scalar N = e(N)
scalar R_2 = e(r2)
scalar Test_BG = (N-1)*R_2
scalar list Test_BG 

quietly reg residuo residuo_1 residuo_2 unem 
scalar N = e(N)
scalar R_2 = e(r2)
scalar Test_BG = (N-2)*R_2
scalar list Test_BG 

reg residuo residuo_* unem 
scalar N = e(N)
scalar R_2 = e(r2)
scalar Test_BG = (N-3)*R_2
scalar list Test_BG 

* f) regresión de las variables en diferecnias 

reg cinf cunem 
predict hat

estat dwatson  // cae en la zona de no autocorrelación 
estat bgodfrey, lag(1)
estat bgodfrey, lag(2)

scatter cinf cunem || line hat cunem, pstyle(p2 p3 p3) sort


* Estimación de MCO usando la matriz de varianza consistente frente a al presencia de heterocedasticidad y autocorrelación de Newey - West
reg inf unem

newey inf unem, lag(1)

newey inf unem, lag(2)


*********************************************************** Pregunta 16 *************************************************************************

clear all 


import excel "C:\Users\Roberto Carlos\Desktop\Ciclo-2020-2\JP\capitulo9_16.xlsx", sheet("Hoja1") firstrow

tsset year

*a) Estimación del modelo 

reg ln_empleo ln_pbi 

// reducción del empleo en 10% reduce el empleo en 6.6%, incremento del pbi en 1% incrementa el empleo en 0.6%

*b) grafico de residuos 

predict residuo, resid

scatter residuo year

ac residuo

*c) Durbin - Watson 

quietly reg ln_empleo ln_pbi
estat dwatson 

// Evidencia de correlación positiva 

*d) Test Breusch-Godfrey 

forval j = 1/2 {
	
gen residuo_`j' = L`j'.residuo 

}

reg ln_empleo residuo_* ln_pbi
scalar N = e(N)
scalar R_2 = e(r2)
scalar Test_BG = (N-2)*R_2
scalar list Test_BG 

** Se rechaza la Ho de no autocorrelación 

gen bonanza=inlist(year,2005,2006,2007,2008,2009,2010,2011)

* gen bonanza = 0
* replace bonanza = 1 if year > 2005 & year < 2012

reg ln_empleo ln_pbi bonanza 

newey ln_empleo ln_pbi bonanza, lag(2)

*f) modelos en tasas de crecimiento 

gen cpbi = D.ln_pbi
gen cemp = D.ln_empleo

reg cemp cpbi
estat dwatson 
estat bgodfrey, lag(1)
estat bgodfrey, lag(2)
estat bgodfrey, lag(3)

***************************************************************** Ejercicio 18 **************************************************************************

clear all 
set more off
cd "C:\Users\Roberto Carlos\Desktop\CICLO-2021-1\Econometria\PC3\ENAHO"

use Educacion 

*1

reg ln_salario educ edad edad_2 sexo 
whitetst
bpagan educ edad edad_2 sexo 

reg ln_salario educ edad edad_2 sexo, robust 





































