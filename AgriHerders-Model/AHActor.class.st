Class {
	#name : 'AHActor',
	#superclass : 'CMAgent',
	#instVars : [
		'name',
		'status',
		'location',
		'myPlots'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHActor >> location [

	^ location
]

{ #category : 'accessing' }
AHActor >> location: anObject [

	location := anObject
]

{ #category : 'as yet unclassified' }
AHActor >> myPlots [

	^ self property components
]

{ #category : 'accessing' }
AHActor >> name [

	^ name
]

{ #category : 'accessing' }
AHActor >> name: anObject [

	name := anObject
]

{ #category : 'as yet unclassified' }
AHActor >> pov [

	<pov>
	^ CMPointOfView color: Color purple size: 0.8
]

{ #category : 'accessing' }
AHActor >> property [

	^ property
]

{ #category : 'accessing' }
AHActor >> property: anObject [

	property := anObject
]

{ #category : 'accessing' }
AHActor >> status [

	^ status
]

{ #category : 'accessing' }
AHActor >> status: anObject [

	status := anObject
]

{ #category : 'as yet unclassified' }
AHActor >> step [ 
]
