Extension { #name : 'AHSedentary' }

{ #category : '*AgriHerders-Tiles' }
AHSedentary >> pov [

	<pov>
	self id = 1 ifTrue: [ ^ CMPointOfView
		tile: AHTilesSet herderRed
		size: 0.7 ] ifFalse: [  ^ CMPointOfView
		tile: AHTilesSet herderBlue 
		size: 0.7]
	
]
