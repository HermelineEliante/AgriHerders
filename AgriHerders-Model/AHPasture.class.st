Class {
	#name : 'AHPasture',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHPasture class >> myColor [

	^ Color fromHexString: 'D2F6C3'
]

{ #category : 'accessing' }
AHPasture >> initialize [

	super initialize.
	age := 0. "years"
	biomassMax := 15000.
	biomass := self randomIntegerBetween: 13000 and: biomassMax "kg/ha"
]
