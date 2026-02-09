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
AHVegetation class >> initializeParameters [

	super initializeParameters.
	maxSupplyFertility := 0
]

{ #category : 'accessing' }
AHVegetation class >> maxSupplyFertility [

	^maxSupplyFertility 
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

	age := age + 0.5. "
	self class maxSupplyFertility > 0 ifTrue: [
			self cell soilFertility:
				(self class maxSupplyFertility min: self cell soilFertility + 1) ]"
	self class maxSupplyFertility > 0 ifTrue: [
			self cell soilFertility < self class maxSupplyFertility ifTrue: [
				self cell soilFertility: self cell soilFertility + 0.5 ] ]
]

{ #category : 'accessing' }
AHVegetation >> initialize [
super initialize. 
age := 0.
biomass := 0
]

{ #category : 'control' }
AHVegetation >> rainyStep [

	age := age + 0.5. "
	self class maxSupplyFertility > 0 ifTrue: [
			self cell soilFertility:
				(self class maxSupplyFertility min: self cell soilFertility + 1) ]"
	self class maxSupplyFertility > 0 ifTrue: [
			self cell soilFertility < self class maxSupplyFertility ifTrue: [
				self cell soilFertility: self cell soilFertility + 0.5 ] ]
]
