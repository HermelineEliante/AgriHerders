Class {
	#name : 'AHForest',
	#superclass : 'AHNaturalVegetation',
	#instVars : [
		'state'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHForest class >> initializeParameters [

	super initializeParameters.
	maxSupplyFertility := 20.
	biomassMax := 18000.
	biomassDecreaseRate := 40
]

{ #category : 'pov' }
AHForest class >> myColor [

	^ Color fromHexString: '25663D'
]

{ #category : 'accessing' }
AHForest >> initialize [

	super initialize.
	age := self randomIntegerBetween: 50 and: 100. "years"
	biomass := self randomIntegerBetween: 15000 and: self class biomassMax. "kg/ha"
]
