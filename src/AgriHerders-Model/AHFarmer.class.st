Class {
	#name : 'AHFarmer',
	#superclass : 'AHActor',
	#instVars : [
		'nobodysPlots'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHFarmer >> color [

	id = 1 ifTrue: [ ^ CMColor orange ].
	id = 2 ifTrue: [ ^ CMColor olympic ].
	^ CMColor colorOfNumber: self id + 2
]

{ #category : 'control' }
AHFarmer >> dryStep [
	"Au début de la saison sèche : récolte et décision de semis. D'abord la récolte des cultures existantes"

"	self harvest"
]

{ #category : 'control' }
AHFarmer >> expandFarm [
	"Chaque 10 ans (Lié à l’augmentation démographique de la famille), l’agriculteur décide d’augmenter sa surface en augmentant 2 plots supplémentaires. Il choisit donc deux  parcelles. il sélectionne les parcelles libres les plus proche de sa maison. Une parcelle libre est celle sans propriétaire, donc celle ayant un couvert de type parcours naturel ou de type forêt. S’il y a des troupeaux sur les nouvelles parcelles qu’il veut exploiter, il les chasse (renvoie) dans leur campement."

	| counter |
	nobodysPlots := nobodysPlots select:[ :p | p myFarm isNil ].
	counter := 0.
	nobodysPlots do: [ :p |
			self myFarm addComponent: p.
			(p occupantsOfClass: AHCattleBatch) do: #goHome.
			counter := counter + 1.
			counter >= 2 ifTrue: [ ^ self ] ]
]

{ #category : 'control' }
AHFarmer >> harvest [
	"Au début de la saison sèche, toutes les cultures matures de sa ferme sont récoltées"

	"pour acceder à toutes les cellules de la ferme : self myFarm components"

	"La récolte sera vendue. Puis, sera ajouté à l'argent que le fermier possède le prix de la culture et il va rester sur le plot des résidus"

	self myFarm components do: [ :plot | 
			plot cover isMature ifTrue: [
					self money:
						self money + (plot cover yield * plot cover price).
					plot cover biomass: plot cover residue ] ]
]

{ #category : 'control' }
AHFarmer >> harvestCasava [
	"Au début de la saison des pluies, tous les maniocs matures de sa ferme sont récoltées"
	"La récolte sera vendue. Puis, sera ajouté à l'argent que le fermier possède le prix de la culture et il va rester sur le plot des résidus"

	(self myFarm components select: [:p | p cover class = AHCassava]) do: [ :plot |
			plot cover isMature ifTrue: [
					self money: self money + (plot cover yield * plot cover price).
					plot cover biomass: plot cover residue ] ]
]

{ #category : 'pov' }
AHFarmer >> pov [

	<pov>
	id = 1
		ifTrue: [ ^CMPointOfView tile: AHTilesSet farmer size: 0.7 ]
		ifFalse: [ ^ CMPointOfView tile: AHTilesSet farmerColored size: 0.7 ]
]

{ #category : 'control' }
AHFarmer >> rainyStep [

	self harvestCasava.
]

{ #category : 'initialization' }
AHFarmer >> setNobodysPlots [
	"L’agriculteur sélectionne les parcelles libres les plus proche de sa maison. Une parcelle libre est celle sans propriétaire, donc celle ayant un couvert de type parcours naturel ou de type forêt. 
	Cette routine est lancée à l'initialisation pour des raisons d'optimisation (car sorted prend bcp de temps)"

	nobodysPlots := self territory select: [ :p | p myFarm isNil ].
	nobodysPlots := nobodysPlots asSortedCollection: [ :p1 :p2 |
		             (p1 distanceTo: self house)
		             < (p2 distanceTo: self house) ].
]

{ #category : 'pov' }
AHFarmer >> shape [ 
^#circle
]

{ #category : 'control' }
AHFarmer >> sow [
	"Si il n'y a pas de manioc dans mes parcelles, je choisis une des parcelles en jachère, la moins fertile pour y implanter du manioc. 
	Pour les autres cultures: Quand le niveau de fertilité des plots de ma propriété est supérieur à 6, et qu'il n'y pas de culture, il fait du coton. Lorsqu’il est supérieur à 4 il fait le maïs, dans le cas contraire il cultive le soja."

	| collTriee cellCiblee |
	(self myFarm components select: [ :p | p cover class = AHCassava ])
		isEmpty ifTrue: [ "plotWithFallow := self myFarm components
				                  detect: [ :p | p cover class = AHFallow ]
				                  ifNone: [ nil ].
			plotWithFallow ifNotNil: [plotWithFallow setLandcover: AHCassava ] "
			collTriee := (self myFarm components select: [ :p |
				              p cover class = AHFallow ]) sorted: [ :a :b |
				             a soilFertility <= b soilFertility ].
			cellCiblee := collTriee first.
			cellCiblee setLandcover: AHCassava ].

	"autres cultures"
	(self myFarm components select: [ :p | "p cover class = AHFallow "
		 p cover isKindOf: AHNaturalVegetation ]) do: [ :plot |
		self sowOnPlot: plot ]
]

{ #category : 'control' }
AHFarmer >> sowOnPlot: aPlot [
	"Quand le niveau de fertilité des plots de ma propriété est supérieur à 6, et qu'il n'y pas de culture, il fait du coton. Lorsqu’il est supérieur à 4 il fait le maïs, dans le cas contraire il cultive le soja."


			aPlot soilFertility >= 6 ifTrue: [ ^aPlot setLandcover: AHCotton ].
			aPlot soilFertility >= 4 ifTrue: [ ^aPlot setLandcover: AHMaize ].
			^aPlot setLandcover: AHSoja
]
