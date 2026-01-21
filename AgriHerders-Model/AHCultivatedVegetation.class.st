Class {
	#name : 'AHCultivatedVegetation',
	#superclass : 'AHVegetation',
	#instVars : [
		'isMature',
		'residue'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHCultivatedVegetation >> dryStep [
	"la récolte de toutes les cultures sauf le manioc"

	self residue
]

{ #category : 'control' }
AHCultivatedVegetation >> initialize [

	super initialize.
	isMature := true.
	residue := 1.
	
]

{ #category : 'accessing' }
AHCultivatedVegetation >> isMature [

	^ isMature
]

{ #category : 'accessing' }
AHCultivatedVegetation >> isMature: anObject [

	isMature := anObject
]

{ #category : 'control' }
AHCultivatedVegetation >> rainyStep [

	self biomass: self isMature.
	residue :=0
]

{ #category : 'accessing' }
AHCultivatedVegetation >> residue [

	^ residue
]

{ #category : 'accessing' }
AHCultivatedVegetation >> residue: anObject [

	residue := anObject
]
