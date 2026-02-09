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
ManifestAgriHerdersModel class >> ruleEndTrueFalseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AHHerder #moveHerd #false)) #'2026-02-09T17:02:16.376+01:00') )
]
