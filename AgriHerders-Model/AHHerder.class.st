Class {
	#name : 'AHHerder',
	#superclass : 'AHActor',
	#instVars : [
		'herd'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
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

	| freePlots |
	freePlots := OrderedCollection new.
	self others do: [ :a | freePlots addAll: a openedPlotsForCoralling ].
	
	^self bestPlotInto: (freePlots).
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

	| needs targetPlot visitedPlots |
	visitedPlots := OrderedCollection new.
	needs := aBatch totalNeeds. "self halt."

	"D'abord sur les bestOpenedPlots"
	[
		needs > 0 and: [
				targetPlot := self bestOpenedPlot.
				targetPlot isNil not ] ] whileTrue: [
			aBatch moveTo: targetPlot.
			needs := aBatch eatForNeeds: needs.
			visitedPlots add: targetPlot ].
	aBatch defecateOn: visitedPlots.

	"Puis sur les natural plots"
	needs > 0 ifTrue: [ needs := self moveToNaturalPlotsOneCattleBatch: aBatch withNeeds: needs].
	aBatch updateCorporalConditionWith: needs.
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

{ #category : 'controlling' }
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
AHHerder >> forestPlots [
	"retourne toutes les plots en Foret"

	^ self territory select: [ :c | c cover class = AHForest ]
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
	" Si le besoin des animaux est supérieur à 0, je les envoie sur les meilleurs pâturages sinon, je les envoie sur d'autres plots pour satisfaire leur besoin restant."

	"self aggregateHerds."

	self herd do: [ :aBatch |
		aBatch heads > 50 ifTrue: [ aBatch splitInTwo ] ].

	self herd do: [ :aBatch |
			self isDrySeason
				ifFalse: [ self rainy_MoveOneCattleBatch: aBatch ]
				ifTrue: [ self dry_MoveOneCattleBatch: aBatch ]]
]

{ #category : 'controlling' }
AHHerder >> moveToNaturalPlotsOneCattleBatch: aBatch [
	" Si le besoin du aBatch (avec plusieurs heads) est supérieur à 0, je l'envoie sur les meilleurs pâturages.
	sinon je l'envoie sur d'autres plots en fallow ou en foret pour satisfaire leur besoin restant.
	Priorité 1 : Pasture, 2 : Fallow & bush, 3 : Forest. "

	| needs targetPlot visitedPlots |
	visitedPlots := OrderedCollection new.
	needs := aBatch totalNeeds. "self halt."
	[ needs > 0 and: [ self existFreeNaturalPlotsWithBiomass ] ] whileTrue: [
			targetPlot := self bestPasturePlot.
			targetPlot
				ifNil: [
						targetPlot := self bestFallowAndBushPlot.
						targetPlot
							ifNil: [
									targetPlot := self bestForestPlot.
									targetPlot ifNotNil: [
											aBatch moveTo: targetPlot.
											needs := aBatch eatForNeeds: needs.
											visitedPlots add: targetPlot ] ]
							ifNotNil: [
									aBatch moveTo: targetPlot.
									needs := aBatch eatForNeeds: needs.
									visitedPlots add: targetPlot ] ]
				ifNotNil: [
						aBatch moveTo: targetPlot.
						needs := aBatch eatForNeeds: needs.
						visitedPlots add: targetPlot ] ].
	aBatch defecateOn: visitedPlots
]

{ #category : 'controlling' }
AHHerder >> moveToNaturalPlotsOneCattleBatch: aBatch withNeeds: needs [
	" Si le besoin du aBatch (avec plusieurs heads) est supérieur à 0, je l'envoie sur les meilleurs pâturages.
	sinon je l'envoie sur d'autres plots en fallow ou en foret pour satisfaire leur besoin restant.
	Priorité 1 : Pasture, 2 : Fallow & bush, 3 : Forest. "

	| targetPlot visitedPlots currentNeeds |
	visitedPlots := OrderedCollection new.
	currentNeeds := needs.
	[ currentNeeds > 0 and: [ self existFreeNaturalPlotsWithBiomass ] ]
		whileTrue: [
				targetPlot := self bestPasturePlot.
				targetPlot
					ifNil: [
							targetPlot := self bestFallowAndBushPlot.
							targetPlot
								ifNil: [
										targetPlot := self bestForestPlot.
										targetPlot ifNotNil: [
												aBatch moveTo: targetPlot.
												currentNeeds := aBatch eatForNeeds: currentNeeds.
												visitedPlots add: targetPlot ] ]
								ifNotNil: [
										aBatch moveTo: targetPlot.
										currentNeeds := aBatch eatForNeeds: currentNeeds.
										visitedPlots add: targetPlot ] ]
					ifNotNil: [
							aBatch moveTo: targetPlot.
							currentNeeds := aBatch eatForNeeds: currentNeeds.
							visitedPlots add: targetPlot ] ].
	aBatch defecateOn: visitedPlots.
	^currentNeeds
]

{ #category : 'accessing' }
AHHerder >> naturalPlots [

	"repond si il y a des natural plots avec de la biomasse et non occupés"

	^ self territory select: [ :c | c cover class = AHPasture or: [ c cover class = AHForest ]]
]

{ #category : 'accessing' }
AHHerder >> pasturePlots [
"retourne toutes les plots en Pasture"
^self territory select: [ : c| c cover class = AHPasture] 
]

{ #category : 'controlling' }
AHHerder >> rainy_MoveOneCattleBatch: aBatch [
	" Si le besoin du aBatch (avec plusieurs heads) est supérieur à 0, je les envoie sur les meilleurs pâturages.
	sinon je les envoie sur d'autres plots en foret pour satisfaire leur besoin restant.
	Priorité 1 : Pasture, 2 : Fallow & bush, 3 : Forest. "

	| needs |
	needs := self moveToNaturalPlotsOneCattleBatch: aBatch withNeeds: aBatch totalNeeds.
	aBatch updateCorporalConditionWith: needs.
]
