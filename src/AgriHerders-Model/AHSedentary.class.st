Class {
	#name : 'AHSedentary',
	#superclass : 'AHHerder',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'aspects' }
AHSedentary >> aspectImage: look [
"get the png"
	<aspect>
	look
		image: (id = 1
				 ifTrue: [ 'herder-red' ]
				 ifFalse: [ 'herder-blue' ]);
		size: 0.7
]

{ #category : 'aspects' }
AHSedentary >> color [

	id = 1 ifTrue: [ ^ CMColor pink ].
	id = 2 ifTrue: [ ^ CMColor lightBlue ].
	^ CMColor palette at: id \\ CMColor palette size + 1
]

{ #category : 'control' }
AHSedentary >> harvest [
	"je ne récolte que le mais"
	super harvest.
	"(self myFarm components select: [ :p | p cover class = AHMaize ])
		do: [ :plot |
				plot cover isMature ifTrue: [
						self money: self money + (plot cover yield * plot cover price).
						self addTotalHarvestFor: plot cover.
						plot cover biomass: plot cover residue ] ]"
]

{ #category : 'aspects' }
AHSedentary >> shape [

	^ #diamond
]

{ #category : 'control' }
AHSedentary >> sow [
	"= sow maize : je fais continuellemnt du maïs sur une parcelle de ma propriété avec un niveau de fertilité > 0 "

	| fertilePlots |
	(self myFarm components select: [ :p | p cover class = AHMaize ])
		isEmpty ifFalse: [ ^ nil ].
	fertilePlots := self fertileFallowPlots.
	fertilePlots ifNotEmpty: [ fertilePlots first setLandcover: AHMaize ]
]
