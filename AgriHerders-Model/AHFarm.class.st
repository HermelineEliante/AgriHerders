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

{ #category : 'pov' }
AHFarm >> povId [
	<pov>
	^ super povId
]

{ #category : 'pov' }
AHFarm >> povId2 [
	"Purpose: Returns a Color from the existing 31 constant names: #(#black #blue #brown #chartreuse #cyan #darkCyan #darkGray #darkGreen #darkMagenta #darkRed #gray #green #lightCyan #lightGray #lightYellow #magenta #navy #olive #orange #orchid #paleGreen #pink #purple #red #royalBlue #salmon #springGreen #veryDarkGray #veryLightGray #white #yellow). The id is used to determine the index at which the color name is picked in the array. 
Example: for an instance with id = 65, the returned color will be brown (65= 2*31+3)"

	<pov>
	^ CMPointOfView color: (self class colorOfNumber: (self id * 100))
]
