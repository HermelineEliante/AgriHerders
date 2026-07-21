Class {
	#name : 'AHCotton',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHCotton class >> myColor [

	^ Color fromHexString: 'EEEEC8'
]

{ #category : 'control' }
AHCotton >> initialize [

	super initialize.
	optimalFertility := 10.
	residue := 1.
	expectedYield := 750. "kg/ha"
	price := 350 "fcfa/kg"
]
