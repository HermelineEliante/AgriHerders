Class {
	#name : 'AHCattleBatch',
	#superclass : 'CMAgent',
	#instVars : [
		'heads',
		'corporalCondition',
		'dailyForrageNeed',
		'faeces',
		'owner',
		'corporalConditionDecreaseRate',
		'dailyForrageNeedCompensate',
		'MinDailyForrageNeed'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHCattleBatch >> corporalCondition [

	^ corporalCondition
]

{ #category : 'accessing' }
AHCattleBatch >> corporalCondition: anObject [

	corporalCondition := anObject
]

{ #category : 'accessing' }
AHCattleBatch >> corporalConditionDecreaseRate [

	^ corporalConditionDecreaseRate
]

{ #category : 'accessing' }
AHCattleBatch >> corporalConditionDecreaseRate: anObject [

	corporalConditionDecreaseRate := anObject
]

{ #category : 'accessing' }
AHCattleBatch >> dailyConsume [

	| quantity needs size |
	(cell isNil or: [ size = 0 ]) ifTrue: [ ^ nil ].

	self dailyBurnCorporalCondition.
	needs := self class dailyNeedsPerHead * size.
	needs := needs * 100 / (self corporalConditionPercent max: 0.1). "plus la vache est maigre, plus elle a faim"
	quantity := self patch AHPasture amountOfGrass min: needs.

	self patch grassCover removeAmountOfGrass: quantity.
	self corporalCondition: (self class maxCorporalCondition min:
			 self corporalCondition + (quantity / size))
]

{ #category : 'accessing' }
AHCattleBatch >> dailyForrageNeed [

	^ dailyForrageNeed
]

{ #category : 'accessing' }
AHCattleBatch >> dailyForrageNeed: anObject [

	dailyForrageNeed := anObject
]

{ #category : 'accessing' }
AHCattleBatch >> dailyForrageNeedCompensate [

	^ dailyForrageNeedCompensate
]

{ #category : 'accessing' }
AHCattleBatch >> dailyForrageNeedCompensate: anObject [

	dailyForrageNeedCompensate := anObject
]

{ #category : 'accessing' }
AHCattleBatch >> dailyStep [

	self
		dailyMove;
		dailyConsume
]

{ #category : 'control' }
AHCattleBatch >> dryStep [
	"le troupeau est amené sur les cover de type NatVegetation où il prélève 6.25 * le nombre de tête"

self cell 


]

{ #category : 'control' }
AHCattleBatch >> eat [
	"le troupeau prélève 6.25 * le nombre de tête de la biomasse du couvert. Retourne les besoins restants pour arriver à la sassiété"

	| needs |
	needs := self dailyForrageNeed * self heads * 183. "jours dans la saison"
	self cell cover biomass >= needs
		ifTrue: [
				self cell cover biomass: self cell cover biomass - needs.
				self corporalCondition: 10.
				^ 0 ]
		ifFalse: [needs := needs - self cell cover biomass.
				self cell cover biomass: 0.
				^ needs ]
]

{ #category : 'control' }
AHCattleBatch >> eatForNeeds: needs [
	"le troupeau prélève 6.25 * le nombre de tête de la biomasse du couvert. Retourne les besoins restants pour arriver à la sassiété"

	| newNeeds |
	self cell cover biomass = 0 ifTrue: [ ^ needs ].
	self cell cover biomass >= needs
		ifTrue: [
				self cell cover biomass: self cell cover biomass - needs.
				self corporalCondition: 10.
				^ 0 ]
		ifFalse: [
				newNeeds := needs - self cell cover biomass.
				self cell cover biomass: 0.
				^ newNeeds ] 
]

{ #category : 'accessing' }
AHCattleBatch >> faeces [

	^ faeces
]

{ #category : 'accessing' }
AHCattleBatch >> faeces: anObject [

	faeces := anObject
]

{ #category : 'accessing' }
AHCattleBatch >> heads [

	^ heads
]

{ #category : 'accessing' }
AHCattleBatch >> heads: anObject [

	heads := anObject
]

{ #category : 'initialization' }
AHCattleBatch >> initialize [

	super initialize.
	"numberOfHeads := 15."
	heads := self randomIntegerBetween: 1 and: 5.
	"corporalCondition := self class maxCorporalCondition / 2."
	corporalCondition := 10.
	dailyForrageNeed := 6.25. "kgMS"
	faeces := 2.8. "kg/day"
	corporalConditionDecreaseRate := 0.
	dailyForrageNeedCompensate := 0.
	MinDailyForrageNeed := 4.25 "kgMS"





	"self class minNumberOfHeads 
		and: self class maxNumberOfHeads"
]

{ #category : 'accessing' }
AHCattleBatch >> owner [

	^ owner
]

{ #category : 'accessing' }
AHCattleBatch >> owner: anObject [

	owner := anObject
]

{ #category : 'initialization' }
AHCattleBatch >> pov [
	<pov>
	^ CMPointOfView
		color: CMColor blue
		shape: #star
		size: 0.6
		

]

{ #category : 'initialization' }
AHCattleBatch >> povNumberOfHeads [
	<pov>
	^ CMPointOfView color:(self
		colorAttribute: #numberOfHeads  
		min: 15
		max: 150
		color: Color red)
]

{ #category : 'control' }
AHCattleBatch >> rainyStep [
	"le troupeau est amené sur les covers de type NatVegetation où il prélève 6.25 * le nombre de tête de la biomasse du couvert"

	self cell cover class = AHNaturalVegetation ifTrue: [self eat.
		self cell cover get: self dailyForrageNeed * self heads * 183 "jours dans la saison" ]
]
