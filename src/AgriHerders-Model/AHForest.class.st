Class {
	#name : 'AHForest',
	#superclass : 'AHNaturalVegetation',
	#instVars : [
		'state'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHForest class >> biomassDecreaseRate [
	<parameterFloatDefault: 40>
	^biomassDecreaseRate
]

{ #category : 'accessing' }
AHForest class >> biomassMax [

	<parameterFloatDefault: 18000>
	^ biomassMax
]

{ #category : 'accessing' }
AHForest class >> maxSupplyFertility [

	<parameterFloatMin: 0 max: 20 default: 20>
	^ maxSupplyFertility
]

{ #category : 'pov' }
AHForest class >> myColor [

	^ Color fromHexString: '25663D'
]

{ #category : 'accessing' }
AHForest >> initialize [

	super initialize.
	age := self randomIntegerBetween: 50 and: 100. "years"
]
