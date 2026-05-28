Class {
	#name : 'AHModel',
	#superclass : 'CMAbstractModel',
	#classInstVars : [
		'time'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'as yet unclassified' }
AHModel class >> initializeParameters [

	super initializeParameters.
	time := 0
]

{ #category : 'as yet unclassified' }
AHModel class >> modelName [

	^ 'AgriHerders'
]

{ #category : 'accessing' }
AHModel class >> prefix [

	^ 'AH'
]

{ #category : 'accessing' }
AHModel class >> time [

	^ time
]

{ #category : 'accessing' }
AHModel class >> time: anObject [

	time := anObject
]

{ #category : 'probes' }
AHModel >> averageBiomass [
	"^ (self @@ AHPlot collect: [ :p | p cover biomass ]) average"

	"<probeNamed: 'averageBiomass' color: #green>"
	^ self totalResidue + self naturalBiomass
]

{ #category : 'probes' }
AHModel >> cattleSize [ 
"retourne le nombre total de vaches, pour suivre l'evolution de tout le troupeau"

	<probeNamed: 'Cattle size' color: 'E74C3C' >
	^(self @@ AHCattleBatch collect: [ :each | each heads ]) sum.
]

{ #category : 'probes' }
AHModel >> corporalCondition [ 
"evolution de CC moyen de tout le troupeau"

	<probeNamed: 'Corporal condition' color: 'F39C12' >
	| heads |
	heads := (self @@ AHCattleBatch collect: [ :each | each heads ]) sum.
	heads = 0 ifTrue: [ ^0 ].
	 ^(self @@ AHCattleBatch collect: [ :each | each heads * each corporalCondition ]) sum / heads.
	
]

{ #category : 'probes' }
AHModel >> cottonSize [

	<probeNamed: 'Cotton size' color: 'F4F2DA' >
	^ (self @@ AHPlot select: [ :p | p cover class = AHCotton ]) size
]

{ #category : 'initialization' }
AHModel >> createCattles [
	"Je crée 10 troupeax pour chaque éleveur"

	| aCattle |
	self @@ AHSedentary do: [ :eleveur |
			aCattle := self newEntity: AHCattleBatch.
			eleveur herd add: aCattle.
			aCattle owner: eleveur.
			aCattle moveTo:
				(eleveur house) ]
]

{ #category : 'initialization' }
AHModel >> createOneFarmFrom: aListOfIDs forAgent: aTypeOfAgent [

	| farmCells aFarm ag |
	farmCells := self thePlots select: [ :c | aListOfIDs includes: c id ].
	aFarm := self createAggregate: AHFarm from: farmCells.
	ag := self newEntity: aTypeOfAgent.
	ag myFarm: aFarm.
	aFarm owner: ag.
	aTypeOfAgent = AHFarmer
		ifTrue: [ ag house: (self selectRandomlyFrom: self villagePlots) ]
		ifFalse: [
				ag house:
					(aFarm components detect: [ :c | c cover class = AHFulaniCamp ]) ].
	ag moveTo: ag house.
	(aFarm includesCell: ag house) ifFalse: [ aFarm addComponent: ag house ]
]

{ #category : 'accessing' }
AHModel >> forestPlots [
	"return the cells in  forest"

	^ self plotsCoveredBy: AHForest
]

{ #category : 'probes' }
AHModel >> globalFertility [
"moyenne de la fertilité de tous les plots : #(2 6 7) average"
	<probeNamed: 'global fertility' color: #black>
	^ (self @@ AHPlot collect: [ :p | p soilFertility ]) average
]

{ #category : 'initialization' }
AHModel >> initFarmsAndAgents [

	| farmCells |
	self createOneFarmFrom: #( 17 18 25 26 27 33 ) forAgent: AHFarmer.
	self createOneFarmFrom: #( 35 36 37 43 44 ) forAgent: AHFarmer.
	self createOneFarmFrom: #( 32 40 ) forAgent: AHSedentary.
	self createOneFarmFrom: #( 57 58 ) forAgent: AHSedentary.

	"Ferme de cajou, sans proprietaire"
	farmCells := self thePlots select: [ :c | #( 29 30 ) includes: c id ].
	self createAggregate: AHFarm from: farmCells.

	farmCells := self thePlots select: [ :c | #( 46 47 ) includes: c id ].
	self createAggregate: AHFarm from: farmCells.

	farmCells := self thePlots select: [ :c |
		             #( 45 51 52 60 61 ) includes: c id ].

	self newEntity: AHTranshumant. "locatedAt: (self cellAt: 1 at: 1)"
	"act, c'est l'acteur en question, self allEntities est une collection de mes cinq acteurs"
	(self allTheEntities: AHActor) do: [ :act |
			act territory: self thePlots.
			act others: (self allTheEntities: AHActor).
			act others remove: act ]
]

{ #category : 'initialization' }
AHModel >> initLandcover [

	1 to: 11 do: [ :i | (self cellAt: i) setLandcover: AHForest ].
	#( 12 13 14 15 16 19 20 21 22 23 24 ) do: [ :i |
		(self cellAt: i) setLandcover: AHPasture ].
	#( 17 18 25 32 36 37 58 ) do: [ :i |
		(self cellAt: i) setLandcover: AHMaize ].
	#( 34 45 ) do: [ :i |
		(self cellAt: i) setLandcover: AHSoja ].
	#( 26 27 35 44 ) do: [ :i | (self cellAt: i) setLandcover: AHCotton ].
	#( 33 43 ) do: [ :i | (self cellAt: i) setLandcover: AHCassava ].
	#( 54 55 62 ) do: [ :i |
		(self cellAt: i) setLandcover: AHFarmerHouse ].
	#( 40 57 ) do: [ :i | (self cellAt: i) setLandcover: AHFulaniCamp ].
	#( 29 30 46 47 51 52 60 61 ) do: [ :i |
		(self cellAt: i) setLandcover: AHCashew ].
	#( 28 31 34 38 39 41 42 48 49 50 53 56 59 63 64 ) do: [ :i |
		(self cellAt: i) setLandcover: AHBush ]
]

{ #category : 'initialization' }
AHModel >> initModel [

	<init>
	self
		createGridNumberOfRows: 8
		numberOfColumns: 8
		neighbourhood: 6
		closed: true.
	self initLandcover.

	self initFarmsAndAgents.
	self createCattles.

	AHPlot activePovSelector: #povLandcover
]

{ #category : 'probes' }
AHModel >> maizeSize [

	<probeNamed: 'Maize size' color: 'F1F10F'>
	^ (self @@ AHPlot select: [ :p | p cover class = AHMaize ]) size
]

{ #category : 'probes' }
AHModel >> naturalBiomass [

	"<probeNamed: 'naturalBiomass' color: '5A9186'>"
	^ ((self @@ AHPlot select: [ :p |
		    p cover isKindOf: AHNaturalVegetation ]) collect: [ :p |
		   p cover biomass ]) average
]

{ #category : 'probes' }
AHModel >> naturalZoneFertility [
	"moyenne de la fertilité de tous les plots : #(2 6 7) average"

	<probeNamed: 'naturalZone fertility' color: #black>
	| coll |
	coll := OrderedCollection new.
	 coll addAll: (self plotsCoveredBy: AHForest).
	 coll addAll: (self plotsCoveredBy: AHPasture).
	^(coll collect: [ :p |
		   p soilFertility ]) average
]

{ #category : 'accessing' }
AHModel >> plotsCoveredBy: aTypeOfCover [
	"return the cells covered by aTypeOfCover"

	^ self thePlots select: [ :c | c cover isKindOf: aTypeOfCover ]
]

{ #category : 'probes' }
AHModel >> sojaSize [

	<probeNamed: 'Soja size' color: 'B29EBB'>
	^ (self @@ AHPlot select: [ :p | p cover class = AHSoja ]) size
]

{ #category : 'control' }
AHModel >> step: t [
	"t = 1 => rainy saeson, si t est pair => dry season"

	<control>
	self class time: t.
	"self @@ AHPlot do: [: p | p cowsCounter: 0]."
	self @@ AHPlot do: #resetCowsCounter.
	t even
		ifTrue: [ self stepDrySeason ]
		ifFalse: [ "pair" self stepRainySeason .
			(t / 10) isInteger ifTrue: [  self  @@ AHFarmer do: #expandFarm ]]
]

{ #category : 'control' }
AHModel >> stepDrySeason [

	(self allTheEntities: AHActor) do: #harvest.
	self thePlots do: #stepDrySeason. "Evolution naturelle des couverts"
	"(self allTheEntities: AHActor) do: #dryStep"
	(self allTheEntities: AHHerder) shuffled do: #moveHerd.
	self @@ AHFarmer do: #sow.
	self @@ AHSedentary do: #sowMaize.
	self @@ AHCattleBatch do: #naturalMortality
]

{ #category : 'control' }
AHModel >> stepRainySeason [

	self @@ AHFarmer do:  #rainyStep .
	self thePlots do: #stepRainySeason.
	(self allTheEntities: AHHerder) shuffled do: #moveHerd.
	self @@ AHCattleBatch do: #reproduce
]

{ #category : 'accessing' }
AHModel >> theCattleBatches [ 

	^ self @@ AHCattleBatch 
]

{ #category : 'accessing' }
AHModel >> thePlots [

	^ self @@ AHPlot 
]

{ #category : 'probes' }
AHModel >> totalResidue [

	"<probeNamed: 'totalResidue' color: '9CB553'>"
	^ ((self @@ AHPlot select: [ :p |
		    p cover isKindOf: AHCultivatedVegetation ]) collect: [ :p |
		   p cover biomass ]) average
]

{ #category : 'accessing' }
AHModel >> villagePlots [
	"return the 3 FarmerHouse cells"

	^ self plotsCoveredBy:  AHFarmerHouse
]
