Class {
	#name : 'BaselineOfAgriHerders',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAgriHerders',
	#package : 'BaselineOfAgriHerders'
}

{ #category : 'baselines' }
BaselineOfAgriHerders >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'AgriHerders-Model'.
		spec package: 'AgriHerders-Tiles' with: [ spec requires: #('AgriHerders-Model') ].
		
		spec group: 'Core' with: #('AgriHerders-Model').
		spec group: 'default' with: #('Core' 'AgriHerders-Tiles').
	]
]
