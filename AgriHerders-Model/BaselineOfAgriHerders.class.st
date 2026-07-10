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
      "Définir le package principal du projet"
      spec
        package: 'AgriHerders-Model'
        with: [
          spec
            repository: 'github://HermelineEliante/AgriHerders/AgriHerders-Model';
            requires: #()
        ].

      "Définir des groupes pour faciliter le chargement"
      spec
        group: 'default' with: #('AgriHerders-Model');
        group: 'Core' with: #('AgriHerders-Model').
    ]
]
