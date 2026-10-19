Class {
	#name : 'AHCassava',
	#superclass : 'AHCultivatedVegetation',
	#instVars : [
		'hasBeenHarvested'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
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

{ #category : 'control' }
AHCassava >> dryStep [
	"Cassava is normally sown at the end of the dry season and harvested 1.5 years after"

	| fallow |
	self semesterStep.
	self isMature ifTrue: [
			self hasBeenHarvested ifTrue: [
					fallow := self cell setLandcover: AHFallow.
					fallow biomass: fallow biomass + self residue.
					isDead := true ] ]
]

{ #category : 'accessing' }
AHCassava >> hasBeenHarvested [

	^ hasBeenHarvested
]

{ #category : 'accessing' }
AHCassava >> hasBeenHarvested: anObject [

	hasBeenHarvested := anObject
]

{ #category : 'initialization' }
AHCassava >> initialize [
"Cassava is normally sown at the end of the dry season"
	super initialize.
	hasBeenHarvested := false
]

{ #category : 'testing' }
AHCassava >> isMature [
	"mature si age >= 1.5 y"

	^ self age > 1
]

{ #category : 'control' }
AHCassava >> rainyStep [
	"Cassava is normally sown at the end of the dry season and harvested 1.5 years after, at the begining of the rainy season"

	| fallow resid |
	self semesterStep.
	self isMature ifTrue: [
		self biomass: self residue + self yield. "kg MS/plot"
		"reduction de la fertilité"
		self cell soilFertility:
			(self cell soilFertility - self optimalFertility max: 0).
		self hasBeenHarvested ifTrue: [
					resid := self residue.
					fallow := self cell setLandcover: AHFallow.
					fallow biomass: fallow biomass + resid.
					isDead := true ] ]
]
