Class {
	#name : 'AHTranshumant',
	#superclass : 'AHHerder',
	#category : 'AgriHerders-Model',
	#package : 'AgriHerders-Model'
}

{ #category : 'control' }
AHTranshumant >> openedPlotsForCoralling [
	"si agrement = true, alors retourne une list de plots déjà récoltés, sinon, retourne une liste vide "
	
	    ^ OrderedCollection new

]
