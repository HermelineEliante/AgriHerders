Class {
	#name : 'AHCashew',
	#superclass : 'AHCultivatedVegetation',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHCashew class >> expectedYield [
"90% de MS"
	<parameterFloatMin: 250 max: 600 default: 450>
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
"KG MS/ha"
	<parameterFloatMin: 2650 max: 4550 default: 3600>
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
