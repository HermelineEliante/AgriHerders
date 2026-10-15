Class {
	#name : 'AHPasture',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHPasture class >> biomassMax [

	<parameterFloatMin: 0 max: 50000 default: 15000>
	^ biomassMax
]

{ #category : 'accessing' }
AHPasture class >> maxSupplyFertility [

	<parameterFloatMin: 0 max: 20 default: 6>
	^ maxSupplyFertility
]

{ #category : 'pov' }
AHPasture class >> myColor [

	^ Color fromHexString: 'D2F6C3'
]
