************************    Insesgadez ***********************************************
clear all
set more off

drawnorm u, n(30) sds(10)
gen beta = .

for j = 1:30{

gen x = rnormal(20,4)

gen y = 50 + 3*x + u

regress y x 

beta[j] = e(b)[1,2]

drop x y

}
