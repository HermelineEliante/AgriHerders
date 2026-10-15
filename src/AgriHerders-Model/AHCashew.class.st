Class {
	#name : 'AHCashew',
	#superclass : 'AHCultivatedVegetation',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHCashew class >> expectedYield [
	<parameterFloatMin: 0 max: 1000 default: 450>
	^ expectedYield
]

{ #category : 'pov' }
AHCashew class >> myColor [

	^ Color fromHexString: 'F9C3C0'
]

{ #category : 'accessing' }
AHCashew class >> price [

	<parameterFloatDefault: 350>
	^ price
]

{ #category : 'accessing' }
AHCashew class >> residue [

	<parameterFloatDefault: 400>
	^ residue
]

{ #category : 'testing' }
AHCashew >> isMature [
	"mature si age >= 5 y ET si age finit par 0.5 Ex: 11.5. => et si l'age n'est pas un nombre entier"

	^ self age >= 5 and: [ self age isInteger not]
]

{ #category : 'accessing' }
AHCashew >> price [
	^ self class price
]

{ #category : 'accessing' }
AHCashew >> residue [

	^ self class residue
]
