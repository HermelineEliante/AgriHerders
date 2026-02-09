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

{ #category : 'accessing' }
AHHerder >> existNaturalPlotsWithBiomass [
	"repond si il y a des natural plots avec de la biomasse et non occupés"

	^ self naturalPlots
		  detect: [ :p | p cover biomass > 0 and: [ p hasNoOccupants] ]
		  ifFound: [ true ]
		  ifNone: [ false ]
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

	self herd do: [ :aBatch |
			self moveOneCattleBatch: aBatch  ]
]

{ #category : 'controlling' }
AHHerder >> moveOneCattleBatch: aBatch [
	" Si le besoin du aBatch (avec plusieurs heads) est supérieur à 0, je les envoie sur les meilleurs pâturages, sinon je les envoie sur d'autres plots en foret pour satisfaire leur besoin restant."

	| needs targetPlot totalNeeds |
	totalNeeds := aBatch heads * aBatch dailyForrageNeed * 183. 
	needs := totalNeeds. "self halt."
	[ needs > 0 and: [ self existNaturalPlotsWithBiomass ] ] whileTrue: [
			targetPlot := self bestPasturePlot.
			targetPlot isNil
				ifTrue: [
						targetPlot := self bestForestPlot.
						targetPlot isNil ifFalse: [
								aBatch moveTo: targetPlot.
								needs := aBatch eatForNeeds: needs ] ]
				ifFalse: [
						aBatch moveTo: targetPlot.
						needs := aBatch eatForNeeds: needs ] ].
	needs > 0
		ifTrue: [
			aBatch corporalCondition:
				10 * (1 - (totalNeeds - needs / totalNeeds)) ]
		ifFalse: [ aBatch corporalCondition: 10 ]
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
