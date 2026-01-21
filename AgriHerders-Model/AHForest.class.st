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
AHForest >> initialize [

	super initialize.
	biomassMax := 80.
	biomassDecreaseRate := 40
]

{ #category : 'pov' }
AHForest >> myColor [
	^(Color fromHexString: '25663D')
]
