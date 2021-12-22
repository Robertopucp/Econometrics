
clear all 
set more off
cd "C:\Users\Roberto Carlos\Desktop\CICLO-2021-1\Econometria\PC3\ENAHO"

use Educacion 

*1

reg ln_salario educ edad edad_2 sexo 

** La variables significativas son educación y la dummy de género al 1% y 5% de nivel de significancia respectivamente. 
** El valor estimado de alpha es 0.17. En efecto, el incremento del salario por hora de los hombres es 14.8% mayor comparado al caso de las mujeres. 

*2 Verificar la presencia de multicolienaliedad

reg ln_salario educ edad edad_2 sexo 
vif

// El indicador de VIF muestra que las variables edad y edad al cuadrado generan multocolienalidad pero esto se debe a que una es el cuadrado de la otra. No estamos ante el caso de una correlación alta entre variables diferentes. Asimsimo, la desviaciones estandar se incrementan de todas las vraibles por la presencia de correlación entre edad y edad al cudrado pero no afectan la significancia de las variables de interés (educación y sexo). 

reg ln_salario educ edad sexo 
vif

reg ln_salario educ edad sexo 
corr



*3 

gen edu_se = educ*sexo

reg ln_salario educ edad edad_2 sexo edu_se

* El incremento del salario por hora de los hombres es 22% mayor comparado al caso de las mujeres. No obstante, el retorno de la educación sobre el salario, en el caso de los hombres, es 0.6% menor comparado al caso de las mujeres. Por tanto, según los resultados, las mujeres obtiene un mayor retorno por cada año adicional de educación. 

*4

reg ln_salario educ edad edad_2 sexo Dsec Dsup c.Dsec#c.educ c.Dsup#c.educ
test Dsec = Dsup = c.Dsec#c.educ = c.Dsup#c.educ = 0





*******************************************************************  Ejercicico 12 ***********************************************************************

clear all 

import excel "C:\Users\Roberto Carlos\Desktop\Ciclo-2020-2\JP\USA\usa.xls", sheet("FRED Graph") firstrow

** convertir la varaible time en terminos trimestrales 

gen trim_date = qofd(time)
format trim_date %tq

gen year_date = yofd(time)
format year_date %ty


gen ln_k = ln(capital/(10000000*deflactor))
gen ln_empleo = ln(empleo/1000)
gen ln_pbi = ln(gdp)

*a)

reg ln_pbi ln_k ln_empleo if year_date < 1990

reg ln_pbi ln_k ln_empleo if year_date >= 1990

gen dm = 0
replace dm = 1 if year_date >= 1990


*b)

//Test de Cambio estrcuutural 

gen d_ln_empleo = dm*ln_empleo
gen d_ln_k = dm*ln_k

reg ln_pbi dm ln_empleo d_ln_empleo ln_k d_ln_k
test (dm=0) (d_ln_empleo=0) (d_ln_k=0)

// Se rechaza la Ho, evidencia de equiebre estrucutral 


*c)

gen id = _n
gen beta2 = .  //missing values
gen beta3 = .

forval i = 5/245{

quietly reg ln_pbi ln_k ln_empleo if id <= `i'
replace beta2 = e(b)[1,1] in `i'
replace beta3 = e(b)[1,2] in `i'

}

reg ln_pbi ln_k ln_empleo

line beta2 beta3 trim_date

* El parámetro del empleo es de mayor variabilidad 
















