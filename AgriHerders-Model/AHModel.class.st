Class {
	#name : 'AHModel',
	#superclass : 'CMAbstractModel',
	#classInstVars : [
		'initialNumberOfPhdCattleBatch'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHModel class >> initialNumberOfPhdCattleBatch [

	^ initialNumberOfPhdCattleBatch
]

{ #category : 'accessing' }
AHModel class >> initialNumberOfPhdCattleBatch: anObject [

	initialNumberOfPhdCattleBatch := anObject
]

{ #category : 'as yet unclassified' }
AHModel class >> initializeParameters [ 
	super initializeParameters.
	initialNumberOfPhdCattleBatch := 10.
]

{ #category : 'as yet unclassified' }
AHModel class >> modelName [

	^ 'AgriHerders'
]

{ #category : 'accessing' }
AHModel class >> prefix [

	^ 'AH'
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
		ifTrue: [ag house: (self selectRandomlyFrom: self villagePlots) ]
		ifFalse: [ag house: (aFarm components detect: [ :c | c cover class = AHFulaniCamp ]) ].
	ag moveTo: ag house.
]

{ #category : 'accessing' }
AHModel >> forestPlots [
	"return the cells in  forest"

	^ self plotsCoveredBy: AHForest
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

{ #category : 'accessing' }
AHModel >> plotsCoveredBy: aTypeOfCover [
	"return the cells covered by aTypeOfCover"

	^ self thePlots select: [ :c | c cover class = aTypeOfCover ]
]

{ #category : 'control' }
AHModel >> step: t [
	"This method will be executed at every step of the simulation"

	<control>
	t even "pair" ifTrue: [ self stepDrySeason ] ifFalse: [ self stepRainySeason ]
]

{ #category : 'control' }
AHModel >> stepDrySeason [
	self thePlots do: #stepDrySeason

	
]

{ #category : 'control' }
AHModel >> stepRainySeason [

	self thePlots do: #stepRainySeason
]

{ #category : 'accessing' }
AHModel >> theCattleBatches [ 

	^ self @@ AHCattleBatch 
]

{ #category : 'accessing' }
AHModel >> thePlots [

	^ self @@ AHPlot 
]

{ #category : 'accessing' }
AHModel >> villagePlots [
	"return the 3 FarmerHouse cells"

	^ self plotsCoveredBy:  AHFarmerHouse
]
