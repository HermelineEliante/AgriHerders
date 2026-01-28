Class {
	#name : 'AHMaize',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHMaize >> initialize [

	super initialize.
	optimalFertility := 5.
	residue := 7.
	expectedYield := 300
]

{ #category : 'pov' }
AHMaize >> myColor [
	^(Color fromHexString: 'F1F10F')
]
