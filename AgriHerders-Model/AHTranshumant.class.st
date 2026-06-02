Class {
	#name : 'AHTranshumant',
	#superclass : 'AHHerder',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'pov' }
AHTranshumant >> color [
^self class colorOfNumber: self id + 33
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
