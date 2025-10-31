Class {
	#name : 'AHLandcover',
	#superclass : 'Object',
	#instVars : [
		'cell'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHLandcover >> cell [

	^ cell
]

{ #category : 'accessing' }
AHLandcover >> cell: anObject [

	cell := anObject
]

{ #category : 'control' }
AHLandcover >> dryStep [

	
]

{ #category : 'pov' }
AHLandcover >> myColor [
	^Color white
]

{ #category : 'control' }
AHLandcover >> rainyStep [
]
