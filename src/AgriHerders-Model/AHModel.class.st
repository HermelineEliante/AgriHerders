Class {
	#name : 'AHModel',
	#superclass : 'CMModel',
	#instVars : [
		'doesPopulationGrow',
		'expansionFrequency',
		'cumulConflicts'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHModel class >> modelName [

	^ 'AgriHerders'
]

{ #category : 'accessing' }
AHModel class >> prefix [

	^ 'AH'
]

{ #category : 'testing' }
AHModel >> areCowsExtinguished [
	"répond si il n'y a plus de vaches "
	<boolean>

	^ self cattleSize <= 4
]

{ #category : 'probes' }
AHModel >> cattleSize [ 
"retourne le nombre total de vaches, pour suivre l'evolution de tout le troupeau"

	<probe>
	self @@ AHCattleBatch ifEmpty: [ ^0 ].
	^(self @@ AHCattleBatch collect: [ :each | each heads ]) sum rounded.
]

{ #category : 'charts' }
AHModel >> chartBiomass [
	"How much forage is left for the cattle, in natural covers and as crop residues?"

	<chart>
	^ CMChart new
		  title: 'Biomass';
		  add: (CMLineSeries new
				   x: #currentTimeStep y: #naturalBiomass;
				   label: 'Mean of natural covers';
				   yourself);
		  add: (CMLineSeries new
				   x: #currentTimeStep y: #totalResidue;
				   label: 'Mean residue of crops';
				   yourself);
		  yourself
]

{ #category : 'charts' }
AHModel >> chartCattle [
	"How many cattle are there, and whose herds grow?"

	<chart>
	^ CMChart new
		  title: 'Cattle of each herder';
		  areasX: #currentTimeStep y: #herdSize ofAll: AHHerder;
		  yTitle: 'Heads';
		  yourself
]

{ #category : 'charts' }
AHModel >> chartConflicts [
	"How many conflicts do cattle cause in the fields, and how does their average change?"

	<chart>
	^ CMChart new
		  title: 'Conflicts';
		  add: (CMBarSeries new
				   x: #currentTimeStep y: #conflicts;
				   label: 'Conflicts of the semester';
				   yourself);
		  add: (CMLineSeries new
				   x: #currentTimeStep y: #conflictsAverage;
				   label: 'Average since the start';
				   yourself);
		  yourself
]

{ #category : 'charts' }
AHModel >> chartCorporalCondition [
	"Are the cattle well fed, enough to give birth?"

	<chart>
	^ CMChart new
		  title: 'Corporal condition of the cattle';
		  add: (CMLineSeries new
				   x: #currentTimeStep y: #corporalCondition;
				   label: 'Mean of the semester';
				   yourself);
		  add: (CMLineSeries new
				   x: #currentTimeStep y: #mobileCC;
				   label: 'Mean of the last two semesters';
				   yourself);
		  lineAtY: AHCattleBatch thresholdGoodCC label: 'Good condition';
		  lineAtY: AHCattleBatch thresholdLowCC label: 'Low condition';
		  lineAtY: AHCattleBatch thresholdBadCC label: 'Bad condition';
		  yFrom: 0 to: 10;
		  yourself
]

{ #category : 'charts' }
AHModel >> chartCorporalConditionSpread [
	"Are all cattle batches in the same condition, or do some starve while others thrive?"

	<chart>
	^ CMChart new
		  title: 'Corporal condition of the cattle batches';
		  boxesX: #currentTimeStep
		  y: #corporalCondition
		  ofAll: AHCattleBatch;
		  yFrom: 0 to: 10;
		  hideLegend;
		  yourself
]

{ #category : 'charts' }
AHModel >> chartFarms [
	"Who takes the land, and how fast do farms grow?"

	<chart>
	^ CMChart new
		  title: 'Plots of each farm';
		  areasX: #currentTimeStep y: #numberOfPlots ofAll: AHFarm;
		  yTitle: 'Plots';
		  yourself
]

{ #category : 'charts' }
AHModel >> chartHarvest [
	"What is harvested, crop by crop?"

	<chart>
	^ CMChart new
		  title: 'Harvest';
		  add: (CMBarSeries new
				   x: #currentTimeStep y: #yield_Cassava;
				   label: 'Cassava';
				   yourself);
		  add: (CMBarSeries new
				   x: #currentTimeStep y: #yield_Cotton;
				   label: 'Cotton';
				   yourself);
		  add: (CMBarSeries new
				   x: #currentTimeStep y: #yield_Maize;
				   label: 'Maize';
				   yourself);
		  add: (CMBarSeries new
				   x: #currentTimeStep y: #yield_Soya;
				   label: 'Soya';
				   yourself);
		  yTitle: 'kg';
		  yourself
]

{ #category : 'charts' }
AHModel >> chartLandUse [
	"How do crops, fallows and natural covers share the land over the years?"

	<chart>
	^ CMChart new
		  title: 'Land use';
		  areasX: #currentTimeStep y: #landcover ofAll: AHPlot;
		  yTitle: 'Plots';
		  yourself
]

{ #category : 'charts' }
AHModel >> chartMoneyOfFarmers [
	"Which farmer gets richer?"

	<chart>
	^ CMChart new
		  title: 'Money of farmers';
		  linesX: #currentTimeStep y: #money ofAll: AHFarmer;
		  yourself
]

{ #category : 'charts' }
AHModel >> chartMoneyOfHerders [
	"Which herder gets richer?"

	<chart>
	^ CMChart new
		  title: 'Money of herders';
		  linesX: #currentTimeStep y: #money ofAll: AHHerder;
		  yourself
]

{ #category : 'charts' }
AHModel >> chartSoilFertility [
	"Do soils get richer or poorer, on the whole and where nobody farms?"

	<chart>
	^ CMChart new
		  title: 'Soil fertility';
		  add: (CMLineSeries new
				   x: #currentTimeStep y: #globalFertility;
				   label: 'Mean of all plots';
				   yourself);
		  add: (CMLineSeries new
				   x: #currentTimeStep y: #naturalZoneFertility;
				   label: 'Mean of natural covers';
				   yourself);
		  yourself
]

{ #category : 'charts' }
AHModel >> chartSoilFertilitySpread [
	"Do all plots keep their fertility, or do some get exhausted?"

	<chart>
	^ CMChart new
		  title: 'Soil fertility of the plots';
		  boxesX: #currentTimeStep y: #soilFertility ofAll: AHPlot;
		  hideLegend;
		  yourself
]

{ #category : 'probes' }
AHModel >> conflicts [
	"Answer the number of conflicts of this semester"

	<probe>
	^ self thePlots sum: [ :p | p conflicts ]
]

{ #category : 'probes' }
AHModel >> conflictsAverage [
	"retourne le nombre total de conflits, pour suivre l'evolution de tout le troupeau"

	<probe>
	self currentTimeStep = 0 ifTrue: [ ^0 ].
	^ (cumulConflicts / self currentTimeStep) asFloat
]

{ #category : 'probes' }
AHModel >> corporalCondition [
	"evolution de CC moyen de tout le troupeau (moyenne pondérée) "

	<probe>
	| heads |
	self @@ AHCattleBatch ifEmpty: [ ^ 0 ].
	heads := (self @@ AHCattleBatch collect: [ :each | each heads ]) sum.
	heads = 0 ifTrue: [ ^ 0 ].
	^ ((self @@ AHCattleBatch collect: [ :each |
		   each heads * each corporalCondition ]) sum / heads) asFloat
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
	(aTypeOfAgent inheritsFrom: AHHerder)
		ifFalse: [ ag house: (self villagePlots at: ag id) ]
		ifTrue: [
				ag house:
					(aFarm components detect: [ :c | c cover class = AHFulaniCamp ]) ].
	ag class = AHExternalProprietary ifFalse: [
			ag moveTo: ag house.
			(aFarm includesCell: ag house) ifFalse: [
				aFarm addComponent: ag house ] ]
]

{ #category : 'probes' }
AHModel >> cumulConflicts [
	"retourne le nombre total de conflits, pour suivre l'evolution de tout le troupeau"

	"<probeNamed: 'cumulConflicts' color: '9B3429'>"
	^ cumulConflicts
]

{ #category : 'accessing' }
AHModel >> cumulConflicts: anObject [

	cumulConflicts := anObject
]

{ #category : 'accessing' }
AHModel >> doesPopulationGrow [

	<parameterBooleanDefault: true>
	^ doesPopulationGrow
]

{ #category : 'accessing' }
AHModel >> doesPopulationGrow: anObject [

	doesPopulationGrow := anObject
]

{ #category : 'accessing' }
AHModel >> expansionFrequency [
"The farms expand every 10 Years"
	<parameterIntegerMin: 0 max: 200 default: 10>
	^ expansionFrequency
]

{ #category : 'accessing' }
AHModel >> expansionFrequency: anObject [

	expansionFrequency := anObject
]

{ #category : 'probes' }
AHModel >> farmsArea [

	<probe>
	^ (self @@ AHPlot select: [ :p | p belongsToSomebody]) size
]

{ #category : 'accessing' }
AHModel >> forestPlots [
	"return the cells in  forest"

	^ self plotsCoveredBy: AHForest
]

{ #category : 'probes' }
AHModel >> globalFertility [
"moyenne de la fertilité de tous les plots : #(2 6 7) average"
	<probe>
	^ (self @@ AHPlot collect: [ :p | p soilFertility ]) average asFloat
]

{ #category : 'initialization' }
AHModel >> init [
	"	<init>"
	
	cumulConflicts := 0.
	self
		createGridNumberOfRows: 8
		numberOfColumns: 8
		neighbourhood: 6
		closed: true.
	self initLandcover.

	self initFarmsAndAgents.
	self createCattles.

	self @@ AHFarmer do: #setNobodysPlots.
	self makeAgentsScatteredInCells.
	context currentTimeStep: 0.

"	AHPlot activePovSelector: #povLandcover.
	AHFarm activePovSelector: #povBorder."
	
]

{ #category : 'initialization' }
AHModel >> initFarmsAndAgents [

	self createOneFarmFrom: #( 17 18 25 26 27 33 ) forAgent: AHFarmer.
	self createOneFarmFrom: #( 35 36 37 43 44 ) forAgent: AHFarmer.
	self createOneFarmFrom: #( 32 40 ) forAgent: AHSedentary.
	self createOneFarmFrom: #( 57 58 ) forAgent: AHSedentary.

	"Ferme de cajou, proprietaires externes"
	"	farmCells := self thePlots select: [ :c | #( 29 30 ) includes: c id ].
	self createAggregate: AHFarm from: farmCells.

	farmCells := self thePlots select: [ :c | #( 46 47 ) includes: c id ].
	self createAggregate: AHFarm from: farmCells."

	self createOneFarmFrom: #( 29 30 ) forAgent: AHExternalProprietary.
	self
		createOneFarmFrom: #( 46 47 51 52 60 61 )
		forAgent: AHExternalProprietary.

	self newEntity: AHTranshumant. "locatedAt: (self cellAt: 1 at: 1)"
	"act, c'est l'acteur en question, self allEntities est une collection de mes cinq acteurs"
	(self allEntitiesOfClass: AHActor) do: [ :act |
			act territory: self thePlots.
			act others: (self allEntitiesOfClass: AHActor).
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
		(self cellAt: i) setLandcover: AHSoya ].
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
AHModel >> initWithAgreement [

	<init>
	<perspective: #perspectiveEcology >
	self init.
	self @@ AHActor do: [ :act | act agreement: true ]
]

{ #category : 'initialization' }
AHModel >> initWithoutAgreement [

	<init>
	<perspective: #perspectiveEcology >
	self init.
	self @@ AHActor do: [ :act | act agreement: false ]
]

{ #category : 'testing' }
AHModel >> isDrySeason [
	"répond si nous sommes en saison sêche, ou non (t = even (pair)) "

	^ self currentTimeStep even
]

{ #category : 'probes' }
AHModel >> mobileCC [
	"evolution de CC moyen de tout le troupeau (moyenne pondérée) "

	<probe>
	| heads |
	self @@ AHCattleBatch ifEmpty: [ ^ 0 ].
	heads := (self @@ AHCattleBatch collect: [ :each | each heads ]) sum.
	heads = 0 ifTrue: [ ^ 0 ].
	^ ((self @@ AHCattleBatch collect: [ :each |
		   each heads * each mobileCC ]) sum / heads) asFloat
]

{ #category : 'probes' }
AHModel >> moneyFarmers [

	<probe>
	^ self @@ AHFarmer sum: [ :p | p money ]
]

{ #category : 'probes' }
AHModel >> moneyHerders [

	<probe>
	^ self @@ AHHerder sum: [ :p | p money ]
]

{ #category : 'probes' }
AHModel >> naturalBiomass [
	<probe>

	| vegetations |
	vegetations := self @@ AHPlot select: [ :p |
		    p cover isKindOf: AHNaturalVegetation ]. 
	vegetations ifEmpty: [ ^0 ] ifNotEmpty: [ ^(vegetations collect: [ :p |
		   p cover biomass ]) average]
]

{ #category : 'probes' }
AHModel >> naturalZoneFertility [
	"moyenne de la fertilité des plots en natural fertility : #(2 6 7) average"

	<probe>
	| coll |
	"coll := OrderedCollection new.
	coll addAll: (self plotsCoveredBy: AHForest).
	coll addAll: (self plotsCoveredBy: AHPasture).
	coll addAll: (self plotsCoveredBy: AHBush ).
	coll addAll: (self plotsCoveredBy: AHFallow )."
	coll := self plotsCoveredBy: AHNaturalVegetation.
	coll isEmpty ifTrue: [ ^ 0 ].
	^ (coll collect: [ :p | p soilFertility ]) average
]

{ #category : 'perspectives' }
AHModel >> perspectiveEcology [
	"The land covers, the farms of each actor, and the actors and their cattle as pictures"

	<perspective>
	^ CMPerspective new
		  show: AHPlot as: #aspectLandcover:;
		  show: AHFarm as: #aspectBorder:;
		  show: AHFarmer as: #aspectImage:;
		  show: AHSedentary as: #aspectImage:;
		  show: AHCattleBatch as: #aspectImage:;
		  yourself
]

{ #category : 'accessing' }
AHModel >> plotsCoveredBy: aTypeOfCover [
	"return the cells covered by aTypeOfCover"

	^ self thePlots select: [ :c | c cover isKindOf: aTypeOfCover ]
]

{ #category : 'control' }
AHModel >> stepDrySeason [
	"t = pair (even) => dry season"

	self @@ AHActor do: #resetHarvest.
	self @@ AHActor do: #harvest.
	self thePlots do: #stepDrySeason. "Evolution naturelle des couverts"
	(self shuffled: (self allEntitiesOfClass: AHHerder)) do: #moveHerd.
	self @@ AHActor do: #sow.
	self @@ AHCattleBatch reverseDo: #naturalMortality
]

{ #category : 'control' }
AHModel >> stepRainySeason [
	"t = semester. t impair (odd) => rainy season"

	self @@ AHActor do: #harvestCasava.
	self thePlots do: #stepRainySeason.
	(self shuffled: (self allEntitiesOfClass: AHHerder)) do: #moveHerd.
	self @@ AHCattleBatch reverseDo: #naturalMortality.
	self @@ AHCattleBatch do: #reproduce.
	"Farms expansion"
	doesPopulationGrow ifTrue: [ "comme currentTime est toujours impair en rainyStep, il faut rajouter 1"
			(self currentTimeStep + 1 / (self expansionFrequency * 2))
				isInteger ifTrue: [
				(self shuffled: self @@ AHFarmer) do: #expandFarm ] ]
]

{ #category : 'control' }
AHModel >> stepSemester [
	"t = 1 => rainy season, si t est pair => dry season"

	<control>
	self @@ AHPlot do: #resetCowsCounter.
	self @@ AHCattleBatch do: #setPreviousCC.
	self isDrySeason
		ifTrue: [ self stepDrySeason "pair" ]
		ifFalse: [ self stepRainySeason ].
	cumulConflicts := cumulConflicts + self conflicts
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
AHModel >> totalHarvest [

	<probe>

	^ self @@ AHFarmer sum: [ :p | p sumOfTotalHarvest ]
]

{ #category : 'probes' }
AHModel >> totalResidue [
	<probe>

	^ ((self @@ AHPlot select: [ :p |
		    p cover isKindOf: AHCultivatedVegetation ]) collect: [ :p |
		   p cover biomass ]) average
]

{ #category : 'accessing' }
AHModel >> villagePlots [
	"return the 3 FarmerHouse cells"

	^ self plotsCoveredBy:  AHFarmerHouse
]

{ #category : 'probes' }
AHModel >> yield_Cassava [

	<probe>
	^ self @@ AHActor sum: [ :p | p totalHarvest at: AHCassava ]
]

{ #category : 'probes' }
AHModel >> yield_Cotton [

	<probe>
	^ self @@ AHActor sum: [ :p | p totalHarvest at: AHCotton ]
]

{ #category : 'probes' }
AHModel >> yield_Maize [

	<probe>
	^ self @@ AHActor sum: [ :p | p totalHarvest at: AHMaize ]
]

{ #category : 'probes' }
AHModel >> yield_Soya [

	<probe>
	^ self @@ AHActor sum: [ :p | p totalHarvest at: AHSoya ]
]
