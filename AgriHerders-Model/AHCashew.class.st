Class {
	#name : 'AHCashew',
	#superclass : 'AHCultivatedVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHCashew >> initialize [

	super initialize.
	optimalFertility := 1.
	expectedYield := 450.
	residue := 5.
]

{ #category : 'testing' }
AHCashew >> isMature [
	"mature si age >= 5 y ET si age finit par 0.5 Ex: 11.5. => et si l'age n'est pas un nombre entier"

	^ self age >= 5 and: [ self age isInteger not]
]

{ #category : 'pov' }
AHCashew >> myColor [

	^ Color fromHexString: 'F9C3C0'
]

{ #category : 'pov' }
AHCashew >> pov [

	<pov>
	^ CMPointOfView color: Color purple
]
