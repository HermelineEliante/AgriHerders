Class {
	#name : 'AHCattleBatch',
	#superclass : 'CMAgent',
	#instVars : [
		'numberOfHeads',
		'corporalCondition',
		'dailyForrageNeed'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHCattleBatch >> corporalCondition [

	^ corporalCondition
]

{ #category : 'accessing' }
AHCattleBatch >> corporalCondition: anObject [

	corporalCondition := anObject
]

{ #category : 'accessing' }
AHCattleBatch >> dailyForrageNeed [

	^ dailyForrageNeed
]

{ #category : 'accessing' }
AHCattleBatch >> dailyForrageNeed: anObject [

	dailyForrageNeed := anObject
]

{ #category : 'initialization' }
AHCattleBatch >> initialize [ 
	super initialize.
	"numberOfHeads := 15."
	numberOfHeads := self randomIntegerBetween: 15 and: 150.
	
	
		"self class minNumberOfHeads 
		and: self class maxNumberOfHeads" 
]

{ #category : 'accessing' }
AHCattleBatch >> numberOfHeads [

	^ numberOfHeads
]

{ #category : 'accessing' }
AHCattleBatch >> numberOfHeads: anObject [

	numberOfHeads := anObject
]

{ #category : 'initialization' }
AHCattleBatch >> pov [
	<pov>
	^ CMPointOfView
		color: CMColor blue
		shape: #star
		size: 0.6
		

]

{ #category : 'initialization' }
AHCattleBatch >> povNumberOfHeads [
	<pov>
	^ CMPointOfView color:(self
		colorAttribute: #numberOfHeads  
		min: 15
		max: 150
		color: Color red)
]
