Class {
	#name : 'AHFarmer',
	#superclass : 'AHActor',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHFarmer >> dryStep [
	"Au début de la saison sèche : récolte et décision de semis. D'abord la récolte des cultures existantes"

"	self harvest"
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

{ #category : 'control' }
AHFarmer >> ranyStep [

	
]

{ #category : 'control' }
AHFarmer >> sow [
	"Si il n'y a pas de manioc dans mes parcelles, je choisis une de parclles en jachère, la moins fertile pour y implanter du manioc. Pour les autres cultures: Quand le niveau de fertilité des plots de ma propriété est supérieur à 6, et qu'il n'y pas de culture, il fait du coton. Lorsqu’il est supérieur à 4 il fait le maïs, dans le cas contraire il cultive le soja."

	| collTriee cellCiblee |
	(self myFarm components select: [ :p | p cover class = AHCassava ])
		isEmpty ifTrue: [ "plotWithFallow := self myFarm components
				                  detect: [ :p | p cover class = AHFallow ]
				                  ifNone: [ nil ].
			plotWithFallow ifNotNil: [plotWithFallow setLandcover: AHCassava ] "
			collTriee := ((self myFarm components select: [ :p | p cover class = AHFallow ])
				 sorted: [ :a :b | a soilFertility <= b soilFertility ]).
			cellCiblee := collTriee first.
			cellCiblee	setLandcover: AHCassava ].

	"autres cultures"
	(self myFarm components select: [ :p | p cover class = AHFallow ])
		do: [ :plot | self sowOnPlot: plot ]
]

{ #category : 'control' }
AHFarmer >> sowOnPlot: aPlot [
	"Quand le niveau de fertilité des plots de ma propriété est supérieur à 6, et qu'il n'y pas de culture, il fait du coton. Lorsqu’il est supérieur à 4 il fait le maïs, dans le cas contraire il cultive le soja."


			aPlot soilFertility >= 6 ifTrue: [ ^aPlot setLandcover: AHCotton ].
			aPlot soilFertility >= 4 ifTrue: [ ^aPlot setLandcover: AHMaize ].
			^aPlot setLandcover: AHSoja
]
