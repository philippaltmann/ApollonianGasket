real((R,I), RealPart) :- 
	RealPart is R.
	
imaginary((R,I), ImaginaryPart) :- 
	ImaginaryPart is I.

conjugate((Rin,Iin), (Rout,Iout)) :-
	Rout is Rin,
	Iout is - Iin.
abs((R,I), Abs) :- 
	Abs is (R ** 2 + I ** 2) ** 0.5.

add((R1,I1), (R2,I2), (ResR,ResI)) :- 
	ResR is R1 + R2, 
	ResI is I1 + I2.
sub((R1,I1), (R2,I2), (ResR,ResI)) :- 
	ResR is R1 - R2, 
	ResI is I1 - I2.

mul((R1,I1), (R2,I2), (ResR,ResI)) :- 
	ResR is R1 * R2 - I1 * I2,
	ResI is R1 * I2 + I1 * R2.
div((R1,I1), (R2,I2), (ResR,ResI)) :- 
	conjugate((R2,I2),(R2conj, I2conj)), 
	mul((R2,I2),(R2conj, I2conj), (Norme2, Zero)), 
	mul((R1,I1), (R2conj, I2conj), (ResRt,ResIt)),
	ResR is ResRt / Norme2,
	ResI is ResIt / Norme2.