Class {
	#name : 'AHPasture',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHPasture class >> initializeParameters [

	super initializeParameters.
	biomassMax := 15000. 
]

{ #category : 'pov' }
AHPasture class >> myColor [

	^ Color fromHexString: 'D2F6C3'
]

{ #category : 'accessing' }
AHPasture >> initialize [

	super initialize.
	age := 0. "years"
	biomass := self randomIntegerBetween: 13000 and: self class biomassMax "kg/ha"
]
