Extension { #name : 'AHFarmer' }

{ #category : '*AgriHerders-Tiles' }
AHFarmer >> pov [

	<pov>
	id = 1
		ifTrue: [ ^CMPointOfView tile: AHTilesSet farmer size: 0.7 ]
		ifFalse: [ ^ CMPointOfView tile: AHTilesSet farmerColored size: 0.7 ]
]
