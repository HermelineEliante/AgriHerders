Class {
	#name : 'AHFallow',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHFallow >> initialize [

	super initialize.
	age := 0. "years"
	biomassMax := 30.
	biomass := self randomIntegerBetween: 3 and: biomassMax "kg/ha"
]
