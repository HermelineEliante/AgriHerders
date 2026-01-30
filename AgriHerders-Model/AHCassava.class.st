Class {
	#name : 'AHCassava',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHCassava >> initialize [

	super initialize.
	optimalFertility := 0.5.
	expectedYield := 80.
	residue := 0
]

{ #category : 'testing' }
AHCassava >> isMature [
	"mature si age >= 1 y"

	^ self age > 1
]

{ #category : 'pov' }
AHCassava >> myColor [

	^ Color fromHexString: 'DCC603'
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
