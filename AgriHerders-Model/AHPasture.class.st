Class {
	#name : 'AHPasture',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHPasture >> initialize [

	super initialize.
	age := 0. "years"
	biomassMax := 60.
	biomass := self randomIntegerBetween: 10 and: biomassMax "kg/ha"
]

{ #category : 'pov' }
AHPasture >> myColor [
	^(Color fromHexString: 'D2F6C3')
]
