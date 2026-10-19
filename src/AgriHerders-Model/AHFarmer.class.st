Class {
	#name : 'AHFarmer',
	#superclass : 'AHActor',
	#instVars : [
		'nobodysPlots'
	],
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'pov' }
AHFarmer >> color [

	id = 1 ifTrue: [ ^ CMColor orange ].
	id = 2 ifTrue: [ ^ CMColor olympic ].
	^ CMColor colorOfNumber: self id + 2
]

{ #category : 'control' }
AHFarmer >> expandFarm [
	"Chaque 10 ans (Lié à l’augmentation démographique de la famille), l’agriculteur décide d’augmenter sa surface en augmentant 2 plots supplémentaires. Il choisit donc deux  parcelles. il sélectionne les parcelles libres les plus proche de sa maison. Une parcelle libre est celle sans propriétaire, donc celle ayant un couvert de type parcours naturel ou de type forêt. S’il y a des troupeaux sur les nouvelles parcelles qu’il veut exploiter, il les chasse (renvoie) dans leur campement."

	| counter |
	nobodysPlots := nobodysPlots select:[ :p | p myFarm isNil ].
	counter := 0.
	nobodysPlots do: [ :p |
			self myFarm addComponent: p.
			(p occupantsOfClass: AHCattleBatch) do: #goHome.
			counter := counter + 1.
			counter >= 2 ifTrue: [ ^ self ] ]
]

{ #category : 'initialization' }
AHFarmer >> setNobodysPlots [
	"L’agriculteur sélectionne les parcelles libres les plus proche de sa maison. Une parcelle libre est celle sans propriétaire, donc celle ayant un couvert de type parcours naturel ou de type forêt. 
	Cette routine est lancée à l'initialisation pour des raisons d'optimisation (car sorted prend bcp de temps)"

	nobodysPlots := self territory select: [ :p | p myFarm isNil ].
	nobodysPlots := nobodysPlots asSortedCollection: [ :p1 :p2 |
		             (p1 distanceTo: self house)
		             < (p2 distanceTo: self house) ].
]

{ #category : 'pov' }
AHFarmer >> shape [ 
^#circle
]
