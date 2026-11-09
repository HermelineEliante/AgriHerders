Class {
	#name : 'AHMaize',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHMaize class >> expectedYield [

	<parameterFloatMin: 1000 max: 2500 default: 1575>
	^ expectedYield
]

{ #category : 'pov' }
AHMaize class >> myColor [

	^ Color fromHexString: 'FFE95A'
]

{ #category : 'accessing' }
AHMaize class >> residue [
"KG MS/ha"
	<parameterFloatMin: 4400 max: 5300 default: 4850>
	^ residue
]
