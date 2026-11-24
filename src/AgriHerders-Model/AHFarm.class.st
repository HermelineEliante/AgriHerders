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

{ #category : 'pov' }
AHFarm >> aspectBorder: look [
		<aspect>
	look
		  borderColor: (owner color);
		  borderThickness: 0.04
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

{ #category : 'pov' }
AHFarm >> povBorder [
		<pov>
	^ CMPointOfView new
		  borderColor: owner povId color;
		  borderWidth: 0.04;
		  yourself
]

{ #category : 'pov' }
AHFarm >> povFilled [
	"Show the grove as one solid shape, with a line around it"

	<pov>
	^ (CMPointOfView color: ((Color fromHexString: '486862') alpha: 0.2))
		  borderColor: Color red;
		  borderWidth: 0.1;
		  yourself
]

{ #category : 'printing' }
AHFarm >> printOn: aStream [

	aStream nextPutAll: 'Farm of '.
	owner printOn: aStream
]
