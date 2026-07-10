Class {
  #name : #BaselineOfAgriHerders,
  #superclass : #BaselineOf,
  #category : 'AgriHerders-Baselines'
}

{ #category : #baseline }
BaselineOfAgriHerders >> baseline: spec [
  <baseline>
  spec
    for: #common
    do: [
      "Définir le package principal du projet"
      spec
        package: 'AgriHerders-Model'
        with: [ spec requires: #() ].

      "Optionnel : Définir des groupes pour faciliter le chargement"
      spec
        group: 'default' with: #('AgriHerders-Model');
        group: 'Core' with: #('AgriHerders-Model').
    ]
]
