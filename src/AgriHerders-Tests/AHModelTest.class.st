"
I check the outputs of `AHModel`, the measures that its charts show and that analyses read.

## Responsibility:

- Check that each output measures the model, and does not change it when it is read.
- Check that the outputs of plots, cattle batches and actors add up to those of the model.
- Run short simulations of the model with a fixed seed.

## Collaborators:

- `AHModel` is the model under test.
- `CMSimulation` runs it, as the simulation window does.

## Public API and Key Messages

- `simulationOf:steps:` runs a simulation from an init method for some semesters.

```
(AHModelTest selector: #testConflictsAverageDoesNotDependOnHowOftenItIsRead) run
```
"
Class {
	#name : 'AHModelTest',
	#superclass : 'TestCase',
	#category : 'AgriHerders-Tests',
	#package : 'AgriHerders-Tests'
}

{ #category : 'helpers' }
AHModelTest >> simulationOf: anInitSelector steps: aNumber [

	| simulation |
	simulation := (CMSimulation for: AHModel new)
		              randomSeed: 7;
		              activeInitSelector: anInitSelector;
		              activeControlSelector: #stepSemester;
		              initializeSimulation;
		              yourself.
	aNumber timesRepeat: [ simulation runStep ].
	^ simulation
]

{ #category : 'tests' }
AHModelTest >> testConflictsAverageDoesNotDependOnHowOftenItIsRead [

	| simulation model conflicts |
	simulation := self simulationOf: #initWithoutAgreement steps: 30.
	model := simulation cormasModel.
	conflicts := (simulation modelData column: #conflicts) sum.
	model conflicts.
	model conflicts.

	self assert: conflicts > 0.
	self assert: model conflictsAverage closeTo: conflicts / 30
]

{ #category : 'tests' }
AHModelTest >> testFarmsShareTheFarmedPlotsWithoutOverlapping [

	| model farms |
	model := (self simulationOf: #initWithoutAgreement steps: 30)
		         cormasModel.
	farms := model allEntitiesOfClass: AHFarm.

	self assert: model farmsArea > 0.
	self
		assert: (farms sum: [ :each | each numberOfPlots ])
		equals: model farmsArea
]

{ #category : 'tests' }
AHModelTest >> testHerdsOfTheHerdersAddUpToTheCattle [

	| model herds |
	model := (self simulationOf: #initWithAgreement steps: 30)
		         cormasModel.
	herds := (model allEntitiesOfClass: AHHerder) sum: [ :each |
		         each herdSize ].

	self assert: model cattleSize > 0.
	self assert: herds rounded equals: model cattleSize
]
