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
	soilFertility := 10.
	"self initializeWithRandomfertilitylevel."
	area := 1. "ha"
	cowsCounter := 0
]

{ #category : 'initialize' }
AHPlot >> initializeWithRandomfertilitylevel [

	self soilFertility: (self selectRandomlyFrom: self possibleSoilFertilities)




]

{ #category : 'accessing' }
AHPlot >> myFarm [

	^ self aggregates detect: [ :a | a isKindOf: AHFarm ] ifNone: [ nil ]
]

{ #category : 'accessing' }
AHPlot >> nextSoilFertility [
	| i |
	i := self possibleSoilFertilities indexOf: self soilFertility.
	i >= self possibleSoilFertilities size ifTrue: [ ^self soilFertility ] ifFalse: [ ^self possibleSoilFertilities at: i + 1 ]
]

{ #category : 'accessing' }
AHPlot >> possibleSoilFertilities [
^(Interval from: 0 to: 20) asArray.
]

{ #category : 'pov' }
AHPlot >> povBiomass [

	<pov>
	cover ifNil: [ ^ CMPointOfView color: Color black ].
	(self cover isKindOf: AHHabitation) ifTrue: [ ^ self povLandcover ].
	^ CMPointOfView color: (self cover colorValue: (self cover biomass) min: 0 color: #white max: (self cover class biomassMax ) color: self cover class myColor).
	"^ CMPointOfView color: self cover class myColor"
	
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
	(self getAggregateType: AHFarm)
		ifNil: [ ^ CMPointOfView color: Color white ]
		ifNotNil: [ ^ (self getAggregateType: AHFarm) povId ]
]

{ #category : 'pov' }
AHPlot >> povLandcover [

	<pov>
	cover ifNil: [ ^ CMPointOfView color: Color black ].
	^ CMPointOfView color: self cover class myColor
]

{ #category : 'pov' }
AHPlot >> povSoilFertility [
	"	| aColor |
	self soilFertility = 0 ifTrue: [ aColor := Color white ].
	self soilFertility = 1 ifTrue: [ aColor := Color yellow ].
	self soilFertility = 2 ifTrue: [ aColor := Color orange ].
	self soilFertility = 3 ifTrue: [ aColor := Color green ]."

	<pov>
	^ CMPointOfView color: (self
			   colorValue: self soilFertility
			   min: 0
			   max: 20
			   color: Color orange)
]

{ #category : 'initialize' }
AHPlot >> resetCowsCounter [
	self cowsCounter: 0
]

{ #category : 'controlling' }
AHPlot >> setLandcover: aTypeOfLandcover [
	self cover ifNotNil: [ self cover cell: nil. self cover delete ].
	self cover: (self cormasModel newEntity: aTypeOfLandcover).
	self cover cell: self.
	^cover 
]

{ #category : 'accessing' }
AHPlot >> soilFertility [

	^ soilFertility
]

{ #category : 'accessing' }
AHPlot >> soilFertility: anObject [
"(self cover isKindOf: AHNaturalVegetation) ifTrue: [ self halt ]."
	soilFertility := anObject
]

{ #category : 'controlling' }
AHPlot >> stepDrySeason [

	self cover dryStep
]

{ #category : 'controlling' }
AHPlot >> stepRainySeason [
 	self cover rainyStep
]
