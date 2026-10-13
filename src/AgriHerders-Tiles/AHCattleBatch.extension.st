Extension { #name : 'AHCattleBatch' }

{ #category : '*AgriHerders-Tiles' }
AHCattleBatch >> pov [

	<pov>
	| size |
	"self heads > 40 ifTrue: [ size := 1 ] ifFalse: [size := 0.7].
	self heads < 10 ifTrue: [ size := 0.2 ]."
	size := 0.3 + (self heads / 50) .
	self owner id = 1
		ifTrue: [ ^ CMPointOfView tile: AHTilesSet cowPink size: size ]
		ifFalse: [ ^ CMPointOfView tile: AHTilesSet cowBlue size: size ]
]
