Class {
	#name : 'AHCultivatedVegetation',
	#superclass : 'AHVegetation',
	#instVars : [
		'optimalFertility',
		'expectedYield',
		'price'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

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
	optimalFertility := 1.
	expectedYield:= 60.
	price := 1
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
Yield (kg MS/ha) = Expected yield*(soilFertility/optimalFertility) avec un maximum = expected yield
Dans le même temps, la plante aura pompé une quantité de fertilité égale au niveau optimal de fertilité de chaque culture (Soil fertility initiale-optimal fertility= Plot fertility). 
La quantité de résidus produite par le maïs et de 7 kg MS/ha, 1 kg MS/ha pour le coton et 2 kg MS/ha pour le soja. "
	super rainyStep.
	self biomass: self yield. "kg MS/ha"
	"reduction de la fertilité"
	self cell soilFertility:
		(self cell soilFertility - self optimalFertility max: 0)
]

{ #category : 'control' }
AHCultivatedVegetation >> yield [
	"Le rendement de chaque culture dépend du niveau optimal de fertilité demandé par la plante. Quand le niveau de fertilité est optimal ou plus, le rendement de la culture est égal au rendement espéré. Si le niveau de fertilité est inférieur, le rendement sera proportionnel à la différence entre optimal fertility et fertility effective.
Yield= Expected yield*(soilFertility/optimalFertility) avec un maximum = expected yield "


	^ (self expectedYield
	  * (self cell soilFertility / self optimalFertility)) min: self expectedYield
]
