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
AHForest >> initialize [

	super initialize.
	age := self randomIntegerBetween: 50 and: 100. "years"
	biomassMax := 80.
	biomass := self randomIntegerBetween: 20 and: biomassMax. "kg/ha"
	biomassDecreaseRate := 40
]

{ #category : 'pov' }
AHForest >> myColor [
	^(Color fromHexString: '25663D')
]
