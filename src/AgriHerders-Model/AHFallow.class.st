Class {
	#name : 'AHFallow',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHFallow class >> maxIngestibleBiomass [
	"correspond au couvert herbacé. A cela, il faut ajouter les résidus de la culture initialement en place (cf. méthode rainyStep & dryStep)"

	<parameterFloatMin: 0 max: 50000 default: 10000>
	^ maxIngestibleBiomass
]

{ #category : 'accessing' }
AHFallow class >> maxSupplyFertility [

	<parameterFloatMin: 0 max: 20 default: 5>
	^ maxSupplyFertility
]

{ #category : 'colors' }
AHFallow class >> myColor [

	^ Color fromHexString: 'A6B58A'
]
