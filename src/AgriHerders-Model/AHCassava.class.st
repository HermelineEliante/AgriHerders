Class {
	#name : 'AHCassava',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHCassava class >> expectedYield [
	<parameterFloatMin: 0 max: 1000 default: 80>
	^ expectedYield
]

{ #category : 'pov' }
AHCassava class >> myColor [

	^ Color fromHexString: 'DCC603'
]

{ #category : 'accessing' }
AHCassava class >> price [

	<parameterFloatDefault: 200>
	^ price
]

{ #category : 'accessing' }
AHCassava class >> residue [
	<parameterIntegerDefault: 500>
	^residue
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
