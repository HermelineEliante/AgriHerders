Class {
	#name : 'AHCultivatedVegetation',
	#superclass : 'AHVegetation',
	#instVars : [
		'residue',
		'optimalFertility',
		'expectedYield',
		'price'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHCultivatedVegetation >> dryStep [
	"la récolte de toutes les cultures sauf le manioc.
	Pendant la saison sêche, tous les champs à l’exception du manioc sont récoltés. Avec ou sans l’accord des agriculteurs, les bœufs peuvent s’y rendre pour consommer les résidus car étant en mauvaise condition corporelle. Avant l’arrivée des pluies, les champs sont nettoyés et les agriculteurs sollicitent les animaux des éleveurs pour le parcage rotatif afin de nourrir leur terre en fertilisant organique"

	self residue
]

{ #category : 'accessing' }
AHCultivatedVegetation >> expectedYield [

	^ expectedYield
]

{ #category : 'accessing' }
AHCultivatedVegetation >> expectedYield: anObject [

	expectedYield := anObject
]

{ #category : 'control' }
AHCultivatedVegetation >> initialize [

	super initialize.
	fertilityCoefficient := 1.
	residue := 1
]

{ #category : 'accessing' }
AHCultivatedVegetation >> optimalFertility [

	^ optimalFertility
]

{ #category : 'accessing' }
AHCultivatedVegetation >> optimalFertility: anObject [

	optimalFertility := anObject
]

{ #category : 'accessing' }
AHCultivatedVegetation >> price [

	^ price
]

{ #category : 'accessing' }
AHCultivatedVegetation >> price: anObject [

	price := anObject
]

{ #category : 'control' }
AHCultivatedVegetation >> rainyStep [
"La croissance des cultures est en fonction du niveau de fertilité de son plot et de la demande en NPK de chaque type de culture. Pour l’instant, elle ne sera qu’en fonction de la fertilité qui englobe la dimension NPK. Le rendement de chaque culture dépend du niveau optimal de fertilité demandé par la plante. Quand le niveau de fertilité est optimal ou plus, le rendement de la culture est égal au rendement espéré. Si le niveau de fertilité est inférieur, le rendement sera proportionnel à la différence entre optimal fertility et fertility effective.
Yield= Expected yield*(soilFertility/optimalFertility) avec un maximum = expected yield
Dans le même temps, la plante aura pompé une quantité de fertilité égale au niveau optimal de fertilité de chaque culture (Soil fertility initiale-optimal fertility= Plot fertility). 
La quantité de résidus produite par le maïs et de 7 kg MS/ha, 1 kg MS/ha pour le coton et 2 kg MS/ha pour le soja. "
	self biomass: self biomass * (qtyNPK / self cell soilFertility)
]

{ #category : 'accessing' }
AHCultivatedVegetation >> residue [

	^ residue
]

{ #category : 'accessing' }
AHCultivatedVegetation >> residue: anObject [

	residue := anObject
]
