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
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
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

	<parameterIntegerDefault: 0>
	^ age
]

{ #category : 'accessing' }
AHVegetation >> age: anObject [

	age := anObject
]

{ #category : 'accessing' }
AHVegetation >> biomass [

	<parameterFloatDefault: 0.01>
	^ biomass
]

{ #category : 'accessing' }
AHVegetation >> biomass: anObject [

	biomass := anObject
]

{ #category : 'control' }
AHVegetation >> dryStep [

	age := age + 0.5. 
	self class maxSupplyFertility > 0 ifTrue: [
			self cell soilFertility < self class maxSupplyFertility ifTrue: [
				self cell soilFertility: self cell soilFertility + 0.5 ] ]
]

{ #category : 'control' }
AHVegetation >> rainyStep [

	age := age + 0.5. 
	self class maxSupplyFertility > 0 ifTrue: [
			self cell soilFertility < self class maxSupplyFertility ifTrue: [
				self cell soilFertility: self cell soilFertility + 0.5 ] ]
]
