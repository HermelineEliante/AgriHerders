Class {
	#name : 'AHVegetation',
	#superclass : 'AHLandcover',
	#instVars : [
		'age',
		'biomass'
	],
	#classInstVars : [
		'maxSupplyFertility'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHVegetation class >> maxSupplyFertility [
	<parameterFloatDefault: 0>
	^ maxSupplyFertility
]

{ #category : 'accessing' }
AHVegetation class >> maxSupplyFertility: anObject [

	maxSupplyFertility := anObject
]

{ #category : 'accessing' }
AHVegetation >> age [

	^ age
]

{ #category : 'accessing' }
AHVegetation >> age: anObject [

	age := anObject
]

{ #category : 'accessing' }
AHVegetation >> biomass [

	^ biomass
]

{ #category : 'accessing' }
AHVegetation >> biomass: anObject [

	biomass := anObject
]

{ #category : 'control' }
AHVegetation >> dryStep [

	^self semesterStep
]

{ #category : 'initialization' }
AHVegetation >> initialize [

	super initialize.
	age := 0.
	biomass := 0.01
]

{ #category : 'control' }
AHVegetation >> rainyStep [

	^self semesterStep
]

{ #category : 'control' }
AHVegetation >> semesterStep [
"age += 0.5. SoilFertility += 0.5"
	age := age + 0.5.
	self cell soilFertility < self class maxSupplyFertility ifTrue: [
		self cell soilFertility: self cell soilFertility + 0.5 ]
]
