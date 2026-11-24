Class {
	#name : 'AHTranshumant',
	#superclass : 'AHHerder',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'aspects' }
AHTranshumant >> color [

	^ CMColor purple
]

{ #category : 'control' }
AHTranshumant >> openedPlotsForCoralling [
	"si agrement = true, alors retourne une list de plots déjà récoltés, sinon, retourne une liste vide "
	
	    ^ OrderedCollection new

]

{ #category : 'aspects' }
AHTranshumant >> shape [

	^ #hexagon
]
