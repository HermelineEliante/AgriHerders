Class {
	#name : 'AHCultivatedVegetation',
	#superclass : 'AHVegetation',
	#classInstVars : [
		'optimalFertility',
		'expectedYield',
		'price',
		'residue'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHCultivatedVegetation class >> expectedYield [

	<parameterFloatDefault: 60>
	^ expectedYield




]

{ #category : 'accessing' }
AHCultivatedVegetation class >> expectedYield: anObject [

	expectedYield := anObject
]

{ #category : 'accessing' }
AHCultivatedVegetation class >> optimalFertility [

	<parameterFloatDefault: 1>
	^ optimalFertility
]

{ #category : 'accessing' }
AHCultivatedVegetation class >> optimalFertility: anObject [

	optimalFertility := anObject
]

{ #category : 'accessing' }
AHCultivatedVegetation class >> price [

	<parameterFloatDefault: 1>
	^ price
]

{ #category : 'accessing' }
AHCultivatedVegetation class >> price: anObject [

	price := anObject
]

{ #category : 'accessing' }
AHCultivatedVegetation class >> residue [

	<parameterFloatDefault: 1>
	^ residue
]

{ #category : 'accessing' }
AHCultivatedVegetation class >> residue: anObject [

	residue := anObject
]

{ #category : 'accessing' }
AHCultivatedVegetation >> biomassMax [
	^ self expectedYield + self residue.
]

{ #category : 'accessing' }
AHCultivatedVegetation >> expectedYield [
	^ self class  expectedYield
]

{ #category : 'accessing' }
AHCultivatedVegetation >> optimalFertility [

	^ self class optimalFertility
]

{ #category : 'accessing' }
AHCultivatedVegetation >> price [

	^ self class price
]

{ #category : 'control' }
AHCultivatedVegetation >> rainyStep [
	"La croissance des cultures est en fonction du niveau de fertilité de son plot et de la demande en NPK de chaque type de culture. Pour l’instant, elle ne sera qu’en fonction de la fertilité qui englobe la dimension NPK. Le rendement de chaque culture dépend du niveau optimal de fertilité demandé par la plante. Quand le niveau de fertilité est optimal ou plus, le rendement de la culture est égal au rendement espéré. Si le niveau de fertilité est inférieur, le rendement sera proportionnel à la différence entre optimal fertility et fertility effective.
Yield (kg MS/ha) = Expected yield*(soilFertility/optimalFertility) avec un maximum = expected yield
Dans le même temps, la plante aura pompé une quantité de fertilité égale au niveau optimal de fertilité de chaque culture (Soil fertility initiale-optimal fertility= Plot fertility). 
La quantité de résidus produite par le maïs et de 7 kg MS/ha, 1 kg MS/ha pour le coton et 2 kg MS/ha pour le soja. "

	super rainyStep.
	self isMature ifTrue: [
			self biomass: self residue + self yield. "kg MS/plot"
			"reduction de la fertilité"
			self cell soilFertility:
				(self cell soilFertility - self optimalFertility max: 0) ]
]

{ #category : 'accessing' }
AHCultivatedVegetation >> residue [

	^ self class residue
]

{ #category : 'control' }
AHCultivatedVegetation >> yield [
	"Le rendement de chaque culture (kg/plot) dépend du niveau optimal de fertilité demandé par la plante. Quand le niveau de fertilité est optimal ou plus, le rendement de la culture est égal au rendement espéré. Si le niveau de fertilité est inférieur, le rendement sera proportionnel à la différence entre optimal fertility et fertility effective.
Yield= Expected yield*(soilFertility/optimalFertility) avec un maximum = expected yield "
	self biomass = 0 ifTrue: [ ^ 0 ].
	^ (self expectedYield
	   * (self cell soilFertility / self optimalFertility) min:
		   self expectedYield) * self cell area "kg/plot"
]
