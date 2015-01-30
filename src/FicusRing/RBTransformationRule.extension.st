Extension { #name : #RBTransformationRule }

{ #category : #'*FicusRing' }
RBTransformationRule >> resultOnEnvironment: rbEnvironment [
	| environment |
	environment := RBParseTreeEnvironment new.
	environment matcher: self rewriteRule.
	environment label: self name.

	self changes do: [ :change |
		(change isKindOf: RBAddMethodChange) ifTrue: [ 
			environment 
				addClass: (rbEnvironment systemDictionary classNamed: change changeClassName) 
				selector: change selector ] ].

	^ environment
]
