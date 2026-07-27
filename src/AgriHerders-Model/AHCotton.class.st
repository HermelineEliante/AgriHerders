Class {
	#name : 'AHCotton',
	#superclass : 'AHAnnualCrop',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHCotton class >> expectedYield [

	<parameterFloatDefault: 750>
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

	<parameterFloatDefault: 700>
	^ residue
]
