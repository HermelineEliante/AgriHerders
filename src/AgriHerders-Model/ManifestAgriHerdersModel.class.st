"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestAgriHerdersModel',
	#superclass : 'PackageManifest',
	#category : 'AgriHerders-Model-Manifest',
	#package : 'AgriHerders-Model',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestAgriHerdersModel class >> ruleNotEliminationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AHHerder #dry_MoveOneCattleBatch: #false)) #'2026-10-20T19:17:59.506113+02:00') )
]

{ #category : 'code-critics' }
ManifestAgriHerdersModel class >> ruleReGuardClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AHHerder #dry_MoveOneCattleBatch: #false)) #'2026-10-20T19:00:49.215515+02:00') #(#(#RGClassDefinition #(#AHHerder)) #'2026-10-20T19:01:00.299236+02:00') )
]
