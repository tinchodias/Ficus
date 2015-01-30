Extension { #name : #RBParseTreeLintRule }

{ #category : #'*FicusRing' }
RBParseTreeLintRule >> resetResultOnEnvironment: rbEnvironment [

	super resetResultOnEnvironment: rbEnvironment.
	self result matcher: self matcher
]
