Class {
	#name : 'AHHerder',
	#superclass : 'AHActor',
	#instVars : [
		'herd'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHHerder >> bestFallowAndBushPlot [
	"retourne le plot en Pasture, non paturé et avec la biomasse max, ou nil s'il n'y a pas de pasture libre et avec de la biomasse"

	| freePlots biomassMax |
	freePlots := self fallowAndBushPlots select: [ :c |
		             c hasNoOccupants and: [ c cover biomass > 0 ] ].
	freePlots := freePlots sorted: [ :a :b |
		             a cover biomass > b cover biomass ].
	freePlots isEmpty
		ifTrue: [ ^ nil ]
		ifFalse: [
				biomassMax := freePlots first cover biomass.
				^ self selectRandomlyFrom:
					  (freePlots select: [ :p | p cover biomass = biomassMax ]) ]
]

{ #category : 'accessing' }
AHHerder >> bestForestPlot [
	"retourne le plot en Foret, non paturé et avec la biomasse max, ou nil s'il n'y a pas de pasture libre et avec de la biomasse"

	| freePlots biomassMax |
	freePlots := self forestPlots select: [ :c |
		             c hasNoOccupants and: [ c cover biomass > 0 ] ].
	freePlots := freePlots sorted: [ :a :b |
		             a cover biomass > b cover biomass ].
	freePlots isEmpty
		ifTrue: [ ^ nil ]	ifFalse: [ biomassMax := freePlots first cover biomass.
			^(self selectRandomlyFrom: (freePlots select: [ :p | p cover biomass = biomassMax]) )]
]

{ #category : 'accessing' }
AHHerder >> bestOpenedPlot [

	| freePlots biomassMax |
	freePlots:= OrderedCollection new .  
self others do: [: a | freePlots addAll: a openedPlotsForCoralling].
	freePlots := freePlots select: [ :c |
		             c hasNoOccupants and: [ c cover biomass > 0 ] ].
	freePlots := freePlots sorted: [ :a :b |
		             a cover biomass > b cover biomass ].
	freePlots isEmpty
		ifTrue: [ ^ nil ]
		ifFalse: [
				biomassMax := freePlots first cover biomass.
				^ self selectRandomlyFrom:
					  (freePlots select: [ :p | p cover biomass = biomassMax ]) ]
]

{ #category : 'accessing' }
AHHerder >> bestPasturePlot [
	"retourne le plot en Pasture, non paturé et avec la biomasse max, ou nil s'il n'y a pas de pasture libre et avec de la biomasse"

	| freePlots biomassMax |
	freePlots := self pasturePlots select: [ :c |
		             c hasNoOccupants and: [ c cover biomass > 0 ] ].
	freePlots := freePlots sorted: [ :a :b |
		             a cover biomass > b cover biomass ].
	freePlots isEmpty
		ifTrue: [ ^ nil ]
		ifFalse: [ biomassMax := freePlots first cover biomass.
			^(self selectRandomlyFrom: (freePlots select: [ :p | p cover biomass = biomassMax]) )]
]

{ #category : 'controlling' }
AHHerder >> dry_MoveOneCattleBatch: aBatch [
	" Si le besoin du aBatch (avec plusieurs heads) est supérieur à 0, je les envoie d'abord sur les meilleurs plots que mes collègues ont ouvert:
	sinon je les envoie sur d'autres plots en foret pour satisfaire leur besoin restant.
	Priorité 1 : Pasture, 2 : Fallow & bush, 3 : Forest. "

	| needs targetPlot visitedPlots |
	visitedPlots := OrderedCollection new.
	needs := aBatch totalNeeds. "self halt."

	[needs > 0 and: [
				targetPlot := self bestOpenedPlot.
				targetPlot isNil not ] ] whileTrue: [
			aBatch moveTo: targetPlot.
			needs := aBatch eatForNeeds: needs.
			visitedPlots add: targetPlot ].


	[ needs > 0 and: [ self existNaturalPlotsWithBiomass ] ] whileTrue: [
			targetPlot := self bestPasturePlot.
			targetPlot isNil
				ifTrue: [
						targetPlot := self bestFallowAndBushPlot.
						targetPlot isNil
							ifFalse: [
									aBatch moveTo: targetPlot.
									needs := aBatch eatForNeeds: needs.
									visitedPlots add: targetPlot ]
							ifTrue: [
									targetPlot := self bestForestPlot.
									targetPlot isNil ifFalse: [
											aBatch moveTo: targetPlot.
											needs := aBatch eatForNeeds: needs.
											visitedPlots add: targetPlot ] ] ]
				ifFalse: [
						aBatch moveTo: targetPlot.
						needs := aBatch eatForNeeds: needs.
						visitedPlots add: targetPlot ] ].
	aBatch defecateOn: visitedPlots
]

{ #category : 'accessing' }
AHHerder >> existNaturalPlotsWithBiomass [
	"repond si il y a des natural plots avec de la biomasse et non occupés"

	^ self naturalPlots
		  detect: [ :p | p cover biomass > 0 and: [ p hasNoOccupants] ]
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

{ #category : 'accessing' }
AHHerder >> initialize [ 
	super initialize .
	self herd: OrderedCollection new.
]

{ #category : 'controlling' }
AHHerder >> moveHerd [
	" Si le besoin des animaux est supérieur à 0, je les envoie sur les meilleurs pâturages sinon, je les envoie sur d'autres plots pour satisfaire leur besoin restant."

	self herd do: [ :aBatch | self isDrySeason ifFalse: [ self rainy_MoveOneCattleBatch: aBatch ] ifTrue: [ self dry_MoveOneCattleBatch: aBatch ] ]
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
	" Si le besoin du aBatch (avec plusieurs heads) est supérieur à 0, je les envoie sur les meilleurs pâturages:
	sinon je les envoie sur d'autres plots en foret pour satisfaire leur besoin restant.
	Priorité 1 : Pasture, 2 : Fallow & bush, 3 : Forest. "

	| needs targetPlot visitedPlots |
	visitedPlots := OrderedCollection new.
	needs := aBatch totalNeeds. "self halt."
	[ needs > 0 and: [ self existNaturalPlotsWithBiomass ] ] whileTrue: [
			targetPlot := self bestPasturePlot.
			targetPlot isNil
				ifTrue: [
						targetPlot := self bestFallowAndBushPlot .
						targetPlot isNil ifFalse: [
								aBatch moveTo: targetPlot.
								needs := aBatch eatForNeeds: needs.
								visitedPlots add: targetPlot ] 
							ifTrue: [ 
						targetPlot := self bestForestPlot.
						targetPlot isNil ifFalse: [
								aBatch moveTo: targetPlot.
								needs := aBatch eatForNeeds: needs.
								visitedPlots add: targetPlot ] ]]
				ifFalse: [
						aBatch moveTo: targetPlot.
						needs := aBatch eatForNeeds: needs.
						visitedPlots add: targetPlot ] ].
	aBatch defecateOn: visitedPlots
]
