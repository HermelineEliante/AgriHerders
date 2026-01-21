Class {
	#name : 'AHCashew',
	#superclass : 'AHCultivatedVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHCashew >> myColor [

	^ Color fromHexString: 'F9C3C0'
]

{ #category : 'pov' }
AHCashew >> pov [

	<pov>
	^ CMPointOfView color: Color purple
]
