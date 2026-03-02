Class {
	#name : 'AHAnnualCrop',
	#superclass : 'AHCultivatedVegetation',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'as yet unclassified' }
AHAnnualCrop >> dryStep [
	"A la fin de la saison seche, l'annual crop devient Fallow"

	| fallow |
	super dryStep.
	self isMature ifTrue: [  
	fallow := self cell setLandcover: AHFallow.
	fallow biomass: self residue.
	isDead := true]
]

{ #category : 'testing' }
AHAnnualCrop >> hasBeenHarvested [

	^ self biomass <= self residue 
]

{ #category : 'testing' }
AHAnnualCrop >> isMature [
	"mature si age >= 0.5 y"
	^ self age >= 0.5 
]
