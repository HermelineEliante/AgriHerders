Class {
	#name : 'AHFarm',
	#superclass : 'CMSpatialEntityAggregate',
	#instVars : [
		'owner'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'aspects' }
AHFarm >> aspectBorder: look [

	<aspect>
	look
		borderColor: owner color;
		borderThickness: 0.04
]

{ #category : 'aspects' }
AHFarm >> aspectFilled: look [
	"Show the farm as one solid shape, with a line around it"

	<aspect>
	look
		color: ((Color fromHexString: '486862') alpha: 0.2);
		borderColor: Color red;
		borderThickness: 0.1
]

{ #category : 'probes' }
AHFarm >> numberOfPlots [

	<probe>
	^ self components size
]

{ #category : 'accessing' }
AHFarm >> owner [

	^ owner
]

{ #category : 'accessing' }
AHFarm >> owner: anObject [

	owner := anObject
]

{ #category : 'printing' }
AHFarm >> printOn: aStream [

	aStream nextPutAll: 'Farm of '.
	owner printOn: aStream
]
