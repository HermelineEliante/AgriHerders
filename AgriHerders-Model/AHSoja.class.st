Class {
	#name : 'AHSoja',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHSoja class >> initializeParameters [

	super initializeParameters.
	maxSupplyFertility := 5
]

{ #category : 'pov' }
AHSoja class >> myColor [

	^ Color fromHexString: 'B29EBB'
]

{ #category : 'control' }
AHSoja >> initialize [

	super initialize.
	optimalFertility := 0.9.
	residue := 2.
	expectedYield := 200. "kg/ha"
	price := 275 "fcfa/kg"
]
