Class {
	#name : 'AHPasture',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHPasture >> initialize [

	super initialize.
	biomassMax := 60
]

{ #category : 'pov' }
AHPasture >> myColor [
	^(Color fromHexString: 'D2F6C3')
]
