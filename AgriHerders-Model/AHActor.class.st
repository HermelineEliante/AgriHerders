Class {
	#name : 'AHActor',
	#superclass : 'CMAgent',
	#instVars : [
		'name',
		'agreement',
		'house',
		'myFarm',
		'territory',
		'others',
		'money'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHActor >> agreement [

	^ agreement
]

{ #category : 'accessing' }
AHActor >> agreement: anObject [

	agreement := anObject
]

{ #category : 'accessing' }
AHActor >> currentTime [

 ^AHModel time
]

{ #category : 'control' }
AHActor >> dryStep [

	
]

{ #category : 'control' }
AHActor >> harvest [


	
]

{ #category : 'accessing' }
AHActor >> house [

	^ house
]

{ #category : 'accessing' }
AHActor >> house: anObject [

	house := anObject
]

{ #category : 'initialize' }
AHActor >> initialize [

	super initialize.
	agreement := false.
	money := 1
]

{ #category : 'testing' }
AHActor >> isDrySeason [
"répond si nous sommes en saison sêche, ou non"
	^self currentTime even 
]

{ #category : 'accessing' }
AHActor >> money [

	^ money
]

{ #category : 'accessing' }
AHActor >> money: anObject [

	money := anObject
]

{ #category : 'accessing' }
AHActor >> myFarm [

	^ myFarm
]

{ #category : 'accessing' }
AHActor >> myFarm: anObject [

	myFarm := anObject
]

{ #category : 'accessing' }
AHActor >> myPlots [

	^ self myFarm components
]

{ #category : 'accessing' }
AHActor >> name [

	^ self class name, '_', self id asString
]

{ #category : 'accessing' }
AHActor >> name1 [

	^ name
]

{ #category : 'accessing' }
AHActor >> name: anObject [

	name := anObject
]

{ #category : 'control' }
AHActor >> openedPlotsForCoralling [
	"si agrement = true, alors retourne une list de plots déjà récoltés, sinon, retourne une liste vide "

	self agreement
		ifTrue: [
		^ self myFarm components select: [ :p | p cover hasBeenHarvested and: [ p hasNoOccupants and: [ p cover biomass > 0 ] ]] ]
		ifFalse: [ ^ OrderedCollection new ]
]

{ #category : 'accessing' }
AHActor >> others [

	^ others
]

{ #category : 'accessing' }
AHActor >> others: anObject [

	others := anObject
]

{ #category : 'pov' }
AHActor >> pov [

	<pov>
	^ CMPointOfView color: Color purple size: 0.3
]

{ #category : 'control' }
AHActor >> rainyStep [
]

{ #category : 'accessing' }
AHActor >> territory [

	^ territory
]

{ #category : 'accessing' }
AHActor >> territory: anObject [

	territory := anObject
]
