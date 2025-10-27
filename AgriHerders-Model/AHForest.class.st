Class {
	#name : 'AHForest',
	#superclass : 'AHVegetation',
	#instVars : [
		'state',
		'coordinates'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHForest >> myColor [
	^(Color fromHexString: '25663D')
]
