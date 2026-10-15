Class {
	#name : 'AHBush',
	#superclass : 'AHNaturalVegetation',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHBush class >> biomassMax [

	<parameterFloatMin: 0 max: 50000 default: 13000>
	^ biomassMax
	
	
]

{ #category : 'accessing' }
AHBush class >> maxSupplyFertility [

	<parameterFloatMin: 0 max: 20 default: 10>
	^ maxSupplyFertility
]

{ #category : 'pov' }
AHBush class >> myColor [

	^ Color fromHexString: 'C9DAA3'
]

{ #category : 'accessing' }
AHBush >> initialize [

	super initialize.
	age := self randomIntegerBetween: 50 and: 100. "years"
]
