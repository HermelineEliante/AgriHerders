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
			spec
				package: 'AgriHerders-Model';
				package: 'AgriHerders-Tests'
				with: [ spec requires: #( 'AgriHerders-Model' ) ] ]
]
