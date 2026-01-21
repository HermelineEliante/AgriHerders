Class {
	#name : 'AHVegetation',
	#superclass : 'AHLandcover',
	#instVars : [
		'age',
		'biomass'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

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
]

{ #category : 'accessing' }
AHVegetation >> initialize [
super initialize. 
age := 0.
biomass := 0
]

{ #category : 'control' }
AHVegetation >> rainyStep [

	
]
