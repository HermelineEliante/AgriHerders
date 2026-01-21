Class {
	#name : 'AHNaturalVegetation',
	#superclass : 'AHVegetation',
	#instVars : [
		'biomassMax',
		'biomassDecreaseRate'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHNaturalVegetation >> biomassDecreaseRate [

	^ biomassDecreaseRate
]

{ #category : 'accessing' }
AHNaturalVegetation >> biomassDecreaseRate: anObject [

	biomassDecreaseRate := anObject
]

{ #category : 'accessing' }
AHNaturalVegetation >> biomassMax [

	^ biomassMax
]

{ #category : 'accessing' }
AHNaturalVegetation >> biomassMax: anObject [

	biomassMax := anObject
]

{ #category : 'control' }
AHNaturalVegetation >> dryStep [
"la biomasse perd 90% (ou 40% si Foret)"

	self biomass: self biomass * ((100 - self biomassDecreaseRate) / 100)
]

{ #category : 'accessing' }
AHNaturalVegetation >> initialize [

	super initialize.
	biomassMax := 10.
	biomassDecreaseRate := 90
]

{ #category : 'control' }
AHNaturalVegetation >> rainyStep [
self biomass: self biomassMax 
]
