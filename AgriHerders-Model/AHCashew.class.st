Class {
	#name : 'AHCashew',
	#superclass : 'AHCultivatedVegetation',
	#instVars : [
		'production'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHCashew >> initialize [

	super initialize.
	optimalFertility := 1.
	expectedYield := 200.
	production :=5
]

{ #category : 'pov' }
AHCashew >> myColor [

	^ Color fromHexString: 'F9C3C0'
]

{ #category : 'pov' }
AHCashew >> pov [

	<pov>
	^ CMPointOfView color: Color purple
]
