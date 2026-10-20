Class {
	#name : 'AHCattleBatch',
	#superclass : 'CMAgent',
	#instVars : [
		'heads',
		'corporalCondition',
		'owner',
		'needs'
	],
	#classInstVars : [
		'faecesPerDay',
		'initialHeads',
		'initialCorporalCondition',
		'dailyForrageNeed',
		'naturalMortalityRate',
		'reproductionRate_good',
		'reproductionRate_low',
		'reproductionRate_bad',
		'thresholdGoodCC',
		'thresholdLowCC',
		'thresholdBadCC',
		'maximumSize'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'accessing parameters' }
AHCattleBatch class >> dailyForrageNeed [
	"6.25 kgMS"
	
	<parameterFloatMin: 0 max: 10 default: 6.25>
	^ dailyForrageNeed
]

{ #category : 'accessing' }
AHCattleBatch class >> dailyForrageNeed: anObject [

	dailyForrageNeed := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> faecesPerDay [ 
	<parameterFloatMin: 0 max: 10 default: 2.8>
	^ faecesPerDay 
]

{ #category : 'accessing' }
AHCattleBatch class >> faecesPerDay: anObject [

	faecesPerDay := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> initialCorporalCondition [
	<parameterFloatMin: 0 max: 10 default: 10>

	^ initialCorporalCondition
]

{ #category : 'accessing' }
AHCattleBatch class >> initialCorporalCondition: anObject [

	initialCorporalCondition := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> initialHeads [

	<parameterIntegerDefault: 10>
	^ initialHeads
]

{ #category : 'accessing' }
AHCattleBatch class >> initialHeads: aNumber [

	initialHeads := aNumber
]

{ #category : 'accessing' }
AHCattleBatch class >> maximumSize [
	<parameterFloatMin: 0 max: 1000 default: 50>
	^ maximumSize
]

{ #category : 'accessing' }
AHCattleBatch class >> maximumSize: anObject [

	maximumSize := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> naturalMortalityRate [
	<parameterFloatMin: 0 max: 1 default: 0.02>
	^ naturalMortalityRate
]

{ #category : 'accessing' }
AHCattleBatch class >> naturalMortalityRate: anObject [

	naturalMortalityRate := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> reproductionRate_bad [

	<parameterFloatMin: 0 max: 1 default: 0.05>
	^ reproductionRate_bad
]

{ #category : 'accessing' }
AHCattleBatch class >> reproductionRate_bad: anObject [

	reproductionRate_bad := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> reproductionRate_good [

	<parameterFloatMin: 0 max: 1 default: 0.25>
	^ reproductionRate_good
]

{ #category : 'accessing' }
AHCattleBatch class >> reproductionRate_good: anObject [

	reproductionRate_good := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> reproductionRate_low [

	<parameterFloatMin: 0 max: 1 default: 0.15>
	^ reproductionRate_low
]

{ #category : 'accessing' }
AHCattleBatch class >> reproductionRate_low: anObject [

	reproductionRate_low := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> thresholdBadCC [

	<parameterFloatMin: 0 max: 10 default: 3>
	^ thresholdBadCC
]

{ #category : 'accessing' }
AHCattleBatch class >> thresholdBadCC: anObject [

	thresholdBadCC := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> thresholdGoodCC [

	<parameterFloatMin: 0 max: 10 default: 7>
	^ thresholdGoodCC
]

{ #category : 'accessing' }
AHCattleBatch class >> thresholdGoodCC: anObject [

	thresholdGoodCC := anObject
]

{ #category : 'accessing' }
AHCattleBatch class >> thresholdLowCC [

	<parameterFloatMin: 0 max: 10 default: 5>
	^ thresholdLowCC
]

{ #category : 'accessing' }
AHCattleBatch class >> thresholdLowCC: anObject [

	thresholdLowCC := anObject
]

{ #category : 'accessing' }
AHCattleBatch >> corporalCondition [
	"<parameterIntegerDefault: 10>"

	^ corporalCondition
]

{ #category : 'accessing' }
AHCattleBatch >> corporalCondition: anObject [

	corporalCondition := anObject
]

{ #category : 'accessing parameters' }
AHCattleBatch >> dailyForrageNeed [
	^ self class dailyForrageNeed
]

{ #category : 'control' }
AHCattleBatch >> defecateOn: visitedPlots [
	"On répartit le nombre de fècès total sur tous les plots visités. 
	Ainsi, on note une Mise à jour de la fertilité des plots visités par les animaux. Excreta deposits are proportional to the time spent by the animals on the plot. ""2.8 * 4 * 183 /1000 = 2T/ha ce qui correspond à une élévation de 1 de la fertilité (Une publication technique mentionne que pour nourrir des microorganismes du sol et améliorer certains aspects de fertilité, des apports de 2 à 4 t/ha de compost jeune de fumier peuvent déjà avoir un effet mesurable. D’où je garde 4 dans ce calcul « ""2.8 * 4 * 183 /1000 = 2T/ha ») .
"

	| qtyFaecesPerPlot |
	visitedPlots ifEmpty: [ ^ self ].
	qtyFaecesPerPlot := self faecesPerDay * self heads
	                    * (183 / visitedPlots size)
	                    * (self corporalCondition / 10) / 1000. "Tonnes"
	visitedPlots do: [ :plot | "on divise par 2 car 2T/ha correspond à une élévation de 1"
		plot soilFertility: plot soilFertility + (qtyFaecesPerPlot / 2) ]
]

{ #category : 'controlling' }
AHCattleBatch >> delete [ 
self owner ifNotNil: [ owner herd remove: self ifAbsent: [nil] ].
super delete.

]

{ #category : 'accessing parameters' }
AHCattleBatch >> faecesPerDay [
"2.8. kg/day"
	^ self class faecesPerDay
]

{ #category : 'control' }
AHCattleBatch >> feedOnPlot [
	"le troupeau prélève 6.25 * le nombre de têtes de la biomasse du couvert (si possible). Met à jour sa Condition Corporelle"

	self cell cover biomass = 0 ifTrue: [ ^ self updateCorporalCondition ].

	self cell cover biomass >= needs
		ifTrue: [
				self cell cover biomass: (self cell cover biomass - needs).
				needs := 0.
				self corporalCondition: 10 ]
		ifFalse: [
				needs := needs - self cell cover biomass.
				self cell cover biomass: 0.
				self updateCorporalCondition ]
	"self owner isDrySeason
		ifFalse: [ self cell conflicts: self cell conflicts + 1 ]
		ifTrue: [
				self cell isOpenForCorraling ifFalse: [
					self cell conflicts: self cell conflicts + 1 ] ]"
]

{ #category : 'control' }
AHCattleBatch >> goHome [ 
self moveTo: (self owner house )
]

{ #category : 'testing' }
AHCattleBatch >> hasBadCorporalCondition [
	" CC > 3 "

	^self corporalCondition > self class thresholdBadCC 
]

{ #category : 'testing' }
AHCattleBatch >> hasGoodCorporalCondition [
	" CC > 7 "

	^self corporalCondition > self class thresholdGoodCC 
]

{ #category : 'testing' }
AHCattleBatch >> hasLowCorporalCondition [
	" CC > 5 "

	^self corporalCondition > self class thresholdLowCC 
]

{ #category : 'accessing' }
AHCattleBatch >> heads [

"	<parameterIntegerDefault: 10>"
	^ heads
]

{ #category : 'accessing' }
AHCattleBatch >> heads: anObject [

	heads := anObject
]

{ #category : 'initialization' }
AHCattleBatch >> initialize [

	super initialize.
	needs := 0.
	heads := self class initialHeads.
	corporalCondition := self class initialCorporalCondition.
]

{ #category : 'testing' }
AHCattleBatch >> isStarving [

	^ self corporalCondition <= self class thresholdBadCC
	
]

{ #category : 'control' }
AHCattleBatch >> moveAndFeedOnPlots: listOfPlots [

	| visitedPlots |
	visitedPlots := OrderedCollection new.
	listOfPlots do: [ :aPlot |
			self needs > 0 ifFalse: [ ^ visitedPlots ].
			self moveTo: aPlot.
			self feedOnPlot.
			visitedPlots add: aPlot ].
	^ visitedPlots
]

{ #category : 'control' }
AHCattleBatch >> moveTo: aPlot [
"(aPlot hasOccupantsOfClass: AHCattleBatch) ifTrue: [ self halt ]."
	super moveTo: aPlot.
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
	self corporalCondition = 0 ifTrue: [ ^self delete ].
	taux_mortalité := self class naturalMortalityRate "0.02".
	(self corporalCondition between: 2 and: 4) ifTrue: [
		taux_mortalité := taux_mortalité + 0.1 ].
	self corporalCondition < 2 ifTrue: [
		taux_mortalité := taux_mortalité + 0.2 ].
	self heads: (heads - (heads * taux_mortalité)) "rounded".
	self heads < 1 ifTrue: [ self delete ]
]

{ #category : 'accessing' }
AHCattleBatch >> needs [

	^ needs
]

{ #category : 'accessing' }
AHCattleBatch >> needs: anObject [

	needs := anObject
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
AHCattleBatch >> povNumberOfHeads [

	<pov>

	^ CMPointOfView color: self owner color shape: #star size: heads / 70
]

{ #category : 'control' }
AHCattleBatch >> reproduce [
	"La reproduction dépend directement de l’état corporel moyen des animaux pendant la saison pluvieuse (période la plus favorable).
On calcule d’abord la condition moyenne du troupeau sur toute la saison pluvieuse :
AverageRainySeasonCondition = mean(DailyRainySeasonCondition)
Ensuite, on applique le taux de reproduction correspondant :
AverageRainySeasonCondition	Taux de reproduction	Explication:
> 7 => 	25 %	Bonne santé → beaucoup de naissances
5 à 7	=> 15 %	Santé moyenne ; naissances modérées
3 à 5 =>	5 %	Santé fragile ; très peu de naissances
< 3	0 %	Santé trop mauvaise ; pas de naissances

Naissances = heads × Taux_reproduction
"

	self hasGoodCorporalCondition ifTrue: [
		^ self heads: (heads * self class reproductionRate_good "0.25") + heads ].
	self hasLowCorporalCondition ifTrue: [
		^ self heads: (heads * self class reproductionRate_low "0.15") + heads ].
	self hasBadCorporalCondition ifTrue: [
		^ self heads: (heads * self class reproductionRate_bad "0.05") + heads ].
	nil "otherwise, no reproduction"
]

{ #category : 'control' }
AHCattleBatch >> splitInTwo [
	"Si la taille du troupeau est > 50, alors je crée un nouveau troupeau de la taille totale du troupeau actuel divisée par 2.Et j'affecte ce nouveau troupeau à mon éleveur."

	| newBatch |
	self heads > self class maximumSize ifFalse: [ ^ nil ].
	newBatch := self cormasModel newEntity: self class.
	newBatch heads: (self heads / 2) rounded.
	self heads: self heads - newBatch heads.
	newBatch owner: self owner.
	owner herd add: newBatch.
	newBatch goHome
]

{ #category : 'control' }
AHCattleBatch >> totalNeeds [
"Ex : heads = 10 => 10 * 6.25 * 183 = 11437 kg/semestre.
dailyForrageNeed := 6.25 kgMS, 183 jours dans un semestre"
	^ self heads * self class dailyForrageNeed * 183 
]

{ #category : 'control' }
AHCattleBatch >> updateCorporalCondition [

	needs > 0
		ifTrue: [
		self corporalCondition: 10 * (1 - (needs / self totalNeeds)) ]
		ifFalse: [ "Ratio = Daily-ing / dailyForrageNeeds"
		self corporalCondition: 10 ]
]
