Class {
	#name : 'AHFallow',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHFallow class >> initializeParameters [

	super initializeParameters.
	maxSupplyFertility := 5
]

{ #category : 'pov' }
AHFallow class >> myColor [

	^ Color fromHexString: 'A6B58A'
]

{ #category : 'accessing' }
AHFallow >> initialize [

	super initialize.
	age := 0. "years"
	biomassMax := 1000.
	biomass := self randomIntegerBetween: 700 and: biomassMax "kg/ha"
]
