Class {
	#name : 'AHCashew',
	#superclass : 'AHVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHCashew >> myColor [
	^(Color fromHexString: '9C4ABE')
]

{ #category : 'pov' }
AHCashew >> pov [

	<pov>
	^ CMPointOfView color: Color purple
]
