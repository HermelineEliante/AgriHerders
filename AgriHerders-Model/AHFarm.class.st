Class {
	#name : 'AHFarm',
	#superclass : 'CMSpatialEntityAggregate',
	#instVars : [
		'owner'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHFarm >> owner [

	^ owner
]

{ #category : 'accessing' }
AHFarm >> owner: anObject [

	owner := anObject
]
