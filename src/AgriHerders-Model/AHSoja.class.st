Class {
	#name : 'AHSoja',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHSoja class >> expectedYield [

	<parameterFloatDefault: 200>
	^ expectedYield
]

{ #category : 'accessing' }
AHSoja class >> maxSupplyFertility [

	<parameterFloatDefault: 5>
	^ maxSupplyFertility
]

{ #category : 'pov' }
AHSoja class >> myColor [

	^ Color fromHexString: 'B29EBB'
]

{ #category : 'accessing' }
AHSoja class >> optimalFertility [

	<parameterFloatDefault: 0.9>
	^ optimalFertility
]

{ #category : 'accessing' }
AHSoja class >> price [

	<parameterFloatDefault: 275>
	^ price
]

{ #category : 'accessing' }
AHSoja class >> residue [

	<parameterFloatDefault: 1200>
	^ residue
]
