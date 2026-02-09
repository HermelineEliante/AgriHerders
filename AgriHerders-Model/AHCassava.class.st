Class {
	#name : 'AHCassava',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHCassava class >> myColor [

	^ Color fromHexString: 'DCC603'
]

{ #category : 'control' }
AHCassava >> initialize [

	super initialize.
	optimalFertility := 1.
	expectedYield := 80 . "kg/ha"
	residue := 0
]

{ #category : 'testing' }
AHCassava >> isMature [
	"mature si age >= 1 y"

	^ self age > 1
]

{ #category : 'control' }
AHCassava >> rainyStep [

	| fallow |
	super rainyStep.
	self isMature ifTrue: [
			fallow := self cell setLandcover: AHFallow.
			fallow biomass: self residue.
			isDead := true ]
]
