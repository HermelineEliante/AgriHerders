Class {
	#name : 'AHSoya',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHSoya class >> expectedYield [
	<parameterFloatMin: 500 max: 1500 default: 1044>
	^ expectedYield
]

{ #category : 'accessing' }
AHSoya class >> maxSupplyFertility [

	<parameterFloatMin: 0 max: 20 default: 5>
	^ maxSupplyFertility
]

{ #category : 'pov' }
AHSoya class >> myColor [

	^ Color fromHexString: 'B29EBB'
]

{ #category : 'accessing' }
AHSoya class >> optimalFertility [

	<parameterFloatDefault: 0.9>
	^ optimalFertility
]

{ #category : 'accessing' }
AHSoya class >> price [

	<parameterFloatDefault: 275>
	^ price
]

{ #category : 'accessing' }
AHSoya class >> residue [
"KG MS/ha"
	<parameterFloatDefault: 2000>
	^ residue
]
