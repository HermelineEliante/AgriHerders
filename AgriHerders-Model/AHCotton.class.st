Class {
	#name : 'AHCotton',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHCotton >> initialize [

	super initialize.
	optimalFertility:= 10.
	residue:= 1.
	expectedYield:= 60 
]

{ #category : 'pov' }
AHCotton >> myColor [
	^(Color fromHexString: 'FCFFFF')
]
