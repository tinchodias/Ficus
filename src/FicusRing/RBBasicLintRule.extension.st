Extension { #name : #RBBasicLintRule }

{ #category : #'*FicusRing' }
RBBasicLintRule >> resetResultOnEnvironment: rbEnvironment [

	result := self resultClass onEnvironment: rbEnvironment.
	result label: self name.
]
