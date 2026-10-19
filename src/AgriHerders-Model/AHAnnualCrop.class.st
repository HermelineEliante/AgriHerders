Class {
	#name : 'AHAnnualCrop',
	#superclass : 'AHCultivatedVegetation',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'controlling' }
AHAnnualCrop >> dryStep [
	"A la fin de la saison seche, l'annual crop devient Fallow"

	| fallow |
	super dryStep.
	self isMature ifTrue: [
			fallow := self cell setLandcover: AHFallow.
			fallow biomass: fallow biomass + self residue.
			isDead := true ]
]

{ #category : 'testing' }
AHAnnualCrop >> hasBeenHarvested [
"Answer if the crop has already been harvested.
ie. if its eatable biomass is = or less than the residue"
	^ self biomass <= self residue 
]

{ #category : 'testing' }
AHAnnualCrop >> isMature [
	"mature si age >= 0.5 y"
	^ self age >= 0.5 
]
