Class {
  #name : #BaselineOfAgriHerders,
  #superclass : #BaselineOf,
  #category : 'BaselineOfAgriHerders'
}

{ #category : #baseline }
BaselineOfAgriHerders >> baseline: spec [
  <baseline>
  spec
    for: #common
    do: [
      spec package: 'AgriHerders-Model'.
      spec group: 'default' with: #('AgriHerders-Model').
    ]
]
