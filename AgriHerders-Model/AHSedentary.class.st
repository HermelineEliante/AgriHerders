Class {
	#name : 'AHSedentary',
	#superclass : 'AHHerder',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHSedentary >> harvest [
	"je ne récolte que le mais"
	(self myFarm components select: [ :p | p cover class = AHMaize ])
		do: [ :plot |
				plot cover isMature ifTrue: [
						self money: self money + (plot cover yield * plot cover price).
						plot cover biomass: plot cover residue ] ]
]

{ #category : 'control' }
AHSedentary >> initialize [

	super initialize.
	agreement := true.
	money := 1
]

{ #category : 'control' }
AHSedentary >> sowMaize [
	"je fais continuellemnt du maïs sur une parcelle de ma propriété avec un niveau de fertilité > 0 "

	| fertilePlots |
	(self myFarm components select: [ :p | p cover class = AHMaize ])
		isEmpty ifTrue: [ "plotWithFallow := self myFarm components
				                  detect: [ :p | p cover class = AHFallow ]
				                  ifNone: [ nil ].
			plotWithFallow ifNotNil: [plotWithFallow setLandcover: AHCassava ] "
			fertilePlots := (self myFarm components select: [ :p |
				                 p cover class = AHFallow and: [
					                 p soilFertility > 0 ] ]) sorted: [ :a :b |
				                a soilFertility <= b soilFertility ].
			fertilePlots ifNotEmpty: [ fertilePlots last setLandcover: AHMaize ] ]
]
