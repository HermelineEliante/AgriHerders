Class {
	#name : 'AHCotton',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing' }
AHCotton class >> expectedYield [

	<parameterFloatMin: 1000 max: 2500 default: 1350>
	^ expectedYield
]

{ #category : 'pov' }
AHCotton class >> myColor [

	^ Color fromHexString: 'EEEEC8'
]

{ #category : 'accessing' }
AHCotton class >> optimalFertility [

	<parameterFloatDefault: 10>
	^ optimalFertility
]

{ #category : 'accessing' }
AHCotton class >> price [

	<parameterFloatDefault: 350>
	^ price
]

{ #category : 'accessing' }
AHCotton class >> residue [
"KG MS/ha"
	<parameterFloatMin: 5100 max: 6900 default: 5500>
	^ residue
]
