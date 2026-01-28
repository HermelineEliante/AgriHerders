Class {
	#name : 'AHBush',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHBush >> initialize [

	super initialize.
	age := self randomIntegerBetween: 50 and: 100. "years"
	biomassMax := 40.
	biomass := self randomIntegerBetween: 10 and: biomassMax. "kg/ha"

]

{ #category : 'pov' }
AHBush >> myColor [

	^ Color fromHexString: 'F0DFC6'
]
