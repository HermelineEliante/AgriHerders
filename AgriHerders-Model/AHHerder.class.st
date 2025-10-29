Class {
	#name : 'AHHerder',
	#superclass : 'AHActor',
	#instVars : [
		'herd'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHHerder >> herd [

	^ herd
]

{ #category : 'accessing' }
AHHerder >> herd: anObject [

	herd := anObject
]

{ #category : 'accessing' }
AHHerder >> initialize [ 
	super initialize .
	self herd: OrderedCollection new.
]

{ #category : 'as yet unclassified' }
AHHerder >> moveHerd [

]
