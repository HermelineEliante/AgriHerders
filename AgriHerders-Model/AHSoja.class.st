Class {
	#name : 'AHSoja',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHSoja >> initialize [

	super initialize.
	optimalFertility := 1.
	residue := 2.
	expectedYield := 200
]

{ #category : 'pov' }
AHSoja >> myColor [

	^ Color fromHexString: 'AA9FAF'
]
