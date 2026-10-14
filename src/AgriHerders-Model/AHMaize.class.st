Class {
	#name : 'AHMaize',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHMaize class >> expectedYield [
	<parameterFloatMin: 0 max: 1000 default: 300>
	^ expectedYield
]

{ #category : 'pov' }
AHMaize class >> myColor [

	^ Color fromHexString: 'F1F10F'
]

{ #category : 'accessing' }
AHMaize class >> optimalFertility [

	<parameterFloatDefault: 5>
	^ optimalFertility
]

{ #category : 'accessing' }
AHMaize class >> price [

	<parameterFloatDefault: 215>
	^ price
]

{ #category : 'accessing' }
AHMaize class >> residue [

	<parameterFloatDefault: 4000>
	^ residue
]
