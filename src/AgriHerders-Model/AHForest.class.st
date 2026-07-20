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
AHForest class >> biomassDecreaseRate [
	<parameterFloatDefault: 40>
	^biomassDecreaseRate
]

{ #category : 'accessing' }
AHForest class >> biomassMax [

	<parameterFloatDefault: 18000>
	^ biomassMax
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
