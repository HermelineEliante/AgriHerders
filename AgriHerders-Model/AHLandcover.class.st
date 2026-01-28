Class {
	#name : 'AHLandcover',
	#superclass : 'CMEntity',
	#instVars : [
		'cell',
		'isDead'
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

{ #category : 'initialization' }
AHLandcover >> initialize [

	super initialize.
	isDead := false
]

{ #category : 'accessing' }
AHLandcover >> isDead [

	^ isDead
]

{ #category : 'accessing' }
AHLandcover >> isDead: anObject [

	isDead := anObject
]

{ #category : 'pov' }
AHLandcover >> myColor [
	^Color white
]

{ #category : 'control' }
AHLandcover >> rainyStep [
]
