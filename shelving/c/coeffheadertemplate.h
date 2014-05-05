struct BiquadCoeff {
	// Need to verify/change datatype
	// Could be different for coefficients and scaling
	int a0
	int a1
	int a2
	int b0
	int b1
	int b2
	int g1
	int g2
};

// For C:

//coeff arrays for bass,mid and treble coefficients
BiquadCoeff exampleBiquadArray[3] ={ 
	{a0, a1, a2, b0, b1, b2, g1, g2}, 
	{a0, a1, a2, b0, b1, b2, g1, g2},
	{a0, a1, a2, b0, b1, b2, g1, g2}
 };
BiquadCoeff shelvingBassBandCoeff[8];
BiquadCoeff shelvingMidBandCoeff[8];
BiquadCoeff shelvingTrebBandCoeff[8];



