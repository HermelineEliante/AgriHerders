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
AHFarmer >> initialize [

	super initialize.
	agreement := true.
	money := 1.
	
	
]

{ #category : 'control' }
AHFarmer >> nextCrop [
]

{ #category : 'control' }
AHFarmer >> ranyStep [

	
]
