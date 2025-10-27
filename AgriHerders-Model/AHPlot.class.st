Class {
	#name : 'AHPlot',
	#superclass : 'CMCell',
	#instVars : [
		'area',
		'cowsCounter',
		'soilFertility',
		'cover'
	],
	#classInstVars : [
		'cowsNumberForFertility'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHPlot class >> cowsNumberForFertility [

	^ cowsNumberForFertility
]

{ #category : 'accessing' }
AHPlot class >> cowsNumberForFertility: anObject [

	cowsNumberForFertility := anObject
]

{ #category : 'initialization' }
AHPlot class >> initializeParameters [ 
super initializeParameters.
cowsNumberForFertility := 100
]

{ #category : 'accessing' }
AHPlot >> area [

	^ area
]

{ #category : 'accessing' }
AHPlot >> area: anObject [

	area := anObject
]

{ #category : 'accessing' }
AHPlot >> cover [

	^ cover
]

{ #category : 'accessing' }
AHPlot >> cover: anObject [

	cover := anObject
]

{ #category : 'accessing' }
AHPlot >> cowsCounter [

	^ cowsCounter
]

{ #category : 'accessing' }
AHPlot >> cowsCounter: anObject [

	cowsCounter := anObject
]

{ #category : 'initialize' }
AHPlot >> initialize [ 
	super initialize.
	soilFertility := 0.
	cowsCounter := 0.
]

{ #category : 'initialize' }
AHPlot >> initializeWithRandomfertilitylevel [

	self soilFertility: (self selectRandomlyFrom: self possibleSoilFertilities)




]

{ #category : 'accessing' }
AHPlot >> nextSoilFertility [
	| i |
	i := self possibleSoilFertilities indexOf: self soilFertility.
	i >= self possibleSoilFertilities size ifTrue: [ ^self soilFertility ] ifFalse: [ ^self possibleSoilFertilities at: i + 1 ]
]

{ #category : 'accessing' }
AHPlot >> possibleSoilFertilities [
	^#('low' 'middle' 'good' 'high')
]

{ #category : 'pov' }
AHPlot >> povCowsCounter [
	<pov>
	^CMPointOfView color: (self
		colorAttribute: #cowsCounter  
		min: 0
		max: 100
		color: Color brown)
]

{ #category : 'pov' }
AHPlot >> povFarm [
	<pov>
		(self getAggregateType: AHFarm) ifNil: [ ^ CMPointOfView color: Color white ] ifNotNil: [ ^ CMPointOfView color: Color red ].
]

{ #category : 'pov' }
AHPlot >> povLandcover [
	<pov>
	cover ifNil: [ ^ CMPointOfView color: Color black ].
	^ CMPointOfView color: self cover myColor
]

{ #category : 'pov' }
AHPlot >> povSoilFertility [
	<pov>
	| aColor |
	self soilFertility = 'low' ifTrue: [ aColor := Color white ].
	self soilFertility = 'middle' ifTrue: [ aColor := Color yellow ].
	self soilFertility = 'good' ifTrue: [ aColor := Color orange ].
	self soilFertility = 'high' ifTrue: [ aColor := Color green ].
	^CMPointOfView color: aColor
]

{ #category : 'initialize' }
AHPlot >> setLandcover: aTypeOfLandcover [
 	self cover: aTypeOfLandcover new.
	self cover cell: self
]

{ #category : 'accessing' }
AHPlot >> soilFertility [

	^ soilFertility
]

{ #category : 'accessing' }
AHPlot >> soilFertility: anObject [

	soilFertility := anObject
]

{ #category : 'initialize' }
AHPlot >> step [
	
	cowsCounter := cowsCounter + 1.
	self soilFertility 




]

{ #category : 'controlling' }
AHPlot >> updateFertility [
	"Augmentation du niveau de fertilité en fonction du passage des troupeaux (cowsCounter).
Si cowsCounter > O alors soilFerility passe à l'étape suivante: si c'était low, il devient middle, si c'était middle, il devient good. Si il est high, il reste high"

	<action>
	cowsCounter > 0 ifTrue: [ self soilFertility: self nextSoilFertility ]
]
