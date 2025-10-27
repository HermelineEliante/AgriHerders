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
AHModel >> initFarms [

	| farmCells |
	
	farmCells := {(self thePlots select: [ :c | #( 17 18 25 26 27 33 ) includes: c id ]).
		(self thePlots select: [ :c | #( 35 36 37 43 44) includes: c id ]).
		(self thePlots select: [ :c | #( 29 30 ) includes: c id ]).
		(self thePlots select: [ :c | #( 32 40 ) includes: c id ]).
		(self thePlots select: [ :c | #(45 46 47 ) includes: c id ]).
		(self thePlots select: [ :c | #( 51 52 60 61 ) includes: c id ]).
		(self thePlots select: [ :c | #( 57 58 ) includes: c id ])} flattened.

	self
		createAggregate: AHFarm
		from: farmCells
		
]

{ #category : 'initialization' }
AHModel >> initLandcover [

	1 to: 11 do: [: i | (self cellAt: i) setLandcover: AHForest].
	#(12 13 14 15 16 19 20 21 22 23 24) do: [: i | (self cellAt: i) setLandcover: AHPasture].
	#(17 18 25 32 36 37 58) do: [: i | (self cellAt: i) setLandcover: AHMaize].
	#(26 27 35 44) do: [: i | (self cellAt: i) setLandcover: AHCotton].
	#(33 43) do: [: i | (self cellAt: i) setLandcover: AHCassava].
	#(54 55 63) do: [: i | (self cellAt: i) setLandcover: AHFarmerHouse].
	#(40 57)do: [: i | (self cellAt: i) setLandcover: AHFulaniCamp].
	#(29 30 45 46 47 51 52 60 61) do: [: i | (self cellAt: i) setLandcover: AHCashew].
	#(28 31 34 38 39 41 42 48 49 50 53 56  59 62 64) do: [: i | (self cellAt: i) setLandcover: AHBrush].

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

	self initializeAgents.
	self initFarms.
	AHPlot activePovSelector: #povLandcover
]

{ #category : 'initialization' }
AHModel >> initializeAgents [

		
	self
		createN: self class initialNumberOfPhdCattleBatch
		randomlyLocatedAloneEntities: AHCattleBatch .
]

{ #category : 'control' }
AHModel >> step [

	<control>
	
]

{ #category : 'control' }
AHModel >> step: t [
	<control>
	"This method will be executed at every step of the simulation"
]

{ #category : 'accessing' }
AHModel >> theCattleBatches [ 

	^ self @@ AHCattleBatch 
]

{ #category : 'accessing' }
AHModel >> thePlots [

	^ self @@ AHPlot 
]
