Class {
	#name : 'AHSedentary',
	#superclass : 'AHHerder',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'pov' }
AHSedentary >> color [

	id = 1 ifTrue: [ ^ CMColor pink ].
	id = 2 ifTrue: [ ^ CMColor lightBlue ].

	^ CMColor colorOfNumber: id 
]

{ #category : 'control' }
AHSedentary >> harvest [
	"je ne récolte que le mais"
	(self myFarm components select: [ :p | p cover class = AHMaize ])
		do: [ :plot |
				plot cover isMature ifTrue: [
						self money: self money + (plot cover yield * plot cover price).
						plot cover biomass: plot cover residue ] ]
]

{ #category : 'pov' }
AHSedentary >> shape [ 
^#diamond
]

{ #category : 'control' }
AHSedentary >> sow [
	"= sow maize : je fais continuellemnt du maïs sur une parcelle de ma propriété avec un niveau de fertilité > 0 "

	| fertilePlots |
	(self myFarm components select: [ :p | p cover class = AHMaize ])
		isEmpty ifFalse: [ ^nil].
			fertilePlots := self fertileFallowPlots.
			fertilePlots ifNotEmpty: [ fertilePlots last setLandcover: AHMaize ] 
]
