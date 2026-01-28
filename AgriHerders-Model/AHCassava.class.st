Class {
	#name : 'AHCassava',
	#superclass : 'AHCultivatedVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHCassava >> initialize [

	super initialize.
	optimalFertility := 1.
	expectedYield := 80
]

{ #category : 'pov' }
AHCassava >> myColor [

	^ Color fromHexString: 'DCC603'
]
