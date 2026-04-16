Class {
	#name : 'AHMaize',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHMaize class >> myColor [

	^ Color fromHexString: 'F1F10F'
]

{ #category : 'control' }
AHMaize >> initialize [

	super initialize.
	optimalFertility := 5.
	residue := 7.
	expectedYield := 300. "kg/ha"
	price := 215 "fcfa/kg"
]
