Class {
	#name : 'AHActor',
	#superclass : 'CMAgent',
	#instVars : [
		'agreement',
		'house',
		'myFarm',
		'territory',
		'others',
		'money'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHActor >> agreement [

	<parameterBooleanDefault: true>
	^ agreement
]

{ #category : 'accessing' }
AHActor >> agreement: anObject [

	agreement := anObject
]

{ #category : 'pov' }
AHActor >> color [
	^ CMColor colorOfNumber: 100
]

{ #category : 'control' }
AHActor >> fertileFallowPlots [
	"Return a list of fallow plots sorted by fertility level (>0)"

	^ (self myFarm components select: [ :p |
		   p cover class = AHFallow and: [ p soilFertility > 0 ] ]) 
				sorted: [:a :b | a soilFertility <= b soilFertility ]
]

{ #category : 'control' }
AHActor >> harvest [
	"Au début de la saison sèche, toutes les cultures matures de sa ferme sont récoltées.
	La récolte sera vendue. Puis, sera ajouté à l'argent que le fermier possède le prix de la culture. Enfin, il ne reste sur les plots que les résidus"

	self myFarm components do: [ :plot | 
			plot cover isMature ifTrue: [
					self money:
						self money + (plot cover yield * plot cover price).
					plot cover biomass: plot cover residue ] ]
]

{ #category : 'accessing' }
AHActor >> house [

	^ house
]

{ #category : 'accessing' }
AHActor >> house: anObject [

	house := anObject
]

{ #category : 'initialize' }
AHActor >> initialize [

	super initialize.
	agreement := false.
	money := 1
]

{ #category : 'testing' }
AHActor >> isDrySeason [
	"répond si nous sommes en saison sêche, ou non"

	^ self currentTimeStep even
]

{ #category : 'accessing' }
AHActor >> money [

	<parameterFloatDefault: 1>
	^ money
]

{ #category : 'accessing' }
AHActor >> money: anObject [

	money := anObject
]

{ #category : 'accessing' }
AHActor >> myFarm [

	^ myFarm
]

{ #category : 'accessing' }
AHActor >> myFarm: anObject [

	myFarm := anObject
]

{ #category : 'control' }
AHActor >> myOwnPlotsForCoralling [
	"retourne une list de mes plots déjà récoltés, sinon, retourne une liste vide "

	^ self myFarm components select: [ :p |
			  p cover hasBeenHarvested and: [
				  p hasNoOccupants] ]
]

{ #category : 'accessing' }
AHActor >> myPlots [

	^ self myFarm components
]

{ #category : 'accessing' }
AHActor >> name [

	^ self class name, '_', self id asString
]

{ #category : 'control' }
AHActor >> openedPlotsForCoralling [
	"si agrement = true, alors retourne une list de plots déjà récoltés, sinon, retourne une liste vide "

	self agreement
		ifTrue: [
		^ self myFarm components select: [ :p | p cover hasBeenHarvested and: [ p hasNoOccupants "and: [ p cover biomass > 0 ]" ]] ]
		ifFalse: [ ^ OrderedCollection new ]
]

{ #category : 'accessing' }
AHActor >> others [

	^ others
]

{ #category : 'accessing' }
AHActor >> others: anObject [

	others := anObject
]

{ #category : 'pov' }
AHActor >> pov [

	<pov>
	^ CMPointOfView
		  color: self color
		  shape: self shape 
]

{ #category : 'pov' }
AHActor >> shape [ 
^#circle
]

{ #category : 'control' }
AHActor >> sow [
	"Si il n'y a pas de manioc dans mes parcelles, je choisis une des parcelles en jachère, la moins fertile pour y implanter du manioc. 
	Pour les autres cultures: Quand le niveau de fertilité des plots de ma propriété est supérieur à 6, et qu'il n'y pas de culture, il fait du coton. Lorsqu’il est supérieur à 4 il fait le maïs, dans le cas contraire il cultive le soja."

	| fertilePlots |
	(self myFarm components select: [ :p | p cover class = AHCassava ])
		isEmpty ifTrue: [
			fertilePlots := self fertileFallowPlots.
			fertilePlots ifNotEmpty: [  fertilePlots first setLandcover: AHCassava ]].

	"autres cultures"
	(self myFarm components select: [ :p | 
		 p cover isKindOf: AHNaturalVegetation ]) do: [ :plot |
		self sowOnPlot: plot ]
]

{ #category : 'control' }
AHActor >> sowOnPlot: aPlot [
	"Quand le niveau de fertilité des plots de ma propriété est supérieur à 6, et qu'il n'y pas de culture, il fait du coton. Lorsqu’il est supérieur à 4 il fait le maïs, dans le cas contraire il cultive le soja."


			aPlot soilFertility >= 6 ifTrue: [ ^aPlot setLandcover: AHCotton ].
			aPlot soilFertility >= 4 ifTrue: [ ^aPlot setLandcover: AHMaize ].
			^aPlot setLandcover: AHSoja
]

{ #category : 'accessing' }
AHActor >> territory [

	^ territory
]

{ #category : 'accessing' }
AHActor >> territory: anObject [

	territory := anObject
]
