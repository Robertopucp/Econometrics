****************************** Evaluando la insesgadez del estimador de MCO *************************************************************

clear all 
set more off 

 
set obs 500

foreach j of numlist 10 100 500 {
    gen beta_`j' = .

forvalues i = 1/`j' {
    

 // se crea una variable aleatoria de 100 observaciones a partir de una distribución normal de media cero y desviación estándar igual a 4
  gen u = rnormal(0,10)
 
 gen x = rnormal(10,5)

 gen y = 50 + 3*x + u  // el término de perturbación es iid (homocedastico), el término de perturbación no está correlacionado con las variable explicativa X
 
 quietly reg y x
 
 replace beta_`j' = e(b)[1,1] in `i'
 drop x y u
 
}

}

histogram beta_10, fcolor(yellow) legend(label (1 "10 muestras")) saving(hist1, replace)
histogram beta_100, fcolor(red) legend(label (2 "100 muestras")) saving(hist2, replace) 
histogram beta_500, fcolor(green) legend(label (3 "500 muestras")) saving(hist3, replace) 

graph combine hist1.gph hist2.gph hist3.gph

*kdensity beta_10 beta_100 beta_500