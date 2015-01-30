Extension { #name : #RBTransformationRule }

{ #category : #'*FicusRing' }
RBTransformationRule >> resetResultOnEnvironment: rbEnvironment [

	self flag: #todo. "do something with the env."
	builder := RBCompositeRefactoryChange named: self name
]

{ #category : #'*FicusRing' }
RBTransformationRule >> resultOnEnvironment: rbEnvironment [
	| environment |
	environment := RBParseTreeEnvironment onEnvironment: rbEnvironment.
	environment matcher: self rewriteRule.
	environment label: self name.

	self changes do: [ :change |
		(change isKindOf: RBAddMethodChange) ifTrue: [ 
			environment 
				addClass: (rbEnvironment systemDictionary classNamed: change changeClassName) 
				selector: change selector ] ].

	^ environment
]
