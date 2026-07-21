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
	"A la fin de la saison pluvieuse, le manioc devient Fallow"

	| fallow resid |
	super rainyStep.
	self isMature ifTrue: [
			resid := self residue.
			fallow := self cell setLandcover: AHFallow.
			fallow biomass: fallow biomass + resid.
			isDead := true ]
]
