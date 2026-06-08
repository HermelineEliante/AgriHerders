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
	"On répartit le nombre de fècès total sur tous les plots visités. 
	Ainsi, on note une Mise à jour de la fertilité des plots visités par les animaux. Excreta deposits are proportional to the time spent by the animals on the plot. ""2.8 * 4 * 183 /1000 = 2T/ha ce qui correspiond à une élévation de 1 de la fertilité (Une publication technique mentionne que pour nourrir des microorganismes du sol et améliorer certains aspects de fertilité, des apports de 2 à 4 t/ha de compost jeune de fumier peuvent déjà avoir un effet mesurable. D’où je garde 4 dans ce calcul « ""2.8 * 4 * 183 /1000 = 2T/ha ») .
""le troupeau prélève 6.25 * le nombre de tête de la biomasse du couvert. Si il n’est pas rassasié et qu’il y a de plot ouvert où il peut manger, il va sur ces plots.
"

	| qtyFaecesOnPlot |
	visitedPlots ifEmpty: [ ^ self ].
	qtyFaecesOnPlot := faeces * heads * (183 / visitedPlots size)
	                   * (corporalCondition / 10) / 1000.
	visitedPlots do: [ :plot |
			plot soilFertility:
				(plot soilFertility + (qtyFaecesOnPlot / 2) "min: 20") ]
]

{ #category : 'controlling' }
AHCattleBatch >> delete [ 
self owner ifNotNil: [ owner herd remove: self ifAbsent: [nil] ].
super delete.

]

{ #category : 'control' }
AHCattleBatch >> eatForNeeds: needs [
	"le troupeau prélève 6.25 * le nombre de têtes de la biomasse du couvert. Retourne les besoins restants pour arriver à la sassiété"

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

{ #category : 'control' }
AHCattleBatch >> goHome [ 
self moveTo: (self owner house )
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
	taux_mortalité := 0.02.
	(self corporalCondition between: 2 and: 4) ifTrue: [
		taux_mortalité := taux_mortalité + 0.1 ].
	self corporalCondition < 2 ifTrue: [
		taux_mortalité := taux_mortalité + 0.2 ].
	self heads: (heads - (heads * taux_mortalité)) "rounded".
	self heads < 1 ifTrue: [ self delete ]
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
	^ CMPointOfView
		  color: self owner color
		  shape: #star
		  size: heads / 70
]

{ #category : 'pov' }
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
AverageRainySeasonCondition	Taux de reproduction	Explication:
> 7 => 	25 %	Bonne santé → beaucoup de naissances
5 à 7	=> 15 %	Santé moyenne ; naissances modérées
3 à 5 =>	5 %	Santé fragile ; très peu de naissances
< 3	0 %	Santé trop mauvaise ; pas de naissances

Naissances = heads × Taux_reproduction
"

	self corporalCondition > 7 ifTrue: [
		^ self heads: (heads * 0.25) "rounded" + heads ].
	self corporalCondition > 5 ifTrue: [
		^ self heads: (heads * 0.15) "rounded" + heads ].
	self corporalCondition > 3 ifTrue: [
		^ self heads: (heads * 0.05) "rounded" + heads ]
]

{ #category : 'control' }
AHCattleBatch >> splitInTwo [
	"Si la taille du troupeau est > 30, alors je crée un nouveau troupeau de la taille totale du troupeau actuel moins 30.Et j'affecte ce nouveau troupeau à mon éleveur."

	| newBatch |
	self heads > 50 ifFalse: [ ^ nil ].
	newBatch := self cormasModel newEntity: self class.
	newBatch heads: self heads - 50.
	self heads: 30.
	newBatch owner: self owner.
	owner herd add: newBatch.
	newBatch goHome
]

{ #category : 'control' }
AHCattleBatch >> totalNeeds [
"Ex : heads = 10 => 10 * 6.25 * 183 = 11437 kg/semestre.
dailyForrageNeed := 6.25 kgMS, 183 jours dans un semestre"
	^ self heads * self dailyForrageNeed * 183 
]

{ #category : 'control' }
AHCattleBatch >> updateCorporalConditionWith: needs [

	needs > 0
		ifTrue: [
			self corporalCondition: 10 * (1 - (needs / self totalNeeds)) ]
		ifFalse: [ "Ratio = Daily-ing / dailyForrageNeeds"
			self corporalCondition: 10 ]
]
