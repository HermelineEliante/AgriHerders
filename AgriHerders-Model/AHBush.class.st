Class {
	#name : 'AHBush',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHBush class >> myColor [

	^ Color fromHexString: 'F0DFC6'
]

{ #category : 'accessing' }
AHBush >> initialize [

	super initialize.
	age := self randomIntegerBetween: 50 and: 100. "years"
	biomassMax := 13000.
	biomass := self randomIntegerBetween: 10000 and: biomassMax "kg/ha"
]
