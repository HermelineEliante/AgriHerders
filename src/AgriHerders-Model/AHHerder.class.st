Class {
	#name : 'AHHerder',
	#superclass : 'AHActor',
	#instVars : [
		'herd'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'controlling' }
AHHerder >> aggregateHerds [
	" Si j'ai des troupeaux trop petits, je les fusionne"

	| smallBatches oneSmallBatch averageCorporalCondition totalHeads |
	smallBatches := self herd select: [ :aBatch | aBatch heads < 3 ].
	smallBatches ifEmpty: [ ^ self ].
	totalHeads := (smallBatches collect: [ :h | h heads]) sum.
	averageCorporalCondition := (smallBatches collect: [ :h | h corporalCondition * h heads]) sum / totalHeads "moyenne pondérée".
	oneSmallBatch := smallBatches removeFirst.
	oneSmallBatch corporalCondition: averageCorporalCondition.
	oneSmallBatch heads: totalHeads.
	smallBatches do: #die
]

{ #category : 'accessing' }
AHHerder >> anyPlotsWithBiomass [
	"Return plots of the territory with biomass, whatever if they are opened or not"

	
	^ territory select: [ :p | p cover biomass > 0 ]
]

{ #category : 'accessing' }
AHHerder >> authorizedfallowAndBushPlots [
	"retourne toutes les plots en Pasture"

	^ self fallowAndBushPlots select: [ :c | c isOpenForCorraling]
]

{ #category : 'accessing' }
AHHerder >> authorizedfallowAndBushPlotsWithBiomass [
	"retourne toutes les plots en fallow & bush avec biomasse"

	^ self authorizedfallowAndBushPlots select: [ :c | c cover biomass > 0 ]
]

{ #category : 'accessing' }
AHHerder >> bestFallowAndBushPlot [
	"retourne le plot en Pasture, non paturé et avec la biomasse max, ou nil"

	^ self bestPlotInto: self fallowAndBushPlots
]

{ #category : 'accessing' }
AHHerder >> bestForestPlot [
	"retourne le plot en Foret, non paturé et avec la biomasse max, ou nil"

	^ self bestPlotInto: self forestPlots
]

{ #category : 'accessing' }
AHHerder >> bestOpenedPlot [
	"répond NIL ou un plot ouvert non occupé et avec de la biommasse"

	| openedPlots |
	openedPlots := OrderedCollection new.
	self others do: [ :actor | openedPlots addAll: actor openedPlotsForCoralling ].

	^ self bestPlotInto: openedPlots
]

{ #category : 'accessing' }
AHHerder >> bestPasturePlot [
	"retourne le plot en Pasture, non paturé et avec la biomasse max, ou nil s'il n'y a pas de pasture libre ou sans biomasse"

	^ self bestPlotInto: self pasturePlots
]

{ #category : 'accessing' }
AHHerder >> bestPlotInto: aListOfPlots [
	"retourne le plot de aListOfPlots, non paturé et avec la biomasse max, ou nil s'il n'y a pas de plot libre ou sans biomasse"

	| freePlots biomassMax |
	freePlots := aListOfPlots select: [ :c |
		             (c hasOccupantsOfClass: AHCattleBatch) not and: [
			             c cover biomass > 0 ] ].

	freePlots isEmpty ifTrue: [ ^ nil ].
	biomassMax := (freePlots collect: [ :p | p cover biomass ]) max. "collecte toutes les biomasses et retourne la plus élevée"
	^ self selectRandomlyFrom:
		  (freePlots select: [ :p | p cover biomass = biomassMax ])
]

{ #category : 'controlling' }
AHHerder >> dry_MoveOneCattleBatch: aBatch [
	" Si le besoin du aBatch (avec plusieurs heads) est supérieur à 0, je les envoie d'abord sur les meilleurs plots que mes collègues ont ouvert (bestOpenedPlot).
	Puis je les envoie sur d'autres 'natural plots' pour satisfaire leur besoin restant :
	Priorité 1 : Pasture, 2 : Fallow & bush, 3 : Forest. "

	| visitedPlots conflictingPlots |
	visitedPlots := OrderedCollection new.
	aBatch needs: aBatch totalNeeds.
	"1- D'abord sur les bestOpenedPlots"
	aBatch needs > 0 ifTrue: [
			visitedPlots addAll:
				(aBatch moveAndFeedOnPlots: self openedPlotsWithBiomass) ].
	"2- Puis sur les natural plots"
	aBatch needs > 0 ifTrue: [
		visitedPlots addAll: (self moveToNaturalPlotsOneCattleBatch: aBatch) ].
	aBatch updateCorporalCondition.
	"3- Enfin, si mes vaches sont encore affamées, je les envoie dans des parcelles cultivées"
	aBatch isStarving ifTrue: [
			conflictingPlots := aBatch moveAndFeedOnPlots:
				                    (self anyPlotsWithBiomass "self plotsWithBiomassAround: visitedPlots").
			(conflictingPlots select: [ :c | c isOpenForCorraling not ]) do: [
				:p | p conflicts: p conflicts + 1 ].
			visitedPlots addAll: conflictingPlots.
			aBatch updateCorporalCondition ].

	aBatch defecateOn: visitedPlots
]

{ #category : 'testing' }
AHHerder >> existFreeNaturalPlotsWithBiomass [
	"repond si il y a des natural plots avec de la biomasse et non occupés"

	^ self naturalPlots
		  detect: [ :p |
			  p cover biomass > 0 and: [
				  (p hasOccupantsOfClass: AHCattleBatch) not ] ]
		  ifFound: [ true ]
		  ifNone: [ false ]
]

{ #category : 'testing' }
AHHerder >> existOpenedPlots [
	"Réponds si mes d'autres acteurs ouvrent leur champ"

	self others
		detect: [ :a | a openedPlotsForCoralling isEmpty not]
 ifFound: [ ^true ] 
		ifNone: [ ^ false ].
]

{ #category : 'accessing' }
AHHerder >> fallowAndBushPlots [
	"retourne toutes les plots en Pasture"

	^ self territory select: [ :c | c cover class = AHBush or:[c cover class = AHFallow ]]
]

{ #category : 'accessing' }
AHHerder >> fallowAndBushPlotsWithBiomass [
	"retourne toutes les plots en fallow & bush avec biomasse"

	^ self fallowAndBushPlots select: [ :c | c cover biomass > 0 ]
]

{ #category : 'accessing' }
AHHerder >> forestPlots [
	"retourne toutes les plots en Foret"

	^ self territory select: [ :c | c cover class = AHForest ]
]

{ #category : 'accessing' }
AHHerder >> forestPlotsWithBiomass [
	"retourne toutes les plots en foret avec biomasse"

	^ self forestPlots select: [ :c | c cover biomass > 0 ]
]

{ #category : 'accessing' }
AHHerder >> herd [

	^ herd
]

{ #category : 'accessing' }
AHHerder >> herd: anObject [

	herd := anObject
]

{ #category : 'initialization' }
AHHerder >> initialize [ 
	super initialize .
	self herd: OrderedCollection new.
]

{ #category : 'controlling' }
AHHerder >> moveHerd [
	" Main activity at each season.
	Si le besoin des animaux est supérieur à 0, je les envoie sur les meilleurs pâturages sinon, je les envoie sur d'autres plots pour satisfaire leur besoin restant."

	"self aggregateHerds."

	self herd do: [ :aBatch |
		aBatch heads > 50 ifTrue: [ aBatch splitInTwo ] ].

	self herd do: [ :aBatch |
			self isDrySeason
				ifFalse: [ self rainy_MoveOneCattleBatch: aBatch ]
				ifTrue: [ self dry_MoveOneCattleBatch: aBatch ] ]
]

{ #category : 'controlling' }
AHHerder >> moveToNaturalPlotsOneCattleBatch: aBatch [
	" Si le besoin du aBatch (avec plusieurs heads) est supérieur à 0, je l'envoie sur les meilleurs pâturages.
	sinon je l'envoie sur d'autres plots en fallow ou en foret pour satisfaire leur besoin restant.
	Priorité 1 : Pasture, 2 : Fallow & bush, 3 : Forest. "

	| visitedPlots |
	visitedPlots := OrderedCollection new.
	aBatch needs > 0 ifTrue: [
			visitedPlots addAll:
				(aBatch moveAndFeedOnPlots: self pasturePlotsWithBiomass) ].
	aBatch needs > 0 ifTrue: [
			visitedPlots addAll: (aBatch moveAndFeedOnPlots:
					 self authorizedfallowAndBushPlotsWithBiomass) ].
	aBatch needs > 0 ifTrue: [
			visitedPlots addAll:
				(aBatch moveAndFeedOnPlots: self forestPlotsWithBiomass) ].

	aBatch needs > 0 ifTrue: [
			aBatch goHome.
			aBatch feedOnPlot.
			visitedPlots add: aBatch cell ].
	^ visitedPlots
]

{ #category : 'accessing' }
AHHerder >> naturalPlots [

	"repond si il y a des natural plots avec de la biomasse et non occupés"

	^ self territory select: [ :c | c cover class = AHPasture or: [ c cover class = AHForest ]]
]

{ #category : 'accessing' }
AHHerder >> naturalPlotsWithBiomass [
	"repond si il y a des natural plots avec de la biomasse et non occupés"

	^ self naturalPlots select: [ :c | c cover biomass > 0 ]
]

{ #category : 'accessing' }
AHHerder >> openedPlots [
	"répond les plots ouverts non occupé et avec de la biommasse + mes propres plots récoltés"

	| openedPlots |
	openedPlots := self myOwnPlotsForCoralling.
	self others do: [ :actor |
		openedPlots addAll: actor openedPlotsForCoralling ].

	^ openedPlots
]

{ #category : 'accessing' }
AHHerder >> openedPlotsWithBiomass [
	"répond les plots ouverts non occupé et avec de la biommasse"

	^ self openedPlots select: [ :c | c cover biomass > 0 ]
]

{ #category : 'accessing' }
AHHerder >> pasturePlots [
"retourne toutes les plots en Pasture"
^self territory select: [ : c| c cover class = AHPasture] 
]

{ #category : 'accessing' }
AHHerder >> pasturePlotsWithBiomass [
	"retourne toutes les plots en Pasture avec biomasse"
	^ self pasturePlots select: [ :c | c cover biomass > 0 ].
]

{ #category : 'accessing' }
AHHerder >> plotsWithBiomassAround: visitedPlots [
	"Return plots around the list of visitedPlots with biomass, whatever if they are opened or not"

	| newPlots |
	newPlots := Set new.
	visitedPlots do: [ :p | newPlots addAll: p neighbourhood ].
	newPlots copy do: [ :p | newPlots addAll: p neighbourhood ].
	newPlots removeAll: visitedPlots.
	^ newPlots asSortedCollection: [ :p1 :p2 |
		  p1 cover biomass > p2 cover biomass ]
]

{ #category : 'controlling' }
AHHerder >> rainy_MoveOneCattleBatch: aBatch [
	" Si le besoin du aBatch (avec plusieurs heads) est supérieur à 0, je les envoie sur les meilleurs pâturages.
	sinon je les envoie sur d'autres plots en foret pour satisfaire leur besoin restant.
	Priorité 1 : Pasture, 2 : Fallow & bush, 3 : Forest. "

	| conflictingPlots visitedPlots |
	aBatch needs: aBatch totalNeeds.
	visitedPlots := self moveToNaturalPlotsOneCattleBatch: aBatch.
	aBatch updateCorporalCondition.
	"Si mes vaches sont encore affamées, je les envoie dans des parcelles cultivées"
	aBatch isStarving ifTrue: [
			conflictingPlots := aBatch moveAndFeedOnPlots: self anyPlotsWithBiomass. "self plotsWithBiomassAround: visitedPlots"
			conflictingPlots "select: [ :c | c isOpenForCorraling not ])" do: [ :p | p conflicts: p conflicts + 1 ]. 
			visitedPlots addAll: conflictingPlots.
			aBatch updateCorporalCondition ].

	aBatch defecateOn: visitedPlots
]
