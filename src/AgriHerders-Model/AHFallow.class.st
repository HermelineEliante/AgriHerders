Class {
	#name : 'AHFallow',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHFallow class >> biomassMax [

	<parameterFloatMin: 0 max: 50000 default: 10000>
	^ biomassMax
]

{ #category : 'accessing' }
AHFallow class >> maxSupplyFertility [

	<parameterFloatMin: 0 max: 20 default: 5>
	^ maxSupplyFertility
]

{ #category : 'pov' }
AHFallow class >> myColor [

	^ Color fromHexString: 'A6B58A'
]
