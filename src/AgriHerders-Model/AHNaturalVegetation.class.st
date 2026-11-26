Class {
	#name : 'AHNaturalVegetation',
	#superclass : 'AHVegetation',
	#classInstVars : [
		'maxIngestibleBiomass',
		'biomassDecreaseRate'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
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
AHNaturalVegetation class >> maxIngestibleBiomass [

	<parameterIntegerDefault: 10>
	^ maxIngestibleBiomass
]

{ #category : 'accessing' }
AHNaturalVegetation class >> maxIngestibleBiomass: anObject [

	maxIngestibleBiomass := anObject
]

{ #category : 'control' }
AHNaturalVegetation >> dryStep [
	"la biomasse perd 90% (ou 40% si Foret)"
	super dryStep.
	self ingestibleBiomass: self ingestibleBiomass * (100 - self class biomassDecreaseRate / 100)
]

{ #category : 'testing' }
AHNaturalVegetation >> hasBeenHarvested [

	^ true 
]

{ #category : 'initialization' }
AHNaturalVegetation >> initialize [

	super initialize.
	age := 0. "years"
	ingestibleBiomass := self randomIntegerBetween: (self class maxIngestibleBiomass / 2) and: self class maxIngestibleBiomass "kg/ha"
]

{ #category : 'accessing' }
AHNaturalVegetation >> maxIngestibleBiomass [
	^self class maxIngestibleBiomass
]

{ #category : 'control' }
AHNaturalVegetation >> rainyStep [
	super rainyStep.
	self ingestibleBiomass: self class maxIngestibleBiomass
]
