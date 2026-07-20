Class {
	#name : 'AHNaturalVegetation',
	#superclass : 'AHVegetation',
	#classInstVars : [
		'biomassMax',
		'biomassDecreaseRate'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHNaturalVegetation class >> biomassDecreaseRate [

	<parameterFloatDefault: 90>
	^ biomassDecreaseRate
]

{ #category : 'accessing' }
AHNaturalVegetation class >> biomassDecreaseRate: anObject [

	biomassDecreaseRate := anObject
]

{ #category : 'accessing' }
AHNaturalVegetation class >> biomassMax [

	<parameterIntegerDefault: 10>
	^ biomassMax
]

{ #category : 'accessing' }
AHNaturalVegetation class >> biomassMax: anObject [

	biomassMax := anObject
]

{ #category : 'accessing' }
AHNaturalVegetation >> biomassMax [
	^self class biomassMax
]

{ #category : 'control' }
AHNaturalVegetation >> dryStep [
	"la biomasse perd 90% (ou 40% si Foret)"
	super dryStep.
	self biomass: self biomass * (100 - self class biomassDecreaseRate / 100)
]

{ #category : 'testing' }
AHNaturalVegetation >> hasBeenHarvested [

	^ true 
]

{ #category : 'control' }
AHNaturalVegetation >> rainyStep [
	super rainyStep.
	self biomass: self class biomassMax
]
