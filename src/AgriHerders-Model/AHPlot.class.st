Class {
	#name : 'AHPlot',
	#superclass : 'CMCell',
	#instVars : [
		'area',
		'cowsCounter',
		'soilFertility',
		'cover',
		'conflicts'
	],
	#classInstVars : [
		'initialSoilFertility'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'initialization' }
AHPlot class >> initialSoilFertility [

	<parameterFloatMin: 0 max: 20 default: 5>
	^ initialSoilFertility
]

{ #category : 'accessing' }
AHPlot class >> initialSoilFertility: anObject [

	initialSoilFertility := anObject
]

{ #category : 'accessing' }
AHPlot >> area [
"ha"
	^ area
]

{ #category : 'accessing' }
AHPlot >> area: anObject [

	area := anObject
]

{ #category : 'aspects' }
AHPlot >> aspectBiomass: look [

	<aspect>
	(cover isKindOf: AHHabitation) ifTrue: [
		^ self aspectLandcover: look ].
	look
		colorShadeOf: cover class myColor
		forValue: cover ingestibleBiomass
		from: 0
		to: cover maxIngestibleBiomass
]

{ #category : 'aspects' }
AHPlot >> aspectConflicts: look [

	<aspect>
	conflicts = 0 ifTrue: [ ^ self aspectLandcover: look ].
	look
		colorShadeOf: CMColor red
		forValue: conflicts
		from: 0
		to: 4
]

{ #category : 'aspects' }
AHPlot >> aspectCowsCounter: look [
	"Show how many cows came on me this semester, with the border of my farm's owner"

	<aspect>
	self myFarm ifNotNil: [ :farm |
			look
				borderColor: farm owner color;
				borderThickness: 0.01 ].
	cowsCounter = 0 ifTrue: [ ^ look color: Color white ].
	look
		colorShadeOf: CMColor brown
		forValue: cowsCounter
		from: 0
		to: 60
]

{ #category : 'aspects' }
AHPlot >> aspectFarm: look [
	"Show the owner of my farm by its colour"

	<aspect>
	self myFarm ifNil: [ look color: Color white ] ifNotNil: [ :farm |
			look
				color: farm owner color;
				borderColor: farm owner color;
				borderThickness: 0.05 ]
]

{ #category : 'aspects' }
AHPlot >> aspectLandcover: look [

	<aspect>
	look
		borderThickness: 0;
		color: cover class myColor
]

{ #category : 'aspects' }
AHPlot >> aspectSoilFertility: look [

	<aspect>
	look
		colorShadeOf: CMColor orange
		forValue: soilFertility
		from: 0
		to: 20
]

{ #category : 'testing' }
AHPlot >> belongsToOwner: anAgent [
	^ self belongsToAggregate: anAgent myFarm
]

{ #category : 'testing' }
AHPlot >> belongsToSomebody [
	^ self belongsToAggregateType: AHFarm 
]

{ #category : 'charts' }
AHPlot >> chartSoilFertility [
	"How does the fertility of my soil change?"

	<chart>
	^ CMChart new
		  title: 'Soil fertility';
		  lineX: #currentTimeStep y: #soilFertility;
		  hideLegend;
		  yourself
]

{ #category : 'probes' }
AHPlot >> conflicts [
	<probe>

	^ conflicts
]

{ #category : 'accessing' }
AHPlot >> conflicts: anObject [

	conflicts := anObject
]

{ #category : 'accessing' }
AHPlot >> cover [

	^ cover
]

{ #category : 'accessing' }
AHPlot >> cover: anObject [

	cover := anObject
]

{ #category : 'probes' }
AHPlot >> cowsCounter [
	<probe>
	^ cowsCounter
]

{ #category : 'accessing' }
AHPlot >> cowsCounter: anObject [

	cowsCounter := anObject
]

{ #category : 'initialize' }
AHPlot >> initialize [

	super initialize.
	soilFertility := self class initialSoilFertility. "5"
	area := 1. "ha"
	cowsCounter := 0.
	conflicts := 0
]

{ #category : 'testing' }
AHPlot >> isOpenForCorraling [
	| agg |
	agg := self getAggregateType: AHFarm.
	agg ifNil: [^ true ] ifNotNil: [ ^agg owner agreement ]
]

{ #category : 'probes' }
AHPlot >> landcover [
	"Answer the name of my cover, such as 'Maize' or 'Forest'"

	<probe>
	^ cover class landcoverName
]

{ #category : 'accessing' }
AHPlot >> myFarm [

	^ self aggregates detect: [ :a | a isKindOf: AHFarm ] ifNone: [ nil ]
]

{ #category : 'initialize' }
AHPlot >> resetCowsCounter [

	cowsCounter:= 0.
	conflicts := 0
]

{ #category : 'controlling' }
AHPlot >> setLandcover: aTypeOfLandcover [
	self cover ifNotNil: [ self cover cell: nil. self cover delete ].
	self cover: (self cormasModel newEntity: aTypeOfLandcover).
	self cover cell: self.
	^cover 
]

{ #category : 'probes' }
AHPlot >> soilFertility [

	<probe>
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
