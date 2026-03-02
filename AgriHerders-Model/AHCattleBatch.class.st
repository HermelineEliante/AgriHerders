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
	#classInstVars : [
		'heads'
	],
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'accessing' }
AHCattleBatch class >> heads [

	^ heads
]

{ #category : 'accessing' }
AHCattleBatch class >> heads: aPositiveInteger [

	heads := aPositiveInteger
]

{ #category : 'accessing' }
AHCattleBatch class >> initializeParameters [

	super initializeParameters.
	heads := 10
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
AHCattleBatch >> defecateOn: listOfPlots [
	"Mise à jour de la fertilité des plots visités. Excreta deposits are proportional to the time spent by the animals on the plot GRILLOT, M., Guerrin, F., Gaudou, B., Masse, D., & Vayssières, J. (2018). Multi-level analysis of nutrient cycling within agro-sylvo-pastoral landscapes in West Africa using an agent-based model. Environmental Modelling & Software, 107, 267–280. [doi:10.1016/j.envsoft.2018.05.003].
	le troupeau dépose ses faeces sur chaque plot en fonction de sa CC :
	 il dépose 2.8 kg/jour * heads * CC/10 * 183j	"
	"Calcul des fèces déposées par le troupeau sur les plots"

	| faecesDepositedByPlot |
	"2.8 * 4 * 183 /1000 = 2T/ha ce qui correspiond à une élévation de 1 de la fertilité.
Une publication technique mentionne que pour nourrir des microorganismes du sol et améliorer certains aspects de fertilité, des apports de 2 à 4 t/ha de compost jeune de fumier peuvent déjà avoir un effet mesurable. https://techniloire.com/sites/default/files/dossier_viticulture_2019_atv_tech_sol_fertilite_des_sols.pdf?utm_source=chatgpt.com"
	listOfPlots ifEmpty: [ ^ self ].
	faecesDepositedByPlot := faeces * heads * (183 / listOfPlots size)
	                         * (corporalCondition / 10) / 1000. "en Tonnes"
	listOfPlots do: [ :p | "Mettre à jour la fertilité de chaque plot"
			p soilFertility:
				(p soilFertility + (faecesDepositedByPlot / 2) min: 20) ]
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
	heads := self class heads.  "self randomIntegerBetween: 1 and: 5."
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

{ #category : 'control' }
AHCattleBatch >> moveTo: aSpatialEntity [
	super moveTo: aSpatialEntity.
	self cell cowsCounter: self cell cowsCounter + self heads.
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
		size: heads / 15
		

]

{ #category : 'initialization' }
AHCattleBatch >> povNumberOfHeads [
	<pov>
	^ CMPointOfView color:(self
		colorAttribute: #heads  
		min: 1
		max: 15
		color: Color red)
]

{ #category : 'control' }
AHCattleBatch >> totalNeeds [

	^self heads * self dailyForrageNeed * 183
]

{ #category : 'control' }
AHCattleBatch >> updateCorporalConditionWith: needs [

	needs > 0
		ifTrue: [
			self corporalCondition:
				10 * (1 - (needs / self totalNeeds)) ]
		ifFalse: [ self corporalCondition: 10 ]
]
