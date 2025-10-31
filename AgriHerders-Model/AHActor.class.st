Class {
	#name : 'AHActor',
	#superclass : 'CMAgent',
	#instVars : [
		'agreement',
		'house',
		'myFarm',
		'territory',
		'others'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHActor >> agreement [

	^ agreement
]

{ #category : 'accessing' }
AHActor >> agreement: anObject [

	agreement := anObject
]

{ #category : 'accessing' }
AHActor >> house [

	^ house
]

{ #category : 'accessing' }
AHActor >> house: anObject [

	house := anObject
]

{ #category : 'accessing' }
AHActor >> initialize [

	super initialize.
	agreement := true.
]

{ #category : 'accessing' }
AHActor >> myFarm [

	^ myFarm
]

{ #category : 'accessing' }
AHActor >> myFarm: anObject [

	myFarm := anObject
]

{ #category : 'accessing' }
AHActor >> myPlots [

	^ self myFarm components
]

{ #category : 'accessing' }
AHActor >> name [

	^ self class name, '_', self id asString
]

{ #category : 'accessing' }
AHActor >> others [

	^ others
]

{ #category : 'accessing' }
AHActor >> others: anObject [

	others := anObject
]

{ #category : 'pov' }
AHActor >> pov [

	<pov>
	^ CMPointOfView color: Color purple size: 0.8
]

{ #category : 'accessing' }
AHActor >> territory [

	^ territory
]

{ #category : 'accessing' }
AHActor >> territory: anObject [

	territory := anObject
]
