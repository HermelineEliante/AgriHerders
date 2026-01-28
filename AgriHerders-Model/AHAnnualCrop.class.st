Class {
	#name : 'AHAnnualCrop',
	#superclass : 'AHCultivatedVegetation',
	#instVars : [
		'residue'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHAnnualCrop >> dryStep [
	"A la fin de la saison seche, l'annual crop devient Fallow"

	| fallow |
	super dryStep.
	fallow := self cell setLandcover: AHFallow.
	fallow biomass: self residue.
	isDead := true
]

{ #category : 'control' }
AHAnnualCrop >> rainyStep [
	"La croissance des cultures est en fonction du niveau de fertilité de son plot et de la demande en NPK de chaque type de culture. Pour l’instant, elle ne sera qu’en fonction de la fertilité qui englobe la dimension NPK. Le rendement de chaque culture dépend du niveau optimal de fertilité demandé par la plante. Quand le niveau de fertilité est optimal ou plus, le rendement de la culture est égal au rendement espéré. Si le niveau de fertilité est inférieur, le rendement sera proportionnel à la différence entre optimal fertility et fertility effective.
Yield= Expected yield*(soilFertility/optimalFertility) avec un maximum = expected yield
Dans le même temps, la plante aura pompé une quantité de fertilité égale au niveau optimal de fertilité de chaque culture (Soil fertility initiale-optimal fertility= Plot fertility). 
La quantité de résidus produite par le maïs et de 7 kg MS/ha, 1 kg MS/ha pour le coton et 2 kg MS/ha pour le soja. "

	super rainyStep.
	self biomass: self residue + self yield 
]

{ #category : 'accessing' }
AHAnnualCrop >> residue [

	^ residue
]

{ #category : 'accessing' }
AHAnnualCrop >> residue: anObject [

	residue := anObject
]
