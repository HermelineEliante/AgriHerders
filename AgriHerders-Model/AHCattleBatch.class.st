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
AHCattleBatch class >> initializeParameters [

	super initializeParameters.
	
]

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
AHCattleBatch >> defecateOn: visitedPlots [
"On répartit le nombre de fècès total sur tous les plots visités"
	| qtyFaecesOnPlot |
	visitedPlots ifEmpty: [ ^ self ].
	qtyFaecesOnPlot := faeces * heads * (183 / visitedPlots size) * (corporalCondition / 10)
	        / 1000.
	visitedPlots do: [ :plot |
		plot soilFertility: (plot soilFertility + (qtyFaecesOnPlot / 2) min: 20) ]
]

{ #category : 'control' }
AHCattleBatch >> eatForNeeds: needs [
	"le troupeau prélève 6.25 * le nombre de tête de la biomasse du couvert. Retourne les besoins restants pour arriver à la sassiété"

	| newNeeds |
	self cell cover biomass = 0 ifTrue: [
			self updateCorporalConditionWith: needs.
			^ needs ].
	self cell cover biomass >= needs
		ifTrue: [
				self cell cover biomass: self cell cover biomass - needs.
				self corporalCondition: 10.
				^ 0 ]
		ifFalse: [
				newNeeds := needs - self cell cover biomass.
				self cell cover biomass: 0.
				self updateCorporalConditionWith: newNeeds.
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
	heads := 10.  "self randomIntegerBetween: 1 and: 5."
	"corporalCondition := self class maxCorporalCondition / 2."
	corporalCondition := 10.
	dailyForrageNeed := 6.25. "kgMS"
	faeces := 2.8. "kg/day"
	corporalConditionDecreaseRate := 0.
	dailyForrageNeedCompensate := 0.
	MinDailyForrageNeed := 4.25 "kgMS"





]

{ #category : 'control' }
AHCattleBatch >> moveTo: arg1 [

	super moveTo: arg1.
	self cell cowsCounter: self cell cowsCounter + self heads
]

{ #category : 'control' }
AHCattleBatch >> naturalMortality [

"Les animaux peuvent mourir de vieillesse ou de faiblesse. Le taux de mortalité augmente si la condition corporelle moyenne annuelle est mauvaise :
Taux_mortalité_base = 0,02 (2 % par an)
Si Condition_moyenne_annuelle < 4 :
    Taux_mortalité = 0,10 (10 %)
Si Condition_moyenne_annuelle < 2 :
    Taux_mortalité = 0,20 (20 %)
Morts_naturelles = heads × Taux_mortalité"
| taux_mortalité |
taux_mortalité := 0.02.
(self corporalCondition between: 2 and:  4) ifTrue: [ taux_mortalité := taux_mortalité + 0.1  ].
self corporalCondition < 2 ifTrue: [ taux_mortalité := taux_mortalité + 0.2  ].
self heads: heads - (heads * taux_mortalité ) rounded 



]

{ #category : 'accessing' }
AHCattleBatch >> owner [

	^ owner
]

{ #category : 'accessing' }
AHCattleBatch >> owner: anObject [

	owner := anObject
]

{ #category : 'pov' }
AHCattleBatch >> pov [

	<pov>
	^ CMPointOfView color: CMColor blue shape: #star size: heads / 100
]

{ #category : 'initialization' }
AHCattleBatch >> povNumberOfHeads [

	<pov>
	^ CMPointOfView color: (self
			   colorAttribute: #heads
			   min: 1
			   max: 15
			   color: Color red)
]

{ #category : 'control' }
AHCattleBatch >> reproduce [
	"La reproduction dépend directement de l’état corporel moyen des animaux pendant la saison pluvieuse (période la plus favorable).
On calcule d’abord la condition moyenne du troupeau sur toute la saison pluvieuse :
AverageRainySeasonCondition = mean(DailyRainySeasonCondition)
Ensuite, on applique le taux de reproduction correspondant :
AverageRainySeasonCondition	Taux de reproduction	Explication
> 7 => 	25 %	Bonne santé → beaucoup de naissances
5 à 7	=> 15 %	Santé moyenne ; naissances modérées
3 à 5 =>	5 %	Santé fragile ; très peu de naissances
< 3	0 %	Santé trop mauvaise ; pas de naissances

Naissances = heads × Taux_reproduction
"

self corporalCondition > 7 ifTrue: [^ self heads: (heads * 0.25) rounded + heads ].
self corporalCondition > 5 ifTrue: [^ self heads: (heads * 0.15) rounded + heads ].
self corporalCondition > 3 ifTrue: [^ self heads: (heads * 0.05) rounded + heads ]

 
]

{ #category : 'pov' }
AHCattleBatch >> splitInTwo [
	"Si la taille du troupeau est > 30, alors je crée un nouveau troupeau de la taille totale du troupeau actuel moins 30.Et j'affecte ce nouveau troupeau à mon éleveur."

	| newBatch |
	self heads > 30 ifFalse: [ ^ nil ].
	newBatch := self cormasModel newEntity: self class.
	newBatch heads: self heads - 30.
	self heads: 30.
	newBatch owner: self owner.
	owner herd add: newBatch.
	newBatch moveTo: self cell  
]

{ #category : 'control' }
AHCattleBatch >> totalNeeds [

	^self heads * self dailyForrageNeed * 183
]

{ #category : 'control' }
AHCattleBatch >> updateCorporalConditionWith: needs [

	needs > 0
		ifTrue: [
		self corporalCondition: 10 * (1 - (needs / self totalNeeds)) ]
		ifFalse: [ self corporalCondition: 10 ]
		
	"Ratio = Daily-ing / dailyForrageNeeds"
]
