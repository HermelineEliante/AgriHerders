Class {
	#name : 'AHBush',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHBush class >> initializeParameters [

	super initializeParameters.
	maxSupplyFertility := 20.
	biomassMax := 13000.
]

{ #category : 'pov' }
AHBush class >> myColor [

	^ Color fromHexString: 'C9DAA3'
]

{ #category : 'accessing' }
AHBush >> initialize [

	super initialize.
	age := self randomIntegerBetween: 50 and: 100. "years"
	biomass := self randomIntegerBetween: 10000 and: self class biomassMax "kg/ha"
]
