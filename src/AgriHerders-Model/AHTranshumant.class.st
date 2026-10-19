Class {
	#name : 'AHTranshumant',
	#superclass : 'AHHerder',
	#category : 'AgriHerders-Model-coreModel',
	#package : 'AgriHerders-Model',
	#tag : 'coreModel'
}

{ #category : 'pov' }
AHTranshumant >> color [
^CMColor colorOfNumber: self id + 33
]

{ #category : 'control' }
AHTranshumant >> openedPlotsForCoralling [
	"si agrement = true, alors retourne une list de plots déjà récoltés, sinon, retourne une liste vide "
	
	    ^ OrderedCollection new

]

{ #category : 'pov' }
AHTranshumant >> shape [
	^#pentagon
]
